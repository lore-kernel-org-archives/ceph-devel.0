From: Mike Dawson <mdawson@gammacode.com>
Subject: Re: Guidelines for Calculating IOPS?
Date: Fri, 19 Oct 2012 15:07:50 -0400
Message-ID: <5081A506.3000505@gammacode.com>
References: <50816812.2040008@gammacode.com> <508191A0.1040509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 23-25-46-103-static.hfc.comcastbusiness.net ([23.25.46.103]:48516
	"EHLO mail1.gammacode.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab2JSTGl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 15:06:41 -0400
In-Reply-To: <508191A0.1040509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: ceph-devel@vger.kernel.org

Mark,

Thanks! I really appreciate your reply!

On 10/19/2012 1:45 PM, Mark Kampe wrote:
> Replication should have no effect on read throughput/IOPS.
>
> The client does a single write to the primary, and the
> primary then handles re-replication to the secondary
> copies.  As such the client does not pay (in terms of
> CPU or NIC bandwidth) for the replication.  Per-client
> throughput limitations should be largely independent of
> the replication.
>
> However, the replication does generate additional network
> and I/O activity between the OSDs.  This means that the
> available aggregate throughput (of the entire cluster)
> is effectively cut in half when you move from one-copy to two.
>
Thanks for this confirmation of read and write throughput penalty.

As this storage is for video surveillance, I'd estimate a ratio of 90% 
(or higher) write to 10% reads. So, I really only care about the write IOPS.

> I am confused by your math:
>
>     You say 385MB/s and 5250 IOPS (x8k)
>     5250 IOPS * 8192 = 43MB/s
>

I believe you mistook 385Mbps for 385MB/s. I'm estimating 385Mbps aka 
48MB/s. The remainder or the confusion is rounding (as it's not exactly 8k).

> Do you mean that some of your clients are generating
> a lot of small block writes (at up to 5250 IPS) and
> that others of your clients are doing larger writes
> (with an aggregate throughput of 385MB/s)?
>
The workload is consistent from all clients. 683 video cameras recording 
7 fps. We plan 13-15 VMs running Network Video Recorder (NVR) software 
with camera count spread as evenly as possible across NVRs.

> For RADOS throughput:
>     385MB/s is a fairly small number
>     5250 buffered sequential IOPS is a very small number
>     5250 random IOPS is not a particularly large
>          number, but will require several servers

I don't know if this use fits into buffered sequential IOPS or random 
IOPS territory. Need to learn more about the NVR software probably.

What role would putting the journal on an SSD play here?

>
> My guess is that the IOPS may drive the number of
> servers, and the drives per server will be the
> capacity divided by the number of required servers.
>
> So how many IOPS can you get per server?

I don't know the answer, but would love input here! Assuming I use 
7200rpm drives and conservatively estimate 75 IOPS/drive. I think I need:

5250 / 75 * 3 = 210 drives for 3x replication
5250 / 75 * 2 = 140 drives for 2x replication

Assuming that's a good starting point, then it's all about how to bring 
those drives online. Ignoring extra servers for spare capacity / 
failures, you could do:

18 12-drive servers
  9 24-drive servers
  6 36-drive servers

Is there any reason to assume any other bounding factors like CPU, RAM, 
etc that would make more servers a better architecture?

>
> You are using RBD, and depending on the particulars
> of your stack, there may be a great deal of buffering
> and caching on the client side that can make the
> RADOS traffic much more efficient than the tributary
> client requests.  Thus, I would suggest that you
> probably want to actually benchmark the application
> in question to measure the client-experienced throughput.

Working on a small scale benchmark next week. Thanks for your help!

Thanks,
Mike

>
>
> On 10/19/12 07:47, Mike Dawson wrote:
>> All,
>>
>> I am investigating the use of Ceph for a video surveillance project with
>> the following minimum block storage requirements:
>>
>> 385 Mbps of constant write bandwidth
>> 100TB storage requirement
>> 5250 IOPS (size of ~8 KB)
>>
>> I believe 2 replicas would be acceptable. We intend to use large
>> capacity (2 or 3TB) SATA 7200rpm 3.5" drives, if the IOPS work out
>> properly.
>>
>> Is there a method / formula to estimate IOPS for RDB? Specifically I
>> would like to understand:
>>
>> - How does replica count affect read/write IOPS?
>>
>> - I'm trying to understand best practice for when to optimize server
>> count, drives per server, and drive capacity as it relates to IOPS. Is
>> there a point of diminishing I/O performance using server chassis with
>> lots of drive slots, like the 36-drive Supermicro SC847a?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
