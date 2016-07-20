From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: getting more updates in rocksdb
Date: Wed, 20 Jul 2016 07:23:40 -0700
Message-ID: <578F896C.1000501@redhat.com>
References: <a8d5d498-cbc7-f252-64a3-791995bfc5bc@digiware.nl>
 <CAJ4mKGYEmECcn_9wMBTovk0tUCnLtTH2Cmy=K18WzK02Fjah4A@mail.gmail.com>
 <1e5059aa-9470-4edc-6229-4a9346988fb3@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56967 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929AbcGTOXa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Jul 2016 10:23:30 -0400
In-Reply-To: <1e5059aa-9470-4edc-6229-4a9346988fb3@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/20/2016 06:52 AM, Willem Jan Withagen wrote:
> On 20-7-2016 15:32, Gregory Farnum wrote:
>> On Wed, Jul 20, 2016 at 3:38 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>
>>> Hi,
>>>
>>> I submitted a small patch to rocksdb for FreeBSD
>>> https://github.com/facebook/rocksdb/commit/b726bf59619d43651838e03cce9f876b3560cbda
>>>
>>> And was hopping that it would be tracked by my Ceph stuff as well.
>>> But refetching things, it does not seem to be in the tree ceph cmake
>>> fetches.
>>>
>>> And I'm not fluent enough in git to actually check if my current
>>> checkout with hash: 5647fa427c4eab87c0caf8bcbb91f5846a4623f9
>>> should contain the above commit.
>>
>> Use "git log" on both trees and search for the hashes? :)
>>
>> Anyway, the Ceph submodule does not auto-update (git submodules don't
>> support that AFAIK). You can go into the rocksdb folder and try
>> checking out the latest upstream master, then committing the new hash
>> as a commit in the Ceph git repo (at least, once your commit is
>> merged; not sure if it is yet).
>
> Although I (sort of) understand what you are saying, I'm not able to
> reproduce the actual commands to do this. Comparing the logs I
> understand. First just have to clone rocksdb.
>
> And as far as I know the commit I'm looking for is in the current
> rocksdb tree. I got commit about 22 days ago, and the current hash seems
> te be from just a bit before that.

To clarify, to update the rocksdb submodule, you'd need to first update
the ceph fork. (cat .gitmodules shows src/rocksdb comes from
https://github.com/ceph/rocksdb).

You can make a PR to ceph/rocksdb with the latest upstream code from
within your submodule checkout (src/rocksdb) which functions like a
normal git repo itself. You could e.g. 'git pull 
https://github.com/facebook/rocksdb' to get the latest code there.

Then once that's merged into ceph/rocksdb, make a PR to ceph (from the
root of your ceph checkout 'git commit src/rocksdb' will update the
sha1 the rocksdb submodule references).

Josh

