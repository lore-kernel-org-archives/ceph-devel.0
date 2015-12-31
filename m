From: Linux Chips <linux.chips@gmail.com>
Subject: Re: How to configure if there are tow network cards in Client
Date: Thu, 31 Dec 2015 11:45:15 +0300
Message-ID: <5684EB1B.2030806@gmail.com>
References: <57b6c7ee.cffc.151d9741bd2.Coremail.cymengxiang@126.com>
 <alpine.DEB.2.00.1512280846380.14656@cobra.newdream.net>
 <56825EA1.1070803@gmail.com>
 <64fd5de0.cb49.151edd1ed20.Coremail.cymengxiang@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35438 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbLaIoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Dec 2015 03:44:46 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so57770486wmf.0
        for <ceph-devel@vger.kernel.org>; Thu, 31 Dec 2015 00:44:46 -0800 (PST)
In-Reply-To: <64fd5de0.cb49.151edd1ed20.Coremail.cymengxiang@126.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6JSh5q+F?= <cymengxiang@126.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

it would certainly help those with less knowledge about networking in=20
linux, though i do not know how many people using ceph are in this=20
category. Sage and the others here may have a better idea about its=20
feasibility.
but i usually use rule-* and route-* (in CentOS) files, they work with=20
networkmanager, and very easy to configure. in ubuntu you can put them=20
in interfaces file, and they are as easy. if such a tool is made, i=20
think it should understand the ceph.conf file, but i doubt it can figur=
e=20
out the routes correctly without you putting them in.

On 12/29/2015 03:58 PM, =B2=CC=D2=E3 wrote:
>        Thank for your replies.
>        So is it reasonable that we could write a file such as shell s=
cript to bind one process with a specific IP and modify the routing tab=
les and rules
> as one of Ceph=A1=AFs tools? So that the users is convenient when the=
y want to change the NIC connecting with the OSD.
>
>
>
> At 2015-12-29 18:21:21, "Linux Chips"<linux.chips@gmail.com>  wrote:
>> On 12/28/2015 07:47 PM, Sage Weil wrote:
>>> On Fri, 25 Dec 2015, ?? wrote:
>>>> Hi all,
>>>>       When we read the code, we haven?t find the function that the=
 client can bind a specific IP. In Ceph?s configuration, we could only =
find the parameter ?public network?, but it seems acts on the OSD but n=
ot the client.
>>>>       There is a scenario that the client has two network cards na=
med NIC1 and NIC2. The NIC1 is responsible for communicating with clust=
er (monitor and RADOS) and the NIC2 has other services except Ceph?s cl=
ient. So   we need the client can bind specific IP in order to differen=
tiate the IP communicating with cluster from another IP serving other a=
pplications. We want to know is there any configuration in Ceph to achi=
eve this function? If there is, how could we configure the IP? if not, =
could we add this function in Ceph? Thank you so much.
>> you can use routing tables plus routing rules. otherwise linux will =
just
>> use the default gateway.
>> or you can put the second interface on the same public net of ceph.
>> though that would break if you have multiple external nets.
>>> Right.  There isn't a configurable to do this now--we've always jus=
t let
>>> the kernel network layer sort it out. Is this just a matter of call=
ing
>>> bind on the socket before connecting? I've never done this before..
>> linux will send all packets to the default gateway event if an
>> application binds to an ip on different interface, the packet will g=
o
>> out with the source address as the binded one but through your route=
r.
>> the only solution, even if the bind function exists is to use the
>> routing tables and rules.
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message tomajordomo@vger.kernel.org
>>> More majordomo info athttp://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
