From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: controlling erasure code chunk size
Date: Sun, 2 Feb 2014 23:27:29 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6C12B4@CERNXCHG41.cern.ch>
References: <52EE6128.209@dachary.org>
	<3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch>,<CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:19402 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbaBBX1e convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Feb 2014 18:27:34 -0500
In-Reply-To: <CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

If you want 4k stripe_size, you have to configure the cauchy plugin wit=
h w=3D8 packetsize=3D128 for a k=3D4 configuration.

=46or w=3D(multiple of 8) we could probably skip the (*sizeof(int)) and=
 get the chunksize factor 4 down ... Loic we should check if this is ok=
 with the Jerasure implementation .... I wonder if we should have 'pack=
etsize' as a plugin parameter or we should just adjust the packetsize b=
ased on the desired chunk_size to get it close.

Cheers Andreas.
________________________________________
=46rom: Samuel Just [sam.just@inktank.com]
Sent: 02 February 2014 23:45
To: Andreas Joachim Peters
Cc: Loic Dachary; Ceph Development
Subject: Re: controlling erasure code chunk size

I assume we will use get_chunksize(desired_chunksize) *
get_data_chunk_count() on the mon to define the stripe width (the size
of the buffer which will be presented to the plugin for encoding) for
the pool.  At the moment, get_chunksize(4*(2<<10)) *
get_data_chunk_count() =3D 393216 using the jerasure plugin where
get_data_chunk_count() =3D 4.  This seems a bit big?
-Sam

On Sun, Feb 2, 2014 at 8:18 AM, Andreas Joachim Peters
<Andreas.Joachim.Peters@cern.ch> wrote:
> Hi Loic et.al.
>
> I think there is now some confusion about chunk_size, alignment, pack=
etsize and the stripe_size to be used upstream.
>
> Algorithms with a bit-matrix require that the size per device is a mu=
ltiple of (packetsize*w). Moreover the size per device and packetsize i=
tself must be a multiple of sizeof(long/int). For other algorithms  you=
 can assume the same with packetsize=3D1.
>
> packetsize and w influence  the performance and too small stripe_size=
 on top will have negative performance effects due to the preparation o=
f bufferlist, internal buffer checks and more loops to execute for the =
same amount of data. We can also do some measurement for this but the c=
urrent benchmark would probably not reflect this, since it measures the=
 algorithmic part not the bufferlist preparation part.
>
> If you want to define a stripe_size it has to be a multiple of the va=
lue returned by get_chunksize  and possibly it is a large multiple but =
in total not larger than processor caches. The plugin can not define th=
e stripe_size, it defines only the alignment to be used for stripe_size=
 and stripe_size is defined outside the plugin which maybe complicates =
the understanding. We should carefully check once more the Jerasure ali=
gnment requirements and our current implementation.
>
> To get rid of the platform dependency we could put a generic alignmen=
t requirement that chunksize has to be also 64-byte aligned.
>
> Cheers Andreas.
>
>
>
>
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 02 February 2014 16:15
> To: Samuel Just
> Cc: Ceph Development; Andreas Joachim Peters
> Subject: controlling erasure code chunk size
>
> [cc' ceph-devel]
>
> Hi Sam,
>
> Here is how chunks are expected to be aligned:
>
> https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a2=
5f465/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L365
>
>  unsigned alignment =3D k*w*packetsize*sizeof(int);
>   if ( ((w*packetsize*sizeof(int))%LARGEST_VECTOR_WORDSIZE) )
>     alignment =3D k*w*packetsize*LARGEST_VECTOR_WORDSIZE;
>   return alignment;
>
> If you are going to encode small objects, it may very well lead to ov=
ersized chunks if packetsize is large. At the moment the default is 307=
2
>
> https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a2=
5f465/src/common/config_opts.h#L406
>
> A value I picked when experimenting with 1MB objects encoding ( http:=
//dachary.org/?p=3D2594 ).
>
> I'm not entirely sure why the alignment is calculated the way it is. =
Andreas certainly has a better understanding on this topic.
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
