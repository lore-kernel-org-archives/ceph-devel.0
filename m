From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: per-pool bluestore options
Date: Mon, 15 Aug 2016 16:48:49 +0300
Message-ID: <4adc2518-07d5-f4bd-7d71-5716bfb767c1@mirantis.com>
References: <alpine.DEB.2.11.1608131843050.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33348 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbcHONro (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 09:47:44 -0400
Received: by mail-wm0-f51.google.com with SMTP id d196so21037699wmd.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2016 06:47:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608131843050.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Sage,

see inline.


On 13.08.2016 21:56, Sage Weil wrote:
> Hi Igor,
>
> I took another look at
>
> 	https://github.com/ceph/ceph/pull/10556
>
> You define three settings:
>
>   compress_hint - determines if pool contains compressible / incompressible data
>   compress_algorithm - permits to specify different compression algorithm
>   compress_ratio - specifies maximum compression ratio
>
> I think we should extend this to include csum-related options.  And use a
> consistent naming scheme that aligns with the config options where we just
> strip off the bluestore_ prefix.  The relevant options are:
Sounds good!
The major questions here is how do these per-pool options correlate with 
corresponding per-store ones?
One might suggest per-pool options to have higher priority over 
per-store one. But I'm not sure that the best option.  Sometimes user 
might want to disable/alter corresponding option without enumerating all 
the pools by simple switching at per-store level. Hence we need to 
consider some means for that.
>   bluestore_csum = {true, false}
>   bluestore_csum_type = {crc32c, crc32c_{8,16}, ...}
>   bluestore_csum_min_chunk_size = 4k      (*)
>   bluestore_csum_max_chunk_size = 64k     (*)
>   bluestore_compression = {force, aggressive, passive, none}
Actually this option along with compression_hint result in a single 
flag: compress or not. Any rationale for not using that simple flag?

My original idea here was to have bluestore_compression on per-store 
basis and compression_hint of per pool one. This way one can receive 
pretty flexible control at both storage and pool level - see my question 
above.

>   bluestore_compression_algorithm = {snappy, zlib, ...}
>   bluestore_compression_min_blob_size = 256k
>   bluestore_compression_max_blob_size = 4M
>   bluestore_compression_required_ratio = .875
>
> (*) These currently have a different name but aren't used yet.  Working on
> a PR to change that.
>
> What's missing is your 'compress_hint'.  We can call that
> 'compression_hint' to align with the names above?
>
>   compression_hint = {compressible, incompressible, ...}
>
> The main changes from your PR that I think we need to make are:
>
> * These options should be part of the pool_opts_t structure in pg_pool_t
> (which is a set of optional key/value-like parameters for the pool).
>
> * We can add a new ObjectStore operation that passes down parameters for a
> collection, and have the OSD pass these all in for each PG collection when
> the pool properties change.  That way ObjectStore doesn't need to persist
> these options at all--just store the ones it understands in memory, and
> the OSD will always reset them on startup etc.
One, probably silly, question here - do pool and collection have 1 to 1 
relation? It seemed to me that they don't and hence we can't store 
per-pool settings at collection level without some additional mapping: 
pool -> setting. Also this requires some means to remove pool settings 
entry when pool goes away...

And another question - are there any means to receive notification when 
pool setting changes. Similar to the one we have for OSD settings. We 
need that to trigger that new Object Store operation to update pool 
settings.
>
> What do you think?
>
> sage

