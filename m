From: Sage Weil <sweil@redhat.com>
Subject: Re: zero-copy questions
Date: Tue, 2 Feb 2016 13:54:03 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602021352290.28963@cpach.fuggernut.com>
References: <4EE3C658-7FFB-4BE8-9BDD-F0543D24196A@ebay.com> <CAJ4mKGZuYkCV2W+-H9Qi--i3JAUraBjtyA52LVd5h02+AkJcxQ@mail.gmail.com> <E80AF9AC-F42C-4B83-9897-3FDD09C52AAB@ebay.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2044788759-1454439245=:28963"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933218AbcBBSxs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Feb 2016 13:53:48 -0500
In-Reply-To: <E80AF9AC-F42C-4B83-9897-3FDD09C52AAB@ebay.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Snyder, Emile" <emsnyder@ebay.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2044788759-1454439245=:28963
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 2 Feb 2016, Snyder, Emile wrote:
> On 2/2/16, 10:23 AM, "Gregory Farnum" <gfarnum@redhat.com> wrote:
> 
> >On Tue, Feb 2, 2016 at 10:06 AM, Snyder, Emile <emsnyder@ebay.com> wrote:
> >> Hi all,
> >>
> >> I was wondering if anyone had any insights as to the status of http://tracker.ceph.com/projects/ceph/wiki/Zero-copy_bufferlists? Poking around in the buffer code I see that there is some code there to handle zero copy with buffer::raw, but that it's disabled (the if (false && read_fd_zero_copy(fd, len) == 0) in buffer::list::read_fd), and that the read path for osd's using FileStore doesn't appear to go through buffer anyway (FileStore::read uses safe_pread)
> >>
> >>
> >>
> >> Was this direction determined to not be worth it, or is it just that no one has had the time to keep pursuing it?
> >
> >I didn't do any of this work, but I think there ended up being (a) not
> >enough time available, and (b) some issue with using pipes as
> >described there — the overhead was too high for the typical amount of
> >memory we use in a buffer, maybe? Or we were just trying to allocate
> >too many pipes for the kernel to handle well, or for us to handle, or
> >something.
> 
> Ah, thanks, I was wondering about the effect of all the requied ::pipe() 
> calls.

The other thing is that the new bluestore OSD backend won't use the page 
cache (in general), which means the only potential win we'd get is when we 
forward buffers to replicas.

sage
--8323329-2044788759-1454439245=:28963--
