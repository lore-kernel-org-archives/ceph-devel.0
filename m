From: Martin Millnert <martin@millnert.se>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Mon, 14 Dec 2015 23:02:06 +0100
Message-ID: <1450130526.1035.24.camel@millnert.se>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	 <CAJ4mKGZP3oHt6Rgsp_pogcAZEmBzcQzDc4vzESDjPyoxJKoBUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:57942 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292AbbLNWCK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Dec 2015 17:02:10 -0500
In-Reply-To: <CAJ4mKGZP3oHt6Rgsp_pogcAZEmBzcQzDc4vzESDjPyoxJKoBUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>, Adam Kupczyk <akupczyk@mirantis.com>

On Mon, 2015-12-14 at 12:28 -0800, Gregory Farnum wrote:
> On Mon, Dec 14, 2015 at 5:17 AM, Radoslaw Zarzynski
<snip>
> > In typical case ciphertext data transferred from OSD to OSD can be
> > used without change. This is when both OSDs have the same crypto key
> > version for given placement group. In rare cases when crypto keys are
> > different (key change or transition period) receiving OSD will recrypt
> > with local key versions.
> 
> I don't understand this part at all. Do you plan to read and rewrite
> the entire PG whenever you change the "key version"? How often do you
> plan to change these keys? What is even the point of changing them,
> since anybody who can control an OSD can grab the entire current key
> set?

You may have leaked keys without having leaked ciphertext.
The typical use case for FDE/SED is IMO being able to RMA drives.
Nothing more than that.

> > For compression to be effective it must be done before encryption. Due
> > to that encryption may be applied differently for replication pools
> > and EC pools. Replicated pools do not implement compression; for those
> > pools encryption is applied right after data enters OSD. For EC pools
> > encryption is applied after compressing. When compression will be
> > implemented for replicated pools, it must be placed before encryption.
> 
> So this means you'll be encrypting the object data, but not the omap
> nor xattrs, and not the file names on disk. Is that acceptable to
> people? It's probably fine for a lot of rbd use cases, but not for
> RGW, CephFS, nor raw RADOS where meaningful metadata (and even *data*)
> is stored in those regions. I'd rather a solution worked on the full
> data set. :/
> -Greg

This is indeed the largest weakness of the proposal.

I'm lacking a bit on the motivation for what problem this solution
solves that a dm-crypt-based solution doesn't address? When, except for
snooping, is it a desired design to not encrypt all the things?

I guess one could say: "ciphertext would be transferred on the network".
But, it's incomplete. Internal transport encryption (and better auth)
for Ceph is a different problem.

I'd probably rather dm-crypt key management processes were refined and
improved (saying this without knowing the state of any current
implementations for Ceph), and have a solid FDE solution than a solution
that doesn't encrypt metadata. Only encrypting data but not metadata
isn't sufficient anymore...

/M

