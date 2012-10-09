From: "james.horner" <james.horner@helpdesk.precedent.co.uk>
Subject: Re: Client Location
Date: Tue, 9 Oct 2012 14:33:09 +0100 (BST)
Message-ID: <252874720.450.1349789589740.JavaMail.root@corellia.pncl.co.uk>
References: <507426F6.1030308@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from corellia.pncl.co.uk ([195.224.14.166]:38681 "EHLO
	corellia.pncl.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab2JINdb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 09:33:31 -0400
In-Reply-To: <507426F6.1030308@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org, James Horner <james.horner@precedent.co.uk>

Hi Wido

Thanks for the response and the advice. It a shame as otherwise ceph meets all our needs.

James

----- Original Message -----
From: "Wido den Hollander" <wido@widodh.nl>
To: "James Horner" <james.horner@precedent.co.uk>
Cc: ceph-devel@vger.kernel.org
Sent: Tuesday, October 9, 2012 2:30:30 PM
Subject: Re: Client Location

On 10/09/2012 03:14 PM, James Horner wrote:
> Hi There
>
>
>
>
> I have a simple test cluster spread across 2 datacenters setup as follows
>
> DC1:
> mon.w
> mon.x
> mds.w
> mds.x
> osd1
>
> DC2:
> mon.e
> mds.e
> osd2
>
> Each DC has a hypervisor(Proxmox running qemu 1.1.1) which can connect to the cluster fine. I think I have the crush map setup to replicate between the datacenters but when I run a VM with a disk on the cluster the hv's connect to the OSD's in the other datacenter. Is there a way to tell qemu that it is DC1 or DC2 and to prefer those osd's?
>

No, there is no such way. Ceph is designed to work on a local network 
where it doesn't matter where the nodes are or how the client connects.

You are not the first to ask this question. People having been thinking 
about localizing data, but there have been no concrete plans.

(See note on crushmap below btw)

> Thanks.
> James
>
>
>
> # begin crush map
>
> # devices
> device 0 osd.0
> device 1 osd.1
>
> # types
> type 0 osd
> type 1 host
> type 2 rack
> type 3 row
> type 4 room
> type 5 datacenter
> type 6 pool
>
> # buckets
> host ceph-test-dc1-osd1 {
> id -2 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.0 weight 1.000
> }
> host ceph-test-dc2-osd1 {
> id -4 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.1 weight 1.000
> }
> rack dc1-rack1 {
> id -3 # do not change unnecessarily
> # weight 2.000
> alg straw
> hash 0 # rjenkins1
> item ceph-test-dc1-osd1 weight 1.000
> }
>

You don't need to specify a weight to the rack in this case, it will 
take the accumulated weight of all the hosts it has in it.

> rack dc2-rack1 {
> id -5
> alg straw
> hash 0
> item ceph-test-dc2-osd1 weight 1.000
> }
>
> datacenter dc1 {
> id -6
> alg straw
> hash 0
> item dc1-rack1 weight 1.000
> }
>
> datacenter dc2 {
> id -7
> alg straw
> hash 0
> item dc2-rack1 weight 1.000
> }
>
> pool proxmox {
> id -1 # do not change unnecessarily
> # weight 2.000
> alg straw
> hash 0 # rjenkins1
> item dc1 weight 2.000
> item dc2 weight 2.000
> }
>


Same goes here, the dc's get their weight by summing up the racks and hosts.

While in your case it doesn't matter that much, you should let crush do 
the calculating when possible.

Wido

> # rules
> rule proxmox {
> ruleset 0
> type replicated
> min_size 1
> max_size 10
> step take default
> step chooseleaf firstn 0 type datacenter
>
> step emit
> }
>
>
> # end crush map
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

