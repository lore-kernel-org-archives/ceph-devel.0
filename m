Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0857283142
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842349; cv=none; b=SI5ROF2yvB5YoMk/56ikq1W4ZG20jCNxFrePv5JIlNgFGXVsnjrMI0rh/yq2B6x0F7LWfYLgYXAe0UlRdKiNouRgCPPjqYCAOHTP065zz4vwsamcElIUce9koHCHtAg0Fj28R2X9uCKPt1dD85TGJXaWtXpNEFbr2zIz5Ttl990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842349; c=relaxed/simple;
	bh=qV9AQ3KUIA3ff/M9AFq1A+oI4EANxSvA1tSBuVs6lUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GoSZudjWjPTWUwLMmgCOZliqzNodVKG444+iTnicD3PbnuChnaYBR21NBJnCP1jvBa2r14PVtqITL0lIJeH9U6/wDXOjoVkVLbVS01jRGuoP3ZJ/5iT7ttI9oqK2hbbkKOUyie7A1XL+t3Q8WfRkPxw8gJDsLPFHzLu4MRkoIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtEVLRdw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fegLdLPV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtEVLRdw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fegLdLPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782842346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gt5jdHBTeMIecPoECU1Y6yFq5iv6Ul/kJzkNtnoHIlw=;
	b=dtEVLRdwkPy4QVOYohjDD3zRWFpIXOY4S00ZN1PkEK5fdUnTNi/OCuhg1oAoAZr8VzpmV9
	IUfRRLfXSOCBo9OPCtkI+sXI3cY6blEgqBErMq7401GKbHi/o/dvRD38bq2lEOrJcWPSdM
	/AygkuS99GS4Uvpx48k8hmteKVnzVSU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-C_eQcDbPM0-viiWK_V452w-1; Tue, 30 Jun 2026 13:59:05 -0400
X-MC-Unique: C_eQcDbPM0-viiWK_V452w-1
X-Mimecast-MFC-AGG-ID: C_eQcDbPM0-viiWK_V452w_1782842344
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c126fae5f46so174588666b.3
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782842344; x=1783447144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt5jdHBTeMIecPoECU1Y6yFq5iv6Ul/kJzkNtnoHIlw=;
        b=fegLdLPVYGEwLhCVz8QUYWa0Ayzn+fCvpT5nPu6A9S+L8yLyvgM5dikVysa9hq/Dk0
         aStSFqPzzss6A0KBNcXf+OguRQjbSTdBVuTMsoU5isErkAgUiAxCB0WO0JZByneUQGKw
         GDCPARu5DEUbuHcwSP67ZkZX/cYf1yg/HCxXKbgSBt4qjl0NmKjhAlN8bgDv7F6JDsTs
         bvr9TbAvVIkobbjUjZ5bF+OdTb+XER7ZOB3aVlcJ2RT7LoeJfnoyhbqMjKCCIbxfn3fw
         0v/SbZaIYfcZWQta5G2jq0AHoeGFrQj3dLav4Sr98a0KreXznxlrJ9bpd3ov/7+FYMCC
         WAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782842344; x=1783447144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gt5jdHBTeMIecPoECU1Y6yFq5iv6Ul/kJzkNtnoHIlw=;
        b=IYhT/gcOdYl0WlOhlnHkcXZeIKfitUe4qTKZqaITyjAVFzUZqrPCw1FyJcTUV9eZ7e
         Qbpo9S07ReRkP0oI1E0ZX5EGUx2iRfD8aNnL2b3GHNmdlRi2+9dwRgGtAEdgiG4qNzF3
         zAtLx6W6dhZaGcvMYcUqc9V7+Bt6pEQxC/RumLZmnC3sFWKwcOLopnuYwFnmB+f4DbR8
         afKrajSVigw/gJWk983db+aiTm77/o3tDJRyoiO21vrSWiU+XIC+7rRVfoOLtQfr/JKZ
         yu7R1l73WpqV72zII9c0fiJp1ss4Z4sVPmd5GrWfAoPv8myb5FJGCchSmuiZzlK85isX
         tSrw==
X-Gm-Message-State: AOJu0Yzbq80YAMTGR+8hCopD4yBCaebnZwJKeQsa0VEdmoDFETmrx4Da
	kJhdB65c89YgeILGuTUwkSQo/sFAheg6bmNK/mq7VDyCRO6WR8RU4s3eEbrUVVVyFjT6h5no+Jh
	i9FwPG6qs5T5lBpgZCblxg6fhFzErnCqk7jONXYcbTyCCRfP0tT4lKr6sDXUJlgi1JeGuDNKNVQ
	==
X-Gm-Gg: AfdE7ck5tJsxzsZayk5AxPHXQTnncf1qxwEtyR5UtUssuCYr3MqSh86Ix/eqXzBRyPp
	fN50QFVwfsNjJDFKeITRZtLmMCiZTg8V791/bSkkyW/Et04eEPtRNl1dHe9MGvXl/v2rYMdH0ba
	dG7kvt1VDI1QoMf6lj3Vr7V/XY7DW0YKvPEPxXl578iiuzL3E8ZNcrFCEn2bnj49a+RB58DYtFv
	61bY3llK1QUdvf2+IxC9S70eNV5kC2TV5Rn4L81ySoi91yJUNDpFsGZ79yHmMRtgQnxpwwqeqnK
	6xhdaXwBlJe4GNZurRFK6dfRDjQkzPUWBwEliR5fK3m7qCUnowe5+cHCU8TxKAMAyrQI2dqObxN
	h8r0yXDxQh2O30CCfA3oNNol8Z3lR0JcdcB2X8h8msxgl
X-Received: by 2002:a17:906:9fce:b0:c12:79aa:8286 with SMTP id a640c23a62f3a-c1287175363mr249741666b.21.1782842343669;
        Tue, 30 Jun 2026 10:59:03 -0700 (PDT)
X-Received: by 2002:a17:906:9fce:b0:c12:79aa:8286 with SMTP id a640c23a62f3a-c1287175363mr249740466b.21.1782842343287;
        Tue, 30 Jun 2026 10:59:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1289176eb0sm162685466b.63.2026.06.30.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:59:02 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: add 'lazyio' mount option to kclient
Date: Tue, 30 Jun 2026 17:59:01 +0000
Message-Id: <20260630175901.447861-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625-lazyio-v1-1-db13078789dd@clyso.com>
References: <20260625-lazyio-v1-1-db13078789dd@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

The mount option plumbing looks good to me, but I have some concerns.

The main issue is where `CEPH_FILE_MODE_LAZY` gets added. `ceph_open()` computes
`fmode`/`wanted` and may either use existing caps or send the open request
before `ceph_init_file_info()` adds the LAZY bit. That means the MDS may not see
the LAZYIO want at open time, which leaves a gap in the case this option is
trying to cover. Could you set the LAZY bit before `ceph_caps_for_mode()` and
make sure the atomic-open path is covered too?

I also think the LAZYIO substitution in `try_get_cap_refs()` needs to be gated
on callers that actually requested LAZYIO. Otherwise an inode with one lazy fd
can let a non-lazy fd have CACHE/BUFFER wants satisfied by LAZYIO, which changes
the consistency semantics for that non-lazy caller.

The revoke-side accounting is subtle as well. Please double-check the
CACHE/BUFFER-then-LAZYIO revoke ordering and add coverage for dirty/cached pages
under LAZYIO, so we don't ack a revoke before the covered state is written back
or invalidated.

-- 
Alex Markuze

