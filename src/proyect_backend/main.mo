import types = "types";
import Array = "mo:base/Array";
import Result "mo:base/Result";
import Iter "mo:base/Iter";
import Time = "mo:base/Time";
actor {
  
  var propiedades: [types.propiedad] = [];
  var myTokens: [types.token] = [];
  var codigos: Nat = 0;
  
  let myWallet : types.wallet = {
    propietario = "yo";
    var saldo = 100;
    var tokens = myTokens;
  };

  public func tokenizarPropiedad(codigo: Nat, ubicacion: Text, valor: Nat, descripcion: Text, cant_tokens: Nat): async Result.Result<Text, Text> {
    for(propiedad in propiedades.vals()){
      if (codigo == propiedad.codigo_inmobiliario){
        return #err("ya existe una propiedad con este codigo");
      }
    };
    let newPropiedad: types.propiedad = {
      codigo_inmobiliario = codigo;
      ubicacion = ubicacion;
      valor = valor;
      descripcion = descripcion;
      var tokens = cant_tokens;
    };
    
    propiedades := Array.append(propiedades, [newPropiedad]);
    return #ok("Propiedad tokenizada correctamente");
  };

  public query func verPropiedades(): async Text {
    var propiedadesTexto: Text = "";
    for (propiedad in propiedades.vals()) {
      propiedadesTexto #= 
        "Código Inmobiliario: " # debug_show(propiedad.codigo_inmobiliario) # "\n" #
        "Ubicación: " # propiedad.ubicacion # "\n" #
        "Valor: " # debug_show(propiedad.valor) # "\n" #
        "Descripción: " # propiedad.descripcion # "\n" #
        "Tokens: " # debug_show(propiedad.tokens) # "\n\n";
    };
    return propiedadesTexto;
  };

  

  public func comprarToken(codigo:Nat, cantidad:  Nat):async Result.Result<Text, Text>{
    for (propiedad in propiedades.vals()){
      if (cantidad > propiedad.tokens){
        return #err("No hay suficientes tokens")
      };
      if (cantidad > myWallet.saldo){
        return #err("no tienes saldo suficiente")
      };
      if (codigo == propiedad.codigo_inmobiliario){
        propiedad.tokens := propiedad.tokens - cantidad;
        var count = 0;
        for (i in Iter.range(1, cantidad)){
          let newToken : types.token={
            codigo = codigos;
            nombre = "token propiedad " #debug_show(propiedad.codigo_inmobiliario);
          };
          count := count + 1;
          myWallet.tokens := Array.append(myWallet.tokens, [newToken]);
          myWallet.saldo := myWallet.saldo - 1;
          codigos:= codigos +1;
        };
      } else {
        return #err("no existe inmueble con el codigo proporcionado");
      };
    };
    return #ok("compra realizada correctamente");
  };


  public query func verMiWallet(): async Text {
    var mensaje: Text = "";
    mensaje #= "propietario: " # myWallet.propietario # "\n" #
      "saldo: " # debug_show(myWallet.saldo) # "\n";
    for (token in myWallet.tokens.vals()){
      mensaje#= "mis tokens: " #"\n" #
      "Código: " # debug_show(token.codigo) # "\n" #
      "nombre: " # token.nombre # "\n\n";
    };
    return mensaje;
  };

  public func venderMisTokens(codigoToken: Nat): async Result.Result<Text, Text>{
    for (token in myWallet.tokens.vals()){
      if(codigoToken != token.codigo){
        return #err("no existe token con el  codigo proporcionado")
      }
    };
    let tokensActualizados = Array.filter<types.token>(myWallet.tokens, func(t: types.token): Bool {
    t.codigo != codigoToken
    });
    myWallet.tokens := tokensActualizados;
    myWallet.saldo := myWallet.saldo + 1;
    return #ok("venta realizada correctamente");
  }
  


};