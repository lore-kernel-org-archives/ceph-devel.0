From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: ceph python crash dumps
Date: Wed, 4 Jan 2017 10:20:38 -0500
Message-ID: <CAGbvivKu6hXg6SG6aqSmPVo+XVikZj_skqSDDwbrYtyXXKCpvA@mail.gmail.com>
References: <CAGbvivK+Rec86bxhW_Sq6tOR0fJpLRcZqVpkNXAkq_MvTMQipA@mail.gmail.com>
 <c6ee5174-f1af-0416-220e-6400bc475609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38426 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968418AbdADPUk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jan 2017 10:20:40 -0500
Received: by mail-it0-f52.google.com with SMTP id x2so323581014itf.1
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jan 2017 07:20:39 -0800 (PST)
In-Reply-To: <c6ee5174-f1af-0416-220e-6400bc475609@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Im pretty certain that is the same bug that we are hitting,
unfortunately I don't have a simple script to recreate it.  It happens
as part of a WSGI application in Apache running with 30 threads and
multiple processes.  If I tune it down to fewer threads and processes,
it becomes harder to trigger.

If this fix is accepted and integrated, please backport fix to the
next Jewel update (10.2.6).

-Wyllys Ingersoll
 Keeper Technology, LLC

On Tue, Jan 3, 2017 at 7:22 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 01/03/2017 01:39 PM, Wyllys Ingersoll wrote:
>>
>> I have a python based WSGI application running inside Apache that uses the
>> ceph python bindings to perform some operations.  Recently its been
>> throwing exceptions when trying to make ceph connections, but I can't
>> figure out what is really causing the issue here.
>>
>> Running ceph 10.2.5 with latest python-ceph packages.
>
>
> This looks like http://tracker.ceph.com/issues/14115 - in your case
> likely due to a bug in librados.
>
>> Anyone seen this sort of thing before or have any idea how to prevent it?
>
>
> You might be able to avoid it by using a single Rados instance per
> process, to avoid re-initializing crypto_context within librados.
>
> If you have a short script that reproduces it, or can run under
> valgrind's memcheck tool we can see if your case would be fixed by
>
> https://github.com/ceph/ceph/pull/12624
>
> or if there are other leaks to fix.
>
> Josh
>
>
>> The following error appears in the Apache error logs:
>>
>> common/ceph_crypto.cc: In function 'void ceph::crypto::init(CephContext*)'
>> thread 7fb1ca8c4700 time 2017-01-03 16:25:31.334606
>> common/ceph_crypto.cc: 77: FAILED assert(crypto_context != __null)
>>  ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
>>  1: (()+0x169b7b) [0x7fb1b1b82b7b]
>>  2: (()+0x1b88c0) [0x7fb1b1bd18c0]
>>  3: (()+0x184615) [0x7fb1b1b9d615]
>>  4: (()+0x181800) [0x7fb1b1b9a800]
>>  5: (()+0x95f2d) [0x7fb1b1aaef2d]
>>  6: (rados_connect()+0x1c) [0x7fb1b1a7dadc]
>
>
