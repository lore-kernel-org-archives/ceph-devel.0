From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Initial proposal for bluestore compression control and statistics
Date: Fri, 20 May 2016 16:52:18 +0300
Message-ID: <4c89f7ee-bff1-8a9a-096a-c9459aba992b@mirantis.com>
References: <2ec0367c-ea9e-469e-4a80-b2a242c84f0f@mirantis.com>
 <20160519175708.GE22208@predictor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35648 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbcETNwW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 May 2016 09:52:22 -0400
Received: by mail-lf0-f46.google.com with SMTP id e126so24450179lfg.2
        for <ceph-devel@vger.kernel.org>; Fri, 20 May 2016 06:52:21 -0700 (PDT)
In-Reply-To: <20160519175708.GE22208@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Piotr_Da=c5=82ek?= <branch@predictor.org.pl>, ceph-devel <ceph-devel@vger.kernel.org>



On 19.05.2016 20:57, Piotr Da=C5=82ek wrote:
> On Thu, May 19, 2016 at 08:27:02PM +0300, Igor Fedotov wrote:
>> Hi cephers,
>>
>> please find my initial proposal with regard to bluestore compression
>> control and related statistics.
>>
>> Any comments/thoughts are highly appreciated.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> COMPRESSION CONTROL OPTIONS
>>
>> One can see following means to control  compression at BlueStore lev=
el.
>>
>> 1) Per-store setting to enable/disable compression and specify
>> default compression method
>>
>> bluestore_compression =3D <zlib | snappy> / <force | optional | disa=
ble>
>>
>> E.g.
>>
>> bluestore_compression =3D zlib/force
>>
>> The first token denotes default/applied compression algorithm.
>> The second one:
>>
>> 'force' - enables compression for any objects
>>
>> 'optional' - burden the caller with the need to enable compression
>> by different means (see below)
>>
>> 'disable' - unconditionally disables any compression for the store.
>>
>> This option is definitely useful for testing/debugging and has
>> probably limited use in production.
> If one uses Ceph for storage of pre-compressed data, having an option=
 to
> disable additional (Ceph-side) compression would be desireable, at le=
ast on
> per-Ceph level, but at least per-pool setting would be better.
> Regarding optional - see below.
>
>> 2) Per-object compression specification. One should be able to
>> enable/disable compression for specific object.
>>
>> Following sub-option can be provided:
>>
>>    a) Specify compression mode (along with disablement option) at
>> object creation
>>
>>    b) Specify compression mode at arbitrary moment via specific
>> method/ioctl call. Compression to be applied for subsequent write
>> requests
>>
>>    c) Force object compression/decompression at arbitrary moment via
>> specific method/ioctl call. Existing object content to be
>> compressed/decompressed and appropriate mode to be set for
>> subsequent write requests.
>>
>>    d) Disable compression for short-lived objects if corresponding
>> hint has been provided via set_alloc_hint2 call. See PR at https://g=
ithub.com/ceph/ceph/pull/6208/files/306c5e148cd2f538b3b6c8c2a1a3d5f38ef=
8e15a#r63775941
>>
>> Along with specific compression algorithm one should be able to
>> specify default algorithm selection. E.g. user can specify 'default'
>> compression for an object instead of specific 'zlib' or 'snappy'
>> value.
>>
>> This way one can avoid the need to care about the proper algorithm
>> selection for each object.
>>
>> Default algorithm to be taken from the store setting (see above)
>>
>> Such an option provides pretty good level of flexibility. Upper
>> level can introduce additional logic to control compression this
>> way, e.g. enable/disable it for specific pools or dynamically
>> control depending on how compressible object content is.
> I would also add ability to set minimum acceptable compression ratio,
> with at least two options (any and no-expand). "Any" would store comp=
ressed
> objects regardless how well they've compressed and "No-expand" would =
store
> object in compressed format only if compressed size is smaller than
> uncompressed size.
Why do we need "Any" option? Isn't "No-expand" enough?
>   For zlib, this is more than possible (see "Maximum
> expansion factor" at http://www.zlib.net/zlib_tech.html) and storing
> doubly-compressed data will yield higher cpu and memory usage while
> accessing object *and* more storage being utilized. Additional option=
 (set
> in percentage or bytes) specifying actual minimum acceptable compress=
ion
> ratio would improve on this idea further, and for example, improve re=
ad
> performance on large images (tens of gigabytes) that were compressed =
by only
> few hundred megabytes.
Sounds good.
>
>> 3) Per-write request compression control.
>>
>> This option provides the highest level of flexibility but is
>> probably an overkill.
>>
>> Any rationales to have it?
> See above. If we're going to have per-block compression flag, then wr=
iting
> compressed format data only if the compression actually shrunk the da=
ta
> would improve read performance later.
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
