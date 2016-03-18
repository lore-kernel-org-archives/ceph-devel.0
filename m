From: Yang Honggang <joseph.yang@xtaotech.com>
Subject: RGW placement multi data pool support
Date: Fri, 18 Mar 2016 19:07:09 +0800
Message-ID: <56EBE15D.6020906@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:46909 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbcCRLHO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2016 07:07:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Javen Wu <javen.wu@xtaotech.com>

Hello,

In the current RGW implementation, only one =E2=80=98data pool=E2=80=99=
 is allowed in the
placement target. So the size of a bucket is limited by the backend poo=
l
size. We can add osds into the backend pool, but it would trigger PG da=
ta
rebalance. Also, we might have to do PG split when the OSD count is clo=
se
to the pre-defined PG number, however, it would trigger data rebalance =
as
well. We try to avoid data rebalance as many as we can by adding multip=
le
pools into one placement target. Then a scheduler between pools of a
placement target is needed.

I have a immature proposal would like to discuss with you. We can exten=
d
placement's data pool to a pool list. When a new object is created thro=
ugh
RGW, we can choose one data pool from placement's data pool list. In or=
der
to do that, the pool ID need to be added into the bucket index for each
object.

How do you guys think?

thx,

Joseph
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
