<li class="ui-state-default clickable" id="${story.id}">			
	<div class="notecard shadow" data-effort="${story.effort}">
    <span>${story.title}</span><div class="clickable delete_card">x</div>
    <g:displayStatusImage status="${story.status.sequence}" alt="${story.status}" />
    <div>${story.description}</div>
  </div>
</li>
