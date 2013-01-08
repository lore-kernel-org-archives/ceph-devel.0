From: Yann ROBIN <yann.robin@youscribe.com>
Subject: Rados gateway init timeout with cache
Date: Tue, 8 Jan 2013 11:13:14 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C54E0E3624@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:14637
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755776Ab3AHLNX convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jan 2013 06:13:23 -0500
Received: from mail123-ch1 (localhost [127.0.0.1])	by
 mail123-ch1-R.bigfish.com (Postfix) with ESMTP id B5AB740022D	for
 <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 11:13:22 +0000 (UTC)
Received: from CH1EHSMHS023.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.245])	by mail123-ch1.bigfish.com (Postfix) with ESMTP id 75FCD80063
	for <ceph-devel@vger.kernel.org>; Tue,  8 Jan 2013 11:13:19 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We recently experienced issue with the backplane of our server, resulti=
ng in loosing half of our osd.
During that period the rados gateway failed initializing (timeout).
We found that the gateway was hanging in the init_watch function.

We recreate our OSDs and we still have this issue, but pg are not all i=
n an active+clean state :
=A0=A0 health HEALTH_WARN 1 pgs degraded; 1 pgs recovering; 2 pgs recov=
ery_wait; 3 pgs stuck unclean; recovery 7/10140464 degraded (0.000%); 3=
/5070232 unfound (0.000%); noout flag(s) set
=A0=A0 monmap e2: 3 mons at {ceph-mon-1=3D172.20.1.13:6789/0,ceph-mon-2=
=3D172.20.2.13:6789/0,ceph-mon-3=3D172.17.9.20:6789/0}, election epoch =
256, quorum 0,1,2 ceph-mon-1,ceph-mon-2,ceph-mon-3
=A0=A0 osdmap e4439: 6 osds: 6 up, 6 in
=A0=A0=A0 pgmap v2531184: 11024 pgs: 11019 active+clean, 2 active+recov=
ery_wait, 1 active+recovering+degraded+remapped, 2 active+clean+scrubbi=
ng+deep; 1291 GB data, 2612 GB used, 19645 GB / 22257 GB avail; 7/10140=
464 degraded (0.000%); 3/5070232 unfound (0.000%)
=A0=A0 mdsmap e1: 0/0/1 up

Should we open an ticket for this init issue with rados gateway ?
Version is 0.56.1 upgraded from 0.55.

--=20
Yann ROBIN
YouScribe


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
