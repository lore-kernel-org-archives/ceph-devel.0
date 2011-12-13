From: <Eric_YH_Chen@wistron.com>
Subject: How to know the status of the monitors?
Date: Tue, 13 Dec 2011 17:12:58 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D9DD46F@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=BIG5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw4.wistron.com ([220.128.89.24]:58583 "EHLO
	TWNHUMSW4.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab1LMJNB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2011 04:13:01 -0500
Received: from TWNHUFE4.whq.wistron (unverified [10.37.31.104]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta144d6ada8c0a81672bec@TWNHUMSW4.wistron.com> for <ceph-devel@vger.kernel.org>;
 Tue, 13 Dec 2011 17:17:34 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wistron.com, Alex_KT_Lin@wistron.com

Hi, all:

    Is there any command or API can retrieve the status of all monitors=
?

    I use =A1=A5ceph mon stat=A1=A6 to get this information. However, t=
he mon.e is not available (server is shutdown).

      2011-12-13 17:08:35.499022 mon <- [mon,stat]
=A1@=A1@=A1@2011-12-13 17:08:35.499716 mon.1 -> 'e3: 5 mons at {a=3D172=
=2E16.33.5:6789/0,b=3D172.16.33.6:6789/0,c=3D172.16.33.7:6789/0,d=3D172=
=2E16.33.71:6789/0,e=3D172.16.33.72:6789/0}, election epoch 16, quorum =
0,1,2,3' (0)
   =20
    Even I use =A1=A5ceph mon dump=A1=A6, I still cannot know if the mo=
nitor is alive or not.

		0: 172.16.33.5:6789/0 mon.a
		1: 172.16.33.6:6789/0 mon.b
		2: 172.16.33.7:6789/0 mon.c
		3: 172.16.33.71:6789/0 mon.d
		4: 172.16.33.72:6789/0 mon.e

    Please give some help. Thanks!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
