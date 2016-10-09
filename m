From: Songbo Wang <songbo1227@gmail.com>
Subject: issue about the parameter 'paxos_propose_interval'
Date: Sun, 9 Oct 2016 15:41:59 +0800
Message-ID: <CAHRQ3VVecRDO1kf8BdtB6jd9rZVF+C42r8xDBYhjLvMoosMcng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35833 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbcJIHmY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Oct 2016 03:42:24 -0400
Received: by mail-wm0-f44.google.com with SMTP id f193so99543260wmg.0
        for <ceph-devel@vger.kernel.org>; Sun, 09 Oct 2016 00:42:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Sage, Sam

I got a issue about the parameter 'paxos_propose_interval' with the
default value 1.0.

I think this parameter aim to reduce the Monitor pressure to call the
propose_pending(). But, this introduces another problem, when a osd is
started,  it will send 3 kinds of requests to Monitor (e.g. MOSDBoot,
MOSDPGTemp, MOSDAlive). Without other changes, It will take 3 seconds
at least. which will increase the time that blocks the whole cluster.

If the parameter 'paxos_propose_interval' is set to 0.05 or smaller,
it loses the propse it designed.

I think we can introduce some special process, for some kinds of
messages (e.g. MOSDPGTemp, MOSDAlive), to process them immediately.

Regards
