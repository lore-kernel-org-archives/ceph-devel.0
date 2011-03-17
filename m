From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: adding/removing osd problem
Date: Thu, 17 Mar 2011 17:09:50 +0800
Message-ID: <AANLkTimz0Q=fGn0SK=5VLDSFPCBGLD5fU==Y3g38yA2Q@mail.gmail.com>
References: <AANLkTimXAypm-DXDu6RC_VzPRE2K-Jx_RYZCRunAdwNP@mail.gmail.com>
	<4D8152EC.5010200@hq.newdream.net>
	<AANLkTik7ePGrLbvk1E4Sjotpj6dZ86nZooZZS-vfCwKN@mail.gmail.com>
	<AANLkTikC4XXb8hrpJab+x=_8V4zRUwaO8s+w4d_7E1ZY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40165 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab1CQJJv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2011 05:09:51 -0400
Received: by bwz15 with SMTP id 15so2273869bwz.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2011 02:09:50 -0700 (PDT)
In-Reply-To: <AANLkTikC4XXb8hrpJab+x=_8V4zRUwaO8s+w4d_7E1ZY@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: samuel.just@dreamhost.com, Samuel Just <samuelj@hq.newdream.net>, ceph-devel@vger.kernel.org

Hi,
I have a similar question when testing.
When I restarted my OSD server, the OSD cannot join the OSD pool automa=
tically.
I have to login into the OSD server and type "cosd -i #"(# is the
number of OSD).

My question is, can monitor or MDS automatically detect OSDes, other
MDSs or monitors and add them into the pool when they restart?
Thanks!

=E5=9C=A8 2011=E5=B9=B43=E6=9C=8817=E6=97=A5=E4=B8=8B=E5=8D=883:20=EF=BC=
=8CUpendra Moturi <upendra.m@hexagrid.com> =E5=AF=AB=E9=81=93=EF=BC=9A
> Hi
>
> I too had the same problem.
> Only one option i found(just for testing)i had to stop the cluster an=
d
> start it again.
>
> /etc/init.d/ceph start osd<n> does not do anything as this not even
> going into start case .
>
> 2011/3/17 Upendra Moturi <upendra.m@hexagrid.com>
>>
>> I too had the same problem.
>> Only one option i found(just for testing)i had to stop the cluster a=
nd start it again.
>>
>> /etc/init.d/ceph start osd<n> does not do anything as this not even =
going into start case .
>>
>>
>> 2011/3/17 Samuel Just <samuelj@hq.newdream.net>
>>>
>>> =C2=A0From the looks of the fdisk output, it seems that the disk wa=
s not
>>> recognized by the OS when it was reinserted? The OSD daemon won't b=
e
>>> able to start if the disk is not found.
>>> -Sam
>>>
>>> On 03/16/2011 05:08 PM, huang jun wrote:
>>> > Hi=EF=BC=8C
>>> > Recently, I try to do "adding/removing osds " in ceph wiki
>>> > Here is what I ave done
>>> > <1> build a cluster with mon/mds/osd0 in the same machine "host0"
>>> > =C2=A0 =C2=A0 And start it,everything is ok
>>> > <2> follow the wiki ceph ,add a disk (/dev/sdb4)into host0
>>> > =C2=A0 =C2=A0It's ok ,"ceph osd dump -o - "show that there are tw=
o osds and
>>> > state are in/up
>>> > <3> write a 4G file
>>> > pull out the osd1 when it about writes 2G ,the osd1 was marked do=
wn
>>> > and 5 mins laster
>>> > it was marked out,but use "df -hl "
>>> > I =C2=A0find "/dev/sdb4 885G =C2=A02.7M =C2=A0885G =C2=A0 1% /dat=
a/osd1" (it's right?)
>>> > so when re-insert the disk ," fdisk -l" show me:
>>> >
>>> > Disk /dev/sda: 1000.2 GB, 1000204886016 bytes
>>> > 255 heads, 63 sectors/track, 121601 cylinders
>>> > Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
>>> > Disk identifier: 0x000d6542
>>> > =C2=A0 =C2=A0Device Boot =C2=A0 =C2=A0 =C2=A0Start =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 End =C2=A0 =C2=A0 =C2=A0Blocks =C2=A0 Id =C2=A0System
>>> > /dev/sda1 =C2=A0 * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 =C2=A0 =C2=
=A0 =C2=A0 =C2=A03263 =C2=A0 =C2=A026210016 =C2=A0 83 =C2=A0Linux
>>> > /dev/sda2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03264 =C2=A0 =C2=
=A0 =C2=A0 =C2=A06134 =C2=A0 =C2=A023061307+ =C2=A0 f =C2=A0W95 Ext'd (=
LBA)
>>> > /dev/sda3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06135 =C2=A0 =C2=
=A0 =C2=A0121601 =C2=A0 927488677+ =C2=A083 =C2=A0Linux
>>> > /dev/sda5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03264 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04307 =C2=A0 =C2=A0 8385898+ =C2=A082 =C2=A0Linux swap =
/ Solaris
>>> > /dev/sda6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04308 =C2=A0 =C2=
=A0 =C2=A0 =C2=A05612 =C2=A0 =C2=A010482381 =C2=A0 83 =C2=A0Linux
>>> > /dev/sda7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05613 =C2=A0 =C2=
=A0 =C2=A0 =C2=A06134 =C2=A0 =C2=A0 4192933+ =C2=A083 =C2=A0Linux
>>> >
>>> > Disk /dev/sdc: 1000.2 GB, 1000204886016 bytes
>>> > 255 heads, 63 sectors/track, 121601 cylinders
>>> > Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
>>> > Disk identifier: 0x000549cb
>>> > =C2=A0 =C2=A0Device Boot =C2=A0 =C2=A0 =C2=A0Start =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 End =C2=A0 =C2=A0 =C2=A0Blocks =C2=A0 Id =C2=A0System
>>> > /dev/sdc1 =C2=A0 * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 =C2=A0 =C2=
=A0 =C2=A0 =C2=A03263 =C2=A0 =C2=A026210016 =C2=A0 83 =C2=A0Linux
>>> > /dev/sdc2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03264 =C2=A0 =C2=
=A0 =C2=A0 =C2=A06134 =C2=A0 =C2=A023061307+ =C2=A0 f =C2=A0W95 Ext'd (=
LBA)
>>> > /dev/sdc4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06135 =C2=A0 =C2=
=A0 =C2=A0121601 =C2=A0 927488677+ =C2=A083 =C2=A0Linux
>>> > /dev/sdc5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03264 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04307 =C2=A0 =C2=A0 8385898+ =C2=A082 =C2=A0Linux swap =
/ Solaris
>>> > /dev/sdc6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04308 =C2=A0 =C2=
=A0 =C2=A0 =C2=A05612 =C2=A0 =C2=A010482381 =C2=A0 83 =C2=A0Linux
>>> > /dev/sdc7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05613 =C2=A0 =C2=
=A0 =C2=A0 =C2=A06134 =C2=A0 =C2=A0 4192933+ =C2=A083 =C2=A0Linux
>>> >
>>> > And finally I can not start osd1
>>> > Because "/etc/init.d/ceph start osd1 " do nothing
>>> > Where is my problem?can you find it out for me?
>>> > thanks
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-inf=
o.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>
>>
>>
>> --
>> Thanks and Regards,
>> Upendra.M
>
>
>
> --
> Thanks and Regards,
> Upendra.M
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Best Regards,
Sylar Shen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
