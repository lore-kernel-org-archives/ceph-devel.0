From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: [ceph-users] Problem with MON after reboot
Date: Wed, 31 Jul 2013 12:27:06 +0200
Message-ID: <51F8E67A.90508@mermaidconsulting.dk>
References: <E0E280CCE0E1A44898C992A9190D929A4F9C66@MBX02-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:39897 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241Ab3GaK1M (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Jul 2013 06:27:12 -0400
In-Reply-To: <E0E280CCE0E1A44898C992A9190D929A4F9C66@MBX02-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luke Jing Yuan <jyluke@mimos.my>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,

> I am having a issue with MON after reboot, I had originally 3 MONs bu=
t=20
> after rebooting one of them, the quorum cannot be established. Diggin=
g=20

Did you happen to upgrade Ceph at some time where you haven't restarted=
=20
the daemon?

Which version of Ceph do you run on each server?

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
