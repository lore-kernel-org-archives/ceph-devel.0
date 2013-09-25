From: Sage Weil <sage@inktank.com>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Wed, 25 Sep 2013 11:53:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309251151500.12714@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>, <523FED54.8040208@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch>, <5242FDDC.3060504@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch>
 <52433014.3030109@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57714 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3IYSxm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Sep 2013 14:53:42 -0400
In-Reply-To: <52433014.3030109@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 25 Sep 2013, Loic Dachary wrote:
> 
> 
> On 25/09/2013 20:33, Andreas Joachim Peters wrote:> Yes, sure. I actually thought the same in the meanwhile ...  I have some questions:
> > 
> > Q: Can/should it stay in the framework of google test's or you would prefer just a plain executable ?
> > 
> 
> A plain executable would make sense. An simple example from src/test/Makefile.am :
> 
> ceph_test_trans_SOURCES = test/test_trans.cc
> ceph_test_trans_LDADD = $(LIBOS) $(CEPH_GLOBAL)
> bin_DEBUGPROGRAMS += ceph_test_trans

FWIW there are a few tools that use gtest that aren't strictly unit tests 
(ceph_test_rados_api_*, for example) just because the framework is 
convenient.  

There are also a few things that do simple, low-cost benchmarks that are 
run as unit tests (e.g., unittest_crc32c).  I think it just depends on how 
expensive the tests you're considering are.

sage


> 
> 
> > I have added local parity support to your erasure class adding a new argument: "erasure-code-lp" and
> > two new methods:
> > 
> > localparity_encode(...)
> > localparity_decode(...)
> > 
> > I made a more complex benchmark of (8,2) + 2 local parities (1^2^3^4, 5^6^7^8) which benchmarks performance of encoding/decoding as speed & effective write-latency for three cases (each for liberation & cauchy_good codecs):
> > 
> > 1 (8,2)
> > 2 (8,2,lp=2)
> > 3 (8,2,lp=2) + crc32c (blocks)
> > 
> > and several failure scenarios ... single, double, triple disk failures. Probably the best is if I make all this parameters configurable. 
> 
> Great :-) Do you have a public git repository where I could clone this & give it a try ?
> 
> > Q: For the local parity implementation .... shall I inherit from your erasure plugin and overwrite the encode/decode method or you would consider a patch to the original class?
> 
> It is a perfect timing for a patch to the original class.
> 
> > I have also a 128-bit XOR implementation for the local parities. This will work with new gcc's & clang compilers ... 
> > 
> > Q: Which compilers/platforms are supported by CEPH? Is there a minimal GCC version?
> 
> You can see all supported platforms here:
> 
> http://ceph.com/gitbuilder.cgi
> 
> I don't think the GCC version shows in the logs but you can probably figure it out from the corresponding distribution. 
> 
> > Q: is there some policy restricting comments within code? In general I see very few or no comments within the code ..
> 
> :-) The mon code tends to be more heavily commented than the osd code (IMO) but I'm not aware of any policy. When I feel the need to comment, I write a unit test. If the unit test is difficult, I tend to comment to clarify its purpose. The problem with comments is that they quickly become obsolete and/or misleading. That being said, I don't think anyone will object if you heavily comment your code.
> 
> Cheers
> 
> > Cheers Andreas.
> > 
> > 
> > 
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do nothing.
> 
> 
