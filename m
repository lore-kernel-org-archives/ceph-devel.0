From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Large numbers of OSD per node
Date: Mon, 05 Nov 2012 12:01:55 +0100
Message-ID: <50979CA3.3060005@widodh.nl>
References: <5097676B.5020200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:55815 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab2KELCG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 06:02:06 -0500
In-Reply-To: <5097676B.5020200@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Thrift <andyonfire@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 05-11-12 08:14, Andrew Thrift wrote:
> Hi,
>
> We are evaluating CEPH for deployment.
>
> I was wondering if there are any current "best practices" around the
> number of OSD's per node ?
>
>
> e.g. We are looking at deploying 3 nodes, each with 72x SAS disks, and
> 2x 10gigabit Ethernet bonded.
>
> Would this best be configured as 72 OSD's per node.
>
> Or would we be better to using raid5 to have 18 OSD's per node ?
>

You should be aware of a large data movement when using 3 nodes.

I myself am I fan of going with a lot of smaller nodes instead of 
building big nodes.

With 3 such nodes you'd probably be going 2x replication? Otherwise you 
can never recover when one of the 3 nodes completely burns down to the 
ground.

If you have 72 1TB disks in such a node you could in theory be moving 
72TB, that would put a lot of stress on the other two nodes and you 
would need a lot of memory and CPU power.

You might be better of by going for 27 nodes with 8 disks each, or have 
18 nodes with 12 disks?

When a node fails the recovery will be much easier on your cluster.

You can also take out a node for maintenance when needed.

Another thing you should be aware of is status "D". What if a filesystem 
inside one of your big machines hangs and one of the OSDs hangs in 
status "D", waiting for I/O which will never come?

You'd be forced to reboot that node and that would again take 72TB of 
data offline.

I am not aware of anybody using such big nodes in production. It could 
work, but you will need a lot of memory and a lot of CPU.

The recommendation is 1GB/1Ghz per OSD, so you'd be looking at at least 
72GB of memory and 72Ghz of CPU power.

Wido

>
>
>
> Regards,
>
>
>
>
>
> Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
