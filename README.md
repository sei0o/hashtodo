HashTodo
============

very simple todo

## How to Use
### Todo file
example:
```
text #hashtag
\#hashtag text
```

### Export
```
$ ./hashtodo.rb export <todo> <template> <target>
```

### Template
template is a __erb__ file.
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