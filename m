Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0537646C
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050586; cv=none; b=Bwfxm03noQ7zVQMLc6dtNwWvHZrsM32A2xtUoncL8556URic6Ph/1aNyuJM0IT+2uXHciVHr9uNHEPgZP8TRrbWCRokdUibFgu/zkyXtQEUvmcgZeoMJvwQ+KHtAk6+UJWDOMwTS4Qy7yVwQ3bBKG3LfkYMear4R1b73gd9PtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050586; c=relaxed/simple;
	bh=JDLbvCKUB+a+IDR0laoJE09QGbcCCmet6VJT4AONztI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR2tqpvOsVb8Tob6ALPSZb4fTb7FJSgiwM55nXa5f1h/PFmNfxGPWElOZiCAgMcM5I5gXlro9pWaS5EQon4tLFe87eTzN3D4Ss3SVnlxoHgr0hrogwWFXWbGZqjkbEOXpNnCg5Y4BoR/vyA9yMrZx50HK8E8CbeAEyr+m9k0SPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbWgsdWy; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbWgsdWy"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-39e59dca659so2252827a91.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2026 21:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790050583; x=1790655383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDLbvCKUB+a+IDR0laoJE09QGbcCCmet6VJT4AONztI=;
        b=qbWgsdWy4wdLIEntA0/FpNsZf7horCJWmJzWBillIAs0GNxkhMLlgvtcqJOfsqP1ws
         Ng/wonxycsF2AqEW3RyNeklKNgPvdiCOC0wbLjzW/qAa+hOvVPhprZcKvZDrpkQbIEd1
         PaR8KMFKjE3Nruixg4Lz4i/TxjIz73YN01CYbAC4efeboklUI7kSWoH4mp8mOTqYT0FC
         fXuHHp6NnkCA+wgOViuzh8WF8Dqk3OdsJeLQnlIeVZ10z/RmuWQ2REFZYvm6xCFxoRKY
         RqxUhWWK8VvKp3nmjYU9Q/tkXcDNplAeKAbNIUbSyfn7bCc8LmQfDrEkLWQtEPOXNE5B
         KuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790050583; x=1790655383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDLbvCKUB+a+IDR0laoJE09QGbcCCmet6VJT4AONztI=;
        b=1UYbBGOaeZcv9HwFBCniNfEOgTcWE3Ehzqw6K+br4t6FMc9nI2BJihTzrASZ/lwVCP
         EIUrgTibhnFdJDpHK1ZxmFya+PV91gbZAoRgJ5bBbmJj+FvLD284jj63KM34cMmdNKxM
         pC1RTLGd3hahra0s9j3Gp6rpF6JwM7qxUeONzxfXTFx47h/kcXp8+2ou11lAcyrA24NC
         F3zJn/cZR5Fdc8M5XtNKgTGeB1wapW6KV4LyunbMohO0JKuFcYKmgaxwb90s/B6bWe0r
         TUw//PeVmIAeBgj+Ef8CKsWffRs4TrJQJll6sqwzZ7wB+oX/tOIqCLAqWrDHK79YNChX
         t6WA==
X-Forwarded-Encrypted: i=1; AKwUvBxtxI2IOomYQf/jX5kffw41DtH2JnYnVjTnmDIrPiwruorIyiJjAaQvknaVkq6fnkmqkHN1R8Hfrb/r@vger.kernel.org
X-Gm-Message-State: AFuF++kiyUHM7sHraEEYitx7PTNrp7wmOtmYhXVvxFTHUbsUXPT45Iq4
	MZ8rF8banPj87EAaQlvGWnjlT61n244ikVH5NvGbvJdy70KKvONcCBuS
X-Gm-Gg: AYBFou1CL747J9HIrAIsJ9eI+HTdgwcHDb2y3C8ob17ZMm3TbQTD9XlamT94SlYCT5j
	Nc0zLYP7yy3eJ4NEPNJOe6bMvM91IJesWz70E5UsBZS9OvE9kXIujmBo3n/p/Au/miFG7npPp+r
	T4RXpetJ7NOBpuBdvs0skutzcc/qHgecRNtyvxjhmytgBUPrxKYVaqzp/8uL4ZtTxlNiHc/+qBT
	mSAzeO/pICxa27xRnf8KUBA6cYZqTPmS/pPuZ1OZ7+fVsEfqI7VaFcGwLohWWZOvXa5Ppjj9eL/
	Ffq7uJ5IRa3moMlaZJ9NZAAg8hrcmZwH6DbATpOgPbfK8y+m7NWTR53soiGPML6ZlyAStGOH2PY
	yS90onpvSfdjmKsEGLj1KeAVj7niXZgnoQqSuu9CG60c8kI045FNccjjn7M2Q0OCQ67MW0lYQlp
	QJFMy+vumLn3hE63wPo5ziP7V6qmdHLqfy/SdEnM9GiuHLEIqWlmNNw4YAQHasvCzE+pEylAz6x
	mrH5LW/0kNsl9dPsRiKrga5bK2KFG+aiAi7
X-Received: by 2002:a17:90b:56c5:b0:39d:f95d:bd08 with SMTP id 98e67ed59e1d1-39e55008a3amr25857593a91.14.1790050583196;
        Mon, 21 Sep 2026 21:16:23 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674d65d4sm2204031a91.15.2026.09.21.21.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:16:22 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-doc@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	kexec@lists.infradead.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <ruirui.yang@linux.dev>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mm@kvack.org,
	Hongbo Li <hongbohbli@tencent.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tal Zussman <tz2294@columbia.edu>,
	Baoquan He <baoquan.he@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Anna Schumaker <anna@kernel.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	x86@kernel.org,
	ceph-devel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Wei Xu <weixugc@google.com>,
	xen-devel@lists.xenproject.org,
	Gao Xiang <xiang@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-mtd@lists.infradead.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Juergen Gross <jgross@suse.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	linux-nfs@vger.kernel.org,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-perf-users@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Trond Myklebust <trondmy@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daeho43@gmail.com>
Subject: Re: [PATCH v5 00/17] Remove PG_private by using page/folio->private checks instead
Date: Tue, 22 Sep 2026 12:16:00 +0800
Message-ID: <20260922041600.1240429-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zi Yan,

Thanks for the series. The cleanup is a nice help for the f2fs
large-folio work -- it removes the page-based private-flag plumbing that
my series would otherwise have to carry itself.

My large-folio series v2 [1] can be rebased on top of this series. The
only overlap is the PAGE_PRIVATE_* flag helpers, which I can re-express
on top of the F2FS_FOLIO_PRIVATE_* names while keeping the
f2fs_folio_state indirection.

Jaegeuk, do you have a preference on the ordering here? My personal
suggestion would be to review and merge this series first, and I'll
rebase on top of it.

[1] https://lore.kernel.org/linux-f2fs-devel/20260915041909.2903887-1-zhaonanzhe@xiaomi.com/

Thanks,
Nanzhe
