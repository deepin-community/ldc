/*
PERMUTE_ARGS:
REQUIRED_ARGS: -o- -Xf=- -Xi=compilerInfo -Xi=modules
TRANSFORM_OUTPUT: sanitize_json
TEST_OUTPUT:
----
{
    "compilerInfo": {
        "__VERSION__": 0,
        "architectures": [
            "VALUES_REMOVED_FOR_TEST"
        ],
        "interface": "dmd",
        "platforms": [
            "VALUES_REMOVED_FOR_TEST"
        ],
        "predefinedVersions": [
            "VALUES_REMOVED_FOR_TEST"
        ],
        "size_t": 0,
        "supportedFeatures": {
            "includeImports": true
        },
        "vendor": "VALUE_REMOVED_FOR_TEST",
        "version": "VALUE_REMOVED_FOR_TEST"
    },
    "modules": [
        {
            "file": "VALUE_REMOVED_FOR_TEST",
            "kind": "module",
            "members": []
        }
    ]
}
----
*/
