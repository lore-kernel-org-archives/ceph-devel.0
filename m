From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: BlueFS per counter
Date: Thu, 13 Oct 2016 17:36:50 +0000
Message-ID: <BY2PR02MB396B782E390FC09E10A8E97F4DC0@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0054.outbound.protection.outlook.com ([104.47.37.54]:13664
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752030AbcJMTNt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Oct 2016 15:13:49 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I found the following counters are tracking (from _flush_range()) the numbe=
r of WAL and SST writes happening in rocksdb. Based on the today's discussi=
on on characterizing rocksdb write pattern, isn't these two counters are he=
lpful ?

l_bluefs_bytes_written_wal
l_bluefs_bytes_written_sst

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
