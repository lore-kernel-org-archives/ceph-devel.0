From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: [ceph-users] Problem with MON after reboot
Date: Wed, 31 Jul 2013 12:37:22 +0200
Message-ID: <51F8E8E2.4040702@mermaidconsulting.dk>
References: <E0E280CCE0E1A44898C992A9190D929A4F9C66@MBX02-TPM.mimos.local> <51F8E67A.90508@mermaidconsulting.dk> <E0E280CCE0E1A44898C992A9190D929A4F9CB1@MBX02-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:58137 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756221Ab3GaKhZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Jul 2013 06:37:25 -0400
In-Reply-To: <E0E280CCE0E1A44898C992A9190D929A4F9CB1@MBX02-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luke Jing Yuan <jyluke@mimos.my>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,

> This happened to me twice actually. Once before I upgraded, using
> 0.61.4 (I solved it by removing the MON and then recreating it) and
> this time after upgrading all nodes to 0.61.7. The surprising thing
> to me is that the node is also running OSD as well but after the
> upgrade and reboot, the cluster is able to pick the OSD portion up
> but not the MON.

So you say you've upgraded all nodes to 0.61.7 and then restarted one,=20
and this happened?

Have you restarted the other mons after you upgraded to 0.61.7, or are=20
they still running an older version?

It could be you simply need to restart the two other mons to fix the=20
problem.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
