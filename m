From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: Guidelines for Calculating IOPS?
Date: Fri, 19 Oct 2012 10:45:04 -0700
Message-ID: <508191A0.1040509@inktank.com>
References: <50816812.2040008@gammacode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59827 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab2JSRpL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 13:45:11 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so533535pad.19
        for <ceph-devel@vger.kernel.org>; Fri, 19 Oct 2012 10:45:11 -0700 (PDT)
In-Reply-To: <50816812.2040008@gammacode.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mdawson@gammacode.com>
Cc: ceph-devel@vger.kernel.org

Replication should have no effect on read throughput/IOPS.

The client does a single write to the primary, and the
primary then handles re-replication to the secondary
copies.  As such the client does not pay (in terms of
CPU or NIC bandwidth) for the replication.  Per-client
throughput limitations should be largely independent of
the replication.

However, the replication does generate additional network
and I/O activity between the OSDs.  This means that the
available aggregate throughput (of the entire cluster)
is effectively cut in half when you move from one-copy to two.

I am confused by your math:

    You say 385MB/s and 5250 IOPS (x8k)
    5250 IOPS * 8192 = 43MB/s

Do you mean that some of your clients are generating
a lot of small block writes (at up to 5250 IPS) and
that others of your clients are doing larger writes
(with an aggregate throughput of 385MB/s)?

For RADOS throughput:
    385MB/s is a fairly small number
    5250 buffered sequential IOPS is a very small number
    5250 random IOPS is not a particularly large
         number, but will require several servers

My guess is that the IOPS may drive the number of
servers, and the drives per server will be the
capacity divided by the number of required servers.

So how many IOPS can you get per server?

You are using RBD, and depending on the particulars
of your stack, there may be a great deal of buffering
and caching on the client side that can make the
RADOS traffic much more efficient than the tributary
client requests.  Thus, I would suggest that you
probably want to actually benchmark the application
in question to measure the client-experienced throughput.


On 10/19/12 07:47, Mike Dawson wrote:
> All,
>
> I am investigating the use of Ceph for a video surveillance project with
> the following minimum block storage requirements:
>
> 385 Mbps of constant write bandwidth
> 100TB storage requirement
> 5250 IOPS (size of ~8 KB)
>
> I believe 2 replicas would be acceptable. We intend to use large
> capacity (2 or 3TB) SATA 7200rpm 3.5" drives, if the IOPS work out
> properly.
>
> Is there a method / formula to estimate IOPS for RDB? Specifically I
> would like to understand:
>
> - How does replica count affect read/write IOPS?
>
> - I'm trying to understand best practice for when to optimize server
> count, drives per server, and drive capacity as it relates to IOPS. Is
> there a point of diminishing I/O performance using server chassis with
> lots of drive slots, like the 36-drive Supermicro SC847a?
