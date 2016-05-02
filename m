From: Boris Ranto <branto@redhat.com>
Subject: Re: jewel selinux failures
Date: Mon, 02 May 2016 09:03:17 +0200
Message-ID: <1462172597.13876.120.camel@redhat.com>
References: <alpine.DEB.2.11.1604302131300.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbcEBHDU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 May 2016 03:03:20 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CA418553B
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2016 07:03:20 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1604302131300.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 2016-04-30 at 21:32 -0400, Sage Weil wrote:
> Hi Boris,
>=20
> Do you know why these selinux failures are happening on the jewel
> branch?=C2=A0=C2=A0
> I don't see any obvious differences from master, which doesn't seem
> to be=C2=A0
> hitting these.
>=20
> http://pulpito.ceph.com/sage-2016-04-30_16:27:00-rados-jewel---basic-
> smithi/159724
>=20
> Thanks!
> sage
>=20

Hi Sage,

all of these are related to PCP (Performance Co-Pilot), not Ceph
directly. You can notice that source context (scontext) is always

pcp_pmlogger_t (or pcp_pmcd_t in one occurrence)

which refers to pmlogger (or pmcd daemon).

Maybe, someone have set-up PCP to measure performance of Ceph clusters?
I can't say much more as I'm not familiar with PCP. AFAIK, PCP is not a
dependency of Ceph so removing it should also make the denials
disappear.

-boris

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
