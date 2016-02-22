From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 22 Feb 2016 07:01:43 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602220656530.13988@cpach.fuggernut.com>
References: <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net> <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com> <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com> <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com> <20151208044640.GL1983@devil.localdomain> <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com> <20160216033538.GB2005@devil.localdomain> <CA+gn+z=dGTeLo71h=z=AvoLM-RRq_-RfbJwFamyfxK93bvk+Hw@mail.gmail.com>
 <CA+gn+zmCx_Pu6oEUT31SfKRF1A9Pzi1aWTPbXJY7dOgQqCqARQ@mail.gmail.com> <20160219052637.GF2005@devil.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59714 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbcBVMCL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Feb 2016 07:02:11 -0500
In-Reply-To: <20160219052637.GF2005@devil.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Chinner <dchinner@redhat.com>
Cc: David Casier <david.casier@aevoo.fr>, Ric Wheeler <rwheeler@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>, Eric Sandeen <esandeen@redhat.com>, =?ISO-8859-15?Q?Beno=EEt_LORIOT?= <benoit.loriot@aevoo.fr>

On Fri, 19 Feb 2016, Dave Chinner wrote:
> On Tue, Feb 16, 2016 at 09:39:28AM +0100, David Casier wrote:
> >         "With this model, filestore rearrange the tree very
> >         frequently : + 40 I/O every 32 objects link/unlink."
> > It is the consequence of parameters :
> > filestore_merge_threshold = 2
> > filestore_split_multiple = 1
> > 
> > Not of ext4 customization.
> 
> It's a function of the directory structure you are using to work
> around the scalability deficiencies of the ext4 directory structure.
> i.e. the root cause is that you are working around an ext4 problem.

If only it were just that :(.  The other problem is that we need in-order 
enumeration of files/objects (with a particular sort order we define) and 
POSIX doesn't give us that.  Small directories let us read the whole thing 
and sort in memory.

If there is a 'good' directory size that tends to have a small/minimal 
number of IOs for listing all files it may make sense to change the 
defaults (picked semi-randomly several years back), but beyond that there 
isn't much to do here except wait for the replacement for this whole 
module that doesn't try to map our namespace onto POSIX's.

Optimizations to any of this FileStore code will see limited mileage since 
it'll be deprecated shortly anyway...

sage
