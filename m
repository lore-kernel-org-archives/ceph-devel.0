Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F9395AD3
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251424; cv=none; b=C2/VUqXBqHi7k7jVTcj8E/76Vo9x0NGzIeaLsjDw5te9ayjlVOd+6MTZShWXhc9fRlvePR8c6D9p1WuUKTThN1MRblufXJTfIUCn81mMAYMaIOSHIJtVhJh1h7lVqfco7j9qRghPlPtirqgrflGcCcG5pQeCsOkdQ/FCj3qFPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251424; c=relaxed/simple;
	bh=ehZHxmxFBchsjh6pqd/BorISaLa1vR6mWdb0dyhaAds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEdeeQDq5iTUACS6k/79ku7CpmNevi/xW5+FiC1pZnBkxw5gvnx+FdPlJDuZ11M5RTs0IEKhEUYrLi8DM7RtqW/ygbK0uRrkEQn7h2a7rHpzSclbcUBhn3T2qEbPIXlwC9SKsbOTg9Q1Q8bxg/9B1n3ozqncY7uZrbGa3Nyhl4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQXWZhdz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k15tvUB4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQXWZhdz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k15tvUB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787251421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehZHxmxFBchsjh6pqd/BorISaLa1vR6mWdb0dyhaAds=;
	b=XQXWZhdz99/Z0NHhxU/nlzBOfCTJGlZJ7c+xylE83G/SxG4tkkUBXLJeIOiDB+gH5hybS+
	jGPrUeJ4aRR5hyANjdWtLH6WNf6ETEK+pmBJdkSjbhizv+NiF6XVLzE9EFXw0rCnIMwl9x
	Rh6SvP5F9h/1oVLmALUcKJuiFNaFrvw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-KqO-IvG2PgiNgABbn3cx2Q-1; Thu, 20 Aug 2026 14:43:40 -0400
X-MC-Unique: KqO-IvG2PgiNgABbn3cx2Q-1
X-Mimecast-MFC-AGG-ID: KqO-IvG2PgiNgABbn3cx2Q_1787251419
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15d4224f9dso7203366b.3
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787251419; x=1787856219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ehZHxmxFBchsjh6pqd/BorISaLa1vR6mWdb0dyhaAds=;
        b=k15tvUB46i6cXyczNfQBHigNybIHZqIssNxB8nuNOB516J7YuQzzNVR530yk0aK6ot
         BOYlbfqvBOt/sxrmJ7KWpzBw7bFPQnCMh5eQOx4ituULCE03dHQIYy5MgPAwLAt7FMVi
         WEGXugoIdY03dgrnBvH8vWBEiwh1B+xL0g42Gnqw9Kuo/jFh7NTtGhDkEjE1KTMr++gF
         Oxrq308IGcTitMSSPU25vUvqE4bjqZbZ9ezfUuHNOlW2B4rVUyZPA4LjeZeia/gxfWgg
         PPl9lMqaVHTA8lY7BOVYy0PHTjAFss2/RC2OlzkHrXrzD2ncmzSbq7Qr9ZxQQaWBJk8P
         ogDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251419; x=1787856219;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehZHxmxFBchsjh6pqd/BorISaLa1vR6mWdb0dyhaAds=;
        b=gZFe0HWHpCOnE9KQVogP65YPsON/Sv/nlgidcMFsw4L+2ju63GiBXQSEvvq5xlIPbh
         /n0ybroXI0c2oViQpHBfJNw20I65wulQmdqr+l6Zc1gbqNm9jrvlq4tPtd5VWw1JllQu
         FqUdP3PtaIBk1YQqOwYVK6Aa6jb/J0IhuhSLC1yC4mYa8uNG5Fl0HUiyWpGV4oCDhvTN
         P6z31xV2Hjwxg7vs6pwwmQf8ELP5gtuAPCENnxs1/0OWRKqsF6n93joJ2N/GjCX5+WEl
         GwlLzd5QJxJoAGPSNRP5c/RsttJIT7T7oHN0I3ZwsUANFmkvz9kqbLs7dnfzYNsTC9ha
         r4iw==
X-Forwarded-Encrypted: i=1; AHgh+RoWj4IA1ypd8yXvpwPLcQqA7oM3L9Pai7J13XZH45BARpehhbUfQuCqbHuAXhVgbK7lhF3Uqle+VBys@vger.kernel.org
X-Gm-Message-State: AOJu0YwEA0c2DoGsIyMdYQS4IvO+hNmhTjqbNHwmIijfIezNflx5XEwT
	D2PucCy9vFJMDMfL74P0fjI+8SSrjfiftgbDBpBCiT4VO5qmLeaZigZULh6UAvPudRkeEFnMEN7
	IR8yQk9NM5z7EvEwAOGZU/J1JXRTpz1RamGsJfLDri6TM23caOOnegKzk6ey0Kew=
X-Gm-Gg: AR+sD12VbKLt6koGHjx4KE7CG23T/qStZihkvpwe3N9gUt8uSbOuaE46RJjQhnN3QjI
	A6lk2nyhKTE/SG3HAVNC2QwtNsNzwBMyi3nhA7XzC7oMgZD90etJWD71GKFnLXjYuyHGbIofsoj
	inZGADML/6QMo5BNLHvV+AcPiOt/GnLr8IiWKZiWn91sPXmXsqMQA/B7d39DLTSUUSmzlPUEWdh
	DMZAtmfXzWmW0edqyPI47zw3+ABM+eSIE3efXts1DEB4NI+QgWaQeaPFKOV+XsgaH29aFfSDZjI
	r9Z61tTI9w9Zs55jpyp/D+X9t+jAPmYBx+BaTTLWkWgKQquBG6TXvDY9MiafKsni02pVO6+imcg
	RYvQvUNZewEiCt35fYCd8xPKreLOn2sX8+w==
X-Received: by 2002:a17:907:1b08:b0:c20:23fb:bb05 with SMTP id a640c23a62f3a-c246a6b4dfdmr42074666b.15.1787251419197;
        Thu, 20 Aug 2026 11:43:39 -0700 (PDT)
X-Received: by 2002:a17:907:1b08:b0:c20:23fb:bb05 with SMTP id a640c23a62f3a-c246a6b4dfdmr42071766b.15.1787251418831;
        Thu, 20 Aug 2026 11:43:38 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df2acsm104609966b.44.2026.08.20.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:43:38 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: xiubo.li@clyso.com
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Subject: Re: [v3] ceph: add 'lazyio' mount option to kclient
Date: Thu, 20 Aug 2026 18:43:37 +0000
Message-Id: <20260820184337.2284093-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819-lazyio-v3-1-21110d37c4be@clyso.com>
References: <20260819-lazyio-v3-1-21110d37c4be@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xiubo,

One issue in caps.c:1014: ceph_adjust_caps_used_for_lazyio() maps
CACHE/BUFFER onto LAZYIO only while LAZYIO is in issued. The grant path
in handle_cap_grant() is fine — the writeback/invalidate wait fires
there. But after the revoke, ceph_check_caps() sees used as BUFFER/CACHE
with revoking as LAZYIO, (revoking & cap_used)==0, and ACKs immediately.
The MDS can then hand the cap to another client while dirty or stale
pages are still present.

Fix: extend the mapping to cover implemented, not just issued, so the
LAZYIO-revoking case holds until writeback and invalidation actually
complete. Also worth queuing writeback when revoking LAZYIO with
i_wrbuffer_ref set, matching the existing BUFFER path.

Minor: the commit message still says CEPH_FILE_MODE_LAZY is set in
ceph_init_file_info(); since v2 it's set in ceph_open()/ceph_atomic_open().

Could you respin?

--
Alex Markuze

