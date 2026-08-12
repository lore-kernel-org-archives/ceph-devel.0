Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3C346774
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542148; cv=none; b=uY+Y+ewt68UMN9tLigxIagjNk9mG/i1eHpU8v0gob2A4auyD+2jLxuuqdt5WpLmzC5x+7orLkeCNd+bi3TDHGEMWAIhjCOpfdogDby+FQlAprMLk+cNWEcq/6zCRa3T169TQi25PpFDuBcxD9gzJZx9bh1uBXsLjZrwhFf4ini8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542148; c=relaxed/simple;
	bh=CDQQvaLK0X905Q5fnM6msGZ//V1TAyDh43C1i7OEGzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZG/IsiMZqwxVd2GNyvaeiff95S2CUXyC8eBZRQHY1sxghc/Q7pQmB6CBM0EqgDgxtIfuBa0htDPDh5XkX1KFl1vtbbzzIj652hswINeVDF8WLcXwcRQtiNBddnTxUliQZxNO1HT0oQ70/8sqZCqcrs/v55fM399y+UcP6O9s8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0mBKaK3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxJ/Ym9f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0mBKaK3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxJ/Ym9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786542146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTeXhZC5SrZYzdz0K39sCsKa+xMCLL+wrp9j0g/GgK8=;
	b=Y0mBKaK3M0IurcfqKcrQr2g5wntw3I9jHzni9kj/IYRZdddYUyxQPqE0DupP1YXLCDwRvH
	/pTHrTPKsUD9ERvJN+B9L6TrQvSi6+RhRfGP6mvylUMx0lfDFcKLrDzJgzfN4ImI/ajViM
	ec3kipDErZAMpNJae66t/qnbsUN2dPw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-1CRBf_CSM1yTV_tquwrlOg-1; Wed, 12 Aug 2026 09:42:23 -0400
X-MC-Unique: 1CRBf_CSM1yTV_tquwrlOg-1
X-Mimecast-MFC-AGG-ID: 1CRBf_CSM1yTV_tquwrlOg_1786542142
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1c232fa136so115085466b.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786542141; x=1787146941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UTeXhZC5SrZYzdz0K39sCsKa+xMCLL+wrp9j0g/GgK8=;
        b=dxJ/Ym9fPVDpH/W0arxrWbjNKav3d0+A3xrAGYrjPn0iKw0Z9D52tMj5lXCe/Cif5o
         CJUQFZPZWkrJk03d6OG1D4j4cs+zlgmYofsufnG3ZTEAcyJfHW1qBRT9zfuCxR6qZkDK
         FlcCU2IbV7XswiLQ6dSKVHy40klHld8jvTJDchveYgzraLc4CguG2JV079PdAONC6xcO
         nAfDwqgG2Q3f/+RsoMvYOn2pAVjmyrTlH/W15AotDWwCOGtbCGEvupzMLnfUlzbQtJH2
         BShRrZGYnXVGQfQ2zPVSnXkTk3mBkn6RsBitfzUdUhJGaS+bl3hOUTC/SmiNuMcbnuMl
         rw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542141; x=1787146941;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTeXhZC5SrZYzdz0K39sCsKa+xMCLL+wrp9j0g/GgK8=;
        b=ogJHxpTM2C7kbI8Y0n/SVAyoct5iPrmarUVjnLX5gKd7b1LgiZhibYusH9U4Tio9gn
         TBQg+YNRmdFzO62BstMaY48bFdm/66VH7TDGCgGu9pbF1Gcjg+V6EeC0GqO33zhG7sEL
         gu8i9sqcHYMYimC6YXLiq7kMmKgyYbkcdodnGHWBDsow6Lk6SVTOvELQZjV7Xt+Y/Bc0
         8/opDKyHB4DutmMnhZLfiIZcn6N/mzIryI3VBJ9xLND5Hrg93DcL/xJUKZMIueVWRebn
         v3aD9pwQbYzK/QRVy5h2HsyIwRjpp3Sx7m9ON6prm2wANtFh6dJ3i1BPnyPE9LjO7u14
         1Gsw==
X-Gm-Message-State: AOJu0Ywpp3bRU4b1nBeeL5ajhREoJpA6JknkPMitUBRt5YsZtqIso7ut
	S20f6Iu8thKd+RShDlYKg58WGO27XjJvJQTCqwq9gaBxlvtV3RjJm7d42KYvfPQdfZmDi59IVN0
	EYXj6bLvttcuE0JHKq1649U9eMqKUCXWO90i+vRrOfLdCjfd0a3n/xxxK1lObx1TGfi4ptL5sAA
	==
X-Gm-Gg: AR+sD11sm1m9GQDmXTmW6H0p6E//+rKhU9LfgUtYWV6FHsQZ1HI0ECYJiCicMtFOS1l
	2Xe7NOT9RNIrpwbfKIrbz89VG+2NFGWSvIsg/xfVjqOuCA7oa7J45l1ipZmwjaDbQvtH3oEXrcu
	Y3BDp3OUyZVZ4ExcZ8W/oMH5aQOofId7r1/Uq+OCTPFJv010/LQF2/zJXBQGceAJL7wi+RQfTEP
	tmGMRe9FHV0kPdbfPJC91UgY5lcTg9T+amvxmh2+khF2wMV+/PNk4Qzwy6ydmEea8oemsMI+XDw
	FrdhJvlyp/9Pb8qXlUzuIAjirX/P6bMqPPnp7U/N4ig7Ic4tniePMWLxis5VMOveyeYEsoWd+Ck
	/LqWVEkuupueOVvcgKm/Ev/nu3MY2ajvEfw==
X-Received: by 2002:a17:907:c510:b0:c15:f55d:f0d8 with SMTP id a640c23a62f3a-c20f5080248mr245224066b.4.1786542141536;
        Wed, 12 Aug 2026 06:42:21 -0700 (PDT)
X-Received: by 2002:a17:907:c510:b0:c15:f55d:f0d8 with SMTP id a640c23a62f3a-c20f5080248mr245220466b.4.1786542141150;
        Wed, 12 Aug 2026 06:42:21 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20f0a9d582sm94401366b.37.2026.08.12.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:42:20 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: matthew@bargrove.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: fix leaked inode reference on writeback abort at umount
Date: Wed, 12 Aug 2026 13:42:19 +0000
Message-Id: <20260812134219.3306354-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808101425.49616-1-matthew@bargrove.com>
References: <20260808101425.49616-1-matthew@bargrove.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi matthew,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [major] commit message: Commit message describes a nonexistent redirty mechanism
     The commit message claims `redirty_page_for_writepage()` calls
     `folio_mark_dirty()`, which re-enters `ceph_dirty_folio()` and
     double-increments `i_wrbuffer_ref`. This doesn't happen. The actual
     chain is `redirty_page_for_writepage()` →
     `folio_redirty_for_writepage()` → `filemap_dirty_folio()`, which
     sets PG_dirty directly — it never dispatches through
     `->dirty_folio`, so `ceph_dirty_folio()` is never re-entered. The
     real bug is simpler: the wrbuffer claim (i_wrbuffer_ref,
     snap_context, ihold) is leaked because `writepages_finish()` — the
     only release path — never runs for writes that were never
     submitted. During umount the osd_stopping_blocker keeps failing, so
     the claim stays leaked and the inode can't be evicted.
     Suggested fix: Drop the double-increment theory. Rewrite around the
     actual failure: unsubmitted writes orphan their wrbuffer claim, and
     releasing it before redirtying lets `i_wrbuffer_ref` reach 0 and
     unblocks inode eviction.
  2. [nit] fs/ceph/addr.c:1429: Helper uses page API instead of folio API
     `ceph_undo_wrbuffer_claim()` takes `struct page *` and uses
     `detach_page_private()`, while `ceph_invalidate_folio()` uses
     `folio_detach_private()`. Functionally identical but folio API is
     preferred for new code.
     Suggested fix: Worth converting if respinning anyway, but not a
     blocker.

Code fix is correct but commit message wrongly claims redirty re-enters ceph_dirty_folio(); needs respin with accurate description of the leaked wrbuffer claim.


-- 
Alex Markuze

