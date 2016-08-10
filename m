From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [RFC PATCH] client: don't use special inode for /..
Date: Wed, 10 Aug 2016 17:15:12 -0400
Message-ID: <CA+2bHPaDy-UiEvve3y0f6eCmxTvCx5UUV9yvjUP=_J0eqCWJJQ@mail.gmail.com>
References: <1470846630-830-1-git-send-email-jlayton@redhat.com>
 <CA+2bHPYjYPRn99e3nCTjED6c89MnD_Eih_27z_J1=b4_CtLqOg@mail.gmail.com>
 <1470861005.2694.12.camel@redhat.com> <CA+2bHPatRa=77jr=JsuLFE86SXH9d7LNKN0LHTB1tMmeSti59A@mail.gmail.com>
 <1470863180.2694.17.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33734 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325AbcHJVPn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 17:15:43 -0400
Received: by mail-qk0-f169.google.com with SMTP id t7so56761050qkh.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 14:15:43 -0700 (PDT)
In-Reply-To: <1470863180.2694.17.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 10, 2016 at 5:06 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Wed, 2016-08-10 at 16:46 -0400, Patrick Donnelly wrote:
>> > On Wed, Aug 10, 2016 at 4:30 PM, Jeff Layton <jlayton@redhat.com> wrote:
>> >
>> > On Wed, 2016-08-10 at 16:08 -0400, Patrick Donnelly wrote:
>> > >
>> > > > > > On Wed, Aug 10, 2016 at 12:30 PM, Jeff Layton <jlayton@redhat.com>
>> > > wrote:
>> > > >
>> > > >
>> > > > The CEPH_INO_DOTDOT thing is quite strange. Under most OS (Linux
>> > > > included), the parent of the root is itself. IOW, at the root, '.'
>> > > > and
>> > > > '..' refer to the same inode.
>> > > >
>> > > > Change the ceph client to do the same, as this allows users to get
>> > > > valid stat info for '..', as well as elimnating some special-
>> > > > casing.
>> > > >
>> > > > > > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
>> > >
>> > > Don't forget Client::_lookup:
>> > >
>> > >   if (dname == "..") {
>> > >     if (dir->dn_set.empty())
>> > >       r = -ENOENT;
>> > >     else
>> > >       *target = dir->get_first_parent()->dir->parent_inode; //dirs
>> > > can't be hard-linked
>> > >     goto done;
>> > >   }
>> > >
>> > > Otherwise LGTM.
>> > >
>> >
>> >
>> > Ahh, thanks. So will dir->dn_set.empty() be true at the root? If so,
>> > then something like the patch below?
>>
>> Well, that's tricky actually. My understanding is that if dn_set is
>> empty then either the inode is unlinked or it is the root inode (from
>> the client's perspective). So the below patch is probably not quite
>> right? I think if the directory is unlinked but not the root, its ".."
>> should still refer to its first parent? The ENOENT error is probably
>> wrong.
>>
>
> Ok, so is there some way to reliably tell whether it's the root? Should
> we instead check whether it's inode number is CEPH_INO_ROOT ?

Inode::is_root should work. By the way, I see now that the readdir
code is also wrong. It should not need to check dn_set at all (just
is_root()). (It doesn't matter if the directory inode is unlinked, the
parent is still visible.)

-- 
Patrick Donnelly
