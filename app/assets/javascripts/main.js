var categoryList=document.getElementsByClassName('category-list');
var arrayOfAddButtons=categoryList[0].getElementsByClassName('addButton');
var arrayOfDeleteButtons=categoryList[0].getElementsByClassName('deleteButton');
var arrayOfLabs=categoryList[0].getElementsByTagName('span');
var i=0;
for(; i<arrayOfAddButtons.length; i++)
{	
	(function(i)
		{
		arrayOfAddButtons[i].onclick=function(){addSquare(arrayOfLabs[i])};
		arrayOfDeleteButtons[i].onclick=function(){deleteSquare(arrayOfLabs[i])};
		})(i);
}

function addSquare (added) {
		
       var div = document.createElement('div');
       div.className='square-active';
	   
	   var space = document.createElement('div');
       space.className='space';

       added.appendChild(div);
	   added.appendChild(space);
};

function deleteSquare(deleted)
{
	
		if(deleted.childNodes.length>1)
		{
		deleted.removeChild(deleted.lastChild);
		deleted.removeChild(deleted.lastChild);
		}
}
