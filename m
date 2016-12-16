From: David Byte <dbyte@suse.com>
Subject: Re: Ceph connections with TLS
Date: Fri, 16 Dec 2016 13:49:30 +0000
Message-ID: <1A95AEBC-13A4-49D1-B903-4469DC45DDFD@suse.com>
References: <7a01ab71-66eb-46d2-3990-c325f8d36a16@m-privacy.de>
 <417867875.4693.1481886637522@ox.pcextreme.nl>
 <5c5a54bc-4527-6e95-7d24-e7ce1200f0d7@m-privacy.de>,<274802089.4698.1481891426375@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prvmx02.microfocus.com ([130.57.1.217]:1035 "EHLO
        prvmx02.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbcLPOEd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 09:04:33 -0500
In-Reply-To: <274802089.4698.1481891426375@ox.pcextreme.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

There are also NICS and switches that do the encryption at the hardware level. That is probably worth investigating. 

David Byte
Sr. Technical Strategist
IHV Alliances and Embedded
SUSE

Sent from my iPhone. Typos are Apple's fault. 

> On Dec 16, 2016, at 6:31 AM, Wido den Hollander <wido@42on.com> wrote:
> 
> 
>> Op 16 december 2016 om 12:39 schreef Amon Ott <a.ott@m-privacy.de>:
>> 
>> 
>>> Am 16.12.2016 um 12:10 schrieb Wido den Hollander:
>>> 
>>>> Op 16 december 2016 om 11:15 schreef Amon Ott <a.ott@m-privacy.de>:
>>>> for a customer we are currently designing a ceph cluster, which shall be
>>>> spread over two data centers. Data in the Ceph cluster is slightly
>>>> confidential, so we would like to encrypt at least all Ceph traffic over
>>>> the fast data center connection link.
>>>> 
>>> 
>>> Fast as in low latency? Writes in Ceph are synchronous, so keep in mind that any increase in latency will decrease the write performance/latency on your Ceph cluster.
>> 
>> Yes, we expect low latency and high bandwidth, but a connection shared
>> with other services. Having locality for accesses by clients would of
>> course help, too.
>> 
> 
> You can play a bit with primary affinity or modify CRUSH in such a way that the primary OSDs are always in the local DC.
> 
>>>> AFAICS, Ceph does not support data encryption at connection level yet,
>>>> so we would have to setup VPN links between the two cluster networks.
>>>> This means extra configuration, maintenance and overhead.
>>>> 
>>>> How far away is TLS support or something similar for the Ceph
>>>> connections? AFAIK, TLS support should not be hard to implement, but I
>>>> am not too familiar with Ceph internals.
>>>> 
>>> 
>>> Afaik there is no work currently in progress.
>> 
>> I feared so.
>> 
>>> You might implement IPSec on the nodes itself. You might call that a VPN obviously, but IPSec can also just encrypt packets between nodes.
>> 
>> Having quite a bit of experience with OpenVPN, we would rather use that
>> than IPSec, and we would do it right on the Ceph nodes. Still, TLS in
>> the connections would be better for lower latency.
>> 
>> Also, we then need VPN connections between all nodes as well as from all
>> clients to all nodes in the other location. The latter could be routed
>> through local Ceph nodes, but that would give even more latency.
>> 
> 
> True. Isn't the a possibility to encrypt the data before it goes into Ceph? I don't know what the use-case is, but if it is RBD why not encrypt the whole RBD device with LUKS / dm-crypt?
> 
> Just an idea though.
> 
> Wido
> 
>> Thanks for your answer,
>> 
>> Amon.
>> -- 
>> Dr. Amon Ott
>> m-privacy GmbH           Tel: +49 30 24342334
>> Werner-Voß-Damm 62       Fax: +49 30 99296856
>> 12101 Berlin             http://www.m-privacy.de
>> 
>> Amtsgericht Charlottenburg, HRB 84946
>> 
>> Geschäftsführer:
>> Dipl.-Kfm. Holger Maczkowsky,
>> Roman Maczkowsky
>> 
>> GnuPG-Key-ID: 0x2DD3A649
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
