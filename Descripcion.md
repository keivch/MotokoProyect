Este proyecto es un sistema de tokenización de propiedades inmobiliarias que permite a los usuarios registrarse, tokenizar propiedades, comprar y vender tokens, y ver sus propiedades y su billetera. A continuación se detalla cómo funciona cada parte del proyecto:

Estructuras de datos principales:

propiedades: lista que almacena las propiedades inmobiliarias tokenizadas.
myTokens: lista que almacena los tokens en posesión de los usuarios.
users: lista que almacena la información de los usuarios registrados.
codigos: contador para asignar códigos únicos a los tokens.
Función m1_newUser:

Registra un nuevo usuario en el sistema.
Comprueba si el usuario ya existe y, si no, lo añade a la lista users.
Función m2_tokenizarPropiedad:

Tokeniza una nueva propiedad inmobiliaria.
Comprueba si la propiedad ya existe mediante su código inmobiliario y, si no, la añade a la lista propiedades.
Función m3_verPropiedades:

Devuelve un texto con la información de todas las propiedades inmobiliarias tokenizadas, incluyendo su código, ubicación, valor, descripción y cantidad de tokens.
Función m4_comprarToken:

Permite a un usuario comprar tokens de una propiedad.
Comprueba si el usuario está registrado y si la propiedad existe.
Verifica que hay suficientes tokens disponibles y que el usuario tiene saldo suficiente.
Si todo es correcto, deduce los tokens de la propiedad, los añade a la billetera del usuario y ajusta su saldo.
Función m5_verMiWallet:

Devuelve un texto con la información de la billetera de un usuario específico, incluyendo el propietario, el saldo y los tokens que posee.
Función m6_venderMisTokens:

Permite a un usuario vender sus tokens.
Comprueba si el usuario está registrado y si posee el token especificado.
Si el token existe en la billetera del usuario, lo elimina y ajusta el saldo del usuario.
Este sistema facilita la gestión de propiedades inmobiliarias y su fraccionamiento en tokens, permitiendo transacciones seguras y transparentes entre los usuarios.Este proyecto es un sistema de tokenización de propiedades inmobiliarias que permite a los usuarios registrarse, tokenizar propiedades, comprar y vender tokens, y ver sus propiedades y su billetera. A continuación se detalla cómo funciona cada parte del proyecto:

Estructuras de datos principales:

propiedades: lista que almacena las propiedades inmobiliarias tokenizadas.
myTokens: lista que almacena los tokens en posesión de los usuarios.
users: lista que almacena la información de los usuarios registrados.
codigos: contador para asignar códigos únicos a los tokens.
Función m1_newUser:

Registra un nuevo usuario en el sistema.
Comprueba si el usuario ya existe y, si no, lo añade a la lista users.
Función m2_tokenizarPropiedad:

Tokeniza una nueva propiedad inmobiliaria.
Comprueba si la propiedad ya existe mediante su código inmobiliario y, si no, la añade a la lista propiedades.
Función m3_verPropiedades:

Devuelve un texto con la información de todas las propiedades inmobiliarias tokenizadas, incluyendo su código, ubicación, valor, descripción y cantidad de tokens.
Función m4_comprarToken:

Permite a un usuario comprar tokens de una propiedad.
Comprueba si el usuario está registrado y si la propiedad existe.
Verifica que hay suficientes tokens disponibles y que el usuario tiene saldo suficiente.
Si todo es correcto, deduce los tokens de la propiedad, los añade a la billetera del usuario y ajusta su saldo.
Función m5_verMiWallet:

Devuelve un texto con la información de la billetera de un usuario específico, incluyendo el propietario, el saldo y los tokens que posee.
Función m6_venderMisTokens:

Permite a un usuario vender sus tokens.
Comprueba si el usuario está registrado y si posee el token especificado.
Si el token existe en la billetera del usuario, lo elimina y ajusta el saldo del usuario.
Este sistema facilita la gestión de propiedades inmobiliarias y su fraccionamiento en tokens, permitiendo transacciones seguras y transparentes entre los usuarios.