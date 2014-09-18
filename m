From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: v2 aligned buffer changes for erasure codes
Date: Thu, 18 Sep 2014 13:01:03 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7D1488@CERNXCHG44.cern.ch>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411036435-18860-1-git-send-email-j@jannau.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE7D1265@CERNXCHG44.cern.ch>,<20140918124039.GB25730@jannau.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:48926 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbaIRNBG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 09:01:06 -0400
In-Reply-To: <20140918124039.GB25730@jannau.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Janne, 

>> For encoding there is normally a single buffer split 'virtually' into
>> k pieces. To make all pieces starting at an aligned address one needs
>> to align the chunk size to e.g. 16*k.

>I don't get that. How is the buffer splitted? into k (+ m) chunk size
>parts? As long as the start and the length are both 16 (or 32) byte
>aligned all parts are properly aligned too. I don't see where the k
>comes into play.

The original data block to encode has to be split into k equally long pieces. Each piece is given as one of the k input buffers to the erasure code algorithm producing m output buffers and each piece has to have an aligned starting address and length.

If you deal with 128 byte data input buffers for k=4 it splits like

offset=00 len=32 as chunk1
offset=32 len=32 as chunk2
offset=64 len=32 as chunk3
offset=96 len=32 as chunk4

If the desired IO size would be 196 bytes the 32 byte alignment requirement blows this buffer up to 256 bytes:

offset=00 len=64 as chunk1
offset=64 len=64 as chunk2
offset=128 len=64 as chunk3
offset=196 len=64 as chunk4

For the typical 4kb only k=2,4,8,16,32,64,128 do not increase the buffer. If someone configures e.g. k=10 the buffer is increased from 4096 to 4160 bytes and it creates 1.5% storage volume overhead.

Cheers Andreas.




________________________________________
From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Janne Grunau [j@jannau.net]
Sent: 18 September 2014 14:40
To: Andreas Joachim Peters
Cc: ceph-devel@vger.kernel.org
Subject: Re: v2 aligned buffer changes for erasure codes

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
