From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [Ceph-qa] ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 06:58:09 -0700
Message-ID: <CAJ4mKGZ72SOiFt_t+ErWBWuGLQSDMYGyKJDyFnRKpUGJ+oORUw@mail.gmail.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
	<570E4843.8000102@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33955 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030906AbcDMN6K convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 09:58:10 -0400
Received: by mail-vk0-f41.google.com with SMTP id e185so70304355vkb.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 06:58:10 -0700 (PDT)
In-Reply-To: <570E4843.8000102@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

On Wed, Apr 13, 2016 at 6:23 AM, Loic Dachary <loic@dachary.org> wrote:
> +1 : I agree it would be a good thing.
>
> The reason why it would help to merge ceph-qa-suite in ceph is because we have no proper methods or tools to work with interdependent repositories. The problem is not unique to Ceph: every Free Software developer end up bug fixing and adding features to dependencies (ceph-qa-suite in the case of Ceph but also jerasure, rocksdb, s3test etc.). It will take a long time to resolve that more general problem and I don't know about an effort in that direction. Do you ?
>
> Cheers
>
> On 13/04/2016 12:52, John Spray wrote:
>> Lately, we've instances where ceph.git and ceph-qa-suite.git got
>> slightly out of sync, as we were adding new stuff and interface
>> changes to ceph (especially in cephfs).
>>
>> We used to have two repos (ceph and teuthology), now we have three
>> (ceph, ceph-qa-suite and teuthology).  Splitting tests out of
>> teuthology was a good thing, but maybe they should have gone into the
>> ceph tree instead of a new repo?  The ceph-qa-suite branching seems to
>> pretty much mirror what we do with ceph, with master vs jewel etc.
>>
>> Historically we had a comparatively static set of workloads in the qa
>> suite (e.g. kernel-untar-build, fsstresss, pjd), which didn't change
>> much with ceph changes.  But these days we're adding much more
>> detailed tests, so there's more effort to keep the two in sync.
>>
>> I would personally love to be able to have a single PR that contained
>> my code and the tests for it.  What if after Jewel we pulled all of
>> ceph-qa-suite into the ceph repo?
>>
>> We could still enable folks running test changes without having to
>> rebuild ceph packages: the suite sha1 selected when running a
>> teuthology suite could still be different from that used for
>> installing ceph, it's just that it would fetch that sha1 from the ceph
>> repo instead of from a separate repo.

We do have qa-suite tests that don't necessarily make a lot of sense
to have in ceph.git. Samba, kernel NFS, ganesha some day. That doesn't
mean we shouldn't merge them, but it popped into my head.
-Greg
