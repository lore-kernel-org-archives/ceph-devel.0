From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 0/2] Fscache cleanup and fix
Date: Mon, 2 Sep 2013 13:44:47 -0400
Message-ID: <CANP1eJGZuSKNhY-ZB9akM8Gi3pntosT4W9VdvQ6VfewnXiTzHw@mail.gmail.com>
References: <cover.1377644443.git.milosz@adfin.com>
	<alpine.DEB.2.00.1308271632300.24783@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38509 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329Ab3IBRos (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Sep 2013 13:44:48 -0400
Received: by mail-wi0-f170.google.com with SMTP id cb5so1271992wib.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Sep 2013 10:44:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308271632300.24783@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>

David,

I wanted to follow on this since I haven't heard any comments on this
in the last few weeks. I imagine that you were on vacation in August.

Best,
- Milosz

On Tue, Aug 27, 2013 at 7:35 PM, Sage Weil <sage@inktank.com> wrote:
> Thanks, Milosz!
>
> I've pulled these into the testing branch and squashed them into the
> existing commits.
>
> David, I'm still not sure whether the fscache patches should go in through
> the Ceph tree or via your tree; either way I think they need your ACK.
>
> https://github.com/ceph/ceph-client/commit/e78fae9b8e0e762114df0cbe718a2ad7c49a18e7
> https://github.com/ceph/ceph-client/commit/8151f62a34cc01c9de040722aa7eff85f3092156
> https://github.com/ceph/ceph-client/commit/341158ee87d950f2bcf73e56d0db7b57bbe500a7
>
> Thanks!
> sage
>
>
> On Tue, 27 Aug 2013, Milosz Tanski wrote:
>
>> Sage,
>>
>> These are the changes you requested. I eliminated the use of ifdefs in the C
>> code. It's all self contained in cache.[ch] and in the case of it being
>> disabled becomes a nop.
>>
>> Also, I found a small bug where we would not free the invalidate queue on
>> unmount. It's split into it's own commit.
>>
>> Finally, I saw that you had a hard time building it without the kernel flag
>> enabled. So I made sure to test a config with fscache for Ceph disabled right
>> before sping things.
>>
>> The commits are from my branch (which is based on top of the main testing
>> branch) from my repo:
>>
>>     https://adfin@bitbucket.org/adfin/linux-fs.git branch: wip-ceph-fscache
>>
>> Best,
>> - Milosz
>>
>> Milosz Tanski (2):
>>   ceph: Do not leak fscache workqueue
>>   ceph: fscache cleanup
>>
>>  fs/ceph/cache.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
>>  fs/ceph/cache.h | 68 +++++++++++++++++++------------------------
>>  fs/ceph/inode.c | 61 +-------------------------------------
>>  fs/ceph/super.c | 22 ++++----------
>>  fs/ceph/super.h |  1 -
>>  5 files changed, 115 insertions(+), 127 deletions(-)
>>
>> --
>> 1.8.1.2
>>
>>
