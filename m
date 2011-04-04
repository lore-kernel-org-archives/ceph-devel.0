From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: increase duplication level decrease performance
Date: Mon, 4 Apr 2011 16:36:27 -0700
Message-ID: <A1F4CC5EAF434ADC898D1B8019BD0E79@gmail.com>
References: <loom.20110404T235336-22@post.gmane.org>
 <056A9574715F491489130619CBB23989@gmail.com> <4D9A5436.50706@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35304 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab1DDXgd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2011 19:36:33 -0400
Received: by iwn34 with SMTP id 34so6255170iwn.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2011 16:36:32 -0700 (PDT)
In-Reply-To: <4D9A5436.50706@ufm.su>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org


On Monday, April 4, 2011 at 4:28 PM, Fyodor Ustinov wrote: 
> On 04/05/2011 01:52 AM, Gregory Farnum wrote:
> > Data replicas don't service reads unless you specifically configure it for that (it doesn't provide POSIX semantics if you do that), and each replica needs to get the data written before it's considered safe. In your case you're doing a dd, which is a write to disk, so you're increasing how much data needs to get sent over the network and written to disk by increasing replication.
> > 
> > Without knowing more about your setup though we can't tell exactly why the performance is dropping as it is. Some possibilities:
> > 1) You have a very small number of OSDs, so you're saturating the NIC on the primaries
> > 2) You have a very small number of OSDs, so you're saturating the disk on all of them (this is particularly likely if you've got the journal on the same drive as the main store, since that's an automatic 50% cut in disk throughput).
> > 3) Everything is connected via one cheap switch, which can't handle the traffic.
> > 4) You've got some very slow OSDs, which will slow down each Placement Group they're a member of (and with higher replication levels you will hit them more often).
> > etc
> Many thanks for your reply.
> 
> If I correct understood - the maximum write speed to the file system in 
> the ideal case is the network bandwidth from the client? Or bandwidth 
> divided by the number of copies?

In ideal case it would be the network bandwidth from the client, as it only sends data once, to the placement group primary. The primary OSDs send out the data to the replicas. The one thing here is that the primary OSD sends out the data to each replica, but with enough OSDs that shouldn't be the limiting factor since the primaries will be spread out all over the cluster.

> 
> How much OSDs recommended for 3 replicas?

Hmm, haven't looked at that too much. As many as you need for acceptable performance, I suppose. ;)

> P.S. without documentation have to ask stupid questions.:)
> 
Yeah -- there is some information in the wiki, which we encourage everybody to edit; there is lots more in the academic papers if you're up for those; but we hope to be generating more documentation in various forms over the coming months.
-Greg



