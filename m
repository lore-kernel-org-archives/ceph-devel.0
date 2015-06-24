From: GuangYang <yguang11@outlook.com>
Subject: radosgw crash within libfcgi
Date: Wed, 24 Jun 2015 10:09:58 -0700
Message-ID: <BLU175-W1310E96C473E9ABED62D65DFAF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s9.hotmail.com ([65.55.111.148]:54028 "EHLO
	BLU004-OMC4S9.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbbFXRJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 13:09:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "yehuda@redhat.com" <yehuda@redhat.com>

Hello Cephers,
Recently we have several radosgw daemon crashes with the same following=
 kernel log:

Jun 23 14:17:38 xxx kernel: radosgw[68180]: segfault at f0 ip 00007ffa0=
69996f2 sp 00007ff55c432710 error 6 in libfcgi.so.0.0.0[7ffa06995000+a0=
00] in libfcgi.so.0.0.0[7ffa06995000+a000]

Looking at the assembly, it seems crashing at this point - http://githu=
b.com/sknown/fcgi/blob/master/libfcgi/fcgiapp.c#L2035, which confused m=
e. I tried to see if there is any other reference holding the FCGX_Requ=
est which release the handle without any luck.

There are also other observations:
=A01> Several radosgw daemon across different hosts crashed around the =
same time.
=A02> Apache's error log has some fcgi error complaining ##idle timeout=
## during the time.

Does anyone experience similar issue?=A0

Thanks,
Guang=A0 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
