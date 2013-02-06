From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: CEPHFS mount error !!!
Date: Wed, 06 Feb 2013 08:24:08 +0100
Message-ID: <51120518.7000105@mermaidconsulting.dk>
References: <CAPhYxPzgHeuivJZDt7CGPjbxfO8r288pdQMEKnX90_UvPEqbBw@mail.gmail.com>	<5111FE64.7050909@inktank.com> <CAPhYxPyBHHhUzNdhZm-vAhny3SZeN-SAC9XFVfzfSh1V5un5JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:46103 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab3BFHYK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Feb 2013 02:24:10 -0500
In-Reply-To: <CAPhYxPyBHHhUzNdhZm-vAhny3SZeN-SAC9XFVfzfSh1V5un5JQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> No I didnt build my kernel.

This is the problem. You need to do that on CentOS 6.3.

> But the client machine which i want to use to access the storage
> 'using CEPHFS' is the one giving this error... this client machine

To mount cephfs like that you need to have kernel support. As the Linux=
=20
kernel on CentOS 6.3 is version 2.6.32 and Ceph support wasn't added=20
until 2.6.34, you need to compile your own kernel.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
