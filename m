From: Sage Weil <sweil@redhat.com>
Subject: Re: Client: what is supposed to protect racing readdirs and
 unlinks?
Date: Tue, 14 Jul 2015 11:36:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507141134000.8878@cobra.newdream.net>
References: <CAC6JEv9VFv2ywGLOfHpcW=yodWCX_VMX22YMFvjnqQhsrfCJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49133 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbbGNSgf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Jul 2015 14:36:35 -0400
In-Reply-To: <CAC6JEv9VFv2ywGLOfHpcW=yodWCX_VMX22YMFvjnqQhsrfCJdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: =?GB2312?B?0c/V/Q==?= <zyan@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 14 Jul 2015, Gregory Farnum wrote:
> I spent a bunch of today looking at http://tracker.ceph.com/issues/12297.
> 
> Long story short: the workload is doing a readdir at the same time as
> it's unlinking files. The readdir functions (in this case,
> _readdir_cache_cb) drop the client_lock each time they invoke the
> callback (for obvious reasons). There is some effort in
> _readdir_cache_cb to try and keep the iterator valid (we check on each
> loop that we aren't at end; we increment the iterator before dropping
> the lock), but it's not sufficient.
> 
> Is there supposed to be something preventing this kind of race? If not
> I can work something out in the code but I've not done much work in
> that bit and there are enough pieces that I wonder if I'm missing some
> other issue.

What is the race you're worried about?  Unlinking the file that we're 
doing the callback on, or the one that follows it (where the iterator now 
points)?

My guess is that in this case unlink should see that there is a reference 
on the dentry and should make it NULL instead of unlinking it from the 
directory entirely...

sage
