import types = "types";
import Array = "mo:base/Array";
import Result "mo:base/Result";
import Iter "mo:base/Iter";
import Time = "mo:base/Time";
import Principal = "mo:base/Principal";
actor {

  var propiedades : [types.propiedad] = [];
  var myTokens : [types.token] = [];
  var users : [types.user] = [];
  var codigos : Nat = 0;



  public func m1_newUser(userId : Principal) : async Result.Result<Text, Text> {
    for (user in users.vals()) {
      if (user.id == userId) {
        return #err("ya existe este usuario");
      };
    };

    let newUser : types.user = {
      var id = userId;
      var wallet = {
        propietario = Principal.toText(userId);
        var saldo = 100;
        var tokens = myTokens;
      };
    };

    users := Array.append(users, [newUser]);

    return #ok("usuario registrado");
  };

  public func m2_tokenizarPropiedad(codigo : Nat, ubicacion : Text, valor : Nat, descripcion : Text, cant_tokens : Nat) : async Result.Result<Text, Text> {
    for (propiedad in propiedades.vals()) {
      if (codigo == propiedad.codigo_inmobiliario) {
        return #err("ya existe una propiedad con este codigo");
      };
    };
    let newPropiedad : types.propiedad = {
      codigo_inmobiliario = codigo;
      ubicacion = ubicacion;
      valor = valor;
      descripcion = descripcion;
      var tokens = cant_tokens;
    };

    propiedades := Array.append(propiedades, [newPropiedad]);
    return #ok("Propiedad tokenizada correctamente");
  };

  public query func m3_verPropiedades() : async Text {
    var propiedadesTexto : Text = "";
    for (propiedad in propiedades.vals()) {
      propiedadesTexto #= "Código Inmobiliario: " # debug_show (propiedad.codigo_inmobiliario) # "\n" #
      "Ubicación: " # propiedad.ubicacion # "\n" #
      "Valor: " # debug_show (propiedad.valor) # "\n" #
      "Descripción: " # propiedad.descripcion # "\n" #
      "Tokens: " # debug_show (propiedad.tokens) # "\n\n";
    };
    return propiedadesTexto;
  };

  public func m4_comprarToken(codigo : Nat, cantidad : Nat, userId : Principal) : async Result.Result<Text, Text> {
    var usuarioEncontrado = false;
    var propiedadEncontrada = false;

    for (user in users.vals()) {
      if (user.id == userId) {
        usuarioEncontrado := true;
        for (propiedad in propiedades.vals()) {
          if (codigo == propiedad.codigo_inmobiliario) {
            propiedadEncontrada := true;

            if (cantidad > propiedad.tokens) {
              return #err("No hay suficientes tokens");
            };
            if (cantidad > user.wallet.saldo) {
              return #err("No tienes saldo suficiente");
            };

            propiedad.tokens := propiedad.tokens - cantidad;
            var count = 0;
            for (i in Iter.range(1, cantidad)) {
              let newToken : types.token = {
                codigo = codigos;
                nombre = "token propiedad " # debug_show(propiedad.codigo_inmobiliario);
              };
              count := count + 1;
              user.wallet.saldo := user.wallet.saldo - 1;
              codigos := codigos + 1;
              user.wallet.tokens := Array.append(user.wallet.tokens, [newToken]);
            };
            
            return #ok("Compra realizada correctamente");
          };
        };
        if ( not propiedadEncontrada) {
          return #err("No existe inmueble con el código proporcionado");
        };
      };
    };
    if (not usuarioEncontrado) {
      return #err("Usuario no registrado");
    };
    return #ok("Compra realizada correctamente");
  };

  public query func m5_verMiWallet(userId : Principal) : async Text {
    var mensaje : Text = "";
    for (user in users.vals()) {
      if (user.id == userId) {
        mensaje #= "propietario: " # user.wallet.propietario # "\n" #
        "saldo: " # debug_show (user.wallet.saldo) # "\n";
        for (token in user.wallet.tokens.vals()) {
          mensaje #= "mis tokens: " # "\n" #
          "Código: " # debug_show (token.codigo) # "\n" #
          "nombre: " # token.nombre # "\n\n";
        };
      } else {
        return "no existe el usuario";
      };
    };
    return mensaje;
  };

   public func m6_venderMisTokens(codigoToken: Nat, userId: Principal): async Result.Result<Text, Text> {
    var usuarioEncontrado: ?types.user = null;

    // Buscar el usuario
    for (user in users.vals()) {
      if (user.id == userId) {
        usuarioEncontrado := ?user;
      }
    };

    // Si el usuario no se encuentra, devolver un error
    switch (usuarioEncontrado) {
      case (null) return #err("usuario no encontrado");
      case (?user) {
        var tokenEncontrado: Bool = false;

        // Buscar el token en la wallet del usuario
        for (token in user.wallet.tokens.vals()) {
          if (token.codigo == codigoToken) {
            tokenEncontrado := true;
          }
        };

        // Si el token no se encuentra, devolver un error
        if  (not tokenEncontrado) {
          return #err("no existe token con el codigo proporcionado");
        };

        // Filtrar los tokens para eliminar el token con el código especificado
        let tokensActualizados = Array.filter<types.token>(
          user.wallet.tokens,
          func(t: types.token): Bool {
            t.codigo != codigoToken
          },
        );

        // Actualizar la wallet del usuario
        user.wallet.tokens := tokensActualizados;
        user.wallet.saldo += 1;

        return #ok("venta realizada correctamente");
      }
    }
  };

};