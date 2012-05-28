From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: distributed cluster
Date: Mon, 28 May 2012 13:28:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:56423 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab2E1L2r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 07:28:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id A584330087
	for <ceph-devel@vger.kernel.org>; Mon, 28 May 2012 13:28:45 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


This may not really be a subject ceph-devel mailinglist but rather a 
potential ceph-users? I hope it is ok to write here. I would like to 
discuss the if it sounds reasonable to run a Ceph cluster distributed over 
a metro (city) network.

Let us assume we have a couple of sites distributed over a metro network 
with at least gigabit interconnect. The demands for storage capacity and 
speed at our sites are increasing together with the demands for reasonably 
stable storage. May Ceph be a port of a solution?

One idea is to set up Ceph distributed over this metro network. A public 
service network is announced at all sites, anycasted from the storage 
SMB/NFS/RGW(?)-to-Ceph gateway. (for stateless connections). Statefull 
connections (iSCSI?) has to contact the individual storage gateways and 
redundancy is handled at the application level (dual path). Ceph kernel 
clients contact the storage servers directly.

Hopefully this means that clients at the sites with a storage gateway will 
contact it. Clients at a site without a local storage gateway, or when the 
local gateway is down, will contact a storage gateway at another site.

Hopefully not all power and network at the whole city will go 
down at once!

Does this sound reasonable? It should be easy to scale up with more 
storage nodes with Ceph. Or is it better to put all servers in the same 
server room?

                         Internet
                          |   |
                         Routers
                          |   |
    Metro network  =============================
                   |     |     |     |    |    |
    Sites          R     R     R     R    R    R
                   |     |     |     |
    Servers      Ceph1 Ceph2 Ceph3 Ceph4


--jerker
