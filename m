From: Gregory Farnum <greg@gregs42.com>
Subject: Re: workloads/rbd_fsx_cache_writethrough.yaml hangs on dumpling
Date: Mon, 2 Feb 2015 08:46:45 -0800
Message-ID: <CAC6JEv9y=2A3Q80bGbTtWam7ESf8_pGBG6L_VSs2B1Z=n--rDA@mail.gmail.com>
References: <54CF7927.7010908@dachary.org>
	<CAAM7YAmrh_DeJgPY-QECbiZqO4w0R=ummQBug=5B8dyoZrkjWw@mail.gmail.com>
	<54CF9120.30509@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48931 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbbBBQqr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 11:46:47 -0500
Received: by mail-ie0-f181.google.com with SMTP id rd18so9569481iec.12
        for <ceph-devel@vger.kernel.org>; Mon, 02 Feb 2015 08:46:46 -0800 (PST)
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com. [209.85.213.176])
        by mx.google.com with ESMTPSA id qs3sm6316020igb.8.2015.02.02.08.46.45
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2015 08:46:46 -0800 (PST)
Received: by mail-ig0-f176.google.com with SMTP id hl2so19661620igb.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Feb 2015 08:46:45 -0800 (PST)
In-Reply-To: <54CF9120.30509@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 2, 2015 at 7:00 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 02/02/2015 14:48, Yan, Zheng wrote:
>> On Mon, Feb 2, 2015 at 9:18 PM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi,
>>>
>>> http://pulpito.ceph.com/loic-2015-01-29_15:39:38-rbd-dumpling-backports---basic-multi/730029/ hangs on dumpling and got killed after two days.
>>>
>>> Although workloads/rbd_fsx_cache_writethrough.yaml  was running with the thrasher, it does not seem to be related to http://tracker.ceph.com/issues/10513 : it was running on a mira070 (16GB RAM) and plana78 (8GB RAM).
>>>
>>> I don't see anything in https://github.com/ceph/ceph-qa-suite/blob/master/tasks/rbd_fsx.py that would suggest it needs backporting a fix to the ceph-qa-suite branch of dumpling.
>>>
>>> I browsed the commits related to RBD that are in the dumpling-backports branch ( see here for the list I used http://tracker.ceph.com/issues/10560 ). I don't see anything in the issues that need backporting to dumpling either.
>>>
>>> Another run of this specific test has been scheduled to check if it always happens at http://pulpito.ceph.com/loic-2015-02-02_13:58:32-rbd:thrash:workloads:rbd_fsx_cache_writethrough.yaml-dumpling-backports---basic-multi/
>>>
>>> Does that ring a bell by any chance ?
>>>
>>
>> maybe it's the same as http://tracker.ceph.com/issues/10498
>>
>
> I hoped it would be but from what I read the bug crashes and creates a core dump, right ? What I'm seeing is the test hanging indefinitely and no core.

Whether it's crashing or not depends on the nature of the test. The
root cause is just a hang; some things might crash on timeouts but
others won't. (I don't think I recall seeing a crash on that bug
report anyway, though.)
-Greg
