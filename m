From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Bobtail vs Argonaut Performance Preview
Date: Thu, 27 Dec 2012 23:17:41 +0100
Message-ID: <50DCC905.7000106@profihost.ag>
References: <CAP8Oy=J6kazDvT6woLZZ3v+XVrzhKbHgO1wgyoTU8OCKq2qDEg@mail.gmail.com> <20121222083200.GA1977@infradead.org> <50D5B769.4090104@inktank.com> <20121222184508.GA32567@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60536 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab2L0WRr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 17:17:47 -0500
In-Reply-To: <20121222184508.GA32567@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mark Nelson <mark.nelson@inktank.com>, Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>

Hi Christoph,
Am 22.12.2012 19:45, schrieb Christoph Hellwig:
> You're defintively missing the "inode64" mount option, which we've
> always recommended, and which finally made it to be the default in
> Linux 3.7.
>
> Some other things worth playing with, but which aren't guaranteed to
> be a win are:
>
>   - use a larger than default log size (e.g. mkfs.xfs -l size=2g)
>   - use large directory blocks, similar to what you already do for btrfs
>     (mkfs.xfs -n size=16k or 64k)
Thanks for recommendations.

Right now i'm using this in my ceph setup with 240GB SSDs for each OSD. 
May i ask you to comment them? Do they make sense in your eyes?

# i have 12 cores per machine
mkfs.xfs -f -d agcount=12 /dev/sdX2

Mount options: noatime,nodiratime,nobarrier,logbsize=256k,logbufs=8,inode64

Greets,
Stefan
