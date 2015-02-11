From: GuangYang <yguang11@outlook.com>
Subject: Upgrade/rollback
Date: Wed, 11 Feb 2015 12:09:24 +0000
Message-ID: <BLU175-W8D101EDE23DCDD591ADF6DF250@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s15.hotmail.com ([65.55.111.154]:58478 "EHLO
	BLU004-OMC4S15.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645AbbBKMKA convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Feb 2015 07:10:00 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ceph-devel,
Recently we are trying the upgrade from Firefly to Giant and it goes pr=
etty smoothly, however, the problem is that it does not support rollbac=
k and seems like that is by design. For example, there is new feature f=
lag / metadata [1] added in the new version and they are persisted. As =
a result, the old version of software does not recognize those values a=
nd will crash themselves.

Ideally we never rollback, but for unknown reasons we couldn't fix in a=
 timely manner, we might want to rollback first. Is that something we w=
ill consider to handle?

[1]=A0https://github.com/ceph/ceph/commit/1fe8b846641486cc294fe7e1d2450=
132c38d2dba

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
