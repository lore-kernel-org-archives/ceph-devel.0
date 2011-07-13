From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 13:25:17 -0700
Message-ID: <CAC-hyiEx2itZ5_RtZ1XhPsPtnF7w0aockQ9+5ZDnzUGooVVdqA@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
	<CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
	<CA+qbEUOvPqv8r1+LG5ygi8dH5-Cw0+FJnVsnSfamW0N6R1kkUA@mail.gmail.com>
	<CAC-hyiE9XDTE99wox3e3-hL+eF40TyRUhfJ=kv4R_UtZcggG+g@mail.gmail.com>
	<CA+qbEUO9XRPaWnSjv3Exh1TppD7OLNZa=TsZdQKyju+G07x_Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56177 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab1GMUZT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 16:25:19 -0400
Received: by bwd5 with SMTP id 5so4965138bwd.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 13:25:17 -0700 (PDT)
In-Reply-To: <CA+qbEUO9XRPaWnSjv3Exh1TppD7OLNZa=TsZdQKyju+G07x_Bg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 13, 2011 at 12:54 PM, Colin Patrick McCabe
<colin.mccabe@dreamhost.com> wrote:
> On Wed, Jul 13, 2011 at 11:59 AM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>> On Wed, Jul 13, 2011 at 11:21 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
>>> On Wed, Jul 13, 2011 at 10:52 AM, Yehuda Sadeh Weinraub
> [snip class variable naming discussion]
>
> You seem to have two objections to the proposed naming. One is that
> you don't like the trailing underscore. That is fine-- I like the "m_"
> prefix better myself.
>
> The second is that you don't want "mixed code." I really don't
> understand this objection. We have "mixed code" right now... there are
> some classes currently use m_ prefixes, some that use underscore
> prefixes, and some that use none of the above. There are some people
> using the exact same variable names for class variables and local
> variable names-- like the example that I gave-- and relying on the C++
> shadowing rules. I don't see how any reasonable person can read that
> kind of code and not feel confused and frustrated.

Hmm.. I might have not been clear enough. I said that introducing this
now won't fix anything as we have enough code that doesn't follow
these rules to dim it ineffective. Moreover, introducing it now as a
rule, will just add further confusion for people who'd read the code
and assume certain things about the coding style.

>>
>> The same goes here. Default parameters *may* bite, yes. But they're
>> also an important tool that can ease up development and make code look
>> much more concise and readable.
>
> I want to quote the discussion included in the Google coding standard
> here, because it's very well-thought-out:
>> Pros:
>> Often you have a function that uses lots of default values, but
>> occasionally you want to override the defaults. Default parameters allow
>> an easy way to do this without having to define many functions for the
>> rare exceptions.
>>
>> Cons:
>> People often figure out how to use an API by looking at existing code that
>> uses it. Default parameters are more difficult to maintain because
>> copy-and-paste from previous code may not reveal all the parameters.
>> Copy-and-pasting of code segments can cause major problems when the
>> default arguments are not appropriate for the new code.

Sorry, it didn't convince me. Copy and pasting of code segments can
cause other major problems not related to default parameters.

> On Wed, Jul 13, 2011 at 11:59 AM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>> As usual, I don't think that
>> restricting your use of the language because of potential errors is
>> the better idea. And please, please don't add a compile flag that'll
>> prevent it.
>
> The whole point of coding standards is to restrict your use of the
> language to prevent potential errors. Obviously, we don't want the
> standard to be too rigid. But dismissing the idea of a standard is not
> helpful.
>

The standard contains much more than the 3 or 4 items that I pointed
at. If any, enforcing a standard without a firm *practical* reasoning
is not helpful either.
Sometimes a rule of thumb is just a rule of thumb, turning it into an
enforced standard is, IMO, one step too far.
Don't take me wrong here. I care about errors prevention and
preemption as much as you do. However, I think there are better things
that we should focus our efforts on.

Yehuda
