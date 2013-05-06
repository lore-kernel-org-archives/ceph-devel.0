From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 06 May 2013 09:59:34 -0500
Message-ID: <5187C556.6050406@inktank.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net> <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com> <5187AEDC.6070202@inktank.com> <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com> <5187B4B3.1080304@mermaidconsulting.dk> <CAJH6TXiWz6Z_gqzEWD-T+FQkd4qD_pTodq7x1=Ur0j1SA38uqQ@mail.gmail.com> <5187B5CC.8020901@mermaidconsulting.dk> <CAJH6TXiU=h-mm+ypm_=dNDzFFNTj0bVe_a2=L82p-WzNSyMPBQ@mail.gmail.com> <5187B832.70504@mermaidconsulting.dk> <CAJH6TXgwzTiULJzb=6a96kX21xzoPknKdabJiRK154dnaifr9g@mail.gmail.com> <5187BB9F.4020301@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36211 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611Ab3EFO7h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 10:59:37 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so4208465ieb.10
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 07:59:37 -0700 (PDT)
In-Reply-To: <5187BB9F.4020301@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 05/06/2013 09:18 AM, Jens Kristian S=F8gaard wrote:
> Hi,
>
>> I'm just supposing, i'm also evaluating the same network topology
>> like you.
>
> I have tested my current setup for a while with just triple-bonded Gb=
E,
> and haven't found the need for more features. I might be wrong ofcour=
se :-)
>
>> There is a lowcost. 12x 10GbaseT switch from Netgear.
>
> I was looking at the Netgear XS708E which is very low cost compared t=
o
> what the prices were 6 months ago when I looked at it last.

I'm really not up to speed on the capabilities of cheap 10GbE switches.=
=20
I'm sure other people will have comments about what features are=20
worthwhile, etc.  Just from a raw performance perspective, you might=20
want to make sure that the switch can handle lots of randomly=20
distributed traffic between all of the ports well.  I'd expect that it=20
shouldn't be too terrible, but who knows.  I expect most IB switches yo=
u=20
run into should deal with this kind of pattern competently enough for=20
Ceph workloads to do OK.  On the front end portion of the network you'l=
l=20
always have client<->server communication, so the pattern there will be=
=20
less all-to-all than the backend traffic (more 1st half <-> 2nd half).

On really big deployments, static routing becomes a pretty big issue.=20
Dynamic routing, or at least well optimized routes can make a huge=20
difference.  ORNL has done some work in this area for their Lustre IB=20
networks and I think LLNL is investigating it as well.

Mark

>
> What I don't know is how those prices compare to IB pricing.
>
>> on cluster network and IB to public network). Do you think will be
>> possible to use all ceph services (RBD, RGW, CephFS, QEMU, ...) via
>> SDP/rsockets ?
>
> I haven't tried SDP/rsocket, so I don't know. From what I have
> experienced in the past, these things doesn't seem to be completely
> "drop in and forget about it" - there's always something that is not
> completely compatible with ordinary TCP/IP sockets.
>
>> On ebay there are many IB switches sold at 1000-1500$ with 24 or 36
>> DDR ports. If used with SDP/rsockets you should archieve more or les=
s
>> 18Gbps
>
> That sounds cheap yes, but I assume that is used equipment?
> I was looking at costs for new equipment.
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
