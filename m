From: Victor Payno <vpayno@gaikai.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Fri, 29 Jul 2016 16:11:14 -0700
Message-ID: <CALXUmNSsZF5LNkqVjhpEV8anyiaZ=9S4MATT2PHdU59Jgj6wsA@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
 <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
 <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
 <CAOi1vP_HwML=7+iZrJFzJpbRcSomKBX5r8RT2hnRGF23agN1FQ@mail.gmail.com>
 <CAE2NFgVVth4BRQNCy6SFOnLnLf0NQ=kgoHcuMLpnz5beG3w-nQ@mail.gmail.com>
 <CAOi1vP8fg4cmAvOOKQWZUcvNpiQ5CzpVr1q=rjhtTjasa85msQ@mail.gmail.com>
 <CAE2NFgXvtZYzD9EGp+GHxcSndS3AoKyvpZkwdmsTr2rB9KF__w@mail.gmail.com>
 <CAOi1vP_7dHOVnxTHEhfYsiXQGvd+e8ecsPf10cg0s33Ry4Vt9Q@mail.gmail.com>
 <CAOi1vP_X=60SHQzJ4v2yZ4JypYgXm+r3GNHn0_7tZkRcte-v3w@mail.gmail.com>
 <CAE2NFgXj0PpX0uN6RGNuXquwkmBncr7KHANaSK6c8SAVTWUVLQ@mail.gmail.com>
 <CAOi1vP-4ua0y=XAraG-wfGaj-5Y9tZ+XnExza3pt_oWceL-eGQ@mail.gmail.com>
 <CALXUmNTwDOKZm=S6mkA4=HzM8H=pHWSuX1VwJZg3dtTRd9e8Tw@mail.gmail.com>
 <CALXUmNQrmPGexE5_ArBwnK2pgOKr2WKfM_hqZRX4_RZ_z6aTkQ@mail.gmail.com>
 <CALXUmNS0dtX5T3++8JgtoWoBHVGB-Bgh+BZpqYiARtMG3qJVCA@mail.gmail.com>
 <CAFXAJ64a9KqF5A+f6BZsD_LtGUniqya+Wz0oMtcaLhxrnW1TFA@mail.gmail.com> <CALXUmNSkR92CYWX4DU37RuiwHm-nubYxq0egQPpnBqN-7=VTwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33315 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbcG2XLf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 19:11:35 -0400
Received: by mail-io0-f177.google.com with SMTP id 38so141931192iol.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 16:11:34 -0700 (PDT)
In-Reply-To: <CALXUmNSkR92CYWX4DU37RuiwHm-nubYxq0egQPpnBqN-7=VTwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cliff Pajaro <cpajaro@gaikai.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Patrick McLean <patrickm@gaikai.com>, Ceph Development <ceph-devel@vger.kernel.org>, Roderick Colenbrander <roderick@gaikai.com>, Rae Yip <ryip@gaikai.com>, Frank Reed <freed@gaikai.com>

Thanks for the info on the 510 snapshot per rbd kernel limit.

We're also wondering what the rbd metadata limits might be. Are the
metadata key and value size limitations listed anywhere?

We're planning on using key names with 64 characters (the same string
as the snapshot name) with a string json payload in the value field.

So on on an rbd with with 100 snapshots, we would also have 100
metadata key/value pairs. The value/data would probably be at least
100 characters per key.

On Wed, Jul 27, 2016 at 12:26 PM, Victor Payno <vpayno@gaikai.com> wrot=
e:
> Yes, it has 697 snapshots. The overall average snapshot count per rdb=
 is
> 355. The lowest number is 3 and the highest number is 708.
>
> Interestingly enough we can't map that rbd anymore.
>
> $ rbd info
> test-rbd/3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5ee=
d9c7-willnotmap
> rbd image
> '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5eed9c7-wil=
lnotmap':
>         size 9536 MB in 2385 objects
>         order 22 (4096 kB objects)
>         block_name_prefix: rbd_data.11e601379f78e7
>         format: 2
>         features: layering, striping
>         flags:
>         stripe unit: 4096 kB
>         stripe count: 1
>
>
> When we try to mount it, it hangs here:
>
> setsockopt(3, SOL_SOCKET, SO_PASSCRED, [1], 4) =3D 0
> open("/sys/bus/rbd/add_single_major", O_WRONLY) =3D 4
> write(4, "192.168.2.63:6789,192.168.3.63:6789,"..., 147
>
>
> Other rbds mount fine.
>
> The cluster health is HEALTH_OK.
>
>
>
>
> From Cliff:
>
> Sifting through the osd2's log for "d960431b30e2f" I see this:
>
> 2016-07-27 00:47:47.199252 7f1ac7dbb700  1 -- 10.9.228.101:6814/25892=
 <=3D=3D
> client.1252427 10.9.72.23:0/273648291 13 =3D=3D=3D=3D osd_op(client.1=
252427.0:19
> rbd_header.d960431b30e2f [call lock.lock] 37.a819967
> ondisk+write+known_if_redirected e107453) v6 =3D=3D=3D=3D 210+0+51 (4=
053684278 0
> 659001106) 0x55c9ec362000 con 0x55c9f0101600
> 2016-07-27 00:47:47.199515 7f1ad3539700  1 -- 10.9.228.101:6814/25892=
 -->
> 10.9.72.23:0/273648291 -- osd_op_reply(19 rbd_header.d960431b30e2f [c=
all
> lock.lock] v0'0 uv0 ondisk =3D -16 ((16) Device or resource busy)) v6=
 -- ?+0
>
> On Tue, Jul 26, 2016 at 8:59 PM, Cliff Pajaro <cpajaro@gaikai.com> wr=
ote:
>>
>> Sifting through the osd2's log for "d960431b30e2f" I see this:
>>
>>> 2016-07-27 00:47:47.199252 7f1ac7dbb700  1 -- 10.9.228.101:6814/258=
92 <=3D=3D
>>> client.1252427 10.9.72.23:0/273648291 13 =3D=3D=3D=3D osd_op(client=
=2E1252427.0:19
>>> rbd_header.d960431b30e2f [call lock.lock] 37.a819967
>>> ondisk+write+known_if_redirected e107453) v6 =3D=3D=3D=3D 210+0+51 =
(4053684278 0
>>> 659001106) 0x55c9ec362000 con 0x55c9f0101600
>>> 2016-07-27 00:47:47.199515 7f1ad3539700  1 -- 10.9.228.101:6814/258=
92 -->
>>> 10.9.72.23:0/273648291 -- osd_op_reply(19 rbd_header.d960431b30e2f =
[call
>>> lock.lock] v0'0 uv0 ondisk =3D -16 ((16) Device or resource busy)) =
v6 -- ?+0
>>> 0x55c9ee4b8b00 con 0x55c9f0101600
>>
>>
>>
>> On Tue, Jul 26, 2016 at 6:48 PM, Victor Payno <vpayno@gaikai.com> wr=
ote:
>>>
>>> REQUESTS 1 homeless 0
>>> 322452  osd2    37.a819967      [2]/2   [2]/2
>>> rbd_header.d960431b30e2f        0x400019        3       0'0     cal=
l
>>> LINGER REQUESTS
>>> 167     osd2    37.a819967      [2]/2   [2]/2
>>> rbd_header.d960431b30e2f        0x24    2       WC/0
>>>
>>>
>>> ceph-osd.2.log.gz has been attached/uploaded to here:
>>> http://tracker.ceph.com/issues/16630
>>>
>>>
>>> On Tue, Jul 26, 2016 at 3:31 PM, Victor Payno <vpayno@gaikai.com> w=
rote:
>>> > We'll have to run the test again for the OSD log data. Forgot to =
make
>>> > sure that the ceph log partition wasn't full.
>>> >
>>> >
>>> > client:
>>> > /sys/kernel/debug/ceph/e88d2684-47c1-5a64-a275-6e375d11b557.clien=
t1242818/osdc
>>> >
>>> > REQUESTS 1 homeless 0
>>> > 11475   osd2    37.a819967      [2]/2   [2]/2
>>> > rbd_header.d960431b30e2f        0x400019        3       0'0     c=
all
>>> > LINGER REQUESTS
>>> > 91      osd0    37.851f81e1     [0]/0   [0]/0
>>> > rbd_header.d94f26cf2eafd        0x24    0       WC/0
>>> > 93      osd0    37.98ca7eab     [0]/0   [0]/0
>>> > rbd_header.d94b96a21ce28        0x24    0       WC/0
>>> > 106     osd0    37.9720d758     [0]/0   [0]/0
>>> > rbd_header.d94f53a7da731        0x24    0       WC/0
>>> > 104     osd1    37.de8088a1     [1]/1   [1]/1
>>> > rbd_header.d94f52e0f9b4d        0x24    0       WC/0
>>> > 105     osd1    37.db9af301     [1]/1   [1]/1
>>> > rbd_header.d94f1ed40c97 0x24    0       WC/0
>>> > 14      osd2    37.a819967      [2]/2   [2]/2
>>> > rbd_header.d960431b30e2f        0x24    2       WC/0
>>> > 96      osd2    37.8fb9befc     [2]/2   [2]/2
>>> > rbd_header.d94f03028192c        0x24    0       WC/0
>>> > 82      osd3    37.370c3798     [3]/3   [3]/3
>>> > rbd_header.d94da25e9605b        0x24    0       WC/0
>>> > 87      osd4    37.9c510a15     [4]/4   [4]/4
>>> > rbd_header.d94f079de7a55        0x24    0       WC/0
>>> > 85      osd5    37.832091ad     [5]/5   [5]/5
>>> > rbd_header.d94f22d15792a        0x24    0       WC/0
>>> > 94      osd5    37.344d5f3      [5]/5   [5]/5   rbd_header.d94f6b=
30f4a
>>> >  0x24    0       WC/0
>>> > 103     osd5    37.4cb8bb74     [5]/5   [5]/5
>>> > rbd_header.d94ef2bac496b        0x24    0       WC/0
>>> > 77      osd6    37.7c480437     [6]/6   [6]/6
>>> > rbd_header.d94c057a9331d        0x24    1       WC/0
>>> > 88      osd7    37.58634cdc     [7]/7   [7]/7
>>> > rbd_header.d94da55fd8a34        0x24    1       WC/0
>>> > 98      osd7    37.a61c68b      [7]/7   [7]/7
>>> > rbd_header.d94ce7d11bf7f        0x24    0       WC/0
>>> >
>>> >
>>> > rbd image
>>> > '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5eed9c7=
':
>>> >         size 9536 MB in 2385 objects
>>> >         order 22 (4096 kB objects)
>>> >         block_name_prefix: rbd_data.d960431b30e2f
>>> >         format: 2
>>> >         features: layering, striping
>>> >         flags:
>>> >         stripe unit: 4096 kB
>>> >         stripe count: 1
>>> >
>>> >
>>> > osdmaptool: osdmap file '/tmp/osdmap'
>>> >  object
>>> > '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5eed9c7=
'
>>> > -> 37.c6 -> [7]
>>> >
>>> > On Tue, Jul 26, 2016 at 3:27 PM, Victor Payno <vpayno@gaikai.com>
>>> > wrote:
>>> >> We'll have to run the test again for the OSD log data. Forgot to=
 make
>>> >> sure
>>> >> that the ceph log partition wasn't full.
>>> >>
>>> >>
>>> >> client:
>>> >>
>>> >> /sys/kernel/debug/ceph/e88d2684-47c1-5a64-a275-6e375d11b557.clie=
nt1242818/osdc
>>> >>
>>> >> REQUESTS 1 homeless 0
>>> >> 11475   osd2    37.a819967      [2]/2   [2]/2
>>> >> rbd_header.d960431b30e2f
>>> >> 0x400019        3       0'0     call
>>> >> LINGER REQUESTS
>>> >> 91      osd0    37.851f81e1     [0]/0   [0]/0
>>> >> rbd_header.d94f26cf2eafd
>>> >> 0x24    0       WC/0
>>> >> 93      osd0    37.98ca7eab     [0]/0   [0]/0
>>> >> rbd_header.d94b96a21ce28
>>> >> 0x24    0       WC/0
>>> >> 106     osd0    37.9720d758     [0]/0   [0]/0
>>> >> rbd_header.d94f53a7da731
>>> >> 0x24    0       WC/0
>>> >> 104     osd1    37.de8088a1     [1]/1   [1]/1
>>> >> rbd_header.d94f52e0f9b4d
>>> >> 0x24    0       WC/0
>>> >> 105     osd1    37.db9af301     [1]/1   [1]/1
>>> >> rbd_header.d94f1ed40c97 0x24
>>> >> 0       WC/0
>>> >> 14      osd2    37.a819967      [2]/2   [2]/2
>>> >> rbd_header.d960431b30e2f
>>> >> 0x24    2       WC/0
>>> >> 96      osd2    37.8fb9befc     [2]/2   [2]/2
>>> >> rbd_header.d94f03028192c
>>> >> 0x24    0       WC/0
>>> >> 82      osd3    37.370c3798     [3]/3   [3]/3
>>> >> rbd_header.d94da25e9605b
>>> >> 0x24    0       WC/0
>>> >> 87      osd4    37.9c510a15     [4]/4   [4]/4
>>> >> rbd_header.d94f079de7a55
>>> >> 0x24    0       WC/0
>>> >> 85      osd5    37.832091ad     [5]/5   [5]/5
>>> >> rbd_header.d94f22d15792a
>>> >> 0x24    0       WC/0
>>> >> 94      osd5    37.344d5f3      [5]/5   [5]/5   rbd_header.d94f6=
b30f4a
>>> >> 0x24
>>> >> 0       WC/0
>>> >> 103     osd5    37.4cb8bb74     [5]/5   [5]/5
>>> >> rbd_header.d94ef2bac496b
>>> >> 0x24    0       WC/0
>>> >> 77      osd6    37.7c480437     [6]/6   [6]/6
>>> >> rbd_header.d94c057a9331d
>>> >> 0x24    1       WC/0
>>> >> 88      osd7    37.58634cdc     [7]/7   [7]/7
>>> >> rbd_header.d94da55fd8a34
>>> >> 0x24    1       WC/0
>>> >> 98      osd7    37.a61c68b      [7]/7   [7]/7
>>> >> rbd_header.d94ce7d11bf7f
>>> >> 0x24    0       WC/0
>>> >>
>>> >>
>>> >> rbd image
>>> >> '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5eed9c=
7':
>>> >>         size 9536 MB in 2385 objects
>>> >>         order 22 (4096 kB objects)
>>> >>         block_name_prefix: rbd_data.d960431b30e2f
>>> >>         format: 2
>>> >>         features: layering, striping
>>> >>         flags:
>>> >>         stripe unit: 4096 kB
>>> >>         stripe count: 1
>>> >>
>>> >>
>>> >> osdmaptool: osdmap file '/tmp/osdmap'
>>> >>  object
>>> >> '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5eed9c=
7'
>>> >> -> 37.c6 -> [7]
>>> >>
>>> >>
>>> >>
>>> >>
>>> >>
>>> >>
>>> >> On Tue, Jul 26, 2016 at 11:11 AM, Ilya Dryomov <idryomov@gmail.c=
om>
>>> >> wrote:
>>> >>>
>>> >>> On Tue, Jul 26, 2016 at 7:58 PM, Patrick McLean <patrickm@gaika=
i.com>
>>> >>> wrote:
>>> >>> > Hi Ilya,
>>> >>> >
>>> >>> > We discovered this weekend that enabling lockdep in the kerne=
l
>>> >>> > makes the
>>> >>> > issue go away. We are working on reproducing without lockdep,=
 and
>>> >>> > isolating
>>> >>> > the issue in the OSD logs. We should be have OSD debug logs t=
his
>>> >>> > week.
>>> >>>
>>> >>> I'm going to need the "cat /sys/kernel/debug/ceph/*/osdc" outpu=
t, the
>>> >>> osd log for the osd from that output, and the output of "echo w=
" and
>>> >>> "echo t" to /proc/sysrq-trigger.
>>> >>>
>>> >>> Thanks,
>>> >>>
>>> >>>                 Ilya
>>> >>
>>> >>
>>> >>
>>> >>
>>> >> --
>>> >> Victor Payno
>>> >> =E3=83=93=E3=82=AF=E3=82=BF=E3=83=BC=C2=B7=E3=83=9A=E3=82=A4=E3=83=
=B3
>>> >>
>>> >> Sr. Release Engineer
>>> >> =E3=82=B7=E3=83=8B=E3=82=A2=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=B9=E3=
=82=A8=E3=83=B3=E3=82=B8=E3=83=8B=E3=82=A2
>>> >>
>>> >>
>>> >>
>>> >> Gaikai, a Sony Computer Entertainment Company   =E2=88=86=E2=97=8B=
=C3=97=E2=96=A1
>>> >> =E3=82=AC=E3=82=A4=E3=82=AB=E3=82=A4=E3=80=81=E3=82=BD=E3=83=8B=E3=
=83=BC=E3=83=BB=E3=82=B3=E3=83=B3=E3=83=94=E3=83=A5=E3=83=BC=E3=82=BF=E3=
=82=A8=E3=83=B3=E3=82=BF=E3=83=86=E3=82=A4=E3=83=B3=E3=83=A1=E3=83=B3=E3=
=83=88=E5=82=98=E4=B8=8B=E4=BC=9A=E7=A4=BE
>>> >> 65 Enterprise
>>> >> Aliso Viejo, CA 92656 USA
>>> >>
>>> >> Web: www.gaikai.com
>>> >> Email: vpayno@gaikai.com
>>> >> Phone: (949) 330-6850
>>> >
>>> >
>>> >
>>> > --
>>> > Victor Payno
>>> > =E3=83=93=E3=82=AF=E3=82=BF=E3=83=BC=C2=B7=E3=83=9A=E3=82=A4=E3=83=
=B3
>>> >
>>> > Sr. Release Engineer
>>> > =E3=82=B7=E3=83=8B=E3=82=A2=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=B9=E3=
=82=A8=E3=83=B3=E3=82=B8=E3=83=8B=E3=82=A2
>>> >
>>> >
>>> >
>>> > Gaikai, a Sony Computer Entertainment Company   =E2=88=86=E2=97=8B=
=C3=97=E2=96=A1
>>> > =E3=82=AC=E3=82=A4=E3=82=AB=E3=82=A4=E3=80=81=E3=82=BD=E3=83=8B=E3=
=83=BC=E3=83=BB=E3=82=B3=E3=83=B3=E3=83=94=E3=83=A5=E3=83=BC=E3=82=BF=E3=
=82=A8=E3=83=B3=E3=82=BF=E3=83=86=E3=82=A4=E3=83=B3=E3=83=A1=E3=83=B3=E3=
=83=88=E5=82=98=E4=B8=8B=E4=BC=9A=E7=A4=BE
>>> > 65 Enterprise
>>> > Aliso Viejo, CA 92656 USA
>>> >
>>> > Web: www.gaikai.com
>>> > Email: vpayno@gaikai.com
>>> > Phone: (949) 330-6850
>>>
>>>
>>>
>>> --
>>> Victor Payno
>>> =E3=83=93=E3=82=AF=E3=82=BF=E3=83=BC=C2=B7=E3=83=9A=E3=82=A4=E3=83=B3
>>>
>>> Sr. Release Engineer
>>> =E3=82=B7=E3=83=8B=E3=82=A2=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=B9=E3=82=
=A8=E3=83=B3=E3=82=B8=E3=83=8B=E3=82=A2
>>>
>>>
>>>
>>> Gaikai, a Sony Computer Entertainment Company   =E2=88=86=E2=97=8B=C3=
=97=E2=96=A1
>>> =E3=82=AC=E3=82=A4=E3=82=AB=E3=82=A4=E3=80=81=E3=82=BD=E3=83=8B=E3=83=
=BC=E3=83=BB=E3=82=B3=E3=83=B3=E3=83=94=E3=83=A5=E3=83=BC=E3=82=BF=E3=82=
=A8=E3=83=B3=E3=82=BF=E3=83=86=E3=82=A4=E3=83=B3=E3=83=A1=E3=83=B3=E3=83=
=88=E5=82=98=E4=B8=8B=E4=BC=9A=E7=A4=BE
>>> 65 Enterprise
>>> Aliso Viejo, CA 92656 USA
>>>
>>> Web: www.gaikai.com
>>> Email: vpayno@gaikai.com
>>> Phone: (949) 330-6850
>>
>>
>
>
>
> --
> Victor Payno
> =E3=83=93=E3=82=AF=E3=82=BF=E3=83=BC=C2=B7=E3=83=9A=E3=82=A4=E3=83=B3
>
> Sr. Release Engineer
> =E3=82=B7=E3=83=8B=E3=82=A2=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=B9=E3=82=
=A8=E3=83=B3=E3=82=B8=E3=83=8B=E3=82=A2
>
>
>
> Gaikai, a Sony Computer Entertainment Company   =E2=88=86=E2=97=8B=C3=
=97=E2=96=A1
> =E3=82=AC=E3=82=A4=E3=82=AB=E3=82=A4=E3=80=81=E3=82=BD=E3=83=8B=E3=83=
=BC=E3=83=BB=E3=82=B3=E3=83=B3=E3=83=94=E3=83=A5=E3=83=BC=E3=82=BF=E3=82=
=A8=E3=83=B3=E3=82=BF=E3=83=86=E3=82=A4=E3=83=B3=E3=83=A1=E3=83=B3=E3=83=
=88=E5=82=98=E4=B8=8B=E4=BC=9A=E7=A4=BE
> 65 Enterprise
> Aliso Viejo, CA 92656 USA
>
> Web: www.gaikai.com
> Email: vpayno@gaikai.com
> Phone: (949) 330-6850



--=20
Victor Payno
=E3=83=93=E3=82=AF=E3=82=BF=E3=83=BC=C2=B7=E3=83=9A=E3=82=A4=E3=83=B3

Sr. Release Engineer
=E3=82=B7=E3=83=8B=E3=82=A2=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=B9=E3=82=A8=
=E3=83=B3=E3=82=B8=E3=83=8B=E3=82=A2



Gaikai, a Sony Computer Entertainment Company   =E2=88=86=E2=97=8B=C3=97=
=E2=96=A1
=E3=82=AC=E3=82=A4=E3=82=AB=E3=82=A4=E3=80=81=E3=82=BD=E3=83=8B=E3=83=BC=
=E3=83=BB=E3=82=B3=E3=83=B3=E3=83=94=E3=83=A5=E3=83=BC=E3=82=BF=E3=82=A8=
=E3=83=B3=E3=82=BF=E3=83=86=E3=82=A4=E3=83=B3=E3=83=A1=E3=83=B3=E3=83=88=
=E5=82=98=E4=B8=8B=E4=BC=9A=E7=A4=BE
65 Enterprise
Aliso Viejo, CA 92656 USA

Web: www.gaikai.com
Email: vpayno@gaikai.com
Phone: (949) 330-6850
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
