From: Thorwald Lundqvist <thorwald@jumpstarter.io>
Subject: Ceph kRBD stuck after disk crash
Date: Tue, 5 Aug 2014 15:59:32 +0200
Message-ID: <CAPZO0-O2eRt1t9o_aN6vZ88gwfT2MMcvjN-Y+-BiFkXHuPo3tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45749 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbaHEN7f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 09:59:35 -0400
Received: by mail-lb0-f179.google.com with SMTP id v6so733958lbi.24
        for <ceph-devel@vger.kernel.org>; Tue, 05 Aug 2014 06:59:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I've just experienced a disk crash in my ceph cluster. This seems to
have caused an error in the kernel since every I/O command sent to any
mapped RBD is defered indefinitely, even an hour later, the OSD is
already taken out of the cluster and ceph -s says HEALTH_OK.

A kernel dump is provided at this pastebin link: http://pastebin.com/WMqmiUsM

What did I do prior the crash?

I mapped one clean rbd device at /dev/rbd0 and one rbd device that had
a partition and ext4 filesystem at 20GB each

I started to dd rbd1 to rbd0 (dd if=/dev/rbd1 of=/dev/rbd0 bs=4M) It
copied a few GB, then deep-scrub started and at that moment one of the
disks failed. and dd got stuck (disk defered). And it still is.

I think that only a reboot of the server can fix this problem now.

This is not normal behavior when a disk crashes, right?

I'm running the linux kernel 3.15.7 and are using layered rbd devices.

Thank you for your time.
