From: Samuel Just <sam.just@inktank.com>
Subject: Re: controlling erasure code chunk size
Date: Mon, 3 Feb 2014 10:15:52 -0800
Message-ID: <CA+4uBUaRXM8J2kotvMQcTdVxEYf0o0y6MJ7S=UjbwizjFcjKSg@mail.gmail.com>
References: <52EE6128.209@dachary.org>
	<3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch>
	<CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>
	<52EF7F14.5020108@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:40539 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbaBCSPx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 13:15:53 -0500
Received: by mail-qc0-f172.google.com with SMTP id c9so11649189qcz.17
        for <ceph-devel@vger.kernel.org>; Mon, 03 Feb 2014 10:15:52 -0800 (PST)
In-Reply-To: <52EF7F14.5020108@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

Yes, I figured we might as well match stripe_width to chunk_size *
get_data_chunk_count().
-Sam

On Mon, Feb 3, 2014 at 3:35 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> The argument to get_chunk_size is the stripe width, named object_size=
 because the API knows nothing about stripes, it is a concept for the c=
aller to implement. Say you have a desired chunk size in mind, you woul=
d:
>
>    object_size =3D desired_chunk_size * get_data_chunk_count()
>    actual_chunk_size =3D get_chunk_size(object_size)
>
> If you have a desired stripe width / object size in mind you would:
>
>    object_size =3D desired_stripe_width
>    chunk_size =3D get_chunk_size(object_size)
>
> Following Andreas suggestions, controlling the size of the actual chu=
nk is a matter of tweaking the alignment constraints via the erasure co=
de plugin parameters.
>
> Cheers
>
> On 02/02/2014 23:45, Samuel Just wrote:
>> I assume we will use get_chunksize(desired_chunksize) *
>> get_data_chunk_count() on the mon to define the stripe width (the si=
ze
>> of the buffer which will be presented to the plugin for encoding) fo=
r
>> the pool.  At the moment, get_chunksize(4*(2<<10)) *
>> get_data_chunk_count() =3D 393216 using the jerasure plugin where
>> get_data_chunk_count() =3D 4.  This seems a bit big?
>> -Sam
>>
>> On Sun, Feb 2, 2014 at 8:18 AM, Andreas Joachim Peters
>> <Andreas.Joachim.Peters@cern.ch> wrote:
>>> Hi Loic et.al.
>>>
>>> I think there is now some confusion about chunk_size, alignment, pa=
cketsize and the stripe_size to be used upstream.
>>>
>>> Algorithms with a bit-matrix require that the size per device is a =
multiple of (packetsize*w). Moreover the size per device and packetsize=
 itself must be a multiple of sizeof(long/int). For other algorithms  y=
ou can assume the same with packetsize=3D1.
>>>
>>> packetsize and w influence  the performance and too small stripe_si=
ze on top will have negative performance effects due to the preparation=
 of bufferlist, internal buffer checks and more loops to execute for th=
e same amount of data. We can also do some measurement for this but the=
 current benchmark would probably not reflect this, since it measures t=
he algorithmic part not the bufferlist preparation part.
>>>
>>> If you want to define a stripe_size it has to be a multiple of the =
value returned by get_chunksize  and possibly it is a large multiple bu=
t in total not larger than processor caches. The plugin can not define =
the stripe_size, it defines only the alignment to be used for stripe_si=
ze and stripe_size is defined outside the plugin which maybe complicate=
s the understanding. We should carefully check once more the Jerasure a=
lignment requirements and our current implementation.
>>>
>>> To get rid of the platform dependency we could put a generic alignm=
ent requirement that chunksize has to be also 64-byte aligned.
>>>
>>> Cheers Andreas.
>>>
>>>
>>>
>>>
>>> ________________________________________
>>> From: Loic Dachary [loic@dachary.org]
>>> Sent: 02 February 2014 16:15
>>> To: Samuel Just
>>> Cc: Ceph Development; Andreas Joachim Peters
>>> Subject: controlling erasure code chunk size
>>>
>>> [cc' ceph-devel]
>>>
>>> Hi Sam,
>>>
>>> Here is how chunks are expected to be aligned:
>>>
>>> https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146=
a25f465/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L365
>>>
>>>  unsigned alignment =3D k*w*packetsize*sizeof(int);
>>>   if ( ((w*packetsize*sizeof(int))%LARGEST_VECTOR_WORDSIZE) )
>>>     alignment =3D k*w*packetsize*LARGEST_VECTOR_WORDSIZE;
>>>   return alignment;
>>>
>>> If you are going to encode small objects, it may very well lead to =
oversized chunks if packetsize is large. At the moment the default is 3=
072
>>>
>>> https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146=
a25f465/src/common/config_opts.h#L406
>>>
>>> A value I picked when experimenting with 1MB objects encoding ( htt=
p://dachary.org/?p=3D2594 ).
>>>
>>> I'm not entirely sure why the alignment is calculated the way it is=
=2E Andreas certainly has a better understanding on this topic.
>>>
>>> Cheers
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
