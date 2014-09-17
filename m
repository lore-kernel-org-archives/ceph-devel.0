From: =?UTF-8?B?5aea5a6B?= <zay11022@gmail.com>
Subject: puzzled with the design pattern of ceph journal, really ruining performance
Date: Wed, 17 Sep 2014 14:29:22 +0800
Message-ID: <CALZt5jz45E_KLHYgmT0eCYc9RJ7wMWuzqk6VeJthMyX98YEytg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f66.google.com ([209.85.219.66]:47090 "EHLO
	mail-oa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaIQG3X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 02:29:23 -0400
Received: by mail-oa0-f66.google.com with SMTP id o6so176763oag.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Sep 2014 23:29:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, guys

I analyze the architecture of the ceph souce code.

I know that, in order to keep journal atomic and consistent, the
journal write mode should be set with O_DSYNC or called fdatasync()
system call after every write operation. However, this kind of
operation is really killing the performance as well as achieving high
committing latency, even if SSD is used as journal disk. If the SSD
has capacitor to keep the data safe when the system crashes, we can
set the mount option nobarrier or SSD itself will ignore the FLUSH
REQUEST. So the performance would be better.

So can it be instead by other strategies?
As far as I am concerned, I think the most important part is pg_log
and pg_info. It will guides the crashed osd recovery its objects from
the peers. Therefore, if we can keep pg_log at a consistent point, we
can recovery data without journal. So can we just use an "undo"
strategy on pg_log and neglect ceph journal?  It will save lots of
bandwidth, and also based on the consistent pg_log epoch, we can
always recovery data from its peering osd, right? But this will lead
to recovery more objects if the osd crash.

Nicheal
