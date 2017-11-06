From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: why not share last_complete in record_write_error
Date: Mon, 6 Nov 2017 19:17:36 +0800
Message-ID: <CANE=7sXMr3vD2qdHwyh0d55JJUcGzxBEF9u=_T1y91iXqpKw=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:52813 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbdKFLRh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Nov 2017 06:17:37 -0500
Received: by mail-pg0-f48.google.com with SMTP id a192so7942647pge.9
        for <ceph-devel@vger.kernel.org>; Mon, 06 Nov 2017 03:17:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

hi,

  In current record_write_error logic, we do not shard the
last_complete during peers. This cause that osd could not trim pg log,
and store tens of thousands of pg log in memory

This occurs when we remove a very large empty image and there are not
successful write.

-- 
Regards,
Xinze Chi
