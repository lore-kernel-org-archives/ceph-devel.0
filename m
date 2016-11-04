From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: rocksdb wal proposed improvement
Date: Fri, 4 Nov 2016 17:06:31 +0000
Message-ID: <BY2PR02MB396573EAF55652571831CE3F4A20@BY2PR02MB396.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1611041605190.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0070.outbound.protection.outlook.com ([104.47.41.70]:41578
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932588AbcKDRGd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 13:06:33 -0400
In-Reply-To: <alpine.DEB.2.11.1611041605190.20331@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "g.marripudi@samsung.com" <g.marripudi@samsung.com>

Sage,
My understanding was rocksdb is already doing this kind of merge before flu=
sh. I thought It will always go through min_write_buffer_number_to_merge me=
mTable files and merge the updates, but, it will not be able to merge if sa=
me key update came beyond min_write_buffer_number_to_merge files. Am I miss=
ing anything ?

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Friday, November 04, 2016 9:06 AM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org; g.marripudi@samsung.com
Subject: rocksdb wal proposed improvement

Here's a quick write-up of what I think we should improve in rocksdb:

http://pad.ceph.com/p/rocksdb-wal-improvement

sage
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
