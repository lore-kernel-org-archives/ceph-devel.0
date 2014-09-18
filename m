From: Janne Grunau <j@jannau.net>
Subject: Re: v2 aligned buffer changes for erasure codes
Date: Thu, 18 Sep 2014 14:53:05 +0200
Message-ID: <20140918125305.GC25730@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411036435-18860-1-git-send-email-j@jannau.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE7D1265@CERNXCHG44.cern.ch>
 <3472A07E6605974CBC9BC573F1BC02E4AE7D13BB@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:45232 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296AbaIRMxH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 08:53:07 -0400
Content-Disposition: inline
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7D13BB@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 2014-09-18 12:34:49 +0000, Andreas Joachim Peters wrote:
>
> there is more confusion atleast on my side ...
> 
> I had now a look at the jerasure plug-in and I am now slightly 
> confused why you have two ways to return in get_alignment ... one is 
> as I assume and another one is "per_chunk_alignment" ... what should 
> the function return Loic?

the per_chunk_alignment is just a bool which says that each chunk has to
start at an aligned address.

get_alignement() seems to be used to align the chunk size.

It might come from gf-complete' strange alignment requirements. Instead 
of requiring aligned buffers it requires that src and dst buffer have 
the same remainder when divided by 16. The best way to archieve that is 
to align the length to 16 and use a single buffer.

I agree it's convoluted.

Janne
