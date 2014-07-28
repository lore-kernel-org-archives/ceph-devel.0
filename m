From: Sage Weil <sweil@redhat.com>
Subject: Re: Pull Request for ISA EC plug-in
Date: Mon, 28 Jul 2014 15:22:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407281520470.4962@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7509E3@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45255 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbaG1WWl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 18:22:41 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7509E3@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

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
