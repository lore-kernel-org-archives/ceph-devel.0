Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393853A3BB
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075739; cv=none; b=selwb6mzz9R3F+On7FMkNbnPtkcYRGWxsN+AxdsLhZaX9cpY/bKF7O7xw+Fa0s69s75/4ZcJh5rE9velRQtMtfvfu88CCAUwhASPz/+XvHlsYY/HKah4KBxyfVnJx3bPuxnxuWotIPxAZDk43aTCuiBMNZwcM1H71+d2r3HZ2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075739; c=relaxed/simple;
	bh=fpjEouw3Uq5z86DVLJ65fmQBwRArC7FhmWG5CTjzhMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIuyW61K+DhmjYeEzegT+/HNgXlgAmUcN/VVtvM/NzC/kQ4AakHAojyAoigilo9YUFsbp5fNLAcqEimI65iJ0GYma9ZE5p68ZlmLORAcaznO3pC5wXWY/q/2HYF0zkKSbZimWHiYYAbK3s7H4CEHYnodiC9cDSV7o1AEejwWhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLI2zfJE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B924k3cT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLI2zfJE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B924k3cT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpXpjclMEoebmC/vi6gvkncTWeClCe1mMRKXCBCDm50=;
	b=GLI2zfJEweYa47NgDSqT0lFVsqPNf+XuEkkrSufJ4aZl1W5VT68N7Ld92mwf6G+yYMVn/A
	oCg7GMQhf42/XerVZWZ4AoIAoewH2X0dPPEQlIJMmOjF2SuP57nQlL7w0YKDKk9VC2eGZc
	YGzIPBUa/Jr8Z7GXIxI+V4h2fyWCrIg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-by1kH_NCN1S49bCzbr_ugw-1; Tue, 22 Sep 2026 07:15:35 -0400
X-MC-Unique: by1kH_NCN1S49bCzbr_ugw-1
X-Mimecast-MFC-AGG-ID: by1kH_NCN1S49bCzbr_ugw_1790075735
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so141781985a.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075735; x=1790680535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpXpjclMEoebmC/vi6gvkncTWeClCe1mMRKXCBCDm50=;
        b=B924k3cTchbD6HDaA04jGzz5gO5swJSRf+3/mdlA/Qmw0O0Pl4JEHwfLMHowaZN6N0
         q89zsm5uZSDTcqB1AEkhAhNRAhlZGiSd3a3ztkSNsSFKRweIRJBx8UtXs5SGhRaqVhBb
         uoeby/JKJJmuTB7QMeZgYQsdiz7K276hQB9KvX2FmUxqfnDF6BvB8d0s12skZndYo1zp
         QfF2k32C6lsbvmcv1sYnT20NcLjop0oZqaiZLl71jpUx8Q0f7bV+d4o/mMTCOYBQn46L
         kyUqXXaJ26EhtYhrDzIE3mTxyLLhKoRhb2ISnC1vXnJrN0k+s0mqNif/ooJP2oJ2J1nr
         OUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075735; x=1790680535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mpXpjclMEoebmC/vi6gvkncTWeClCe1mMRKXCBCDm50=;
        b=EF413XDFeoPMyVhWWcN6vLo9Gymo2cig225RbZM5EBFnXlH/bEEGFkkY3j5kWUFxBN
         DTSFESDvb1tse1F5/n0+pEpyJ6PWdMZr4ZPuWKna7efBBlFjjhhkzRtT3JC9MmHy37To
         m+6bAH432/SSpf+fP4hQR3NNN3xCsMlFnZ6u81Kk3oontgw+g/zyZ/D8zMsz9VCcQwc+
         SlJ2HJfUfuoKretzOrBIhkct7DhWzd/QJElPZZ3d6pZtdRhF/T0f2F/i7x/eSV4iAOoe
         0jZfd7Wd7SJB+PpHBa4Xx6apPUlyDt6m1E8Cx/AllC9vjS52vMwx40+ElvMEkzpJDjz7
         ZHKg==
X-Forwarded-Encrypted: i=1; AKwUvBzslEOGkMdzfgGrQM8IF6/50MX8U3ILZHzDRAolqgz8mSxoUJYRa8y40TU/+DPV2vumwNtTFY+f5/qP@vger.kernel.org
X-Gm-Message-State: AFuF++kXSoBTmvLh9NKySwY/p725c+mCl/6gTovrzu8GYDv8/W0vFRXC
	FNNqTeTEMghcY5qFOWouLKCTaDNHvwT5oceKFkYoGazQmdo4oUDynBFzBYxjmoBc5fdu3a8Ifoa
	K6fjkPlaHT8cvFoCK6wveO0JnvgXJ2flrTdSC/Fa7DgxMECFwzrQxMdQTBBJn6s8=
X-Gm-Gg: AYBFou1BkMN6jZl8kaCoB990KRTHxESClIOgviTXGY2ksCuxN3Vpm2n53F6sbFjPGY5
	gZRSHvlZE94M3zvfd5muyG7RJF/Ppx8nbCwa0cc13OO6sge9DtsTdWm+k4ELWWtzu364GPMlAGs
	xDSPwomdSkavc2VWlbjnE1BJfggSgfbTh9pIKr5dQQ/498p/cZM8NTDAb011MpHRewOYgfsSYBb
	UwMyLG5FvdT0nIW8qY7X6NRr2rXFKaCZvnmHQ3TSyRI8eGn26yVqOLHxb2Zi1FY2G7Cohgog7LG
	Fmv18K/4fXQLpg7NCnIX28kEzXRm5vmd5ckNTNBtu6WvapLV+sRVVUV4GfZ5QottT16WtlP9H1E
	4nCvvOAwgjHK9Wq7ZtKzfY2HTHO8O73tgj2EMOlE3tqDSCp97HfpO0hcQ6TJMCIqJTxQskwatt1
	om9abXNWY6mCzE7g==
X-Received: by 2002:a05:620a:600b:b0:939:f861:8836 with SMTP id af79cd13be357-93c17ea5accmr372860785a.20.1790075734697;
        Tue, 22 Sep 2026 04:15:34 -0700 (PDT)
X-Received: by 2002:a05:620a:600b:b0:939:f861:8836 with SMTP id af79cd13be357-93c17ea5accmr372856785a.20.1790075734305;
        Tue, 22 Sep 2026 04:15:34 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914025128a3sm13040226d6.44.2026.09.22.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:33 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] ceph: don't let a bad mon_addr= reach the empty-monmap BUG_ON()
Date: Tue, 22 Sep 2026 11:15:31 +0000
Message-Id: <20260922111531.767419-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911133110.2218-1-yogeshgaur.83@gmail.com>
References: <20260911133110.2218-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yogesh,

Thanks for the series.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

