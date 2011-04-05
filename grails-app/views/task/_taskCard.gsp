<li class="ui-state-default clickable" id="${task.id}">			
	<div class="notecard shadow" data-effort="${task.effort}">
    <div>${task.title}
    <g:displayStatusImage status="${task.status.sequence}" alt="${task.status}" />
    </div>
      <hr/>
      <div>${task.description}</div>
  </div>
</li>
