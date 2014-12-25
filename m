From: Nicheal <zay11022@gmail.com>
Subject: why do we need SNAPDIR ?
Date: Thu, 25 Dec 2014 11:27:30 +0800
Message-ID: <CALZt5jwj=9KXTJu-T-bWqMXw9FHhbGen9QJfZ5fFDg_7jv3HhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51131 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbaLYD1b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Dec 2014 22:27:31 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so30505757obc.8
        for <ceph-devel@vger.kernel.org>; Wed, 24 Dec 2014 19:27:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear develops,

I find that SNAPDIR means a special object in ceph. It is a read-only
object since if a op write want to modify SNAPDIR object, it return
-EINVAL immediately. But I cannot find when we need to create the
SNAPDIR object? and what is used for?

Based on my understanding, ceph snapshot is realized by snap_set Xattr
and snapperMapper in omap. It does not cooperate with SNAPDIR object,
so I am puzzled. Can anyone provide some guides to understand this?


Regards,
Ning Yao
