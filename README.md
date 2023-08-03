# jimmyscript

Simple language created by Will (Nephew) and Jimmy (uncle) as a fun and educational exercise! Below is a simple assign statement

### Example input

```
double myDouble = 3.14159265358;
```

### Tokens

```json
[
     {
          "precedence": 3,
          "body": "double",
          "type": "type"
     },
     {
          "precedence": 0,
          "body": "myDouble",
          "type": "variable"
     },
     {
          "precedence": 0,
          "body": "=",
          "type": "operator"
     },
     {
          "precedence": 0,
          "body": "3.14159265358",
          "type": "double"
     }
]

```

### AST

```json
{
     "token": {
          "precedence": 0,
          "body": "=",
          "type": "operator"
     },
     "children": [
          {
               "token": {
                    "precedence": 3,
                    "body": "double",
                    "type": "type"
               },
               "children": [
                    {
                         "token": {
                              "precedence": 0,
                              "body": "myDouble",
                              "type": "variable"
                         },
                         "children": []
                    }
               ]
          },
          {
               "token": {
                    "precedence": 0,
                    "body": "3.14159265358",
                    "type": "double"
               },
               "children": []
          }
     ]
}
```
