From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Building a small Ceph development environment
Date: Tue, 19 Jun 2012 16:30:22 -0700
Message-ID: <4FE10B8E.1040709@inktank.com>
References: <CAJLzzs+9X3dWUMLavOnp1ijvOJLDprM3YsGDLo=DUEEkb9yp4w@mail.gmail.com> <CAPYLRzh0XbsvGFOJCzpGjvtn_e_CVXcXcT5u_nbGut9VMfmSgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41010 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab2FSXaZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 19:30:25 -0400
Received: by pbbrp8 with SMTP id rp8so10298632pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 16:30:25 -0700 (PDT)
In-Reply-To: <CAPYLRzh0XbsvGFOJCzpGjvtn_e_CVXcXcT5u_nbGut9VMfmSgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Terrance Hutchinson <terrance.hutchinson@gmail.com>, ceph-devel@vger.kernel.org

Yeah, it's certainly doable to run all the daemons on one server; they=20
don't even really need a separate disk, but that's generally a nice=20
partitioning.

You can usually get help on irc://irc.oftc.net/#ceph, too.

On 06/19/2012 10:54 AM, Gregory Farnum wrote:
> You don't need to virtualize anything =97 I'd recommend running Ubunt=
u
> 12.04 on it (you don't need to, but a lot of things will be more
> performant), building from source, and then setting up the daemons so
> everybody gets a separate disk.
> Check out http://ceph.com/docs/master/source/ and the other docs and
> let us know if you have any questions. :)
>
> On Tue, Jun 19, 2012 at 10:47 AM, Terrance Hutchinson
> <terrance.hutchinson@gmail.com>  wrote:
>> Hi all,
>>
>> I have an HP ProLiant ML350 G5 server that is currently sitting idle
>> at the moment. Would it be possible to virtualize a Ceph cluster so =
I
>> can mess around and begin contributing back to the community?
>>
>> Specs:
>>
>> ML350 G5
>> 2 x Quad Core Xeon E5430
>> 16GB RAM
>> 7x 146GB SAS disks
>> 1x 120 GB Intel 520 SSD
>> HP P800 Smart Array Controller (can purchase an LSI 208E SAS HBA whi=
ch
>> will make the disks a JBOD)
>>
>> My goal is to create a small Ceph setup to do testing and bug fixes
>> for the project which is why I posted this to the development list.
>>
>> Thanks in advance,
>> Terrance
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
