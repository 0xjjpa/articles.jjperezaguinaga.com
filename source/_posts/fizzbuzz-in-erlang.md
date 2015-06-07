title: FizzBuzz in Erlang
tags:
  - code
  - developer
  - erlang
  - fizzbuzz
  - lists
id: 262
categories:
  - Just life
date: 2012-11-10 20:30:42
---

While I was reading some Erlang, I stumbled upon the term [FizzBuzz](http://en.wikipedia.org/wiki/Bizz_buzz "Fizz Buzz") and how it is used to [test programmers](http://imranontech.com/2007/01/24/using-fizzbuzz-to-find-developers-who-grok-coding/ "Fizz Buzz testing") (and I just realized that my former employer used this to test me...). I found this [Erlang implementation](http://joelhughes.co.uk/erlang-fizzbuzz-showdown-pt-1 "Fizzbuzz Erlang"), made in [two](http://joelhughes.co.uk/erlang-fizzbuzz-showdown-pt2 "Fizz Buzz Erlang pt2.") parts. So, I decide to chip in and add mine: it's not so Erlangish and uses no properties of numbers (I was going to go all computer science on it) but mah, just wanted to showcase how Erlang is not THAT hard compared to other languages.

    -module(fizzbuzz).
    -export([fizzbuzz/1]).

    % How to run it in erl
    % $ erl
    % &gt; c(fizzbuzz).
    % {ok, fizzbuzz} (It will tell you about shadowed, its ok)
    % fizzbuzz:fizzbuzz(100).
    % ...

    fizzbuzz(N) -&gt;
    	lists:map(fun(N) -&gt;						
    			case (N rem 15) =:= 0 of
    				true -&gt; io:format("FizzBuzz~n");
    				false -&gt; 
    				case (N rem 3) =:= 0 of
    					true -&gt;	io:format("Fizz~n");
    					false -&gt; 
    					case (N rem 5) =:= 0 of
    						true -&gt; io:format("Buzz~n");
    						false -&gt; io:format("~B~n", [N])
    					end
    				end
    			end
    	end, lists:seq(1, N)).

From there, just run your Erl and enjoy.  Update: Here's the [Gist](https://gist.github.com/4052389 "Erlang FizzBuzz gist."), any better ideas?