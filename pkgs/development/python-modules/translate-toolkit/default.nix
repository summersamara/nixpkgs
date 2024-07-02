{ stdenv
, lib
, fetchPypi
, buildPythonPackage
, setuptools-scm
, lxml
, wcwidth
, pytest
, iniparse
, vobject
, mistletoe
, phply
, pyparsing
, ruamel-yaml
, cheroot
, fluent-syntax
, aeidon
, charset-normalizer
, syrupy
, gettext
}:

buildPythonPackage rec {
  pname = "translate-toolkit";
  version = "3.13.1";

  pyproject = true;
  build-system = [ setuptools-scm ];

  src = fetchPypi {
    inherit version;
    pname = builtins.replaceStrings [ "-" ] [ "_" ] pname;
    sha256 = "sha256-Tx5WZo3AH7CWfYxv7hGYSGk1P4SQNsSxoTDbZOryZzA=";
  };

  dependencies = [
    lxml
    wcwidth
  ];

  nativeCheckInputs = [
    pytest
    iniparse
    vobject
    mistletoe
    phply
    pyparsing
    ruamel-yaml
    cheroot
    fluent-syntax
    aeidon
    charset-normalizer
    syrupy
    gettext
  ];

  # test_timezones: Probably breaks because of nix sandbox
  # test_xlff_conformance: Requires network
  checkPhase = ''
    runHook preCheck
    py.test -k "not test_timezones and not test_xliff_conformance" tests
    runHook postCheck
  '';

  pythonImportsCheck = [ "translate" ];

  meta = with lib; {
    description = "Useful localization tools for building localization & translation systems";
    homepage = https://toolkit.translatehouse.org/;
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ phile314 jtojnar ];
  };
}
