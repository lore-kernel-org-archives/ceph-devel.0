From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: [ceph-users] Problem with MON after reboot
Date: Wed, 31 Jul 2013 13:17:16 +0200
Message-ID: <51F8F23C.8060306@mermaidconsulting.dk>
References: <E0E280CCE0E1A44898C992A9190D929A4F9C66@MBX02-TPM.mimos.local> <51F8E67A.90508@mermaidconsulting.dk> <E0E280CCE0E1A44898C992A9190D929A4F9CB1@MBX02-TPM.mimos.local> <51F8E8E2.4040702@mermaidconsulting.dk> <E0E280CCE0E1A44898C992A9190D929A4F9D01@MBX02-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:51570 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379Ab3GaLRV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Jul 2013 07:17:21 -0400
In-Reply-To: <E0E280CCE0E1A44898C992A9190D929A4F9D01@MBX02-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luke Jing Yuan <jyluke@mimos.my>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,

> However, in a previous situation I had (while all of them were still
> running the older 0.61.4). Rebooting the same MON, did not restore
> the quorum also, so I am not sure what may cause this but I supposed
> it maybe some other reasons.

Actually it is the same reason.

When upgrading from a version before 0.61.4 to a later version, you'll=20
need to restart all the monitors before they form a new quorum.

This was mentioned in the release notes.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
