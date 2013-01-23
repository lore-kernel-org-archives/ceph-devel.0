From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Hit suicide timeout after adding new osd
Date: Wed, 23 Jan 2013 13:29:48 +0100
Message-ID: <50FFD7BC.6040502@mermaidconsulting.dk>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk> <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net> <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk> <alpine.DEB.2.00.1301201613130.31658@cobra.newdr
 eam.net> <50FCE759.9070309@mermaidconsulting.dk> <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net> <50FFD420.7000604@mermaidconsulting.dk> <50FFD6F9.1010705@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.stofanet.dk ([212.10.10.14]:59235 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387Ab3AWM36 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Jan 2013 07:29:58 -0500
In-Reply-To: <50FFD6F9.1010705@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Sage Weil <sage@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Wido,

> Going through the code and reading that this solved it for Jens, coul=
d=20
> this issue be traced back to less powerful CPUs?

Depends on what you mean by less powerful.

All my OSD servers are equipped with Xeon E5606 CPUs. That is a=20
quad-core 2.13 Ghz CPU.

They are not used for anything else than Ceph.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
