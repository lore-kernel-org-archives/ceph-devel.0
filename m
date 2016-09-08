From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore memory leak
Date: Thu, 8 Sep 2016 01:08:16 +0000
Message-ID: <BL2PR02MB21153E4497C3C2364B543BAEF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0047.outbound.protection.outlook.com ([104.47.33.47]:54404
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751284AbcIHBIS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Sep 2016 21:08:18 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
As Mark said, the latest code has severe memory leak , my system memory (64=
GB) started swapping after 3 min of 4K RW run.

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
