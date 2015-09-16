From: GuangYang <yguang11@outlook.com>
Subject: Pool setting for recovery priority
Date: Wed, 16 Sep 2015 08:48:22 -0700
Message-ID: <BLU175-W30B038F9EE84A31BF7D842DF5B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s25.hotmail.com ([65.55.111.164]:59536 "EHLO
	BLU004-OMC4S25.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648AbbIPPsX convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Sep 2015 11:48:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sjust@redhat.com" <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sam,
As part of the effort to solve problems similar to issue #13104 (http:/=
/tracker.ceph.com/issues/13104), do you think it is appropriate to add =
some parameters to pool setting:
=A0 =A01. recovery priority of the pool - we have a customized pool rec=
overy priority (like process's nice value) to favor some pools over oth=
ers. For example, the bucket index pool is usually much much smaller bu=
t important to recover first (e.g. might affect write latency as like i=
ssue #13104).
=A0 =A02. pool level recovery op priority - currently we have a low pri=
ority for recovery op (by default it is 10 while client io's priority i=
s 63), is it possible to have a pool setting to customized the priority=
 on pool level.

The purpose is to give some flexibility in terms of favor some pools ov=
er others when doing recovery, in our case using radosgw, we would like=
 to favor bucket index pool as that is on the write path for all reques=
ts.

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
