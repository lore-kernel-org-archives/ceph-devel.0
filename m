From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Pull Request for ISA EC plug-in
Date: Thu, 31 Jul 2014 07:39:02 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE752C7A@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7509E3@CERNXCHG44.cern.ch>,
 <alpine.DEB.2.00.1407281520470.4962@cobra.newdream.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE750C17@CERNXCHG44.cern.ch>,
 <alpine.DEB.2.00.1407301044510.4962@cobra.newdream.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE7529BD@CERNXCHG44.cern.ch>
 <alpine.DEB.2.00.1407301600170.4962@cobra.newdream.net>
 <6AA21C22F0A5DA478922644AD2EC308C8A1810@SHSMSX101.ccr.corp.intel.com>,<alpine.DEB.2.00.1407302226300.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:27618 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178AbaGaHjI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 03:39:08 -0400
In-Reply-To: <alpine.DEB.2.00.1407302226300.18917@cobra.newdream.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok, 
thanks for looking into that.

I am fixing the 'make dist' target and will try to make it work also with yasm 1.1 ...

Will let you know when to retry ...

Andreas.

________________________________________
From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Sage Weil [sweil@redhat.com]
Sent: 31 July 2014 07:27
To: Ma, Jianpeng
Cc: Andreas Joachim Peters; ceph-devel@vger.kernel.org
Subject: RE: Pull Request for ISA EC plug-in

On Thu, 31 Jul 2014, Ma, Jianpeng wrote:
> Hi,
>    At my machine, I also met this bug. But I modify this, it can work.
> diff --git a/src/erasure-code/isa/Makefile.am b/src/erasure-code/isa/Makefile.am
> index eebffea..dee593b 100644
> --- a/src/erasure-code/isa/Makefile.am
> +++ b/src/erasure-code/isa/Makefile.am
> @@ -34,7 +34,7 @@ libec_isa_la_SOURCES = ${isa_sources}
>
>  libec_isa_la_CFLAGS = ${AM_CFLAGS} -I $(srcdir)/erasure-code/isa/isa-l/include/
>  libec_isa_la_CXXFLAGS = ${AM_CXXFLAGS} -I $(srcdir)/erasure-code/isa/isa-l/include/
> -libec_isa_la_CCASFLAGS = ${AM_CCASFLAGS} -I $(srcdir)/erasure-code/isa/isa-l/include/
> +libec_isa_la_CCASFLAGS = ${AM_CCASFLAGS} -i $(srcdir)/erasure-code/isa/isa-l/include
>
>  libec_isa_la_LIBADD = $(LIBCRUSH) $(PTHREAD_LIBS) $(EXTRALIBS)
>  libec_isa_la_LDFLAGS = ${AM_LDFLAGS} -version-info 2:10:0
>
>
> As Andreas said, the different is -I and -i.
> But how to choose? My yasm version is 1.2.0.

Ah, my machine with 1.2 is behaving.  I think it's a combination of that,
and that the files are not all include in the 'make dist' tarball.

sage



>
> Thanks!
>
>
>
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Thursday, July 31, 2014 7:02 AM
> > To: Andreas Joachim Peters
> > Cc: ceph-devel@vger.kernel.org
> > Subject: RE: Pull Request for ISA EC plug-in
> >
> > On Wed, 30 Jul 2014, Andreas Joachim Peters wrote:
> > > Hi Sage,
> > >
> > > my guess it comes from the yasm include option which evt. is
> > > non-standard. Mine documents '-i' and '-I' while I found on the web
> > > that probably only '-I' is the portable one.
> > >
> > > I have changed that, still I can only guess, since I cannot reproduce.
> >
> > Hmm, how are you building it?  Running make on my work box (precise) also
> > fails.  I modified yasm-wrapper slightly[1] and it's gets further, but still no
> > dice...
> >
> > Thanks!
> > sage
> >
> >
> > [1] https://github.com/ceph/ceph/commit/wip-ec-isa
> >
> >
> > >
> > > Please rerun.
> > >
> > > Thanks, Andreas.
> > >
> > > ________________________________________
> > > From: Sage Weil [sweil@redhat.com]
> > > Sent: 30 July 2014 19:46
> > > To: Andreas Joachim Peters
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: RE: Pull Request for ISA EC plug-in
> > >
> > > On Mon, 28 Jul 2014, Andreas Joachim Peters wrote:
> > > > Hi Sage,
> > > >
> > > > I fixed that. I missed '$(srcdir)' in the assembler  and C/C++
> > > > include statements (I always compiled in src dir ..)
> > > >
> > > > You can retry.
> > >
> > > I think there are still a few issues:
> > >
> > > make[4]: ***
> > > [erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_base.lo] Error 1
> > > make[4]: *** Waiting for unfinished jobs....
> > > ./yasm-wrapper: yasm -f elf64 -i ./erasure-code/isa/isa-l/include/
> > > erasure-code/isa/isa-l/erasure_code/ec_multibinary.asm.s -o
> > > erasure-code/isa/isa-l/erasure_code/.libs/libec_isa_la-ec_multibinary.
> > > asm.o
> > > FATAL: yasm: unable to open include file `reg_sizes.asm'
> > > ./yasm-wrapper: yasm -f elf64 -i ./erasure-code/isa/isa-l/include/
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s -o
> > > erasure-code/isa/isa-l/erasure_code/.libs/libec_isa_la-gf_2vect_dot_pr
> > > od_avx2.asm.o
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:157:
> > > undefined symbol `gf_2vect_dot_prod_avx2.return_fail' (first use)
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:157:
> > > (Each undefined symbol is reported only once.)
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:161:
> > > instruction expected after label
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:178:
> > > instruction expected after label
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:179:
> > > instruction expected after label
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:183:
> > > instruction expected after label
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:184:
> > > instruction expected after label
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:206:
> > > undefined symbol `vperm2i128.next_vect' (first use)
> > > error:
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx2.asm.s:213:
> > > undefined symbol `vperm2i128.loop32' (first use)
> > > make[4]: ***
> > > [erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_multibinary.asm.l
> > > o] Error 1
> > > make[4]: ***
> > > [erasure-code/isa/isa-l/erasure_code/libec_isa_la-gf_2vect_dot_prod_av
> > > x2.asm.lo] Error 1
> > > ./yasm-wrapper: yasm -f elf64 -i ./erasure-code/isa/isa-l/include/
> > > erasure-code/isa/isa-l/erasure_code/gf_2vect_dot_prod_avx.asm.s -o
> > > erasure-code/isa/isa-l/erasure_code/.libs/libec_isa_la-gf_2vect_dot_pr
> > > od_avx.asm.o In file included from
> > > erasure-code/isa/isa-l/erasure_code/ec_highlevel_func.c:30:0:
> > > ./erasure-code/isa/isa-l/include/erasure_code.h:52:25: fatal error:
> > > gf_vect_mul.h: No such file or directory compilation terminated.
> > >
> > > This is from
> > >
> > http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-basic/log.
> > cgi?log=c7e765e22427958c0d03fbfec42a29aa34895ef3.
> > >
> > > Thanks!
> > > sage
> > >
> > >
> > >
> > >
> > > >
> > > > Thanks Andreas.
> > > >
> > > > ________________________________________
> > > > From: ceph-devel-owner@vger.kernel.org
> > > > [ceph-devel-owner@vger.kernel.org] on behalf of Sage Weil
> > > > [sweil@redhat.com]
> > > > Sent: 29 July 2014 00:22
> > > > To: Andreas Joachim Peters
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Subject: Re: Pull Request for ISA EC plug-in
> > > >
> > > > Hi Andreas!
> > > >
> > > > On Mon, 28 Jul 2014, Andreas Joachim Peters wrote:
> > > > > Hi all,
> > > > >
> > > > > here is a PULL request for the ISA EC plugin rebased against
> > > > > master of today for review.
> > > > >
> > > > > https://github.com/ceph/ceph/pull/2155
> > > > >
> > > > > I have added as discussed the exhaustive test of all possible
> > > > > failures scenarios for both supported matrix types for a
> > > > > (k=12,m=4) configuration to the unit tests ( which helped indeed
> > > > > to spot a bug in the table caching )
> > > >
> > > > I tried to push this through the build system and it looks like
> > > > perhaps some files are missing from the commit?
> > > >
> > > > CC
> > > > erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_highlevel_func.l
> > > > o In file included from
> > > > erasure-code/isa/isa-l/erasure_code/ec_base.c:32:0:
> > > > erasure-code/isa/isa-l/include/erasure_code.h:52:25: fatal error:
> > > > gf_vect_mul.h: No such file or directory compilation terminated.
> > > > CCAS
> > > > erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_multibinary.asm.
> > > > lo CCAS
> > > > erasure-code/isa/isa-l/erasure_code/libec_isa_la-gf_2vect_dot_prod_a
> > > > vx2.asm.lo In file included from
> > > > erasure-code/isa/isa-l/erasure_code/ec_highlevel_func.c:30:0:
> > > > erasure-code/isa/isa-l/include/erasure_code.h:52:25: fatal error:
> > > > gf_vect_mul.h: No such file or directory compilation terminated.
> > > >
> > > > and
> > > >
> > > > FATAL: yasm: unable to open include file `reg_sizes.asm'
> > > >
> > > > See
> > > >
> > > > http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-wheezy-amd64-ba
> > > > sic/log.cgi?log=60408e6c6b3b34d719943d16fcc023407e08ae01
> > > >
> > > > Hopefully these are just sitting in your working directory?
> > > >
> > > > Thanks!
> > > > sage
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >
> > > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body
> > of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
