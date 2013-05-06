From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 16:03:30 +0200
Message-ID: <5187B832.70504@mermaidconsulting.dk>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net> <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com> <5187AEDC.6070202@inktank.com> <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com> <5187B4B3.1080304@mermaidconsulting.dk> <CAJH6TXiWz6Z_gqzEWD-T+FQkd4qD_pTodq7x1=Ur0j1SA38uqQ@mail.gmail.com> <5187B5CC.8020901@mermaidconsulting.dk> <CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [193.189.92.131] ([193.189.92.131]:45859 "EHLO mail2.mdc.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab3EFODb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 May 2013 10:03:31 -0400
In-Reply-To: <CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

>> I'm looking at just a bare-bones switchs that does VLANs, jumbo fram=
es and
>> port trunking. The network would be used exclusively for Ceph.

> You should also consider 10GbE for the public network, and there you
> should need more features.

I was actually going to put both the public and private network on the=20
same 10 GbE. Why do you think I need more features?

My public and private networks are completely dedicated to Ceph - so=20
nothing else takes place on them.

I have a third network which is just plain 1 GbE which handles all othe=
r=20
communication between the servers (and the Internet).

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://wwww.mermaidconsulting.com/


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
