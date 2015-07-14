From: Sage Weil <sweil@redhat.com>
Subject: Re: Client: what is supposed to protect racing readdirs and
 unlinks?
Date: Tue, 14 Jul 2015 12:18:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507141216510.8849@cobra.newdream.net>
References: <CAC6JEv9VFv2ywGLOfHpcW=yodWCX_VMX22YMFvjnqQhsrfCJdg@mail.gmail.com> <alpine.DEB.2.00.1507141134000.8878@cobra.newdream.net> <CAC6JEv9i2J_XAyDdWZRe1RsN9VNaikaKtBiAYMb_YEvRSV3w0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1185338307-1436901539=:8849"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34294 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbbGNTTA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Jul 2015 15:19:00 -0400
In-Reply-To: <CAC6JEv9i2J_XAyDdWZRe1RsN9VNaikaKtBiAYMb_YEvRSV3w0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, =?GB2312?B?0c/V/Q==?= <zyan@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1185338307-1436901539=:8849
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Jul 2015, Gregory Farnum wrote:
> The following dentry. When it gets unlinked it also gets removed from the
> xlist we're using to traverse the directory contents. We could add some kind
> of refcounting to try and make it do a NULL or similat but I don't think
> anything like that exists yet.

Yeah that sounds likely.  I think that's the fix, though.. and I have some 
recollection of conditions where we favor making the dentry null instead 
of removing it, so hopefully it's not to involved.

It's probably a better behavior anyway for caching reasons, in case the 
directory isn't complete?

> (Sorry this is probably going to get bounced from the list, I'm on my phone
> and haven't found an html-free way to send from it...)

My reply should go through at least :)

sage

> 
> 
> On Tue, Jul 14, 2015, 7:36 PM Sage Weil <sweil@redhat.com> wrote:
>       On Tue, 14 Jul 2015, Gregory Farnum wrote:
>       > I spent a bunch of today looking at
>       http://tracker.ceph.com/issues/12297.
>       >
>       > Long story short: the workload is doing a readdir at the same
>       time as
>       > it's unlinking files. The readdir functions (in this case,
>       > _readdir_cache_cb) drop the client_lock each time they invoke
>       the
>       > callback (for obvious reasons). There is some effort in
>       > _readdir_cache_cb to try and keep the iterator valid (we check
>       on each
>       > loop that we aren't at end; we increment the iterator before
>       dropping
>       > the lock), but it's not sufficient.
>       >
>       > Is there supposed to be something preventing this kind of
>       race? If not
>       > I can work something out in the code but I've not done much
>       work in
>       > that bit and there are enough pieces that I wonder if I'm
>       missing some
>       > other issue.
> 
>       What is the race you're worried about?  Unlinking the file that
>       we're
>       doing the callback on, or the one that follows it (where the
>       iterator now
>       points)?
> 
>       My guess is that in this case unlink should see that there is a
>       reference
>       on the dentry and should make it NULL instead of unlinking it
>       from the
>       directory entirely...
> 
>       sage
> 
> 
> 
--557981400-1185338307-1436901539=:8849--
