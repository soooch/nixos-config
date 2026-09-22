# Recall's AWS SSO profiles for the AWS CLI. The account table lives in the
# private nixos-config-private input (recall/aws.nix there); this only turns
# it into ~/.aws/config. Log in with `aws sso login`. ~/.aws/credentials stays
# empty.
{ inputs, lib, ... }:
let
  recall = import "${inputs.nixos-config-private}/recall/aws.nix";

  mkProfile =
    { account, role }:
    {
      inherit (recall) region;
      sso_session = recall.session;
      sso_account_id = account;
      sso_role_name = role;
    };
in
{
  programs.awscli = {
    enable = true;

    settings = {
      "sso-session ${recall.session}" = {
        sso_start_url = recall.startUrl;
        sso_region = recall.region;
        sso_registration_scopes = "sso:account:access";
      };

      default = mkProfile recall.profiles.${recall.default};
    }
    // lib.mapAttrs' (name: p: lib.nameValuePair "profile ${name}" (mkProfile p)) recall.profiles;
  };
}
