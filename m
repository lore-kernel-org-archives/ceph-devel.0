From: =?UTF-8?B?5LqO55u45rSL?= <penglaiyxy@gmail.com>
Subject: [ceph-users] Questions about pg num setting
Date: Wed, 27 Dec 2017 02:15:53 +0000
Message-ID: <CAE5T3NwPo5edTkm+4DOPKFAyuCXWOEj0SMoHrLEkoFyn+ipP-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:40403 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdL0CPz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Dec 2017 21:15:55 -0500
Received: by mail-wm0-f43.google.com with SMTP id f206so37090488wmf.5
        for <ceph-devel@vger.kernel.org>; Tue, 26 Dec 2017 18:15:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

Hi cephers,

I have two questions about pg number setting.

First :
My storage informaiton is show as belows:
HDD: 10 * 8TB
CPU: Intel(R) Xeon(R) CPU E5645 @ 2.40GHz (24 cores)
Memery: 64GB

As my HDD capacity and my Mem is too large, so I want to set as many
as 300 pgs to each OSD. Although 100 pgs per OSD is perferred. I want
to know what is the disadvantage of setting too many pgs?


Second:
At begin ,I can not judge the capacity proportion of my workloads, so
I can not set accurate pg numbers of different pools. How many pgs
should I set for each pools first?
