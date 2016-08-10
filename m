From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [RFC PATCH] client: don't use special inode for /..
Date: Wed, 10 Aug 2016 16:46:46 -0400
Message-ID: <CA+2bHPatRa=77jr=JsuLFE86SXH9d7LNKN0LHTB1tMmeSti59A@mail.gmail.com>
References: <1470846630-830-1-git-send-email-jlayton@redhat.com>
 <CA+2bHPYjYPRn99e3nCTjED6c89MnD_Eih_27z_J1=b4_CtLqOg@mail.gmail.com> <1470861005.2694.12.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34034 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697AbcHJUrS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 16:47:18 -0400
Received: by mail-qk0-f178.google.com with SMTP id p186so55964855qkd.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 13:47:17 -0700 (PDT)
In-Reply-To: <1470861005.2694.12.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 10, 2016 at 4:30 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Wed, 2016-08-10 at 16:08 -0400, Patrick Donnelly wrote:
>> On Wed, Aug 10, 2016 at 12:30 PM, Jeff Layton <jlayton@redhat.com>
>> wrote:
>> >
>> > The CEPH_INO_DOTDOT thing is quite strange. Under most OS (Linux
>> > included), the parent of the root is itself. IOW, at the root, '.'
>> > and
>> > '..' refer to the same inode.
>> >
>> > Change the ceph client to do the same, as this allows users to get
>> > valid stat info for '..', as well as elimnating some special-
>> > casing.
>> >
>> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
>>
>> Don't forget Client::_lookup:
>>
>>   if (dname == "..") {
>>     if (dir->dn_set.empty())
>>       r = -ENOENT;
>>     else
>>       *target = dir->get_first_parent()->dir->parent_inode; //dirs
>> can't be hard-linked
>>     goto done;
>>   }
>>
>> Otherwise LGTM.
>>
>
>
> Ahh, thanks. So will dir->dn_set.empty() be true at the root? If so,
> then something like the patch below?

Well, that's tricky actually. My understanding is that if dn_set is
empty then either the inode is unlinked or it is the root inode (from
the client's perspective). So the below patch is probably not quite
right? I think if the directory is unlinked but not the root, its ".."
should still refer to its first parent? The ENOENT error is probably
wrong.

> Note that this patch is not strictly necessary, but it does simplify
> some other changes that I have queued up:

I think the patch is a good change but there may be some other code
paths that need fixed. This change needs some simple tests.

-- 
Patrick Donnelly
