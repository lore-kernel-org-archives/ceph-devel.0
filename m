From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Newbie questions
Date: Mon, 01 Oct 2012 14:20:24 +0100
Message-ID: <50699898.2050506@inktank.com>
References: <k4c2dj$s3i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64892 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab2JANUe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 09:20:34 -0400
Received: by bkcjk13 with SMTP id jk13so4934448bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 06:20:33 -0700 (PDT)
In-Reply-To: <k4c2dj$s3i$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: ceph-devel@vger.kernel.org

Hello Adam,

On 10/01/2012 01:30 PM, Adam Nielsen wrote:
> Hi all,
> 
> I've been investigating cluster filesystems for a while now, and I have
> a few questions about Ceph I hope you don't mind me asking here.  This
> is in the context of using Ceph as a POSIX filesystem and alternative to
> something like NFS.
> 
>   1. Is Ceph stable enough for "real" use yet?  I read that upgrading to
> v0.48 required a reformat, which I imagine would be a bit of an issue in
> a production system.  Is this how upgrades are normally done?  Is anyone
> running Ceph in a production environment with real data yet?

The rbd and radosgw are considered stable. CephFS on the other hand is
not advised for production.

With 0.48 (aka argonaut) came big changes, and that made the upgrade a
one-way street: upgrading to 0.48 was possible, but going back was not.
Argonaut's release notes made that bit clear
(http://ceph.com/releases/v0-48-argonaut-released/)

And yes, there are production systems backed up by Ceph. Probably the
one with most visibility is Dreamhost's DreamObjects
(http://dreamhost.com/cloud/dreamobjects/) which is now on an open
public beta.

>   2. Why does the wiki say that you can run one or three monitor
> daemons, but running two is worse than one?  Wouldn't running two be
> less work than running three?

First of all, a better source for update documentation would be
http://ceph.com/docs/master/

The monitors must reach a quorum, thus it is advised to have an
odd-number of monitors. Having an even-number of monitors may result in
some confusion if both halves disagree on something such as "what's the
most recent version of a given map". Hence, running an odd-number of
monitors is advised.

>   3. If I have multiple disks in a machine that I can dedicate to Ceph,
> is it better to RAID them and present Ceph with a single filesystem, or
> do you get better results by giving Ceph a filesystem on each disk and
> letting it look after the striping and any faulty disks?

I'm sure someone else will be able to address this better than I am!

> 
>   4. How resilient is the system?  I can find a lot of information
> saying one node can go away without any data loss, but does that mean
> losing a second node will take everything down?  Can you configure it
> such that every node has a complete copy of the cluster, so as long as
> any one node survives, all the data is available?

Depending on the replication level, how the data is placed across the
cluster and how many nodes you have in place, I would say it is fairly
certain that you wouldn't lose any data. I, for one, haven't got to
configure and deal with such a system (although other have), but ceph is
all about avoiding such data loss.

See, data is replicated across the cluster osds. As long as the
surviving nodes also have the data that was lost on the other two,
three, ..., servers, your cluster should be up and running.

You can configure how data is placed across the cluster by configuring
the crush map (http://ceph.com/docs/master/cluster-ops/crush-map/). I
don't know if having a complete copy of the cluster in each node is the
best idea ever, unless you are aiming for either a small-ish aggregated
storage capacity or massive servers.

>   5. Given that the cluster filesystem contains files, which are then
> stored as other files in a different filesystem, does this affect
> performance much? I'm thinking of something like a git repository which
> accesses file metadata a lot, and seems to suffer a bit if it's not
> running off a local disk.

Well, yes. Adding an extra layer of abstraction is bound to result in
performance loss. But on the other hand, using those native file systems
simplify ceph's task, design and also allows ceph to leverage certain
capabilities those file systems offer and that would otherwise need to
be supported by ceph itself (btrfs snapshots come to mind). So, I
suppose there's a trade-off here.

How much it affects performance? Well, there are a couple of recent
threads in the mailing list regarding such issues (feel free to skim
over them), and how they are being address.

> 
> Hopefully I'm not asking questions which are already covered in the
> documentation - if so please point me in the right direction.

http://ceph.com/docs/master/

Cheers,
  -Joao

> 
> Many thanks,
> Adam.

