From: Janne Grunau <j@jannau.net>
Subject: ARM NEON optimisations for gf-complete/jerasure/ceph-erasure
Date: Thu, 4 Sep 2014 16:42:37 +0200
Message-ID: <20140904144237.GK2591@jannau.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:38003 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIDOwW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Sep 2014 10:52:22 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've started writing ARM/AArch64 NEON optimizations for gf-complete.  
http://git.jannau.net/gf-complete.git/log/?h=neon has proof of concept 
AArch64 NEON optimisations for w8.

Implemented methods are so far the carry-less/polynomial multiplication 
and the split table. The polynomial multiplication is reasonable fast 
for region multiplications (~2000MB/s on an Apple A7 at 1.3GHz) since 
NEON has a 8-bit to 16-bit SIMD polynomial multiplication.

The split table method is still faster though, 5700MB/s on the same CPU.  
I'm actually surprised by that since it is faster (per cycle) than the 
Core i7-3770 from gf-complete's manual (page 14). That suggests that 
SSE3 code might not be optimal.

I'm currently working on integrating NEON into the build system and then 
will extend the existing code to work on ARMv7-a too. Those two are 
straight forward. There are a couple of other issues I would like to 
discuss before I start to work on them.

The #if/#ifdefs in the source are starting to make the source hard to 
read then more than one optimization is added. Separating arch specific
implementations from each other and from the generic implementation 
works reasonable well for the multimedia related projects I have 
experience with (libav/FFmpeg, x264). There would be arch specific init 
functions which set the appropriate function pointers. The neon 
optimisations would then live in w8_arm.c which would be only compiled 
for arm. If someone has another idea how to avoid the #ifdefs I'm open 
for that too.

I'm currently using the SSE/NOSSE region option which is bogus. I'm 
wondering whether I should just rename that SIMD/NOSIMD (not really true 
since the carry less operations for w64 and w128 only use the SIMD 
instruction set but are single data). That would need to have backward 
compatibility for SSE/NOSSE. The other option would be to add 
NEON/NONEON flags.

I'm sure I find other issues to discuss when I start integrating the 
NEON optimisations into jerasure and ceph.

thanks

Janne
