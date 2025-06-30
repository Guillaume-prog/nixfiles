{ buildFirefoxXpiAddon, lib }:
{
  igplus-extension = buildFirefoxXpiAddon rec {
    pname = "igplus-extension";
    version = "3.0.5.1";
    addonId = "{8e41107d-2be2-454d-b4b8-c3d7e54d77de}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4475061/${pname}-${version}.xpi";
    sha256 = "sha256-V6fIrAux7CU2wtXsOKrs5SkBpDZD39CXdTfECuy1UuQ=";
    meta = with lib;
      {
        homepage = "https://github.com/gerwld/igplus-extension";
        description = "IGPlus is an open-source extension designed to help you reduce distractions from Instagram";
        license = licenses.cc-by-nc-nd-40;
        platforms = platforms.all;
      };
  };
}