From: Eric Sandeen <esandeen@redhat.com>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Fri, 19 Feb 2016 11:06:25 -0600
Message-ID: <56C74B91.9080508@redhat.com>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
 <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
 <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
 <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
 <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com> <20151208044640.GL1983@devil.localdomain>
 <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
 <20160216033538.GB2005@devil.localdomain>
Reply-To: sandeen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43291 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423865AbcBSRG1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Feb 2016 12:06:27 -0500
In-Reply-To: <20160216033538.GB2005@devil.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Chinner <dchinner@redhat.com>, David Casier <david.casier@aevoo.fr>
Cc: Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>



On 2/15/16 9:35 PM, Dave Chinner wrote:
> On Mon, Feb 15, 2016 at 04:18:28PM +0100, David Casier wrote:
>> Hi Dave,
>> 1TB is very wide for SSD.
> 
> It fills from the bottom, so you don't need 1TB to make it work
> in a similar manner to the ext4 hack being described.

I'm not sure it will work for smaller filesystems, though - we essentially
ignore the inode32 mount option for sufficiently small filesystems.

i.e. if inode numbers > 32 bits can't exist, we don't change the allocator,
at least not until the filesystem (possibly) gets grown later.

So for inode32 to impact behavior, it needs to be on a filesystem 
of sufficient size (at least 1 or 2T, depending on block size, inode
size, etc). Otherwise it will have no effect today.

Dave, I wonder if we need another mount option to essentially mean
"invoke the inode32 allocator regardless of filesystem size?"

-Eric

>> Exemple with only 10GiB :
>> https://www.aevoo.fr/2016/02/14/ceph-ext4-optimisation-for-filestore/
> 
> It's a nice toy, but it's not something that is going scale reliably
> for production.  That caveat at the end:
> 
> 	"With this model, filestore rearrange the tree very
> 	frequently : + 40 I/O every 32 objects link/unlink."
> 
> Indicates how bad the IO patterns will be when modifying the
> directory structure, and says to me that it's not a useful
> optimisation at all when you might be creating several thousand
> files/s on a filesystem. That will end up IO bound, SSD or not.
> 
> Cheers,
> 
> Dave.
> 
