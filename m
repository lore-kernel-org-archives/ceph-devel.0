From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [BUG] backport commit ebeec2ef4c in ubuntu-vivid.git break cephfs
Date: Tue, 5 Apr 2016 22:32:14 +0200
Message-ID: <CAOi1vP9wtdbZ+e9XTiJZSxBOY8uZHWAR6MbEQ8NiwE+akshotA@mail.gmail.com>
References: <90A03E70-2B8B-4C29-9655-A73D7D4523D5@redhat.com>
	<20160331143921.GB18035@whence.com>
	<87CCCB41-994B-4259-8883-001D88B7B893@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36379 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcDEUcQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 16:32:16 -0400
Received: by mail-lb0-f194.google.com with SMTP id q4so2150886lbq.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 13:32:15 -0700 (PDT)
In-Reply-To: <87CCCB41-994B-4259-8883-001D88B7B893@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sasha Levin <sasha.levin@oracle.com>
Cc: Kamal Mostafa <kamal@canonical.com>, kernel-team@lists.ubuntu.com, Ceph Development <ceph-devel@vger.kernel.org>, Luis Henriques <luis.henriques@canonical.com>

On Fri, Apr 1, 2016 at 4:01 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On Mar 31, 2016, at 22:39, Kamal Mostafa <kamal@canonical.com> wrote:
>>
>> On Thu, Mar 31, 2016 at 12:06:42PM +0800, Yan, Zheng wrote:
>>> ubuntu-vivid git tree includes commit ebeec2ef4c (ceph: fix message
>>> length computation), but does not contain backport for upstream commit
>>> 1f041a89b4 (ceph: fix request time stamp encoding). This breaks cephfs
>>> kernel driver completely. Please add the later commit to your git
>>> tree.
>>>
>>> Regards
>>> Yan, Zheng
>>
>> Hi Yan-
>>
>> Thanks for letting us know about this.  If that patch is required for
>> all trees that carry a backport of 777d738 (ceph: fix message length
>> computation), then we'll need to apply 1f041a89b4 to:
>
> yes, that patch is required for all trees include the back port
>
>>
>>  3.19.y-ckt (stable)
>>  3.16.y-ckt (stable)
>>  ubuntu-vivid
>>  ubuntu-utopic
>>
>> For our reference, can you point me to a bug report or email thread
>> which discusses the breakage?
>>
> http://tracker.ceph.com/issues/15302 <http://tracker.ceph.com/issues/15302>

777d738a5e58 "Fixes" commit that went into 3.16, while 1f041a89b4f2
went into 4.0.  This means 3.18 stable series is affected is well.

Sasha, could you cherry-pick 1f041a89b4f2 ("ceph: fix request time
stamp encoding")?

Thanks,

                Ilya
