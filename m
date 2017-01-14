From: kefu chai <tchaikov@gmail.com>
Subject: Re: Shaman build fails with "reference is not a tree"
Date: Sat, 14 Jan 2017 12:59:31 +0800
Message-ID: <CAJE9aOPmBtLBPmETixOtwTjqMO4t92JG6yVTAV4BUknEUEO+Nw@mail.gmail.com>
References: <0dc16c42-995c-8623-f2e6-5b69868f8e15@suse.cz> <6002374e-e889-ab23-b2f6-c9aad7de6db1@suse.cz>
 <alpine.DEB.2.11.1701131435390.1911@piezo.novalocal> <f7625cc6-2fd7-3ace-31ad-c10dcef66e52@dachary.org>
 <b0731b3d-87fb-f232-331e-c5072c7b3ee0@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33324 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbdANE7d (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2017 23:59:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id r144so16201984wme.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2017 20:59:33 -0800 (PST)
In-Reply-To: <b0731b3d-87fb-f232-331e-c5072c7b3ee0@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>, Alfredo Deza <adeza@redhat.com>, "Mick, Dan" <dmick@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Jan 14, 2017 at 5:05 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hm, master seems to have the same problem as hammer:
>
> Unable to checkout '3d899da2f005f72e1682f0e000aa41b82dbd2fde' in submodule
> path 'src/rocksdb'


$ git show --format=oneline 3d899da2f005f72e1682f0e000aa41b82dbd2fde
3d899da2f005f72e1682f0e000aa41b82dbd2fde util/thread_local.h: silence
a clang-build warning

Nathan, this submodule reference is not in master yet. it's a a very
recent commit in https://github.com/ceph/rocksdb/commits/wip-rocksdb,
it is included in the PR of https://github.com/ceph/ceph/pull/12908.
as i planned to retire that branch after the upstream accepts my PRs.
it is not pushed to "master" or a non "wip" branch.


>
>
> On 01/13/2017 04:11 PM, Loic Dachary wrote:
>>
>>
>>
>> On 01/13/2017 03:36 PM, Sage Weil wrote:
>>>
>>> On Fri, 13 Jan 2017, Nathan Cutler wrote:
>>>>
>>>> The error is reproducible by running the following commands:
>>>>
>>>> git clone http://github.com/ceph/ceph
>>>> git checkout hammer
>>>> git submodule update --init
>>>>
>>>> So it's not a Shaman issue. Looks more like a git repo issue.
>>>
>>>
>>> I just tried this and it's working for me...
>>> 422e26633267b25c225975b456a9f4fc40091a2e is the precious-v0.94.9 branch
>>> in
>>> rocksdb.git.
>>
>>
>> I just pushed it ;-) http://tracker.ceph.com/issues/18521 tracks the
>> problem. I have no clue what caused it in the first place.
>>
>>>
>>> sage
>>
>>
>>
>>>
>>>>
>>>> On 01/13/2017 12:36 PM, Nathan Cutler wrote:
>>>>>
>>>>> Is it me, or is Shaman is acting weird? wip-hammer-backports build
>>>>> suddenly fails because:
>>>>>
>>>>> Submodule 'src/rocksdb' (https://github.com/ceph/rocksdb) registered
>>>>> for
>>>>> path 'src/rocksdb'
>>>>> Cloning into 'src/rocksdb'...
>>>>> fatal: reference is not a tree:
>>>>> 422e26633267b25c225975b456a9f4fc40091a2e
>>>>> Unable to checkout '422e26633267b25c225975b456a9f4fc40091a2e' in
>>>>> submodule path 'src/rocksdb'
>>>>>
>>>>> Some googling suggests the following might help:
>>>>>
>>>>> git submodule sync
>>>>> git submodule update
>>>>>
>>>>
>>>> --
>>>> Nathan Cutler
>>>> Software Engineer Distributed Storage
>>>> SUSE LINUX, s.r.o.
>>>> Tel.: +420 284 084 037
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
