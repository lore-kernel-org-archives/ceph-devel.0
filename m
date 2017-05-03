From: Drunkard Zhang <gongfan193@gmail.com>
Subject: doc: dead link in doc template
Date: Wed, 3 May 2017 15:56:02 +0800
Message-ID: <CAJiejCQoJGWGOdkvzn3REKAzb0eLWdFpshM5XxRf0ieK+ZUONw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33143 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdECH4Y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 May 2017 03:56:24 -0400
Received: by mail-qk0-f176.google.com with SMTP id u68so8197873qkd.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 May 2017 00:56:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux-fs <ceph-devel@vger.kernel.org>

Hi cephers,

The link in doc template `doc/_templates/layout.html` is dead, what
the js file does, it seems no harm when removed.

Below is wget test result:

$ wget http://ayni.ceph.com/public/js/ceph.js
--2017-05-03 15:53:49--  http://ayni.ceph.com/public/js/ceph.js
Resolving ayni.ceph.com (ayni.ceph.com)... 158.69.67.53,
2607:5300:201:2000::3:58b1
Connecting to ayni.ceph.com (ayni.ceph.com)|158.69.67.53|:80... connected.
HTTP request sent, awaiting response... 404 Not Found
2017-05-03 15:54:07 ERROR 404: Not Found.

Can we remove it or fixup? Thx.
