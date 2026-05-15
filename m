Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B347DFBB
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845642; cv=none; b=aF3+OsQGHD+o/qyy8Vqg0YC5tDsY0fxxnk5G3SjgNRFHFB7vlTUdwk2ITMN0bo6gEdX+/CYneSBD7Hcxv46wtHqhGZdXg5CSHQbnbSOOV1fEKbZiaM9k/e26y5TGShs/7o92iZM9696QiP9k8v/dQsntFxs7tOycKFT/gwWYua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845642; c=relaxed/simple;
	bh=GVzpf8DHrtIE2e0iLrgK05eawGI15jKhZ0DshiAXIe8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hMAqBDF4SBpvyvAZtXs7LCXQmP/YdnQLuBbvy9OZgSZjjCN548AxLslr5tyRIOAIcnnJBLQaT4IjKZMRyVvEqSpBBG2FFF4ZnXzGNRzQgzim56e5GQ/kMYp1/MguOYEtGT9nMfZtNOjFp04sA5lyRUqczSRD9rxYSLwaKtFB8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iz9ePMCT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iz9ePMCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778845637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDpsJ9vTI5/XpFdT7cxzYBQrIqR/7gB5JKH/whriB4o=;
	b=iz9ePMCTOOI2Mn6xidnYCRXb2SSZCr1PUFm1c9xzzvkq2T3CleFRQYwYyTn3xGLkaXJedC
	qE6nvFuAvXhIWnwPR/fFmVPmcrisqgRtxGGwo3IXS4gQLaTfIjrvqjNAjK9rZrcd+B/4v6
	z63QjjAgpNiB/MUKpTqYNFrOaZTT1JU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-UAqYTvpgM-SMWa-X9yYaYQ-1; Fri,
 15 May 2026 07:47:14 -0400
X-MC-Unique: UAqYTvpgM-SMWa-X9yYaYQ-1
X-Mimecast-MFC-AGG-ID: UAqYTvpgM-SMWa-X9yYaYQ_1778845632
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 575081800451;
	Fri, 15 May 2026 11:47:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C0B419560A2;
	Fri, 15 May 2026 11:47:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260510232455.2245650-1-michael.bommarito@gmail.com>
References: <20260510232455.2245650-1-michael.bommarito@gmail.com> <20260502132506.1936358-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>,
    Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
    stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: krb5 - filter out async aead implementations at alloc
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2632014.1778845625.1@warthog.procyon.org.uk>
Date: Fri, 15 May 2026 12:47:05 +0100
Message-ID: <2632015.1778845625@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Michael Bommarito <michael.bommarito@gmail.com> wrote:

> -	ci = crypto_alloc_aead(krb5->encrypt_name, 0, 0);
> +	ci = crypto_alloc_aead(krb5->encrypt_name, 0, CRYPTO_ALG_ASYNC);

Apologies, but doesn't that do the opposite of what we want?

Documentation/crypto/architecture.rst says:

	The mask flag restricts the type of cipher. The only allowed flag is
	CRYPTO_ALG_ASYNC to restrict the cipher lookup function to
	asynchronous ciphers. Usually, a caller provides a 0 for the mask
	flag.

Don't we want only synchronous ciphers?

David

