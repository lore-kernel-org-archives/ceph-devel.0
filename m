From: sw zhang <zhangsw1001@gmail.com>
Subject: Useless data in multipart upload
Date: Fri, 6 Jan 2017 14:20:22 +0800
Message-ID: <CAHjSqiZ=XbF7E=H-kV5EfjnhrUpeMHRRjdYJGwmDD2+x1OTVFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36800 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937845AbdAFGUY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 01:20:24 -0500
Received: by mail-lf0-f41.google.com with SMTP id x140so41088761lfa.3
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jan 2017 22:20:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda <yehuda@redhat.com>, Casey Bodley <cbodley@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

If users don't complete or abort the multipart uploading and then
delete their bucket, the parts those have been uploaded are not
deleted and will exist forever. Even we delete the user, these useless
data still exist.
At present, we can use the orphan tool to find these data. But it
really costs too much time if the data pool has many objects. Can we
clean the useless data when the users delete their buckets? Or some
other method
to handle this problem?

Thanks a lot,

Zhang Shaowen
