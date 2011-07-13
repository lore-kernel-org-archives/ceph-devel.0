From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 12:54:26 -0700
Message-ID: <CA+qbEUO9XRPaWnSjv3Exh1TppD7OLNZa=TsZdQKyju+G07x_Bg@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
	<CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
	<CA+qbEUOvPqv8r1+LG5ygi8dH5-Cw0+FJnVsnSfamW0N6R1kkUA@mail.gmail.com>
	<CAC-hyiE9XDTE99wox3e3-hL+eF40TyRUhfJ=kv4R_UtZcggG+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44482 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1GMTy2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 15:54:28 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 675C9C067
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 12:54:29 -0700 (PDT)
Received: from mail-fx0-f52.google.com (mail-fx0-f52.google.com [209.85.161.52])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E4605C065
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 12:54:28 -0700 (PDT)
Received: by fxd18 with SMTP id 18so6292394fxd.11
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 12:54:26 -0700 (PDT)
In-Reply-To: <CAC-hyiE9XDTE99wox3e3-hL+eF40TyRUhfJ=kv4R_UtZcggG+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 13, 2011 at 11:59 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Wed, Jul 13, 2011 at 11:21 AM, Colin McCabe <cmccabe@alumni.cmu.ed=
u> wrote:
>> On Wed, Jul 13, 2011 at 10:52 AM, Yehuda Sadeh Weinraub
[snip class variable naming discussion]

You seem to have two objections to the proposed naming. One is that
you don't like the trailing underscore. That is fine-- I like the "m_"
prefix better myself.

The second is that you don't want "mixed code." I really don't
understand this objection. We have "mixed code" right now... there are
some classes currently use m_ prefixes, some that use underscore
prefixes, and some that use none of the above. There are some people
using the exact same variable names for class variables and local
variable names-- like the example that I gave-- and relying on the C++
shadowing rules. I don't see how any reasonable person can read that
kind of code and not feel confused and frustrated.

>
>>
>>>
>>>>
>>>> * Naming > Constant Names:
>>>>
>>>> =A0 Google uses kSomeThing for constants. =A0We prefere SOME_THING=
=2E
>>>>
>>>> * Naming > Function Names:
>>>>
>>>> =A0 Google uses CamelCaps. =A0We use_function_names_with_underscor=
es().
>>>>
>>>> =A0 Accessors are the same, {get,set}_field().
>>>>
>>>> * Naming > Enumerator Names:
>>>>
>>>> =A0 Name them like constants, as above (SOME_THING).
>>>>
>>>> * Comments > File Comments:
>>>>
>>>> =A0 Don't sweat it, unless the license varies from that of the pro=
ject (LGPL2) or
>>>> the code origin isn't reflected by the git history.
>>>>
>>>> * Formatting > Conditionals:
>>>>
>>>> =A0 - No spaces inside conditionals please, e.g.
>>>>
>>>> =A0 =A0 =A0 =A0if (foo) { =A0 // okay
>>>>
>>>> =A0 =A0 =A0 =A0if ( foo ) { // no
>>>>
>>>> =A0 - Always use newline following if:
>>>>
>>>> =A0 =A0 =A0 =A0if (foo)
>>>> =A0 =A0 =A0 =A0 =A0bar; =A0 =A0 =A0 =A0 // okay
>>>>
>>>> =A0 =A0 =A0 =A0if (foo) bar; =A0// no, usually hardler to visually=
 parse
>>>>
>>>>
>>>>
>>>>
>>>> The following guidelines have not been followed in the legacy code=
,
>>>> but are worth mentioning and should be followed strictly for new c=
ode:
>>>>
>>>> * Header Files > Function Parameter Ordering:
>>>>
>>>> =A0 =A0Inputs, then outputs.
>>>
>>> I generally agree, just that there's a class of strcpy like functio=
ns
>>> that put the destination first. This usually makes sense when you h=
ave
>>> multiple functions that do similar things with varied input
>>> parameters:
>>>
>>> =A0char *strcpy(char *dest, const char *src);
>>>
>>> =A0char *strncpy(char *dest, const char *src, size_t n);
>>>
>>> So in both cases, dest and src are the first and second parameters,
>>> which looks more consistent.
>>
>> Well, nothing is set in stone. There are always exceptions if it
>> really makes sense. If you are designing a function patterned after
>> strcpy or whatever, making it "look like" strcpy probably makes a lo=
t
>> of sense.
>>
>>>
>>> And there's also the case of using default values, which usually
>>> (though not always) applies to the input parameters. Enforcing stri=
ct
>>> input before output ordering wouldn't work there.
>>
>> Well, the Google document says not to use default parameters because
>> "they obscure the interface."
>> So that is a non-issue.
>>
>> Check out commit 6e2b594b3329cb08bf54cd325776b236f2e6c4f1 for an
>> example of how default parameters can really bite.
>>
>
> The same goes here. Default parameters *may* bite, yes. But they're
> also an important tool that can ease up development and make code loo=
k
> much more concise and readable.

I want to quote the discussion included in the Google coding standard
here, because it's very well-thought-out:
> Pros:
> Often you have a function that uses lots of default values, but
> occasionally you want to override the defaults. Default parameters al=
low
> an easy way to do this without having to define many functions for th=
e
> rare exceptions.
>
> Cons:
> People often figure out how to use an API by looking at existing code=
 that
> uses it. Default parameters are more difficult to maintain because
> copy-and-paste from previous code may not reveal all the parameters.
> Copy-and-pasting of code segments can cause major problems when the
> default arguments are not appropriate for the new code.
>
> Decision:
> Except as described below, we require all arguments to be explicitly
> specified, to force programmers to consider the API and the values th=
ey
> are passing for each argument rather than silently accepting defaults=
 they
> may not be aware of.

On Wed, Jul 13, 2011 at 11:59 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> As usual, I don't think that
> restricting your use of the language because of potential errors is
> the better idea. And please, please don't add a compile flag that'll
> prevent it.

The whole point of coding standards is to restrict your use of the
language to prevent potential errors. Obviously, we don't want the
standard to be too rigid. But dismissing the idea of a standard is not
helpful.

regards,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
