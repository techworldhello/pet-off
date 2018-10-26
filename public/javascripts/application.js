// Core feature 
const imageShow = document.querySelectorAll('.animal-show');

imageShow.forEach(image => {
	image.addEventListener('click', event => {
		event.target.parentElement.submit();
	})
})

// Logo to lead users to core feature
const logo = document.querySelector('.logo');

logo.addEventListener('click', event => {
	event.target.parentElement.submit();
})

// Edit button in accounts page
const imageEdits = document.querySelectorAll('.image-edit');

imageEdits.forEach(image => {
	image.addEventListener('click', event => {
		event.target.parentElement.submit();
	})
})


function perHour() {
    setInterval(() => {
		let date = new Date();
		let hour = date.getHours();
		let min = date.getMinutes();
		let sec = date.getSeconds();
		document.querySelector('.timer').innerHTML = `${hour}:${min}:${sec}`;
	}, 1000 * 60 * 60);
}






