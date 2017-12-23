From: Oleg Kolosov <olekol@gmail.com>
Subject: Primary OSD not as first shard in PG - LRC experiment
Date: Sat, 23 Dec 2017 18:55:11 +0200
Message-ID: <CAODUPsGX3zXP0RTOs8EcPFDMTwd4=4i_yL2Pg02WqxgbB82XTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:40482 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdLWQzM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Dec 2017 11:55:12 -0500
Received: by mail-oi0-f52.google.com with SMTP id w125so20744297oie.7
        for <ceph-devel@vger.kernel.org>; Sat, 23 Dec 2017 08:55:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
When ceph selects an OSD to act as primary, it is the first shard in
the PG (shard[0]). When working with LRC plugin, this constraint
greatly diminishes LRC's advantage. Ceph LRC plugin allows grouping of
OSD, so that recovery would occur between them (local groups).
However, since all recovery has to go through the primary OSD, in fact
the recovery isn't really local. Only in case the primary OSD is in
the same local group which contains the failed OSD the recovery is
local.

I'm running LRC experiments on ceph and measure recovery by crashing a
specific OSD. In order to bypass this and make LRC truly effective in
my experiments, I was wondering if it is possible to manipulate the
choice of the primary OSD.

For example, if I have a bucket which contains OSDs 0-10, and I always
kill one of them, is it possible to force the primary also to be OSD
0-10 ?

Thanks,
Oleg
