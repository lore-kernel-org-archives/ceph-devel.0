From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: controlling erasure code chunk size
Date: Sun, 2 Feb 2014 16:18:53 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch>
References: <52EE6128.209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:42755 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbaBBQS5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Feb 2014 11:18:57 -0500
In-Reply-To: <52EE6128.209@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic et.al.

I think there is now some confusion about chunk_size, alignment, packet=
size and the stripe_size to be used upstream.

Algorithms with a bit-matrix require that the size per device is a mult=
iple of (packetsize*w). Moreover the size per device and packetsize its=
elf must be a multiple of sizeof(long/int). For other algorithms  you c=
an assume the same with packetsize=3D1.

packetsize and w influence  the performance and too small stripe_size o=
n top will have negative performance effects due to the preparation of =
bufferlist, internal buffer checks and more loops to execute for the sa=
me amount of data. We can also do some measurement for this but the cur=
rent benchmark would probably not reflect this, since it measures the a=
lgorithmic part not the bufferlist preparation part.

If you want to define a stripe_size it has to be a multiple of the valu=
e returned by get_chunksize  and possibly it is a large multiple but in=
 total not larger than processor caches. The plugin can not define the =
stripe_size, it defines only the alignment to be used for stripe_size a=
nd stripe_size is defined outside the plugin which maybe complicates th=
e understanding. We should carefully check once more the Jerasure align=
ment requirements and our current implementation.

To get rid of the platform dependency we could put a generic alignment =
requirement that chunksize has to be also 64-byte aligned.=20

Cheers Andreas.




________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 02 February 2014 16:15
To: Samuel Just
Cc: Ceph Development; Andreas Joachim Peters
Subject: controlling erasure code chunk size

[cc' ceph-devel]

Hi Sam,

Here is how chunks are expected to be aligned:

https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a25f=
465/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L365

 unsigned alignment =3D k*w*packetsize*sizeof(int);
  if ( ((w*packetsize*sizeof(int))%LARGEST_VECTOR_WORDSIZE) )
    alignment =3D k*w*packetsize*LARGEST_VECTOR_WORDSIZE;
  return alignment;

If you are going to encode small objects, it may very well lead to over=
sized chunks if packetsize is large. At the moment the default is 3072

https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a25f=
465/src/common/config_opts.h#L406

A value I picked when experimenting with 1MB objects encoding ( http://=
dachary.org/?p=3D2594 ).

I'm not entirely sure why the alignment is calculated the way it is. An=
dreas certainly has a better understanding on this topic.

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
