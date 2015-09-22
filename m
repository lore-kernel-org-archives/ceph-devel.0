From: Z Zhang <zhangz.david@outlook.com>
Subject: use crushtool to simulate pg distribution for a specific pool
Date: Tue, 22 Sep 2015 12:46:23 +0800
Message-ID: <SNT146-W7672C7B2604BA26E504E1D8C450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from snt004-omc4s26.hotmail.com ([65.55.90.229]:63723 "EHLO
	SNT004-OMC4S26.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752430AbbIVEqX convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Sep 2015 00:46:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ceph-devel,

We enhanced the crushtool to simulate real pg distribution for a specif=
ic pool. Recently we had encountered pg uneven issue again after expand=
ing our cluster, although we had re-weighted the cluster to make pg eve=
nly-distribution at the time we built up the cluster.=A0

It could be painful to re-weighted osds after expanding cluster because=
 in order to achieve pg evenly-distribution, we may need to re-weight c=
ouple of times and each time will trigger data movement.

Now we could use this crushtool to simulate pg distribution against cru=
sh map, re-weight osds and test the crush map again and again until we =
satisfy with pg distribution. Then we could set back the final crush ma=
p and trigger data movement for one time.

Please check this PR:=A0https://github.com/ceph/ceph/pull/6004=A0if you=
r guys are interested.=A0

Thanks.
Zhi Zhang (David) 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
