From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: v2 aligned buffer changes for erasure codes
Date: Thu, 18 Sep 2014 12:18:59 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7D1265@CERNXCHG44.cern.ch>
References: <1410796508-28711-1-git-send-email-j@jannau.net>,<1411036435-18860-1-git-send-email-j@jannau.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:35918 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaIRMTB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 08:19:01 -0400
In-Reply-To: <1411036435-18860-1-git-send-email-j@jannau.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Janne, 
=> (src/erasure-code/isa/README claims it needs 16*k byte aligned buffers

I should update the README since it is misleading ... it should say 8*k or 16*k byte aligned chunk size depending on the compiler/platform used, it is not the alignment of the allocated buffer addresses.The get_alignment in the plug-in function is used to compute the chunk size for the encoding (as I said not the start address alignment). 

If you pass k buffers for decoding each buffer should be aligned at least to 16 or as you pointed out better 32 bytes. 

For encoding there is normally a single buffer split 'virtually' into k pieces. To make all pieces starting at an aligned address one needs to align the chunk size to e.g. 16*k. For the best possible performance on all platforms we should change the get_alignment function in the ISA plug-in to return 32*k if there are no other objections ?!?!
 
Cheers Andreas.
________________________________________
From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Janne Grunau [j@jannau.net]
Sent: 18 September 2014 12:33
To: ceph-devel@vger.kernel.org
Subject: v2 aligned buffer changes for erasure codes

Hi,

following a is an updated patchset. It passes now make check in src

It has following changes:
 * use 32-byte alignment since the isa plugin use AVX2
   (src/erasure-code/isa/README claims it needs 16*k byte aligned buffers
   but I can't see a reason why it would need more than 32-bytes
 * ErasureCode::encode_prepare() handles more than one chunk with padding

cheers

Janne
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
