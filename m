From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 6 May 2013 18:51:16 +0200
Message-ID: <CAJH6TXh1G_1V9-9PjAUydNzo39aEuqXtD1kKxr+L+qjgMvNkqw@mail.gmail.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
	<CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
	<5187AEDC.6070202@inktank.com>
	<CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com>
	<5187B4B3.1080304@mermaidconsulting.dk>
	<CAJH6TXiWz6Z_gqzEWD-T+FQkd4qD_pTodq7x1=Ur0j1SA38uqQ@mail.gmail.com>
	<5187B5CC.8020901@mermaidconsulting.dk>
	<CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com>
	<5187B832.70504@mermaidconsulting.dk>
	<CAJH6TXgwzTiULJzb=6a96kX21xzoPknKdabJiRK154dnaifr9g@mail.gmail.com>
	<5187BB9F.4020301@mermaidconsulting.dk>
	<5187C556.6050406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:53763 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab3EFQvR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 12:51:17 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey16so2769417wid.6
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 09:51:16 -0700 (PDT)
In-Reply-To: <5187C556.6050406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

2013/5/6 Mark Nelson <mark.nelson@inktank.com>:
>  On the front end
> portion of the network you'll always have client<->server communication, so
> the pattern there will be less all-to-all than the backend traffic (more 1st
> half <-> 2nd half).

What do you suggest for the frontend portion? 10GbE or 2Gb (2x 1GbE
bonded toghether) should be enough in case of RBD with Qemu?
