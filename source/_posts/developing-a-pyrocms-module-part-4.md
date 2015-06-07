title: 'Developing a PyroCMS module: Part 4'
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
id: 85
categories:
  - Developer Stories
date: 2012-01-03 20:07:02
---

_This a small series of stories that I'm writing for a project I'm doing at my office. The focus is to describe all my programming techniques and steps, as well as tools and strategies used in order to create the project. The project involves creating a PyroCMS that handles information related to the company contractors._

Please read [Developing a PyroCMS module: Part 3](http://jjperezaguinaga.wordpress.com/2011/12/20/developing-a-pyrocms-module-part-3/ "Developing a PyroCMS module Part 3") first.

If you have read everything so far, you were able to produce something like the following pictures, as well as an index that prints your data list tables.

![](http://jjperezaguinaga.files.wordpress.com/2011/12/error-supplier.png?w=300 "Error Supplier")![](http://jjperezaguinaga.files.wordpress.com/2011/12/success-supplier.png?w=300 "Success Supplier")

Today I'm going to work on 4 features: **smart database row listing**, **mysql error reporting** and the **delete and edit functionality** on AJAX.

**Smart Database Row Listing**

This is a term I use in order to describe the process to display data of a database no matter how many columns or rows the table I want to view has. There are many ways to do so, although for those that play around with Ruby on Rails or any other language with scaffolding features will just laugh on this part. Let's get on it.

If we remember from last part, we retrieve the data from our suppliers in our model with the result_array() method.

[sourcecode language="php"]

public function get_all_suppliers()
 {
 return $this-&gt;db-&gt;get($this-&gt;db-&gt;dbprefix('gpsi_suppliers'))-&gt;result_array();
 }

[/sourcecode]

_Method? Function? What's the difference? A function is a general term for a **procedure applied to a set of arguments.** The difference with "method" (as it is a procedure too) is that it's related to Object Oriented Programming. Objects have public and private methods, which are functions themselves but related to that Object's scope. Summed up? All methods are functions, but not all functions are methods. _

With this we have an array with the table data. Now, in order to display this data in a smart way, we need the following information: first, does it have any information whatsoever? how many rows does the data contains? how many columns distribute this data into? As I said before, there are many ways to do this, but let's go simple:

[sourcecode language="php"]
$data_suppliers = $this-&gt;admin_m-&gt;get_all_suppliers();

 /// SUPPLIERS DATA ///
 $rows = 0;
 $cols = 0;
 $isEmpty = 1;
 if (!empty($data_suppliers))
 {
 $isEmpty = 0;
 $cols = count($data_suppliers[0]);
 $rows = count($data_suppliers);
 }

[/sourcecode]

_Depending on your standards, you can name your variables as you wish. I like to prepend "data" on my retrieved data from a model, in order to describe that it hasn't gone through any modifications. Sometimes it's "raw", depending on my mood._

Let's save that information in a array that we will use later.

[sourcecode language="php"]
$suppliers = array(
 'isEmpty' =&gt; $isEmpty,
 'cols' =&gt; $cols,
 'rows' =&gt; $rows
 );

[/sourcecode]

_The data_suppliers array contains the raw data that will be displayed. The suppliers array contains the meta information of the data_suppliers. A better way to structure this information would be to only have the suppliers array, with an extra field on the array called "data" that contains the data_suppliers. Bear with me on this one._

Did you set() both arrays from your controller? Good, let's display the information on our view; remember that we are using the varialbe cmd_index to tell our view that it has to display instead of add (that's what cmd_add is for).

[sourcecode language="php"]

&lt;?php elseif (isset($cmd_index) &amp;&amp; $cmd_index === 1): ?&gt;
 &lt;h2&gt; Review Suppliers &lt;/h2&gt;
 &lt;?php if($suppliers['isEmpty']): ?&gt;
 &lt;p&gt; There's no current information about Suppliers&lt;/p&gt;
 &lt;?php else: ?&gt;
 &lt;table&gt;
 &lt;thead&gt;
 &lt;tr&gt;
 &lt;?php while ($col_name = current($data_suppliers[0])) {
 echo '&lt;th&gt;'.strtoupper(key($data_suppliers[0])).'&lt;/th&gt;';
 next($data_suppliers[0]);
 } ?&gt;
 &lt;/tr&gt;
 &lt;/thead&gt;
 &lt;tbody&gt;
 &lt;?php foreach($data_suppliers as $data): ?&gt;
 &lt;tr&gt;
 &lt;?php while ($col_name = current($data)) {
 echo '&lt;td&gt;'.$data[(key($data))].'&lt;/td&gt;';
 next($data);
 } ?&gt;
 &lt;/tr&gt;
 &lt;?php endforeach;?&gt;
 &lt;/tbody&gt;
 &lt;?php endif; ?&gt;
&lt;?php endif; ?&gt;

[/sourcecode]

If you did everythign right, you should be able to see something like this on the "View" section.

[caption id="attachment_109" align="alignnone" width="354" caption="View (Index) of Suppliers"]![](http://jjperezaguinaga.files.wordpress.com/2012/01/index_suppliers.png "Index_suppliers")[/caption]

**MySQL Error Reporting**

So far we had been able to add data and read it in a pretty format (by the way, I didn't add any style in the previous view, PyroCMS has those styles by default). However, we have a problem: since the suppliers name has to be unique, a MySQL Error is displayed when adding a repeated supplier.

[caption id="attachment_113" align="alignnone" width="590" caption="MySQL Error (In case you were wondering how it looks in Spanish)"][![](http://jjperezaguinaga.files.wordpress.com/2012/01/mysqlerror.png "MySQLError")](http://jjperezaguinaga.files.wordpress.com/2012/01/mysqlerror.png)[/caption]

In order to avoid this, we need to follow 2 steps:

1.- Turn off MySQL error reporting

2.- Display the error

**Turn off MySQL error debug**

Usually, to do this in CodeIgniter, you go to your config/database.php file and set to FALSE the variable $db['default']['db_debug']. How do we do this in a module?

First let me tell you that I tried to go with a config/database.php and do the same but it didn't work. Same went with a config/config.php file (although for the record, instead of using $db['default']['db_debug'] you would use $db[ENVIRONMENT]['db_debug'] due PyroCMS Enviroment and Production features. Read more about it [here](http://www.pyrocms.com/docs/2.0/getting-started/development-and-production-environments "Development and Production Environment")).

When that didn't work, I just went to modify the $db object on Run Time. How? Just create a constructor for your module's model (no pun intended) that holds the false statement for debugging.

[sourcecode language="php"]
//In admin_m.php
public function __construct()
{
$this-&gt;db-&gt;db_debug = FALSE;
}
[/sourcecode]

This way your application will now fail silently. However, how can we still use the environment feature that PyroCMS provides you? (If you read the previous links, you would know the benefits of using it). We will just copy a few lines from our PyroCMS index.php and adapt it to our needs.

[sourcecode language="php"]
//This goes inside our model's construct
switch (ENVIRONMENT)&lt;/pre&gt;
{
 case 'local':
 case 'dev':
 $this-&gt;db-&gt;db_debug = TRUE;
 break;

case 'qa':
 case 'live':
 $this-&gt;db-&gt;db_debug = FALSE;
 break;

default:
 $this-&gt;db-&gt;db_debug = FALSE;
 }
&lt;pre&gt;[/sourcecode]

_The reason why this is good is because in localhost, where you are still working on your module, you WANT to see all your errors. Yeah, you may think that there won't be an error and that you want to see everything working like if it were live right? My QA teacher had a word for those kind of persons: fools._

If you are hosting your application with a cloud platform like [Phpfog](https://phpfog.com/ "PHP Cloud Platform"), you would then realize than on index.php, the value of ENVIRONMENT is defined. Yes, that means that you won't need to assign it or do anything at all to define it, PyroCMS does it for you. Now, obviously the ideal would be to have a config file with this on it, but I haven't yet been able to find how or where to put it. I'll update this entry when I figure it out.

**Turn off MySQL error debug**

To display the errors... well, you already do! Remember?

[sourcecode language="php"]

if ($id = $this-&gt;admin_m-&gt;insert_supplier($data))
 {
 $this-&gt;session-&gt;set_flashdata('success', sprintf(lang('contractors.suppliers.add_success'), $data['name']) );
 redirect($this-&gt;uri-&gt;uri_string);
 }
 else
 {
 $this-&gt;session-&gt;set_flashdata('error', lang('contractors.suppliers.add_error') );
 redirect($this-&gt;uri-&gt;uri_string);
 }

[/sourcecode]

Now you, may want to try to get the error text or number with $this-&gt;db-&gt;_error_message() and $this-&gt;db-&gt;_error_number()... it doesn't work. The only thing that it's different from a successful mySQL operation and a non-successful one, is the value the insert returns (it's from the $db object inserted_id value, success is 1, error is empty vaue). Ergo, this is your best solution.

**Edit and Delete functionality with AJAX**

The next thing we want to do is to both Edit (and update) the values we added and Delete the ones we don't want. Delete operations follow two possible UI standards:

1.- Items deleted are stored in a cache store, so rollback is possible. You may have read the term "ghost values" from this pattern.

2.- Any operation prompts a confirmation action.

Since we want to go simple on this one, we will just use the second one. You can use implement a json store yourself in case you want to go for the first one; however, if you really want to do the first one, I strongly recommend you give a look to Ext JS 4 from &lt;a title="Sencha " href="http://www.sencha.com/products/extjs" target="_blank"&gt;Sencha&lt;/a&gt; json store API. Be adviced, it's easy to fell in love with the library, but it's not open source, so if you want to use in any commercial application be ready to some interesting fees (and don't even think of not paying your license, that's a no no).

<span style="color:#ff0000;">Edit and Delete on Model</span>

First, let's create our edit and delete actions in our models. That's quite simple thanks to CodeIgniter active record.

[sourcecode language="php"]

public function update_supplier($id, $data)
 {
 $this-&gt;db-&gt;where('id', $id);
 return $this-&gt;db-&gt;update($this-&gt;db-&gt;dbprefix('gpsi_suppliers'), $data);
 }

 public function delete_supplier($id)
 {
 $this-&gt;db-&gt;where('id', $id);
 return $this-&gt;db-&gt;delete($this-&gt;db-&gt;dbprefix('gpsi_suppliers'));
 }

[/sourcecode]

<span style="color:#ff0000;">Edit and Update on Controller</span>

Let's now add the Edit and Update to our controller with the same structure we used before. What this is going to do is call the functions we described before in our model. First the edit part:

[sourcecode language="php"]
case 'edit':
 $id = $this-&gt;input-&gt;post('supplier_id');
 $arr_result = ($this-&gt;admin_m-&gt;get_supplier($id));
 $result = $arr_result['name'];

 if ($this-&gt;form_validation-&gt;run('suppliers'))
 {
 $data =
 array(
 'name' =&gt; $this-&gt;input-&gt;post('supplier_name'),
 'id' =&gt; $id
 );

 if ($id = $this-&gt;admin_m-&gt;update_supplier($data['id'], $data))
 {
 $result = $data['name'];
 }
 }
 echo $result;
 break;

[/sourcecode]

_What's going on here? First we get the input without validating it, specially because it's not from user's input, so we don't really need to and we will use it before validating our form. Then, we get the PREVIOUS name of the supplier, in case the validation fails, we return the old value. I used a new function called get_supplier, that I guess you can figure yourselves out; if you really need to know, here is it. _

[sourcecode language="php"]
public function get_supplier($id)
 {
 $this-&gt;db-&gt;where('id', $id);
 return $this-&gt;db-&gt;get($this-&gt;db-&gt;dbprefix('gpsi_suppliers'))-&gt;row_array();
 }
[/sourcecode]

On the delete:

[sourcecode language="php"]&lt;/pre&gt;
case 'delete':

 $id = $this-&gt;input-&gt;post('supplier_id');
 if ($id = $this-&gt;admin_m-&gt;delete_supplier($id))
 {
 echo &quot;success&quot;;
 }
 else
 {
 echo &quot;error&quot;;
 }

 break;
&lt;pre&gt;

[/sourcecode]

_Quick notes before going on. First, don't forget to add your messages in the language folder. Second, why would I want to use $data['id'], $data (on the edit one) if I could send just data? Easy, readibility. There's a chance that some day you will fingle with someone's code, and you won't have access to all the data inside of it. By explicit asking $id as a parameter, I'm telling the future me that I'm using the $id for something, so it's very important that it has a value on it. Finally, on my model I used the value 'id' because that's how I named my columns. If you have other convention, like table_name_id, that's ok, but stick with it for your whole database. I think the delete one is quick explicit, so I'll make no comments on it._

Ready for the fun part? We have to POST to this methods from our views without using a form; Javascript time!

<span style="color:#ff0000;">Edit and Update on the View</span>

What would be the best way for a person to edit a field? After asking a lot of UX experts, the best choice came as the one that involved  to just click on the data you want to edit, and then you will be able to edit it. Since we are have only text fields (nothing fancy), we will use the [Jeditable](http://www.appelsiini.net/projects/jeditable "Jeditable Plugin") plugin. This will allow us to do that in our VIEW section, so the user can see what he or she is editing.

First, let's add the Jeditable file to our index section of our view and the script that loads it. Since we will need jQuery for this, let's use PyroCMS one. We load that through the controller, of course.

[sourcecode language="php"]

//In our controller, index section, on the template loading

$this-&gt;template
 -&gt;append_metadata( css('buttons.css', 'contractors'))
 -&gt;append_metadata( js('jquery/jquery.min.js') )
 -&gt;append_metadata( js('jquery.editable.js', 'contractors') )
 -&gt;append_metadata( js('script.js', 'contractors') )
 -&gt;title($this-&gt;module_details['name'])
 -&gt;set('cmd_index', 1)
 -&gt;set('data_suppliers', $data_suppliers)
 -&gt;set('suppliers', $suppliers)
 -&gt;build('admin/suppliers');
 break;

[/sourcecode]

_The first line loads jQuery from the cms folder in our system. The second line adds the plugin we require, and the third one is the script that will load all our plugins, in this case so far only the jeditable one._

Before we get into the script.js file, let's modify our index view so we can add a class and an ID to the suppliers we want to edit.

[sourcecode language="php"]

// This is in the suppliers.php file, the view for our suppliers controllers.&lt;/pre&gt;
&lt;?php while ($col_name = current($data)) {
 if( strcmp(key($data), 'name') == 0 )
 {
 echo '&lt;td id=&quot;'.$supplier_id.'&quot; class=&quot;editable&quot;&gt;'.$data[(key($data))].'&lt;/td&gt;';
 }
 else
 {
 $supplier_id = $data[(key($data))];
 echo '&lt;td&gt;'.$supplier_id.'&lt;/td&gt;';
 }
 next($data);
 } ?&gt;
&lt;pre&gt;

[/sourcecode]

_I added a new variable, $supplier_id, just to hold the id of the data. Your id column should always be first; if not, well, you should at least put this variable before with a value of zero to realize your error later._

Let's go to the script that makes everything work; we won't POST things yet, let's just make sure the jEditable plugin is working.

[sourcecode language="javascript"]

$(document).ready(function() {
 //for Caching
 var $content = $('#content');

 $content.find('.editable').editable(function(value, settings) {
 return(value);}, {type : 'text'});

});

[/sourcecode]

_I know it can be hard to follow all the scripts I put, that's why at the end I'm putting all the generated files together for you to download. Quick note though, I'm using the selector #content because that's what all my views are wrapped in. Frankly I don't remember if it was PyroCMS who put that or me at some point; use a the native Web Developer Toolkit from your browser to check what's your container._

If you get something like this when you click in your columns, we are good so far.

[caption id="attachment_123" align="alignnone" width="552" caption="jEditable plugin on action"][![](http://jjperezaguinaga.files.wordpress.com/2012/01/jeditableindex.png "jEditableIndex")](http://jjperezaguinaga.files.wordpress.com/2012/01/jeditableindex.png)[/caption]

The edit won't be much of a trouble then. We just need to put right URL and parameters for our suppliers. Do you remember the suppliers.php modifications? We needed to add the unique ID to the Text element, since that's what jEditable uses to POST; now, since I'm using the names supplier_id and supplier_name for the post, script.js ends up like this:

[sourcode language="javascript"]

$(document).ready(function() {
//for Caching
var $content = $('#content');
$content.find('.editable').editable(SITE_URL+'admin/contractors/suppliers/edit', {
id: 'supplier_id',
name: 'supplier_name',
});

)};

[/sourcecode]

That should work! The best way would be to create a plugin that gets the URL as an option, or to create a smart plugin that will check for a specific element only loaded to some views. You can decide what do you want to do, but I will likely go for the second option when I start working on the plugin on the next parts.

The delete is maybe simpler, we will just add an extra column in our views with a little icon that will trigger through ajax the delete option. I will add the following lines on each while on the suppliers.php to create a new column:

[sourcecode language="php"]

//After  the first while ...

&lt;th&gt; Delete &lt;/th&gt;

...

//After the second while, inside the foreach part.

&lt;td&gt;&lt;?php echo anchor('#', 'Delete', array('class' =&gt; &quot;btn i_trash delete red icon&quot;, 'id' =&gt; 'delete-'.$supplier_id.'')); ?&gt;&lt;/td&gt;

[/sourcecode]

The only that's left is the required Javascript; as I explained before, I won't go further in the plugin development to make it work for the other submodules, I'll just explain the basics to work on the suppliers one:

[sourcecode language="javascript"]

$content.find('.delete').click(function(e) {
 var $this = $(this);
 var id = $this.attr('id').split(&quot;delete-&quot;)[1];
 $.ajax({
 url: SITE_URL+'admin/contractors/suppliers/delete',
 data: {supplier_id: id},
 type: &quot;POST&quot;,
 success: function(msg)
 {
 if(msg === 'success');
 $this.parent().parent().fadeOut();
 }
 });
 e.preventDefault();
 });

[/sourcecode]

_Did I mentioned that PyroCMS has some default javascript constants for your back end? I hope I did! All of them are [here](http://www.pyrocms.com/docs/1.3/manuals/developers/constants-globals "PyroCMS Constants")._

Right now that's kind of faulty (we don't report any error, although I have to admit that's hard on a delete operation), and we forgot to prompt user to confirm if he or she was sure to delete the supplier. We will do that in the next and last part of this series, which will be more focused on Javascript and maybe a little surprise if I have time.

After thinking for a while, I think there's no harm if you get to download the **whole module;** this means that you will be able to download what I have done so far in a handy module to put in modules section, and install without no problem (I didn't do the uninstall! Sorry about that). All controllers, views and models are include, even the database logic is there, in case you want to give a look. The only thing I left off was the WhiteLabel icons, but you can buy those in their webpage. You should be able to install and activate it in your own environment, and try the functionality described in the series. If you develop anything good from it, just don't forget to share :). You can download the module from my box.net account [here](http://www.box.com/s/glxgd8lbz88rrejgz29g "My BoxNet Account") under the name "contractors.zip". See you next time!