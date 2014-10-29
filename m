From: GuangYang <yguang11@outlook.com>
Subject: OSD crashed due to filestore EIO
Date: Wed, 29 Oct 2014 13:27:15 +0000
Message-ID: <BLU175-W31E452BBB4E24DD455DA07DF9C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s23.hotmail.com ([65.55.111.162]:64814 "EHLO
	BLU004-OMC4S23.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932769AbaJ2N1P convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Oct 2014 09:27:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Recently we observed an OSD crash due to file corruption in filesystem,=
 which leads to an assertion failure at FileStore::read as EIO is not t=
olerated. As file corruption is normal in large deployment, I am thinki=
ng if that behavior is too aggressive, especially for EC pool.

After searching, I found this flag might help : filestore_fail_eio, whi=
ch can make the OSD survive an EIO failure, it is true by default thoug=
h. I haven't tested it yet.

Does it make sense to adjust the behavior a little bit, if the filestor=
e read fail due to file corruption, return back the failure and at the =
same time mark the PG as inconsistent, due the redundancy (replication =
or EC), the request can still be served, and at the same time, we can g=
et alert saying there is inconsistency and manually trigger a PG repair=
?

Thanks,
Guang
=A0 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
