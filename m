Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36453C9456
	for <ceph-devel@vger.kernel.org>; Sun, 11 Oct 2026 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791696595; cv=none; b=B6QSPne8HdJQZqw0dRvyXLnMY/6mSlUJHuaZcui9RNhVQwd87lR+7575ieQIBLH6Mn36PXu1vSBFdQeadv2mHuE0lG9dZ/MiS0JQNdVqNZq1w7MaeMT5xQHrLA3tU4iEw/7r+OOaGyC3f5FMJ+cVuUjjVS74mMxP2OMa0lIl3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791696595; c=relaxed/simple;
	bh=1haV4dNMWDdQWqZsUuA0TFAZtQMdcpLXPmSnhiji0ao=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=uPyiX0RYcdQe7v9Hwq1SRHNoIKOcCUa22e7aUOGAFqWKNOm6BUqejwdF5t8oIp6mwVa45ZeBokndgB9i7ALAOkUc1juid4rNepjijq8QTqQ1UAx/B+HXe7MoIfYf1ne4KNzxj2gXFWZ5SnjH3fsb/XgQe1TbDmUBmi+LLSFPz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com; spf=pass smtp.mailfrom=innovatrics.com; dkim=pass (1024-bit key) header.d=innovatrics.com header.i=@innovatrics.com header.b=sG+ClBZE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=innovatrics.com header.i=@innovatrics.com header.b="sG+ClBZE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a166199820so5244335e9.1
        for <ceph-devel@vger.kernel.org>; Sat, 10 Oct 2026 22:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innovatrics.com; s=google; t=1791696592; x=1792301392; darn=vger.kernel.org;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2LSr6tsQNBQXJylfG8nOPgyPFtDzDbVgLjnyN+NvOY=;
        b=sG+ClBZEZshyYL12WpUA8gi5U4p3Lf2TUW5h8eG3RZVknGgosp9xUBym2Jg7on3Bti
         u3YWy87k/lf3MT3ptjbhL28yBia/RGwBWim2B6spsjnWSKbqf/PRWIODLjHoWquV6rf6
         lWE+oxJb1L+70J2GVpC844oToN87Xc7V4+zzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791696592; x=1792301392;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q2LSr6tsQNBQXJylfG8nOPgyPFtDzDbVgLjnyN+NvOY=;
        b=gl8WHtO+KhUZbz92Y9V7rr7UY1lkPXYIvUJQt9CCzaN1HNy/NLgqj2R2JAt1VZe3M5
         hBE3UwqRkWorAAnu/OIjTaxby++gU+7fqv6N69ZpP29uij6lxPhX0POqhGiWSMDKQRuJ
         aiSeLn3tee+b8qNVoAlUOYWsGFBy4NYxXYsJvMUBDVXkNWbF16t6qUGZYrmbw994SSgg
         RLyQ81xoosjyBTNDZh3ZkYgsbM60aVBVCKMeVqcAv1Js5kMF8e7ME3Po6mglS3SYfrkN
         Hj+nWrt3XXdJk+nIkKysTxIQUuZytakRYpvGYuJXb3ToJgQjqNZGuphm7QNjexOv+HcT
         sjCA==
X-Forwarded-Encrypted: i=1; AKwUvBz3PR1MIXxOd2vat8H4Ux2qPatpzP7Aw+W2NQpfpndntXlGV5JoQnJLzmO9sI6hnGpcbJqr61VGBMcX@vger.kernel.org
X-Gm-Message-State: AFq9FYL/b2hFf35ffd/ihyy7kN+/IC7VFwd9ba2Vr/gH47CHsyor4LUu
	e39gPB4iqSH79fTDO2gywDsYBB24lHUV95vWFPjmqKqM7UQnZjmWk2dgszTv3hb34w==
X-Gm-Gg: AYBFou2AMBShVYErt1otXVV5/3FdpHh/KkOqAOMlYc5NbHCxweCpEVvSgVxbJ7n2FAB
	oZg93/OukAYo64PmQ8CxkA9T2W0BLGXaINUoLRS7tKtZ5IC6S0/WscexISez+Z00rXNNzZJtFpo
	KQGiLtNuqzhlglzhF4umANNfPYOydgTD4J+6SokdsshQQ1Jocc9pDd+NcenU+YFkjUNrGUmDYBG
	2N8V3o37k67PTvP+24bX1yGBfVdSyFHDNBtTLTkAdQROQzvhkWSEIOqmeUtnskUV7omnEdYCaCv
	Mvp2VWOFE4mAoTA9rdyK1eENHFJvwfcZeDe7Phn4oS9VOYQVrwJ91fndbkxWsJ6/7t4O1h5DtoO
	Vs2lvTfs09MMsK27QlHfAAXVU9HQZeSxjMWX9HwHgbDfNmEtdu5dmngpU8EP+asbvSKOm3syBZc
	dbvkjj9bIQLwoIKmi9csN+UQGCnCGLPQkF3/kveFk1GCm6sOeCuOzsZRziKU7JMYNTLtuL/5xx6
	ZaxDfvfH35F8cy0Yoip+Yff/tEtovd15AGlCtdT2zS8UdAXhU0KkkEbCaaS1C/53GCUUtyYkNlt
	sMXEzU+U/yXGIjFDf9oIOziD0O9SeHg=
X-Received: by 2002:a05:600c:3146:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a18e4a7cb9mr117216165e9.14.1791696591843;
        Sat, 10 Oct 2026 22:29:51 -0700 (PDT)
Received: from [10.11.72.5] (bip-static-148.213-81-147.telecom.sk. [213.81.147.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm277235065e9.9.2026.10.10.22.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 22:29:51 -0700 (PDT)
From: Petr Chmelar <petr.chmelar@innovatrics.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    netfs@lists.linux.dev,
    linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 0/5] netfs, cachefiles: Changes for next, primarily
 occupancy tracking-related
Message-ID: <20261011.cachefiles-seek-hole-walk.pchmelar@innovatrics.com>
In-Reply-To: <20260910220242.2165023-1-dhowells@redhat.com>
References: <20260910220242.2165023-1-dhowells@redhat.com>
Date: Sun, 11 Oct 2026 05:29:50 +0000
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"

Hi David,

The cover letter leaves non-contiguous objects, which still use
SEEK_DATA/SEEK_HOLE, for a later series.  We hit that case badly in
production, so here are numbers in case they help with its priority.

Objects get into that state when a large file is read at random
offsets, as training jobs do with data sets on NFS.  Each read is
copied to the cache at its own offset, and with other files being
cached at the same time most pieces end up in separate XFS extents.  The
object is BACKFS_MAP from the first discontiguous write and stays so
once it has filled in.

SEEK_HOLE has no upper bound.  On XFS, iomap_seek_hole() calls
xfs_seek_iomap_begin() once per extent until it finds a hole, and in a
fully populated object the only hole is EOF.  cachefiles probes the
occupancy at least once per read request, so a sequential read of such
an object walks the rest of its extent list for every readahead batch.

On our NFS clients (Ubuntu, v6.8, cache on XFS), a sequential read of a
fully cached 184 GB object with 1,080,732 extents ran at 0.4 MB/s.  In
a 15 s trace of one of the affected readers, each SEEK_HOLE took 64 ms
to 1 s, XFS did 58.5 million extent lookups, and nothing was read from
the server.  After xfs_fsr brought the object down to a few hundred
extents, a traced read of it ran at 369 MB/s from the cache.  On
another machine, v6.14 does the same walk at about 220 ns per extent,
against 520 ns on v6.8.

It's the same on vfs-7.4.netfs (9f8b64f66).  In QEMU (TCG, 4 vCPUs),
over an NFSv4.2 loopback mount with fsc and the cache on XFS, a 1 GiB
object filled by random 64 KiB reads, while a second file is filled
the same way, ends up with about 16,300 extents.  A sequential read of
it after dropping the page cache makes 4,098 SEEK_HOLE calls that take
176 s in total, and runs at 4.3 MiB/s.

To confirm that the walk is the whole problem, I wrote a naive
workaround with LLM assistance.  I don't know the cachefiles and netfs
internals well, so take it as a probe rather than a proposal:

 - Each cachefiles_object remembers the last region that SEEK_DATA/
   SEEK_HOLE found to be contiguous data.  cachefiles_query_occupancy()
   answers a query that starts inside that region without seeking, and
   overlapping or abutting regions merge.  A sequential read then pays
   for one walk instead of one per request.

 - The region is forgotten after every place where cachefiles removes
   data from a backing file: the punch on low space in
   __cachefiles_prepare_write(), the padding clear and the truncation in
   cachefiles_collect_write(), cachefiles_shorten_object() and
   invalidation.  A sequence number sampled before the seeks stops a
   query that raced with a removal from recording what it saw, and
   cookie->inval_counter ties the region to the backing file.

In the same test, the workaround makes one SEEK_HOLE call taking 61 ms,
and the read runs at 17 MiB/s.  A debug build that checked every
remembered answer against a fresh SEEK_DATA/SEEK_HOLE saw no mismatch in
more than 7,000 checks over NFS and 9p.  It only helps fully or mostly
populated objects read in order; random reads of a partly cached object
still seek.

I expect the right fix is for cachefiles to track what it has written
itself, as CONTENT_ALL now does for contiguous files, rather than
something like the above.  I can send the workaround if it's useful as
a reference, and I'm happy to test whatever you plan for this case on
our workload.

While testing it I hit a data corruption on partly cached objects that
bisects to patch 4/5 of this series and reproduces without the
workaround; I've reported it in a reply to that patch:

  https://lore.kernel.org/r/20261011.cachefiles-partial-zeros.pchmelar@innovatrics.com

The numbers on vfs-7.4.netfs and the debug cross-check were also
produced with LLM assistance.

Thanks,
Petr
