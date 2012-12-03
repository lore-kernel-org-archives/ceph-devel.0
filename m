From: Christopher Kunz <chrislist@de-punkt.de>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Mon, 03 Dec 2012 20:49:23 +0100
Message-ID: <50BD0243.2050109@de-punkt.de>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:51945 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab2LCT4F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 14:56:05 -0500
In-Reply-To: <50BCFA2F.9070603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 03.12.12 20:14, schrieb Josh Durgin:
> On 12/03/2012 11:05 AM, Oliver Francke wrote:
>> Hi *,
>>
>> well, even if 0.48.2 is really stable and reliable, it is not
>> everytime the case with linux kernel. We have a couple of nodes,
>> where an update would make life better.
>> So, as our OSD-nodes have to care for VM's too, it's not the problem
>> to let them drain so migrate all of them to other nodes.
>> Just reboot? Perhaps not, cause all OSD's will begin to
>> remap/backfill, they are instructed to do so. Well, declare them as
>> "osd lost"?
>> Dangerous. Is there another way I miss in doing node-maintenance?
>> Will we have to wait for bobtail for far less hassle with all
>> remapping and resources?
>
> By default the monitors won't mark an OSD out in the time it takes to
> reboot, but if maintenance takes longer, you can drain data from the
> node.
Hi,

what time is that (in seconds) and how can we reliably test this?

Regards,

--ck
