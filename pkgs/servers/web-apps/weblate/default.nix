{ lib
, python3
, fetchFromGitHub
, wrapGAppsNoGuiHook
, gobject-introspection
, pango
, harfbuzz
, borgbackup
, nixosTests
}:

python3.pkgs.buildPythonApplication rec {
  pname = "weblate";
  version = "5.6.2";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "WeblateOrg";
    repo = pname;
    rev = "weblate-${version}";
    sha256 = "sha256-t/hnigsKjdWCkUd8acNWhYVFmZ7oGn74+12347MkFgM=";
  };

  build-system = with python3.pkgs; [ setuptools ];

  nativeBuildInputs = [
    wrapGAppsNoGuiHook
    gobject-introspection
  ];

  buildInputs = [
    pango
    harfbuzz
  ];

  dependencies = with python3.pkgs; [
    aeidon
    # ahocorasick-rs
    borgbackup
    celery # [redis]
    certifi
    charset-normalizer
    # crispy-bootstrap3
    cryptography
    cssselect
    cython
    diff-match-patch
    django-appconf
    django-celery-beat
    django-compressor
    django-cors-headers
    django-crispy-forms
    django-filter
    django-redis
    django
    djangorestframework
    filelock
    fluent-syntax
    GitPython
    hiredis
    html2text
    iniparse
    jsonschema
    lxml
    misaka
    mistletoe
    nh3
    openpyxl
    packaging
    phply
    pillow
    pycairo
    pygments
    pygobject3
    # pyicumessageformat
    pyparsing
    python-dateutil
    (python-redis-lock.override { withDjango = true; })
    rapidfuzz
    redis
    requests
    ruamel-yaml
    sentry-sdk
    # siphashc
    social-auth-app-django
    social-auth-core
    tesserocr
    translate-toolkit
    # translation-finder
    user-agents
    # weblate-language-data
    # weblate-schemas
  ] ++ django.optional-dependencies.argon2;

  meta = with lib; {
    description = "Web based translation tool with tight version control integration";
    homepage = "https://weblate.org/";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ erictapen ];
  };

  passthru = {
    tests = { inherit (nixosTests) weblate; };
    optional-dependcencies = {
      postgres = with python3.pkgs; [ psycopg ];
    };
  };

}

