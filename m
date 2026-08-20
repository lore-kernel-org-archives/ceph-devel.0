Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87E3AF662
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210614; cv=none; b=iRdlTIU/xaFUlfYB0H3MPYitmzSERtAJCaunjcMxhxuE1OG+BImdlnhSwNlQgrCYbSMuhBJt/UY0c1bztusMc8Ipz7rxHASlypCWxmW79TLS+ngN25a3prJcTVBiCNWTJI23bZ2W/u4Drit1AMHNd1WOxo7HOZoDNtxNWp3nd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210614; c=relaxed/simple;
	bh=Xh/93Th6M6YozRdf/QTIg9oZ20Uf2iCJxIUALyHoBnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXrgiVKEfjCQBt8ODTo4MPAKa/zyDX0CPeCIJhbBHfr+wZZxAc0+dTXZrg6EAUh6B+ICVFaao7jhL2l2Eso9bJm/i0o5xwH9su8hWJdaN5mKIzCiX3F5YBPHssqUi4NwoZ4bVao31eR4pPB2amwIbDeuwPxcKYRA919lOFJnleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGLO8/zB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHExQyTY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGLO8/zB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHExQyTY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787210607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xh/93Th6M6YozRdf/QTIg9oZ20Uf2iCJxIUALyHoBnY=;
	b=PGLO8/zBLsKazJZ4CP0ezor9wV4FTUfCHe7npmrkHciK8BSeMmfQ345syCI9hVZfzQ0aY1
	JnCIaR6qHeqkF8+PkjlrcXm7vobM6acfHB8e3jn8PyQTkH4vo0Atv2zZm8lNwoC/D/mHTo
	BKq3v1+JrVycn1SCCEnphVqbbpaffLo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-C4s8ZDjGPPupSekl27RvXQ-1; Thu, 20 Aug 2026 03:23:26 -0400
X-MC-Unique: C4s8ZDjGPPupSekl27RvXQ-1
X-Mimecast-MFC-AGG-ID: C4s8ZDjGPPupSekl27RvXQ_1787210605
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c16740eb587so146590666b.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787210605; x=1787815405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xh/93Th6M6YozRdf/QTIg9oZ20Uf2iCJxIUALyHoBnY=;
        b=RHExQyTYNzq5NQSR8tQLY3nnsgw1Xw1MOv6AogxwBXS1efP8qoPsNFDZCqDE7RL+dI
         Z9jpTgVSforikTyv2x7RTVA4q3WITt4ZfY1WyL3EbUxo56Un2SatOPi65Xg2u1gyMWul
         LefviVXKaAYbaHEf+8kG9UqcqgHGP+CsfVJL8UFNAt1eyLCXttGgeiQVvZD6mjSyGqFS
         OS4Z45G1rt+8oXRH5xwsv4KhGYmw8y2fPhoFhf7B6EOVS+TBXdAaMvtHwPzIICbmU1Gz
         UClcik7rqYBuQ78cQYWc+kula9GytyP8x57bQXzobNhUrwjigiUyvbnIRe0K2O3hQZ6S
         hpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787210605; x=1787815405;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xh/93Th6M6YozRdf/QTIg9oZ20Uf2iCJxIUALyHoBnY=;
        b=kwjQt/TEvDU24LapgSlzpUL+GruUZl3VNrJDbshfB16gQH80qVpbzJptbcKpbeWsuO
         3AQ65sx8AmV0KAGJ9TWWEuElJkFWbWjPxHtNhw3Gxcx3EiYSd6si67Fm00to9LR3N4IL
         JcMLkRLUMFEk/OwREEzrAotbP52vTrcHWM3PTQroUQ1jZG6ocgz1YwU2xJYGDirv7HlR
         pjzZVbGNxv6E0KFVmavrkhnCmGwxrbkPomJHtuOlRGTrh9wW14cKUGcK+vd2sTcGHBR9
         xrosUvMOhUHB7j/Iv8IR7oTCl79YIRcT6E3dgYBM1NrXToHI/sPWsarzH32dKqu0sL+3
         lhxw==
X-Gm-Message-State: AOJu0YzFu6vZqTOhtwoZwMl9c7U0hpH613xwdZqPVgVoSS2ky5CljJCG
	lC2ekB07pZ74dbxPq2la8D4pUDVzgJzPZLKVTHTxccRvB91+8Q295cZGB7syZRXm24rEZgxrZG7
	y4NipGua+5z3qaUPzcgv5jqWedkFPyeyTbZ+tZGyR+2DB6DgL+sPKcpRZeAw+gsP4EVPwEvG6sA
	==
X-Gm-Gg: AR+sD12qe+JSSKleCX2UH/9SfrCC/K6q9etBFXa6w+BEvgxvX2nFtiYOquOpNOkYXk2
	8kCmW/lJ6NfRdfPf82TSGYErqWYKgPvhDc0rTMD4tSlVPDEFwHSov8Esh9PdvBfGISsHJjo43dA
	7+4BUh8tnHN8QJRzQIYX6qv2dPRtixIlEUwlNYOFw0JUSY0FLJnW2+yiWvWw62Bp3VoSUfncJas
	2KbJUrvhMURsFGqyVzAWPeBgt6ZUbK9KgpF2iDqNDMVVVKbteYUeqnoqrlqg8eHT9XBnKkkWKfb
	GGSLj0S3e1uRzyQ6gbz68zw1+NDzoE6q602pnDEfpX+qzsR2Vxq7m/VmXIZOLAh5uXw66uIKOYS
	tdd1V8sgdyDY7W8E8SY0VifiDDjgJIm/QIQ==
X-Received: by 2002:a17:906:fe42:b0:c21:9cf4:e1b0 with SMTP id a640c23a62f3a-c23f929e249mr698338166b.3.1787210605067;
        Thu, 20 Aug 2026 00:23:25 -0700 (PDT)
X-Received: by 2002:a17:906:fe42:b0:c21:9cf4:e1b0 with SMTP id a640c23a62f3a-c23f929e249mr698325766b.3.1787210604588;
        Thu, 20 Aug 2026 00:23:24 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459223b9esm34523066b.62.2026.08.20.00.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:23:24 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: don't unregister an MDS session before removing its caps
Date: Thu, 20 Aug 2026 07:23:23 +0000
Message-Id: <20260820072323.2180183-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818165053.3514195-1-max.kellermann@ionos.com>
References: <20260818165053.3514195-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

Deferring unregister until after remove_session_caps() is the right fix
for the BUG_ON. One gap though: check_new_map() wasn't updated for the
new invariant. A CLOSED session now stays in mdsc->sessions[], but that
loop still treats a registered session as live — on a rank failover it
can overwrite CLOSED with RESTARTING and call send_mds_reconnect() on a
dying object, or in the export-target path treat the occupied slot as
"no session" and fail to open a replacement.

The fix: in check_new_map(), skip CLOSED sessions the same way you skip
NULL slots.

Could you respin?

--
Alex Markuze

