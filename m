From: "Dyweni - Qemu-Devel" <8SScqsnYX8tr@dyweni.com>
Subject: Re: How to enable the debug symbols
Date: Sun, 15 May 2011 07:24:25 -0500 (CDT)
Message-ID: <10709e0d5db695dae3ba2d07c2fe73ff.squirrel@pl1.haspere.com>
References: <BANLkTi=aKfr4ZpqsnhCpzREin8c5Y_sbpg@mail.gmail.com>
Reply-To: 8SScqsnYX8tr@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:49507 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130Ab1EOMY0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 15 May 2011 08:24:26 -0400
In-Reply-To: <BANLkTi=aKfr4ZpqsnhCpzREin8c5Y_sbpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Simon!

You will need to add the '-ggdb' flag when compiling Ceph.  Also, you will
need to remove all optimizations flags (i.e. -O*).

Thanks,
Dyweni


> Hi folks,
>
> When I want to trace the stack of ceph in gdb, I set a breakpoint at
> Objecter::send_op(Op *op),  some of the stack can't be showed.  It
> just came out with "??"
> Hmm,  How can I see the content of those "??"......
>
> (gdb)b Objecter.cc:635
> ... ...
> (gdb) bt
> #0  0x00007ff2d4190d60 in ?? () from /usr/local/lib/librados.so.2
>                                        ^^^^
> #1  0x00007ff2d4193c4b in ?? () from /usr/local/lib/librados.so.2
>                                        ^^^^
> #2  0x00007ff2d4157d9e in librados::RadosClient::write (this=<value
> optimized out>, io=@0x7ff2cc0030a0, oid=@0x7fff237d97d0,
> bl=@0x7fff237d9840, len=512,
>     off=3072) at osdc/Objecter.h:805
> #3  0x00007ff2d41580fa in librados::IoCtx::write (this=0x7ff2cc0028f0,
> oid=<value optimized out>, bl=@0x7fff237d9840, len=512, off=3072) at
> librados.cc:2278
> #4  0x00007ff2d44e1ca8 in librbd::write (ictx=0x7ff2cc002800,
> off=3072, len=<value optimized out>,
>     buf=0x7fff237d9980
> "KHVvrQTdx;I>mJ(9S\"&M6+KBac1E6<Q^a)WUW-;RGcm5-tM`sP/*XWK<:Z^Ou1.X9d-ppGB8*1L7(vvzH%&#ZO<s+yC\"*PWB4c2&,S;3dfIi\\?e'Bi'y:@nD91CB^yaq^swgF4y*xErVaZZ%C^}\\{l}6|BU]=9Px,GaOY\\YS!M)b)adIAb%?P$RLC*)]@YWI}:wVtR+t"...)
> at librbd.cc:1191
> #5  0x0000000000401e95 in write_test_data (image=0x7ff2cc002800,
>     test_data=0x7fff237d9980
> "KHVvrQTdx;I>mJ(9S\"&M6+KBac1E6<Q^a)WUW-;RGcm5-tM`sP/*XWK<:Z^Ou1.X9d-ppGB8*1L7(vvzH%&#ZO<s+yC\"*PWB4c2&,S;3dfIi\\?e'Bi'y:@nD91CB^yaq^swgF4y*xErVaZZ%C^}\\{l}6|BU]=9Px,GaOY\\YS!M)b)adIAb%?P$RLC*)]@YWI}:wVtR+t"...,
> off=3072, len=512) at testlibrbd.c:189
> #6  0x00000000004021bc in test_io (io=0x606b20, image=0x7ff2cc002800)
> at testlibrbd.c:250
> #7  0x0000000000402e2b in main (argc=1, argv=0x7fff237d9cd8) at
> testlibrbd.c:415
>
>
> Thx!
> Simon
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


