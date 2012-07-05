From: <Eric_YH_Chen@wiwynn.com>
Subject: What does replica size mean?
Date: Thu, 5 Jul 2012 09:47:07 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D019C06A8@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:49322 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab2GEBrN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 21:47:13 -0400
Received: from TWNHUFE4.whq.wistron (unverified [10.37.31.104]) by TWNHUMSW3.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta562f4dee7c0a816711e0c@TWNHUMSW3.wistron.com> for <ceph-devel@vger.kernel.org>;
 Thu, 5 Jul 2012 09:50:18 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi, all:

Just want to make sure one thing.=20
If I set replica size as 2, that means one data with 2 copies, right?
Therefore, if I measure the performance of rbd is 100MB/s,=20
I can imagine the actually io throughputs on hard disk is over 100MB/s =
*3 =3D 300 MB/s. =A0
Am I correct?=20

Thanks!

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
