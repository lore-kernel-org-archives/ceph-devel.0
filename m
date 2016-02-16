From: Dave Chinner <dchinner@redhat.com>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Tue, 16 Feb 2016 14:35:38 +1100
Message-ID: <20160216033538.GB2005@devil.localdomain>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
 <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
 <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
 <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
 <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com>
 <20151208044640.GL1983@devil.localdomain>
 <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbcBPDfo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 15 Feb 2016 22:35:44 -0500
Content-Disposition: inline
In-Reply-To: <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier <david.casier@aevoo.fr>
Cc: Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>, Eric Sandeen <esandeen@redhat.com>

On Mon, Feb 15, 2016 at 04:18:28PM +0100, David Casier wrote:
> Hi Dave,
> 1TB is very wide for SSD.

It fills from the bottom, so you don't need 1TB to make it work
in a similar manner to the ext4 hack being described.

> Exemple with only 10GiB :
> https://www.aevoo.fr/2016/02/14/ceph-ext4-optimisation-for-filestore/

It's a nice toy, but it's not something that is going scale reliably
for production.  That caveat at the end:

	"With this model, filestore rearrange the tree very
	frequently : + 40 I/O every 32 objects link/unlink."

Indicates how bad the IO patterns will be when modifying the
directory structure, and says to me that it's not a useful
optimisation at all when you might be creating several thousand
files/s on a filesystem. That will end up IO bound, SSD or not.

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com
