From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: OSD's DOWN ---after upgrade to 0.56.3
Date: Fri, 15 Feb 2013 15:09:48 +0100
Message-ID: <511E41AC.6060606@mermaidconsulting.dk>
References: <CAPhYxPzWKZhko9OBy7a-F=o3J2E2_P8EsZNuvBUTC8W7yUBJNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx06.stofanet.dk ([212.10.10.58]:35263 "EHLO mx06.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab3BOOJw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Feb 2013 09:09:52 -0500
In-Reply-To: <CAPhYxPzWKZhko9OBy7a-F=o3J2E2_P8EsZNuvBUTC8W7yUBJNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com

Hi Femi,

> Pls I got this result after i did an upgrade to 0.56.3. I'm not sure
> -2      4                       host server109
> 0       1                               osd.0   DNE
> 1       1                               osd.1   DNE
> 2       1                               osd.2   DNE

Your OSDs are not marked down - they're listed as do not exist.

Did you previously run a ceph osd rm command on those osds?

Note: This topic is probably best suited for the ceph-users list, so I=20
have cross-posted to that list.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
