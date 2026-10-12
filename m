Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A73290AF
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789370; cv=none; b=VUtWxwuhr7csEFlXSlhAD7GUSbRJbyHAuVqd6whUij3Svpp2Sm/SE8HV7pasYqp2a+2B2LV7JlK2WRHQTbwII3L2MGite1ngW1RluyydUQgh8ZdDE1YzuiasbC17VhBYjlzGXbpBIqsqU4NyU+pMQ7l3g124YSssYkRRIUbQA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789370; c=relaxed/simple;
	bh=tANiSwK27Bb6N4lauLHQ/pG9GUgh81f8sQ6eq0lsUMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sH3+7hftk7M1PlQyhMk4SnVICkX8rn4NHlAtEiu2UIae65IkZscCRdUHnZFyONLTdUWad85euhw1XPis58/wx240bdC0X41z4wpshR1ZE9l1x3sd+AfnlQQb9IBYJTWNB8uzAHa3HGKcZorRCokujfHeSlevyDVQA68szb2CIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRwDEChT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGVWUFpq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRwDEChT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGVWUFpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791789368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
	b=ZRwDEChTIjeS5/XlnoiGjhXvtB7FOFY6VD2k+MgPLg8dIOoi0lbAtw7LZ4ESmQjyKVDiU+
	o/+2QDL/Y/hiACbHxvlU7pMhGIdeppjJHVYdv3XRz9gtXxqin2P13WZpWsaAptBPUGfX5W
	YX0ST3xyfd2oPXJUNDjMuQ/pACjsYso=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-a5RMp4tKNemoGJunhEVbWA-1; Mon, 12 Oct 2026 07:16:07 +0000
X-MC-Unique: a5RMp4tKNemoGJunhEVbWA-1
X-Mimecast-MFC-AGG-ID: a5RMp4tKNemoGJunhEVbWA_1791789366
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b1bbf8dbe9so846795a12.3
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791789366; x=1792394166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
        b=hGVWUFpqFr437qx4lNim2HrYr1vkVCTmq17BHgSUEVbBouMy+/bzwtAs91QkwzhaBO
         eDsIEg8iEqfMbtc9Nx9l/F8B8LKj8ZocPG90JE+OOQ14ccdEE9Ask855v20smxSvM4kV
         mFrABy9QV1NxN8q+/DBDRT02HY+6LBO+PiSq0fVgF+unMqVQDK7JJPHQX2pvOcZ/cq6j
         vhaPZ5oX7y07whH5E6ywxOOik18Z0K4URRvcXR46USuo/8kPQ2IpdCNdUrYkzsqFy39m
         fxHQRnA4pDsaD93cY/Ac5ZnJBaQSyy54JhYz+ZQdc+czicr/FXKHxpyFZd6sxRWoo/AB
         SlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791789366; x=1792394166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
        b=nS54/7Y9y1gfoTGK7wv+k0YOTMEaXaZeuzkqih6KeW4ytHw8Y4rniDJFV+Z8NOhhOJ
         BTmEQDK09dDgjBrd9eAlV9PoUp13oqc3PvWhpWw0J409my1Q7Um9A1tGeHjDqwqlraXJ
         J2KmXhnnZ4kP3eiECEgGypRjCSnGLNq3Lgu9D0VneoDRfmqVedRli4Q9sb1TYwCrdWlr
         vX0sI9b8AJmalNlZ66pn/yjAK69Y9FTK5hrTPlRdVIuy9IcMRekULxGpIopS0jitarUn
         KQWpjCy/l9gEnDltNDRE32ekKCVo2Gs/wqSFr+rZiIRCfm9kQvraQW57OM+j/ZuoZQj5
         ZA9Q==
X-Gm-Message-State: AFq9FYLPX0d3rmgkSfYaGdJNokmKZU1055GD70geeZkIPiY33Kvi79QO
	JSw8hdIXsvT5UW7WSily6om+JBq9eeVJCdltIgrpm49gKKc2PXT3klvyzoixzUTHA7+ZcstaKaG
	hMn6ECei0N2JBjAdI0SYRNHtM/zJb5Bmfs6OfjznD+l3XxRHs7CJGwCYZLEBK07I=
X-Gm-Gg: AYBFou0i5Q+nAJK+DqESVbNiuz/3xzbMZao5fuKdAp/BxXH8ecA2RvUYZKDYxEVZoCU
	QJWrPvhUl69GELzPx0EfD5M3czOmL1lm9MSbKYy6zVMy7Gym3/rU7BPC74sLV4uiylFSFLdANOG
	ynAQZj1lxRlbLLSnCDMTf/7LvTEF6u72nj/V7GSGoLBDyxT9nl9gjsEO8x3TS52+iUsklw1Zfyy
	b9QQJyaikJi4zMoq6CbWq40DQuOMeAQhAshz0OlMfg7MZECSwYfZPEPCKw9DmdXX9nkTAzIMMgL
	MLDIfBRRkDpNgSN+KIrXE+7iK9TW+XD8wzLEszoWg505N8CMqvRIwjgy40Lf9IM78/CNz7EAhlj
	xkdzEvI7bhm/WRY91mHEqp1kiu8vGA9YU6PeH9n7pUgu/op3OqIppJ/3gIxmir2TLWyKPHyciBB
	WbxL0r570zRzY33A==
X-Received: by 2002:a05:6402:c522:20b0:6b1:abe7:8276 with SMTP id 4fb4d7f45d1cf-6b1abe78768mr1947767a12.2.1791789366309;
        Mon, 12 Oct 2026 00:16:06 -0700 (PDT)
X-Received: by 2002:a05:6402:c522:20b0:6b1:abe7:8276 with SMTP id 4fb4d7f45d1cf-6b1abe78768mr1947757a12.2.1791789365938;
        Mon, 12 Oct 2026 00:16:05 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b178d15fc2sm4474923a12.3.2026.10.12.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:16:05 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: bound MDSMap name skips by the message end
Date: Mon, 12 Oct 2026 07:16:03 +0000
Message-Id: <20261012071603.3426578-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008060714.182511-1-tjdqudcks0424@naver.com>
References: <20261008060714.182511-1-tjdqudcks0424@naver.com>
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

