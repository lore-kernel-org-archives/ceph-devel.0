From: Dave Chinner <dchinner@redhat.com>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Tue, 23 Feb 2016 16:20:21 +1100
Message-ID: <20160223052021.GH2005@devil.localdomain>
References: <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com>
 <20151208044640.GL1983@devil.localdomain>
 <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
 <20160216033538.GB2005@devil.localdomain>
 <56C74B91.9080508@redhat.com>
 <CA+gn+znGy7VnfkZ+vz65s-j+hpTafQ731-T_tx6gYZrRk3h1Yw@mail.gmail.com>
 <56CB2FCB.8080105@redhat.com>
 <CA+gn+z=7N+uaNXQ3DU65ZFiNhW-VPjwf+ppaMLxswgoep5EJ3g@mail.gmail.com>
 <56CB346B.50200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47176 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbcBWFU1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 23 Feb 2016 00:20:27 -0500
Content-Disposition: inline
In-Reply-To: <56CB346B.50200@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: David Casier <david.casier@aevoo.fr>, Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>

On Mon, Feb 22, 2016 at 10:16:43AM -0600, Eric Sandeen wrote:
> On 2/22/16 10:12 AM, David Casier wrote:
> > I have carried out tests very quickly and I have not had time to
> > concentrate fully on XFS.
> >  maxpct =0.2 => 0.2% of 4To = 8Go
> > Because my existing ssd partitions are small
> > 
> > If i'm not mistaken, and with what Dave says :
> > By default, data is written to 2^32 inodes of 256 bytes (= 1TiB).
> > With maxpct, you set the maximum size used by inodes, depending on the
> > percentage of disk

maxpct doesn't work like that. It's a limit on the count of inodes,
not a limit on their physical location.

And, FWIW, mkfs does not take floating point numbers, so that
mkfs.xfs command line is not doing what you think it's doing. In
fact, it's probably setting maxpct to zero, and the kernel is then
ignoring it because it's invalid.

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com
