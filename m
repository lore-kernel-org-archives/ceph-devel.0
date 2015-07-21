From: Dan van der Ster <dan@vanderster.com>
Subject: hdparm -W redux, bug in _check_disk_write_cache for RHEL6?
Date: Tue, 21 Jul 2015 11:31:16 +0200
Message-ID: <CABZ+qq=NDjKsQfqshVTzoPoC7PW2MPW1Q8MgvvmJfNGqhp0feQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33367 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbbGUJb7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 05:31:59 -0400
Received: by lbbyj8 with SMTP id yj8so111856602lbb.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 02:31:57 -0700 (PDT)
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com. [209.85.217.182])
        by smtp.gmail.com with ESMTPSA id l5sm5876503lal.29.2015.07.21.02.31.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 02:31:56 -0700 (PDT)
Received: by lbbyj8 with SMTP id yj8so111856044lbb.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 02:31:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Following the sf.net corruption report I've been checking our config
w.r.t data consistency. AFAIK the two main recommendations are:

  1) don't mount FileStores with nobarrier
  2) disable write-caching (hdparm -W 0 /dev/sdX) when using block dev
journals and your kernel is < 2.6.33

Obviously we don't do (1) because that would be crazy, but for (2) we
didn't disable yet write-caching, probably because we didn't notice
the doc.

But my lame excuse is that apparently _check_disk_write_cache in
FileJournal.cc doesn't print a warning when it should, because hdparm
-W doesn't always work on partitions rather than whole block devices.
See:

GOOD: ceph 0.94.2, kernel 3.10.0-229.7.2.el7.x86_64, hdparm v9.43:

   10 journal _open_block_device: ignoring osd journal size. We'll use
the entire block device (size: 21474836480)
   20 journal _check_disk_write_cache: disk write cache is on, but
your kernel is new enough to handle it correctly.
(fn:/var/lib/ceph/osd/ceph-96/journal)
    1 journal _open /var/lib/ceph/osd/ceph-96/journal fd 20:
21474836480 bytes, block size 4096 bytes, directio = 1, aio = 1


BAD: ceph 0.94.2, kernel 2.6.32-431.29.2.el6.x86_64, hdparm v9.43:

   10 journal _open_block_device: ignoring osd journal size. We'll use
the entire block device (size: 21474836480)
    1 journal _open /var/lib/ceph/osd/ceph-56/journal fd 19:
21474836480 bytes, block size 4096 bytes, directio = 1, aio = 1


In other words, running hammer on EL6, _check_disk_write_cache exits
without printing anything, but actually it should log the scary
"WARNING: disk write cache is ON".

I guess it's because of this:

GOOD # uname -r && hdparm -W /dev/sda && hdparm -W /dev/sda1
3.10.0-229.7.2.el7.x86_64

/dev/sda1:
 write-caching =  1 (on)

/dev/sda:
 write-caching =  1 (on)


BAD # uname -r && hdparm -W /dev/sda && hdparm -W /dev/sda1
2.6.32-431.23.3.el6.x86_64

/dev/sda:
 write-caching =  1 (on)

/dev/sda1:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device


(in both cases /dev/sda is an INTEL SSDSC2BA20).

So a few questions to end this:
  1) What was the magic patch in 2.6.33 which made write-caching safe?
  2) What's the recommended recourse here: hopefully Red Hat
backported the necessary to their 2.6.32 kernel, but if not should we
fix _check_disk_write_cache and make some publicity for people to
check their configs?

Best Regards,

Dan
