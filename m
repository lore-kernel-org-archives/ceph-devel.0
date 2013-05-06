From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 15:48:35 +0200
Message-ID: <5187B4B3.1080304@mermaidconsulting.dk>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net> <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com> <5187AEDC.6070202@inktank.com> <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [193.189.92.131] ([193.189.92.131]:53701 "EHLO mail2.mdc.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab3EFOSr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 May 2013 10:18:47 -0400
In-Reply-To: <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

> Yes, but IB costs 1/4 than 10GbE and will be much expandible in futur=
e.

I'm testing Ceph currently with bonded 1 GbE links and contemplating=20
moving to 10 GbE or IB. I have to pay for the costs out of my own=20
pocket, so price is a major factor.

I have noted that just recently it has become possible to buy 10 GbE=20
switches for a lot less than before. I don't know what IB equipment=20
costs, mainly because I don't know much about IB and hence don't know=20
which equipment to buy.

My costs for a cobber-based 10 GbE setup per server would be approximat=
e:

   Switch: 115$
   NIC: 345$
   Cable: 2$

   Total: 462$ (per server)

If anyone could comment on how that compares to IB pricing, I would=20
appreciate it.

Is it possible to quantify how much Ceph would benefit of the improved=20
latency between 1 GbE and 10 GbE? (i.e. assuming that 1 GbE gives me=20
enough bandwidth, would I see any gains from lower latency?)

And similarly, would there be a significant gain from lower latency whe=
n=20
comparing 10 GbE to IB? (I assume that IB has lower latency than 10 GbE=
)

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://wwww.mermaidconsulting.com/


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
