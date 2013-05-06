From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 16:18:07 +0200
Message-ID: <5187BB9F.4020301@mermaidconsulting.dk>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net> <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com> <5187AEDC.6070202@inktank.com> <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com> <5187B4B3.1080304@mermaidconsulting.dk> <CAJH6TXiWz6Z_gqzEWD-T+FQkd4qD_pTodq7x1=Ur0j1SA38uqQ@mail.gmail.com> <5187B5CC.8020901@mermaidconsulting.dk> <CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com> <5187B832.70504@mermaidconsulting.dk> <CAJH6TXgwzTiULJzb=6a96kX21xzoPknKdabJiRK154dnaifr9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [193.189.92.131] ([193.189.92.131]:53692 "EHLO mail2.mdc.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab3EFOSI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 May 2013 10:18:08 -0400
In-Reply-To: <CAJH6TXgwzTiULJzb=6a96kX21xzoPknKdabJiRK154dnaifr9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

> I'm just supposing, i'm also evaluating the same network topology
> like you.

I have tested my current setup for a while with just triple-bonded GbE,
and haven't found the need for more features. I might be wrong ofcourse=
 :-)

> There is a lowcost. 12x 10GbaseT switch from Netgear.

I was looking at the Netgear XS708E which is very low cost compared to
what the prices were 6 months ago when I looked at it last.

What I don't know is how those prices compare to IB pricing.

> on cluster network and IB to public network). Do you think will be
> possible to use all ceph services (RBD, RGW, CephFS, QEMU, ...) via
> SDP/rsockets ?

I haven't tried SDP/rsocket, so I don't know. From what I have
experienced in the past, these things doesn't seem to be completely
"drop in and forget about it" - there's always something that is not
completely compatible with ordinary TCP/IP sockets.

> On ebay there are many IB switches sold at 1000-1500$ with 24 or 36
> DDR ports. If used with SDP/rsockets you should archieve more or less
> 18Gbps

That sounds cheap yes, but I assume that is used equipment?
I was looking at costs for new equipment.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://wwww.mermaidconsulting.com/


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
