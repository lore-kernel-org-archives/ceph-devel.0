From: Dan Mick <dan.mick@inktank.com>
Subject: Re: questions on networks and hardware
Date: Tue, 22 Jan 2013 13:05:09 -0800
Message-ID: <50FEFF05.1050700@inktank.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net> <CAJH6TXi40uB5Xup3xob+zVJaf6q=4dKjdgs4+NkD-fa5Bh2z0Q@mail.gmail.com> <6C6B937F81BD480D8B439B27D504FE9C@inktank.com> <CAJH6TXiutMfJ51G3itP83=-eSX+W9xtdPftNj0j0xcg+rHANmw@mail.gmail.com> <BA913A5056344C77AE4476417C3197A3@inktank.com> <CAJH6TXhxCBeB7-0vw3mbVO05zckH=F5JiVBJG7woW2SfwrBFBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35757 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab3AVVFN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:05:13 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so4280326pad.4
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:05:12 -0800 (PST)
In-Reply-To: <CAJH6TXhxCBeB7-0vw3mbVO05zckH=F5JiVBJG7woW2SfwrBFBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org



On 01/21/2013 12:19 AM, Gandalf Corvotempesta wrote:
> 2013/1/21 Gregory Farnum <greg@inktank.com>:
>> I'm not quite sure what you mean=85the use of the "cluster network" =
and "public network" are really just intended as conveniences for peopl=
e with multiple NICs on their box. There's nothing preventing you from =
running everything on the same network=85(and more specifically, from d=
ifferent speed grades to different boxes, but keeping them all on the s=
ame network).
>
> I mean using two cluster network and two pubic networks. 4 NICs in to=
tal.
> Our cluster network will be 10GBe or Infiniband DDR/QDR, making a
> fully redundany cluster network (two nics on each server, two
> switches) will double our costs.

Well, again, you needn't use two different networks for Ceph; that=20
capability is there so that you *can* only use the faster gear for the=20
cluster traffic if you want to limit costs but still segregate traffic.=
=20
  If you're just after a fully-redundant network (by which I assume you=
=20
also mean fully-redundant fabric, power, etc.), there's no reason it=20
can't all be fast gear.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
