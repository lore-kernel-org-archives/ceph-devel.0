Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518F1A23B6
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394667; cv=none; b=oLm7Inldu4JenZpu6o9l86jyEZ7SpTJqWtmO5vPCgppDVR6PUN8YALh7J6IXv7ozGZ/K7Et8A6UUBnC2qETfaL/N7n6NRS7NV1/ayWqz8iltntykspoWtcY66aH42hOZmsHJEDiwM4/7NkTf3ly3Ox7NTeSJ8xsCLNXeHgFPpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394667; c=relaxed/simple;
	bh=mrQWcprsJ7tXA+6MiR721zXu/D/Xf6tHUu5xYUHWluk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvpZXQLA84YChjufo14tC8xPdtYpB91Ql1Y0D6HYVXc51/4RVrYrY6ahbwFE+Q88kS9XExIOMJeH3ecSAV/b5ZSxVcXvJXP7vajlZ9m44bNvAfiam4NlADl88g/z5T067kn0A3p1Yn4f6DqWfxkC59mgtrtQAkQe7HYFgLozhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNWNF8pE; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNWNF8pE"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1232d9f25e9so769363c88.0
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jan 2026 18:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394665; x=1769999465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o53HDt0q1CVwbi/zSNV9kLXIizI6aM8edUoYkNZlqJg=;
        b=iNWNF8pE41M8u7KIRcWyesy0I8iG3c/hIJG/xzyDxxrXPnCBn2n7W7+ZxRi8v7uO31
         5eTKGQSlcINetcczxbKIFJm7TZGxl2OlKaApR7e0YTenpuVuGUb5CEnf7Nme8+Gt+3eD
         qFNj2/IQaKfbXgzqpX97ePGLSVLsfQu/Tp80CcJBfRHsgthVyJuyvc/GMwi9d503lsaT
         zKl/rW5AHceFyv6rmQRioCvH9T7HssbfEJWOHebv5+Cv7fazSqAYIUkA6RwsBdPeAEv4
         NnQ3rlgzpMg8kY/9PPug7kcRyCGgE2wvdj/tUxiMzprnVnNihsCLyzxjPmGI/DpxoJlJ
         yGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394665; x=1769999465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o53HDt0q1CVwbi/zSNV9kLXIizI6aM8edUoYkNZlqJg=;
        b=QCKkyUCJK8u+3o/OYFNd5YF+SnUUQtF/wbcE8yEbR8x8RP+qjOxbHsAiWH0O+jl3bY
         HwIEXOiwMgEskg2tZzK49WEpnHI44wimLnlUBJzXxcvFRFHCrf2EhFeJ9Qxt4EEsqRm1
         Ir+N+erlQUkZNHbZQPMSbTbIvkWt266+np11qTCsfwbjSK++y9HdwQPY0q3y2vRY827k
         O8uty1BByMS3ca7jlY1zWOV3US97SkiyA6v8HtKvfWYw+4f1BAOOuS55I233O3QaVPTn
         d/QTKRuoq1b7cwBamOZGlCuwaBhJITzIPB9KWSwleBZU4q4WQmCVZ1uHj4ztJG71p8c8
         v0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl/EFPmamjvNTm5yqlUlI0+hCEz6rnxUhNR2uqX3V+WDNhVyvSBhZdbXnt1/44Ag2Pdi2ULlZ5X8JU@vger.kernel.org
X-Gm-Message-State: AOJu0YwXi3HtqvOOecFfr+UxalwiFmvIpma2C8ISPmMZ8K+4Z5eULUDj
	jL9KdmBdfDvgFKfp6U63ZdIrQn5KhdxngAnp+pu1kOAQwlpRfORzjn4t
X-Gm-Gg: AZuq6aLCb+P1fNdcOuc21JzGlAKcV5uoH04I+6X8AKlUTAk/5PaZB52YaWaepnp4Hur
	3VTAAC3Vv1pRZNo0+TEUZDLiJb7V5Ds1gfwbGfBsQc/3LER/oNpN3YPtu2dIA0M3BdCdv2SYj45
	u1a8wBBHiT1+z5xnsoZhaPS/eyTLoBouuT6CK/H5/uwXAUfliYONDI872ofUqudZcyjv8EJHMJ0
	T8Hk37iUDAjU+CEhUxNskmRUFhbZoUrJJ/Bx8AuzELEcJ7EakFA9z4Z7IJQa9ZGbfMQ9hRGp326
	CF3wH8JMcIhRgr8JtmqweGA1d8NcH7L7Co6DXk9DGTotxGDUB6LGZrPqlNH8KD6bjOG5Nu2FXgd
	/XRWclzXzc5qK9D7f5EFFTIlV/MyH2JNrE1qmeQbfVXZ+XVAp6wJ1VFtR832R3ng9f8USQ03AYD
	dUHHBDTMoxFDjIla7Qpqm3Wg8he/Yoj2nY0BXfdQyOsdpVPo0xQKEb
X-Received: by 2002:a05:7022:914:b0:11e:3e9:3e99 with SMTP id a92af1059eb24-1248ec877bdmr1892191c88.49.1769394664769;
        Sun, 25 Jan 2026 18:31:04 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm17212277c88.6.2026.01.25.18.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:31:04 -0800 (PST)
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
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v3 0/4] ceph: CephFS writeback correctness and performance fixes
Date: Sun, 25 Jan 2026 18:30:51 -0800
Message-ID: <20260126023055.405401-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello list,

This is v2 of my series that addresses interrelated issues in CephFS writeback,
fixing crashes, improving robustness, and correcting performance behavior,
particularly for fscrypted files. [1]

Changes v2->v3:
- Split out two patches ("ceph: free page array when ceph_submit_write() fails"
  and "ceph: split out page-array discarding to a function") to a new series
  [2] since they are independent and had no outstanding review comments.
- Lowercase the subject lines of commit messages, per subsystem-local style.
- Update the commit message of ("ceph: fix write storm on fscrypted files") to
  mention the explicit dependency on ("ceph: do not propagate page array
  emplacement errors as batch errors") for correctness, to prevent the former
  from being accidentally backported without the latter.
- Reorder the series to make the aforementioned patches consecutive. The series
  cadence is now: bugfix, bugfix, cleanup, cleanup
- Add a clarification to ("ceph: remove error return from
  ceph_process_folio_batch()") that "abort" logic is still possible, just that
  it is responsible for cleaning up after itself.

Changes v1->v2:
- Clarify patch #1's commit message to establish that failures on the first
  folio are not possible.
- Add another patch to move the "clean up page array on abort" logic to a new
  ceph_discard_page_array() function. (Thanks Slava!)
- Change the wording "grossly degraded performance" to instead read
  "correspondingly degraded performance." This makes the causal relationship
  clearer (that write throughput is limited much more significantly by write
  op/s due to the bug) without making any claims (qualitative or otherwise)
  about significance. (Thanks Slava!)
- Reset locked_pages = 0 immediately when the page array is discarded,
  simplifying patch #5 ("ceph: Assert writeback loop invariants")
- Reword "as evidenced by the previous two patches which fix oopses" to
  "as evidenced by two recent patches which fix oopses" and refer to the
  patches by subject (being in the same series, I cannot refer to them by hash)

Warm regards,
Sam

[1] https://lore.kernel.org/all/20260107210139.40554-1-CFSworks@gmail.com/
[2] https://lore.kernel.org/all/20260126022715.404984-1-CFSworks@gmail.com/

Sam Edwards (4):
  ceph: do not propagate page array emplacement errors as batch errors
  ceph: fix write storm on fscrypted files
  ceph: remove error return from ceph_process_folio_batch()
  ceph: assert writeback loop invariants

 fs/ceph/addr.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

-- 
2.52.0

