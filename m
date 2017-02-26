From: Loic Dachary <loic@dachary.org>
Subject: Re: crushmap visualisation
Date: Sun, 26 Feb 2017 12:25:27 +0100
Message-ID: <8cadcfa5-7369-1d41-5e40-de4094154983@dachary.org>
References: <b2a72da4-b8aa-4d64-4bd2-374f25aeb681@dachary.org>
 <20170226104005.epmmjwvcfeccuvcq@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38688 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdBZLZ4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Feb 2017 06:25:56 -0500
Received: from mfilter29-d.gandi.net (mfilter29-d.gandi.net [217.70.178.160])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 4095EFB8A4
        for <ceph-devel@vger.kernel.org>; Sun, 26 Feb 2017 12:25:30 +0100 (CET)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter29-d.gandi.net (mfilter29-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id 8YjqL7URfztC for <ceph-devel@vger.kernel.org>;
        Sun, 26 Feb 2017 12:25:28 +0100 (CET)
Received: from [192.168.3.2] (x55b52aaa.dyn.telefonica.de [85.181.42.170])
        (Authenticated sender: loic@dachary.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 895D1FB87D
        for <ceph-devel@vger.kernel.org>; Sun, 26 Feb 2017 12:25:28 +0100 (CET)
In-Reply-To: <20170226104005.epmmjwvcfeccuvcq@jf_suse_laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>



On 02/26/2017 11:40 AM, Jan Fajerski wrote:
> On Sun, Feb 26, 2017 at 10:51:12AM +0100, Loic Dachary wrote:
>> Hi,
>>
>> Is there something to visualize a crushmap ? It looks like balloon trees and hierarchical bundling (see fig 13a in http://www.aviz.fr/wiki/uploads/Teaching2014/bundles_infovis.pdf) would be a good match. It could show, for instance, where objects move when the crushmap changes. But I've never thought about it before and maybe someone already has an answer to the question ;-)
>>
>> Cheers
> 
> Hi Loic,
> Openattic has a crushmap visualisation. See an example here https://demo.openattic.org/openattic/#/ceph/crushmap.
> Its called editor now but I'm not certain of the editors status.

It would be great if this visualization also had a way to represent the impact of changing to another crushmap (with more or less devices). I'll keep an eye on it, thanks for the link :-)

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
