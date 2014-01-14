From: GuangYang <yguang11@outlook.com>
Subject: Ceph cluster is unreachable because of authentication failure
Date: Tue, 14 Jan 2014 20:04:14 +0800
Message-ID: <BLU0-SMTP1356EEDE6A8ACF94947F22ADFBF0@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu0-omc4-s36.blu0.hotmail.com ([65.55.111.175]:29784 "EHLO
	blu0-omc4-s36.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375AbaANMJZ convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Jan 2014 07:09:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi ceph-users and ceph-devel,
I came across an issue after restarting monitors of the cluster, that a=
uthentication fails which prevents running any ceph command.

After we did some maintenance work, I restart OSD, however, I found tha=
t the OSD would not join the cluster automatically after being restarte=
d, though TCP dump showed it had already sent messenger to monitor tell=
ing add me into the cluster.

So that I suspected there might be some issues of monitor and I restart=
ed monitor one by one (3 in total), however, after restarting monitors,=
 all ceph command would fail saying authentication timeout=85

2014-01-14 12:00:30.499397 7fc7f195e700  0 monclient(hunting): authenti=
cate timed out after 300
2014-01-14 12:00:30.499440 7fc7f195e700  0 librados: client.admin authe=
ntication error (110) Connection timed out
Error connecting to cluster: Error

Any idea why such error happened (restarting OSD would result in the sa=
me error)?

I am thinking the authentication information is persisted in mon local =
disk and is there a chance those data got corrupted?

Thanks,
Guang--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
