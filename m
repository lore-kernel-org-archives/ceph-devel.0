Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC54C6507
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557420; cv=none; b=Caeba04Q6mTQDqo5IfCExXLKeso/PK8mVLW1JLyNDEd5wsZ9hAYhJ2v91eGJZZPfQez3lQDwE/6g2Il3eiF+kHVP5BZBvhP3n/k8vFeN/gMGtb2kEO665Zj/hZ8VSWy8cgtDgYaAMTrqQ+MmsBVUULDd7l2PEKXbufN7czlEF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557420; c=relaxed/simple;
	bh=QMBBcDwgjsDjyl3EBe3JFAp/DeQlExENh9tN3Jkup4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1//RWu4RbztbMekLA+EW6SmH7He09PY+3ZwTkfwnZkegUJRQ6lfPGgyJjz4kXbF44QoWbMymycbeKHmBW3wLgi4NfbpfBxDpwObHynCMkurJFdu0m7ZLsNoPxF9o9+MNTTt+IVQ7ly8SpPLxbpiPfPfPYCTrhWTlgLrQtMY59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=enBGoHc9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpBa0oqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enBGoHc9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpBa0oqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791557417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
	b=enBGoHc9RMNkxCvRD2c8TYF3/4Qa6itjGVdPONhLMwJbDaQRYwUaHpqdM2Bor0ts5JBugZ
	83aRRGaXgGHJfxLZrXjX9tzkPJY9JjcHm2LrTJL3ewRtkeg+uAwdmLJY7LwQQFfjkuhtSg
	8+2gkR0jtI7uLXPKLuWnnz8bg4qzoOI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-1fVomzz9OGqv7gRky0zSYQ-1; Fri, 9 Oct 2026 14:50:16 +0000
X-MC-Unique: 1fVomzz9OGqv7gRky0zSYQ-1
X-Mimecast-MFC-AGG-ID: 1fVomzz9OGqv7gRky0zSYQ_1791557416
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917b7dd3f1dso108421116d6.3
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791557416; x=1792162216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
        b=KpBa0oqTj9m5sD41mCfx7jGDTOnLdHFeZUPB67cJE+y/DXq5ITUrYNE2jmaIzF2sAS
         yn47mDu9Scz+ie+NxBLJ7INu2cefHnqmJ8uhblfw1GnT6zke16lQ0RA2qj0st6zY96Mi
         8RVokFXlBz0vU6x5KUvj4UVBtLyHebY3TvE2dH37638/HZyeb3DFgV2MsxQkc7Ag15KX
         vptR0DP2JMZ6ocV7Nq8R1pdlyy5goDIFUinfqmMeWF8Ze1RQ6vYSiZyDKKqy62/XzCKz
         LbBFBEHo+E2N34l6FqYzZZ1tpEr5hmUlrnFFOPJLNvUKl+T4mkV6HozQ9+q3gFjjLHo5
         Wmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557416; x=1792162216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=denjLYVgwbF9iEIwmMqmhaeRtlsrnClW1EGbNR+b3NA=;
        b=OZSSTH0b3nlCUTDfciPAhZ/lcHuCHQOfVcZe9XKKxe4lJcp63IIXNDHbf6tMVRdodb
         J/daU/FmW4T5LrbWCAVSd+CavxmBtQot+szYzzpVU9IeW3/mHgFCGJV+Kl5znzt8zW4P
         dzLosoVIexJrfT1yw4bmVk0oooa9sq+U2vKa3zKHjoOzJ2wDm+XTgHamIcguZkh36mue
         /CV7sFO/fju2MgwI7SKPYL5C4vVilSwURCcINplMPd0NJPIYKpb6NZVk+rX+194iG1xE
         p7v1Wg3XEGwojmCsSuu3b6JhnCPr827H1lohaQ+Fzm0cJvy7MpruBfNKcsd5tsOlzjr3
         ehEg==
X-Forwarded-Encrypted: i=1; AKwUvByziM8g6Om49UoKz7GodKE443H5wLqX9SDUn2HGARyvTp+iq6GBJliZAGUlZOeaZGkF96/TvBjmk+Qx@vger.kernel.org
X-Gm-Message-State: AFq9FYKYJmLvH1XXwr4zuZwjI2SETwFHsZdabTvRm4yhD38oxcqY6AqP
	uJivlWenUkUf+kUxg/W2S8WFP5kLasJ9LzVnF7u+avvv6rUHp92UHZKeTjBgHRgEu1hKAqhw/DB
	h5f3BjPzGFGGX6yFo07bkuKy4nV4hoR1WJmg2kJuEodsjgmovnLkSe1XxdnvtOPU=
X-Gm-Gg: AYBFou1yRkZFWLIjOjXYLVSi1G0UhULU48+XV6Shzzqo/g3Py/aVx2sOSt94vqLeAZA
	YgE0Fg2Kft+bs4eVfFwZ/NLN1TJ/j+9dULNjvxmj6OO/5qOEtgpHKrOE/aBuQXJMy85JoD2Zb5I
	I9jZ+VSijp7ilt/HzjxhkSlRIXmcYHnnE4swaQkzUrk5cmLaYFxFj3assWPdnCIp2LSsNcVAU9n
	mGNla8eOzDTop1lpxNus6l14jQlwk0JgdIcvBT/IXgKvHfBXNPkxpoivPGtZfqnSMlT8oCgjtzM
	FmpnUUbh6ZW2if0HbwVvj7LJEO8abE1rnzLSBcp+zvIgGW/CxQvtecGEhlzR6THBgGyHHyeU1bf
	0moMc2n/j38OCXfy2A0l6oKTqZ4imz27l8EsaCdJg0McbN4KyYiE6QUHVYfGfBbF9yMtD6GuMji
	1ahj6VXzG0ORqXMQ==
X-Received: by 2002:ad4:5def:0:b0:91b:53e5:9263 with SMTP id 6a1803df08f44-91b55531337mr36208396d6.21.1791557415668;
        Fri, 09 Oct 2026 07:50:15 -0700 (PDT)
X-Received: by 2002:ad4:5def:0:b0:91b:53e5:9263 with SMTP id 6a1803df08f44-91b55531337mr36207516d6.21.1791557414875;
        Fri, 09 Oct 2026 07:50:14 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550dfb6csm20185456d6.45.2026.10.09.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:50:14 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [v3] fscache, cachefiles: Fix resize handling
Date: Fri,  9 Oct 2026 14:50:10 +0000
Message-Id: <20261009145010.2380147-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1091807.1791483394@warthog.procyon.org.uk>
References: <1091807.1791483394@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Reviewed this on your netfs-next-5 tree. The resize helper it changes is not in our testing branch.

For Ceph this is the right split. ceph_fill_file_size() stores the new i_size before __ceph_do_pending_vmtruncate() trims the page cache and the cookie, so the worker can no longer see that the file shrank. i_truncate_shrank records size < isize at the truncate_seq bump. Without that, a truncate that is still above the stale cache size takes the grow path and leaves the backing tail in place.

IMHO the same flag is right for the other filesystems. AFS, 9p, and cifs_resize_file_locked() still have the old size at the call, so shrank is a direct comparison. The grow paths pass false, collapse passes true, and cachefiles shortens only when the caller says the file shrank and the backing file is actually larger.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

