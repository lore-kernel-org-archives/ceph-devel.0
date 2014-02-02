From: Samuel Just <sam.just@inktank.com>
Subject: Re: controlling erasure code chunk size
Date: Sun, 2 Feb 2014 15:33:16 -0800
Message-ID: <CA+4uBUYROX1gWuBzkUgxTN4Vc2+62BfXq8Ch5FHPQbvKHU8Jsw@mail.gmail.com>
References: <52EE6128.209@dachary.org>
	<3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch>
	<CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>
	<3472A07E6605974CBC9BC573F1BC02E4AE6C12B4@CERNXCHG41.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:56889 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbaBBXdR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Feb 2014 18:33:17 -0500
Received: by mail-qa0-f45.google.com with SMTP id ii20so9139046qab.32
        for <ceph-devel@vger.kernel.org>; Sun, 02 Feb 2014 15:33:16 -0800 (PST)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6C12B4@CERNXCHG41.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Adjusting deterministically based on the desired chunk_size seems like
it would be the simplest thing, if only to avoid having one more knob
to mis-adjust.  How large does packetsize need to be before making it
bigger no longer provides a benefit?
-Sam

On Sun, Feb 2, 2014 at 3:27 PM, Andreas Joachim Peters
<Andreas.Joachim.Peters@cern.ch> wrote:
> If you want 4k stripe_size, you have to configure the cauchy plugin w=
ith w=3D8 packetsize=3D128 for a k=3D4 configuration.
>
> For w=3D(multiple of 8) we could probably skip the (*sizeof(int)) and=
 get the chunksize factor 4 down ... Loic we should check if this is ok=
 with the Jerasure implementation .... I wonder if we should have 'pack=
etsize' as a plugin parameter or we should just adjust the packetsize b=
ased on the desired chunk_size to get it close.
>
> Cheers Andreas.
> ________________________________________
> From: Samuel Just [sam.just@inktank.com]
> Sent: 02 February 2014 23:45
> To: Andreas Joachim Peters
> Cc: Loic Dachary; Ceph Development
> Subject: Re: controlling erasure code chunk size
>
> I assume we will use get_chunksize(desired_chunksize) *
> get_data_chunk_count() on the mon to define the stripe width (the siz=
e
> of the buffer which will be presented to the plugin for encoding) for
> the pool.  At the moment, get_chunksize(4*(2<<10)) *
> get_data_chunk_count() =3D 393216 using the jerasure plugin where
> get_data_chunk_count() =3D 4.  This seems a bit big?
> -Sam
>
> On Sun, Feb 2, 2014 at 8:18 AM, Andreas Joachim Peters
> <Andreas.Joachim.Peters@cern.ch> wrote:
>> Hi Loic et.al.
>>
>> I think there is now some confusion about chunk_size, alignment, pac=
ketsize and the stripe_size to be used upstream.
>>
>> Algorithms with a bit-matrix require that the size per device is a m=
ultiple of (packetsize*w). Moreover the size per device and packetsize =
itself must be a multiple of sizeof(long/int). For other algorithms  yo=
u can assume the same with packetsize=3D1.
>>
>> packetsize and w influence  the performance and too small stripe_siz=
e on top will have negative performance effects due to the preparation =
of bufferlist, internal buffer checks and more loops to execute for the=
 same amount of data. We can also do some measurement for this but the =
current benchmark would probably not reflect this, since it measures th=
e algorithmic part not the bufferlist preparation part.
>>
>> If you want to define a stripe_size it has to be a multiple of the v=
alue returned by get_chunksize  and possibly it is a large multiple but=
 in total not larger than processor caches. The plugin can not define t=
he stripe_size, it defines only the alignment to be used for stripe_siz=
e and stripe_size is defined outside the plugin which maybe complicates=
 the understanding. We should carefully check once more the Jerasure al=
ignment requirements and our current implementation.
>>
>> To get rid of the platform dependency we could put a generic alignme=
nt requirement that chunksize has to be also 64-byte aligned.
>>
>> Cheers Andreas.
>>
>>
>>
>>
>> ________________________________________
>> From: Loic Dachary [loic@dachary.org]
>> Sent: 02 February 2014 16:15
>> To: Samuel Just
>> Cc: Ceph Development; Andreas Joachim Peters
>> Subject: controlling erasure code chunk size
>>
>> [cc' ceph-devel]
>>
>> Hi Sam,
>>
>> Here is how chunks are expected to be aligned:
>>
>> https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a=
25f465/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L365
>>
>>  unsigned alignment =3D k*w*packetsize*sizeof(int);
>>   if ( ((w*packetsize*sizeof(int))%LARGEST_VECTOR_WORDSIZE) )
>>     alignment =3D k*w*packetsize*LARGEST_VECTOR_WORDSIZE;
>>   return alignment;
>>
>> If you are going to encode small objects, it may very well lead to o=
versized chunks if packetsize is large. At the moment the default is 30=
72
>>
>> https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a=
25f465/src/common/config_opts.h#L406
>>
>> A value I picked when experimenting with 1MB objects encoding ( http=
://dachary.org/?p=3D2594 ).
>>
>> I'm not entirely sure why the alignment is calculated the way it is.=
 Andreas certainly has a better understanding on this topic.
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
