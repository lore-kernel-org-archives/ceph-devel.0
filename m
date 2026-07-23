Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95D38F92A
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781316; cv=pass; b=Svql4wgAZhLGfhBkPlLOaz1FyU9ki8D2dpQjMWoZ4ZE4MVEwr0y8DZJNxn9QW//H1SsaYx9+HBuViZSq3MQ3UShYG2Kf3AdZTTDzEdoJZtPrmDmOEa/EfxunDMteP90wWj4YFmzCXRR72WxO7mncA+QKtRnsYVWfcXstfizC7dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781316; c=relaxed/simple;
	bh=3tIRl6n9ScEPVyFCPZX1mfWqRv1lJpXYKq2yg2toHMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/ranHbpoSJ/md5t4Wj1igYB70cvYqR7uFPEv+H4ZHI3Q95gCsRQ0s/zD+sscpD7v4rZU/QER8OB/1TLyxAw+OJdjE+lNZLWR16qAX0+t5WNKO+749p25u2jg+pQ9zAYMjjUbncv41Y1oGB2ZglFTR/ONRCZOJN5zIz+CniZLGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=MJjlqI3X; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="MJjlqI3X"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1c26d7e951so39300366b.0
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2026 21:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784781299; cv=none;
        d=google.com; s=arc-20260327;
        b=R6K/hL/HNk46BlY8Rca+ysCY9afhfqpuipB3R3hNaqSJzy/ZqapSuCPfY0BgrEPNmi
         SsGlmPyd+yGXrDeSjoFPWArwJAGph08J2NK5exT6E4ZGJEJINZmSOy2hpKz6E8cw9Jfz
         Qy4I4Be+wSKHMaljjTJavfi1Z5WJIVgPCrFePHS1QqEGA6rW9CuM8iqNQ5DPfmGZJpkp
         xoINiaoXTEDpRm0td/5ykhd8vJDH7QGJ0199cUoZG9X2CnRnFTWP1rlQbKOqcOrj9Qu1
         5LRtAkJHL1FYnaJcPbCKtKc//bjGJMRkc5hC8rSwTOnho4ZpKgHvWXGC6d7B7zUth+RK
         jC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YVvRt3Do4BL7YwpYfYdAkO7uZ2P2iMzXV9MzEDFPk3Y=;
        fh=nR3Jc7XROKujVnO8AUemquLs3257DQo9aA0wcTdcOY4=;
        b=PuwEv8DVg58ZN5iRvYlSwLQUQXROLfrrTIMRhu+9ygUHeIzmagFbF5d7qvmtjkBDLP
         8AwJEcfv6UVlku6oxIzNbdcTWho/jp2bqNhSh/A0DGOMccmlKP3AKObKZWk/CL2zlTs1
         Ait9/+wcx+CYIqJQ4PQONDwvSXQW2KRm/UQJ+Wl8YGfJl5EU1MlHGk7Y5McGF9dAe8O/
         5wjQP60THrHJODT5VZx9KuAIAQk9SXEgFH1aY9IsY3I1AYVlskI50cw3VAjj3djqB2QV
         fSW1u+DVxg2ybQ1lv9WGtVPvVGTW436CkkUXYoX4776T8SW3JSdc+8sOg0EiRsOId/co
         7iTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784781299; x=1785386099; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVvRt3Do4BL7YwpYfYdAkO7uZ2P2iMzXV9MzEDFPk3Y=;
        b=MJjlqI3XhKBBAQbLhAQzd+aBLi7LyjPnQYCsyCWYFnI6V+iGeiSIPNvy5oT5ezWbAb
         4DF0bi9l1//Qw6p3yFJDZKKwqSzaTwJXLZZSDwxyWtOYF6ZhDFFNekrhIMD6gVJGeIDW
         vz+QgXw/1LwUsaiYxgOt5liuIiZGqpxNXEAEDAjECgy/0oExjwQO8KpAYxJ6gbfhNFdv
         zUKutCvsvvEOgRbC7kGHoco2Aq3QJA3lVDS8qovBBY6v6kIEC/9wak58iJGbqmE3xbNw
         1OmOLiAFamrj1SW4WTmkR868J2Hijvjiy/lGXl7cqPmYC94cDo1nZCmzrnDT0EnqaIKv
         ln6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784781299; x=1785386099;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YVvRt3Do4BL7YwpYfYdAkO7uZ2P2iMzXV9MzEDFPk3Y=;
        b=H1BePTNkina8dErOLNuxJkn6ZLf4JcdqXNc5y50xLb0n7fzoCJbzl4jjy1FWDkIU5k
         XMjFlum+gxn/YbSG974MLYA7MJcyxvW7cyr7EIbKHlvLvjeIlJrJalcApeP83XZwLzs2
         Ss0jM7oSnqIao06J9d5zKGtWuC8Av8TBJyjXbf+JAfMhkr/4u1gi3L1LXrlpPHP1w92M
         ckIdK5P4TSXFLes9gdSTsJeruLViAx61fx38UsBdeRoRlG8KPI7+xJ/zh9WLDUNac9fV
         +/DdKY6+axSh2aPoORd7moKGebaOVHVB66OPXOcRGVL4cGSEU2CMTIN6fU+rp2Y0Qa7S
         nx5A==
X-Forwarded-Encrypted: i=1; AHgh+RpolAWcb0XauoUK46/YVtUJkDtRlscEyz4uv4O1rlAf/aSgVNCXQO8HsVEtDcoHWIFlQKBXsgpt8cc9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9D2LTM9uGRLkoCRXwaXUjuxt6gl6yc3Jsep0Sv9vTCI0r9Ulo
	RO5d7y1ZKGeDWWHd28IcGO0QeoJmtZMO8Hvkq60mLvylWjQrIOSyEB9D7DSBbmEZ/nmWNYZCMlD
	FzzfHFmXniftjkZs8Cp0JXV9IUJPVxMnRsWLJoJGjpw==
X-Gm-Gg: AR+sD12cPsyhpxC1RpKfiwrdPSelxRmGqKhDPaOK7ynX3gYu9GjmVL5MkMOIbwcebnj
	nkfC69IABfCWr9W2MgU6XMTHXIZLg2EO+jtVV3bOi5OW0Fy2Q0tU3Fxocwwc1iZEOeGgvasOI+K
	5LDy1HoNwMLpem3AUBHU+uJE4btEeoMl7wLMcc4gzV7n9ajGFD5rtJ/xkmW5XsBpAUXp2PXwCb0
	P/C1IcqDWf8AUmNcMAmRh7ghcZRVEbIJaPijmAdSAOVxmCdtVKSo3+xggS1639Y
X-Received: by 2002:a17:907:7ba9:b0:c15:d0ef:a0c3 with SMTP id
 a640c23a62f3a-c1c5093591bmr74498466b.32.1784781298809; Wed, 22 Jul 2026
 21:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722114931.3557110-1-max.kellermann@ionos.com> <afb662b8da9c1365546f658d75f27c88903f8a9f.camel@dubeyko.com>
In-Reply-To: <afb662b8da9c1365546f658d75f27c88903f8a9f.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 23 Jul 2026 12:34:48 +0800
X-Gm-Features: AUfX_mwzMooYN3DkxYc_rUC_sxcwF_f4yADvVoWtrRdjn1aDa8hLR5SIjeKRzUI
Message-ID: <CAOJNxRKyeBw1cxtXwQXoUnGrguGhcYMDpf2Dujhp=jHofSDvNw@mail.gmail.com>
Subject: Re: [PATCH] ceph: avoid fs reclaim while using `current->journal_info`
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks & Regards
Xiubo

On Thu, 23 Jul 2026 at 01:20, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Wed, 2026-07-22 at 13:49 +0200, Max Kellermann wrote:
> > handle_reply() stores a `ceph_mds_request` pointer in
> > `current->journal_info` while filling the inode and dentry cache from
> > an MDS reply.
> >
> > An allocation in this section can enter direct reclaim and prune
> > dentries from another filesystem.  If this dirties an ext4 inode,
> > ext4
> > starts a JBD2 transaction.  JBD2 interprets the Ceph request in
> > `current->journal_info` as a journal handle and dereferences the
> > request's `r_tid` as `h_transaction`, causing a kernel crash, e.g.:
> >
> >  Unable to handle kernel paging request at virtual address
> > 00000000077b4818
> >  [...]
> >  Internal error: Oops: 0000000096000004 [#1]  SMP
> >  Modules linked in:
> >  CPU: 6 UID: 0 PID: 2699135 Comm: kworker/6:3 Tainted: G
> > W           6.18.38-i3 #1113 NONE
> >  [...]
> >  Workqueue: ceph-msgr ceph_con_workfn
> >  pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >  pc : jbd2__journal_start+0x2c/0x208
> >  lr : __ext4_journal_start_sb+0x100/0x178
> >  [...]
> >  Call trace:
> >   jbd2__journal_start+0x2c/0x208 (P)
> >   __ext4_journal_start_sb+0x100/0x178
> >   ext4_dirty_inode+0x3c/0x90
> >   __mark_inode_dirty+0x58/0x400
> >   iput.part.0+0x2b0/0x370
> >   iput+0x18/0x30
> >   dentry_unlink_inode+0xc0/0x158
> >   __dentry_kill+0x80/0x250
> >   shrink_dentry_list+0x90/0x130
> >   prune_dcache_sb+0x60/0x98
> >   super_cache_scan+0xe8/0x190
> >   do_shrink_slab+0x174/0x388
> >   shrink_slab+0xd8/0x4c0
> >   shrink_node+0x31c/0x908
> >   do_try_to_free_pages+0xd0/0x508
> >   try_to_free_pages+0x11c/0x238
> >   __alloc_frozen_pages_noprof+0x4d0/0xdd0
> >   __folio_alloc_noprof+0x18/0x70
> >   __filemap_get_folio+0x248/0x440
> >   ceph_readdir_prepopulate+0x570/0x9e8
> >   mds_dispatch+0x1424/0x1ba0
> >   ceph_con_process_message+0x74/0xa0
> >   ceph_con_v1_try_read+0x3a0/0x1510
> >   ceph_con_workfn+0x260/0x460
> >
> > Enter a scoped NOFS allocation context and leave it after clearing
> > `journal_info`.  This prevents filesystem reclaim from recursing into
> > another filesystem while the field contains Ceph-private data.
> >
> > Fixes: 315f24088048 ("ceph: fix security xattr deadlock")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > ---
> >  fs/ceph/mds_client.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 853bf698b356..3c692ad02c85 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/gfp.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/delay.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/seq_file.h>
> > @@ -4015,6 +4016,7 @@ static void handle_reply(struct
> > ceph_mds_session *session, struct ceph_msg *msg)
> >       struct ceph_mds_reply_head *head = msg->front.iov_base;
> >       struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply
> > info */
> >       struct ceph_snap_realm *realm;
> > +     unsigned int nofs_flags;
> >       u64 tid;
> >       int err, result;
> >       int mds = session->s_mds;
> > @@ -4158,6 +4160,14 @@ static void handle_reply(struct
> > ceph_mds_session *session, struct ceph_msg *msg)
> >
> >       /* insert trace into our cache */
> >       mutex_lock(&req->r_fill_mutex);
> > +
> > +     /* disable fs reclaim while we are using current-
> > >journal_info
> > +      * for our own purposes, or else shrinkers of other
> > +      * filesystems might dereference this pointer as a different
> > +      * type
> > +      */
> > +     nofs_flags = memalloc_nofs_save();
> > +
> >       current->journal_info = req;
> >       err = ceph_fill_trace(mdsc->fsc->sb, req);
> >       if (err == 0) {
> > @@ -4166,6 +4176,7 @@ static void handle_reply(struct
> > ceph_mds_session *session, struct ceph_msg *msg)
> >                       err = ceph_readdir_prepopulate(req, req-
> > >r_session);
> >       }
> >       current->journal_info = NULL;
> > +     memalloc_nofs_restore(nofs_flags);
> >       mutex_unlock(&req->r_fill_mutex);
> >
> >       up_read(&mdsc->snap_rwsem);
>
> Makes sense.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.
