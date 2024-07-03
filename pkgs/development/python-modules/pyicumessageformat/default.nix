{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pyicumessageformat";
  version = "1.0.0";
  pyproject = true;
  build-system = [ setuptools ];

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-s+l8DtEMKxA/DzpwGqZSlwDqCrZuDzsj3I5K7hgfyEA=";
  };

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ pname ];

  meta = with lib; {
    description = "An unopinionated Python3 parser for ICU MessageFormat";
    homepage = "https://github.com/SirStendec/pyicumessageformat/";
    license = licenses.mit;
    maintainers = with maintainers; [ erictapen ];
  };

}
