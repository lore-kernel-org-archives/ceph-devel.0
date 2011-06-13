From: biyan chen <riby.chen@gmail.com>
Subject: Re: Ceph to copy files. 500000 "journal throttle: waited for ops" and
 "fault with nothing to send"
Date: Mon, 13 Jun 2011 14:26:48 +0800
Message-ID: <BANLkTinqeX4Lu490=nCxa5HzoK+QX7iv+w@mail.gmail.com>
References: <BANLkTiky1sE2Jj9xcraaMZbc8Xqmwu2SgA@mail.gmail.com>
	<0839802B-37DB-4B97-AD2C-3B679AE98B58@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41544 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1FMG0u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 02:26:50 -0400
Received: by yia27 with SMTP id 27so815523yia.19
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jun 2011 23:26:48 -0700 (PDT)
In-Reply-To: <0839802B-37DB-4B97-AD2C-3B679AE98B58@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

I just copying some files. I check the flow of the network card only a
few hundred K

Suppose I have some 500000 small file, how to copy a file system into c=
eph?

Thanks!

2011/6/13 Gregory Farnum <gregory.farnum@dreamhost.com>:
>> 192.168.0.208:6801/26514 pipe(0x1281280 sd=3D13 pgs=3D4 cs=3D5 l=3D0=
).fault
>> with nothing to send, going to standby
> This message generally means that the other daemon has died, so it lo=
oks like maybe your OSDs are crashing?
>
>> 2011-06-11 00:26:56.654530 7f19f221c710 journal throttle: waited for=
 ops
> And this message means that the journal is throttling itself to wait =
for the on-disk store. You might be overloading your OSD disks?
> -Greg
>
> On Jun 10, 2011, at 7:55 PM, biyan chen wrote:
>
>> hi,all
>>
>> When I copy a contains about 500000 files folder to ceph file system=
!
>> All files size is under 2 M !
>>
>> In the executive to half of the time
>>
>> I found that the error log :
>>
>> [root@ceph_osd1 ~]# tail /var/log/ceph/osd.1.log -f
>> 2011-06-11 00:26:56.654530 7f19f221c710 journal throttle: waited for=
 ops
>> 2011-06-11 00:26:56.845956 7f19f2a1d710 journal throttle: waited for=
 ops
>> 2011-06-11 00:27:22.378345 7f19f2a1d710 journal throttle: waited for=
 ops
>> 2011-06-11 00:27:22.561483 7f19f221c710 journal throttle: waited for=
 ops
>> 2011-06-11 00:42:35.491143 7f19ef216710 -- 192.168.0.209:6801/31773 =
>>
>> 192.168.0.208:6801/26514 pipe(0x1281280 sd=3D13 pgs=3D4 cs=3D5 l=3D0=
).fault
>> with nothing to send, going to standby
>> 2011-06-11 06:03:07.834786 7f19ef216710 -- 192.168.0.209:6801/31773 =
>>
>> 192.168.0.208:6801/26514 pipe(0x4c20780 sd=3D16 pgs=3D0 cs=3D0 l=3D0=
).accept
>> connect_seq 6 vs existing 6 state 1
>> 2011-06-11 06:03:08.513372 7f19f2a1d710 osd1 4 pg[1.70( v 4'3143
>> (4'3141,4'3143] n=3D385 ec=3D2 les/c 4/4 3/3/3) [1,0] r=3D0 mlcod 4'=
3141
>> !hml active+clean]  sending commit on repgather(0x281df4b0 applied
>> 4'3143 rep_tid=3D256248 wfack=3D wfdisk=3D op=3Dosd_op(mds0.1:334034
>> 200.000002a6 [write 702932~3164] 1.a9f0) v2) 0x30140540
>> 2011-06-11 06:04:02.963002 7f19f221c710 osd1 4 pg[1.70( v 4'3144
>> (4'3142,4'3144] n=3D385 ec=3D2 les/c 4/4 3/3/3) [1,0] r=3D0 mlcod 4'=
3142
>> !hml active+clean]  sending commit on repgather(0x281df4b0 applied
>> 4'3144 rep_tid=3D256249 wfack=3D wfdisk=3D op=3Dosd_op(mds0.1:334037
>> 200.000002a6 [write 706096~1232] 1.a9f0) v2) 0x30140380
>> 2011-06-11 06:04:09.489288 7f19f2a1d710 osd1 4 pg[1.70( v 4'3145
>> (4'3143,4'3145] n=3D385 ec=3D2 les/c 4/4 3/3/3) [1,0] r=3D0 mlcod 4'=
3143
>> !hml active+clean]  sending commit on repgather(0x281df5a0 applied
>> 4'3145 rep_tid=3D256250 wfack=3D wfdisk=3D op=3Dosd_op(mds0.1:334039
>> 200.000002a6 [write 707328~1196] 1.a9f0) v2) 0x30140700
>> 2011-06-11 06:19:34.799410 7f19eea0e710 -- 192.168.0.209:6801/31773 =
>>
>> 192.168.0.208:6801/26514 pipe(0x1281280 sd=3D13 pgs=3D6 cs=3D7 l=3D0=
).fault
>> with nothing to send, going to standby
>>
>> [root@ceph_osd0 ~]# tail /var/log/ceph/osd.0.log -f
>> 2011-06-11 12:26:05.366366 7fbfe3ae8710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x3eebc60
>> 2011-06-11 12:39:55.959237 7fbfe08e0710 -- 192.168.0.208:6801/26514 =
>>
>> 192.168.0.209:6801/31773 pipe(0x2de2280 sd=3D13 pgs=3D3 cs=3D5 l=3D0=
).fault
>> with nothing to send, going to standby
>> 2011-06-11 18:00:28.570888 7fbfdd7d2710 -- 192.168.0.208:6801/26514 =
>>
>> 192.168.0.209:6801/31773 pipe(0x2769780 sd=3D14 pgs=3D0 cs=3D0 l=3D0=
).accept
>> connect_seq 6 vs existing 6 state 6
>> 2011-06-11 18:00:29.140549 7fbfe7af0710 osd0 4 pg[1.14( v 4'4797
>> (4'4795,4'4797] n=3D416 ec=3D2 les/c 4/4 3/3/2) [0,1] r=3D0 mlcod 4'=
4795
>> !hml active+clean]  sending commit on repgather(0x2107d4b0 applied
>> 4'4797 rep_tid=3D315438 wfack=3D wfdisk=3D op=3Dosd_op(mds0.1:334035
>> 200.00000000 [writefull 0~84] 1.3494) v2) 0x1d347000
>> 2011-06-11 18:01:23.652245 7fbfe07df710 osd0 4 pg[1.14( v 4'4798
>> (4'4796,4'4798] n=3D416 ec=3D2 les/c 4/4 3/3/2) [0,1] r=3D0 mlcod 4'=
4796
>> !hml active+clean]  sending commit on repgather(0x2107d3c0 applied
>> 4'4798 rep_tid=3D315439 wfack=3D wfdisk=3D op=3Dosd_op(mds0.1:334038
>> 200.00000000 [writefull 0~84] 1.3494) v2) 0x21659700
>> 2011-06-11 18:01:55.254019 7fbfe08e0710 -- 192.168.0.208:6800/26514 =
>>
>> 192.168.0.210:0/605992965 pipe(0xcf9d000 sd=3D13 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/605992965 (socket is
>> 192.168.0.210:39797/0)
>> 2011-06-11 18:01:55.378638 7fbfe07df710 osd0 4 pg[0.60( v 4'1853
>> (4'1851,4'1853] n=3D1853 ec=3D2 les/c 4/4 3/3/2) [0,1] r=3D0 mlcod 4=
'1851
>> !hml active+clean]  sending commit on repgather(0x2107d3c0 applied
>> 4'1853 rep_tid=3D315440 wfack=3D wfdisk=3D op=3Dosd_op(client4101.1:=
237118
>> 100000474b9.00000000 [write 0~2560 [1@-1]] 0.c60 snapc 1=3D[]))
>> 0x1df74c40
>> 2011-06-11 18:03:05.460675 7fbfe3ae8710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-11 18:03
>>
>> And unable to carry out writing data, such as: time dd if=3D/dev/zer=
o
>> bs=3D5 count=3D512 of=3Dfile
>>
>>
>> My operating system is redhat6.0 kernel 2.6.38.6 x86_64
>> 4 a home computer
>>
>>
>> If you can give me some Suggestions? thank you
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
