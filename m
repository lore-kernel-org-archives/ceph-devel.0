From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Hit suicide timeout after adding new osd
Date: Thu, 17 Jan 2013 21:32:44 +0100
Message-ID: <50F85FEC.7030305@mermaidconsulting.dk>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.stofanet.dk ([212.10.10.11]:37885 "EHLO mx01.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876Ab3AQUcu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jan 2013 15:32:50 -0500
In-Reply-To: <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

> The fix for this is in v0.56.1, so I think you are seeing something e=
lse.
> If this is something you can reproduce with 'debug osd =3D 10' or 20 =
and=20
> 'debug ms =3D 1', that would be extremely helpful!

I have set the debug level and restarted the osd. It initialized for=20
about an hour and then crashed after 5 minutes with the same error mess=
age.

You can download the full logs here:

http://bit.ly/WbcSQp

Thanks for your help!

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
