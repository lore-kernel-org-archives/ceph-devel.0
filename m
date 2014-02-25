From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/6] libceph: add support for CEPH_OSD_OP_SETALLOCHINT
 osd op
Date: Tue, 25 Feb 2014 09:12:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402250911020.5145@cobra.newdream.net>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com> <1393008946-7931-3-git-send-email-ilya.dryomov@inktank.com> <530B5E36.4030200@ieee.org> <CALFYKtBkQWkiHnA28xOs-NjBH-5F9ohZ8mR-C+kOkAc=SrA7uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35847 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbaBYRMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 12:12:06 -0500
In-Reply-To: <CALFYKtBkQWkiHnA28xOs-NjBH-5F9ohZ8mR-C+kOkAc=SrA7uA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 25 Feb 2014, Ilya Dryomov wrote:
> >> +                     u64 expected_write_size;
> >
> > Probably the same thing here, a byte might be enough
> > to encode this by using log2(expected_write_size).
> >
> >> +                     __u8 expected_size_probability;
> 
> I think in the interest of genericity expected_object_size should be an
> arbitrary, not limited to a power-of-2 value.  Now, given the current
> 90M object size limit 64 bits might seem a lot, but extent offset and
> length are 64 bit values and to be future-proof I followed that here.
> 
> expected_size_probability is currently unused.  It was supposed to be
> a 0-100 value, indicating whether we expect the object to be smaller
> than expected_object_size or not and how strong that expectation is.
> 
> I'm not sure if you've seen it, but this (both userspace and kernel
> sides) were implemented according to the design laid out by Sage in the
> "rados io hints" thread on ceph-devel about a month ago.  There wasn't
> any discussion that I'm aware of in the interim, that is until the
> recent "wip-hint" thread, which was triggered by my PR.
> 
> >
> > I'm not sure why these single-byte values use __u8 while the
> > multi-byte values use (e.g.) u32.  The leading underscores
> > are supposed to be used for values exposed to user space (or
> > something like that).  Anyway, not a problem with your change,
> > but something maybe you could check into.
> 
> I'm not sure either.  I vaguely assumed it's related to the fact that
> single-byte ceph_osd_req_op fields are directly assigned to the
> corresponding ceph_osd_op fields which are exported to userspace,
> whereas the multi-byte values go through the endianness conversion
> macros, which change the type to __le*.

Oh, good catch.  Yeah, these need to be __le64 so that on the kernel side 
sparse knows what is going on and so on the userspace side the magic __le* 
classes do the endian conversion.

sage
