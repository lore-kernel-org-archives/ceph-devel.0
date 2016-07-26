From: Victor Payno <vpayno@gaikai.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Tue, 26 Jul 2016 15:31:04 -0700
Message-ID: <CALXUmNQrmPGexE5_ArBwnK2pgOKr2WKfM_hqZRX4_RZ_z6aTkQ@mail.gmail.com>
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
 <CAOi1vP-4ua0y=XAraG-wfGaj-5Y9tZ+XnExza3pt_oWceL-eGQ@mail.gmail.com> <CALXUmNTwDOKZm=S6mkA4=HzM8H=pHWSuX1VwJZg3dtTRd9e8Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33763 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757407AbcGZWbZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2016 18:31:25 -0400
Received: by mail-io0-f182.google.com with SMTP id 38so47448646iol.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2016 15:31:25 -0700 (PDT)
In-Reply-To: <CALXUmNTwDOKZm=S6mkA4=HzM8H=pHWSuX1VwJZg3dtTRd9e8Tw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick McLean <patrickm@gaikai.com>, Ceph Development <ceph-devel@vger.kernel.org>, Cliff Pajaro <cpajaro@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>, Rae Yip <ryip@gaikai.com>, Frank Reed <freed@gaikai.com>

We'll have to run the test again for the OSD log data. Forgot to make
sure that the ceph log partition wasn't full.


client: /sys/kernel/debug/ceph/e88d2684-47c1-5a64-a275-6e375d11b557.cli=
ent1242818/osdc

REQUESTS 1 homeless 0
11475   osd2    37.a819967      [2]/2   [2]/2
rbd_header.d960431b30e2f        0x400019        3       0'0     call
LINGER REQUESTS
91      osd0    37.851f81e1     [0]/0   [0]/0
rbd_header.d94f26cf2eafd        0x24    0       WC/0
93      osd0    37.98ca7eab     [0]/0   [0]/0
rbd_header.d94b96a21ce28        0x24    0       WC/0
106     osd0    37.9720d758     [0]/0   [0]/0
rbd_header.d94f53a7da731        0x24    0       WC/0
104     osd1    37.de8088a1     [1]/1   [1]/1
rbd_header.d94f52e0f9b4d        0x24    0       WC/0
105     osd1    37.db9af301     [1]/1   [1]/1
rbd_header.d94f1ed40c97 0x24    0       WC/0
14      osd2    37.a819967      [2]/2   [2]/2
rbd_header.d960431b30e2f        0x24    2       WC/0
96      osd2    37.8fb9befc     [2]/2   [2]/2
rbd_header.d94f03028192c        0x24    0       WC/0
82      osd3    37.370c3798     [3]/3   [3]/3
rbd_header.d94da25e9605b        0x24    0       WC/0
87      osd4    37.9c510a15     [4]/4   [4]/4
rbd_header.d94f079de7a55        0x24    0       WC/0
85      osd5    37.832091ad     [5]/5   [5]/5
rbd_header.d94f22d15792a        0x24    0       WC/0
94      osd5    37.344d5f3      [5]/5   [5]/5   rbd_header.d94f6b30f4a
 0x24    0       WC/0
103     osd5    37.4cb8bb74     [5]/5   [5]/5
rbd_header.d94ef2bac496b        0x24    0       WC/0
77      osd6    37.7c480437     [6]/6   [6]/6
rbd_header.d94c057a9331d        0x24    1       WC/0
88      osd7    37.58634cdc     [7]/7   [7]/7
rbd_header.d94da55fd8a34        0x24    1       WC/0
98      osd7    37.a61c68b      [7]/7   [7]/7
rbd_header.d94ce7d11bf7f        0x24    0       WC/0


rbd image '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5ee=
d9c7':
        size 9536 MB in 2385 objects
        order 22 (4096 kB objects)
        block_name_prefix: rbd_data.d960431b30e2f
        format: 2
        features: layering, striping
        flags:
        stripe unit: 4096 kB
        stripe count: 1


osdmaptool: osdmap file '/tmp/osdmap'
 object '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5eed9=
c7'
-> 37.c6 -> [7]

On Tue, Jul 26, 2016 at 3:27 PM, Victor Payno <vpayno@gaikai.com> wrote=
:
> We'll have to run the test again for the OSD log data. Forgot to make=
 sure
> that the ceph log partition wasn't full.
>
>
> client:
> /sys/kernel/debug/ceph/e88d2684-47c1-5a64-a275-6e375d11b557.client124=
2818/osdc
>
> REQUESTS 1 homeless 0
> 11475   osd2    37.a819967      [2]/2   [2]/2   rbd_header.d960431b30=
e2f
> 0x400019        3       0'0     call
> LINGER REQUESTS
> 91      osd0    37.851f81e1     [0]/0   [0]/0   rbd_header.d94f26cf2e=
afd
> 0x24    0       WC/0
> 93      osd0    37.98ca7eab     [0]/0   [0]/0   rbd_header.d94b96a21c=
e28
> 0x24    0       WC/0
> 106     osd0    37.9720d758     [0]/0   [0]/0   rbd_header.d94f53a7da=
731
> 0x24    0       WC/0
> 104     osd1    37.de8088a1     [1]/1   [1]/1   rbd_header.d94f52e0f9=
b4d
> 0x24    0       WC/0
> 105     osd1    37.db9af301     [1]/1   [1]/1   rbd_header.d94f1ed40c=
97 0x24
> 0       WC/0
> 14      osd2    37.a819967      [2]/2   [2]/2   rbd_header.d960431b30=
e2f
> 0x24    2       WC/0
> 96      osd2    37.8fb9befc     [2]/2   [2]/2   rbd_header.d94f030281=
92c
> 0x24    0       WC/0
> 82      osd3    37.370c3798     [3]/3   [3]/3   rbd_header.d94da25e96=
05b
> 0x24    0       WC/0
> 87      osd4    37.9c510a15     [4]/4   [4]/4   rbd_header.d94f079de7=
a55
> 0x24    0       WC/0
> 85      osd5    37.832091ad     [5]/5   [5]/5   rbd_header.d94f22d157=
92a
> 0x24    0       WC/0
> 94      osd5    37.344d5f3      [5]/5   [5]/5   rbd_header.d94f6b30f4=
a  0x24
> 0       WC/0
> 103     osd5    37.4cb8bb74     [5]/5   [5]/5   rbd_header.d94ef2bac4=
96b
> 0x24    0       WC/0
> 77      osd6    37.7c480437     [6]/6   [6]/6   rbd_header.d94c057a93=
31d
> 0x24    1       WC/0
> 88      osd7    37.58634cdc     [7]/7   [7]/7   rbd_header.d94da55fd8=
a34
> 0x24    1       WC/0
> 98      osd7    37.a61c68b      [7]/7   [7]/7   rbd_header.d94ce7d11b=
f7f
> 0x24    0       WC/0
>
>
> rbd image
> '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5eed9c7':
>         size 9536 MB in 2385 objects
>         order 22 (4096 kB objects)
>         block_name_prefix: rbd_data.d960431b30e2f
>         format: 2
>         features: layering, striping
>         flags:
>         stripe unit: 4096 kB
>         stripe count: 1
>
>
> osdmaptool: osdmap file '/tmp/osdmap'
>  object '3f370dbabff91bbb7ff23ae7a96e5cb414cac3408013cefed6d4b627b5ee=
d9c7'
> -> 37.c6 -> [7]
>
>
>
>
>
>
> On Tue, Jul 26, 2016 at 11:11 AM, Ilya Dryomov <idryomov@gmail.com> w=
rote:
>>
>> On Tue, Jul 26, 2016 at 7:58 PM, Patrick McLean <patrickm@gaikai.com=
>
>> wrote:
>> > Hi Ilya,
>> >
>> > We discovered this weekend that enabling lockdep in the kernel mak=
es the
>> > issue go away. We are working on reproducing without lockdep, and
>> > isolating
>> > the issue in the OSD logs. We should be have OSD debug logs this w=
eek.
>>
>> I'm going to need the "cat /sys/kernel/debug/ceph/*/osdc" output, th=
e
>> osd log for the osd from that output, and the output of "echo w" and
>> "echo t" to /proc/sysrq-trigger.
>>
>> Thanks,
>>
>>                 Ilya
>
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
