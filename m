From: Ketor D <d.ketor@gmail.com>
Subject: [Issue]Ceph cluster hang due to network partition
Date: Tue, 14 Apr 2015 11:59:50 +0800
Message-ID: <CAM9_UU9SwjQ1FxYHcT2wrXwi1oCH5xuwRJQ9D-rwHwATTusTZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35960 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbbDNEAa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Apr 2015 00:00:30 -0400
Received: by qku63 with SMTP id 63so217310773qku.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 21:00:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
      We recently meet a network partition problem, cause our ceph
cluster can not service rbd service.
       We are running 0.67.5 on our customer cluster. And the network
partition is 3 osd can connect mon, but can not connect with all other
osds.
       Then many PGs fall in peering status, and rbd I/O is hang.

        Before we operate the cluster , I set nout flag and stop the 3
OSDs. After operating the 3 OSDs memory and OS bootup, the network is
partition. The 3 OSDs start, then many PGs went to peering.
I stoped the 3 OSDs process, but the PGs fall in peering.
        After network partition is fixed, all PG get active+clean, all is OK.

        I can't explain this, because I think the OSD can judge if the
other OSD is alive, and I can see 3OSD is marked down in 'ceph osd
tree'.
        Why did these PGs fall in peering?

Thanks!
Ketor
