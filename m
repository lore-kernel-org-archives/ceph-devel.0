From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph connections with TLS
Date: Fri, 16 Dec 2016 14:28:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612161425200.10622@piezo.novalocal>
References: <7a01ab71-66eb-46d2-3990-c325f8d36a16@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51328 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757583AbcLPO30 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 09:29:26 -0500
In-Reply-To: <7a01ab71-66eb-46d2-3990-c325f8d36a16@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Fri, 16 Dec 2016, Amon Ott wrote:
> Hello Ceph,
> 
> for a customer we are currently designing a ceph cluster, which shall be
> spread over two data centers. Data in the Ceph cluster is slightly
> confidential, so we would like to encrypt at least all Ceph traffic over
> the fast data center connection link.
> 
> AFAICS, Ceph does not support data encryption at connection level yet,
> so we would have to setup VPN links between the two cluster networks.
> This means extra configuration, maintenance and overhead.
> 
> How far away is TLS support or something similar for the Ceph
> connections? AFAIK, TLS support should not be hard to implement, but I
> am not too familiar with Ceph internals.

I hope to work on the msgr2 protocol change (which will enable encryption 
on the wire) during the next cycle, but I definitely can't promise it'll 
happen by luminous.  In the meantime, you'll need to this in the network 
layer.

Also, note that a stretch cluster will (1) increase latency and that (2) 
two is a bad number of datacenters because you won't be able to establish 
a quorum if the one with the majority of mons goes down.  You'll probably 
want to put one or more mons in a third data center to act as an arbiter.  
But in general these stretch clusters are tricky get set up in a way that 
doesn't break in a failure situation so proceed with extreme caution!

sage
