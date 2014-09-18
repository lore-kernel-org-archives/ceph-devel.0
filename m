From: Janne Grunau <j@jannau.net>
Subject: Re: v2 aligned buffer changes for erasure codes
Date: Thu, 18 Sep 2014 14:40:39 +0200
Message-ID: <20140918124039.GB25730@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411036435-18860-1-git-send-email-j@jannau.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE7D1265@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:45213 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbaIRMkk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 08:40:40 -0400
Content-Disposition: inline
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7D1265@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 2014-09-18 12:18:59 +0000, Andreas Joachim Peters wrote:
> 
> => (src/erasure-code/isa/README claims it needs 16*k byte aligned buffers
> 
> I should update the README since it is misleading ... it should say 
> 8*k or 16*k byte aligned chunk size depending on the compiler/platform 
> used, it is not the alignment of the allocated buffer addresses.The 
> get_alignment in the plug-in function is used to compute the chunk 
> size for the encoding (as I said not the start address alignment). 

I've seen that

> If you pass k buffers for decoding each buffer should be aligned at 
> least to 16 or as you pointed out better 32 bytes. 

ok, that makes sense

> For encoding there is normally a single buffer split 'virtually' into 
> k pieces. To make all pieces starting at an aligned address one needs 
> to align the chunk size to e.g. 16*k.

I don't get that. How is the buffer splitted? into k (+ m) chunk size 
parts? As long as the start and the length are both 16 (or 32) byte 
aligned all parts are properly aligned too. I don't see where the k 
comes into play.

cheers

Janne
