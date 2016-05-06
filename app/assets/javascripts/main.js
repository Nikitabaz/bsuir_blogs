var categoryList=$('.category-list');
var arrayOfAddButtons=$('.category-list').find('.addButton');
var arrayOfDeleteButtons=$('.category-list').find('.deleteButton');
var arrayOfLabs=$('.category-list').find('span');
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

var openedTab=0;
$('.vote-field').hide();//скрываем табу с опросом

function changeTab(elem)//переключение табов (таба с опросом и таба с микропостом)
{
  var index =$(elem).parents('.element-box').find('a').index(elem);
	if(openedTab!=index && index==1)
	{
		$(elem).parents('.element-box').find('.new_micropost').hide();
		$('.vote-field').show();
		openedTab=1;
	}
	if(openedTab!=index && index==0)
	{
		$(elem).parents('.element-box').find('.new_micropost').show();
		$('.vote-field').hide();
		openedTab=0;
	}
}

function addVoteOption()//добавляем элемент для голосования
{
	if($('.vote-field').find('.vote-option').length<8)
	{
		$('.vote-field').find('#acceptVote').remove();
		$('.vote-field').append('<input type="text" class="vote-option"></input>');
		$('.vote-field').append('<input type="submit" id="acceptVote" value="Опубликовать" class="btn btn-large btn-primary btn_micpost"></input>');
  }
}

function removeVoteOption()//удаляем элемент для голосования
{
	if($('.vote-field').find('.vote-option').length>1)
	$('.vote-field').find('.vote-option').last().remove();
}
