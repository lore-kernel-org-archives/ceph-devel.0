From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: BlueStore::fsck() during mkfs()
Date: Wed, 31 Aug 2016 21:17:32 +0000
Message-ID: <BL2PR02MB211583CCF7ABCA3F4C0CABF7F4E30@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:1584
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754369AbcHaVRg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 17:17:36 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I saw with recent master we have introduced fsck() (and it is 'on' by defau=
lt) during mkfs() , wondering what is the use case of fsck() during mkfs() =
?
This is making cluster creation terribly slow for BlueStore.

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
