Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578028688C
	for <ceph-devel@vger.kernel.org>; Sat, 11 Apr 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775898122; cv=none; b=d4WTjc5UwC5N3BnEw8VMMUFpYfZJRBD5QtRLO+j+22zSOVLRhj64Or4BiKDbhkNjGMR70GrzBT7ZGnglk8R0EwF7BdNnM+IOLQRSnCVM3u/u1LX91s48fmHZWSOgdQkbYWCxluAZbHNPtwRXblQtk9HzxWZzGwSDVHt1Z5aZmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775898122; c=relaxed/simple;
	bh=PgBOqvLkZXXlMehf33vE37wfvtcU7v0irRhefURrfE0=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=hOz9D75CipIveP/I8UPUni5aqWHAb9x4+YSDlwT/mARNJ61BkrAynUaBel+pPLaPgNshs84TaW3SDCPnIPxXGsta+XivTnhw+xZJj803YjzTHgT1TlUWmHjpuTeDkdnT8tv6Va4nmrnV4i7aH5/lDMvYDKKpeVPsroLiswm6C6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1hjQaeO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1hjQaeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775898120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgBOqvLkZXXlMehf33vE37wfvtcU7v0irRhefURrfE0=;
	b=N1hjQaeOy0KzebFr0jwBIBDrKFanHaGA8WE7VLLRY97YIMZ8PbSdFMyH53ZMi3ufKSrtsD
	5LjxKHOxa1MTjmkH6ojml1n6Xmg9Ejv93Bfd228YsC+oWFbXKxqHuK9oRtVVpuPKVfuy9E
	8xorUUUY7yEoEfeQsQsPfStpcwpkdpk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-fDuhLqYOMZS583ifo6Dxtg-1; Sat,
 11 Apr 2026 05:01:54 -0400
X-MC-Unique: fDuhLqYOMZS583ifo6Dxtg-1
X-Mimecast-MFC-AGG-ID: fDuhLqYOMZS583ifo6Dxtg_1775898113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FEF31800365;
	Sat, 11 Apr 2026 09:01:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC3771955D86;
	Sat, 11 Apr 2026 09:01:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260411085643.3221565-5-dhowells@redhat.com>
References: <20260411085643.3221565-5-dhowells@redhat.com> <20260411085643.3221565-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 4/4] netfs: Fix netfs_invalidate_folio() to clear dirty bit if all changes gone
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3222154.1775898107.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 10:01:47 +0100
Message-ID: <3222155.1775898107@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fixes: 9ebff83e6481 ("netfs: Prep to use folio->private for write grouping=
 and streaming write")

