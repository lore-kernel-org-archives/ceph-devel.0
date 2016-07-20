From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: getting more updates in rocksdb
Date: Wed, 20 Jul 2016 15:52:57 +0200
Message-ID: <1e5059aa-9470-4edc-6229-4a9346988fb3@digiware.nl>
References: <a8d5d498-cbc7-f252-64a3-791995bfc5bc@digiware.nl>
 <CAJ4mKGYEmECcn_9wMBTovk0tUCnLtTH2Cmy=K18WzK02Fjah4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:54180 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267AbcGTNxT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Jul 2016 09:53:19 -0400
In-Reply-To: <CAJ4mKGYEmECcn_9wMBTovk0tUCnLtTH2Cmy=K18WzK02Fjah4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 20-7-2016 15:32, Gregory Farnum wrote:
> On Wed, Jul 20, 2016 at 3:38 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>
>> Hi,
>>
>> I submitted a small patch to rocksdb for FreeBSD
>> https://github.com/facebook/rocksdb/commit/b726bf59619d43651838e03cce9f876b3560cbda
>>
>> And was hopping that it would be tracked by my Ceph stuff as well.
>> But refetching things, it does not seem to be in the tree ceph cmake
>> fetches.
>>
>> And I'm not fluent enough in git to actually check if my current
>> checkout with hash: 5647fa427c4eab87c0caf8bcbb91f5846a4623f9
>> should contain the above commit.
> 
> Use "git log" on both trees and search for the hashes? :)
> 
> Anyway, the Ceph submodule does not auto-update (git submodules don't
> support that AFAIK). You can go into the rocksdb folder and try
> checking out the latest upstream master, then committing the new hash
> as a commit in the Ceph git repo (at least, once your commit is
> merged; not sure if it is yet).

Although I (sort of) understand what you are saying, I'm not able to
reproduce the actual commands to do this. Comparing the logs I
understand. First just have to clone rocksdb.

And as far as I know the commit I'm looking for is in the current
rocksdb tree. I got commit about 22 days ago, and the current hash seems
te be from just a bit before that.

--WjW


