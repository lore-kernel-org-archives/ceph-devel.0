From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Need CRYPTO_CXXFLAGS with latest master?
Date: Fri, 2 Nov 2012 18:04:50 -0700
Message-ID: <591CE14B-3A97-41C0-B04A-01EBE0CEE3D4@inktank.com>
References: <CAPrxi59wW8EgQerDbY4E=i7RYMQy-Tb24AaSeEXJZhVehX0=1w@mail.gmail.com> <CAPrxi59u69dhunXv1PcwTeQJBvNKZ1X2JSYcsVr-sULFJ3ZzAA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32989 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab2KCBEy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 21:04:54 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2778815pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 18:04:53 -0700 (PDT)
In-Reply-To: <CAPrxi59u69dhunXv1PcwTeQJBvNKZ1X2JSYcsVr-sULFJ3ZzAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Looks like the complaints come from a small number of newish programs that are compiled only when the --with-debug flag is given.  When building against cryptpp (--with-cryptpp) the pk11 headers are found implicitly and  when building agains libnss (--with-nss) they are not.

So we probably need the changes in your wip-make-crypto-flags branch.

Cheers,
Gary

On Oct 31, 2012, at 8:22 PM, Noah Watkins wrote:

> Whoops, here is the original error:
> 
>  CXX    test_idempotent_sequence.o
> In file included from ./os/LFNIndex.h:27:0,
>                 from ./os/HashIndex.h:20,
>                 from ./os/IndexManager.h:26,
>                 from ./os/ObjectMap.h:18,
>                 from ./os/ObjectStore.h:22,
>                 from ./os/FileStore.h:32,
>                 from test/filestore/test_idempotent_sequence.cc:22:
> ./common/ceph_crypto.h:44:22: fatal error: pk11pub.h: No such file or directory
> compilation terminated.
>  CXX    DeterministicOpSequence.o
> In file included from ./os/LFNIndex.h:27:0,
>                 from ./os/HashIndex.h:20,
>                 from ./os/IndexManager.h:26,
>                 from ./os/ObjectMap.h:18,
>                 from ./os/ObjectStore.h:22,
>                 from ./os/FileStore.h:32,
>                 from test/filestore/DeterministicOpSequence.cc:21:
> ./common/ceph_crypto.h:44:22: fatal error: pk11pub.h: No such file or directory
> compilation terminated.
> 
> 
> On Wed, Oct 31, 2012 at 6:27 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> Pushed changes to Makefile.am in branch:
>> 
>>   wip-make-crypto-flags
>> 
>> Several changes to Makefile.am that add CRYPTO_CXXFLAGS to various
>> test targets. I needed these to build after updating to master this
>> afternoon.
>> 
>> Not sure if there is something else going on in my environment..
>> 
>> Thanks,
>> Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

