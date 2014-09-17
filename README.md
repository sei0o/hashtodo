HashTodo
============

very simple todo

## Install
```
$ gem install clier
```
That is all.

## How to Use
### Todo file
example:
```
 text #hashtag
 #hashtag text
```

### Export
```
$ ./hashtodo.rb export -d <todo> -e <template> -t <target>
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