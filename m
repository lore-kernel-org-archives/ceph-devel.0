From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: distributed cluster
Date: Mon, 28 May 2012 14:47:59 +0100
Message-ID: <D349C36D-377E-4D56-A6E8-709360B65463@tchpc.tcd.ie>
References: <sfid-H20120528-122852-+018.44-1@marduk.tchpc.tcd.ie> <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>  (sfid-H20120528-122852-+018.44-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:54188 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab2E1NsD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 09:48:03 -0400
In-Reply-To: <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>  (sfid-H20120528-122852-+018.44-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerker Nyberg <jerker@Update.UU.SE>
Cc: ceph-devel@vger.kernel.org

Hi All,

On 28 May 2012, at 12:28, Jerker Nyberg wrote:

> 
> This may not really be a subject ceph-devel mailinglist but rather a potential ceph-users? I hope it is ok to write here. I would like to discuss the if it sounds reasonable to run a Ceph cluster distributed over a metro (city) network.
> 
> Let us assume we have a couple of sites distributed over a metro network with at least gigabit interconnect. The demands for storage capacity and speed at our sites are increasing together with the demands for reasonably stable storage. May Ceph be a port of a solution?
> 
> One idea is to set up Ceph distributed over this metro network. A public service network is announced at all sites, anycasted from the storage SMB/NFS/RGW(?)-to-Ceph gateway. (for stateless connections). Statefull connections (iSCSI?) has to contact the individual storage gateways and redundancy is handled at the application level (dual path). Ceph kernel clients contact the storage servers directly.
> 
> Hopefully this means that clients at the sites with a storage gateway will contact it. Clients at a site without a local storage gateway, or when the local gateway is down, will contact a storage gateway at another site.
> 
> Hopefully not all power and network at the whole city will go down at once!
> 
> Does this sound reasonable? It should be easy to scale up with more storage nodes with Ceph. Or is it better to put all servers in the same server room?
> 
>                        Internet
>                         |   |
>                        Routers
>                         |   |
>   Metro network  =============================
>                  |     |     |     |    |    |
>   Sites          R     R     R     R    R    R
>                  |     |     |     |
>   Servers      Ceph1 Ceph2 Ceph3 Ceph4
> 
> 


I'm also interested in this type of use case, I would be interested in running a ceph cluster across a metropolitan area network. Has anyone tried running ceph in a WAN/MAN environment across a city/state/country?

Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

