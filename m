From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Ceph connections with TLS
Date: Fri, 16 Dec 2016 12:39:15 +0100
Message-ID: <5c5a54bc-4527-6e95-7d24-e7ce1200f0d7@m-privacy.de>
References: <7a01ab71-66eb-46d2-3990-c325f8d36a16@m-privacy.de>
 <417867875.4693.1481886637522@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www1.m-privacy.de ([85.214.254.135]:50684 "EHLO
        www1.m-privacy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759600AbcLPLjZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 06:39:25 -0500
In-Reply-To: <417867875.4693.1481886637522@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Ceph Devel <ceph-devel@vger.kernel.org>

Am 16.12.2016 um 12:10 schrieb Wido den Hollander:
> 
>> Op 16 december 2016 om 11:15 schreef Amon Ott <a.ott@m-privacy.de>:
>> for a customer we are currently designing a ceph cluster, which shall be
>> spread over two data centers. Data in the Ceph cluster is slightly
>> confidential, so we would like to encrypt at least all Ceph traffic over
>> the fast data center connection link.
>>
> 
> Fast as in low latency? Writes in Ceph are synchronous, so keep in mind that any increase in latency will decrease the write performance/latency on your Ceph cluster.

Yes, we expect low latency and high bandwidth, but a connection shared
with other services. Having locality for accesses by clients would of
course help, too.

>> AFAICS, Ceph does not support data encryption at connection level yet,
>> so we would have to setup VPN links between the two cluster networks.
>> This means extra configuration, maintenance and overhead.
>>
>> How far away is TLS support or something similar for the Ceph
>> connections? AFAIK, TLS support should not be hard to implement, but I
>> am not too familiar with Ceph internals.
>>
> 
> Afaik there is no work currently in progress.

I feared so.

> You might implement IPSec on the nodes itself. You might call that a VPN obviously, but IPSec can also just encrypt packets between nodes.

Having quite a bit of experience with OpenVPN, we would rather use that
than IPSec, and we would do it right on the Ceph nodes. Still, TLS in
the connections would be better for lower latency.

Also, we then need VPN connections between all nodes as well as from all
clients to all nodes in the other location. The latter could be routed
through local Ceph nodes, but that would give even more latency.

Thanks for your answer,

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

