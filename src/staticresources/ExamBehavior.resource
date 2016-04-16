var timeLim;
var myTime;//=setInterval(function(){myTimer()},1000);
var hour;
var min;
var sec = 0;
var timeTaken = 0;
var secTaken = 0;
var minTaken = 0;
var hourTaken = 0;

/**
 * @description handles the countdown timer for the exam
 * @author Created By Noy De Goma
 * @date Created On July 31, 2013
 */
function myTimer()
{
	var timeRemaining;
	sec--;
	if (sec < 0){
		sec = 59;
		min--;
		if (min < 0){
			min = 59;
			hour--;
		}
	}
	
	secTaken++;
	if (secTaken >= 60){
		secTaken = 0;
		minTaken++;
		if (minTaken >= 60){
			minTaken = 0;
			hourTaken++;
		}
	}
	if (hour < 10){
		if (min < 10){
			if (sec < 10){
				timeRemaining = "0" + hour + ":" + "0" + min + ":" + "0" + sec;
			}else{
				timeRemaining = "0" + hour + ":" + "0" + min + ":" + sec;
			}
		}else{
			if (sec < 10){
				timeRemaining = "0" + hour + ":" + min + ":" + "0" + sec;
			}else{
				timeRemaining = "0" + hour + ":" + min + ":" + sec;
			}
		}
	}else{
		if (min < 10){
			if (sec < 10){
				timeRemaining = hour + ":" + "0" + min + ":" + "0" + sec;
			}else{
				timeRemaining = hour + ":" + "0" + min + ":" + sec;
			}
		}else{
			if (sec < 10){
				timeRemaining = hour + ":" + min + ":" + "0" + sec;
			}else{
				timeRemaining = hour + ":" + min + ":" + sec;
			}
		}
	}
	
	
	//sets the value of the timer
	$("#timer")[0].innerHTML='Time Remaining: '+timeRemaining.toString();
	if (min < 5 && hour <= 0){
		$("#timer")[0].style.color = 'red';
	}
	//check if the value of the timer is equal to 0
	if (hour <= 0 && min <= 0 && sec <= 0){
		getTimeTaken();
		clearInterval(myTime);
		$("#timer")[0].innerHTML=null;
		
		
	}
}
function getTimeTaken(){
	if (secTaken < 10){
		secTaken = "0" + secTaken;
	}
	if(minTaken < 10){
		minTaken = "0" + minTaken;
	}
	if(hourTaken < 10){
		hourTaken = "0" + hourTaken;
	}
	timeTaken = hourTaken + ":" + minTaken + ":" + secTaken;
	if (hour <= 0 && min <= 0 && sec <= 0){
		onTimeRunOut('Time: ' + timeTaken);
	}else{
		getTime('Time: ' + timeTaken);
	}
}
function Submit(){
	clearInterval(myTime);
	$("#timer")[0].innerHTML=null;
	getTimeTaken();
}
$(document).ready(function(){
	$("#timer")[0].style.fontWeight = 'bolder';
	if (timeLimit >= 60){
		hour = Math.floor(timeLimit/60);
		min = timeLimit%60;
	}else{
		hour = 0;
		min = timeLimit;
	}
	timeStart(true);
	myTime=setInterval(function(){myTimer()},1000);
});

function ShowLoading(){
    $('.black_overlay').show();
    $('.white_content').show();
}
function CloseLoading(){
    $('.black_overlay').hide();
    $('.white_content').hide();
}



