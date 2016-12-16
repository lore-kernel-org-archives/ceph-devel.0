From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Ceph connections with TLS
Date: Fri, 16 Dec 2016 15:37:03 +0100
Message-ID: <1f00af21-15b0-8a4a-afa5-9ecbbedc5e65@m-privacy.de>
References: <7a01ab71-66eb-46d2-3990-c325f8d36a16@m-privacy.de>
 <alpine.DEB.2.11.1612161425200.10622@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www1.m-privacy.de ([85.214.254.135]:55198 "EHLO
        www1.m-privacy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753265AbcLPOhO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 09:37:14 -0500
In-Reply-To: <alpine.DEB.2.11.1612161425200.10622@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Am 16.12.2016 um 15:28 schrieb Sage Weil:
> On Fri, 16 Dec 2016, Amon Ott wrote:
>> How far away is TLS support or something similar for the Ceph
>> connections? AFAIK, TLS support should not be hard to implement, but I
>> am not too familiar with Ceph internals.
> 
> I hope to work on the msgr2 protocol change (which will enable encryption 
> on the wire) during the next cycle, but I definitely can't promise it'll 
> happen by luminous.  In the meantime, you'll need to this in the network 
> layer.

Ok, looking forward to those changes. And we will setup a VPN
infrastructure for now.

> Also, note that a stretch cluster will (1) increase latency and that (2) 
> two is a bad number of datacenters because you won't be able to establish 
> a quorum if the one with the majority of mons goes down.  You'll probably 
> want to put one or more mons in a third data center to act as an arbiter.  
> But in general these stretch clusters are tricky get set up in a way that 
> doesn't break in a failure situation so proceed with extreme caution!

For the quorum we plan to have an extra mon node in a separate building
containing the switches that connect everything. There is just enough
space for this extra node.

Thanks!

Amon.
-- 
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Voß-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Geschäftsführer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

