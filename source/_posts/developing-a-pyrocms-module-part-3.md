title: 'Developing a PyroCMS module: Part 3'
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
id: 76
categories:
  - Developer Stories
date: 2011-12-20 15:57:32
---

_This a small series of stories that I'm writing for a project I'm doing at my office. The focus is to describe all my programming techniques and steps, as well as tools and strategies used in order to create the project. The project involves creating a PyroCMS that handles information related to the company contractors._

Please read [Developing a PyroCMS module: Part 2](http://jjperezaguinaga.wordpress.com/2011/12/10/developing-a-pyrocms-module-part-2/ "Developing a PyroCMS module: Part 2") first.

There's [Developing a PyroCMS module: Part 4](http://jjperezaguinaga.wordpress.com/2012/01/03/developing-a-pyrocms-module-part-4/ "Developing a PyroCMS module part 4") already.

We got stuck at our controller and view, so now we are ready to dig on the models. If you remember, our view rendered a table with our table options. Let's code the "Add Supplier" functionality; for that, I'm going to append a css style that's going to help me out with the buttons layout. I'll be using the [WhiteLabel Admin](http://revaxarts-themes.com/whitelabel/dashboard.html "White Label") skin so I'll be just appending the required classes. (It's licensed, so I'll recommend you to buy it if you want to use it). I will also set the names of my sub modules; I'll save them in an array an use them in the view with the **set** function we reviewed during Part 2.

Here's our controller:

[code]

public function index()
 {
 $data_tables = array('contractors.suppliers', 'contractors.clients',
 'contractors.terms', 'contractors.contractors');
 $this-&gt;template
 -&gt;append_metadata(css('buttons.css', 'contractors'))
 -&gt;title($this-&gt;module_details['name'])
 -&gt;set('data_tables', $data_tables)
 -&gt;build('admin/index');
 }

[/code]

And here's our view:

[code]

&lt;div id=&quot;contractors-content&quot;&gt;
 &lt;h2&gt;&lt;?php echo lang('contractors.welcome'); ?&gt;&lt;/h2&gt;
 &lt;p&gt;&lt;?php echo lang('contractors.welcome_intro');?&gt;&lt;/p&gt;
 &lt;table&gt;
 &lt;thead&gt;
 &lt;tr&gt;
 &lt;th&gt;Information&lt;/th&gt;
 &lt;th&gt;Add new information&lt;/th&gt;
 &lt;th&gt;View specific information&lt;/th&gt;
 &lt;/tr&gt;
 &lt;/thead&gt;
 &lt;tbody&gt;
 &lt;?php foreach($data_tables as $data): ?&gt;
 &lt;tr&gt;
 &lt;td&gt;&lt;?php echo lang($data); ?&gt;&lt;/td&gt;
 &lt;td&gt;&lt;?php echo anchor('/admin/contractors/'.strtolower(lang($data)).'/add', 'Add new', 'class=&quot;btn i_plus green icon&quot;'); ?&gt;&lt;/td&gt;
 &lt;td&gt;&lt;?php echo anchor('/admin/contractors/'.strtolower(lang($data)).'/index', 'View', 'class=&quot;btn i_preview blue icon&quot;'); ?&gt;&lt;/td&gt;
 &lt;/tr&gt;
 &lt;?php endforeach;?&gt;
 &lt;/tbody&gt;
 &lt;/table&gt;
 &lt;/div&gt;

[/code]

If you did everything right, and used WhiteLabel css, you will get something like this:

[![](http://jjperezaguinaga.files.wordpress.com/2011/12/gpsi_index_v2.png "GPSI_Index_v2")](http://jjperezaguinaga.files.wordpress.com/2011/12/gpsi_index_v2.png)

As you can see, I'm creating the "Add" and "View" functionality of the application; since each submodule represents a table in a database, the **right way to design the application would be using a model and a controller for each submodule. **Now, since I'm going for the fastest development possible, and the final application will be likely to change, I'll put all together in one file for simplicity (at the end, I can metada data to these files and with an external project split them). This will generate the following result:

*   Main Controller: admin.php

    *   Method #1 [Submodule] - suppliers($cmd = 'index')
    *   Method #2 [Submodule] - clients($cmd = 'index')
    *   ....

*   Main Model: admin.php

    *   Method #1 [Table] - get_all_suppliers()
    *   Method #2 [Table] - getl_all_clients()
    *   ....

*   Views:

    *   suppliers.php
    *   clients.php
    *   ....
<div>Now, each submodule can add, read, delete and update data from the Database! If you got the hint from the function parameters, then you can assume that in order to deliver each functionality to each submodule, I'll "switch" over all our possible features through parameters as commands, thanks to CodeIgniter's URI segment as parameter [feature](http://codeigniter.com/user_guide/general/controllers.html#passinguri "CodeIgniter URI Segmet as a Parameter"). For instance, the suppliers method would look like this:</div>
<div></div>
<div>[code]&lt;/pre&gt;
&lt;/div&gt;
&lt;div&gt;
public function suppliers($cmd = 'index') {
 switch($cmd) {
 case 'index':
 $data_suppliers = $this-&gt;admin_m-&gt;get_all_suppliers();
 $this-&gt;template
 -&gt;append_metadata(css('buttons.css', 'contractors'))
 -&gt;title($this-&gt;module_details['name'])
 -&gt;set('cmd_index', 1)
 -&gt;set('suppliers', $data_suppliers)
 -&gt;build('admin/suppliers');
 break;
 case 'add':
 $this-&gt;template
 -&gt;append_metadata(css('buttons.css', 'contractors'))
 -&gt;title($this-&gt;module_details['name'])
 -&gt;set('cmd_add', 1)
 -&gt;build('admin/suppliers');
 break;
 default:
 echo &quot;Unknown action for specified module&quot;;
 }
 }&lt;/div&gt;
&lt;div&gt;[/code]

</div>
_This programming pattern is not suggested as your functionality relies in only one file, and it's also not consistent with the MVC pattern. It's used for academic purposes and to speed up a small prototype that will likely to be modified. If you are curious about where I got this programming design pattern, it's how jQuery plugins are mostly [made](http://docs.jquery.com/Plugins/Authoring#Events "jQuery Plugin Programming Pattern"): methods are encapsulated as functions within arrays, that then are executed with the apply method. This pattern is common in scripting languages, and it may be the foster son of the [Factory Design Pattern](http://en.wikipedia.org/wiki/Factory_method_pattern "Factory Design Pattern")._

_If you got lost, feel free to download a [new sample](http://www.box.com/s/glxgd8lbz88rrejgz29g "MVC Sample") I put in my Box.net. It has the base model, controller and view used with the switch method to control the application._

**The add method**

Let's work on the Add Method on the Suppliers sub module. The first step is to see what data are we trying to add; Suppliers has only two fields, ID and Name. The ID is provided by MySQL so the only data we have to worry about is Name. What are the constrains on the Name? First, it can't be empty; second, must be inferior to 255 characters (the limit in our database); finally, it has to be cross site scripting free. We will apply these rules as using the [CodeIgniter Form Validation](http://codeigniter.com/user_guide/libraries/form_validation.html "Form Validator Class") class, so we will create an array of rules like this:

[code]

private $supplier_rules = array(
 array(
 'field' =&gt; 'name',
 'label' =&gt; 'lang:contractors.suppliers.form_name',
 'rules' =&gt; 'trim|max_length[255]|required|alpha|xss'
 )
 );

[/code]

After you load the form validator class ($this-&gt;load-&gt;library('form_validation')), you will be able to set those rules using the $this-&gt;form_validation-&gt;set_rules() method. Now, every single action to your database has to be wrapped by the $this-&gt;form_validation-&gt;run() method, allowing us to protect our database from invalid data.

Before going on, let's think for a moment; we created an array of rules for only one field and one submodule. We will have to create all those arrays for our submodules. If we do that, our **admin.php** main controller will have a long liste of rules we will have to scroll over multiple times. Are you a big fan of that? I'm not, so I decided to use the **form_validator.php **file in a **config folder **(you can read the documentation on how I managed to realize that [here](http://codeigniter.com/user_guide/libraries/form_validation.html#savingtoconfig "CodeIgniter Form Validator Class Using Config Files"), just create a config folder inside your module). There I put all my rules instead of adding them up in my controllers. Right now, my form_validator.php looks like this:

[code]

&lt;?php
$config = array(
 'suppliers' =&gt; array(
 array(
 'field' =&gt; 'supplier_name',
 'label' =&gt; 'lang:contractors.suppliers.form_name',
 'rules' =&gt; 'trim|max_length[255]|required|alpha_dash|xss_clean'
 )),

'clients' =&gt; array(
 array(
 'field' =&gt; 'name',
 'label' =&gt; 'lang:contractors.clients.form_name',
 'rules' =&gt; 'trim|max_length[255]|required|alpha_dash|xss_clean'
 )),
 ....
 );
?&gt;
[/code]

_I don't know why, but the controllers shorcut for the form validator class doesn't work on admin modules. For instance, if you try admin/suppliers, it won't work. I'll research more about it later._

Can you do the same for the messages? (set_message) Not that I had found, but in my case I just need a message for the "required" attribute on the validation. Also, this is not Ruby on Rails, but I don't like to repeat myself neither: let's move the form_validation load to the construct, as well as the set_message (required is the same for all my form validations). I got something like this in my construct:

[code]

public function __construct()
 {
 parent::__construct();
 $this-&gt;load-&gt;model('admin_m');
 $this-&gt;lang-&gt;load('contractors');

 $this-&gt;load-&gt;library('form_validation');
 $this-&gt;form_validation-&gt;set_message('required', lang('contractors.form_required'));

 $this-&gt;load-&gt;helper('html');
 $this-&gt;template-&gt;set_partial('shortcuts', 'admin/partials/navigation');
 }

[/code]

_Important Note: Don't forget to localize your module so it can be translate later! For instance, my contractors_lang.php file has all my messages and labels. For the form validation, don't forget to use the [sptrinf()](http://php.net/manual/en/function.sprintf.php "Sprintf Format") format; here's an example:_

[code]

// FORM BUTTONS
$lang['contractors.form_submit'] = 'Send';
$lang['contractors.form_required'] = 'The field %s is required';

[/code]

Our form validation is ready (remember to add the rule run() method). Let's go to our model now.

**admin_m.php**

Yes, yes, I know, I should don't this, but remember, RAD! All my methods for all my tables are cluggered in one same file, admin_m.php

[code]

class Admin_m extends MY_Model {

public function get_all_suppliers()
 {
 return $this-&gt;db-&gt;get($this-&gt;db-&gt;dbprefix('gpsi_suppliers'))-&gt;result_array();
 }

 public function insert_supplier($data)
 {
 return $this-&gt;db-&gt;insert($this-&gt;db-&gt;dbprefix('gpsi_suppliers'), $data);
 }

[/code]

_Oh, by the way, use [Allman style identing](http://en.wikipedia.org/wiki/Indent_style#Allman_style "Allman Code Style"). I know my code uses a mix, but I'm trying a few new Code Editors ([CodeLobster](http://www.codelobster.com/ "CodeLobster")) so my identing is crap right now. More related to the topic, don't forget to use dbprefix on your tables, so they are related to the table you are working on; for instance, my tables are named default_gpsi_*. I put the for the module and PyroCMS puts the default._

Well, that was easy, let's go back to our controller and load the model in the construct method ($this-&gt;load-&gt;model('admin_m')), now, let's give a look to our views.

**suppliers.php**

The suppliers view loads the right markup depending on the command received by the controller (remember the switch right?); I think you don't need further details on this code, as it is really straight forward: I use the Form Helper class from CI in order to create the labels and inputs.

[code]

&lt;div class=&quot;blank-slate&quot;&gt;
&lt;?php if (isset($cmd_add) &amp;&amp; $cmd_add === 1): ?&gt;
&lt;h2&gt;&lt;?php echo lang('contractors.suppliers.add_title'); ?&gt;&lt;/h2&gt;
&lt;?php echo form_open(uri_string()); ?&gt;
 &lt;?php echo form_fieldset(lang('contractors.suppliers.add_intro')); ?&gt;

&lt;!-- Name --&gt;
 &lt;?php echo form_label(lang('contractors.suppliers.form_name'), 'name'); ?&gt;
 &lt;?php $supplier_name = array('id'=&gt;'supplier_name','name'=&gt;'supplier_name','type'=&gt;'text'); ?&gt;
 &lt;?php echo form_input($supplier_name); ?&gt;

 &lt;!-- /Name --&gt;

&lt;?php echo form_submit('submit', lang('contractors.form_submit'), 'class=&quot;green small&quot;'); ?&gt;

&lt;?php echo form_close(); ?&gt;
&lt;?php elseif (isset($cmd_index) &amp;&amp; $cmd_index === 1): ?&gt;
 &lt;?php print_r($suppliers); ?&gt;
&lt;?php endif; ?&gt;
&lt;/div&gt;

[/code]

Right now I just print the data I get from the database, with our model method and the template set method:

[code]

switch($cmd) {
 case 'index':
 $data_suppliers = $this-&gt;admin_m-&gt;get_all_suppliers();
 $this-&gt;template
 -&gt;append_metadata(css('buttons.css', 'contractors'))
 -&gt;title($this-&gt;module_details['name'])
 -&gt;set('cmd_index', 1)
 -&gt;set('suppliers', $data_suppliers)
 -&gt;build('admin/suppliers');
 break;

[/code]

Ready to integrate our form validator with the model and view? This will be the result :

[code]

if ($this-&gt;form_validation-&gt;run('suppliers') )
 {
 $data = array
 (
 'name' =&gt; set_value('supplier_name')
 );
 if ($id = $this-&gt;admin_m-&gt;insert_supplier($data))
 {
 $this-&gt;session-&gt;set_flashdata('success', sprintf(lang('contractors.suppliers.add_success'), set_value('supplier_name')) );
 redirect($this-&gt;uri-&gt;uri_string);
 }
 else
 {
 $this-&gt;session-&gt;set_flashdata('error', lang('contractors.suppliers.add_error') );
 redirect($this-&gt;uri-&gt;uri_string);
 }
 }

[/code]

Let's go line per line:

[code] $this-&gt;form_validation-&gt;run('suppliers') [/code]

We make sure that the form is validating the input using the rules we set up in our **form_validation.php **file inside our **config **folder.

[code]

$data =
 array(
 'name' =&gt; set_value('supplier_name')
 );

[/code]

I prepare the data I'm sending to my model, because my label names are different than my column names. It's important to make this distintion, as for a normalized database will have tables with multiple columns labeled as "name", for instance, but you want to be able to distinguish them for styling purposes, or to apply an specific behavior  through Javascript (which I will do later).

The next lines:

[code]

if ($id = $this-&gt;admin_m-&gt;insert_supplier($data))
 {
 $this-&gt;session-&gt;set_flashdata('success', sprintf(lang('contractors.suppliers.add_success'), set_value('supplier_name')) );
 redirect($this-&gt;uri-&gt;uri_string);
 }
 else
 {
 $this-&gt;session-&gt;set_flashdata('error', lang('contractors.suppliers.add_error') );
 redirect($this-&gt;uri-&gt;uri_string);
 }

[/code]

If the query was successful, $id is going to have a value over 0\. We will then create a [Session Flash Data](http://codeigniter.com/user_guide/libraries/sessions.html "Session Flash Data"), which PyroCMS will load **automatically. **What does this mean? Usually you would need to retrieve the session data an display it in your views; check this out, PyroCMS does this for you, with a neat format and style. You can read what messages can display [here](http://www.pyrocms.com/docs/1.3/tag-reference/session "PyroCMS Session"). As a final note, I used sprintf in my message so I could show the user which supplier was added. This will be useful when he/she adds multiple ones at the same time!

We will see that other session, as this one was already too long. Don't worry, the next one we will use AJAX for sure (as I know I promised that last part). If you got lost with all the codes (as I don't have a highlight plugin), I copied the MVC and how it ended as a result of the Part 3\. Feel free to download it [here](http://www.box.com/s/glxgd8lbz88rrejgz29g "Box Net Part 3"). Thanks for reading!