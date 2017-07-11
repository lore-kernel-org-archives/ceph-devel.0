From: =?utf-8?B?0JTQvNC40YLRgNC40Lkg0JPQu9GD0YjQtdC90L7Qug==?=
        <glush@jet.msk.su>
Subject: OSD returns back and recovery process
Date: Tue, 11 Jul 2017 17:43:04 +0300
Message-ID: <286A8681-0B8A-4AE0-88E3-44D818260EDA@jet.msk.su>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4.jet.su ([193.203.100.136]:18762 "EHLO mx4.jet.su"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755967AbdGKOy1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Jul 2017 10:54:27 -0400
Received: from [77.37.164.219] (helo=[30.0.0.6])
        by smtp.jet.su with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <glush@jet.msk.su>)
        id 1dUwNV-00029I-Oa
        for ceph-devel@vger.kernel.org; Tue, 11 Jul 2017 17:43:05 +0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello!

Unfortunately I didn't get any reply on ceph-users, so writing here.

It is clear what happens after OSD goes OUT - PGs are backfilled to other OSDs and PGs whose primary copies were on lost OSD gets new primary OSDs. But when OSD returns back it looks like all that data, for which the OSD was holding primary copies, are read from that OSD and re-written to other OSDs (to secondary copies). Am I right? If so, what is the reason to re-read copies from returned OSD? Wouldn't it be cheaper to just track modified ones?

Ceph Jewel 10.2.7. Below are links to collectd graphs during backfilling and recovery (node №8 was turned off and on for that).
Backfilling: https://pasteboard.co/GAs8VTD.png
Recovery: https://pasteboard.co/GAs93Ck.png

--
Dmitry Glushenok
Jet Infosystems

