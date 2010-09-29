From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: Usage of rbd
Date: Wed, 29 Sep 2010 11:42:49 +0900
Message-ID: <AANLkTimge7x+P6JANFXHty5C9crPQYmiFu1YD5OCK1S2@mail.gmail.com>
References: <AANLkTikUMZiGmjF9xPhn-9UiknrnQWLLrMgFEFU83PF7@mail.gmail.com>
 <AANLkTi=mftr=1=KG18nBpKHycGO24QPvLT6FJvFjyh3w@mail.gmail.com> <AANLkTin6oL-U4_0s4Qk5Uc9LctgP_71K0BxJDtbXuRtt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60507 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0I2CnK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Sep 2010 22:43:10 -0400
Received: by wyb28 with SMTP id 28so317643wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Sep 2010 19:43:09 -0700 (PDT)
In-Reply-To: <AANLkTin6oL-U4_0s4Qk5Uc9LctgP_71K0BxJDtbXuRtt@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ml ml <takada_ml@mail.syonbori.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

Hi,

I haven't check debug output(yet), but it looks similar here.
rbd create never succeeded on my environment.

syuu

On Wed, Sep 29, 2010 at 9:32 AM, ml ml <takada_ml@mail.syonbori.net> wr=
ote:
> Hi
>
> I also trying to use rbd in my environment, following the wiki's inst=
ruction.
> and I did "ceph class activate rbd 1.2", but still not works.
>
>
>
> My situation:
>
> # mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs
> # /etc/init.d/ceph -c /usr/local/etc/ceph/ceph.conf --allhosts start
> # cclass -a
> # ceph class activate rbd 1.2
> (snip)
> 10.09.29_09:01:30.047510 mon <- [class,activate,rbd,1.2]
> (snip)
> 10.09.29_09:01:31.067373 mon0 -> 'updated' (0)
>
> # ceph class list
> (snip)
> mon <- [class,list]
> 192.168.101.41:0/2359 --> mon0 192.168.101.41:6789/0 --
> mon_command(class list v 0) v1 -- ?+0 0x1d4ce30
> 192.168.101.41:0/2359 <=3D=3D mon0 192.168.101.41:6789/0 4 =3D=3D=3D=3D
> mon_command_ack([class,list]=3D0 installed classes:
> rbd (v1.2 [x86-64]) [active]
> =C2=A0v3) v1 =3D=3D=3D=3D 96+0+0 (1704564143 0 0) 0x7f0268000bf0
> 10.09.29_09:01:44.151874 mon0 -> 'installed classes:
> rbd (v1.2 [x86-64]) [active]
> ' (0)
>
>
> -* looks like OK. create new pool named "testpool", and make
> -* new image named "testdata" in it.
>
>
> # rados lspools
> (snip)
> data
> metadata
> casdata
> rbd
>
> # rados mkpool testpool
> (snip)
> successfully created pool testpool
>
>
> # rbd -p testpool create testdata --size 128
> :/2428 messenger.start
> :/2428 --> mon0 192.168.101.41:6789/0 -- auth(proto 0 30 bytes) v1 --
> ?+0 0x25cfe10
> 192.168.101.41:0/2428 learned my addr 192.168.101.41:0/2428
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 1 =3D=3D=3D=3D
> auth_reply(proto 1 0 Success) v1 =3D=3D=3D=3D 24+0+0 (1462504351 0 0)
> 0x7ff88c000940
> 192.168.101.41:0/2428 --> mon0 192.168.101.41:6789/0 --
> mon_subscribe({monmap=3D0+}) v1 -- ?+0 0x25d57d0
> 192.168.101.41:0/2428 --> mon0 192.168.101.41:6789/0 --
> mon_subscribe({monmap=3D0+,osdmap=3D0}) v1 -- ?+0 0x25d59b0
> 192.168.101.41:0/2428 --> mon0 192.168.101.41:6789/0 --
> mon_subscribe({monmap=3D0+,osdmap=3D0}) v1 -- ?+0 0x25d4180
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 2 =3D=3D=3D=3D=
 mon_map v1
> =3D=3D=3D=3D 191+0+0 (3527398169 0 0) 0x7ff88c000c40
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 3 =3D=3D=3D=3D
> mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (388814775 0 0) 0x7ff8=
8c000920
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 4 =3D=3D=3D=3D=
 mon_map v1
> =3D=3D=3D=3D 191+0+0 (3527398169 0 0) 0x7ff88c000bf0
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 5 =3D=3D=3D=3D
> osd_map(5,5) v1 =3D=3D=3D=3D 1153+0+0 (1530501066 0 0) 0x7ff88c000920
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 6 =3D=3D=3D=3D
> mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (388814775 0 0) 0x7ff8=
8c000920
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 7 =3D=3D=3D=3D=
 mon_map v1
> =3D=3D=3D=3D 191+0+0 (3527398169 0 0) 0x7ff88c000bf0
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 8 =3D=3D=3D=3D
> osd_map(5,5) v1 =3D=3D=3D=3D 1153+0+0 (1530501066 0 0) 0x7ff88c000920
> 192.168.101.41:0/2428 --> osd0 192.168.101.41:6801/2231 --
> osd_op(client4104.0:1 testdata.rbd [stat 0~0] 4.49b3) v1 -- ?+0
> 0x25d43c0
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 9 =3D=3D=3D=3D
> mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (388814775 0 0) 0x7ff8=
8c0011e0
> 192.168.101.41:0/2428 <=3D=3D osd0 192.168.101.41:6801/2231 1 =3D=3D=3D=
=3D
> osd_op_reply(1 testdata.rbd [stat 0~0] =3D -2 (No such file or
> directory)) v1 =3D=3D=3D=3D 98+0+0 (1237653720 0 0) 0x7ff87c000990
> 192.168.101.41:0/2428 --> osd0 192.168.101.41:6801/2231 --
> osd_op(client4104.0:2 rbd_info [write 0~0] 4.573a) v1 -- ?+0 0x25d43c=
0
> 192.168.101.41:0/2428 <=3D=3D osd0 192.168.101.41:6801/2231 2 =3D=3D=3D=
=3D
> osd_op_reply(2 rbd_info [write 0~0] =3D 0) v1 =3D=3D=3D=3D 94+0+0 (38=
94334133 0
> 0) 0x7ff87c000990
> 192.168.101.41:0/2428 --> osd0 192.168.101.41:6801/2231 --
> osd_op(client4104.0:3 rbd_info [call rbd.assign_bid] 4.573a) v1 -- ?+=
0
> 0x25d43a0
> 192.168.101.41:0/2428 --> mon0 192.168.101.41:6789/0 --
> mon_subscribe({monmap=3D2+,osdmap=3D6}) v1 -- ?+0 0x7ff874000a90
> 192.168.101.41:0/2428 --> osd0 192.168.101.41:6801/2231 -- ping v1 --
> ?+0 0x7ff874000d20
> 192.168.101.41:0/2428 <=3D=3D mon0 192.168.101.41:6789/0 10 =3D=3D=3D=
=3D
> mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (388814775 0 0) 0x7ff8=
8c000920
> 192.168.101.41:0/2428 --> osd0 192.168.101.41:6801/2231 -- ping v1 --
> ?+0 0x7ff874000d20
>
> -* rbd command doesnt return, the ping v1 log continues.
> -* mon0, mds0, osd0 are on the same machine and they work well in cep=
h
> fuse environment.
> -* the result is same if i change testpool to rbd...
>
> 2010/9/29 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>> On Tue, Sep 28, 2010 at 8:55 AM, Takuya ASADA <syuu@dokukino.com> wr=
ote:
>>>
>>> Hi,
>>>
>>> I'm trying to test kvm-rbd, and I just failed to create image on it=
=2E
>>> I followed installation sequence on the wiki
>>> (http://ceph.newdream.net/wiki/Kvm-rbd),
>>> and executed
>>> $ qemu-img create -f rbd rbd:data/foo 10G
>>> it returned
>>>
>>> failed assigning block id
>>> qemu-img: rbd:data/foo: error while creating rbd: Input/output erro=
r
>>>
>>> Then I looked into source code, and realized maybe I need to load l=
ibcls_rbd.so,
>>> so I executed
>>> $ cclass -a
>>> $ ceph class list
>>> rbd class shows up.
>>>
>>> 10.09.29_00:55:53.939866 mon <- [class,list]
>>> 10.09.29_00:55:53.940230 mon0 -> 'installed classes:
>>> rbd (v1.2 [x86-64])
>>> ' (0)
>>>
>>> Then I tried "qemu-img create" again, also "rbd create", it didn't =
work at all.
>>> Like this:
>>>
>>> $ rbd -p hoge99 --size 10 create test.img
>>> failed to assign a block name for image
>>> create error: Operation not supported
>>>
>>> $ qemu-img create -f rbd rbd:data/foo 10G
>>> Formatting 'rbd:data/foo', fmt=3Drbd size=3D10737418240 cluster_siz=
e=3D0
>>> failed assigning block id
>>> qemu-img: rbd:data/foo: error while creating rbd: Input/output erro=
r
>>>
>>> osd and mon are working correctly, I can use it via rados command a=
nd librados.
>>>
>>> My question is:
>>> - Am I missing something to start using rbd?
>>
>> The rbd class is loaded but not activated. You can run 'ceph class
>> activate rbd 1.2', it should fix it (note that it takes a minute to
>> propagate).
>>
>>>
>>> - Do I need rbd kernel module for kvm-rbd?
>>> I thought it's just a userland application, which calling librados.
>>>
>> It is a userland application, and you don't need any kernel module.
>>
>> Thanks,
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
> --
> Software Laboratory, Graduate school of Systems and Information
> Engineering, Univ. of Tsukuba.
> Shingo TAKADA
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
