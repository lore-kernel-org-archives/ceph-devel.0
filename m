From: Steve Capper <steve.capper@linaro.org>
Subject: Effects of varying page size on OSD writes
Date: Fri, 1 May 2015 15:54:22 +0100
Message-ID: <CAPvkgC1psL7xc8V_n+tzHoWdgLviyYw7T3m_Lg5Ej-kaMzYB7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38704 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbbEAOyX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 May 2015 10:54:23 -0400
Received: by igbhj9 with SMTP id hj9so40008775igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 May 2015 07:54:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,
Whilst testing Ceph 0.94.1 on 64-bit ARM hardware, I noticed that
switching the kernel PAGE_SIZE from 4KB to 64KB caused an increase by
a factor of ~6 in the total amount of data written to disk (according
to blktrace) by the OSD when running the RBD bench-write test (with
--io-pattern rand, --io-size=4096, --num-threads=16, --io-total=$((50
<< 20))).

Delving into the source, it is apparent that the FileJournal code uses
the current page size for the block size. I was wondering why
something like the block device sector size wasn't used instead? Is
there a mmap somewhere that I missed, or are fewer larger blocks
better for most use cases? (The use case above may be overly
contrived?).

Cheers,
--
Steve
