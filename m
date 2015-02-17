From: David Zafman <dzafman@redhat.com>
Subject: sage-2015-02-15_07:44:23-rados-hammer-distro-basic-multi failures
Date: Mon, 16 Feb 2015 17:40:35 -0800
Message-ID: <54E29C13.4000406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbbBQBkj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Feb 2015 20:40:39 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1H1ecvU012955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Mon, 16 Feb 2015 20:40:38 -0500
Received: from Davids-iMac.local (vpn-232-138.phx2.redhat.com [10.3.232.138])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t1H1eaKs018751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 16 Feb 2015 20:40:38 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


There were 24 failures before the run was killed.

758289 757223
=46AILED assert(weak_refs.empty()) "saw valgrind issues=E2=80=9D
=46iled bug #10901

757405
failed to become clean before timeout expired
osd.4 killed and never restarted, Thrasher may have died
=46iled bug #10902

758034:
mira038 disk I/O error ceph-1 on /dev/sdf
Sandon is aware

757087 757162 758292 758300 758071
already fixed bug #10784 Watch timeout

757177 757385 757506
No JSON object could be decoded bug #10630

757185
osd/ReplicatedPG.cc: 12991: FAILED assert(obc) bug #10820 (testing)

757431 757365
infrastructure - could not read lock status

757601 757777 757952
infrastructure - too many values to unpack (immediately after locking=20
machines)

757895
=46AILED assert(0 =3D=3D "racing read got wrong version"): already fixe=
d bug=20
#10830

758070 758244 757075 757251 757426
infrastructure?    Immediate osd crash ERROR: osd init failed: (1)=20
Operation not permitted

David Zafman


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
