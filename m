From: Loic Dachary <loic@dachary.org>
Subject: libcrush to be merged in Ceph
Date: Wed, 16 Aug 2017 10:42:50 +0200
Message-ID: <0a045b84-d77c-30d8-0e87-3b5b32c11997@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44683 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdHPIqz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Aug 2017 04:46:55 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id B9EC847B3DF
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 10:42:52 +0200 (CEST)
Received: from [192.168.3.43] (static-176-158-46-5.ftth.abo.bbox.fr [176.158.46.5])
        (Authenticated sender: loic@dachary.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 19257FB89E
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 10:42:50 +0200 (CEST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

TL;DR: libcrush rebalancing algorithm is going to be merged in Ceph[0]

A few months ago http://libcrush.org started with the goal to provide an library independent from Ceph and usable by other software. The short conclusion is that there is not much interest. Other storage software would have to be re-architectured entirely to take advantage of CRUSH. And other kind of distributed software such as distributed cache or databases also have their own way of addressing content. I'd be happy to share the research if someone is interested in the details.

Although unexpected, the positive outcome of the work done on libcrush is an algorithm to fix uneven CRUSH distributions in Ceph[1]. Instead of bundling it as part of a standalone python module, it will be re-written in C++ and merged into the Ceph mainline[0]. Having a separate library would be worth the effort if projects other than Ceph use it. Since it's not going to be the case in the near future, it would just be a maintenance burden.

Unless someone is willing to takeover libcrush, it is going to be deprecated in the near future.

Cheers

[0] https://github.com/ceph/ceph/pull/16272
[1] An algorithm to fix uneven CRUSH distributions in Ceph http://dachary.org/?p=4055

-- 
Loïc Dachary, Artisan Logiciel Libre
