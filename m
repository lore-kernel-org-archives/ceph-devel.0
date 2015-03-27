From: Barclay Jameson <almightybeeij@gmail.com>
Subject: CephFS Slow writes with 1MB files
Date: Fri, 27 Mar 2015 11:40:38 -0500
Message-ID: <CAMzumdZo2jdHEnB55g1XOVTxc4JLq-+6JFFZSwjgox=9LOUdZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:35799 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbbC0Qki (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 12:40:38 -0400
Received: by qcfy6 with SMTP id y6so1611100qcf.2
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2015 09:40:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

I did a Ceph cluster install 2 weeks ago where I was getting great
performance (~= PanFS) where I could write 100,000 1MB files in 61
Mins (Took PanFS 59 Mins). I thought I could increase the performance
by adding a better MDS server so I redid the entire build.

Now it takes 4 times as long to write the same data as it did before.
The only thing that changed was the MDS server. (I even tried moving
the MDS back on the old slower node and the performance was the same.)

The first install was on CentOS 7. I tried going down to CentOS 6.6
and it's the same results.
I use the same scripts to install the OSDs (which I created because I
can never get ceph-deploy to behave correctly. Although, I did use
ceph-deploy to create the MDS and MON and initial cluster creation.)

I use btrfs on the OSDS as I can get 734 MB/s write and 1100 MB/s read
with rados bench -p cephfs_data 500 write --no-cleanup && rados bench
-p cephfs_data 500 seq (xfs was 734 MB/s write but only 200 MB/s read)

Could anybody think of a reason as to why I am now getting a huge regression.

Hardware Setup:
[OSDs]
64 GB 2133 MHz
Dual Proc E5-2630 v3 @ 2.40GHz (16 Cores)
40Gb Mellanox NIC

[MDS/MON new]
128 GB 2133 MHz
Dual Proc E5-2650 v3 @ 2.30GHz (20 Cores)
40Gb Mellanox NIC

[MDS/MON old]
32 GB 800 MHz
Dual Proc E5472  @ 3.00GHz (8 Cores)
10Gb Intel NIC
