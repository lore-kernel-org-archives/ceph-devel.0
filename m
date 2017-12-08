From: kefu chai <tchaikov@gmail.com>
Subject: build on centos-7 and trusty
Date: Fri, 8 Dec 2017 13:28:14 +0800
Message-ID: <CAJE9aOPA03dJmJKfwch+XkgzYh8uUBNa0TkUFHu=AK0fJ4G=kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36991 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbdLHF2Q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Dec 2017 00:28:16 -0500
Received: by mail-qt0-f177.google.com with SMTP id f2so23540780qtj.4
        for <ceph-devel@vger.kernel.org>; Thu, 07 Dec 2017 21:28:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi developers building master and mimic-dev1 on centos-7 and/or trusty,

please use install-deps.sh to install the gcc-7 for compiling Ceph. as
from now on, we will need GCC >= 5.1 [1] for better C++11 support.

cheers,

---
[1] https://github.com/ceph/ceph/pull/19344

-- 
Regards
Kefu Chai
