From: Sage Weil <sweil@redhat.com>
Subject: RE: Pull Request for ISA EC plug-in
Date: Wed, 30 Jul 2014 10:46:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407301044510.4962@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7509E3@CERNXCHG44.cern.ch>, <alpine.DEB.2.00.1407281520470.4962@cobra.newdream.net> <3472A07E6605974CBC9BC573F1BC02E4AE750C17@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59085 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813AbaG3RqF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 13:46:05 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE750C17@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 28 Jul 2014, Andreas Joachim Peters wrote:
> Hi Sage, 
> 
> I fixed that. I missed '$(srcdir)' in the assembler  and C/C++ include statements (I always compiled in src dir ..)
> 
> You can retry.

I think there are still a few issues:

make[4]: *** [erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_base.lo] Error 1
make[4]: *** Waiting for unfinished jobs....
./yasm-wrapper: yasm -f elf64 -i ./erasure-code/isa/isa-l/include/ erasure-code/isa/isa-l/erasure_code/ec_multibinary.asm.s -o erasure-code/isa/isa-l/erasure_code/.libs/libec_isa_la-ec_multibinary.asm.o
FATAL: yasm: unable to open include file `reg_sizes.asm'
./yasm-wrapper: yasm -f elf64 -i ./erasure-code/isa/isa-l/include/ erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s -o erasure-code/isa/isa-l/erasure_code/.libs/libec_isa_la-gf_2vect_dot_prod_avx2.asm.o
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:157: undefined symbol `gf_2vect_dot_prod_avx2.return_fail' (first use)
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:157: (Each undefined symbol is reported only once.)
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:161: instruction expected after label
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:178: instruction expected after label
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:179: instruction expected after label
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:183: instruction expected after label
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:184: instruction expected after label
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:206: undefined symbol `vperm2i128.next_vect' (first use)
error: erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:213: undefined symbol `vperm2i128.loop32' (first use)
make[4]: *** [erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_multibinary.asm.lo] Error 1
make[4]: *** [erasure-code/isa/isa-l/erasure_code/libec_isa_la-gf_2vect_dot_prod_avx2.asm.lo] Error 1
./yasm-wrapper: yasm -f elf64 -i ./erasure-code/isa/isa-l/include/ erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx.asm.s -o erasure-code/isa/isa-l/erasure_code/.libs/libec_isa_la-gf_2vect_dot_prod_avx.asm.o
In file included from erasure-code/isa/isa-l/erasure_code/ec_highlevel_func.c:30:0:
./erasure-code/isa/isa-l/include/erasure_code.h:52:25: fatal error: gf_vect_mul.h: No such file or directory
compilation terminated.

This is from 
http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-basic/log.cgi?log=c7e765e22427958c0d03fbfec42a29aa34895ef3.

Thanks!
sage




> 
> Thanks Andreas.
> 
> ________________________________________
> From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Sage Weil [sweil@redhat.com]
> Sent: 29 July 2014 00:22
> To: Andreas Joachim Peters
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Pull Request for ISA EC plug-in
> 
> Hi Andreas!
> 
> On Mon, 28 Jul 2014, Andreas Joachim Peters wrote:
> > Hi all,
> >
> > here is a PULL request for the ISA EC plugin rebased against master of
> > today for review.
> >
> > https://github.com/ceph/ceph/pull/2155
> >
> > I have added as discussed the exhaustive test of all possible failures
> > scenarios for both supported matrix types for a (k=12,m=4) configuration
> > to the unit tests ( which helped indeed to spot a bug in the table
> > caching )
> 
> I tried to push this through the build system and it looks like perhaps
> some files are missing from the commit?
> 
> CC erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_highlevel_func.lo
> In file included from erasure-code/isa/isa-l/erasure_code/ec_base.c:32:0:
> erasure-code/isa/isa-l/include/erasure_code.h:52:25: fatal error: gf_vect_mul.h: No such file or directory
> compilation terminated.
> CCAS erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_multibinary.asm.lo
> CCAS erasure-code/isa/isa-l/erasure_code/libec_isa_la-gf_2vect_dot_prod_avx2.asm.lo
> In file included from erasure-code/isa/isa-l/erasure_code/ec_highlevel_func.c:30:0:
> erasure-code/isa/isa-l/include/erasure_code.h:52:25: fatal error: gf_vect_mul.h: No such file or directory
> compilation terminated.
> 
> and
> 
> FATAL: yasm: unable to open include file `reg_sizes.asm'
> 
> See
>  http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-wheezy-amd64-basic/log.cgi?log=60408e6c6b3b34d719943d16fcc023407e08ae01
> 
> Hopefully these are just sitting in your working directory?
> 
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
