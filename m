From: Sage Weil <sage@newdream.net>
Subject: Re:Re: Consult some problems of Ceph when reading source code
Date: Thu, 6 Aug 2015 13:00:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508061252250.22099@cobra.newdream.net>
References: <780bf286.119cf.14f008cac3f.Coremail.cymengxiang@126.com> <alpine.DEB.2.00.1508060540070.22099@cobra.newdream.net> <44598b40.157d5.14f0389480d.Coremail.cymengxiang@126.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41713 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbbHFUA6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 16:00:58 -0400
In-Reply-To: <44598b40.157d5.14f0389480d.Coremail.cymengxiang@126.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-2022-JP?Q?=1B$Bhq5#=1B=28J?= <cymengxiang@126.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 6 Aug 2015, ?? wrote:
> Dear Dr.Sage:

> Thank you for your detailed reply?These answers helps me a lot. I also 
> have some problems in Question (1.

> In your reply, the requests according to the different PG enqueue into 
> the ShardedWQ, if I have 3 requests( that is 
> <pg1,r1>,<pg2,r2>,<pg3,r3>), and I put them to the ShardedWQ, is the 
> process also aserializes processing?

Lots of threads are enqueuing things into the ShardedWQ.  A deterministic 
function of the pg determines which shard the request lands in.

	https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L8247

> When I want to dequeue the item from ShardedWQ, there is a work_queues 
> (the type is the vector of work_queue) in ThreadPool 
> method(WorkQueue.cc) and then I calculate the work queue according to 
> the work_queues, so is there many work queue in the request process?  
> or is there no association with the ShardedWQ?

	https://github.com/ceph/ceph/blob/master/src/common/WorkQueue.cc#L350

Any given thread services a single shard.  There can be more than 
one threads per shard.  There's a bunch of code in OSD.cc that ensures 
that the requests for any given PG are processed in order, serially, 
so if two threads pull off requests for the same PG one will block so 
that they still complete in order.

> When I get the item from ShardedWQ, I will transfer it to the 
> transaction and then read or write. Is the process done one by one( 
> another transaction is handled only when this transaction is over), if 
> it is, Could we promise the performance? if it isn't , Are the 
> transactions'actions parallel?

The write operations are analyzed, prepared, and then started (queued for 
disk and replicated over the network).  Completion is asynchronous (since 
it can take a while).

The read operatoins are currently done synchronously (we block while we 
read the data from the local copy on disk), although this is likely to 
change soon to be either synchronous or async (depending on the backend, 
hardware, etc.).

HTH!
sage


> Thank you a lot!
> 
> 
> 
> 
> 
> At 2015-08-06 20:44:45, "Sage Weil" <sage@newdream.net> wrote:
> >Hi!
> >
> >On Thu, 6 Aug 2015, ?? wrote:
> >> Dear developers,
> >> 
> >> My name is Cai Yi, and I am a graduate student majored in CS of Xi?an 
> >> Jiaotong University in China. From Ceph?s homepage, I know Sage is the 
> >> author of Ceph and I get the email address from your GitHub and Ceph?s 
> >> official website. Because Ceph is an excellent distributed file system, 
> >> so recently, I am reading the source code of the Ceph (the edition is 
> >> Hammer) to understand the IO good path and the performance of Ceph. 
> >> However, I face some problems which I could not find the solution from 
> >> Internet or solve by myself and my partners. So I was wondering if you 
> >> could help us solve some problems. The problems are as follows:
> >> 
> >> 1)  In the Ceph, there is a concept that is the transaction. When the 
> >> OSD receives a write request, and then it is encapsulated by a 
> >> transaction. But When the OSD receive many requests, is there a 
> >> transaction queue to receive the messages? If there is a queue, is it a 
> >> process of serial or parallel to submit these transaction to do next 
> >> operation? If it is serial, could the transaction operations influence 
> >> the performance?
> >
> >The requests are distributed across placement groups and into a shared 
> >work queue, implemented by ShardedWQ in common/WorkQueue.h.  This 
> >serializes processing for a given PG, but this generally makes little 
> >difference as there are typically 100 or more PGs per OSD.
> >
> >> 2)  From some documents about Ceph, if the OSD receives a read request, 
> >> the OSD can only read data from primary and then back to client. Is the 
> >> description right?
> >
> >Yes.  This is usually the right thing to do or else a given object will 
> >end up consuming cache (memory) on more than one OSD and the overall cache 
> >efficiency of the cluster will drop by your replication factor.  It's only 
> >a win to distributed reads when you have a very hot object, or when you 
> >want to spend OSD resources by reduce latency (e.g., by sending reads to 
> >all replica and taking the fastest reply).
> >
> >> Is there any way to read the data from replicated 
> >> OSD? Do we have to require the data from the primary OSD when deal with 
> >> the read request? If not and we can read from replicated OSD, could we 
> >> promise the consistency?
> >
> >There is a client-side flag to read from a random or the closest 
> >replica, but there are a few bugs that affect consistency when recovery is 
> >underway that are being fixed up now.  It is likely that this will work 
> >correctly in Infernalis, the next stable release.
> >
> >> 3)  When the OSD receives the message, the message?s attribute may be 
> >> the normal dispatch or the fast dispatch. What is the difference between 
> >> the normal dispatch and the fast dispatch? If the attribute is the 
> >> normal dispatch, it enters the dispatch queue. Is there a single 
> >> dispatch queue or multi dispatch queue to deal with all the messages?
> >
> >There is a single thread that does the normal dispatch.  Fast dispatch 
> >processes the message synchrnonously from the thread that received the 
> >message, so it faster, but it has to be careful not to block.
> >
> >> These are the problem I am facing. Thank you for your patience and 
> >> cooperation, and I look forward to hearing from you.
> >
> >Hope that helps!
> >sage
> 
