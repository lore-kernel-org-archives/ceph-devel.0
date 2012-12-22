From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Bobtail vs Argonaut Performance Preview
Date: Sat, 22 Dec 2012 13:45:08 -0500
Message-ID: <20121222184508.GA32567@infradead.org>
References: <CAP8Oy=J6kazDvT6woLZZ3v+XVrzhKbHgO1wgyoTU8OCKq2qDEg@mail.gmail.com>
 <20121222083200.GA1977@infradead.org>
 <50D5B769.4090104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:47705
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790Ab2LVSpK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 22 Dec 2012 13:45:10 -0500
Content-Disposition: inline
In-Reply-To: <50D5B769.4090104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Christoph Hellwig <hch@infradead.org>, Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>

On Sat, Dec 22, 2012 at 07:36:41AM -0600, Mark Nelson wrote:
> Btw Christoph, thank you for taking the time to read my article.  If
> I've done anything dumb or suboptimal regarding xfs, please do let
> me know.  Soon I will be doing parametric sweeps over ceph parameter
> spaces to see how performance varies on different hardware
> configurations.  I want to make sure the tests are setup as
> optimally as possible.

You're defintively missing the "inode64" mount option, which we've
always recommended, and which finally made it to be the default in
Linux 3.7.

Some other things worth playing with, but which aren't guaranteed to
be a win are:

 - use a larger than default log size (e.g. mkfs.xfs -l size=2g)
 - use large directory blocks, similar to what you already do for btrfs
   (mkfs.xfs -n size=16k or 64k)

Also at least for the benchmarks doing concurrent I/O (or any real life
setup) you're probably much better off with a concatenation than a RAID 0
for the multiple disk setup.

