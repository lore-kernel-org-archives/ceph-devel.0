From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Mon, 3 Dec 2012 20:21:48 +0100
Message-ID: <EB4A37AF-6A19-4F66-B5E3-AED15BECED06@filoo.de>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:35047 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab2LCTVu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 14:21:50 -0500
In-Reply-To: <50BCFA2F.9070603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Josh,

Am 03.12.2012 um 20:14 schrieb Josh Durgin <josh.durgin@inktank.com>:

> On 12/03/2012 11:05 AM, Oliver Francke wrote:
>> Hi *,
>> 
>> well, even if 0.48.2 is really stable and reliable, it is not everytime the case with linux kernel. We have a couple of nodes, where an update would make life better.
>> So, as our OSD-nodes have to care for VM's too, it's not the problem to let them drain so migrate all of them to other nodes.
>> Just reboot? Perhaps not, cause all OSD's will begin to remap/backfill, they are instructed to do so. Well, declare them as "osd lost"?
>> Dangerous. Is there another way I miss in doing node-maintenance? Will we have to wait for bobtail for far less hassle with all remapping and resources?
> 
> By default the monitors won't mark an OSD out in the time it takes to
> reboot, but if maintenance takes longer, you can drain data from the
> node.
> 
> A simple way to rate limit it yourself is by slowly lowering the
> weights of the OSDs on the host you want to update, e.g. by 0.1 at a
> time and waiting for recovery to complete before lowering again. Once
> they're at 0 and the cluster is healthy, they're not responsible for
> any data anymore, and the node can be rebooted.
> 

true. Should have mentioned knowing smooth way. But for a planned reboot this take way too much time ;)
But if it's recommended, it's recommended ;)

Oliver.

> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

