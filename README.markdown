need\_help
=========

A simple help system using Rails Engine.

Installation
------------

Just install the plugin with `script/plugin install git://github.com/fnando/need_help.git`.

Usage
-----

1) Run the task `rake help:sync` to copy the required migrations. Run `db:migrate` to update the database schema.

2) Create the file `config/help/help.yml`. This file will hold all categories and topics. The syntax is quite simple:

	"Category 1":
	  "Topic 1.1": topic11.textile
	  "Topic 1.2": topic12.textile
	"Category 2":
	  "Topic 2.1": topic21.textile
	  "Topic 2.2": topic22.textile

3) Create the files you specify (*.textile) on `config/help` directory.

4) Import the topics with `rake help:update`

5) Start the server `script/server` and go to `http://localhost:3000/help` to view the help index.

6) This plugin has two dependencies: <http://github.com/fnando/has_permalink> and <http://github.com/fnando/has_markup>.

Customization
-------------

To customize the view, just create two views at `app/views/help/index.erb.html` and `app/views/help/show.erb.html`. There's three instance variables: `@categories`, `@category` and `@topics`, depending on the view you're working.

You need to set two keys for your locale file:

	en:
	  back_to_top: "Back to top"
	  see_all: "See all"

Here's some CSS:

	body {
		font-family: Georgia;
		font-size: 14px;
		margin: 0;
		padding: 40px;
	}

	.help h3,
	.help-summary h2 a {
		color: #900;
		font-size: 18px;
		margin-bottom: 0;
	}

	.help-summary h2 a {
		text-decoration: none;
	}

	.help-summary h2 a:hover {
		text-decoration: underline;
	}

	.help p {
		line-height: 160%;
		margin: 0;
		padding-bottom: 10px;
	}

	a {
		color: rgb(54, 113, 161);
	}

	p.top a {
		font-weight: bold;
	}

	p.top a:after {
		content: "↑";
	}

	ul.topics {
		margin-left: 0;
		padding-left: 20px;
	}

	ul.topics li {
		margin: 5px 0;
	}

	h2#index {
		font-size: 24px;
		margin: 0;
	}

	.help {
		border-top: 1px dotted #888;
	}

TODO
----

* Write specs

License
-------

Copyright (c) 2009 Nando Vieira

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
