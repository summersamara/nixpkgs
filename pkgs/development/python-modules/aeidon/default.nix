{ lib
, buildPythonPackage
, fetchPypi
, gettext
, flake8
, isocodes
, pytest
, charset-normalizer
}:

buildPythonPackage rec {
  pname = "aeidon";
  version = "1.15";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-qGpGraRZFVaW1Jys24qvfPo5WDg7Q/fhvm44JH8ulVw=";
  };

  nativeBuildInputs = [ gettext flake8 ];

  dependencies = [ isocodes ];

  installPhase = ''
    runHook preInstall
    python setup.py --without-gaupol install --prefix=$out
    runHook postInstall
  '';

  nativeCheckInputs = [ pytest charset-normalizer ];

  checkPhase = ''
    # Aeidon is wrongly looking in the subdirectory for data
    cp -r data aeidon/
    # test_spell requires gspell to work with gobject introspection
    py.test -k "not test_spell" aeidon/test
  '';

  pythonImportsCheck = [ "aeidon" ];

  meta = with lib; {
    description = "Reading, writing and manipulationg text-based subtitle files";
    homepage = "https://github.com/otsaloma/gaupol";
    license = licenses.gpl3;
    maintainers = with maintainers; [ erictapen ];
  };

}
