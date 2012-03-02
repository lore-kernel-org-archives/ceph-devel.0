From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 2/2] rbd: small changes
Date: Fri, 02 Mar 2012 15:26:00 -0800
Message-ID: <4F515708.2060005@dreamhost.com>
References: <4F4DA340.3040202@dreamhost.com> <4F4DAB7E.2080308@dreamhost.com> <Pine.LNX.4.64.1203021331390.6413@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60804 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965393Ab2CBX0B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 18:26:01 -0500
In-Reply-To: <Pine.LNX.4.64.1203021331390.6413@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 03/02/2012 01:31 PM, Sage Weil wrote:
>> >  +/*
>> >  + * The basic unit of block I/O is a sector.  It is interpreted in a
>> >  + * number of contexts in Linux (blk, bio, genhd), but the default is
>> >  + * universally 512 bytes.  These symbols are just slightly more
>> >  + * meaningful than the bare numbers they represent.
>> >  + */
>> >  +#define	SECTOR_SHIFT	9
>> >  +#define	SECTOR_SIZE	(1ULL<<  SECTOR_SHIFT)
>> >  +
> I would expect the block layer already has #defines for these?

I would too, but I don't see it.  I think "9" and "512" are
considered obvious enough.

I still prefer this though; if nothing else it makes it easy
to search for places we are using things with this meaning.

					-Alex
