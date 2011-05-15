From: Simon Tian <aixt2006@gmail.com>
Subject: Re: How to enable the debug symbols
Date: Sun, 15 May 2011 20:37:16 +0800
Message-ID: <BANLkTikCB1gAL-WPGv1u8AZk_OjD4TLgyA@mail.gmail.com>
References: <BANLkTi=aKfr4ZpqsnhCpzREin8c5Y_sbpg@mail.gmail.com>
	<10709e0d5db695dae3ba2d07c2fe73ff.squirrel@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64354 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab1EOMhS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 May 2011 08:37:18 -0400
Received: by wya21 with SMTP id 21so2833265wya.19
        for <ceph-devel@vger.kernel.org>; Sun, 15 May 2011 05:37:16 -0700 (PDT)
In-Reply-To: <10709e0d5db695dae3ba2d07c2fe73ff.squirrel@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 8SScqsnYX8tr@dyweni.com
Cc: ceph-devel@vger.kernel.org

Hi Dyweni,

     Can I do this by any options of =E2=80=9C./configure=E2=80=9D?   o=
r JUST modify
the Makefile manually?

Thx!
Simon


2011/5/15 Dyweni - Qemu-Devel <8SScqsnYX8tr@dyweni.com>:
> Hi Simon!
>
> You will need to add the '-ggdb' flag when compiling Ceph. =C2=A0Also=
, you will
> need to remove all optimizations flags (i.e. -O*).
>
> Thanks,
> Dyweni
>
>
>> Hi folks,
>>
>> When I want to trace the stack of ceph in gdb, I set a breakpoint at
>> Objecter::send_op(Op *op), =C2=A0some of the stack can't be showed. =
=C2=A0It
>> just came out with "??"
>> Hmm, =C2=A0How can I see the content of those "??"......
>>
>> (gdb)b Objecter.cc:635
>> ... ...
>> (gdb) bt
>> #0 =C2=A00x00007ff2d4190d60 in ?? () from /usr/local/lib/librados.so=
=2E2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^=
^^^
>> #1 =C2=A00x00007ff2d4193c4b in ?? () from /usr/local/lib/librados.so=
=2E2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^=
^^^
>> #2 =C2=A00x00007ff2d4157d9e in librados::RadosClient::write (this=3D=
<value
>> optimized out>, io=3D@0x7ff2cc0030a0, oid=3D@0x7fff237d97d0,
>> bl=3D@0x7fff237d9840, len=3D512,
>> =C2=A0 =C2=A0 off=3D3072) at osdc/Objecter.h:805
>> #3 =C2=A00x00007ff2d41580fa in librados::IoCtx::write (this=3D0x7ff2=
cc0028f0,
>> oid=3D<value optimized out>, bl=3D@0x7fff237d9840, len=3D512, off=3D=
3072) at
>> librados.cc:2278
>> #4 =C2=A00x00007ff2d44e1ca8 in librbd::write (ictx=3D0x7ff2cc002800,
>> off=3D3072, len=3D<value optimized out>,
>> =C2=A0 =C2=A0 buf=3D0x7fff237d9980
>> "KHVvrQTdx;I>mJ(9S\"&M6+KBac1E6<Q^a)WUW-;RGcm5-tM`sP/*XWK<:Z^Ou1.X9d=
-ppGB8*1L7(vvzH%&#ZO<s+yC\"*PWB4c2&,S;3dfIi\\?e'Bi'y:@nD91CB^yaq^swgF4y=
*xErVaZZ%C^}\\{l}6|BU]=3D9Px,GaOY\\YS!M)b)adIAb%?P$RLC*)]@YWI}:wVtR+t".=
=2E.)
>> at librbd.cc:1191
>> #5 =C2=A00x0000000000401e95 in write_test_data (image=3D0x7ff2cc0028=
00,
>> =C2=A0 =C2=A0 test_data=3D0x7fff237d9980
>> "KHVvrQTdx;I>mJ(9S\"&M6+KBac1E6<Q^a)WUW-;RGcm5-tM`sP/*XWK<:Z^Ou1.X9d=
-ppGB8*1L7(vvzH%&#ZO<s+yC\"*PWB4c2&,S;3dfIi\\?e'Bi'y:@nD91CB^yaq^swgF4y=
*xErVaZZ%C^}\\{l}6|BU]=3D9Px,GaOY\\YS!M)b)adIAb%?P$RLC*)]@YWI}:wVtR+t".=
=2E.,
>> off=3D3072, len=3D512) at testlibrbd.c:189
>> #6 =C2=A00x00000000004021bc in test_io (io=3D0x606b20, image=3D0x7ff=
2cc002800)
>> at testlibrbd.c:250
>> #7 =C2=A00x0000000000402e2b in main (argc=3D1, argv=3D0x7fff237d9cd8=
) at
>> testlibrbd.c:415
>>
>>
>> Thx!
>> Simon
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
