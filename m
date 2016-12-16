From: Wido den Hollander <wido@42on.com>
Subject: Re: Ceph connections with TLS
Date: Fri, 16 Dec 2016 12:10:37 +0100 (CET)
Message-ID: <417867875.4693.1481886637522@ox.pcextreme.nl>
References: <7a01ab71-66eb-46d2-3990-c325f8d36a16@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:57612 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760976AbcLPLSm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 06:18:42 -0500
In-Reply-To: <7a01ab71-66eb-46d2-3990-c325f8d36a16@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>, Ceph Devel <ceph-devel@vger.kernel.org>


> Op 16 december 2016 om 11:15 schreef Amon Ott <a.ott@m-privacy.de>:
> 
> 
> Hello Ceph,
> 
> for a customer we are currently designing a ceph cluster, which shall be
> spread over two data centers. Data in the Ceph cluster is slightly
> confidential, so we would like to encrypt at least all Ceph traffic over
> the fast data center connection link.
> 

Fast as in low latency? Writes in Ceph are synchronous, so keep in mind that any increase in latency will decrease the write performance/latency on your Ceph cluster.

> AFAICS, Ceph does not support data encryption at connection level yet,
> so we would have to setup VPN links between the two cluster networks.
> This means extra configuration, maintenance and overhead.
> 
> How far away is TLS support or something similar for the Ceph
> connections? AFAIK, TLS support should not be hard to implement, but I
> am not too familiar with Ceph internals.
> 

Afaik there is no work currently in progress.

You might implement IPSec on the nodes itself. You might call that a VPN obviously, but IPSec can also just encrypt packets between nodes.

Wido

> Thoughts?
> 
> Amon Ott
> -- 
> Dr. Amon Ott
> m-privacy GmbH           Tel: +49 30 24342334
> Werner-Voß-Damm 62       Fax: +49 30 99296856
> 12101 Berlin             http://www.m-privacy.de
> 
> Amtsgericht Charlottenburg, HRB 84946
> 
> Geschäftsführer:
>  Dipl.-Kfm. Holger Maczkowsky,
>  Roman Maczkowsky
> 
> GnuPG-Key-ID: 0x2DD3A649
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
