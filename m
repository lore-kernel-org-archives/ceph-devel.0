From: Xinying Song <songxinying.ftd@gmail.com>
Subject: mds: where is mdr->slave_commit called?
Date: Sun, 22 Mar 2020 15:38:13 +0800
Message-ID: <CAMWWNq-8H8JJsPdL1JC9pOKMQY9LawZDRxfKa7Ag8MWGJbBY5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi1-f171.google.com ([209.85.167.171]:46876 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgCVHiZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Mar 2020 03:38:25 -0400
Received: by mail-oi1-f171.google.com with SMTP id q204so3600071oia.13
        for <ceph-devel@vger.kernel.org>; Sun, 22 Mar 2020 00:38:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, everyone:
Could anybody give some tips about how `mdr->slave_commit` is called?

As for `link_remote()`, steps are as follows:
1. master mds sends OP_(UN)LINKPREP to salve mds.
2. slave mds replys OP_LINKPREPACK to master mds after its journal has
been flushed.
3. master mds continues to process the client request.

I only find out there is a chance in MDCache::request_finish() that
`mdr->slave_commit` will be called. However, after a successful
journal flush, slave mds only sends an ACK to master mds and bypasses
MDCache::request_finish().
So when or where is `mdr->slave_commit` called?

Thanks!
