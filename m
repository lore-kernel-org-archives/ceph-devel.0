From: Willem Jan Withagen <wjw@digiware.nl>
Subject: cannot do ceph pg dump
Date: Sun, 2 Jul 2017 13:45:12 +0200
Message-ID: <7e8f4b8a-8a85-8356-0f56-485d02696fd2@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:36358 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdGBLpS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 2 Jul 2017 07:45:18 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id E601144D95
        for <ceph-devel@vger.kernel.org>; Sun,  2 Jul 2017 13:45:14 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I can rebuild the cluster, and fix it for mgr, but that is not the point
of my message:

---
root@cephtest:/zfs/home/wjw # ceph pg dump
Error EACCES: access denied' does your client key have mgr caps? See
http://docs.ceph.com/docs/master/mgr/administrator/#client-authentication
---

When I try to follow that link, it does not really work, because the
actual link on that page to give the instructions how to do this, tha
page does not exist.

--WjW

