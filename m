From: Gregory Farnum <greg@gregs42.com>
Subject: Re: RBD mirroring design draft
Date: Thu, 28 May 2015 07:07:16 -0700
Message-ID: <CAC6JEv-3jZkGcLLOUNTnmCv=s_nxW=3opq=pT7z+zUoTW_ubjQ@mail.gmail.com>
References: <55529E04.1070202@redhat.com>
	<CAC6JEv_gGMnNUVFr5m2PaTum9Pa2z2YadVSJA+JBE7BvqOMKuA@mail.gmail.com>
	<5566F0FF.2020400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32929 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbE1OHS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 10:07:18 -0400
Received: by qkhg32 with SMTP id g32so26596723qkh.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 07:07:17 -0700 (PDT)
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com. [209.85.220.174])
        by mx.google.com with ESMTPSA id 16sm1082611qhd.11.2015.05.28.07.07.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 07:07:16 -0700 (PDT)
Received: by qkoo18 with SMTP id o18so26601551qko.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 07:07:16 -0700 (PDT)
In-Reply-To: <5566F0FF.2020400@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 28, 2015 at 3:42 AM, John Spray <john.spray@redhat.com> wro=
te:
>
>
> On 28/05/2015 06:37, Gregory Farnum wrote:
>>
>> On Tue, May 12, 2015 at 5:42 PM, Josh Durgin <jdurgin@redhat.com> wr=
ote:
>>> Parallelism
>>> ^^^^^^^^^^^
>>>
>>> Mirroring many images is embarrassingly parallel. A simple unit of
>>> work is an image (more specifically a journal, if e.g. a group of
>>> images shared a journal as part of a consistency group in the futur=
e).
>>>
>>> Spreading this work across threads within a single process is
>>> relatively simple. For HA, and to avoid a single NIC becoming a
>>> bottleneck, we'll want to spread out the work across multiple
>>> processes (and probably multiple hosts). rbd-mirror should have no
>>> local state, so we just need a mechanism to coordinate the division=
 of
>>> work across multiple processes.
>>>
>>> One way to do this would be layering on top of watch/notify. Each
>>> rbd-mirror process in a zone could watch the same object, and shard
>>> the set of images to mirror based on a hash of image ids onto the
>>> current set of rbd-mirror processes sorted by client gid. The set o=
f
>>> rbd-mirror processes could be determined by listing watchers.
>>
>> You're going to have some tricky cases here when reassigning authori=
ty
>> as watchers come and go, but I think it should be doable.
>
>
> I've been fantasizing about something similar to this for CephFS back=
ward
> scrub/recovery.  My current code supports parallelism, but relies on =
the
> user to script their population of workers across client nodes.
>
> I had been thinking of more of a master/slaves model, where one guy w=
ould
> get to be the master by e.g. taking the lock on an object, and he wou=
ld then
> hand out work to everyone else that was a watch/notify subscriber to =
the
> magic object.  It seems like that could be simpler than having worker=
s have
> to work out independently what their workload should be, and have the=
 added
> bonus of providing a command-like mechanism in addition to continuous
> operation.

Heh. This could be the method but I caution people that it's a
brand-new use case for watch-notify and I'm not too sure how it'd
perform. I suspect we'd need to keep the chunks of work pretty large
in order to avoid the watch-notify cycle latencies being a limiting
factor. ;)

Speaking more generally, unless a peer-based model turns out to be
infeasible I much prefer that =E2=80=94 the systems are sometimes more
complicated but generally much more resilient to failures, and tend to
be better-designed for recovery than when everything is residing in
the master's memory and then has to get reconstructed.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
