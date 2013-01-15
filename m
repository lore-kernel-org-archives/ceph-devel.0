From: jie sun <0maidou0@gmail.com>
Subject: mon down
Date: Tue, 15 Jan 2013 16:37:48 +0800
Message-ID: <CAB6Jr7RiHwYnSAGjzLG=8ises4VwsfX3xDRep0e2sHChB1B_Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56548 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845Ab3AOIhs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 03:37:48 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2781546pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 00:37:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,
    I have done some tests nowadays. I made a ceph cluster with 1 mon
1 mds and 10 osds. Then I made a block device(use "rbd create/rbd
map/.." mount it do a virtual machine as a disk). I stored some data
on the disk and broke down the mon.
    I want to know if there is any way to find out my data with some
operations? Can I recreate a mon to take the place of the mon before?
    Any suggestions are welcome, thank you.
