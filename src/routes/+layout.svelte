<slot />

<style>
	:global(body),
	:global(textarea),
	:global(input),
	:global(select) {
		background: #2e2e2e; /* Replace with your desired color */
		color: white;
	}

	:global(button) {
		background: goldenrod;
		color: black;
		height: 40px;
		min-width: 50px;
	}
	:global(button:disabled) {
		background: #4a4a4a; /* Fondo gris oscuro */
		color: #a0a0a0; /* Texto gris claro */
		border: 1px solid #5a5a5a; /* Borde gris ligeramente más claro */
		opacity: 0.6; /* Opacidad para indicar que está deshabilitado */
		cursor: not-allowed; /* Cambia el cursor para indicar que no es interactivo */
	}
</style>
