From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 6 May 2013 16:13:27 +0200
Message-ID: <CAJH6TXgwzTiULJzb=6a96kX21xzoPknKdabJiRK154dnaifr9g@mail.gmail.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
	<CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
	<5187AEDC.6070202@inktank.com>
	<CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com>
	<5187B4B3.1080304@mermaidconsulting.dk>
	<CAJH6TXiWz6Z_gqzEWD-T+FQkd4qD_pTodq7x1=Ur0j1SA38uqQ@mail.gmail.com>
	<5187B5CC.8020901@mermaidconsulting.dk>
	<CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com>
	<5187B832.70504@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:62687 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab3EFON2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 10:13:28 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so2587922wiv.14
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 07:13:27 -0700 (PDT)
In-Reply-To: <5187B832.70504@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Mark Nelson <mark.nelson@inktank.com>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

2013/5/6 Jens Kristian S=F8gaard <jens@mermaidconsulting.dk>:
> I was actually going to put both the public and private network on th=
e same
> 10 GbE. Why do you think I need more features?

I'm just supposing, i'm also evaluating the same network topology like =
you.

There is a lowcost. 12x 10GbaseT switch from Netgear.

I'm also evaluating to create a full IB network dedicated to ceph (IB
on cluster network and IB to public network). Do you think will be
possible to use all ceph services (RBD, RGW, CephFS, QEMU, ...) via
SDP/rsockets ?

On ebay there are many IB switches sold at 1000-1500$ with 24 or 36
DDR ports. If used with SDP/rsockets you should archieve more or less
18Gbps
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
