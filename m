From: Chengguang Xu <cgxu519@icloud.com>
Subject: osdmap consistency during incremental applying in kernel client
Date: Mon, 12 Feb 2018 12:05:51 +0800
Message-ID: <302D379F-727B-489C-B257-633CF16577C8@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:60707 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932477AbeBLEF6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Feb 2018 23:05:58 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp001.me.com by
 pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P4000A00R3JZN00@pv33p36im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Mon, 12 Feb 2018 04:05:55 +0000 (GMT)
Received: from icloud.com ([127.0.0.1]) by pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0P4000I5LRDR1O20@pv33p36im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Mon, 12 Feb 2018 04:05:54 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi All,

In ceph kernel client, osdmap_apply_incremental() can fail by failing of
allocation memory in many places, in this case, current osdmap can not
keep consistency after applying failure.=20

I=A1=AFm not sure how much impact will be caused by this kind of =
inconsistency
but for safety it=A1=AFs better to keep osdmap consistency all the time =
even
failing from incremental applying.=20

I=A1=AFm trying to make some patches to fix this issue, but first of all =
please
let me know what do you think for this, I would be grateful if you could
share some ideas with me.



Thanks,
Chengguang.
