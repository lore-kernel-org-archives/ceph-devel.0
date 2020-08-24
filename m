Return-Path: <SRS0=j5Jn=CC=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958BC433E1
	for <ceph-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22F3206F0
	for <ceph-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289020;
	bh=08B5xmuciC9Qn8N+HTCgixsvYWj3l7brqWHYJ+TxcVE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=EzyagjGAY04nQ3YoEshV3ixyT7RYTRj39ai3IZZOfqQ1Oo3BOHYc41ZDD696Z6ran
	 qf8D+HRgSuqEn89TsVMuiEhS4LJXxzKCA/xZc7R//S936mIMtxWU4jYED/KsAphiM/
	 MRqwzRt9XR63xirAjOWrU/JfvQoC67rItZXPojzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHXRKU (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgHXQh5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:37:57 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E697A22D73;
        Mon, 24 Aug 2020 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287040;
        bh=08B5xmuciC9Qn8N+HTCgixsvYWj3l7brqWHYJ+TxcVE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=deGWWJhZAq4dokVKcfYWi2Pu9SXoxrVDFlagiK5cq+HthvINSrn3eQMFwAbvOMerh
         qHzZByW65HXQv6WYX8QjPunFOkGG72afmkHo18xgNfC2TVvRxbDVUa4tdqwEtGsOzh
         aVOx1u1vE6RpMRzDen7Qg5ad8uU5p3plKjn59zLo=
Message-ID: <1d1f9e52634ca43ac018935fcfa0ac8c5fe57bfe.camel@kernel.org>
Subject: Re: [PATCH] ceph: don't allow setlease on cephfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Ceph Development <ceph-devel@vger.kernel.org>
Date:   Mon, 24 Aug 2020 12:37:18 -0400
In-Reply-To: <CAOi1vP-s7RwdndJ9T0=YLNJ+CQMQDgn9ODHKHjxo2foe_rNu=w@mail.gmail.com>
References: <20200820151349.60203-1-jlayton@kernel.org>
         <CAOi1vP_i67NVgb_sef1ZS0K_ZHP5J_H=Op+LGs3n5CJbhR_95w@mail.gmail.com>
         <17e14441da0f636e3b0b5244a27865645b168297.camel@kernel.org>
         <CAOi1vP-s7RwdndJ9T0=YLNJ+CQMQDgn9ODHKHjxo2foe_rNu=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, 2020-08-24 at 18:35 +0200, Ilya Dryomov wrote:
> On Mon, Aug 24, 2020 at 6:03 PM Jeff Layton <jlayton@kernel.org> wrote:
> > On Mon, 2020-08-24 at 17:38 +0200, Ilya Dryomov wrote:
> > > On Thu, Aug 20, 2020 at 5:13 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > Leases don't currently work correctly on kcephfs, as they are not broken
> > > > when caps are revoked. They could eventually be implemented similarly to
> > > > how we did them in libcephfs, but for now don't allow them.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/ceph/dir.c  | 2 ++
> > > >  fs/ceph/file.c | 1 +
> > > >  2 files changed, 3 insertions(+)
> > > > 
> > > > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > > > index 040eaad9d063..34f669220a8b 100644
> > > > --- a/fs/ceph/dir.c
> > > > +++ b/fs/ceph/dir.c
> > > > @@ -1935,6 +1935,7 @@ const struct file_operations ceph_dir_fops = {
> > > >         .compat_ioctl = compat_ptr_ioctl,
> > > >         .fsync = ceph_fsync,
> > > >         .lock = ceph_lock,
> > > > +       .setlease = simple_nosetlease,
> > > >         .flock = ceph_flock,
> > > >  };
> > > > 
> > > > @@ -1943,6 +1944,7 @@ const struct file_operations ceph_snapdir_fops = {
> > > >         .llseek = ceph_dir_llseek,
> > > >         .open = ceph_open,
> > > >         .release = ceph_release,
> > > > +       .setlease = simple_nosetlease,
> > > 
> > > Hi Jeff,
> > > 
> > > Isn't this redundant for directories?
> > > 
> > > Thanks,
> > > 
> > >                 Ilya
> > 
> > generic_setlease does currently return -EINVAL if you try to set it on
> > anything but a regular file. But, there is nothing that prevents that at
> > a higher level. A filesystem can implement a ->setlease op that allows
> > it.
> > 
> > So yeah, that doesn't really have of an effect since you'd likely get
> > back -EINVAL anyway, but adding this line in it makes that explicit.
> 
> It looks like gfs2 and nfs only set simple_nosetlease for file fops,
> so it might be more consistent if we did this only for ceph_file_fops
> as well.
> 

Fair enough. Do you want to just fix it up, or would you rather I send a v2?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

