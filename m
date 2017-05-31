From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: teuthology SELinux failures
Date: Wed, 31 May 2017 13:23:28 -0700
Message-ID: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:32926 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdEaUXa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 May 2017 16:23:30 -0400
Received: by mail-qt0-f175.google.com with SMTP id t26so21555457qtg.0
        for <ceph-devel@vger.kernel.org>; Wed, 31 May 2017 13:23:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Boris Ranto <branto@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

We started seeing SELinux related failures in recent teuthology run, e.g.:
http://pulpito.ceph.com/yehudasa-2017-05-30_14:55:10-rgw-wip-rgw-mdsearch---basic-smithi/

It seems that it's unrelated to the runs themselves, possibly postfix
that's running in the background is triggering these. Any idea what we
should do there?

Yehuda
