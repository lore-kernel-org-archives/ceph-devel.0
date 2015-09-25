From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Fri, 25 Sep 2015 16:16:23 +0300
Message-ID: <56054927.2040008@mirantis.com>
References: <56018A05.6090100@mirantis.com>
 <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
 <56029F66.3070503@mirantis.com>
 <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
 <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
 <5602C48C.4010009@mirantis.com>
 <CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
 <5604131E.2030408@mirantis.com>
 <CAJ4mKGaJY31=WbTPFfpWkNho0zSb__dYMbjN6W9jeQTKiGvxyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:35355 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083AbbIYNQ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Sep 2015 09:16:26 -0400
Received: by lacrr8 with SMTP id rr8so18684448lac.2
        for <ceph-devel@vger.kernel.org>; Fri, 25 Sep 2015 06:16:24 -0700 (PDT)
In-Reply-To: <CAJ4mKGaJY31=WbTPFfpWkNho0zSb__dYMbjN6W9jeQTKiGvxyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>



On 24.09.2015 21:10, Gregory Farnum wrote:
> On Thu, Sep 24, 2015 at 8:13 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>> On 23.09.2015 21:03, Gregory Farnum wrote:
>> Okay, that's acceptable, but that metadata then gets pretty large. 
>> You would need to store an offset, for each chunk in the PG, and for 
>> each individual write. (And even then you'd have to read an entire 
>> write at a time to make sure you get the data requested, even if they 
>> only want a small portion of it.) If you're doing it this way, then 
>> realize we've also got a problem with recovery: we can't lose those 
>> offsets. Which means they need to be preserved at all costs. So that 
>> means for each stripe unit you'd store them on the primary (for easy 
>> access) and on the replica (so they have the same lifecycle as the 
>> data they're mapping), which means the replicas need to be 
>> compression-aware. Which is good, since I think they'd need to be 
>> compression-aware for scrubbing and things as well. And then when you 
>> lose the primary the next guy who's reconstructing would need to, uh, 
>> ask each shard for the uncompressed version of the data? 
You are absolutely right about metadata importance and replicas 
compression-awareness. The great thing here is that it's absolutely 
similar to current EC pool implementation. Each append to EC pool 
updates some specific metadata (hash info) that are propagated to all 
replicas. And each replica is able to restore EC encoded data when 
primary is lost. IMO such replica simply becomes a new primary.

And yes - reconstructing entity collects shards from multiple OSDs. 
Moreover primary does the same during regular read. Thus all this 
mechanics already exists for EC pools.

>> If we were going to limit this to EC pools I think we should just do 
>> it at the replica in the FileStore or something, transparently to the 
>> wire and recovery protocols. While the compression would help on 
>> 1GigE networks, on 10GigE I think the CPU costs of compression 
>> outweigh any bandwidth efficiencies we'd get... 
This is definitely worth to consider but one thing to mention here. In 
general from CPU loading perspective there is no much difference where 
compression is performed: at primary OSD or at replica node. Each 
replica node can be a primary for some other object thus its' CPU can be 
utilized for that compression.
E.g.
There are three nodes: node1, node2, node3.
There are three objects written to EC pool.
They have different primaries: node1, node2, node3 respectively.
and all nodes are used for objects to store resulting EC shards.

Original disposition after EC:
obj1 -> shard1_1, shard1_2, shard1_3. (performed at node1)
obj2 -> shard2_1, shard2_2, shard2_3. (performed at node2)
obj3 -> shard3_1, shard3_2, shard3_3. (performed at node3)

Stored data disposition can be:
node1: shard1_1,  shard2_2, shard3_3
node2: shard1_3, shard2_1, shard3_2
node3: shard1_2 & shard2_3, shard3_1

Thus each node has to deal with 3 shards - no matter where you have 
compression functionality:  each node has to compress 3 shards.
If compression is done at primary  node1 compresses shards1_1, 1_2, 1_3
If compression is at replica node 1 compresses shard1_1,  shard2_2, shard3_3
The same applies to other nodes.

As a result you will have similar CPU load distribution among nodes 
under Ceph cluster load  for both compression approaches.
Actually compression at primary before EC even has some benefit: each 
object has two shards prior to EC thus you need to compress less data.

>>
>> Well I agree that have compression support for both replicated and EC pools
>> is better.
>> But random access ( and probably other advanced features ) requires much
>> more complex data handling that also brings additional overhead. Actually I
>> suppose EC pools have such limitations due to these reasons. Thus my
>> original idea was to simplify compression implementation from one side and
>> make it  in-line with EC usage from another. The latter makes sense since
>> compression and EC  have pretty the same reasons for implementation.
> Well, EC pools still support random reads, I think? Or at least
> reading along stripes, which for the purpose of this discussion is
> almost the same.
Yeah, random reads are possible for EC pools. But they aren't the major 
issue IMO. That's random writes that causes a head ache.
On such write one should decompress existing block, merge it with new 
data, compress it again and then save to a disk given the fact that 
block size has changed.
Or implement a sort of journal where new writes are saved separately and 
then data reconstruction from this journal is required on read. As well 
as some garbage collection... AFAIK ZBD I mentioned before works in this 
way.
see
http://users.ics.forth.gr/~bilas/pdffiles/makatos-snapi10.pdf

> In any case, as Sam said I think judging these proposals well will 
> require actually going through the data structure and algorithms 
> design work for each one and comparing. Unfortunately I've no time to 
> do that, but I'd definitely like to see two real approaches 
> well-sketched-out before any work is spent on coding one. -Greg 
Got it, will try to prepare some draft...

Thanks,
Igor
