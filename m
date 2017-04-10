From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Forwarding Rocksdb to a new sha
Date: Mon, 10 Apr 2017 15:45:28 +0200
Message-ID: <21ce1351-d892-90ed-d902-fb043af3d87e@digiware.nl>
References: <efe3e212-13b9-c4b6-9abd-f95a6803123a@digiware.nl>
 <alpine.DEB.2.11.1704101334321.2999@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:21747 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753239AbdDJNpv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Apr 2017 09:45:51 -0400
In-Reply-To: <alpine.DEB.2.11.1704101334321.2999@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 10-4-2017 15:36, Sage Weil wrote:
> On Mon, 10 Apr 2017, Willem Jan Withagen wrote:
>> Hi,
>>
>> I have submitted a PR to RocksDB that got accepted.
>> But now I'd like to try it in my WIP tree.
>>
>> So how do I locally roll the RocksDB version forward?
>>
>> Is it as simple as going into RocksDB and go:
>> 	'git pull' ??
> 
> It depends on what remotes you have in the rocksdb repository; you may 
> have to 'git remote add upstream https://github.com/facebook/rocksdb' and 
> fetch that first.

Uptil now I avoided cloning RocksDB and submitted PRs fully thru GitHub ;-)

> Once you get the submodule on the right commit, you'll need to make a 
> commit in the containing ceph.git updating the submodule sha1.  (I usually 
> use 'git gui' for this.)

There is not that many updates to RocksDB, And my PR-commit is the
current HEAD: 04abb2b2ddc308ab03f55ea9a1e08b62667d6e39

So how do I forward the submodule to this SHA?
And I can actually test this release of RockDB with Ceph. Otherwise we
stay at the old version we include, and I need to keep a patch.

--WjW


