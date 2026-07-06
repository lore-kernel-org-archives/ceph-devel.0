Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B642377F
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349972; cv=none; b=UmRA6l4SCjlNT8qtRPjb0A/awH9FYj1Y+KJzlbfRRfc27P/qKxC4dCP+YdsY8DV2uEJxwBlx4viCj/j5gRr5JuiLhTg/83y0KX280MX0kH4INACzj7LlorSsIEOerDCOSgqLxPNVIGPHveNkAAA3hDYxyOBSBOCF6DFuN0N7Qt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349972; c=relaxed/simple;
	bh=mSF8IHEnaLUQN+8ULeKs1g8+1rEm//DN2j8bXKSazyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYHfFe0rgvf/OIWcsmOvhpcqR58gCdHBN3j20w1hHuEBvB6fqJnEVjqOw5GJnvhMzwXNBmrZuk4RnMywE3GxECJIuNX0W2jwhahLnVTNL/AoWhdp8ydrkoE7XJJnDkrt9bvSnOhfk9KxEXnPuA4mCR+9fs0xsiDLlsRTFZrH9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ABj3wIvA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ABj3wIvA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so24121425e9.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783349968; x=1783954768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QeStcLSdfwxcN44D9Oy9a8bVFzM7p1YOmb/gfi7ptzo=;
        b=ABj3wIvAn0cwY5b7ji6L/g9kAD5f9N535pxF04CES+PQkmuglOq91FjgRQRqHSzQFM
         A0fCv5ustBKtmIiH/CqgJBbWJ2phe97zM7iNl03CuCePw8nCLcSIE9tIQhJfFl1rAHwd
         o34D+Q0ETigImwcf4CHdRAsqYGubtZPjbYYd9bXSGFbRB3upRegy6Avr4MTAApYBzWg+
         ZYswMFet0yXyxoTp3FsF1fxfKjukqGuDC+XiptEug2bSQUC7UqG7J35F95+VgfeVfv0K
         BSLRAxdafIRQBlPUmvCykzuwErV6mvvHHn1IAmoa8vK/PSkw6YnqOxlz6FQlRu433rGr
         MD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349968; x=1783954768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QeStcLSdfwxcN44D9Oy9a8bVFzM7p1YOmb/gfi7ptzo=;
        b=me4TKX5AHrwVvlwO86hwdXKjNbsifpWiRSpvH24BUAg3tDoDDsSUUNB0yCYSdDRIhX
         44arukKTtVat4Jmupgr9cI3mw2dGr/JCxcp5LEyBlfaTdIvWUdcq5g32Xbt5ZvJAWCtG
         NVYHJ6fycapPjut6UnKi0XpulTW0+dYlnW2FN7uF8lNPkPrQH0dR1jSLKeWupbvwBhWg
         2Ryhq3z7CnHWWHaIKH4ZvY6hdGb6zkOsWugSIY1CGPnD34cszqbI4KUVrzeMV6gotfeu
         YnQrBmOw2iVVuLui7aZZMAGLsd//Oe2e6sJDiAA9zxbvPQVFd+p2ut6APDytFD/lxoaP
         6UDg==
X-Forwarded-Encrypted: i=1; AHgh+RqyzyFQTUE8fO0orOo7vPsO4bofuu95QYRvoXAV6/Qa+eZJfEAjo6s0H06258Z3+k45tmiOT1IOCm/v@vger.kernel.org
X-Gm-Message-State: AOJu0YxjyPVo/9xVzpJo8nXvjRfWX56vFvWsqr3qG0/m0t8ijjUXGjMF
	z2sTsdz6qHO4xi6CIMJBEOyPH9O4qhcDmeagmVGchsBRAPmzUNcgpWsL7IIe3GIRB/A=
X-Gm-Gg: AfdE7cn0monuaBUyChaj+fiTOH6MpzRnr0LV+opFwmWZb3ez6Zf/weWkZSbqJYoVJhQ
	q6uvKmrIkQ3d079DaYjGfh/UAiB4tfD1AldVfp78nouVuLdMh42yyNAceOBi8rjumZqHRHl4znx
	zd38EA5HXWAhuIf6fQxw0dhbVUsUIXZr5BS3hXFiZs+u5olSL3aMkLTSN96LlPL0snSe96pyzTj
	WghWVy9adZmAU9uqSuUQEU5RcGznCRmvuF82Ha4aFGinHXYiqOaogPJONql4vAF5aMwoLb8uFxI
	EIEQVoKOH6SJjovdB/p3GS6XVmjxr8zuMKb6cJyyjSI17to6ZdZc6WAU9Hni+7hqHzhDUpWxYZY
	d2+oultnx5DwbKuRHqJH2UL68ihpQnRvhmKQaMzmJ66rLqYTrf4fTudKENkk+TQaDxymrmTlZHm
	QprtcwzzSsJfP5TbKfLKkJsyQqoS0Je0v4nxofT4PtIB2abu+QdYimbGa1LPqgvJqLFggZt5Qb0
	4KdO21+64mtYOyU
X-Received: by 2002:a05:600c:6992:b0:493:b2c1:b2f8 with SMTP id 5b1f17b1804b1-493df0386efmr9498955e9.4.1783349968265;
        Mon, 06 Jul 2026 07:59:28 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm25592916f8f.9.2026.07.06.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:59:27 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] fs/ceph/caps: skip __touch_cap() most of the time
Date: Mon,  6 Jul 2026 16:59:25 +0200
Message-ID: <20260706145925.3989710-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__touch_cap() moves one capability to the end of the LRU list; this
list is sorted by access time for just one thing: ceph_trim_caps().
That function is supposed to discard the least-recently used
capabilities.

__touch_cap() is called extremely often - several times for every
system call, but ceph_trim_caps() is only called rarely.

__touch_cap() causes considerable lock contention on
`ceph_mds_session.s_cap_lock`; this is a /proc/lock_stat I captured on
one of our web servers for 5 minutes:

      class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

  &s->s_cap_lock:     336304046      341686597           0.04        4905.76   418498578.76           1.22      892783632     1957814739           0.04         959.40   355752146.24           0.18
  --------------
  &s->s_cap_lock      339379730          [<00000000a2197200>] __ceph_caps_issued_mask+0x1bc/0x240
  &s->s_cap_lock        1268054          [<00000000c96a24b7>] ceph_add_cap+0x234/0x3e0
  &s->s_cap_lock        1021360          [<00000000aa76f996>] ceph_add_cap+0x108/0x3e0
  &s->s_cap_lock          16042          [<0000000099463548>] __ceph_remove_cap+0x1f4/0x270
  --------------
  &s->s_cap_lock      338509619          [<00000000a2197200>] __ceph_caps_issued_mask+0x1bc/0x240
  &s->s_cap_lock        1937864          [<00000000c96a24b7>] ceph_add_cap+0x234/0x3e0
  &s->s_cap_lock        1203451          [<00000000aa76f996>] ceph_add_cap+0x108/0x3e0
  &s->s_cap_lock            202          [<00000000888f212a>] __ceph_remove_cap+0x7c/0x270

In this /proc/lock_stat output, __touch_cap() is inlined in
__ceph_caps_issued_mask().  It is responsible for 99% of all
contentions.

Since __touch_cap() is called so often, it is acceptable to just skip
most calls.  The most busy capabilities will still gravitate towards
the end of the linked list, and if not, it doesn't hurt as much as the
lock contention.  This is still good enough for ceph_trim_caps().

This patch adds a static variable that gets incremented with each
call, and 255 out of 256 calls will just be skipped.  I didn't bother
to make the increment atomic or use READ_ONCE because I don't think
that makes a practical difference for this use case.

Another /proc/lock_stat for 5 minutes with this patch (__touch_cap()
is no longer inlined probably because it contains a static variable):

      class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

  &s->s_cap_lock:       1043711        1065182           0.04         502.72      737472.88           0.69       10522578       25069948           0.04         796.44    11053669.64           0.44
  --------------
  &s->s_cap_lock        1043074          [<00000000f4367d73>] __touch_cap.isra.0+0x50/0xa8
  &s->s_cap_lock          12147          [<0000000096f45706>] ceph_add_cap+0x234/0x3e0
  &s->s_cap_lock           9472          [<0000000038a23e0f>] ceph_add_cap+0x108/0x3e0
  &s->s_cap_lock            471          [<00000000e2eba934>] __ceph_remove_cap+0x1f4/0x270
  --------------
  &s->s_cap_lock         978499          [<00000000f4367d73>] __touch_cap.isra.0+0x50/0xa8
  &s->s_cap_lock          57794          [<0000000038a23e0f>] ceph_add_cap+0x108/0x3e0
  &s->s_cap_lock          27226          [<0000000096f45706>] ceph_add_cap+0x234/0x3e0
  &s->s_cap_lock           1581          [<00000000e2eba934>] __ceph_remove_cap+0x1f4/0x270

__touch_cap() is still responsible for 91% of all contentions, but the
number of contentions has been reduced by a factor of 320 and the
total wait time by a factor of 567.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2:
- add data_race() annotation
- use the proprietary "u8" typedef instead of the standard "uint8_t" type

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..876201075623 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -871,6 +871,14 @@ static void __touch_cap(struct ceph_cap *cap)
 	struct inode *inode = &cap->ci->netfs.inode;
 	struct ceph_mds_session *s = cap->session;
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
+	static u8 skip_counter;
+
+	if (data_race(++skip_counter))
+		/* skip this call most of the time to reduce lock
+		 * contention; the LRU list is still accurate enough
+		 * for ceph_trim_caps()
+		 */
+		return;
 
 	spin_lock(&s->s_cap_lock);
 	if (!s->s_cap_iterator) {
-- 
2.47.3

