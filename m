From: Sage Weil <sage@newdream.net>
Subject: Re: VLA detection ...
Date: Sun, 4 Jun 2017 18:28:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706041826470.3646@piezo.novalocal>
References: <174f417f-02f5-beb1-0f8b-96ff4a70349b@digiware.nl> <CAJE9aONhiWL+gHMKaeeg95mnSpua+DeDbArks+O=okKDh3k=YQ@mail.gmail.com> <5b4dd43f-5e9f-ca46-2448-8147a1615921@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44855 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdFDS2E (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jun 2017 14:28:04 -0400
In-Reply-To: <5b4dd43f-5e9f-ca46-2448-8147a1615921@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: kefu chai <tchaikov@gmail.com>, Jesse Williamson <jwilliamson@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 4 Jun 2017, Willem Jan Withagen wrote:
> On 04/06/2017 05:28, kefu chai wrote:
> > On Sat, Jun 3, 2017 at 2:50 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> >> Hi,
> >>
> >> Now that we have -Wvla set:
> >> ===
> >>     Adds C++ warning flag for C Variable-Length Arrays.
> >>
> >>     C VLAs are not supported in C++. However, the GNU compiler allows
> >>     them as an extension, which it does not warn about when not in
> >>     pedantic mode. Unfortunately, it's easy to accidentally write
> >>     a VLA, even unintentionally-- adding this warning will help us
> >>     catch that.
> >> ===
> >>
> >> Are there going to be attempts to eradicate this usage?
> >> Note that Clang also supports VLAs:
> >> ===
> >> GCC and C99 allow an array's size to be determined at run time. This
> >> extension is not permitted in standard C++. However, Clang supports such
> >> variable length arrays for compatibility with GNU C and C99 programs.
> >> ===
> >>
> > 
> > it's not in C++11 standard. but it's a handy feature in practice. i
> > still have trouble understanding we want to have -Wvla. i was trying
> > to silence this warning option last night but failed to move further
> > after several attempts. see https://github.com/ceph/ceph/pull/15441.
> > 
> > probably, Jesse have more insights on this.
> 
> It starts with old discussions from before 2009, and it would be hard
> for compiler makers to actually build it.
> 
> Both GCC and Clang support it.
> 
> And next the major complaint I find about it, is that these structures
> are build on the stack, which might cause stackoverlows (and that mostly
> on embedded computers) That would be something for programmers to be
> aware of.

I'd consider this a feature more than a risk.  It means we can 
allocate a modest-sized array without hitting the allocator.  My vote 
is to just revert -Wvla...

> I would probably think there are beter things to do, than to chase after
> this. And IMHO the order should have been: Fix the VLAs and only then
> turn the warning on on the master repo. As to not have every body start
> looking at these warning that have just started to pop up. But perhaps
> that is just me, because each and every warning is again a case where I
> need to look for possible incompatabilities.

Yep, my bad for assuming the cleanup was already done (or trivial)!

sage
