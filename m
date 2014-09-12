From: Haomai Wang <haomaiwang@gmail.com>
Subject: [RFC]New Message Implementation Based on Event
Date: Fri, 12 Sep 2014 11:09:59 +0800
Message-ID: <CACJqLybDH97G8do8UfLJd+BKz1Oq9wKneasg8P7L2z9ozCewEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:45806 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbaILDKA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 23:10:00 -0400
Received: by mail-we0-f173.google.com with SMTP id u56so95643wes.32
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 20:09:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Samuel Just <sam.just@inktank.com>, Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

Recently, I did some basic work on new message implementation based on
event(https://github.com/yuyuyu101/ceph/tree/msg-event). The basic
idea is that we use a Processor thread for each Messenger to monitor
all sockets and dispatch fd to threadpool. The event mechanism can be
epoll, kqueue, poll or select. The thread in threadpool will
read/write with this socket and dispatch message later.

Now the branch has passed basic tests and before make it more stable
and pass more QA suites. I want to do some benchmark tests compared to
pipe implementation with large-scale cluster. I would like to use at
least 100 OSDs(SSD) and hundreds of clients to test it. And now the
benchmark for only one OSD, the client can get the same latency with
pipe implementation and the latency stdev will be smaller.

The background for this implementation is that pipe implementation
consumes too much overhead on context switch and thread resource. In
our env, several ceph-osd is running on compute node which also runs
KVM process.

Do you have any ideas about this, or some serious concerns compared to pipe.

-- 

Best Regards,

Wheat
