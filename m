From: Libin Wu <hzwulibin@gmail.com>
Subject: poor performance when recovering
Date: Mon, 7 Dec 2015 21:45:57 +0800
Message-ID: <CAN4gH2P0WeVxXd1hDbc5T_-_2mBd4wsAiqDt=9sFXnY=AgikZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36247 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbbLGNp7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 08:45:59 -0500
Received: by wmec201 with SMTP id c201so27749679wme.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Dec 2015 05:45:57 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>, ceph-users <ceph-users@ceph.com>

Hi, cephers

I'm doing the performance test of ceph when recovering. The scene is si=
mple:
1. run fio on 6 krbd device
2. stop one OSD for 10 seconds
3. start that OSD

However, when the OSD up and start recovering, the performance of fio
drop down from 9k to 1k for about 20 seconds. At the same tiime, we
found the SSD of that OSD's latency is more than 100ms, so it seems
the SSD become the bottleneck=E3=80=82

So we want to slow down the recovery speed to lighten the load of the
SSD when recovery. But configuration like:
    osd_recovery_max_active
    osd_recovery_max_chunk
    osd_max_backfills
    osd_recovery_op_priority
are all useless.

After reading and change some code, we want add a flow control in the
process of:
    OSD::do_recovery

So, will it be possible to do so and if this solution has some
potential problem?

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
