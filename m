From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 17:16:58 +0200
Message-ID: <5187C96A.8060504@mermaidconsulting.dk>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net> <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com> <5187AEDC.6070202@inktank.com> <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com> <5187B4B3.1080304@mermaidconsulting.dk> <CAJH6TXiWz6Z_gqzEWD-T+FQkd4qD_pTodq7x1=Ur0j1SA38uqQ@mail.gmail.com> <5187B5CC.8020901@mermaidconsulting.dk> <CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com> <5187B832.70504@mermaidconsulting.dk> <CAJH6TXgwzTiULJzb=6a96kX21xzoPknKdabJiRK154dnaifr9g@mail.gmail.com> <5187BB9F.4020301@mermaidconsulting.dk> <5187C556.6050406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [193.189.92.131] ([193.189.92.131]:52818 "EHLO mail2.mdc.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754737Ab3EFPQ7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 May 2013 11:16:59 -0400
In-Reply-To: <5187C556.6050406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

> Just from a raw performance perspective, you might
> want to make sure that the switch can handle lots of randomly
> distributed traffic between all of the ports well.  I'd expect that i=
t
> shouldn't be too terrible, but who knows.

It has been many years since I've seen a switch have problems with that=
=2E=20
This switch has a 160 Gb/s backplane, so I don't foresee any problems.

Especially considering that I'm mixing the public and private networks=20
on the same switch.

> On really big deployments, static routing becomes a pretty big issue.
> Dynamic routing, or at least well optimized routes can make a huge

I use dedicated routers for routing, the switch is just a "dumb" L2-swi=
tch.

I'm looking at a very small deployment (probably 8 servers).

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://wwww.mermaidconsulting.com/


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
