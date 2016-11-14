From: Tianshan Qu <qutianshan@gmail.com>
Subject: rgw/multisite: unlock failure problem
Date: Mon, 14 Nov 2016 14:40:54 +0800
Message-ID: <CAEv+sP6p9sdMt61yucxy10azo5jwQf-e765YbcHvDYQcXrfWPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33056 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbcKNGk4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 01:40:56 -0500
Received: by mail-ua0-f172.google.com with SMTP id 20so55976609uak.0
        for <ceph-devel@vger.kernel.org>; Sun, 13 Nov 2016 22:40:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi:

There is a problem with unlock multiste sync log.
The situation is set rgw_num_rados_handles > 1 and
rgw_num_async_rados_threads default 32. since multisite use async
thread pool, so lock and unlock operation may get different threads,
which may direct to different rados handles, and lock operation use
client.xxxx to identify owner, different rados handles means different
client, leads to unlock fail, and next lock will return locked, rgw
log will show many -16 error.
Is there a good way to solve this?
