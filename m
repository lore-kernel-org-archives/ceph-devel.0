From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Need CRYPTO_CXXFLAGS with latest master?
Date: Thu, 1 Nov 2012 21:53:24 -0700
Message-ID: <602A8C77-7214-42C9-BB4E-378C4EB6576C@inktank.com>
References: <CAPrxi59wW8EgQerDbY4E=i7RYMQy-Tb24AaSeEXJZhVehX0=1w@mail.gmail.com> <CAPrxi59u69dhunXv1PcwTeQJBvNKZ1X2JSYcsVr-sULFJ3ZzAA@mail.gmail.com> <916A1FB2-9626-4422-ABA3-1F14D5DD309F@inktank.com> <CAPrxi589jMkEN8y7PfVJkCmaJOGeE8t9B714iqEdp6WTWhaL3A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36708 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab2KBEx2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 00:53:28 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2212011pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 21:53:27 -0700 (PDT)
In-Reply-To: <CAPrxi589jMkEN8y7PfVJkCmaJOGeE8t9B714iqEdp6WTWhaL3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Let me know if you see the problem again.  It's probably something in the autotools dependencies resolution.

Cheers,
Gary


On Nov 1, 2012, at 8:54 PM, Noah Watkins wrote:

> I guess I'm going to have to retract this problem, as I can't
> reproduce it today. No clue what happened :)
> 
> On Thu, Nov 1, 2012 at 12:05 PM, Gary Lowell <gary.lowell@inktank.com> wrote:
>> Hi Noah -
>> 
>> What platform are you building on, and are you building with nss or  cryptopp ?
>> 
>> Thanks,
>> Gary
>> 
>> On Oct 31, 2012, at 8:22 PM, Noah Watkins wrote:
>> 
>>> Whoops, here is the original error:
>>> 
>>> CXX    test_idempotent_sequence.o
>>> In file included from ./os/LFNIndex.h:27:0,
>>>                from ./os/HashIndex.h:20,
>>>                from ./os/IndexManager.h:26,
>>>                from ./os/ObjectMap.h:18,
>>>                from ./os/ObjectStore.h:22,
>>>                from ./os/FileStore.h:32,
>>>                from test/filestore/test_idempotent_sequence.cc:22:
>>> ./common/ceph_crypto.h:44:22: fatal error: pk11pub.h: No such file or directory
>>> compilation terminated.
>>> CXX    DeterministicOpSequence.o
>>> In file included from ./os/LFNIndex.h:27:0,
>>>                from ./os/HashIndex.h:20,
>>>                from ./os/IndexManager.h:26,
>>>                from ./os/ObjectMap.h:18,
>>>                from ./os/ObjectStore.h:22,
>>>                from ./os/FileStore.h:32,
>>>                from test/filestore/DeterministicOpSequence.cc:21:
>>> ./common/ceph_crypto.h:44:22: fatal error: pk11pub.h: No such file or directory
>>> compilation terminated.
>>> 
>>> 
>>> On Wed, Oct 31, 2012 at 6:27 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>>>> Pushed changes to Makefile.am in branch:
>>>> 
>>>>  wip-make-crypto-flags
>>>> 
>>>> Several changes to Makefile.am that add CRYPTO_CXXFLAGS to various
>>>> test targets. I needed these to build after updating to master this
>>>> afternoon.
>>>> 
>>>> Not sure if there is something else going on in my environment..
>>>> 
>>>> Thanks,
>>>> Noah
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

