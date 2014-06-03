From: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Subject: Official Ceph RPM build flags needed
Date: Tue, 3 Jun 2014 15:56:53 +0000
Message-ID: <46cee548efee484b8edf2b24e0cc4340@EPBYMINSA0001.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from evbyminsa0101.epam.com ([217.21.63.36]:23294 "EHLO
	EVBYMINSA0101.epam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbaFCP5P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 11:57:15 -0400
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Ceph-developers,
=20
at the moment we are doing some performance testing of Ceph v0.72.2 on =
ContOS 6.5, 64 bit. He have found, that Ceph from official RPM works fa=
ster that one which was compiled ourselves from sources. Do you know wh=
at compiler flags and configure options are actually used to build offi=
cial Ceph PRM for CentOS? Maybe you can give an advise where to dig to =
find out what we need? :)

Thank you very much!

Best Regards,=20
Ilya Storozhilov
Lead Software Engineer
=9A
EPAM Systems=20
Tver office, Russia=20
GMT+4=20
=9A
EPAM Internal ext.:=9A 55529
Office phone:=9A=9A=9A=9A=9A=9A=9A +7 (4822) 630-070 ext. 55529
Office fax:=9A=9A=9A=9A=9A=9A=9A=9A=9A +7 (4822) 630-073
Mobile phone:=9A=9A=9A=9A=9A=9A=9A +7 (904) 021-0763
E-mail:=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A Ilya_Storozhilov@epam.co=
m=20
=9A
http://www.epam.com=20
=9A
CONFIDENTIALITY CAUTION AND DISCLAIMER=20
This message is intended only for the use of the individual(s) or entit=
y(ies) to which it is addressed and contains information that is legall=
y privileged and confidential. If you are not the intended recipient, o=
r the person responsible for delivering the  message to the intended re=
cipient, you are hereby notified that any dissemination, distribution o=
r copying of this communication is strictly prohibited. All unintended =
recipients are obliged to delete this message and destroy any printed c=
opies.=20

         --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
