From: Sage Weil <sage@newdream.net>
Subject: Re: coding style document
Date: Wed, 13 Jul 2011 15:28:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107131518300.11118@cobra.newdream.net>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
 <CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
 <CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
 <CA+qbEUOvPqv8r1+LG5ygi8dH5-Cw0+FJnVsnSfamW0N6R1kkUA@mail.gmail.com>
 <CAC-hyiE9XDTE99wox3e3-hL+eF40TyRUhfJ=kv4R_UtZcggG+g@mail.gmail.com>
 <CA+qbEUO9XRPaWnSjv3Exh1TppD7OLNZa=TsZdQKyju+G07x_Bg@mail.gmail.com>
 <CAC-hyiEx2itZ5_RtZ1XhPsPtnF7w0aockQ9+5ZDnzUGooVVdqA@mail.gmail.com>
 <CA+qbEUM7HPo9DdjyS_7Dnmq74u_gKVCJjXEf8G=_VVfiX_sJ-Q@mail.gmail.com>
 <CAC-hyiFxqSEVm5r54hitYWNaHr3DMZ1jyC4FdnCPVDqgFWdULQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46724 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab1GMWZE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 18:25:04 -0400
In-Reply-To: <CAC-hyiFxqSEVm5r54hitYWNaHr3DMZ1jyC4FdnCPVDqgFWdULQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Colin Patrick McCabe <colin.mccabe@dreamhost.com>, ceph-devel@vger.kernel.org

Let's try to keep this out of the weeds...

In both these cases, I'm talking about setting guidelines to make new code 
reasonably consistent, not blindly fixing up old code.  The old code is 
sufficiently inconsistent (at least with respect to member names) I don't 
think there any reason not to pick something good going forward.

I kind of hate the _ suffix.  The m_ prefix is a bit better.  I'm inclined 
to say it's worth it.  At least for complex classes.. not so much for 
the simple structs.  Does that distinction between simple and complex 
structs/classes make sense?

I buy Google's default value argument, at least as a rule of thumb.  At 
least most of the places I've used them are probably better off without.

sage



On Wed, 13 Jul 2011, Yehuda Sadeh Weinraub wrote:

> On Wed, Jul 13, 2011 at 2:36 PM, Colin Patrick McCabe
> <colin.mccabe@dreamhost.com> wrote:
> > On Wed, Jul 13, 2011 at 1:25 PM, Yehuda Sadeh Weinraub
> > <yehudasa@gmail.com> wrote:
> >> On Wed, Jul 13, 2011 at 12:54 PM, Colin Patrick McCabe
> >> <colin.mccabe@dreamhost.com> wrote:
> >>> On Wed, Jul 13, 2011 at 11:59 AM, Yehuda Sadeh Weinraub
> >>> <yehudasa@gmail.com> wrote:
> >>>> On Wed, Jul 13, 2011 at 11:21 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> >>>>> On Wed, Jul 13, 2011 at 10:52 AM, Yehuda Sadeh Weinraub
> >>> [snip class variable naming discussion]
> >>>
> >>> You seem to have two objections to the proposed naming. One is that
> >>> you don't like the trailing underscore. That is fine-- I like the "m_"
> >>> prefix better myself.
> >>>
> >>> The second is that you don't want "mixed code." I really don't
> >>> understand this objection. We have "mixed code" right now... there are
> >>> some classes currently use m_ prefixes, some that use underscore
> >>> prefixes, and some that use none of the above. There are some people
> >>> using the exact same variable names for class variables and local
> >>> variable names-- like the example that I gave-- and relying on the C++
> >>> shadowing rules. I don't see how any reasonable person can read that
> >>> kind of code and not feel confused and frustrated.
> >>
> >> Hmm.. I might have not been clear enough. I said that introducing this
> >> now won't fix anything as we have enough code that doesn't follow
> >> these rules to dim it ineffective. Moreover, introducing it now as a
> >> rule, will just add further confusion for people who'd read the code
> >> and assume certain things about the coding style.
> >
> > You just need a tool that understands C++ to do the renaming. I think
> > eclipse's "rename variable" function might be able to fix pretty
> > quickly. I also predict that we would uncover some actual errors this
> > way by eliminating the confusion between local variables and class
> > variables.
> >
> > We were trying to do the same thing with -Wshadow a while ago, but we
> > got bogged down because that compiler warning included a lot of
> > unecessary stuff not directly related to variables.
> 
> Swiping changes tend to have unexpected results. I'd avoid doing
> anything like that.
> 
> >
> >>
> >>>>
> >>>> The same goes here. Default parameters *may* bite, yes. But they're
> >>>> also an important tool that can ease up development and make code look
> >>>> much more concise and readable.
> >>>
> >>> I want to quote the discussion included in the Google coding standard
> >>> here, because it's very well-thought-out:
> >>>> Pros:
> >>>> Often you have a function that uses lots of default values, but
> >>>> occasionally you want to override the defaults. Default parameters allow
> >>>> an easy way to do this without having to define many functions for the
> >>>> rare exceptions.
> >>>>
> >>>> Cons:
> >>>> People often figure out how to use an API by looking at existing code that
> >>>> uses it. Default parameters are more difficult to maintain because
> >>>> copy-and-paste from previous code may not reveal all the parameters.
> >>>> Copy-and-pasting of code segments can cause major problems when the
> >>>> default arguments are not appropriate for the new code.
> >>
> >> Sorry, it didn't convince me. Copy and pasting of code segments can
> >> cause other major problems not related to default parameters.
> >
> > If you have two code segments that perform the same task, and one of
> > them requires a lot of context to understand, and the other requires
> > very little, the second one is the better code.
> 
> I'd argue that code aesthetics has a not-less-important value too.
> Adding strange variable names, and/or having longer function calls due
> to default avoidance impairs that.
> 
> >
> > This is the same reason why unecessary global variables and global
> > state are bad. It's the same reason why poorly documented code is bad.
> > The harder it is to understand what is going on, the worse it is.
> 
> Life is not black and white, so is coding. If you see everything in
> dichotomy, you end up impractically and blindly following rules you
> don't understand the reasoning behind them.
> 
> >
> > Secondly... let the programmer who has never copied and pasted, throw
> > the first stone. I'm sure that it won't be either of us.
> 
> I'd take the word of a person that never did that with a grain of salt
> as he obviously hasn't done much actual development.
> 
> 
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
