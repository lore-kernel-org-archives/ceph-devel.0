From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Hit suicide timeout after adding new osd
Date: Sat, 19 Jan 2013 10:25:21 +0100
Message-ID: <50FA6681.10507@mermaidconsulting.dk>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk> <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:46455 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab3ASJZ1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 19 Jan 2013 04:25:27 -0500
In-Reply-To: <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Thanks for the speedy reply!

> to get it integrated.  Can you give wip-pg-removal a go and see if
> that resolves the problem? It's building right now.. packages should
> show up shortly on gitbuilder.ceph.com once it goes green here=20
> http://ceph.com/gitbuilder.cgi

It is only listed for OpenSUSE 12 where it is in yellow state.

I'm running Fedora 17.

I would really much like to test the fix soon, as multiple osds have no=
w
crashed with the same error. I now have unfound pgs and the cluster is
no longer usable.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
