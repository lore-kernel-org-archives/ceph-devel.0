From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Thu, 26 May 2016 12:54:27 -0700
Message-ID: <CA+55aFygBAq19UXECwQf_crUqNH4btTDircZJ=CctAHtFhnexw@mail.gmail.com>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com>
	<CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com>
	<alpine.DEB.2.11.1605261446230.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34121 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298AbcEZTy2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2016 15:54:28 -0400
In-Reply-To: <alpine.DEB.2.11.1605261446230.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 26, 2016 at 12:02 PM, Sage Weil <sweil@redhat.com> wrote:
>
> The branch was assembled in its current form yesterday and is included in
> today's -next:

So that's what I *don't* want, and it's not the point of "next".

The next branch is about the *next* merge window. If it was about the
current one, it would be called "linux-current".

It's not just about merge conflicts and integration - it's also about
showing that your code is ready. Having the branch being created the
day before would be much more palatable if we were talking about the
first few days of the merge window. As it is, we're in the latter part
of the second week of the merge window, and I get a very strong
feeling that it wasn't ready for the merge window, and that it was set
up in a hurry because it was getting to the last two working days.

And again, it's called the *merge* window, not the *development*
window. It's not that the two weeks is where the work is supposed to
be done, it's when things get merged. Right now I'm in the mode where
I was planning to look at some of the older pulls that I didn't do
earlier because I felt I wanted to take a second look (in particular,
I have two DAX pull requests that I am getting back to). And I'm
starting to already see pull requests for *fixes* for things I pulled
earlier in the merge window. That makes me go "good, people are
already using it and finding problems, we're starting to move from
just integration to fixing things up".

Having entirely new pull requests show up that haven't even been on my
radar because they weren't in linux-next is annoying.

And yes, I've started to become stricter about these issues, because
it turns out that the whole linux-next process has worked fairly well.
It allows developers to see what the potential problem spots can be,
but it also allows me to see what I can expect during the merge
window. And the "it's been in next for a while" really does give me
the warm and fuzzies. Admittedly very few people actually *run* and
actually test next kernels, but there's a couple who do, and even
without that it does tend to get not just build coverage for odd
configurations, but there are now several boot farms too, so it does
add value.

If your patch series had been "90% of it has been in -next since
before the merge window even opened, and 10% are clearly new things
that came in later", that would be one thing. That's perfectly normal
- last-minute fixes etc, possibly for stuff that was _found_ because
it was in linux-next.

But it was *all* from the last day, and I don't see anything at all in
my next tree (which I tend fetch at the end of the first week, exactly
to get a feel for "ok, so who/what am I still looking to get").

And yes, Ceph is pretty standalone and the boot farms likely don't
trigger any ceph testing, and the build coverage is probably pretty
configuration-independent (with architecture header file differences
likely being the biggest issue, and unlikely to happen to bite *only*
ceph), so you can always argue that linux-next isn't really all that
big of a deal for Ceph at least wrt coverage. But that can be argued
individually for almost _any_ subsystem. None of them are all that
likely to have problems individually. It's just that once you have
lots of different subsystems, not only do they interact, but enough of
those "very unlikely to have problems" on their own tends to become
"it's likely that _one_ of them ended up causing a problem anyway".

                  Linus
