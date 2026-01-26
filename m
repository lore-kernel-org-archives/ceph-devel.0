Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC72877CD
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394470; cv=none; b=PIx2kLP+FsyVYZ2rsMysvHpDYV7egogAyjWttR/qMjKpRZL5nCSk27CsDGQOJB+Y0tVJAyEuSTyLWbldwPwHnHAo5AG+quhTBUslqSkEQtI5JajgzCwIGSq/qo4NjDtrv+n46Oks6NgOhrVVQ2sj5nVJ1a2JQN2xoxuUYjpC8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394470; c=relaxed/simple;
	bh=elLdawZdiNF3T78K+DA6DMPmbUn63JQVKocXOMorMwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3VVW5qt81lU9VRBGXW2R7RQl4OpYytnlVTdj+AN3kVQrgM6E9LndQndid/J0jA+EWQAXJ4bF7CIvOZ+xH9X9B1UTu67fiDySNA/Lskhz/37JchuojA7OxcQo5eRSfSF7G86K/o/S54RJn7nuahmxVeWcsV+E5tQIHBDw+rftSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSPmH/sM; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSPmH/sM"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1233702afd3so5469075c88.0
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jan 2026 18:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394468; x=1769999268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuyRS9NwFd3elvIRvYUasvxQvQ9+X8/Y2dmyuDNlfJI=;
        b=KSPmH/sMAr/HOFG43/OysDUyiVMiYdgbkVnXZKOPH8d7a0c13eW8OeQ70FZe7+lnPE
         X2xVsgTqrz0QWmhQj6gMRK8ipTh2v8zbBEhvDtL3m6b8uQKmR0qEAApsq4CY9UMwEyW6
         McNXdbzayMYeR0mVKUS7vQZvv8DENwON3kwbgQjKHrANXFDwLSKg26Ydl/vWvsJA6gbG
         wYwjbK3ikxsUbDtop2i/EWSpwLCjbk70Wy+lrxEqaTC6wbzTAwZs43fQWgN+xyIDqiuh
         YXBNhSm7RjQcrsxwArChGWdarK2rTRVb+0aLh49p5/gmqYmnM8KCZZ7ZzHhp/6VuS9Vz
         L1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394468; x=1769999268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuyRS9NwFd3elvIRvYUasvxQvQ9+X8/Y2dmyuDNlfJI=;
        b=wWjHFwMIGa7fxj0i8MPyHvK9166KwLBZ8jg8y7/KPNZ8orrGltGlp84YfpQsd6IZtq
         ltrueWwrfA9nXsN/pqN5G6cW8Od3gWUfFrgcYKcKIJGZnwqa4Tq6y8M5+VSaDXJa3PyA
         WWA6TYKBmyceHXrTU2FgRvjs26yjB2Tw8BdhsnfWRKCsnd6be8QlqQ/zdjgx83+x72Vy
         rkLEJ1YJXgi76aJL6hc0A4hrAKuLBFpWOnAul8tOYcRdTy+omwgLF9InIYlDql9YjE1L
         0HU7C+eaHQytu/lWZgiyoVZS6lfkrha61zG2kLEK9pvZ1JPlnw2yJ3v+GwG0Eo6eAfUB
         xuOA==
X-Forwarded-Encrypted: i=1; AJvYcCWvYHkk3ljr7fsyoHHG9qohmxMH5B5j8OYWhtNCnU7apCrzK7tR8KBUpyPxwKA3JDUMNsSlexFCh1ne@vger.kernel.org
X-Gm-Message-State: AOJu0YzzKc5l9Sf2KNfpH8pbfpEGyD0rvGH27D+B/kHvpWzlquNShmOS
	HIZ5JC9GdJ5PPIkB1mEh6I1hq2+XHdgeQfr2Ww6fSrEmj64It4dPXDNj
X-Gm-Gg: AZuq6aJl1ld4uaaBsdboLz0Z3x7y2N9YbkCG9Qi/aYyYpEZUUdTv78kuOr7/8KQRws5
	CmhqKqt/7QwwMQBLZQBmKzjcN19kpgxCPmQlQrgsbAXFBQ5gZsFytruEvi8uxF+Xt/KyAlybKcQ
	OyU2mKvMyXUTukNfQRKnG4u7rXsNGwASpVJoMEjS9WnLsRmtfSGJhH5ytEWvxKZIh7EYV26koLn
	faueBBxeOMQooXJGUEtnROIsu/mvAuIQsmMQH569IRCvy8iEqJG2XuBSOZJpPm3vo1xQTcNE+yU
	/Pk7YidDlXAteP4+GlQWLmOQzx/sTCmEAoWdRZ7tyCTJwpm3doAaSZ2ND01aajmETlVZWR9mfAc
	iphlO9znv4xMguXT++R90yBvaIJiXFnuCGPNxI3J8T+nHeDJAh6wRiPiYFlW1AdSTtnYpk3un5/
	Eb6w1Si/LKsbibG7LQUNqhNbnDgzGx+dxidjE9zduvH7Ai1f0L7Yj3
X-Received: by 2002:a05:7022:497:b0:11d:f44c:ad97 with SMTP id a92af1059eb24-1248ec6916cmr1706255c88.24.1769394467722;
        Sun, 25 Jan 2026 18:27:47 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90cda6sm15266037c88.1.2026.01.25.18.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:27:47 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
Date: Sun, 25 Jan 2026 18:27:14 -0800
Message-ID: <20260126022715.404984-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126022715.404984-1-CFSworks@gmail.com>
References: <20260126022715.404984-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If `locked_pages` is zero, the page array must not be allocated:
ceph_process_folio_batch() uses `locked_pages` to decide when to
allocate `pages`, and redundant allocations trigger
ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
writeback stall) or even a kernel panic. Consequently, the main loop in
ceph_writepages_start() assumes that the lifetime of `pages` is confined
to a single iteration.

The ceph_submit_write() function claims ownership of the page array on
success (it is later freed when the write concludes). But failures only
redirty/unlock the pages and fail to free the array, making the failure
case in ceph_submit_write() fatal.

Free the page array (and reset locked_pages) in ceph_submit_write()'s
error-handling 'if' block so that the caller's invariant (that the array
does not remain in ceph_wbc) is maintained unconditionally, making
failures in ceph_submit_write() recoverable as originally intended.

Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 63b75d214210..c3e0b5b429ea 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1470,6 +1470,14 @@ int ceph_submit_write(struct address_space *mapping,
 			unlock_page(page);
 		}
 
+		if (ceph_wbc->from_pool) {
+			mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
+			ceph_wbc->from_pool = false;
+		} else
+			kfree(ceph_wbc->pages);
+		ceph_wbc->pages = NULL;
+		ceph_wbc->locked_pages = 0;
+
 		ceph_osdc_put_request(req);
 		return -EIO;
 	}
-- 
2.52.0

