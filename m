From: Sage Weil <sage@newdream.net>
Subject: Re: ceph_setattr mask
Date: Tue, 14 Feb 2012 09:03:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202140902450.1554@cobra.newdream.net>
References: <C5CEE4B7-2D43-48F4-B741-8AB23C62D039@cs.ucsc.edu>
 <CAF3hT9A-n9yVWQExONF2T0ODwZRLeoVe6bi3qTFY9EEGeWBv+A@mail.gmail.com>
 <6E946A5C-EC6F-4D3F-9D37-1CA6A640AF55@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50983 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab2BNRDc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 12:03:32 -0500
In-Reply-To: <6E946A5C-EC6F-4D3F-9D37-1CA6A640AF55@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Tue, 14 Feb 2012, Noah Watkins wrote:
> On Feb 14, 2012, at 8:50 AM, Gregory Farnum wrote:
> > You're right, those flags are only specified in ceph_fs.h. I don't
> > think it's appropriate to include that file in user-facing stuff as
> > it's mostly things that I'd consider to be Ceph internals, but the
> > CEPH_SETATTR_* stuff is obviously public since you need them for
> > ceph_setattr. My inclination would be to either move or duplicate them
> > into a header that's already installed, but I'm not sure which one is
> > best for that. Do you have any thoughts as a user? :)
> 
> java-libcephfs has a build dependency on libcephfs-dev deb that only 
> contains libcephfs.h. These flags must be available during build and it 
> seems to make little sense to add another header just for these bits. So 
> as far as moving vs copying I'm not sure, but exposing all of ceph_fs.h 
> seems like overkill.

The simplest thing is to probably duplicate them (with an #ifndef guard) 
in libcephfs.h.  I'll push something to do that now.

> Related:  does Ceph re-use the POSIX bit masks for mode_t?

Yep!

sage
