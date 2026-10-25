Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792953773;
	b=a6zGSR9VIWeTpyZhBVRg6+xkYPO+Zurx0n4YLki3QXv5nI2IgsNj5koSziWo6+T9I0RD
	 vRkOXzRWzVtBVHEAqUMG8MMQfPOhk8GT5aFM3jRUq7r/tTr9YYRd//VuRtfxsFNDZzLnH
	 6gvlGm5SUzVdUg8We6b08bI73MSgpzt8ahmBgckokJ3w4n/Yg0H1nLexPLmR2PYaOJ/Lg
	 N+SuRHzC3/nXzWfa/J7GIfjlJt2OVCL7cnoIO7k299eFXvl/La+rYwCOqPtkUs+qfMCuy
	 ry5YrSph38LjQ257zlY1eFQZY1HhGUpHQAaZTlMV9iDPldbmT9Z61k94isd2+ExfYPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953773;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MWImOuQ6ypazyDauHnpT+aNeaPFSVLwAEzW6QlQDKXg=;
	b=l8Kr5obFPCqQh1Pjuk3+P/K2Rt6Tv1M8eYEmX5Gb6WKcWo9BntJiCK+7LS41YgOpaThw
	 ur/h/59+gx6AOf2eaPCzT1qdA1rj5k1235knCNb5ztLIZBbx3bciU3mlztuNoRysbDsno
	 1gilC71NmzxL7cQc2+DGGNGr4SdCa9Wrvk/VaA3RzVN7XhJblKLhO23tq72xoYECK4IAl
	 nJo6nzBagfbi49BoeV57ASNdEb1yZy/sapOxP3h9PCc0qWsnyJFc+PAv4fBhAzmtOZOgP
	 2gWoWWSZamu+Sgr2Bqu/PCtJl3Na+wphQJHvKUnQ6txRrjbVPZf5ggoHdoZ4DRoo0Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnhCpwT5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UM9gNfOc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543EA606A323
	for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 18:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 543EA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnhCpwT5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UM9gNfOc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792953772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWImOuQ6ypazyDauHnpT+aNeaPFSVLwAEzW6QlQDKXg=;
	b=YnhCpwT5oQvz/xsrUA0NmjLzHab6GVhBdslYCvVwuNxMQiVjFWyHAAa7MZzA9rbsHGbJrs
	XF/ZiF3OT5B6xMZt+Gvat+tV5TS5jnaZ8FXoBApC3GYIW8tmKPWWGSgXJJtLxMpdQl5yTL
	2NlfnPpV/D7R7vAg/TCqQRF1aGmH29c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-_vrDivNuPNO6dtCxPkeEBw-1; Sun, 25 Oct 2026 14:42:50 -0400
X-MC-Unique: _vrDivNuPNO6dtCxPkeEBw-1
X-Mimecast-MFC-AGG-ID: _vrDivNuPNO6dtCxPkeEBw_1792953770
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c498fa2d96cso11066566b.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792953770; x=1793558570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWImOuQ6ypazyDauHnpT+aNeaPFSVLwAEzW6QlQDKXg=;
        b=UM9gNfOcWXQfA6+mcNx2oOQLAI7uqUEEJFZll8z+z1ftL3/5ziQNEzQZ2OVoqKwM/Y
         SNSw00ojeXr7N5jtYuSeSmSMQgS9ml/ddfALqfu8o6Fl0t9twnlZBDuUOhPEg3IdskWh
         5TG0xGt5EXyDYYVjdcoduwqJEf1arIEMiBaS4EUdyhJm3bFZu9j3kccBjnwUuIaB4I73
         /W8AF1sw/drE6ylMDrWiNEaoHXUVzKHZhOBPHAVE8oFN3orLP9zqagTldlOmG9tmSFnQ
         ZjXQBNGhXrMnPUsHVVNuIF2Sia8pCLtK4Bbq9jNdDQuCpP4YAH9uHRF/GqeNBJkvB6sE
         dvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792953770; x=1793558570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MWImOuQ6ypazyDauHnpT+aNeaPFSVLwAEzW6QlQDKXg=;
        b=hmIKqSTYejN86JdRZ3n0YYvkqXbqOE+unBdOpFovXmORziOe4/tkOPWsc4rx6WNF54
         qQSdBLV1reN6lsd7RHgOPx4VD3HP421RzSdN7R9nTHIxjb4sHaGqRjG54BLR+VvavcFw
         VemvOqndMEHiAzfRAQ+u7t3rI2QOfyTv273tvDrf7m2sDm3qxrpiRfFrPUeFJKXMrrih
         k4weRA3dKcEF5TWr2UZm1lBu1qmjQxG6b7u0zOGEDBZNnrRCzzmBcLjPn88826TvPPA8
         m3XyVW4Q3pWfP2FTHmsawM0i+05nTa+1UbvOk904OgulpwmO2OvtebMIHvd7gcnw5OFU
         /aLQ==
X-Gm-Message-State: AFq9FYK/ILUPh4BAOfr9NbBHwW5a9weqo44LWKjgVYMtN9qpn3Q9I86n
	YWTQ8M2sT0zn5dKp3TE0SokUlqMm2VlJ2LU9An5991SKceAStPiOU9MOtDZXGiM620hK4jlTUYb
	0Fkz/r00rIRD0qhoMxHLd7LWZutt5rAUppfQca2neilXt+TZe9RK48adFz7mZeWsrIZEG3auir2
	disbt+lT/jNHvvrboDTcTA9VGelUjfeMPjWJ2WLFnHOqGaNbgWgA==
X-Gm-Gg: AYBFou0/Kn8l8t6S+dN2hpN/R2C0648PFLMrx7d4oEyMRDHOCU9JH2fyAlCY8jV8xTh
	nZ85zqV7ASo5G4vRcx4I9Q6UQHhzVJsVdiy58GmAaebeVL05xuboZeobZQllb5noK6FEY6rc7L9
	VFCbEZzxrqhvwd1Ca8WUAqf0+UBrmaIuVj7BvE/xc/5mcOkQbSbXhqXtvGLSL0uKA4cfWJL6otK
	pyxK9fgFmTbYN6qIs0NM2XJ4zaI6upawNn3GGPqmWxjKCyX3LANB7znfCbd4PuQurecHfYJovmb
	lqsXXgh81eHq6soYAwf4/tWGdn8O+QTA2k9g+ItCzWsR63I83vHMFa1IYnIFmkmuX3/8UsTs8LT
	mb/mokCNpffqBy6dDgK4VdhKbFmZgaleX+vpGF6ezZRhACBeJTaKBphRaHUW6wOvfx8BS/qPB2o
	5ZUihrVHTe8J7utVCzl7PDO4qmxyWeT8Z7xXwztKEg4XKpHg6DHmfUvvPknooFXlwJc95XlvR0G
	q8=
X-Received: by 2002:a17:907:a095:b0:c42:24ea:3227 with SMTP id a640c23a62f3a-c46bde93411mr663664466b.31.1792953769866;
        Sun, 25 Oct 2026 11:42:49 -0700 (PDT)
X-Received: by 2002:a17:907:a095:b0:c42:24ea:3227 with SMTP id a640c23a62f3a-c46bde93411mr663659466b.31.1792953769487;
        Sun, 25 Oct 2026 11:42:49 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66e51fsm230750866b.64.2026.10.25.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:42:49 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] dcache: export d_find_alias_rcu() for modular filesystems
Date: Sun, 25 Oct 2026 18:42:41 +0000
Message-Id: <99467b57d12e5b671246aa5e216ddce3a7dc3923.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
References: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CephFS subvolume quarantine needs a dentry alias for its RCU ancestry
walk without acquiring a dentry reference. d_find_alias_rcu() provides
that lookup, but is unavailable to a modular Ceph client.

Export d_find_alias_rcu() to GPL modules. The Ceph quarantine state
handling patch uses the export with the helper's RCU lifetime rules.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da67c608704383086c3facb64ee3b3b..13ba553081b33a54fd8d1cac5cbc55d0149e4ad7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1248,6 +1248,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
+EXPORT_SYMBOL_GPL(d_find_alias_rcu);
 
 /*
  *	Try to kill dentries associated with this inode.

