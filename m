From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Guidelines for Calculating IOPS?
Date: Fri, 19 Oct 2012 19:56:40 +0200
Message-ID: <50819458.2060201@widodh.nl>
References: <50816812.2040008@gammacode.com> <508191A0.1040509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:42472 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab2JSR4m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 13:56:42 -0400
In-Reply-To: <508191A0.1040509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: Mike Dawson <mdawson@gammacode.com>, ceph-devel@vger.kernel.org



On 10/19/2012 07:45 PM, Mark Kampe wrote:
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

I think you can say this.

You have 100 disks each capable of doing ~100 IOps.

Read: 100 * 100 = 10.000 IOps
Write: (100 * 100 / 2) = 5.000 IOps

Since you are replicating everything twice you only have the speed of 
50% of the disks.

When reading the reads will be balanced over the available copies.

I've taken 100 IOps as a safe assumption for a regular SATA disk.

Wido

> I am confused by your math:
>
>     You say 385MB/s and 5250 IOPS (x8k)
>     5250 IOPS * 8192 = 43MB/s
>
> Do you mean that some of your clients are generating
> a lot of small block writes (at up to 5250 IPS) and
> that others of your clients are doing larger writes
> (with an aggregate throughput of 385MB/s)?
>
> For RADOS throughput:
>     385MB/s is a fairly small number
>     5250 buffered sequential IOPS is a very small number
>     5250 random IOPS is not a particularly large
>          number, but will require several servers
>
> My guess is that the IOPS may drive the number of
> servers, and the drives per server will be the
> capacity divided by the number of required servers.
>
> So how many IOPS can you get per server?
>
> You are using RBD, and depending on the particulars
> of your stack, there may be a great deal of buffering
> and caching on the client side that can make the
> RADOS traffic much more efficient than the tributary
> client requests.  Thus, I would suggest that you
> probably want to actually benchmark the application
> in question to measure the client-experienced throughput.
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
