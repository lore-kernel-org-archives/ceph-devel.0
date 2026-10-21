Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560652;
	b=NnsBgNt69tlWIWMkS6dwEYBzSiQnS9trLwSDsXe+fL9JprLBf26vvQXYVU7qVT9ZtCGs
	 biuxb6T5DJ5a0COF4tPclUBHH8nM1U78QB0CwEt+N236bSn3ZOEFmvUv2eLhFNEnFVLLD
	 IUILbTExlrT6GxYSky+ugdlypYwiJ1bCdS0v6gAQi4VBUE861Yu2NGk4tV85tyXqfNrlN
	 0SXDX1WoAVF1zUEXuyFtenpmifcUoEJ1RgkOw8+7wMqr39fug89UDLXaEz7B5r+WSa2+T
	 Ny7iZv0O+3PN2BtFuWdQjLx/21VerRziSnPBTDlApMUpGnqYbef0sNgAuSOGGn+rU0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type;
	bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
	b=ZX63sbiQkEj6ipq3MFPoTrhPfl0ZqnBuRZ5zCJ5l8M6CCyb0HVHyPLvjWNJz0tH5DMkm
	 5jkN/AkxzVQVv72q3IqgV0d2r7kaEh2fWKrIrg/SjNcSYTAy2ef8US9RfOvqqIiLHkONL
	 arsHn+1XatOgLQaBcnoKbC5VbNsMlIWNWhRC147u3LQ4sXcD1rKltN/mcgK0BzOPDiGnE
	 kDjVxN3q2G0xI3WCv9q7CyFB9xD/d/O+uiaPtDyv5OoO0rvVdRjdQbaRFZ9DK4BLtbC/9
	 s23LR9NoGpatLKsnPxk1+I9SfN/2huVniAIW3zRNU6s1Qj/FRwvpcOowX+FUZHo8e4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innovatrics.com;
	spf=pass smtp.mailfrom=innovatrics.com;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844D606A326
	for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2026 05:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E844D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innovatrics.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1f68a9855so1635445e9.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innovatrics.com; s=google; t=1792560650; x=1793165450; darn=vger.kernel.org;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
        b=dZG9+Qrbq6r8virMQzN/ZnScSqFL9UpktW2+0+n3rDobwVeYO2vFRf/TLLKIVXBmhF
         Gy8RLB4EpeJSlAY8DjkXHht8NBPQbM5e5fFurkIdO9DfEYRLT1UnIUiVHv5USugAATTU
         SMpXa/vr/CV4YYNC5DI0uYI78q0K+X5Fj4Q/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792560650; x=1793165450;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
        b=Fs3LaWV2/xY+2via/V7jwwQPqSrWu6k5Yyslxnq8SMVmKMn8wzpTWcvVHTvcS8YNvZ
         THQ8ohIxODkaqnBbv5zg/UFc4JCG9+fytw5sLWMoIhaIIiV1P6G4tWBQqZxVf2PlYsc5
         dRckfHC03BpR+z0z6uBb43vPvR/cRxz+qP5FgLwblvcF7bC9oLvjMeE7fGel3iloHieB
         2QYtZhtLqhSMBYKPljQjqXR991tYhYjmTEGXdazusy0cFDynbbw6afphzCqbyFcogkbW
         OS9il5Pj9pWY6BVVxsJwmbT5RlEoNmJ5JSzwFbDujmYeJnXHNEtS1/iLtpVDOdJAgu4I
         emCg==
X-Forwarded-Encrypted: i=1; AKwUvBzgBnej9hLNJ4emdFG6JpU8naqvUvttY0l0WXE97EEMXcpapFTpjQ7Gi37/G+wMq2/ZIJdazCDRSwdY@vger.kernel.org
X-Gm-Message-State: AFq9FYJ26X4aFdb6H8hPDp+ivMoU9NKheteqYh2IEjho//dFQ3g9lCCN
	p8tAXHd7G1ePJU+9Y43Hs8SFiT8rqLIX9z+lxxuZsfJL+WfQHUH9U8Karz/XmO8OHQ==
X-Gm-Gg: AYBFou1X3+LjDNTvuistGPRHdGqCC9mi5Ti3WqChLjXrAfScdeCgcUx8YNx4hgLczQo
	KqhpWwA0Ppt0ddIdI0OLKEujHLfJtoQv0syZuwOS7tsoRegOm605nn4wqus9L2D0tTigQf6rz2y
	2JuKtNkN4o4oXgorpFLWIPQ6mla6RmV8mWjE9sCto2iSRYmso+kh5Q0TLiLwP2KlNangIKlg2m6
	aRVpHBipupwkOyi1qVIhWmZ27toXQW49OKE5T//8Qr1YLzj5/IUDXQjGmcZynlt1Hx24cVoYz7S
	6sKpAHByhifDfgjWsP0yhrJjfVXAfcrwMpmUmAcT8Dl+s0E52PWYb85gaUIaDtQgzPttU/ESa+Y
	/Y29jps2LF0FrkOW5gyCcDJja4/d9DnI92KXs/vQVQGkAAv25n3FB7q2NeynIhAw7AbHe35DFq6
	OWQ1KeLaA6ua1DnA0M1Zt9yRb1i8folHyxxctp4Q81R8elpEbk/IKQw7XwrhkocTW9Wm0v7aytO
	Pu8qI5QpfYBU3rxkPVNjx0UdhjkA/YW4I+oNY2Bq7SYwQvgGOjZtbXVzvvvgQfKwlDU+56Iw/eV
	za1f+uvM7nLO667LhZEJbgxEzWEAtRVN+2lhQN6862LSE5vz8fnXZQKqRs4w6FUPBLa5w1GdSI/
	nQ7ducqdgD4FL
X-Received: by 2002:a05:600c:4686:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a1fd72e1e6mr17106685e9.0.1792560650270;
        Tue, 20 Oct 2026 22:30:50 -0700 (PDT)
Received: from [10.11.72.5] (bip-static-148.213-81-147.telecom.sk. [213.81.147.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm85779985e9.5.2026.10.20.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:30:49 -0700 (PDT)
From: Petr Chmelar <petr.chmelar@innovatrics.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    netfs@lists.linux.dev,
    linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/5] cachefiles: Don't rely on backing fs storage map
 for most use cases
Message-ID: <20261021.cachefiles-mainline-confirmed.pchmelar@innovatrics.com>
In-Reply-To: <2648476.1792482342@warthog.procyon.org.uk>
References: <20260910220242.2165023-1-dhowells@redhat.com>
 <20260910220242.2165023-5-dhowells@redhat.com>
 <20261011.cachefiles-partial-zeros.pchmelar@innovatrics.com>
 <1655268.1791878098@warthog.procyon.org.uk>
 <20261013.cachefiles-partial-zeros-trace.pchmelar@innovatrics.com>
 <1995693.1791971125@warthog.procyon.org.uk>
 <2648476.1792482342@warthog.procyon.org.uk>
Date: Wed, 21 Oct 2026 05:30:48 +0000
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"

David Howells <dhowells@redhat.com> wrote:

> Note that these patches are now upstream with this change incorporated.

Thanks, David, and sorry for the slow reply to your question about
the fix - I was on vacation.

I've now tested mainline (72a16bcff2) with the same reproducers as in
my earlier mail, and it fixes the problem.  All 4096 blocks read back
correctly on both full reads, and the reads were served from the
cache:

 - 9p, cache=fscache: 0 wrong blocks (936 on 13e340e397).
 - NFSv4.2 loopback with fsc: 0 wrong blocks (817 on 9f8b64f66),
   also after a server-side rewrite of half the file and after
   truncating and regrowing it through the mount.

Thanks again for the quick fix.

Petr
