HashTodo
============

very simple todo

## Install
```
$ gem install clier
$ gem install fssm
```

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
or Auto Export:
```
$ ./hashtodo.rb autoexport -d <todo> -e <template> -t <target>
```
also you can use **YAML** file:
```
data: <todo>
erb: <template>
target: <target>
```
and
```
$ ./hashtodo.rb autoexport -c <yaml>
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