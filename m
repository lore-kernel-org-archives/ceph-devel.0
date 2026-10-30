Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793346900;
	b=2ulE8+nJtonu5y5KyuFr2qH47xxdvn4Jm2vLdeqkVqJxwtdAHhGCJicqMN4b7A7/aTyx
	 tJmh5RJ45zLYhogt2sk3Seb2NH4tkSnGQJkqfq0rOAXLA44e8w4mTrLG+CTuTf0MiJMtA
	 cVoEy/22CtfTjWFKwW95ZS2g2ZxXPRdBdEJGpRakVSkZ9bIpyZB7IdUmU/Pejw7gS+nAF
	 RTeUoUeMAtkKMulatfQUpsf6lrnF8SyfJXqM2Oir7CaZ1XkCDafxL22uomgf27+VsnPn+
	 MZebAKCK3ZvG/cUg5PnbrX+pdFiopfIjjaCB+5Obn7o9jqqV6IEiF6LX7v71ql/tIog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jtaaIcAIydXlXOXw1jzOh056nqIYk2N51HGIAEOOFM8=;
	b=AKovRp0IKFYrA5d9yUP4bBYsw5xo28ZPg03WsRSdMYVIqRnUCTBxRKJYvaV4x38Ki5Gc
	 Cnnv9/HTCpWNz8Ioq6DN7EyyYZH7jUtJVUA4prFRtQyeJh3uExCui/t063+wu7qMu9sfh
	 TdUMClFpQJX7C3YMbLhhGKx9G9nHioev9mQK7kgWrZv5ZYx8AYy87vm2OnfGjI/7n4xdm
	 hnbKVpOg5P29whWIu9tq1dLA4M4WGNOw8GmEcdhWHHMI7X1zlPR0vTDFFP1pnALFiZ7PH
	 vpQuG7fX3rGOnFuDKEgySMA0ZZ2s4LHEqsH2bXoAVre8x6Ssugyt3gTCdJDGuuDebxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=nq5E0qRM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9420606A31A
	for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2026 07:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9420606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=nq5E0qRM
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so550790a12.2
        for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2026 00:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793346897; cv=none;
        d=google.com; s=arc-20260327;
        b=ExnBVy0VSBD0nyocQXDbr9SIMNIr0RBJUu4OCmwul5u/56EdpLQRfMZCSmWV7NbjLe
         Iark8TPBFPKZ+968gT23Q9XAtERq/P91eSJF5x6ZhPYsxTf+0Z0QP4b32Y3Fi4tPojae
         bzmhJ9pGs+wr0E+QT8UC0IfcdvkyrZ+HdkCmyg/3aPEHF/3vaFJ56XJxYYANqKzJpH2L
         4qQQQM/l/9BBkDmelRcRtKg69zIID5+hLLNIShqFUyK74f7bvrt3XLnOwR6gdFFFiJG/
         kLbfpZWN2tDTF1/PdM3NCNQFegkRXv/ksm8k8Y1U71CtJwD3Akp3E9FC08CTXpHYXnaD
         wr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jtaaIcAIydXlXOXw1jzOh056nqIYk2N51HGIAEOOFM8=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=I2zHn95vVYXtVksgRS6C3nJ2fv5bzL1vZfBasWhGzX3lrpuOq3u5Y6Y7qTFErunVdL
         ajlF6pzYOlBd7pzbj84/vsGy3Amy+A84tN93CsVumC6aK83rfh1TdM49FKtftk8Id+49
         2+0x+sPyTwvDsamNUwKcM++gLJEFmOn7IqqdRWeRepy4VLOPefI4uhlmtrKVX90+wSef
         mvPszIhJ7tEj2alGVUtaF+l9u0KyXpUDqLqQugy8cOHv06ImTGB7yLT/EUIjA3l0xFwj
         oRYcQpQzzEeZ4AnmjE09luRjiNZQ73dAsEU6bfrz0WVO2Bveu+Ma+4KQS0WAi/Pkazfs
         meQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1793346897; x=1793951697; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtaaIcAIydXlXOXw1jzOh056nqIYk2N51HGIAEOOFM8=;
        b=nq5E0qRMbmmMk63rqTbtVG3scWeMGZtjnSBUrSr+H0EzoWy0dgICSdnI0eOLr9IE/g
         xh44gF9s5sVL2Hbxs5H/ZUeJce0FeAMr7pzl6P3594tVfb/45UH1spW2HTYIbvgrn53m
         oz/DY93cPfKkHjzkyWF6vjqcI9Z6PGOVrUGwMqXU0YcQnnjSpE4oSVFcywwUXnKBb8B1
         VIK7YJdwXlBqsXCHAw7OJGTGsHKGskPwxTThWfuIhmwcN3nFurELP30CJAbEYVPH3LJk
         A0Tu5CKvTAQ8IJwHMC843BNVpjL/h73+GPuB8eV0KsqWCB7ETNSRPOuwLuppnCPQrERS
         wmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793346897; x=1793951697;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jtaaIcAIydXlXOXw1jzOh056nqIYk2N51HGIAEOOFM8=;
        b=hqU8nBDNLOZrK/9/XbcipE9NwueobOsNZ/QCa478KALnk3L/4th/mMHlkTyuni0S5X
         rB5sFLVoPgZzllt4t/EAMcXRupqzCieqZNOP24TdETLrkT+VbSDHJmaF/ki/TywYd6rU
         7A3+neeyXyzOJ4lO/mQ8W/maxMqsBPuD08PagFaIgrWcZFcO9blxYmhjk5VZA0Kmshij
         vc5BG/3xwuvcIN3GqYmu8l14H+is+h5eQkcXGgAjqd3uo52ZY+gCkW2DmVSz5Kln4Djs
         SZpVBCKqQM9YP3O46qBNXwiwjociP8X5j+SuDml/KjCfzDuBO3CFGZRRIe16gYmaJK5O
         Ni7w==
X-Gm-Message-State: AFq9FYKdRkzcMnQxs2OOxK/amhzgFyhUPia+aSiuJssndHUikQjOMdZ2
	qSX88ByShuR6nDkGakGRBX989NFYzxJL4TNCJsXAwTDTB4E62pRVbPWvwpDAH3PXtevI6f4ehd8
	jhCjyd6bskRS3bpL2dFaYziVKb14XTLs9pN31IEklIA==
X-Gm-Gg: AYBFou1Z1TvG8zDvU/VlcwQ4Wwou4M2S76jxrTMenovSZnk+NS5u+QZ/hmgQBSiIqY9
	yKxtztPLIzhL9M/0vvv7OWw3knXDy6skoYN/XchR72WeMT46OaBQIsKqCDl0D4iePPJBASKza5b
	LNwfKoNcT4T6jdNLmkHCNomoxS36rXQkx6hNO6003c4dbaCO5Re2jCDf5ke/hyxfraLUdDsRhH3
	S4DsyzlsdFMIgdb3jA2rmQS35WmgBuSh8VvDnsStMuKLEEMrRfUCS2z0OYkYKK/CgyWO4wxMVu8
	0KyEFN8ftpOV2KLsk3iuFZATzGOMt5icQA/T2WWjkXHl8AMAxYG8tMysVBINCdbe0AxQHaUMDZo
	Rz/QfLSZu6xqDlg9MnvB/f+tALYy6NHWydIkKG1A=
X-Received: by 2002:a17:907:6e8a:b0:c3f:d912:ff8e with SMTP id
 a640c23a62f3a-c4ca7a15d8bmr121492466b.16.1793346897022; Fri, 30 Oct 2026
 00:54:57 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
 <20261027-b4-wip-ceph-lazyio-fix-v3-3-df2926c30867@clyso.com> <179320481135.91990.18372101872369607474.ceph-lazyio-v3-nack@redhat.com>
In-Reply-To: <179320481135.91990.18372101872369607474.ceph-lazyio-v3-nack@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 30 Oct 2026 08:54:44 +0100
X-Gm-Features: AclHuK97HdXvF7XLr3WUvukcp2D-enZAzFgHWiQbie0aOpajwzurvoQaEV6CLIg
Message-ID: <CAOJNxR+w_MsnoFz1wJdigriJyhwzkJyBjHoaN2Uap-er2V3MuQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ceph: write back only the dirty bytes of a lazy
 I/O write
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thanks, both are real and both reproduce.

1. v3 checked for the pin after folio_mark_dirty(), so an unpin in
   between skipped the folio and was gone before the check.  With a
   test-only delay in that window, v3 loses the pinned bytes.  v4
   checks before dirtying the folio, with the folio locked, so an unpin
   either still holds the pin or has already dirtied the folio whole.

2. The unaligned cache write fails with -ENOBUFS, which is ignored, and
   a read on the same fd returns the old byte.  v4 keeps the OSD write
   to the dirty range but rounds the cache write down to the page, so
   the cache gets whole pages as before.  The cache only serves this
   client and is invalidated with its page cache.

Both tests fail 3 of 3 on v3 and pass 3 of 3 on v4. I will send the v4 later.

Thanks,
Xiubo

On Wed, 28 Oct 2026 at 17:29, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> NACK for v3 as it stands. Patch 3 still has a lost-write race, and its
> partial writeback can leave stale FS-Cache data readable.
>
> The pin check protects a pin that remains held through the check, but
> there is a release window. A process_vm_writev() pin can survive an
> initial writeback that cleans and write-protects the shared PTE. After a
> later lazy pwrite() marks the folio dirty, the pin holder can finish its
> copy outside the pwrite range and unpin before ceph_folio_note_write().
> unpin_user_pages_dirty_lock() sees the folio already dirty and skips both
> locking and re-dirtying it. The pin check then sees no pin and records
> only the pwrite range. The pinned copy uses a kernel mapping, so it does
> not dirty the already-clean userspace PTE. With no later store through
> the shared mapping, the next writeback need not widen the range, and a
> successful fsync can omit the completed process_vm_writev() bytes.
>
> With lazyio,fsc and a populated active cache extent, an overwrite at page
> offset +1 passes that unaligned start to FS-Cache. CacheFiles rejects it
> with -ENOBUFS before updating the extent, and
> ceph_fscache_write_terminated() explicitly ignores that error. OSD
> writeback can succeed while the old cache data survives. With CACHE
> retained, evicting the clean folio and reading again on the same open fd
> can return the old byte. Marking the cache object LOCAL_WRITE does not
> invalidate its active data. The rejected update needs to leave the old
> extent unreadable, without widening the OSD write to stale neighbours.
>
> These findings are from source inspection, not runtime reproductions.
> Could you address them in v4?
>
> --
> Alex Markuze
>
