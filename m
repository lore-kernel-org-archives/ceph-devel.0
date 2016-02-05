From: Odintsov Vladislav <VlOdintsov@croc.ru>
Subject: [rgw] etag and content type after changing ACL and adding headers
Date: Fri, 5 Feb 2016 06:51:00 +0000
Message-ID: <1454655060586.25596@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ironport1.croc.ru ([195.38.23.101]:26927 "EHLO
	ironport1.croc.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbcBEHBa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 02:01:30 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,=A0

I've tested this PR (https://github.com/ceph/ceph/pull/6620) in our tes=
ting LAB and found a strange behaviour of RGW, but since I'm not a ceph=
 developer, I don't know if such behaviour right or not.
Description is in RGW tracker:
http://tracker.ceph.com/issues/14447

Can someone help me understand 2 points:
- why and what for '\u0000' symbol appears in fields
- why "tag" field changes to some strange value?

Thanks.

---
Regards,
=20
Vladislav Odintsov
System Engineer of Croc Cloud Development Team--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
