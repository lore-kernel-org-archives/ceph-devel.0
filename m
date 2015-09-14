From: GuangYang <yguang11@outlook.com>
Subject: Priority backfill/recovery based on the degradation level of the PG
Date: Mon, 14 Sep 2015 14:29:39 -0700
Message-ID: <BLU175-W372B4EAB4A50AEE222196DF5D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s29.hotmail.com ([65.55.111.168]:59500 "EHLO
	BLU004-OMC4S29.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751357AbbINV3j convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Sep 2015 17:29:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sjust@redhat.com" <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "dzafman@redhat.com" <dzafman@redhat.com>

Hi Sam,
We discussed this briefly on IRC, I think it might be better to recap w=
ith an email.

Currently we schedule the backfill/recovery based on how degrade the PG=
 is, with a factor distinguishing recovery vs. backfill (recovery alway=
s has higher priority). The way to calculate the degradation level of a=
 PG is: {expected_pool_size} - {acting_set_size}. I think there are two=
 issues with the current approach:

1. The current {acting_size_size} might not capture the degradation lev=
el over the past intervals. For example, we have two PGs (Erasure Codin=
g with 8 data and 3 parity chunks) 1.0 and 1.1:
=A0 =A0 =A01.1 At t1, PG 1.0's acting set size becomes 8 while PG 1.1's=
 acting set is 11
=A0 =A0 =A01.2 At t2, PG 1.1's acting set size becomes 10 while PG 1.1'=
s acting set is 9
=A0 =A0 =A01.3 At t3, we start recovering (e.g. mark out some OSDs)
With the current algorithm, PG 1.1 will recovery first and then PG 1.0 =
(if the concurrency is configured as 1), however, from a data durabilit=
y's perspective, the data written between t1 and t2 are more degraded a=
nd risky.

2. The algorithm does not take EC/replication into account (and EC prof=
ile), which might be also important go consider the data durability.

Is my understanding correct here?

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
