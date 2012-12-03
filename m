From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Mon, 03 Dec 2012 11:14:55 -0800
Message-ID: <50BCFA2F.9070603@inktank.com>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63955 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2LCTPH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 14:15:07 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2129596pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 11:15:06 -0800 (PST)
In-Reply-To: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/03/2012 11:05 AM, Oliver Francke wrote:
> Hi *,
>
> well, even if 0.48.2 is really stable and reliable, it is not everytime the case with linux kernel. We have a couple of nodes, where an update would make life better.
> So, as our OSD-nodes have to care for VM's too, it's not the problem to let them drain so migrate all of them to other nodes.
> Just reboot? Perhaps not, cause all OSD's will begin to remap/backfill, they are instructed to do so. Well, declare them as "osd lost"?
> Dangerous. Is there another way I miss in doing node-maintenance? Will we have to wait for bobtail for far less hassle with all remapping and resources?

By default the monitors won't mark an OSD out in the time it takes to
reboot, but if maintenance takes longer, you can drain data from the
node.

A simple way to rate limit it yourself is by slowly lowering the
weights of the OSDs on the host you want to update, e.g. by 0.1 at a
time and waiting for recovery to complete before lowering again. Once
they're at 0 and the cluster is healthy, they're not responsible for
any data anymore, and the node can be rebooted.

Josh
