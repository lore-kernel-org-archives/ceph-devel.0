From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: cephfs issue, get_reply data > preallocated
Date: Mon, 24 Apr 2017 11:51:04 -0400
Message-ID: <CAGbvivLexKgh7L5hhLXjWSJiPj-nEwuxC4O3Hefxt5WGWjHpgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35932 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972078AbdDXPvG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 11:51:06 -0400
Received: by mail-it0-f44.google.com with SMTP id g66so830094ite.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Apr 2017 08:51:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Ubuntu 16.04.1
Ceph 10.2.5
Linux 4.9.10 kernel

We are having problems accessing some files in cephfs, the process
reading the files become hung when trying to read them (md5sum, for
example).  When these hangups occur, there are messages in the system
logs that look like this:

"libceph: get_reply osd6 tid 55 data 1305852 > preallocated 1048576, skipping"

The cluster shows healthy status and all OSD are reporting as up/up.

Wondering if our hanging read issues are related to the messages being
reported, they seem to be since we only see the messages once we
encounter the issue reading the files.

Wyllys Ingersoll
Keeper Technology, LLC
