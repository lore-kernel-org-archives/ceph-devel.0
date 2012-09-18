From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: How are you using Ceph?
Date: Tue, 18 Sep 2012 12:01:43 -0400
Message-ID: <CACkq2moDS27CAk6-RTrqZXW-95XYSdsEVM0nSop-oSQtGd9H1A@mail.gmail.com>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:62982 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab2IRQCF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 12:02:05 -0400
Received: by qaas11 with SMTP id s11so142655qaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Sep 2012 09:02:03 -0700 (PDT)
In-Reply-To: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ross Turk <ross@inktank.com>, ceph-devel@vger.kernel.org

I am using Ceph mainly for it's KVM and OpenStack integration, and
also RBD.  I also needed to provide shared storage to clusters of
nodes, and thus far I haven't needed the highest-possible performance.
 Thus, I create RBDs, format them with ext4, and re-export them with
NFS.  Clients do both NFS v3 and v4 mounts.

I'm using such an NFS mount for my "nova-instances" directory in
OpenStack, which allows me to do live-migration of VMs between compute
nodes.  OpenStack Glance speaks to Ceph directly, and I am using that
as well.

CephFS would be simpler for most of my scenarios, but I've elected to
wait until Inktank is slightly more confident about it.  However,
given comments I've seen on here, it sounds like I should at least
give it a shot -- a SPOF from one MDS is no different than my current
single NFS  server.  =)  For me, Ceph's strong points lie in the
administrative capabilities to create custom pools with custom
replication rules.  And they are easy to change!  Taking down a node
(or OSD's) and watching new objects get copied in order to keep the
required number of copies is very reassuring.

The main competitor when I was exploring options for my project was
GlusterFS.  I played with it for a few months.  It worked for my okay,
but I found it to be slow, and surprisingly, very static.  I pretty
much had to define my volume/replication level ahead of time, and that
was fixed for all time.  I didn't like that I had to define that brick
X on host Y is mirrored to brick A on host B.  I wanted what Ceph does
-- make sure there are two copies of X, and make sure they are not on
the same host (or rack, or row, etc.).

The ability to grow the cluster and add storage while the cluster was
live was also critical.  Adjusting the crush map and having the
objects take immediate advantage of the new OSDs is great.  I wanted
to keep the HW fairly simple, so in keeping with commodity hardware
wanted something that was strictly software based -- no hardware RAID.
That has worked well for me.

Things I would like to see:
The RBD advisory locking and fencing (this seems to be close!)
CephFS of course
more docs re: best practices, performance tuning, HW configs, etc.
Some information (whitepaper?) about how Ceph could be used in more of
an HPC environment, in addition to cloud storage.  I feel like I read
somewhere that part of the inspiration for Ceph originally came out of
frustration with Lustre.  I've also had bad Lustre experiences, and
would like to see Ceph compete on that space.

 - Travis

On Mon, Sep 17, 2012 at 6:14 PM, Ross Turk <ross@inktank.com> wrote:
> Hi, all!
>
> One of the most important parts of Inktank's mission is to spread the
> word about Ceph. We want everyone to know what it is and how to use
> it.
>
> In order to tell a better story to potential new users, I'm trying to
> get a sense for today's deployments. We've spent the last few months
> talking to folks around the world, but I'm sure there are a few great
> stories we haven't heard yet!
>
> If you've got a spare five minutes, I would love to hear what you're
> up to. What kind of projects are you working on, and in what stage?
> What is your workload? Are you using Ceph alongside other
> technologies? How has your experience been?
>
> This is also a good opportunity for me to introduce myself to those I
> haven't met yet! Feel free to copy the list if you think others would
> be interested (and you don't mind sharing).
>
> Cheers,
> Ross
>
> --
> Ross Turk
> Ceph Community Guy
>
> "Any sufficiently advanced technology is indistinguishable from magic."
> -- Arthur C. Clarke
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
