From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Need CRYPTO_CXXFLAGS with latest master?
Date: Wed, 31 Oct 2012 20:22:45 -0700
Message-ID: <CAPrxi59u69dhunXv1PcwTeQJBvNKZ1X2JSYcsVr-sULFJ3ZzAA@mail.gmail.com>
References: <CAPrxi59wW8EgQerDbY4E=i7RYMQy-Tb24AaSeEXJZhVehX0=1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45233 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186Ab2KADWq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 23:22:46 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so2276408vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 20:22:45 -0700 (PDT)
In-Reply-To: <CAPrxi59wW8EgQerDbY4E=i7RYMQy-Tb24AaSeEXJZhVehX0=1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Whoops, here is the original error:

  CXX    test_idempotent_sequence.o
In file included from ./os/LFNIndex.h:27:0,
                 from ./os/HashIndex.h:20,
                 from ./os/IndexManager.h:26,
                 from ./os/ObjectMap.h:18,
                 from ./os/ObjectStore.h:22,
                 from ./os/FileStore.h:32,
                 from test/filestore/test_idempotent_sequence.cc:22:
./common/ceph_crypto.h:44:22: fatal error: pk11pub.h: No such file or directory
compilation terminated.
  CXX    DeterministicOpSequence.o
In file included from ./os/LFNIndex.h:27:0,
                 from ./os/HashIndex.h:20,
                 from ./os/IndexManager.h:26,
                 from ./os/ObjectMap.h:18,
                 from ./os/ObjectStore.h:22,
                 from ./os/FileStore.h:32,
                 from test/filestore/DeterministicOpSequence.cc:21:
./common/ceph_crypto.h:44:22: fatal error: pk11pub.h: No such file or directory
compilation terminated.


On Wed, Oct 31, 2012 at 6:27 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Pushed changes to Makefile.am in branch:
>
>    wip-make-crypto-flags
>
> Several changes to Makefile.am that add CRYPTO_CXXFLAGS to various
> test targets. I needed these to build after updating to master this
> afternoon.
>
> Not sure if there is something else going on in my environment..
>
> Thanks,
> Noah
