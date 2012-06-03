From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: How will Ceph cope with a failed Journal device?
Date: Sun, 3 Jun 2012 12:26:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206021049430.358@Psilocybe.Update.UU.SE>
References: <2465580.E9977TXsHv@pc10> <CADxhoDTe5mO5-pAzBoZYesCw8MV4TUUzBCYMmmwPfKU4otTrNg@mail.gmail.com>
 <CADvuQREBg4GfouqSVTmBXaTRTfoDSuvZdhMK7MdperStT4Utqw@mail.gmail.com>
 <Pine.LNX.4.64.1206011326020.358@Psilocybe.Update.UU.SE>
 <CADvuQRF51pSL2+pQFn3HO6A_BFqmic-NAXa8gyrwfHEWkTgY2g@mail.gmail.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:39572 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2FCK0P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Jun 2012 06:26:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id 71D7F3002F
	for <ceph-devel@vger.kernel.org>; Sun,  3 Jun 2012 12:26:12 +0200 (CEST)
In-Reply-To: <CADvuQRF51pSL2+pQFn3HO6A_BFqmic-NAXa8gyrwfHEWkTgY2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, 1 Jun 2012, Tommi Virtanen wrote:

> The problem with storing things in RAM is, what if your rack/row/data
> center loses power, all at once. It's really hard to guard against
> those kinds of massive failures. If you don't have a persistent
> journal, you might as well not have a journal at all.

The storage nodes can be put in different data centers with different 
kinds of uninterruptable power, from emergency power (diesel backed up 
batteries) to a small UPS (batteries) for individual nodes. This would 
hopefully give Ceph enough time to write down the journal to disk.

I am not sure that using for example battery backed up hardware raid cards 
would give better performance and reliability for the same money. 
Especially if existing infrastructure may be used for uninterruptable 
power. That would be interesting to figure out.

> The memory-only systems you see out there are typically only used to
> the kinds of applications where rolling back to last (on-disk)
> snapshot is acceptable -- stuff like shopping carts. Ceph is built on
> significantly stronger promises, so it's not the ideal match for an
> architecture like that.

I will begin with rsyncing disk backups there and maybe use it for 
temporary but fast storage. Rolling back to a consistent state some 
(shorter) time ago would be fine. If Ceph itself is stable it could later 
be used for data that cannot so easily be recreated.

It would be great to be able for individual users and existing 
applications to use the data directly from Ceph and old snapshots there 
instead of having to read back the data from Ceph into a normal file 
server by a system administrator.

> It's also unclear to me on what would happen to Ceph if all the
> replicas lost their journals at the same time. That might cause bigger
> problems, since there's no up to date replica to pull the lost data
> from.

It would be very interesting to know what would happen.

--jerker
