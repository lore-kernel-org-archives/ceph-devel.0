From: denval re <redenval@gmail.com>
Subject: How can rbd image qos take effect
Date: Wed, 24 Jan 2018 12:23:06 +0800
Message-ID: <CACGTc=E=dSdB4xWeWevqVu0Zwj1YZvP4XpLy=GOdWjnW6FaimA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34151 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932947AbeAXEXH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jan 2018 23:23:07 -0500
Received: by mail-io0-f180.google.com with SMTP id c17so3397302iod.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jan 2018 20:23:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dongsheng.yang@easystack.cn
Cc: ceph-devel@vger.kernel.org

Hi,dongsheng (and cc ceph-devel)

I've updated my code with ceph master and compiled it, according to
the description of pr ''rbd: implement image qos in tokenbucket
algorithm",   using the command "rbd image-meta set test
conf_rbd_qos_iops_limit IOPS" could  limit the R&W iops of rbd image.

Then I use vstart.sh script to start my cluster, but using fio tool
with rbd ioengine way to randwrite rbd image, there is no effect to
limit IOPS with the above command, Is there something wrong with my
operation or is there some other setting that must set?

Any advice will be appreciated.
Thank you!
