From: Janne Grunau <j@jannau.net>
Subject: Re: v2 aligned buffer changes for erasure codes
Date: Thu, 18 Sep 2014 15:23:55 +0200
Message-ID: <20140918132355.GD25730@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411036435-18860-1-git-send-email-j@jannau.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE7D1265@CERNXCHG44.cern.ch>
 <20140918124039.GB25730@jannau.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE7D1488@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:45312 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755AbaIRNX6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 09:23:58 -0400
Content-Disposition: inline
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7D1488@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 2014-09-18 13:01:03 +0000, Andreas Joachim Peters wrote:
> 
> >> For encoding there is normally a single buffer split 'virtually' 
> >> into
> >> k pieces. To make all pieces starting at an aligned address one 
> >> needs
> >> to align the chunk size to e.g. 16*k.
> 
> >I don't get that. How is the buffer splitted? into k (+ m) chunk size
> >parts? As long as the start and the length are both 16 (or 32) byte
> >aligned all parts are properly aligned too. I don't see where the k
> >comes into play.
> 
> The original data block to encode has to be split into k equally long 
> pieces. Each piece is given as one of the k input buffers to the 
> erasure code algorithm producing m output buffers and each piece has 
> to have an aligned starting address and length.
> 
> If you deal with 128 byte data input buffers for k=4 it splits like
> 
> offset=00 len=32 as chunk1
> offset=32 len=32 as chunk2
> offset=64 len=32 as chunk3
> offset=96 len=32 as chunk4
> 
> If the desired IO size would be 196 bytes the 32 byte alignment 
> requirement blows this buffer up to 256 bytes:
> 
> offset=00 len=64 as chunk1
> offset=64 len=64 as chunk2
> offset=128 len=64 as chunk3
> offset=196 len=64 as chunk4

I fail to see how the 32 * k is related to alignment. It's only used for 
to pad the total size so it becomes a mulitple of k * 32. That is ok 
since we want k 32-byte aligned chunks. The alignment for each chunk is 
just 32-bytes.

Janne
