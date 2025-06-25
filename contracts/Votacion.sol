// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Votacion {
    struct Postulante {
        uint id;
        string nombre;
        uint votos;
    }

    // Guarda los postulantes por categoría e ID
    mapping(string => mapping(uint => Postulante)) public encuesta;
    // Guarda cuántos postulantes hay por categoría
    mapping(string => uint) public conteoPostulantes;
    // Guarda qué wallets están autorizadas para votar
    mapping(address => bool) public esVotanteAutorizado;
    // Guarda si ya votó por categoría
    mapping(address => mapping(string => bool)) public yaVoto;

    mapping(string => mapping(string => bool)) public nombreRegistrado;


    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Solo el admin puede hacer esto");
        _;
    }

    function registrarPostulante(string memory categoria, string memory nombre) public onlyAdmin {
        require(!nombreRegistrado[categoria][nombre], "Ese nombre ya existe en la categoria");

        uint nuevoId = conteoPostulantes[categoria] + 1;
        encuesta[categoria][nuevoId] = Postulante(nuevoId, nombre, 0);
        conteoPostulantes[categoria] = nuevoId;
        nombreRegistrado[categoria][nombre] = true;
    }


    function autorizarVotante(address wallet) public onlyAdmin {
        esVotanteAutorizado[wallet] = true;
    }

    function votarComo(address votante, string memory categoria, uint idPostulante) public onlyAdmin {
        require(esVotanteAutorizado[votante], "No estas autorizado para votar");
        require(!yaVoto[votante][categoria], "Ya votaste en esta categoria");
        require(idPostulante > 0 && idPostulante <= conteoPostulantes[categoria], "ID invalido");

        encuesta[categoria][idPostulante].votos++;
        yaVoto[votante][categoria] = true;
    }


    function obtenerVotos(string memory categoria, uint idPostulante) public view returns (uint) {
        return encuesta[categoria][idPostulante].votos;
    }

    // Opcional: ver si alguien está autorizado o si ya votó en una categoría
    function puedeVotar(address wallet, string memory categoria) public view returns (bool) {
        return esVotanteAutorizado[wallet] && !yaVoto[wallet][categoria];
    }
}
