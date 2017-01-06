From: liuchang0812 <liuchang0812@gmail.com>
Subject: Question about RGW lifecycle support status
Date: Fri, 6 Jan 2017 21:17:28 +0800
Message-ID: <CACKY0b85oVx8TD8LBMO=fGw+thqjPM0N4-Wmbuv_1-reQMSrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33704 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753617AbdAFNSQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 08:18:16 -0500
Received: by mail-yw0-f179.google.com with SMTP id r204so369245961ywb.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2017 05:17:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

Our document says that "Bucket Lifecycle Not Supported" in
http://docs.ceph.com/docs/master/radosgw/s3/ . But it seems that there
are a lot of code about lc in RGW. I want to confirm whether RGW
supported LC.

Any comments appreciated. Thanks
