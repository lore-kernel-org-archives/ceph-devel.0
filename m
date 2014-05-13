From: Mike <mike.almateia@gmail.com>
Subject: Change size journal's blocks from 4k to another.
Date: Tue, 13 May 2014 11:22:26 +0400
Message-ID: <5371C832.70406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:43735 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbaEMHWa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 03:22:30 -0400
Received: by mail-lb0-f182.google.com with SMTP id q8so8316000lbi.13
        for <ceph-devel@vger.kernel.org>; Tue, 13 May 2014 00:22:29 -0700 (PDT)
Received: from localhost.localdomain ([212.34.43.122])
        by mx.google.com with ESMTPSA id o1sm2639438lbw.27.2014.05.13.00.22.27
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 00:22:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello.

I am also sent this message to ceph-users@ maillist, but nobody answer
me. If this topic is inappropriate for this maillist I am already to
apologize.

In my Ceph installation I am uses a ssd drive for journal with direct
access.

When an osd started I see in log file this string:
...
1 journal _open /dev/sda1 fd 22: 19327352832 bytes, block size 4096
bytes, directio = 1, aio = 1
...

How I can change size of block from 4k to 512k, because my SSD show
better perfomance witch large blocks:
* With 4K (sdr6 - source, sda8 - target)

dd if=/mnt/from/random of=/mnt/sda8/random bs=4k oflag=direct,dsync

iostat show me the statistic:
iostat -cdm 1 /dev/sda /dev/sdr

Device:            tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda           16198.00         0.00       126.54          0        126
sdr             126.00        15.75         0.00         15          0


* With 512K (sdr6 - source, sda8 - target)
Sync: sync
Clear cache: echo 1 > /proc/sys/vm/drop_caches
Clear cache LSI controller: megacli -AdpCacheFlush -a0

dd if=/mnt/from/random of=/mnt/sda8/random bs=512k oflag=direct,dsync

iostat show me the statistic:
iostat -cdm 1 /dev/sda /dev/sdr

Device:            tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            3021.00         0.01       318.00          0        318
sdr            2410.00       301.25         0.00        301          0

I think my cluster have a bottle neck in journal block size. How I can
increase the size of block for journal?

--
Best regards, Mike.
