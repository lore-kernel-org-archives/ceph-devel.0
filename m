From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Segmentation fault due to lacking NULL-check
Date: Fri, 12 Jul 2013 21:58:00 +0200
Message-ID: <51E05FC8.7000504@mermaidconsulting.dk>
References: <51E025E1.8050103@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx06.stofanet.dk ([212.10.10.58]:39217 "EHLO mx06.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757685Ab3GLT6D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Jul 2013 15:58:03 -0400
In-Reply-To: <51E025E1.8050103@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi again,

> I then installed Qemu 1.4.2 and tried to start a VM with an image on=20
> RBD. Qemu segfaults with this backtrace:

I trying compiling Qemu 1.5.1 instead - and that works. So it seems to=20
be an issue with Qemu 1.4.2 and not Ceph as such.

Anyone else using 1.4.2 with Cuttlefish?

> [23504.239286] libceph: mon1 10.0.0.2:6789 feature set mismatch, my=20
> 40002 < server's 2040002, missing 2000000

I found the reason for this was that I had my tunables set too "high" i=
n=20
order for my older kernel to connect. So it wasn't related to the qemu=20
issue at all.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
