From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Changes to Rocksdb in tree
Date: Fri, 28 Oct 2016 20:18:37 +0200
Message-ID: <8b910192-ed5d-4223-9cca-e716ccce5501@digiware.nl>
References: <db531186-389a-fafe-c911-8e75a33da72a@digiware.nl>
 <alpine.DEB.2.11.1610281044550.10754@piezo.us.to>
 <e4cc6632-4ac0-5049-1573-a08c01f6f3a1@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:57334 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935364AbcJ1SSl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Oct 2016 14:18:41 -0400
In-Reply-To: <e4cc6632-4ac0-5049-1573-a08c01f6f3a1@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 28-10-2016 15:38, Willem Jan Withagen wrote:
> On 28-10-2016 12:46, Sage Weil wrote:
>> On Fri, 28 Oct 2016, Willem Jan Withagen wrote:
>>> Hi,
>>>
>>> Now that we have an In-tree rocksdb:
>>> When I have changes to rocksdb how to I get them permanently into the
>>> Ceph tree?
>>>
>>> I submitted the changes upstream to rocksdb.
>>
>> Once they are merged upstream in rocksdb we will push the commit to 
>> github.com/ceph/rocksdb and update the submodule.  If you like, we can 
>> cherry-pick the patch in our tree too for the time being (in which case 
>> you can submit a PR to ceph/rocksdb too).
> 
> his is the PR with rocksdb:
> https://github.com/facebook/rocksdb/pull/1428
> 
> and the commit:
> https://github.com/facebook/rocksdb/pull/1428/commits/d1b183561f3238d9e42fff6402813f773c446f67
> 
> Or do you need it to be in my Ceph fork?

Change is in Rocksdb repo.
https://github.com/facebook/rocksdb/commit/0aab5e55f0b1808671fa8c58a8c8093fbe32210f

--WjW


