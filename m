Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E93E5561
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272518; cv=none; b=FUQv8cWL9VOvbh6sUCuNcEnhTjFlUgLbTmGWpPzox4/sWGshzpd2yfBexkgFX2PfTQGQd7h15FjxzOUoTtmAmrPhtvECF6smdlsBSwk2TzxwonC7BXmwAMrzOsgsPEOodfhvQ5vKCmQRSYZ6sMIH0glnl1ZvcxeVXU/H35W4/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272518; c=relaxed/simple;
	bh=nKbqGY84rIJB8BOdLzFBm2ltPcQM/ROZhxewUnBDS9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APjo1xGi/MlXPZlzM81uRZwUTZz9zOyaNM44LaETJMqpXfjZkK1lLOrXhgFIc/jAajWnWDtFRM1YrCtL9/J+iGXoTCMrh2UQwe8U88Kf90dMgnBqPjtmIzlqoWfhPWv19oNanzHrYmt+gOai8/qP0Jz2+OrQWrLBJbaieQjjRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmxIaoFI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/+xH+3Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmxIaoFI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/+xH+3Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776272515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Nj+i/zUf6yIYxwBMDoj27NRKQ28v/DcLzCnlkUqOk8=;
	b=gmxIaoFIBay6wbi0Ag+vOlNSBzzIt8YamKdyv3LZv0X6XQIscOB1D3Cqjow8XSDn6XGvWx
	FAyQhsXAI6aq+AwIpQKKHleyRBp2dP1c/J8/WqpNto/q6Yj8nrHV97Hb1DFvD9/IcU3k0L
	Q15LlUUjO3tixHBwTGAv9mU0xv61BQk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-T2HTCzLIMYC4F_9F3WlrAw-1; Wed, 15 Apr 2026 13:01:54 -0400
X-MC-Unique: T2HTCzLIMYC4F_9F3WlrAw-1
X-Mimecast-MFC-AGG-ID: T2HTCzLIMYC4F_9F3WlrAw_1776272513
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d63962d83so167608361cf.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776272513; x=1776877313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nj+i/zUf6yIYxwBMDoj27NRKQ28v/DcLzCnlkUqOk8=;
        b=C/+xH+3QWDkFzBLtLnYCJLNo15/IeWQ7ulquc8fDx8OiY5Mx9PrrIyGREtK9X+TqjE
         3p1Tgxw17O9QyUOoTcJMYafQMGLKyaRxTIuvcpbB/5GUDkt/8Qy5KCCGTfOimbxjY0Hi
         LGg36s1gfP/GGV2VhQTPuPKwJJ8+nnBfxyqVfc5bjiyM721huKcgEoc1F1MiOWGBXZlp
         Kb6lu17mT1Wx641nwXfAU8ZtMVi8EGx17k3STacTLKtI+g9zFmJ4cw0jbAxuW5YPgV7p
         Hgl8TTaGnq+ba3HKI4GQZ5K444WDy7t60l8c+dmXUjP1FOMQW/gtSZAAsQGYHxZ5Lm4f
         Q+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272513; x=1776877313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Nj+i/zUf6yIYxwBMDoj27NRKQ28v/DcLzCnlkUqOk8=;
        b=AXmvG63ys2FmX7jzEtsALTYT+FJOlToog+eKqyiWz/UpoAE8C/gmtlya7sJq4j9TU0
         UUZaTksMbUrzDmtas7QeniYNn1xNY5Xvfyz70NmS34RFyJhIqbDxG9vquRGwsceE5MlW
         eE0hFG1wtUrcPCWA0mVsBem4JfI6lkCz65AxPEZoolyUfvvWZD053HT4SMg5QHx+qk9O
         n5bU7l6vvVzk0LVBQn4ywXpkW4J4+UYL5Chq3LkTHYV0Jv9qP4vU6RKptWBojw/CB6lU
         vI2bsCD6RBymx19mG2IRE5cKWZ4mk8Q38Iv/DTFAv0uLQ6cytvnO17XoRS88EITF7CZB
         7+Rg==
X-Gm-Message-State: AOJu0YyssihBgDGl5HQyDhi3Np6cFC+17DdPi4rPFtrndq7Z4zdXbXhv
	bHk9t3q2pGkCKWllE2S8VtmlWMgfbHyY8AFofhc6GSKsnPruuLJVrdgOw114jO6prwDajRr1/54
	FuO6QKl7j6/hyz7mdtRHrb+/gDzbV4wOwY06DjUYwpt7k5QyGxR7h8/YUNfQqYceHm0QTLEoPI5
	lh5P/8hUKNZAa9EjJh2PxaCGNqd34J32p+WuMyDv6upRQkC0vptQ==
X-Gm-Gg: AeBDiet4P7VVJMeeHft2vAxjLsfbj48MFFjmRy6S+0EJ4t398SrPsxUrPPxzAXQRDQb
	MzCWZLvfpPcVRx9nBgT3sj9TR3V0YjUyCOekCjDhXCh7f9SlP+we8tO4OzO1yON0ZaPvMhz26NU
	E7G+xxYOTN0J4SHhnJq4baq+xJrBQI9ZezT9ay2oLuOg8NUX3tsMXjikm2LYdlLq01bGgqDzQHg
	MJLbij5gjfjyNzDvFguKTWk9K2EgJB0VY0FllqHstm/hsHjdDKtgw0YsjPT29qeotw4seOM2chh
	CP7YWKX/+TZTynkFeLWGFwG4s5CYQVHHe+LVQ+VePFHQc8wzaw4F7W073jHx7vFb6mKCs2IGQfO
	nQj7r8hvBRA7RKy/S7Xmvs7YaB8a9UEw7OnypWDgaXb2f0pUprMnOXlIFKP1Zzeg1/Q==
X-Received: by 2002:a05:622a:10c:b0:50d:c69c:d01c with SMTP id d75a77b69052e-50dd5c3d6e0mr339858701cf.37.1776272497723;
        Wed, 15 Apr 2026 10:01:37 -0700 (PDT)
X-Received: by 2002:a05:622a:10c:b0:50d:c69c:d01c with SMTP id d75a77b69052e-50dd5c3d6e0mr339824561cf.37.1776272464530;
        Wed, 15 Apr 2026 10:01:04 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm16817841cf.16.2026.04.15.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:01:04 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 2/7] ceph: use proper endian conversion for flock_len in reconnect
Date: Wed, 15 Apr 2026 17:00:38 +0000
Message-Id: <20260415170043.3882912-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415170043.3882912-1-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the __force __le32 cast with cpu_to_le32() for the flock_len field
in reconnect_caps_cb(). The old code used a type-system bypass to silence
sparse; the new form uses the proper endian conversion macro.

Also switch from a raw bitmask test against i_ceph_flags to test_bit() on
the named CEPH_I_ERROR_FILELOCK_BIT, which is the correct accessor for the
unsigned long flags field after the bit-position conversion.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ccf0d53dde2b..871f0eef468d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4693,8 +4693,9 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(path_info.vino.ino);
-		rec.v2.flock_len = (__force __le32)
-			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
+		rec.v2.flock_len = cpu_to_le32(
+			test_bit(CEPH_I_ERROR_FILELOCK_BIT,
+				 &ci->i_ceph_flags) ? 0 : 1);
 	} else {
 		struct timespec64 ts;
 
-- 
2.34.1

