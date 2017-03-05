From: Loic Dachary <loic@dachary.org>
Subject: python-crush to experiment with crush
Date: Sun, 5 Mar 2017 08:49:00 +0100
Message-ID: <601e709f-cbfc-a1e6-830e-7edf007470da@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51479 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdCEHtG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Mar 2017 02:49:06 -0500
Received: from mfilter14-d.gandi.net (mfilter14-d.gandi.net [217.70.178.142])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 7074FA80C4
        for <ceph-devel@vger.kernel.org>; Sun,  5 Mar 2017 08:49:03 +0100 (CET)
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter14-d.gandi.net (mfilter14-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id opAq2zqLwCgt for <ceph-devel@vger.kernel.org>;
        Sun,  5 Mar 2017 08:49:01 +0100 (CET)
Received: from [192.168.1.8] (65.78.31.93.rev.sfr.net [93.31.78.65])
        (Authenticated sender: loic@dachary.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A47A3A80C7
        for <ceph-devel@vger.kernel.org>; Sun,  5 Mar 2017 08:49:01 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

While researching the crush multipick anomaly[1], Pedro López-Adeva Fernández-Layos came up with a problem statement and a python implementation[2]. It is work in progress and it seemed useful to have a python module implementing crush to help with experimentations. The python-crush[3] module was written for that purpose last week and published on PyPI. It proposes an API with two functions (parse the crushmap & map an object). The crushmap is a python object and is fully documented[4].

Although python-crush is usable as it is, noone should depend on it right now because two important aspects need to be discussed:

  - should the API be different ?
  - is the crushmap format ok ?

In other words, the current python-crush module is a basis for discussion and there is a good chance both the API and the crushmap are completely different in a few weeks.

Cheers

[1] crush multipick anomaly http://marc.info/?l=ceph-devel&m=148539995928656&w=2
[2] https://github.com/plafl/notebooks/blob/master/converted/replication.pdf
[3] python-crush http://crush.readthedocs.io/
[4] crushmap documentation http://crush.readthedocs.io/en/latest/api.html#crush.Crush.parse

-- 
Loïc Dachary, Artisan Logiciel Libre
