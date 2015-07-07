From: Haomai Wang <haomaiwang@gmail.com>
Subject: About Adding eventfd support for LibRBD
Date: Tue, 7 Jul 2015 23:18:58 +0800
Message-ID: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33735 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbbGGPS7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 11:18:59 -0400
Received: by ykeo3 with SMTP id o3so60104221yke.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2015 08:18:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Jason Dillaman <dillaman@redhat.com>

Hi All,

Currently librbd support aio_read/write with specified
callback(AioCompletion). It would be nice for simple caller logic, but
it also has some problems:

1. Performance bottleneck: Create/Free AioCompletion and librbd
internal finisher thread complete "callback" isn't a *very
littleweight" job, especially when "callback" need to update some
status with lock hold

2. Call logic: Usually like fio rbd engine, caller will maintain some
status with io and rbd callback isn't enough to finish all the jobs
related to io. For example, caller need to check each queued io
stupidly again when rbd callback finished.

So maybe we could add new api which support eventfd, so caller could
add eventfd to its event loop and batch reap finished io event and
update status or do more things.

Any feedback is appreciated!

-- 
Best Regards,

Wheat
