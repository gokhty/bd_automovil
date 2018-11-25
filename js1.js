var v=true;
function ver(conten){
	var lista= document.querySelectorAll(conten);
		 if(v==true){
			  for(var f=0; f<lista.length; f++){ 
				lista[f].style.display="block"; 
  } 
			 v=false;
		 }
		 else{
			  for(var f=0; f<lista.length; f++){ 
				lista[f].style.display="none"; 
  } 
			 v=true;
		 } 
         }
		 
		 var v2=true;
function ver2(conten){
	
		 if(v2==true){
			 document.querySelector(conten).style.display="block";
			 v2=false;
		 }
		 else{
			 document.querySelector(conten).style.display="none";
			 v2=true;
		 } 
         }
		 
function ver3(conten,index){
	var lista= document.querySelectorAll(conten);
	   for(var f=0; f<lista.length; f++){ 
			lista[f].style.display="none"; 		
         }
		 lista[index].style.display="block";
}
function ver4(conten,index){
	var lista= document.querySelectorAll(conten);
	   for(var f=0; f<lista.length; f++){ 
			lista[f].style.display="none"; 		
         }
		 lista[index].style.display="block";
}