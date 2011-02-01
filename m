From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: some thoughts about scrub
Date: Tue, 1 Feb 2011 16:29:37 +0000
Message-ID: <20110201162937.7705c83e.ctpm@ist.utl.pt>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
	<20110131215819.f0537c57.ctpm@ist.utl.pt>
	<AANLkTinJ7q5tFzQfoJaSvopaJpHrqxoBbKoxNMgKD70n@mail.gmail.com>
	<AANLkTimkx4CuZqE2dHgS-9iKy9F=B-C+QDjQO_qAOnB8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:54756 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab1BAQ3k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Feb 2011 11:29:40 -0500
In-Reply-To: <AANLkTimkx4CuZqE2dHgS-9iKy9F=B-C+QDjQO_qAOnB8@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org


On Tue, 1 Feb 2011 17:20:34 +0800 Henry Chang <henry.cy.chang@gmail.com=
> wrote:
>=20
> Yeah. I expect that scrub can both detect disk errors and check data
> integrity (based on the checksum) in the background. For disk errors,
> I would like CEPH to mark the OSD down/failed and notify the sys
> admin immediately. For data errors, I expect that CEPH can repair
> them automatically (by fetching a right copy from other replicas).
>=20

 I suppose the best approach would be for this to be configurable with
per OSD granularity. Something like an io_error_threshold config
variable. I would set it to something like 50 or 100, but you could set
it to 1 and the OSD would put itself down or out after that many IO
errors that propagated up to the osd daemon. I guess that even if that
OSD becomes unresponsive for a while it won't be much trouble, since
ceph will mark it down and should recover later, or else the OSD will
be out soon by itself due to the error threshold.

 What do you think?

Cheers

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
