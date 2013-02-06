From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: Re: CEPHFS mount error !!!
Date: Wed, 06 Feb 2013 12:54:15 +0100
Message-ID: <51124467.10403@conversis.de>
References: <CAPhYxPzgHeuivJZDt7CGPjbxfO8r288pdQMEKnX90_UvPEqbBw@mail.gmail.com>	<5111FE64.7050909@inktank.com> <CAPhYxPyBHHhUzNdhZm-vAhny3SZeN-SAC9XFVfzfSh1V5un5JQ@mail.gmail.com> <51120518.7000105@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:34794 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab3BFLyR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:54:17 -0500
In-Reply-To: <51120518.7000105@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: femi anjorin <femi.anjorin@gmail.com>, ceph-devel@vger.kernel.org

On 02/06/2013 08:24 AM, Jens Kristian S=F8gaard wrote:
> Hi,
>=20
>> No I didnt build my kernel.
>=20
> This is the problem. You need to do that on CentOS 6.3.
>=20
>> But the client machine which i want to use to access the storage
>> 'using CEPHFS' is the one giving this error... this client machine
>=20
> To mount cephfs like that you need to have kernel support. As the Lin=
ux
> kernel on CentOS 6.3 is version 2.6.32 and Ceph support wasn't added =
until
> 2.6.34, you need to compile your own kernel.
>=20

The better alternative is probably to install a kernel from
http://elrepo.org/tiki/kernel-lt . "lt" stand for "long term" and shoul=
d be
fairly stable and "ml" is "mainline" which is even more current but bec=
ause
of that not quite as stable (currently 3.7.6).

Regards,
  Dennis
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
