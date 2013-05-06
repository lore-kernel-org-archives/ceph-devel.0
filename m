From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 6 May 2013 16:00:08 +0200
Message-ID: <CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
	<CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
	<5187AEDC.6070202@inktank.com>
	<CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com>
	<5187B4B3.1080304@mermaidconsulting.dk>
	<CAJH6TXiWz6Z_gqzEWD-T+FQkd4qD_pTodq7x1=Ur0j1SA38uqQ@mail.gmail.com>
	<5187B5CC.8020901@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:40973 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab3EFOAJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 10:00:09 -0400
Received: by mail-we0-f179.google.com with SMTP id t9so3020651wey.24
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 07:00:08 -0700 (PDT)
In-Reply-To: <5187B5CC.8020901@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Mark Nelson <mark.nelson@inktank.com>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

2013/5/6 Jens Kristian S=F8gaard <jens@mermaidconsulting.dk>:
> So an 8 port switch would be approx. 920$ USD.
>
> I'm looking at just a bare-bones switchs that does VLANs, jumbo frame=
s and
> port trunking. The network would be used exclusively for Ceph.

You should also consider 10GbE for the public network, and there you
should need more features.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
