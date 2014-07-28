From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Pull Request for ISA EC plug-in
Date: Mon, 28 Jul 2014 22:53:42 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE750C17@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7509E3@CERNXCHG44.cern.ch>,<alpine.DEB.2.00.1407281520470.4962@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:7567 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbaG1Wxr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 18:53:47 -0400
In-Reply-To: <alpine.DEB.2.00.1407281520470.4962@cobra.newdream.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage, 

I fixed that. I missed '$(srcdir)' in the assembler  and C/C++ include statements (I always compiled in src dir ..)

You can retry.

Thanks Andreas.

________________________________________
From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Sage Weil [sweil@redhat.com]
Sent: 29 July 2014 00:22
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: Pull Request for ISA EC plug-in

Hi Andreas!

On Mon, 28 Jul 2014, Andreas Joachim Peters wrote:
> Hi all,
>
> here is a PULL request for the ISA EC plugin rebased against master of
> today for review.
>
> https://github.com/ceph/ceph/pull/2155
>
> I have added as discussed the exhaustive test of all possible failures
> scenarios for both supported matrix types for a (k=12,m=4) configuration
> to the unit tests ( which helped indeed to spot a bug in the table
> caching )

I tried to push this through the build system and it looks like perhaps
some files are missing from the commit?

CC erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_highlevel_func.lo
In file included from erasure-code/isa/isa-l/erasure_code/ec_base.c:32:0:
erasure-code/isa/isa-l/include/erasure_code.h:52:25: fatal error: gf_vect_mul.h: No such file or directory
compilation terminated.
CCAS erasure-code/isa/isa-l/erasure_code/libec_isa_la-ec_multibinary.asm.lo
CCAS erasure-code/isa/isa-l/erasure_code/libec_isa_la-gf_2vect_dot_prod_avx2.asm.lo
In file included from erasure-code/isa/isa-l/erasure_code/ec_highlevel_func.c:30:0:
erasure-code/isa/isa-l/include/erasure_code.h:52:25: fatal error: gf_vect_mul.h: No such file or directory
compilation terminated.

and

FATAL: yasm: unable to open include file `reg_sizes.asm'

See
 http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-wheezy-amd64-basic/log.cgi?log=60408e6c6b3b34d719943d16fcc023407e08ae01

Hopefully these are just sitting in your working directory?

Thanks!
sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
