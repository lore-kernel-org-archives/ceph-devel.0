Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFAA4028E8
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372101; cv=pass; b=YYh8RcP5y8SNL40tuveEBtgccQ+zKGKMPbVAcUB119+3Dc/Cs6wKlY4jQpFIq+X6KKvP6zMiwgniCU3FccAMQnYYfn6vV5ruKjDWtiUY3HgHg6/SpxnzqXmJqdjUq1bJr7UnE1YcvspMxRvdvk03HW42XvruCqGm9+HzPTd1DmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372101; c=relaxed/simple;
	bh=pnDzUOaejzbZKnGiFAwhq774ZLfxQebZ6F3KHCN/tGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPYpTe5DHjaA1/MIdsDjuiW3QhZDsrMg3cpDK7MFLzCGQx0iVdOZ40BIhjDzkK1sDR0ZwZ6e017/nYw1clY0f1N70zjWEDdzmRucVLFbvbwxUxyBiTTxawxv5Y1Bw+e5riy/t22+qHlLcoeewbn2PHzIezMk3byM5TZjs9MZWS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eYi5XFBL; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eYi5XFBL"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c4436d02cso9089841cf.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372094; cv=none;
        d=google.com; s=arc-20260327;
        b=kulPqJYuPIZm2lIgr3I8NsuuDyaxfKMf0ygY5v56RNIvOeypyikcyPHBlwaV0B3Rck
         NSiS7DHE+YwxWwJ2sLIpexr/if7aY7i+NJZvxr6pnP93HG+wC/MOAsh7Sm/kddtCns2N
         gz8l0A8mRtU9oFS5l1gqS8mP88Z4l5SG5r4MhU5H3nhP0cQcrHKLJyv4fG8FrkZFJHeR
         TwH9ZIfoHByF72t5b/1gmdmsTVLF3ZiuaVcna4KWxh/IJG3Y2LIzfBBgtxvYVL1nEwRw
         oFjLTGwcD43iCj1MNTZY7EX/54TUOAOnu8ZIuQJ6Er7ZyXPFi8e3CQ7VsfLeGmGc9w7w
         7xdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        fh=iMeaHoAcPutMaJ4XlOCh5Ka0dzj0JVWeuYTtQwchHJ8=;
        b=ALoFVf5T048BPaWhY4q2m3YqbQzktexbX33i4DmvlBxOzTAuHsPII/cybicsrX4SS2
         qfsPSjqzxxzSJWZ5ZTf5IcEgbeYqIritvrhLRL78lbule+ah6wTv0b2OIOI25Q8DK8NA
         aDuCu/JxZj5T9hOc0w4gNIVbB/RcN5HFDLL2LVdTYh/8wmNh3O27evfCSXKFFv0RmqOC
         G4/N4i/l53CcNWFNanSXy4g6Gdtkx3QFx3oDb91ijeRR9bELSdb/U7tRi49XkhNS8VJd
         i/PrUJhyswLs4thyCV8Ev0EHKGC0Q0bAmB7BXS2qAf4JJk09pqwTxtc9XAdSwRsQezDB
         pdEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786372094; x=1786976894; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        b=eYi5XFBL4lOLQZHq370I9VsIpsf0Hgt0nVSXeSEb+mmlrKHaJI4QsZSEEiTfiAJQOI
         BtwL1guQfj4kSPT3K1/+8ZmOHuVonXv7JrNDZggKxBZHRcaY43DswgZKTCHAkwJm+/CR
         LPGeYPx1WltgV1D0yMRC7WESmzvvQ0ZMDGIic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372094; x=1786976894;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        b=sDRxt5SWYNItU8JsNbHahzZHI475U0tmjbBsBbQSOe/Z7ykcn+dpmxFjZu5ksy4mJ6
         fRKWsCc/RgkJYWFAmskRH25/8MgyXKdpcCUDZ63EGLpUkVTAAmnhJD9PHzFqf6l1bEw5
         7BLO4q7cBUP6SX9aeQO/2IGOkj4KlKHB3Le+5ingkHD9kxjB1SKlhW0lv5s7pLAqErCn
         OpmpXvH/NWrjSvJYzB+5deN6ptJ09NQ7EsR4RBBSr+Nr9HXDUWQxfDqd9mxR7LqObhaC
         sTiVGTtUCALWLfBc4yE4JwkL2aQi9E57uzsxVdj3sqTT/eK4AK9R62PoZESn7OEjdMSv
         lcPg==
X-Forwarded-Encrypted: i=1; AHgh+RrQ8ZB80aaYgbP/oV4j4iAXtmE+Ko/ngFvpNJ4uiuIcLr2FjXc6wtjC0hgsokZaLOCmyAg2ZHiR/Gkp@vger.kernel.org
X-Gm-Message-State: AOJu0YwqEZHMsBHOflWuSVOr3KbhuDSjmdDV7f92iHbkcK7AYuCt8q2p
	xGYYg4suoShtF0eHgRSoVTdWb5pWnUNa9pi9swifOde7hmnBmyR6tf0o2jGdmqHG2tEriH1OEza
	hPzAIpAf/RE0AJBBIw05Gs+eK897aommzDuBAnrRe3A==
X-Gm-Gg: AR+sD11gE3//1RhttsnH+sx+UbD8HCHrCoPlGYwKgb6BmymQ6oj4QxPRUpKNDlr0Eg3
	bHBDS1mb25upyX5iLHWXk30r+iVo2BoMBUalI+67RRZYUmnw2jg+TjYOCZgVmDfOR4RhmVLQ2MH
	LE8twz2IGYJXA4rMAtUV4be7umhwGEl4lmTrEi2iFK+gDz+35w47SpLB94Md2y2rbVyP2D1ntWk
	AWdvyrVM054n0U5nd2/S0qJzL/lMIdbty3Ol7RcVw3BTbGCYt2sGz4cbE57rt1NElLnEJMiok2n
	frfoj8gYk8kG0GGVi1QooPUqu1lbNjD7IIcBA86lDG2xc/j94lQhC4MpTfG8Aln387MKgOu9O9Y
	=
X-Received: by 2002:a05:622a:64e:b0:528:583:a6c6 with SMTP id
 d75a77b69052e-52d18e1b942mr222143421cf.6.1786372093929; Mon, 10 Aug 2026
 07:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-4-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-4-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:28:01 +0200
X-Gm-Features: AUfX_myUlEzBYTf-8rEmM-ECZTiH7eaZjHfGryDDDQcizrarEk4s5RrECFPlIkk
Message-ID: <CAJfpegs-k3skRGiwZvQLzD7OrAK4KL8zwmpmJKyjRHSQ-rqX+Q@mail.gmail.com>
Subject: Re: [PATCH v1 03/12] fsnotify: don't hold a spin_lock across
 fsnotify_recalc_mask() calls.
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:39, NeilBrown <neilb@ownmail.net> wrote:

> @@ -116,11 +117,15 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
>                 else {
>                         *prev = dn->dn_next;
>                         kmem_cache_free(dnotify_struct_cache, dn);
> -                       dnotify_recalc_inode_mask(inode_mark);
> +                       need_recalc = true;
>                 }
>         }
>
> +       if (need_recalc)
> +               need_recalc = dnotify_recalc_inode_mask(inode_mark);
>         spin_unlock(&inode_mark->lock);
> +       if (need_recalc)
> +               fsnotify_recalc_mask(inode_mark->connector);

Is the fsnotify_group_lock() held in this case?   I don't see it.

Thanks,
Miklos
