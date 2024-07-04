module {
  public type propiedad = {
    codigo_inmobiliario : Nat;
    ubicacion : Text;
    valor : Nat;
    descripcion: Text;
    var tokens: Nat
  };

  public type token = {
    codigo : Nat;
    nombre: Text;
  };


  public type wallet = {
  propietario: Text;
  var saldo: Nat;
  var tokens: [token];
};



};