From: Jan Fajerski <jan-fajerski@gmx.net>
Subject: Re: crushmap visualisation
Date: Sun, 26 Feb 2017 11:40:05 +0100
Message-ID: <20170226104005.epmmjwvcfeccuvcq@jf_suse_laptop>
References: <b2a72da4-b8aa-4d64-4bd2-374f25aeb681@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:63489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752046AbdBZKrM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 26 Feb 2017 05:47:12 -0500
Received: from localhost ([79.210.124.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx5hl-1cFVLa0iHh-016ejv for
 <ceph-devel@vger.kernel.org>; Sun, 26 Feb 2017 11:40:07 +0100
Content-Disposition: inline
In-Reply-To: <b2a72da4-b8aa-4d64-4bd2-374f25aeb681@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Feb 26, 2017 at 10:51:12AM +0100, Loic Dachary wrote:
>Hi,
>
>Is there something to visualize a crushmap ? It looks like balloon trees and hierarchical bundling (see fig 13a in http://www.aviz.fr/wiki/uploads/Teaching2014/bundles_infovis.pdf) would be a good match. It could show, for instance, where objects move when the crushmap changes. But I've never thought about it before and maybe someone already has an answer to the question ;-)
>
>Cheers

Hi Loic,
Openattic has a crushmap visualisation. See an example here 
https://demo.openattic.org/openattic/#/ceph/crushmap.
Its called editor now but I'm not certain of the editors status.

>-- 
>Loïc Dachary, Artisan Logiciel Libre
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
