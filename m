From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: RadosGW on ubuntu is OK but CentOS fails
Date: Mon, 30 Jul 2012 15:58:11 +0800
Message-ID: <CAMm-wcJ7aFjgW_ROb-=+Mk9RdRB_NCoFCChA+8U_s8jd5cgFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47018 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab2G3H6L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 03:58:11 -0400
Received: by mail-qc0-f174.google.com with SMTP id o28so2764471qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 00:58:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi everyone.

Nowadays, I start to play with radosgw.

I deploy an instance including 1 mon, 1 osd and 1 radosgw on one
machine which based on CentOS 6.2. I can access the system from
browser(Chrome) which tells me that: no bucket for anonymous user.

I think I get everything fine, but when I use S3-tests to test this
instance, the test script is very very slow and got lots of errors.

I deploy another instance which is all the same with the first
excepted it is based on Ubuntu 12.04 Sever. Browser access is still OK
and S3-tests completed fast with 209 OK, 8 Fall and 38 Error, I think
this is the correct result.

I compare these two instance including Ceph version, ceph.conf,
S3TEST_CONF and httpd.conf. they are all the same expected some random
passwords.

I also read the radosgw log, even the logs on the two instance are
seems to be the same. The log on the CentOS shows that AUTHORITY
action is OK, then PUT BUCKET  action is OK .... the log is too large
to read them all.

Did somebody meet this situation?

Thanks.

--=20
=E8=A2=81=E5=86=AC
Tel:13573888215
Email:yuandong1222@gmail.com
QQ:10200230
MSN:yuandong1222@hotmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
