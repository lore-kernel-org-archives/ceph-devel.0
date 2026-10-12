Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEED43B3C0
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789027; cv=none; b=LRJ+6wfkTjKNXYVOCF1roxj2KPNCWFxG4C8txILHElSkAQqLLINxbZuQZT2BbKEEeQaza/MbnlxSfM/DtCJ+T3sYaKoUKkPacwXOA2iK1Wm2+YJVwdtPuvVPAcDPz74Fgc+YZWKt+G6I46m4pPi6o58W+9wMmRLUJUrsnMMCU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789027; c=relaxed/simple;
	bh=tANiSwK27Bb6N4lauLHQ/pG9GUgh81f8sQ6eq0lsUMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7v917K8uv0v/xAWQHs6kOy6XD0dmjZqnJEL6UOg6uVCNly9CFVIDy+uZcB9X/LdOhHo1WJv0KnbaBWaCBCeMgAK1gwy2PBW6ic6ukjG/fRyHrc7p1O7qDmdu4uMkvIjwvIESpiJs6yTInkTeQNSAVf2hvXq8e3YRgGBcfAl+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3m5VZQQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDmf/Gky; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3m5VZQQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDmf/Gky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791789024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
	b=J3m5VZQQYmg7q8fEHae8xs1cIlgico0pBLiKfNmNa+olAPcAAbwds5ju2mA14zKWmYDAQx
	e5P74X3rhNkjSdon9VrcvkgoAu9wVqRYJq6LKqcJdU2eOiTpUlvzgNRizGwKrUCY2efqsG
	95Yw49ETSb2oTIG1g35euLsUz2o/ReU=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-DW7PiYLROXKHmdb3wgztiA-1; Mon, 12 Oct 2026 07:10:22 +0000
X-MC-Unique: DW7PiYLROXKHmdb3wgztiA-1
X-Mimecast-MFC-AGG-ID: DW7PiYLROXKHmdb3wgztiA_1791789022
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34ef0362d95so1862884eec.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791789021; x=1792393821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
        b=GDmf/GkyZiWWvQGufDZHXs07qC3jfYxmDqECHDxbnvzhRPpC85d1wdCtXViOnmHgwd
         eLXcjIUaQpKa/eNR2HCGWbZiL9TE0rzv9GDSD3vK1pJUzl3BGxdKiI6cZ7t3/16Xm18K
         TQG7KFNEFPA0e8DinXmp2HopZmIGwMVMwadXkUbT2LhRfiaLXyLvpZtT1YdsOPq2OlcF
         XyL6EDLvgGWaWWs8OdE2iRyiV+w+EccaAUt8gS7qc8n/AbQ0CCRULbYSwCdtCsoNIIfE
         3eju90mVPjzzZDOpaGPS/XWilGckIYuhFHm7ERHqNdcUhEvYfFGOUroxtVsizyNwd9mD
         YJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791789021; x=1792393821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
        b=yW5vhZ36qTPI9WTAtRT6ITvATNu6wiY89mPtuhOMlu+2KrA7zTWi/aIOLpSwebFghc
         HIgW2xEST0JoLV1HARrqK55tSPkO8NjAW8SFU/lf3DR4CLX4eNkrSGjWY3OD/d0Do24F
         COkGCFCS4vfLw9Xn+2kZ5x7hYk8E5hcNxMqxtgjRbfECESiyuU0fu7aySXxQmM6tmkZ9
         2+FnwYfgaSFJEBfX3inl9ZvQGqArHWZufPnLQvAo03EqrQ1ZByoAskIhdzT34DojN6rC
         RhrYuznoOLFlL+jdV3YmVxwDJ4iGRxOL49xIbnm7Jz2VzP7y1asJkwSdmGeVmPu4EsiS
         ifMA==
X-Gm-Message-State: AFq9FYJ/MG3iL6UyQzrKfKUGRfEmW3SwLX16yneieXsECX9p88nrV2k2
	5UAQvWMgjNIq/gz7gBO0OCLUkSNsBIZUs++0maloazY3izhbAEzXRRmm1+s8tcj7kT9xNkIl11P
	HIk5grApy5WHuySqMZnQJ5t865EMZ3mpeHjjTEV3F/grJh2qVTS1xvok8LA03oEA=
X-Gm-Gg: AYBFou3WjsIrS8otMwGo/h0AAem+540RlRDylprmbqNr+V4MgujFojTF1j/Rj3U/IGB
	PqkTOMr3B6fMdbtdVseE38tkA0+3Pp4qjtTiOFMZtSqVU7wdbMtSEiPnIqKXcCe3nRQT0XuoNQe
	c7x0IB3w0HCRbBptKKqFoyfMA14UXpeafrMqtX37s4g+DcO91xitbIRzwb1lp5bs7mViiZtdfIF
	wVVK1+hu9r1HqioqH04J5ehHaI3dmz2nOs4e6C+vUy/vM2PEKnyMALWKIWwDkN1hwSBPHvyU8jP
	pBJeXWXdx2AknOMpvwF3np9h4etm+rU9zOB2Ev6/VSH/XWOFiTVVFqrCp2COyiUMagJq/WW7ipw
	oqGxnCjxnCDTatO5xseqHEk0rquvR4gaGnx1hOBxBU7KvabTrOXDjoK9vLS/U97H2Ys914jEurP
	lpSIINBrlr/whyKQ==
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id 5a478bee46e88-35a47edc590mr3774419eec.37.1791789021319;
        Mon, 12 Oct 2026 00:10:21 -0700 (PDT)
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id 5a478bee46e88-35a47edc590mr3774378eec.37.1791789020650;
        Mon, 12 Oct 2026 00:10:20 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm31679103eec.26.2026.10.12.00.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:10:20 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: validate fscrypt auth blob length
Date: Mon, 12 Oct 2026 07:10:17 +0000
Message-Id: <20261012071017.3425962-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008060646.181728-1-tjdqudcks0424@naver.com>
References: <20261008060646.181728-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sung,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

