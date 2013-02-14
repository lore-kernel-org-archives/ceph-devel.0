From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: [ceph-users] urgent journal conf on ceph.conf
Date: Thu, 14 Feb 2013 15:20:29 +0100
Message-ID: <CAOLwVUkKD1J_pCRWmw-S-jM4jfH4LDK=i_gjkr7seNZiFoSedw@mail.gmail.com>
References: <DUB116-W25AEABD85893916143C7CFE00F0@phx.gbl> <511CEADB.9070001@42on.com>
 <511CEC39.8020400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:60162 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757736Ab3BNOUw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 09:20:52 -0500
Received: by mail-ob0-f182.google.com with SMTP id va7so2447086obc.27
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 06:20:51 -0800 (PST)
In-Reply-To: <511CEC39.8020400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>, charles L <charlesboy009@hotmail.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

+1 for Wido

Moreover, if you want to store the journal on a block device, you
should partition your journal disk and assign one partition per OSD
like /dev/sdb1, 2 , 3....

Again, osd journal =3D /dev/osd$id/journal is wrong, if you use this
directive, this must point to a filesystem because the journal will be
a file.

Anyway, as far I'm concerned I didn't notice that much performance
gain by using the journal on a block device. At the end, just put the
journal on a dedicated formatted partition since the filesystem
overhead is not that big. So just keep the osd journal =3D
/dev/osd$id/journal but change it for something like osd journal =3D
/srv/ceph/journals/osd$id/journal.

Cheers.
--
Regards,
S=E9bastien Han.


On Thu, Feb 14, 2013 at 2:52 PM, Joao Eduardo Luis
<joao.luis@inktank.com> wrote:
> Including ceph-users, as it feels like this belongs there :-)
>
>
>
> On 02/14/2013 01:47 PM, Wido den Hollander wrote:
>>
>> On 02/14/2013 11:24 AM, charles L wrote:
>>>
>>>
>>> Pls can someone help me with the ceph.conf for 0.56.2. I have two
>>> servers for STORAGE with 3tb hard drives each and two SSD's each.  =
I
>>> want to use OSD data on the hard drive and osd journal on SSD.
>>>
>>> I want to know how osd journal configuration is set to SSD. My SSD =
is
>>> mounted on /dev/sdb.
>>>
>>> I have tried the osd data configurations  devs =3D /dev/sda and it
>>> worked just good.
>>>
>>> Is this line correct "osd journal =3D /dev/osd$id/journal" ?? and "=
 osd
>>> journal =3D /dev/sdb " ???
>>>
>>
>> In the osd specific (osd.0 and osd.1) sections you override the jour=
nal
>> settings made in the [osd] section.
>>
>> They are not needed, since you give the whole block device (/dev/sdb=
) to
>> the OSD as a journal.
>>
>> Are you sure /dev/sda is available for the OSD and it's not your boo=
t
>> device?
>>
>> Wido
>>
>>> [global]
>>>
>>>                  auth cluster required =3D cephx
>>>                  auth service required =3D cephx
>>>                  auth client required =3D cephx
>>>                  debug ms =3D 1
>>>
>>> [osd]
>>>                  osd journal size =3D 1000
>>>                  osd journal =3D /dev/osd$id/journal
>>>                  filestore xattr use omap =3D true
>>>                  osd mkfs type =3D xfs
>>>                  osd mkfs options xfs =3D -f
>>>                  osd mount options xfs =3D rw,noatime,
>>>
>>> [osd.0]
>>>                  host =3D server04
>>>                  devs =3D /dev/sda
>>>                  osd journal =3D /dev/sdb
>>> [osd.1]
>>>                  host =3D server05
>>>                  devs =3D /dev/sda
>>>                  osd journal =3D /dev/sdb
>>>
>>> THANKS.                           --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
