From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: Using file->f_flags rather than flags check O_CREAT.
Date: Thu, 13 Aug 2015 21:25:16 +0800
Message-ID: <CAAM7YAkTek8KB4v=Pbw2kE4RJRR=sFbJP2pFnHmh7S=yK+yB4g@mail.gmail.com>
References: <6AA21C22F0A5DA478922644AD2EC308C1D19E799@SHSMSX101.ccr.corp.intel.com>
	<CAAM7YA=FTWLfm0j=M-tw8hKTtL=ifzAdgJH3Ojf2v_vJRJskqw@mail.gmail.com>
	<alpine.DEB.2.00.1508130533060.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34591 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbHMNZS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Aug 2015 09:25:18 -0400
Received: by labd1 with SMTP id d1so26193051lab.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2015 06:25:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508130533060.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "zyan@redhat.com" <zyan@redhat.com>

On Thu, Aug 13, 2015 at 8:34 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 13 Aug 2015, Yan, Zheng wrote:
>> On Thu, Aug 13, 2015 at 5:01 PM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
>> > Because flags removed the O_CREAT, so we should use file->f_flags.
>> >
>> > Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
>> > ---
>> >  fs/ceph/file.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> > index 8b79d87..e1347cf 100644
>> > --- a/fs/ceph/file.c
>> > +++ b/fs/ceph/file.c
>> > @@ -210,7 +210,7 @@ int ceph_open(struct inode *inode, struct file *file)
>> >         ihold(inode);
>> >
>> >         req->r_num_caps = 1;
>> > -       if (flags & O_CREAT)
>> > +       if (file->f_flags & O_CREAT)
>> >                 parent_inode = ceph_get_dentry_parent_inode(file->f_path.dentry);
>> >         err = ceph_mdsc_do_request(mdsc, parent_inode, req);
>> >         iput(parent_inode);
>>
>> In this case, we do not need parent_inode because file already exists.
>> I'd like to remove the code that finds parent inode.
>
> Do you mean that O_CREAT is only removed in the case where the inode
> already exists?  Because there is at least one case where we do a single
> op to the MDS that does the create + open, and in that case we do need to
> make sure a dir fsync waits for it to commit.  As long as we don't break
> that one!
>

create+open case is handled by ceph_atomic_open or ceph_create.
ceph_open is used only when inode already exists.

Regards
Yan, Zheng

> sage
