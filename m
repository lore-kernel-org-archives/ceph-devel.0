Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25A3F9F56
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372647; cv=pass; b=FYc9Sr2R7cInOESIuABorslXHy0ck8e42qE5c2284Xzw+piYwb3XV/LbeCMfGAnVnfoNZJe+54tCFKA9sHtUas9Ba+vt5BYDKNrhcBr9MnrqS7vSZFmfvzBgNbmnMbHjbq0EGY+bmCZtA+dfufliq96oZXuZve7n26+Y6tOmfto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372647; c=relaxed/simple;
	bh=1TOh47GuX2DYZgrLBuHx9ZqIJlL5qlbKX0nFvU4QG8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/XYqpreRUN89ktFZMScO17pLVh7rqAGIUB4h/Ja35iDJGiWrVx0yIHflgi331R2mA0kMxlFWLZKIPH+KGKtJQpWMNWfYmll9dMRDr7Sh+hEAdw9gJvmOPX8uSYspNlmKxMwT+XVIxW3rOFRSMvaJPCz7F3WM1Qn84OHEno4EsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BnjWOSSE; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BnjWOSSE"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so15405946d6.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372644; cv=none;
        d=google.com; s=arc-20260327;
        b=QSod4LB68VUUml74rojhO+FJFs2EeeqKHPRa4Je8z1ySgxaAjWX5xuhVUAo1olPVBU
         2iUthKX66vUVKpjkst4c8kj/5PS0u6136G22qploA0Yu55YmW5z2G3M40LeYfuqTn2tC
         Lovh6l2Y1U6rCYG1iKca5BKzW7QTALae809QHSyaXP2Z1RBGVuoPRbYrt+v+COZ6TmP5
         bp/C5E1OHAwnhZvP4hLGYgp3zWY3RMj2ACd3D72oZtG3bzN7av+k/qERpRApMYKUbg3q
         tnDzGtn9WkHHxtGjNfuGxc4f+XLDtMCYfh2B6x+M7kwMAz1w6OTOlKWcTplTtBtWFVlg
         1lag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        fh=2CMZSe/pDbdTV/lske4uzg3MctkVhpMqpsW5PaC06rI=;
        b=NvAJpKOapVUsemREvyGokIovzyZzy5Zp1+HkpZUOINi1Wvp/NTonGoJToih8I+pn0t
         1izSZ2uYn0TD9ZzOPaXGeqvqXqWA1xUZEuIaHP72gsikquHw9mOzf34QU3jfIGQLfcA7
         jYgiJ8AFickVVOiuHZgOyvEDzMqi4g8hLMGZ5VXNssKVIXqh1R96UP26YdwBngfbXvKl
         tQVvHNsxuTQGdHsn9EL7ONQfeeSKfGafeHXZRDfIaDOaJ0jMn6vg+j5MZBJiGoViQNWO
         qV4F8FUu/GmWVeTnWSP+bi7lamBbY23CGrXqeuGDp9+nAfK8Pu2chzCQ+AXC/GCZJiH0
         GYrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786372644; x=1786977444; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        b=BnjWOSSEvEzWJR5J14cWubjkTZghiLwSDr8kJW4rvp0BwKy+nI2ukNW8e93CAslQWz
         oCQhP/5/uCvPqx210NpA5dAr7YKD1Po/1H7JGoWx0owTdLfkUjN6DLKhHhLpSAH2I+iI
         vgQcsTPjEjbabHAo6lj8yF/WExkf+DhpOI64s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372644; x=1786977444;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        b=Lem0bln107fDdrPx+ShNH6DfkYnm98ldc5JBNHUfpS/FVQMBcOzu+P5UqHFl4mI6VZ
         /AWER/rmusCHLe8lGVPkbCb1nvIkd04ESqQhdCJjkRLIII5BnSYn4A9T4gUJ/IRapL9P
         gSqzKejpd7SBqGfKfWcVwQEfGImzf6H8cgPAlXBJv+DI4DvQjiasOE6TQwozaLO0Joxn
         YRviO04GqRcQz2OWWV3JWvQh0AbeQ4odCpohY2PNcZAJz1c8HoUmY/AE1imFY4D0173S
         lcT6a+7wU80+hH0mF2HSfROAgCMN/0Khlf6CsoMHXTUF+DkxPLEwRP29oSqPyn8Xs9nG
         Aq2w==
X-Forwarded-Encrypted: i=1; AHgh+Roh2wA69qasWgkLxi1XHQG+5W0Fy0zCJJEogMqlbG1nKSTTCF0j+6fpuUar0fAyhE2btssJVF74iJL8@vger.kernel.org
X-Gm-Message-State: AOJu0YwsEnOf1JWb8nNb+YSiLhd8Evt88Dor6jBD/Ny7LGTpgLTr0ONQ
	rkNWNN0myfCuHvB1dZuBkqEXOT50d010ZLacfvBQ0vPOvhc1PfwscyjGHix3VF2GQyY5Lc49mrU
	TM2WsEETeGUMF7y78unEhLr22SCVWGHWjX5iPPg2bsA==
X-Gm-Gg: AR+sD113tuf3SfxJSgtIFqLf3EfJ1aGiqyDEh+8EIheI4tC1Toidb33ugAADA1njdqN
	cBbP8KPtvB8JIK9Mz2nMkqPNx//Qn0inHXabmpQvfyKIUgFvQE8NQh8+8mMf99qghPxtVOrI6aE
	Re4TaHRPYNaGKtPJqVN6+DUQh0H2NdaSZlXDlTcvQNR5/kTSmKIfiNK+90WcsCup8ktPbr2rlaa
	NbOhI80SiX+9hekHKsH/3o8pqAhnxwfsiR5pnBw0gNoFBoyxz/WAUPcFFwB34g4Kp2Q3YPYufZh
	kwyxUHshRVmCHuYB26iv07cEnyIAcNg6W5mgRnkowJw4B+5QlU0fLo39HBegRhEZl1uLptDvTmI
	8KaB9wettUw==
X-Received: by 2002:a05:6214:20ef:b0:8ee:f531:4de4 with SMTP id
 6a1803df08f44-90a5dfa37c0mr27777156d6.13.1786372644393; Mon, 10 Aug 2026
 07:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-5-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-5-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:37:13 +0200
X-Gm-Features: AUfX_mwDV5L6hLfp08WK2RA4_U7t0g-kBuPpgpA2dBgLwUCWyqeJ369EboEHc-4
Message-ID: <CAJfpegv2TTEGgfFBvAB1j2ixyEMXruG0AhL=R9iMC-LMJToiAg@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] fsnotify: reduce i_lock hold time in fsnotify_set_children_dentry_flags()
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

> +       /* Find the dentry for inode - there can only be one */
> +       for_each_alias(alias, inode)
> +               break;
> +       dget(alias);

This is __d_find_dir_alias().

Could add a get_dir_alias() primitive that does the i_lock locking as well?

Thanks,
Miklos
