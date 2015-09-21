From: GuangYang <yguang11@outlook.com>
Subject: More accurate of how degrade a PG is
Date: Mon, 21 Sep 2015 09:43:05 -0700
Message-ID: <BLU175-W23FAE57B308D398D4CA67FDF460@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s19.hotmail.com ([65.55.111.158]:57629 "EHLO
	BLU004-OMC4S19.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932383AbbIUQnH convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Sep 2015 12:43:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
Looking at the reporting from command line tools (ceph status, pg query=
, etc), I don't find a way to tell how degraded the recovering objects =
are for a given PG. The use case could be, when doing deployment, we do=
n't want to stop the procedure upon a recovering PG, but at the same ti=
me, we don't want to stop an OSD which could bring *unfound* objects (o=
r even stuck at peering PG).

Any idea how we could query those information? Or should we expose thos=
e information from CLI, some ways I can think of:
=A01. Implement a command line option like "ceph osd could-down <ids> [=
<ids>...]" which would examine if the down of the given OSD(s) would br=
ing problems?
=A02. Instead of just warning for "degraded", we also warn if a PG coul=
d further lose OSDs, so that we stop upon having that warning?

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
