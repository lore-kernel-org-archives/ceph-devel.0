From: Samuel Just <sam.just@inktank.com>
Subject: Re: controlling erasure code chunk size
Date: Sun, 2 Feb 2014 14:45:16 -0800
Message-ID: <CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>
References: <52EE6128.209@dachary.org>
	<3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:51411 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbaBBWpR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Feb 2014 17:45:17 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so9227059qac.31
        for <ceph-devel@vger.kernel.org>; Sun, 02 Feb 2014 14:45:16 -0800 (PST)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

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
