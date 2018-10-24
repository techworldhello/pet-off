imageShow = document.querySelectorAll('.animal-show');

imageShow.forEach(image => {
	image.addEventListener('click', favoured);
})

function favoured() {
	console.log('hi')
}

