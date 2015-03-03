From: Butkeev Stas <staerist@ya.ru>
Subject: Problems with "shadow" objects
Date: Tue, 03 Mar 2015 14:04:08 +0300
Message-ID: <1809941425380648@web25h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from forward1h.mail.yandex.net ([84.201.187.146]:58955 "EHLO
	forward1h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbCCLNB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2015 06:13:01 -0500
Received: from web25h.yandex.ru (web25h.yandex.ru [84.201.187.159])
	by forward1h.mail.yandex.net (Yandex) with ESMTP id 7B4939E26E3
	for <ceph-devel@vger.kernel.org>; Tue,  3 Mar 2015 14:04:09 +0300 (MSK)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello, all

I have ceph+RGW installation. And have some problems with "shadow" obje=
cts.

=46or example:
#rados ls -p .rgw.buckets|grep "default.4507.1"

=2E....
default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.1_5
default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_2
default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.6_4
default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.4_2
default.4507.1__shadow_test_s3.2/2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.3_5
=2E....

Please give me advices and answer on my questions
1) How can I rm this "shadow" files?
2) What does the name of this "shadow" files?
example
with normal object:
# radosgw-admin object stat --bucket=3Ddev --object=3D"RegExp_tutorial.=
png"
and I receive information about this object.

with "shadow" object:
default.4507.1_ - bucket-id
radosgw-admin object stat --bucket=3Ddev --object=3D"_shadow_test_s3.2/=
2vO4WskQNBGMnC8MGaYPSLfGkhQY76U.2_7"
ERROR: failed to stat object, returned error: (2) No such file or direc=
tory
how can I determine name of this object

--=9A
Best Regards,
Stanislav Butkeev
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
