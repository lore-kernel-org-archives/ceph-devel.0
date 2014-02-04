From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: controlling erasure code chunk size
Date: Tue, 4 Feb 2014 17:01:32 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6C3B0D@CERNXCHG41.cern.ch>
References: <52EE6128.209@dachary.org>
	<3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch>
	<CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>
	<3472A07E6605974CBC9BC573F1BC02E4AE6C12B4@CERNXCHG41.cern.ch>
 <CA+4uBUYROX1gWuBzkUgxTN4Vc2+62BfXq8Ch5FHPQbvKHU8Jsw@mail.gmail.com>,<52F112B3.6050502@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:40480 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbaBDRBj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 12:01:39 -0500
In-Reply-To: <52F112B3.6050502@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,
for the sizeof(int)... the reason is that JERAUSRE internally uses uses=
 long* addresses with operations on them e.g. if you XOR two chunks of =
size 3 you access illegal memory a long* xor's also byte 4.

The PDF documentation says this:

int packetsize: The packet size as defined in section 1. This must be a=
 multiple of sizeof(long).

int size: The total number of bytes per device to encode/decode. This m=
ust be a multiple of sizeof(long). If a
bit-matrix is being employed, then it must be a multiple of packetsize =
* w. If one desires to encode data blocks
that do not conform to these restrictions, than one must pad the data b=
locks with zeroes so that the restrictions
are met.

You cannot just do the modulo adjustment because this breaks the requir=
ement that len is a multiple of packetsize*w  !!!
Imagine w=3D3, packetsize=3D4 .... a module add would adjust it to 16 a=
nd you cannot divide 16 by 12, so the smallest proper adjustment here i=
s 48 ! So the most simple approach is to add just another " * VECTOR_WO=
RD_SIZE" since the condition will be always fulfilled.=20

Cheers Andreas.
________________________________________
=46rom: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.=
org] on behalf of Loic Dachary [loic@dachary.org]
Sent: 04 February 2014 17:17
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Re: controlling erasure code chunk size

Hi Andreas,

> For w=3D(multiple of 8) we could probably skip the (*sizeof(int)) and=
 get the chunksize factor 4 down ... Loic we should check if this is ok=
 with the Jerasure implementation .... I wonder if we should have 'pack=
etsize' as a plugin parameter or we should just adjust the packetsize b=
ased on the desired chunk_size to get it close.

You are correct : the packet size is best adapted to the object size (o=
r stripe size) rather than being set once for all. However Sam wants to=
 use a fixed stripe size and we don't need this flexibility right now.

I don't fully understand the alignment requirements of Jerasure. Since =
we're using Cauchy because it is the fastest, here is how I understand =
its alignment constraints. I copied them from the original encode/decod=
e methods found in jerasure into the get_alignment method whithout unde=
rstanding the details.

* each chunk memory address must be aligned to allow
https://github.com/ceph/ceph/blob/v0.76/src/osd/ErasureCodePluginJerasu=
re/vectorop.h to be used by https://github.com/ceph/ceph/blob/v0.76/src=
/osd/ErasureCodePluginJerasure/galois.c#L748 . This is done without rea=
ding from get_alignment() because each buffer is created with https://g=
ithub.com/ceph/ceph/blob/v0.76/src/common/buffer.cc#L519 buffer::create=
_page_aligned which calls https://github.com/ceph/ceph/blob/v0.76/src/c=
ommon/buffer.cc#L235 posix_memalign with an alignment of CEPH_PAGE_SIZE=
 which is large enough. It is implicit though and it would be better to=
 explicitly set this constraint.

https://github.com/ceph/ceph/blob/v0.76/src/osd/ErasureCodePluginJerasu=
re/ErasureCodeJerasure.cc#L288

* each chunk size must be a multiple of get_alignment() and in the case=
 of the Cauch techniques it means:
** being a multiple of sizeof(int) (why?)
** being a multiple of LARGEST_VECTOR_WORDSIZE (because https://github.=
com/ceph/ceph/blob/v0.76/src/osd/ErasureCodePluginJerasure/galois.c#L74=
8)
** being a multiple of k*w*packetsize (because each chunk contains k pa=
ckets of packets size and each packet is made of words of size w)

I would be grateful if you could explain what the sizeof(int) is about.=
 Also, I understand that k*w*packetsize should be a multiple of LARGEST=
_VECTOR_WORDSIZE but I don't understand why you would multiply the alig=
nment to achieve this. Is it be enough to if (alignment % LARGEST_VECTO=
R_WORDSIZE) alignment +=3D alignment % LARGEST_VECTOR_WORDSIZE ?

Thanks in advance for your patience :-)

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
