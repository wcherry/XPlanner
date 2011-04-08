<li class="ui-state-default clickable" id="${task.id}">			
	<div class="notecard shadow" data-effort="${task.effort}">
    <span>${task.title}</span><div class="clickable delete_card">x</div>
    <g:displayStatusImage status="${task.status.sequence}" alt="${task.status}" />
    <div>${task.description}</div>
  </div>
</li>
