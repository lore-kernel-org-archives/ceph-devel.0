From: Loic Dachary <loic@dachary.org>
Subject: crushmap visualisation
Date: Sun, 26 Feb 2017 10:51:12 +0100
Message-ID: <b2a72da4-b8aa-4d64-4bd2-374f25aeb681@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39256 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbdBZJwH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Feb 2017 04:52:07 -0500
Received: from mfilter10-d.gandi.net (mfilter10-d.gandi.net [217.70.178.139])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 4A8C7A80C4
        for <ceph-devel@vger.kernel.org>; Sun, 26 Feb 2017 10:51:15 +0100 (CET)
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter10-d.gandi.net (mfilter10-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id VnCcaHGD6-Y3 for <ceph-devel@vger.kernel.org>;
        Sun, 26 Feb 2017 10:51:13 +0100 (CET)
Received: from [192.168.3.2] (x55b52aaa.dyn.telefonica.de [85.181.42.170])
        (Authenticated sender: loic@dachary.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 08400A80C0
        for <ceph-devel@vger.kernel.org>; Sun, 26 Feb 2017 10:51:12 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Is there something to visualize a crushmap ? It looks like balloon trees and hierarchical bundling (see fig 13a in http://www.aviz.fr/wiki/uploads/Teaching2014/bundles_infovis.pdf) would be a good match. It could show, for instance, where objects move when the crushmap changes. But I've never thought about it before and maybe someone already has an answer to the question ;-) 

Cheers
-- 
Loïc Dachary, Artisan Logiciel Libre
