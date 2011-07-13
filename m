From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 14:36:50 -0700
Message-ID: <CA+qbEUM7HPo9DdjyS_7Dnmq74u_gKVCJjXEf8G=_VVfiX_sJ-Q@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
	<CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
	<CA+qbEUOvPqv8r1+LG5ygi8dH5-Cw0+FJnVsnSfamW0N6R1kkUA@mail.gmail.com>
	<CAC-hyiE9XDTE99wox3e3-hL+eF40TyRUhfJ=kv4R_UtZcggG+g@mail.gmail.com>
	<CA+qbEUO9XRPaWnSjv3Exh1TppD7OLNZa=TsZdQKyju+G07x_Bg@mail.gmail.com>
	<CAC-hyiEx2itZ5_RtZ1XhPsPtnF7w0aockQ9+5ZDnzUGooVVdqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38647 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1GMVgx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 17:36:53 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id B0C59C066
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 14:36:53 -0700 (PDT)
Received: from mail-fx0-f52.google.com (mail-fx0-f52.google.com [209.85.161.52])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E10C5C062
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 14:36:52 -0700 (PDT)
Received: by fxd18 with SMTP id 18so6350477fxd.11
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 14:36:50 -0700 (PDT)
In-Reply-To: <CAC-hyiEx2itZ5_RtZ1XhPsPtnF7w0aockQ9+5ZDnzUGooVVdqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 13, 2011 at 1:25 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Wed, Jul 13, 2011 at 12:54 PM, Colin Patrick McCabe
> <colin.mccabe@dreamhost.com> wrote:
>> On Wed, Jul 13, 2011 at 11:59 AM, Yehuda Sadeh Weinraub
>> <yehudasa@gmail.com> wrote:
>>> On Wed, Jul 13, 2011 at 11:21 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
>>>> On Wed, Jul 13, 2011 at 10:52 AM, Yehuda Sadeh Weinraub
>> [snip class variable naming discussion]
>>
>> You seem to have two objections to the proposed naming. One is that
>> you don't like the trailing underscore. That is fine-- I like the "m_"
>> prefix better myself.
>>
>> The second is that you don't want "mixed code." I really don't
>> understand this objection. We have "mixed code" right now... there are
>> some classes currently use m_ prefixes, some that use underscore
>> prefixes, and some that use none of the above. There are some people
>> using the exact same variable names for class variables and local
>> variable names-- like the example that I gave-- and relying on the C++
>> shadowing rules. I don't see how any reasonable person can read that
>> kind of code and not feel confused and frustrated.
>
> Hmm.. I might have not been clear enough. I said that introducing this
> now won't fix anything as we have enough code that doesn't follow
> these rules to dim it ineffective. Moreover, introducing it now as a
> rule, will just add further confusion for people who'd read the code
> and assume certain things about the coding style.

You just need a tool that understands C++ to do the renaming. I think
eclipse's "rename variable" function might be able to fix pretty
quickly. I also predict that we would uncover some actual errors this
way by eliminating the confusion between local variables and class
variables.

We were trying to do the same thing with -Wshadow a while ago, but we
got bogged down because that compiler warning included a lot of
unecessary stuff not directly related to variables.

>
>>>
>>> The same goes here. Default parameters *may* bite, yes. But they're
>>> also an important tool that can ease up development and make code look
>>> much more concise and readable.
>>
>> I want to quote the discussion included in the Google coding standard
>> here, because it's very well-thought-out:
>>> Pros:
>>> Often you have a function that uses lots of default values, but
>>> occasionally you want to override the defaults. Default parameters allow
>>> an easy way to do this without having to define many functions for the
>>> rare exceptions.
>>>
>>> Cons:
>>> People often figure out how to use an API by looking at existing code that
>>> uses it. Default parameters are more difficult to maintain because
>>> copy-and-paste from previous code may not reveal all the parameters.
>>> Copy-and-pasting of code segments can cause major problems when the
>>> default arguments are not appropriate for the new code.
>
> Sorry, it didn't convince me. Copy and pasting of code segments can
> cause other major problems not related to default parameters.

If you have two code segments that perform the same task, and one of
them requires a lot of context to understand, and the other requires
very little, the second one is the better code.

This is the same reason why unecessary global variables and global
state are bad. It's the same reason why poorly documented code is bad.
The harder it is to understand what is going on, the worse it is.

Secondly... let the programmer who has never copied and pasted, throw
the first stone. I'm sure that it won't be either of us.

cheers,
Colin
