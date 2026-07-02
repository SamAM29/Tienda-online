//boton de cargar más

let loadMoreBtn = document.querySelector("#load-more");
let currentItem = 8;

loadMoreBtn.onclick = () => {
    let boxes =[...document.querySelectorAll(".box-container .box")];
    for(var i = currentItem; i < currentItem + 4 ; i++) {
        boxes[i].style.display = 'inline-block';
    }
    currentItem += 4;
    if(currentItem >= boxes.length)  {
        loadMoreBtn.style.display = 'none'
    }

}

//Carrito
const carrito = document.getElementById('carrito');
const elementos1 = document.getElementById('lista-1');
const lista = document.querySelector('#lista-carrito tbody');
const vaciarCarritoBtn = document.getElementById('vaciar-carrito');

cargarEventListeners();

function cargarEventListeners() {
    elementos1.addEventListener('click', comprarElemento);
    carrito.addEventListener('click', eliminarElemento);
    vaciarCarritoBtn.addEventListener('click', vaciarCarrito);
}

function comprarElemento(e) {
    e.preventDefault(); 
    if(e.target.classList.contains('agregar-carrito')) {
        const elemento = e.target.parentElement.parentElement;
        leerDatosElemento(elemento);
    }
}

function leerDatosElemento(elemento) {
    const infoElemento = {
        imagen: elemento.querySelector('img').src,
        titulo: elemento.querySelector('h3').textContent,
        precio: elemento.querySelector('.Precio').textContent,
        id: elemento.querySelector('a').getAttribute('data-id')
    }
    insertarCarrito(infoElemento);
}

function insertarCarrito(elemento) {
    const row = document.createElement('tr');
    row.innerHTML = `
    <td>
        <img src="${elemento.imagen}" width=100 height=150px >
    </td>
    <td>
        ${elemento.titulo}
    </td>
    <td>
        ${elemento.precio}
    </td>
    <td>
        <a herf="#" class="borrar" data-id="${elemento.id}" >X</a>
    </td>
    `;
    lista.appendChild(row);
    calcularTotal();
}

function eliminarElemento(e) {
    e.preventDefault();
    let elemento,
        elementoId;

    if(e.target.classList.contains('borrar')) {
        e.target.parentElement.parentElement.remove();
        elemento = e.target.parentElement.parentElement;
        elementoId = elemento.querySelector('a').getAttribute('data-id');
    }
    calcularTotal();
}

function vaciarCarrito() {
    while(lista.firstChild) {
        lista.removeChild(lista.firstChild);
    }
    calcularTotal();
    return false;
}

// Nueva función para calcular los totales de la compra
function calcularTotal() {
    const filas = document.querySelectorAll('#lista-carrito tbody tr');
    let subtotal = 0;

    filas.forEach(fila => {
        const precioTexto = fila.children[2].textContent;
        
        const precioNumero = parseInt(precioTexto.replace('$', '').replaceAll('.', '').trim());
        
        subtotal += precioNumero;
    });

    const costoEnvio = subtotal > 0 ? 18500 : 0;
    const totalFinal = subtotal + costoEnvio;

    document.getElementById('subtotal-val').textContent = `$${subtotal.toLocaleString('es-CO')}`;
    document.getElementById('envio-val').textContent = `$${costoEnvio.toLocaleString('es-CO')}`;
    document.getElementById('total-val').textContent = `$${totalFinal.toLocaleString('es-CO')}`;
}