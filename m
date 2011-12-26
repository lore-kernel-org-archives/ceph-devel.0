From: Leander Yu <leander.yu@gmail.com>
Subject: Some Question Regarding to RBD performance
Date: Mon, 26 Dec 2011 21:34:01 +0800
Message-ID: <CAA9wQNfSH=8ei6Kk8VQ6nWELhL5SV0eXFHv58WkPL4bFQsjtqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38801 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab1LZNeD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Dec 2011 08:34:03 -0500
Received: by iaeh11 with SMTP id h11so18904007iae.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Dec 2011 05:34:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I have a question regarding to RBD performance. Recently I test RBD in
2 cluster, using dd if=/dev/zero of=/dev/rbd5 bs=4M count=1024
oflag=direct. I got 33.4MB/s in one cluster , however got only 6MB/s
in the other cluster.

I have confirmed that the network bandwidth is ok. and osd bench shows
around 32 ~ 40 MB/s on all OSD. Is this performance normal? if not ,
how can I troubleshoot it?
I have move journal to ramdisk for testing and get performance boost
to 7x MB/s. Does this means the HDD is the bottleneck ?

The other cluster that got 33.4 MB/s , it's osd bench shows around
44MB/s. The major difference between those two cluster is the better
performed one use SAS with RAID controller the other use SATA with no
RAID control.

Thanks.

Regards,
Leander Yu.
