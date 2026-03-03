Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594A4D2EFB
	for <ceph-devel@vger.kernel.org>; Tue,  3 Mar 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554673; cv=pass; b=oqFabMUQ2riU1td6j+S0XFlU2Rn1iNziLATDKHegEFs5C2oJwqJBx7Gf7a5T6xdotBfz3CqrVsE5bIjkU/hODc8TstTx9p9I/sUJ3ueIfuZRP/4jyxit+ILMgI8aL6olavlYYlH0dVdBvmeVGx3bbgdfdyoApF0oHgpMq0coTbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554673; c=relaxed/simple;
	bh=D31bfjZSP/L0HElgbPJEOIXXw9PZR2MgXoaqrLT9Rqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtXfpxUHqYcJpC4YXGJiOsYVm6TZeSFc8gt/bRJ4U+DaAbU/saFtkcamC/zF3EHxwlY6gN/2VwX5cglumrO750eXf0Le1lp8uwd9cZykAx1QUB/oM9bbnTfAgdWCWzx7VEIIzPrVCZzT08jBjIBKVRo6vw2xefkyNjlGX7Xg6B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AwjiNWln; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AwjiNWln"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824a3509a12so2686384b3a.2
        for <ceph-devel@vger.kernel.org>; Tue, 03 Mar 2026 08:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772554668; cv=none;
        d=google.com; s=arc-20240605;
        b=JEQg6h79Id0oQ6Ses+KyHFx4ryv4bdQ5JiQv+/Xj3/kl7ovflB8q4S7lky0W1AhhvM
         Mq0Y0RGVs0FsYISXpKtnqmhFMeLkdUxip2Hfqpxfwta06GpHx4fYdi4llMqyEd0o+0et
         HE0kH6Tl2Xxb8gdEGRtnJODv0dWamIhbitapxu7LmOpG5WDWY8PKBAzI5hrQbBXbnP8u
         ZJlq/nfKgSSu7aN8aIlqASYDjoX61d6QfEkr7XwP9qx6nQUikcNp3V+coZ51bH+MPujz
         cG/RWP4f/5HWNSVSEKPFaHA/ZxE0/XuA4prQDdkUP5LPjQ1BwyMb0iKMIzOutaHHK/VO
         /tvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
        fh=IQCoRrLPfyCaUfDKNx+6kpd6uIoM5eUtE3CJDlFLboY=;
        b=fL7oL3ByEiW9AGaNoyK634KWHoEFDcei16YYLgKfuv36yNZN/emu+GBZ2T2HvlHUhb
         pMgea0BkY2eN+TX7mdlx5Q5dRBPtsYKStI0YpKAxZYruwQ18HPoW7Rn/c1zR/Q+C/Hms
         X8TniscLtBfmPvLmdI9Nezn3D+MwlQUq7UomKkF5sC1F4KMjpYYbTiP/waGyB1mb3+FW
         K7vkL4U8DW3GNEJuG9Aba9l3llQwmvaUVDxBRi3BPY7Tz0GDyMUju6NGw5qi8YG9rJ41
         /9GVAjP/uQw0ykL88p06na1FGF2l1LM3gDZz2r7aoPmWGX8FPwnE0cFqT04WXlo1ly5V
         pWHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772554668; x=1773159468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
        b=AwjiNWln5JR6BxSrUTDTHA+0IzNH6y/wDyQd8wA8GmdtuWg0T7RL0eJsZE/3cD7JTN
         J+fLhSw6cPUycqgFu+Q+/ajM7Sji9fBJ6gnOrRT/Q+DNeGveICu3p2iA2h+bvcTk+GxF
         /XoXg8WhQpUAUJIVoH0tjyBT4Mi8qy90ohn7q6lOW9FLjyXLXB0q6aBZ6q0wprJV1GPR
         l4JDkYfvmZkRb++O8RFLWEKuhno69fazyKkVXzVUU6RSzmGNni/ji6h3OTvSd+Jw9IhG
         AjnormoIAmc8F7TR4h6EwKoARQfPCyOSvgMgqLHIlMLTs/a79zkB4RSFwd61MxtDZzz9
         yJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772554668; x=1773159468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
        b=WwH2vLeffY/lmPo6f8uDKEb3EUQ7mlZuXI+XE/SvneWNmQ8wW8TQKZXn30mDzaIyoU
         mr8lSbR5uUj/6HgfjxkecRzW0jEqm9/fSSKpVkMxL1PHGpw0MNCACs0oJOLvIvUatFMS
         PW+m9DI20ErzMGlul0AWK1vyKcRGuzew5+38oHVM0izDepwYAegRPbIA99Vmm0LfzmCc
         doVizm3VpEetbHeH+tMQ1j3ybqvEDUEbPFj7EN2hbLbrswFb9+i3dxKXP9o2ScQDQ9cs
         gfYj6IeKQ0m9rWNgquljJesMhvB1ejuF4KT2U/j9zvuVGWk1xZSP6hWOIYYo+d8OnE+Z
         i4KA==
X-Forwarded-Encrypted: i=1; AJvYcCWr/u+H+OY61irN8GOnHpqGZpA7JIdh3ufT/Gs7WBH/4/4DdH+kiElkKDyFg/Deo5vNya9SuG8TNiNZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGKp/r9Atf/wpuuI0IXMY7nYaM+OI5/r4UZYRh21cOijDA8/K
	mOk4f62zMmTtxbgErwuRJ+UrF9sK5mYgSjC6sKK1gRMZLtWEu6zxmZ7HgXGwD9eqg4DeoySpKJK
	FzgXGbLRsfXkuv4aecPV8Sz9Wl5dIPnCz6tLYBZKb
X-Gm-Gg: ATEYQzxIzJzH8qxw/D4k7gIu1ltMCg1tywvbJ7AEiw6BJj28N+Xu6KenbWjyyYUotaa
	dbO6pK/wGAToyigmqe/FyFR+RQ+C73091Ep3/ivJZs/MWwl4anTXmZ/eZ2Kzy6cVRWAgtyTwqTj
	zl1M6qf55r219jhhAGCA46XG8EyfCGaQUqq+7M4dmUEnBytHeE2NgV75WyQytkNIbwgiEHZ6ZHM
	zLxGJbz7tIneJdr5FyFr6eRmzdfbh4mFkpNjKvjiy3Rg2Q17IfV84/XNxorvXD6SIIgjZhh6fVu
	37wFCgU=
X-Received: by 2002:a17:90b:4c12:b0:359:8d70:c4e6 with SMTP id
 98e67ed59e1d1-3598d70c5admr5344309a91.1.1772554667658; Tue, 03 Mar 2026
 08:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-3-e5388800dae0@kernel.org> <CAHC9VhRnmBuXEKkUPQhJ_LDzcksjoAJL-ne6mFoJdR1hnDdzsg@mail.gmail.com>
 <7a0165fe39e82a1effd8cce5c2c4e82d6a42cb3a.camel@kernel.org>
 <CAHC9VhTyhnG7-ojnTnVdh_m1x=rKxw9YEH9g7Xp9m4F78aA5cA@mail.gmail.com> <add39953250a4a1b2fe2b09deb3373c2a7482b88.camel@kernel.org>
In-Reply-To: <add39953250a4a1b2fe2b09deb3373c2a7482b88.camel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Mar 2026 11:17:34 -0500
X-Gm-Features: AaiRm503AvilRZsmzje3hsLVwZQN2UeIDoaYrT0wwtgoCj-_LcRzyWRvZdGrFAo
Message-ID: <CAHC9VhSb3nAsJBxhqitDVQw=J8hX1CJDe1xqL-JMjOA5J4tUkw@mail.gmail.com>
Subject: Re: [PATCH v2 003/110] audit: widen ino fields to u64
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org, audit@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:12=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Tue, 2026-03-03 at 11:03 -0500, Paul Moore wrote:
> > On Tue, Mar 3, 2026 at 6:05=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > On Mon, 2026-03-02 at 18:44 -0500, Paul Moore wrote:
> > > > On Mon, Mar 2, 2026 at 3:25=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > > >
> > > > > inode->i_ino is being widened from unsigned long to u64. The audi=
t
> > > > > subsystem uses unsigned long ino in struct fields, function param=
eters,
> > > > > and local variables that store inode numbers from arbitrary files=
ystems.
> > > > > On 32-bit platforms this truncates inode numbers that exceed 32 b=
its,
> > > > > which will cause incorrect audit log entries and broken watch/mar=
k
> > > > > comparisons.
> > > > >
> > > > > Widen all audit ino fields, parameters, and locals to u64, and up=
date
> > > > > the inode format string from %lu to %llu to match.
> > > > >
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  include/linux/audit.h   | 2 +-
> > > > >  kernel/audit.h          | 9 ++++-----
> > > > >  kernel/audit_fsnotify.c | 4 ++--
> > > > >  kernel/audit_watch.c    | 8 ++++----
> > > > >  kernel/auditsc.c        | 2 +-
> > > > >  5 files changed, 12 insertions(+), 13 deletions(-)
> > > >
> > > > We should also update audit_hash_ino() in kernel/audit.h.  It is a
> > > > *very* basic hash function, so I think leaving the function as-is a=
nd
> > > > just changing the inode parameter from u32 to u64 should be fine.
> >
> > ...
> >
> > > It doesn't look like changing the argument type will make any materia=
l
> > > difference. Given that it should still work without that change, can =
we
> > > leave this cleanup for you to do in a follow-on patchset?
> >
> > I would prefer if you made the change as part of the patch, mainly to
> > keep a patch record of this being related.
>
> Ok, I'll see about factoring that in.

Thanks.

> > Ideally I'd really like to see kino_t used in the audit code instead
> > of u64, but perhaps that is done in a later patch that I didn't see.
>
> I think I didn't make this clear enough in the cover letter, but kino_t
> is removed at the end of the series. It's just there to support the
> change during the interim.

Ah, gotcha, thanks for the education :)

> If HCH gets his way to do the changes as one big patch, it'll go away
> entirely.

--=20
paul-moore.com
