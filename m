From: star fan <jfanix@gmail.com>
Subject: can we shrink the lock of ThreadPool::worker
Date: Tue, 16 Sep 2014 10:24:05 +0800
Message-ID: <CAOdVJi0cx6fdGDZ+8B7YA4VyXzOnPm40TaG_FN8Nq4oMRWwT4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f194.google.com ([209.85.212.194]:47566 "EHLO
	mail-wi0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbaIPCYH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 22:24:07 -0400
Received: by mail-wi0-f194.google.com with SMTP id n3so2278464wiv.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 Sep 2014 19:24:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>

Now, I found _void_dequeue() and _void_process_finish both run with
lock. I think they can run without lock to promote threadpool
performance
