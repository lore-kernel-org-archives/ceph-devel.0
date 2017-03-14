From: Loic Dachary <loic@dachary.org>
Subject: Predicting which OSD will fill up first
Date: Tue, 14 Mar 2017 10:39:15 +0100
Message-ID: <df3adc5b-019b-64ff-9a84-e8f1abc2932d@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44371 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdCNJjV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 05:39:21 -0400
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id C75CFA80D9
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 10:39:19 +0100 (CET)
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter22-d.gandi.net (mfilter22-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id erWLfncsN4_l for <ceph-devel@vger.kernel.org>;
        Tue, 14 Mar 2017 10:39:18 +0100 (CET)
Received: from [192.168.3.2] (x4db30e63.dyn.telefonica.de [77.179.14.99])
        (Authenticated sender: loic@dachary.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0E555A80E1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 10:39:15 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ceph,

Last week-end I wrote a script to show which hosts or OSD are the most overused. Then it occurred to me that it would be useful to a sysadmin wanting to keep an eye on the device usage. Some OSDs will fill up more quickly than others, there is no way around it (see http://tracker.ceph.com/issues/15653#detailed-explanation for the details) but that can easily be predicted and more space added to the cluster when necessary. For instance:

$ pip install crush
$ ceph osd crush dump > crushmap-ceph.json
$ crush ceph --convert crushmap-ceph.json > crushmap.json
$ crush analyze --type device --rule replicated --crushmap crushmap.json

                    ~id~  ~weight~  ~over/under used~
            ~name~
            osd.35    35  2.299988     10.400604
            osd.2      2  1.500000     10.126750
            osd.47    47  2.500000      5.543335
            osd.46    46  1.500000      2.956655
            osd.29    29  1.784988      2.506855
            ...

shows that more disks are needed when osd.35 reaches the threshold (80% full for instance). There is a blog post with more details at http://dachary.org/?p=3980

Cheers 
-- 
Loïc Dachary, Artisan Logiciel Libre
