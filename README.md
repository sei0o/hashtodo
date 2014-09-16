HashTodo
============

very simple todo

## How to Use
### Todo file
example:
```
text #hashtag
```

### Export
```
$ ./hashtodo.rb export <todo> <template> <target>
```
<template> is a erb file.

### Template
```
<ul>
	<% tasks.each do |task| %>
		<li>
			<% task.hashtags.each do |tag| %>
				<span class="hashtag">#<%= tag %></span>
			<% end %>
			<%= task.text %>
		</li>
	<% end %>
</ul>
```