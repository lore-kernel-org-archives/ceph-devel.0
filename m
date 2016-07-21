From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: getting more updates in rocksdb
Date: Thu, 21 Jul 2016 11:16:35 +0200
Message-ID: <fe8f81e1-430f-2f3c-807b-180944b316c1@digiware.nl>
References: <a8d5d498-cbc7-f252-64a3-791995bfc5bc@digiware.nl>
 <CAJ4mKGYEmECcn_9wMBTovk0tUCnLtTH2Cmy=K18WzK02Fjah4A@mail.gmail.com>
 <1e5059aa-9470-4edc-6229-4a9346988fb3@digiware.nl>
 <578F896C.1000501@redhat.com>
 <CAOCf4A=p+FMC1Ep41-v6UDm=dYejwY+0sOKgvi77g0fxCQ94NQ@mail.gmail.com>
 <8d49bd5d-ad6b-8900-75ae-af234e5a05ae@digiware.nl>
 <CAOCf4AnmaetSW1Qz2egHphfq+r1nBVFZ+tB3SwLt9NvRN8sQrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25238 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbcGUJQt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Jul 2016 05:16:49 -0400
In-Reply-To: <CAOCf4AnmaetSW1Qz2egHphfq+r1nBVFZ+tB3SwLt9NvRN8sQrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tone Zhang <tone.zhang@linaro.org>
Cc: Josh Durgin <jdurgin@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 21-7-2016 10:59, Tone Zhang wrote:
> Hi,
>=20
> Could you please share me that after reclone the ceph code you can
> fetch the latest code of ceph/rocksdb or not? I mean the same as the
> upstream facebook/rocksdb.
> I have tried, the HEAD of ceph/rocksdb is still
> 5647fa427c4eab87c0caf8bcbb91f5846a4623f9. In my side, the code cloned
> to local is different from the files saw in github filebrowser.

Right.

That is exactly my problem as well.
https://github.com/ceph/rocksdb claims 6797e6f
Which is 17 commits behind on the master version

So what I get from the other mails, is to actually get that forward, a
commit for the new tree needs to get into ceph/ceph.
Which is what Josh and Greg are writting about.
And there is a lingering PULL from Kefu that is actually doing somethin=
g
like that.

--WjW


> Thanks.
>=20
> Br,
> Tone
>=20
> On 21 July 2016 at 16:15, Willem Jan Withagen <wjw@digiware.nl> wrote=
:
>> On 21-7-2016 09:15, Tone Zhang wrote:
>>> Hi=EF=BC=8C
>>>
>>> I met the same issue, and I run "git submodule update --init
>>> --recursive --remote" to fetch the latest commit from
>>> facebook/rocksdb.
>>> In fact, there is one similar PR has been raised, it is
>>> https://github.com/ceph/rocksdb/pull/10, it is in review stage.
>>> In fact, the PR is raised to fix the rocksdb compiling error in
>>> AArm64, the reason the ceph/rocksdb is out of date.
>>> Sure we should fetch all the delta from facebook/rocksdb to ceph/ro=
cksdb.
>>> Thanks.
>>>
>>> Br,
>>> Tone
>>>
>>> On 20 July 2016 at 22:23, Josh Durgin <jdurgin@redhat.com> wrote:
>>>> On 07/20/2016 06:52 AM, Willem Jan Withagen wrote:
>>>>>
>>>>> On 20-7-2016 15:32, Gregory Farnum wrote:
>>>>>>
>>>>>> On Wed, Jul 20, 2016 at 3:38 AM, Willem Jan Withagen <wjw@digiwa=
re.nl>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I submitted a small patch to rocksdb for FreeBSD
>>>>>>>
>>>>>>> https://github.com/facebook/rocksdb/commit/b726bf59619d43651838=
e03cce9f876b3560cbda
>>>>>>>
>>>>>>> And was hopping that it would be tracked by my Ceph stuff as we=
ll.
>>>>>>> But refetching things, it does not seem to be in the tree ceph =
cmake
>>>>>>> fetches.
>>>>>>>
>>>>>>> And I'm not fluent enough in git to actually check if my curren=
t
>>>>>>> checkout with hash: 5647fa427c4eab87c0caf8bcbb91f5846a4623f9
>>>>>>> should contain the above commit.
>>>>>>
>>>>>>
>>>>>> Use "git log" on both trees and search for the hashes? :)
>>>>>>
>>>>>> Anyway, the Ceph submodule does not auto-update (git submodules =
don't
>>>>>> support that AFAIK). You can go into the rocksdb folder and try
>>>>>> checking out the latest upstream master, then committing the new=
 hash
>>>>>> as a commit in the Ceph git repo (at least, once your commit is
>>>>>> merged; not sure if it is yet).
>>>>>
>>>>>
>>>>> Although I (sort of) understand what you are saying, I'm not able=
 to
>>>>> reproduce the actual commands to do this. Comparing the logs I
>>>>> understand. First just have to clone rocksdb.
>>>>>
>>>>> And as far as I know the commit I'm looking for is in the current
>>>>> rocksdb tree. I got commit about 22 days ago, and the current has=
h seems
>>>>> te be from just a bit before that.
>>>>
>>>>
>>>> To clarify, to update the rocksdb submodule, you'd need to first u=
pdate
>>>> the ceph fork. (cat .gitmodules shows src/rocksdb comes from
>>>> https://github.com/ceph/rocksdb).
>>>>
>>>> You can make a PR to ceph/rocksdb with the latest upstream code fr=
om
>>>> within your submodule checkout (src/rocksdb) which functions like =
a
>>>> normal git repo itself. You could e.g. 'git pull
>>>> https://github.com/facebook/rocksdb' to get the latest code there.
>>>>
>>>> Then once that's merged into ceph/rocksdb, make a PR to ceph (from=
 the
>>>> root of your ceph checkout 'git commit src/rocksdb' will update th=
e
>>>> sha1 the rocksdb submodule references).
>>
>> 'mmmm,
>>
>> If I look in ceph/rocksdb at github thru the filebrowser, the commit=
 I
>> made is actually in this tree. So I guess I should be getting it.
>> So I guess I'm going to start recloning my sources...
>>
>> --WjW
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
