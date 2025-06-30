# Guide : Comment créer un test

### Cette documentation a pour but d’expliquer comment créer un test pour la plateforme Maester :
- soit à partir des tests standards (issus de la bibliothèque officielle GitHub),
- soit sous forme de tests personnalisés (custom tests) organisés autour de trois fichiers.

## Test Standart (officiel)
Les tests standard sont directement issus du dépôt officiel. Ils utilisent des commandes internes comme ```Test-MtEidscaControl```.

Pour les trouvers d'abord regarder la doc pour savoir a quoi il sert : https://maester.dev/docs/intro
Puis aller sur le github officiel de maester : https://github.com/maester365/maester/tree/main/tests
Chercher le test que vous voules puis copier coller le dans le repertoire test de votre repo

## Custom Test
Ces tests sont créés manuellement pour des besoins spécifiques. Ils sont organisés autour de trois fichiers.
```
NomDuTest/
├── check.ps1      # Contient la logique d’évaluation du test
├── test.ps1       # Contient le bloc Describe/It PowerShell
└── readme.md      # Fichier de documentation associé au test
```
#### Fichier check.ps1
Contient la logique métier du test. Exemples :
```
function Invoke-CustomCheck {
    $policy = Invoke-MtGraphRequest -RelativeUri 'policies/authorizationpolicy' -ApiVersion beta
    return $policy.defaultUserRolePermissions.allowedToCreateSecurityGroups
}
```

#### Fichier test.ps1
Contient la définition du test Maester :
```
Describe "Custom.Test" -Tag "Custom", "Security" {
    It "Custom.Test.01: Security Group creation should be disabled for users" {
        . ./check.ps1
        Invoke-CustomCheck | Should -Be $false
    }
}
```

#### Fichier readme.md
Documente le test (objectif, sources, liens externes) :
```
# Custom.Test.01

## Objectif
Vérifie que les utilisateurs standards ne peuvent pas créer de groupes de sécurité.

## Référence
- https://learn.microsoft.com/en-us/graph/api/resources/authorizationpolicy
```
