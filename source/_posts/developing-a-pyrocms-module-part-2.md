title: 'Developing a PyroCMS module: Part 2'
tags:
  - codeigniter
  - controller
  - database
  - helper
  - html
  - libraries
  - model
  - module
  - partial
  - php
  - view
id: 44
categories:
  - Developer Stories
date: 2011-12-11 19:09:52
---

_This a small series of stories that I'm writing for a project I'm doing at my office. The focus is to describe all my programming techniques and steps, as well as tools and strategies used in order to create the project. The project involves creating a PyroCMS that handles information related to the company contractors._

Please read [Developing a PyroCMS module: Part 1](http://jjperezaguinaga.wordpress.com/2011/12/10/developing-a-pyrocms-module-part-1/ "Developing a PyroCMS module: Part 1") first.

There's [Developing a PyroCMS module: Part 3](http://jjperezaguinaga.wordpress.com/2011/12/20/developing-a-pyrocms-module-part-3/ "Developing a PyroCMS module Part 3") already.

So I got my strategies, my tools and workflow set and ready. Let's get started! As I illustrated in the post[ Steps to Develop a PyroCMS module](http://jjperezaguinaga.wordpress.com/2011/12/09/steps-to-develop-a-pyrocms-module/ "Steps to Develop a PyroCMS module"), the first thing we need to settle is the **details.php** file, the basic setup for our file. (If you need to download a stripped module template so you can fill your info, I suggest to download it from my [BoxNet](http://www.box.com/s/glxgd8lbz88rrejgz29g "Box Net PyroCMS repo"). It's not in github cause I won't mantain it, sorry, I will for the 2.0 version).

**details.php**

This file is required for your module to work; it also requires inside of it 4 methods: info() -that returns an array with basic information about your module-, install() -that runs the queries for your database setup-, uninstall() -where you clean up your database and return true if succeded- and help() -that returns a html markup string with help for your module-. Upgrade is also suggested but I don't think it's required. Now, before going on, make sure you have defined all your data model (I know, it would be awesome to have it defined through objects, but we are using MySQL here, sorry). Install will look something like this:

[code]
public function install() {

$this-&gt;dbforge-&gt;drop_table('table_name');

$table_query = 'CREATE TABLE IF NOT EXISTS' . $this-&gt;db-&gt;dbprefix('table_name').' ( .... ) ';

if ($this-&gt;db-&gt;query('table_name')) return TRUE; //if you use dbforge here, dbprefix in the $table_query wont be required.

}
[/code]

Uninstall will only include the drop table statement, and return TRUE if succeded. For instance, in my case, I don't want anyone to accidently remove all data, so I always return FALSE. PyroCMS displays an error that the module wasn't uninstall. As a rule of thumb, install and uninstall many times your module and make sure all the data logic is being created. If you are using foreign keys, it's likely that when dropping, you must use a specific order (drop tables that contain the foreign keys first) in order to make it work. In order to continue with the example, it may be useful for you to see what data model I will be using. Here's the model I will be using. [![Sample Data Model](http://jjperezaguinaga.files.wordpress.com/2011/12/gpsi_datamodel.png "GPSI_DataModel")](http://jjperezaguinaga.files.wordpress.com/2011/12/gpsi_datamodel.png) **controllers/admin.php**

 After I pushed my data in the database, I need to create my models in order to create, read, update and delete the data (CRUD). For this example, I will be using the simplest table from my model: suppliers.** Suppliers **only requires a valid name with less than 45 characters. Let's start from the logic of the data retrieval, which will be handled by the controller/admin.php. How do we get the data? First, since suppliers is just one table of all the tables that will require CRUD. Therefore, it would be nice to have an index listing all the tables and all the options available for them. The controller then will render my view that holds a list of my tables within a table (no pun intended).

[code]

public function index()
 {
 $this-&gt;template
 -&gt;title($this-&gt;module_details['name'])
 -&gt;build('admin/index');
 }

[/code]

Simple right? Now, the magic is in the view. Let's go to admin/index and see what it contains:

[code]&lt;/pre&gt;
&lt;div id=&quot;contractors-content&quot;&gt;
&lt;h2&gt;&lt;/h2&gt;
&lt;!--?php echo lang('contractors.welcome_intro');?--&gt;
&lt;table&gt;
&lt;thead&gt;
&lt;tr&gt;
&lt;th&gt;Information&lt;/th&gt;
&lt;th&gt;Add new information&lt;/th&gt;
&lt;th&gt;View specific information&lt;/th&gt;
&lt;/tr&gt;
&lt;/thead&gt;
&lt;tbody&gt;
&lt;tr&gt;
&lt;td&gt;Suppliers&lt;/td&gt;
&lt;td&gt;Button&lt;/td&gt;
&lt;td&gt;Button&lt;/td&gt;
&lt;/tr&gt;
&lt;/tbody&gt;
&lt;/table&gt;
&lt;/div&gt;
&lt;pre&gt;[/code]

Again, pretty straight forward information. It's worth mention that I'm using the Language Helper from CodeIgniter in order to render the text. In order to do so, just start the lang helper in the constructor of your controller or the method you want to use it. Also, since I'll be using plenty of forms, the HTML helper would be nice too (the Form one is already loaded). Feel free to copy this code, my controller constructor:

[code]

public function __construct()
 {
 parent::__construct();
 $this-&gt;lang-&gt;load('contractors');
 $this-&gt;load-&gt;helper('html');
 $this-&gt;template-&gt;set_partial('shortcuts', 'admin/partials/navigation');
 }

[/code]

If you have doubts on the third line of the code, don't google that yet, I will explain it later. If you did everything right, you would be able to see something like this (I added an extra row just for academic purposes, you'll soon see why). [![GPSI Module Intro](http://jjperezaguinaga.files.wordpress.com/2011/12/gpsi-indexmodule.png "GPSI-IndexModule")](http://jjperezaguinaga.files.wordpress.com/2011/12/gpsi-indexmodule.png) Now, we can see three interesting things here: The first one is that there's an interrogation sign at the top right of the module. If you click on it, you will see a colorbox rendering the html that your details.php file provided through the help() method.The second thing worth mentioning is that there's a navigation menu that displays "Suppliers". This is a **partial**, a little chunk of HTML that PyroCMS allows me to render in my module. Remember the third line in the construct of my controller? I set up a partial using the keyword "shortcuts", which is an already predefined partial that I'm just overriding with a new parameter, in this case, the path to my own navigation menu. There are many partials you can use, but that's the only one we are going to use for now. And at last but not least... did you see that I imported any style whatsoever? The answer is no, yet, the second row of the table displays a gray background as part of a usability feature. That's because PyroCMS has already some pretty handy classes and styles rolling that will help us to settle the basic things without getting messy. For the next part, I'll explain how to use custom and CSS and JS for our module.

Now, let's make a little modification to our controller. Since I know which tables are going to be modified in the backend, I'll put them in an array and send them to my view, so instead of having to write all the markup for each table, I'll let PHP do it for me. I can do that using the method **set **from PyroCMS. Here's the new controller and view.

[code]

///////// CONTROLLER

public function index()
 {
 $data_tables = array('contractors.suppliers', 'contractors.clients',
 'contractors.terms', 'contractors.contractors'); //Remember to send the language strings if you are using the language helper
 $this-&gt;template
 -&gt;title($this-&gt;module_details['name'])
 -&gt;set('data_tables', $data_tables)
 -&gt;build('admin/index');
 }

////////// VIEW&lt;/pre&gt;
&lt;div id=&quot;contractors-content&quot;&gt;
&lt;h2&gt;&lt;/h2&gt;
&lt;!--?php echo lang('contractors.welcome_intro');?--&gt;
// Just a foreach trick
&lt;table&gt;
&lt;thead&gt;
&lt;tr&gt;
&lt;th&gt;Information&lt;/th&gt;
&lt;th&gt;Add new information&lt;/th&gt;
&lt;th&gt;View specific information&lt;/th&gt;
&lt;/tr&gt;
&lt;/thead&gt;
&lt;tbody&gt;&lt;!--?php foreach($data_tables as $data): ?--&gt;
&lt;tr&gt;
&lt;td&gt;&lt;/td&gt;
&lt;td&gt;{Button}&lt;/td&gt;
&lt;td&gt;{Button}&lt;/td&gt;
&lt;/tr&gt;
&lt;!--?php endforeach;?--&gt;&lt;/tbody&gt;
&lt;/table&gt;
&lt;/div&gt;
&lt;pre&gt;[/code]

We have reviewed the controller and the view, but we still need to check the model. I'll save that up for the next part, as we will be creating a form that updates to the database through -wait for it- AJAX. I hope you like it and wait for the next part.