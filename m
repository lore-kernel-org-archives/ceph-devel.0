Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0B3064A9
	for <ceph-devel@vger.kernel.org>; Sat, 11 Apr 2026 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775898273; cv=none; b=MdwlMWkynZL16TeEwv0JHcfoqSirQFxN0Utc9PvbMUA1BqpBUJwmesMgnKttSLzN9qkwjr4jm46dKYPEGV/jZlOEhTObNc41IDv9yX5Na7nOYqTdMpKYcqsxtpyI+aT7MsoN1BxdL6CdFJdKTFVRJ8M8T46C/PjgryjbCtG1GwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775898273; c=relaxed/simple;
	bh=OoXsiXJFYoAT9cC085Xd3G5+lSv37YH35GHqonO/aQ0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=m00d9x9IZmfqjcnHZYmXFbnS0acloETidoZzmE40zWX9nWcqoAVGMdIBX9I286DQuVnidiHKly5yFtW95H096NojO3xh09idfKGEiUMnm/vM4Em++vEMdK9y2YNqPXWzID0kRkrFvzwNWcDzLW/X9Qks5HapS6DuL/LggtNpQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kl5KX7pR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kl5KX7pR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775898271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OoXsiXJFYoAT9cC085Xd3G5+lSv37YH35GHqonO/aQ0=;
	b=Kl5KX7pRljQqZwGazdUrDkN7Uo6ovO59m5KCekBJ2DnxJSipREMmRd6TP79qM7Rr/AA+yC
	uZiNI8c08r/rUDaGaK50Twwlr3rcE+zPPQBdjrEeNi4oz1iRVBaAUJwRKwFb0ygF1g0ruR
	+KeFvo9WA4y37I2A9ss3KIgUZHqdeeQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-XFkmtC5PMfuMvL4R4ZQAdw-1; Sat,
 11 Apr 2026 05:04:28 -0400
X-MC-Unique: XFkmtC5PMfuMvL4R4ZQAdw-1
X-Mimecast-MFC-AGG-ID: XFkmtC5PMfuMvL4R4ZQAdw_1775898266
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A59C19560AA;
	Sat, 11 Apr 2026 09:04:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B23E19560B7;
	Sat, 11 Apr 2026 09:04:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260411085643.3221565-2-dhowells@redhat.com>
References: <20260411085643.3221565-2-dhowells@redhat.com> <20260411085643.3221565-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    netfs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
    "Paulo Alcantara (Red Hat)" <pc@manguebit.org>
Subject: Re: [PATCH 1/4] netfs: fix VM_BUG_ON_FOLIO() issue in netfs_write_begin() call
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3222521.1775898261.1@warthog.procyon.org.uk>
Date: Sat, 11 Apr 2026 10:04:21 +0100
Message-ID: <3222522.1775898261@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")

