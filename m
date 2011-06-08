From: biyan chen <riby.chen@gmail.com>
Subject: Re: libceph: osd0 down
Date: Wed, 8 Jun 2011 14:00:39 +0800
Message-ID: <BANLkTi=hV7T-P+FVpsF-iP+jkwoyi1A7uw@mail.gmail.com>
References: <BANLkTim6cJxoxqXJaRhoca5HSmuad6p2SQ@mail.gmail.com>
	<1307512144.9098.4.camel@cephclient0>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53982 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab1FHGAk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2011 02:00:40 -0400
Received: by ywe9 with SMTP id 9so60038ywe.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2011 23:00:39 -0700 (PDT)
In-Reply-To: <1307512144.9098.4.camel@cephclient0>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well, thank you =A3=A1



2011/6/8 Jeff Wu <cpwu@tnsoft.com.cn>:
>
> Hi=A3=AC
>
> If you detected a bug ,you can register a user account at
>
> http://tracker.newdream.net/projects/ceph
>
> and list the detail platform infos and the detail reproducing steps ,
> then file the bug at the bug tracker.
>
> Regards,
> Jeff ,Wu
>
>
>
> On Wed, 2011-06-08 at 13:16 +0800, biyan chen wrote:
>> command :time dd if=3D/dev/zero bs=3D5k count=3D512 of=3Dfile
>>
>> [root@ceph_osd0 ~]# tail /var/log/ceph/osd.0.log -f
>> 2011-06-08 20:53:26.541053 7f57c7cee710 log [INF] : 0.3d scrub ok
>> 2011-06-08 20:53:27.541216 7f57c7cee710 log [INF] : 0.3e scrub ok
>> 2011-06-08 20:53:29.541794 7f57c7cee710 log [INF] : 0.41 scrub ok
>> 2011-06-08 20:53:31.541977 7f57c7cee710 log [INF] : 0.42 scrub ok
>> 2011-06-08 20:54:22.169841 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 20:54:22.169898 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x3701120
>> 2011-06-08 20:54:22.170133 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x255fa00 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:59462/0)
>> 2011-06-08 20:55:22.272944 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 20:55:22.272995 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x3701240
>> 2011-06-08 20:55:22.273295 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x255f780 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:59464/0)
>>
>> 2011-06-08 20:56:22.375928 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 20:56:22.375999 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x3701360
>> 2011-06-08 20:56:22.376256 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x362a500 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:52424/0)
>> 2011-06-08 20:57:22.478977 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 20:57:22.479043 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x3701480
>> 2011-06-08 20:57:22.479343 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x362a280 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:52425/0)
>> 2011-06-08 20:58:22.582096 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 20:58:22.582161 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x37015a0
>> 2011-06-08 20:58:22.582407 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x255fa00 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:52426/0)
>> 2011-06-08 20:59:22.685227 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 20:59:22.685295 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x37016c0
>> 2011-06-08 20:59:22.685597 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x255f780 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:52427/0)
>> 2011-06-08 21:00:22.788255 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 21:00:22.788330 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x37017e0
>> 2011-06-08 21:00:22.788575 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x362a780 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:52428/0)
>> 2011-06-08 21:01:22.891341 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 21:01:22.891401 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x3701900
>> 2011-06-08 21:01:22.891638 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x362a500 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:35491/0)
>> 2011-06-08 21:02:22.994417 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 21:02:22.994472 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x3701a20
>> 2011-06-08 21:02:22.994721 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x362a280 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:35492/0)
>> 2011-06-08 21:03:23.097481 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> 2011-06-08 21:03:23.097541 7f57cbbf7710 osd0 4 OSD::ms_handle_reset(=
)
>> s=3D0x3701b40
>> 2011-06-08 21:03:23.097794 7f57c45e4710 -- 192.168.0.208:6800/2373 >=
>
>> 192.168.0.210:0/1260740138 pipe(0x255fa00 sd=3D16 pgs=3D0 cs=3D0 l=3D=
0).accept
>> peer addr is really 192.168.0.210:0/1260740138 (socket is
>> 192.168.0.210:35493/0)
>> 2011-06-08 21:03:24.460849 7f57cc5f8710 FileStore: sync_entry timed
>> out after 600 seconds.
>>  ceph version 0.28.2 (commit:23242045db6b0ec87400441acbe0ea14eedbe6c=
c)
>> 2011-06-08 21:03:24.460919 1: (SafeTimer::timer_thread()+0x35e) [0x6=
1bbbe]
>> 2011-06-08 21:03:24.460936 2: (SafeTimerThread::entry()+0xd) [0x61e7=
6d]
>> 2011-06-08 21:03:24.460947 3: /lib64/libpthread.so.0() [0x3f724077e1=
]
>> 2011-06-08 21:03:24.460960 4: (clone()+0x6d) [0x3f718e153d]
>> 2011-06-08 21:03:24.460971 *** Caught signal (Aborted) **
>>  in thread 0x7f57cc5f8710
>>  ceph version 0.28.2 (commit:23242045db6b0ec87400441acbe0ea14eedbe6c=
c)
>>  1: /usr/local/bin/cosd() [0x639d12]
>>  2: /lib64/libpthread.so.0() [0x3f7240f4c0]
>>  3: (gsignal()+0x35) [0x3f718329a5]
>>  4: (abort()+0x175) [0x3f71834185]
>>  5: (__assert_fail()+0xf5) [0x3f7182b935]
>>  6: (SyncEntryTimeout::finish(int)+0xf4) [0x5c2454]
>>  7: (SafeTimer::timer_thread()+0x35e) [0x61bbbe]
>>  8: (SafeTimerThread::entry()+0xd) [0x61e76d]
>>  9: /lib64/libpthread.so.0() [0x3f724077e1]
>>  10: (clone()+0x6d) [0x3f718e153d]
>>
>>
>> Why did the osd dead?,
>> Thanks all!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
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
