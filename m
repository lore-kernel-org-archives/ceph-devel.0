From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: ceph caps (Ganesha + Ceph pnfs)
Date: Tue, 8 Jan 2013 12:11:48 -0500 (EST)
Message-ID: <546032248.22.1357665108393.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1538446321.14.1357663643915.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3589 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755295Ab3AHRLw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jan 2013 12:11:52 -0500
In-Reply-To: <1538446321.14.1357663643915.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>

Hi Sage,

----- "Sage Weil" <sage@inktank.com> wrote:

> 
> Your prevoius question made it sound like the DS was interacting with
> 
> libcephfs and dealing with (some) MDS capabilities.  Is that right?
> 
> I wonder if a much simpler approach would be to make a different fh
> format 
> or type, and just cram the inode and ceph object/block number in
> there.  
> Then the DS can just go direct to rados and avoid interacting with the
> fs 
> at all.  There are some additional semantics surrounding the truncate
> 
> metadata, but if we're lucky that can fit inside the fh, and the DS 
> servers could really just act like object targets--no libcephfs or MDS
> 
> interaction at all.

The current architecture gets the inode and block information to the DS 
reliably already without change to the Ceph fh--decoding steering information
happens at the MDS, rather than the DS.  It is important to us to ensure that
the total steering information be "finite and manageable," though, since
we need it to travel with the pNFS layout to the NFS client.

It is definitely the goal for the DS to go direct to rados.  I think the
outstanding issue may be limited to getting the MDS view of metadata up-to-date
after an extending or truncating i/o completes (at least in the immediate
term).

You may well be thinking, "sheesh, the client is doing out-of-band i/o, why doesn't it send the LAYOUTCOMMIT operation to the MDS to update the metadata."  The unsatisfactory answer is that currently (due to our use of the "files"
layout type) clients can insist that the DS do the commit.  The Linux kernel client does so for writes below a size threshold.

For the longer term, an option is shaping up that would allow us to use the objects layout (RFC 5664), which always commits layouts.  This discussion seems to be adding to the argument in support of switching, frankly.  My intuition is that it's preferable to let the DS jump layers to commit, though, even if we want to elide such commits in future (not just for expediency, but because the flexibility to do it seems like a win for the Ceph architecture).

> 
> Either way, to your first (original question), yes, we should expose a
> way 
> via libcephfs to take a reference on the capability that isn't
> released 
> until the layout is committed.  That should be pretty straightforward
> to 
> do, I think.

Excellent.

> 
> Hopefully my understanding is getting closer!
> 
> :) sage
> 

Indeed, thanks

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
