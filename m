From: Quenten Grasso <QGrasso@onq.com.au>
Subject: RE: distributed cluster
Date: Tue, 29 May 2012 07:55:19 +0000
Message-ID: <7111C6286D862F43B94FD6291D898915868585@EX01.onqtel.local>
References: <sfid-H20120528-122852-+018.44-1@marduk.tchpc.tcd.ie>
 <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>
  (sfid-H20120528-122852-+018.44-1@marduk.tchpc.tcd.ie)
 <D349C36D-377E-4D56-A6E8-709360B65463@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.onqtel.net ([120.88.69.160]:45257 "EHLO mx1.onqtel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab2E2H4P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 03:56:15 -0400
In-Reply-To: <D349C36D-377E-4D56-A6E8-709360B65463@tchpc.tcd.ie>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Jimmy Tang' <jtang@tchpc.tcd.ie>, Jerker Nyberg <jerker@Update.UU.SE>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is also something I'm very interested in as well from a Power outage or some other Data centre issue.

I assume the main issue here would be our friend latency however there is a bloke on the mailing list who is currently running a 2 site cluster setup as well.

I've been thinking about a setup with 2 replica level (1 replica per site) with the sites only 2-3km apart latency shouldn't be much of an issue but the obvious bottleneck will be the 10gbe link between sites and split brain isn't an issue if the RBD Vol is only mounted at a single site anyway.

If the data is sitting on a BTRFS/ZFS raid (or raid6 until BTRFS is ready) this would be reasonable level of risk. As for data integrity/availability of only having 2 replicas because the likely hood of having a complete server failure and a link outage at the same time would be fairly minimal.

Regards,
Quenten 


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Jimmy Tang
Sent: Monday, 28 May 2012 11:48 PM
To: Jerker Nyberg
Cc: ceph-devel@vger.kernel.org
Subject: Re: distributed cluster

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

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
