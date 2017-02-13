From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: Breakage in Clang compile....
Date: Mon, 13 Feb 2017 15:55:34 -0500
Message-ID: <8483843f-0b6d-54f3-9265-8fc7c9bebfe3@redhat.com>
References: <a5a35bfc-57b2-bf28-9788-04127654e23a@digiware.nl>
 <E5D4D9AF-0529-424A-9C75-759906A4C65D@quantum.com>
 <28691041-11fc-bd69-2d0b-1986fa798aca@digiware.nl>
 <CACKY0b_pZXyJO1fQn9hrqJw5JYT_x932YkCYZv3miFZOks9vJw@mail.gmail.com>
 <CAF-wwdFushwATp88GxKAJfZpiB+ZSf6Q7iQa5mAKjKeEetMO0g@mail.gmail.com>
 <32db5fd3-a02a-1f4d-9e28-674280fa071c@corp.ovh.com>
 <4cb44f22-9c7e-1266-df20-b53f11e377ec@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbdBMUzh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Feb 2017 15:55:37 -0500
In-Reply-To: <4cb44f22-9c7e-1266-df20-b53f11e377ec@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Bassam Tabbara <bassam.tabbara@quantum.com>, Ceph Development <ceph-devel@vger.kernel.org>, =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>, Brad Hubbard <bhubbard@redhat.com>, liuchang0812 <liuchang0812@gmail.com>

On 02/13/2017 05:20 AM, Willem Jan Withagen wrote:
> On 13-2-2017 10:26, Bartłomiej Święcki wrote:
> > Hi,
> >
> > What I usually hear in gcc vs comparisons is that clang does not yet
> > optimize the code as good gcc
> > (fun fact: sometimes that's because it's more standards conformant).
> > Nevertheless, it's always
> > a good idea to compile the code with as many compilers as possible -
> > that way more meaningful warnings
> > could be found. An example - when I was compiling the patch, clang has
> > found this:
> >
> > /builds/ceph-histograms/src/include/denc.h:1160:10: warning: binding
> > dereferenced null pointer to reference has undefined behavior
> > [-Wnull-dereference]
> >     denc(*(bool *)nullptr, p);
> >          ^~~~~~~~~~~~~~~~
> >
> > And I strongly believe we should get rid of it - dereferencing null
> > pointer in C++ is undefined
> > behavior so the compiler can do whatever he wants there. Even if it
> > works with current gcc,
> > more aggressive optimizations added to compilers in the future could
> > make this totally broken.
> >
> > I've observed it's a common practice in many companies to develop using
> > clang (to get
> > best diagnostic and tools) but do the final release using gcc (to get
> > the best performance).
> > I also like clang for the number of tools built on top of clang - static
> > analyzers, sanitizers,
> > code formatting etc. Chandler Carruth from Goggle has given some nice
> > talks about this:
> > https://youtu.be/cX_GhJ6BuWI, https://youtu.be/E36BUcTWo50.
>
> Hi Bartek,
>
> What you found is also what I found. And I agree with the fact that it
> needs fixing.... Am not even sure what a dereferenced null-pointer
> should actually generate as value?
>
> We have fixed similar issues at several places already where it
> generated errors. Here it is a warning, so I can sort of live with it
> because I can continue my porting/testing work.
>
> So if you have suggestions, I very sure that they will get happily
> accepted. And I can and will test and support getting these fixes in.
>
> Using GCC on FreeBSD is no longer the preferred way of doing things.
> Also are all packages compiled with Clang, so best to use those with the
> Clang compiler.
> And modern releases of GCC are all in ports and are not free of pesky
> conflicts with the installed base.
>
> Thanx,
> --WjW

That issue has two PRs devoted to two spots in the code where it comes up:

	https://github.com/ceph/ceph/pull/12796
	https://github.com/ceph/ceph/pull/12931

gcc with a high enough optimization level (1 is sufficient, I think)
takes that code out if it's never referenced, as it should not be. But
when optimizations are turned off (-O0) it results in a runtime error.
That makes it difficult to run under gdb with optimizations off.

That code is there to generate a runtime error, much like an assert,
when other code is doing something it should not. But it depends on
optimization for it to work correctly under gcc.

It seems that PR 12796 is a workaround that undermines the attempt to
flag bad code.

I'm encouraged by Adam Emerson's PR (12931), though.

Eric
