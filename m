From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 10:40:06 -0500
Message-ID: <5187CED6.5020307@inktank.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net> <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com> <5187AEDC.6070202@inktank.com> <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com> <5187B4B3.1080304@mermaidconsulting.dk> <CAJH6TXiWz6Z_gqzEWD-T+FQkd4qD_pTodq7x1=Ur0j1SA38uqQ@mail.gmail.com> <5187B5CC.8020901@mermaidconsulting.dk> <CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com> <5187B832.70504@mermaidconsulting.dk> <CAJH6TXgwzTiULJzb=6a96kX21xzoPknKdabJiRK154dnaifr9g@mail.gmail.com> <5187BB9F.4020301@mermaidconsulting.dk> <5187C556.6050406@inktank.com> <5187C96A.8060504@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33621 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab3EFPkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 11:40:09 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so2917307iec.35
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 08:40:09 -0700 (PDT)
In-Reply-To: <5187C96A.8060504@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 05/06/2013 10:16 AM, Jens Kristian S=F8gaard wrote:
> Hi,
>
>> Just from a raw performance perspective, you might
>> want to make sure that the switch can handle lots of randomly
>> distributed traffic between all of the ports well.  I'd expect that =
it
>> shouldn't be too terrible, but who knows.
>
> It has been many years since I've seen a switch have problems with th=
at.
> This switch has a 160 Gb/s backplane, so I don't foresee any problems=
=2E
>
> Especially considering that I'm mixing the public and private network=
s
> on the same switch.
>
>> On really big deployments, static routing becomes a pretty big issue=
=2E
>> Dynamic routing, or at least well optimized routes can make a huge
>
> I use dedicated routers for routing, the switch is just a "dumb" L2-s=
witch.
>
> I'm looking at a very small deployment (probably 8 servers).

Ha, ok.  I suspect you'll be fine.  Nothing like over-thinking the=20
problem right? :)

>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
