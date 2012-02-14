From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: ceph_setattr mask
Date: Tue, 14 Feb 2012 09:00:37 -0800
Message-ID: <6E946A5C-EC6F-4D3F-9D37-1CA6A640AF55@cs.ucsc.edu>
References: <C5CEE4B7-2D43-48F4-B741-8AB23C62D039@cs.ucsc.edu> <CAF3hT9A-n9yVWQExONF2T0ODwZRLeoVe6bi3qTFY9EEGeWBv+A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:45661 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758179Ab2BNRAt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 12:00:49 -0500
In-Reply-To: <CAF3hT9A-n9yVWQExONF2T0ODwZRLeoVe6bi3qTFY9EEGeWBv+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org


On Feb 14, 2012, at 8:50 AM, Gregory Farnum wrote:

> 
> You're right, those flags are only specified in ceph_fs.h. I don't
> think it's appropriate to include that file in user-facing stuff as
> it's mostly things that I'd consider to be Ceph internals, but the
> CEPH_SETATTR_* stuff is obviously public since you need them for
> ceph_setattr. My inclination would be to either move or duplicate them
> into a header that's already installed, but I'm not sure which one is
> best for that. Do you have any thoughts as a user? :)

java-libcephfs has a build dependency on libcephfs-dev deb that only contains libcephfs.h. These flags must be available during build and it seems to make little sense to add another header just for these bits. So as far as moving vs copying I'm not sure, but exposing all of ceph_fs.h seems like overkill. Related:  does Ceph re-use the POSIX bit masks for mode_t?

-Noah