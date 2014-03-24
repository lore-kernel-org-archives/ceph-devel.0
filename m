From: Haomai Wang <haomaiwang@gmail.com>
Subject: [librbd] Add interface of get the snapshot size?
Date: Mon, 24 Mar 2014 21:30:44 +0800
Message-ID: <CACJqLybccTqhcumeP33LTY8_s7zxjyuodU-bdKFL9a1cM28dVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:41116 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbaCXNao (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Mar 2014 09:30:44 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so5289077pdi.5
        for <ceph-devel@vger.kernel.org>; Mon, 24 Mar 2014 06:30:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

As we know, snapshot is a lightweight resource in librbd and we
doesn't have any statistic informations about it. But it causes some
problems to the cloud management.

We can't measure the size of snapshot, different snapshot will occur
different space. So we don't have way to estimate the resource usage
of user.

Maybe we can have a counter to record space usage when volumn created.
When creating snapshot, the counter is freeze and store as the size of
snapshot. New counter will assign to zero for the volume.

Any feedback is appreciate!

-- 

Best Regards,

Wheat
