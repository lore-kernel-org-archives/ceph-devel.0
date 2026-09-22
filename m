Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131153A3A5
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075730; cv=none; b=ljk+xNEso+uGgROU3zVpOePXPJsE4IDwvNoM1XCuPLPdIZh5vmfNrp17qzIveZEVFjxd1REC6EJU66tQiVQfs52NqV5gz1Z6Z4ZprlvmbTQgrF5N2xnPY3r/FmK/6CfjY4HcXysZeL0ySK7SxtOtkZ55Pc8MC1afFS09/vHdzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075730; c=relaxed/simple;
	bh=onU/5/kT1hiHwApG8rwpT3PI4XbL2fj4IPsBDnGXyqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ru5wKsYMtfxB9uvxm2pBeUbeaAMiANtqzwEO0Wp81zdPnwlQyx5LguhE3fSiGMqWNufyaQ2SLdXSIxUIpVB4qqL0DaX7nZwlRass4afvGqedTLu8feJoxMPybSHJ2gb/m/KJpiEGZ7kopA0IcscC9rgzqT9lcNXE6ENjnjYc8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cs7us13u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d68oNJj7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs7us13u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d68oNJj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
	b=cs7us13uspkjGoXHEZBtP4xcfR6pNbyKH1kXOu1JZ1RK5fTWCGe0FlNuuERJD0aDSnLjNM
	KWXHSNnNvlvze3EheSjsx7Q/t/9gzFei3wgCw4y/KKMI5eBXEyLAh4On2qpfbSDbORt2tA
	1LYS66FGGEdxFKdztPduKK5lgDjRddw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-DzqQ9v78N9yVRc0OmAPonQ-1; Tue, 22 Sep 2026 07:15:26 -0400
X-MC-Unique: DzqQ9v78N9yVRc0OmAPonQ-1
X-Mimecast-MFC-AGG-ID: DzqQ9v78N9yVRc0OmAPonQ_1790075726
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93bfb2da664so634643885a.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075726; x=1790680526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=d68oNJj7mbzm3PtnWP+1kO1pR1DLvJ8jeryomPL4DYN/9QEyIZZLlO2Ricy8UHsie8
         dOy2SwcEgrCAD9lL4NMJA1jFAFbL14FgP07O8bQhYBGoIBHvZPvH5DHpHnn2yggVteJw
         VlDZOgEHszdQZxu7HU2N6yJUfu1zovKAnAr1iPqFycJCg7OcApRGv2lbXGZu7k9eAaXU
         kpDV44YrjSSvbrJlJnIaFKwxK+96H2nOpBpxddeHfAXRj1UJVLZhkTPEsvwn8IVZhzod
         WCU6NEKCIrGgavxcjcBbbg1d1KQI34EWgCxYgSdPdKx2SORkgIy7g8QRx/r6QC5fpTDy
         fxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075726; x=1790680526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=uIehB975ckKrVCsNJ149b714JfHy5wk60f3Cq8uEqYVAo8GvUVmrUZW+8I/Eu6v3Y3
         34IHeGbik8XQo37X8E4KU6mfJbYvUEGYbo2GhHylDBe6hhtBZQyZ257io3gQd70ExgBy
         H620LzoCyUoJqlO2k+2tUgfk3zf8i3KRDUT1vzZ7OlvIqn3jcLoUa7/Mst6I30GZGchG
         8PN9IBcsCneJG4WhUTK2eDeuDVDhXScZilqkU5agUUBUSpXDmm5kRdVi/F1XKLJE32qg
         cRmHCOyZbiDKvlggWxSEgsN97SyzZqHjSkUDD5V1g9DgMTa+fEuTtAMF4S4dtn4iasfw
         OPfA==
X-Forwarded-Encrypted: i=1; AKwUvByZYJnA3hqLiUkprqHL6J0Cuc9PM5CaeSCMwSPPpAH3rj2SZ/yeZQTAmiGqeos0Wo2LGzsK8CgrvKBg@vger.kernel.org
X-Gm-Message-State: AFuF++ksM9N+3/jzwpHTEPrYoFhdwtxOj93o2JV+8i46awo7j4sZnown
	BUhMP2DzlmxpNlICPcAUuyvw7o2hh1BiklRayY5BtYOLTgPnIK6OFCRMUj+UdqtfbZILwf3lZWU
	W5DLzOYTeYwEhMkRPABJmVvM8SMxDTBoCeg08YDXhYRgG071qGUMQeYGeSWuydVo=
X-Gm-Gg: AYBFou28Y8O7kT2bxo+AqBs3K4D+J+pLNhhJDTaNig+ZXE3GTswcDtqZk5GR0kq1wGD
	C2tcfjoH597FHciEMuf2ULsCji2CHaMBEGdMpfha6Ybw1Q23ioVxatML9+8wz4z8KwmOnxdmIIp
	La81mi5szWknz3SDUttjJt/ePHYpsdDJ16lgMj1raYgqmwyYVLUL/HnTW/9U02vbllQiHPDziDs
	dR5NYBAqeFharNeKW/7n65ytB+dsuncNGULk0JYC2L6o1mynjxF4KJ1iVGd+2CQ6vqLejn8HdBi
	VdcpNvdWT5VnEUDrjTn9xdLeSw4LROf8IkqAb0Z9FXBjpoXE70QWEMZ4Ya7/OzEGqezG8MqyAzL
	X3CKs4lps8ziXYcUUjjoCEj2Zg6vSd1BQ6tsjgNWU+PX1uMIRjqQRMv09yKW5deuzS5SPF8T0lt
	MaSWbK4KwjDt5q2A==
X-Received: by 2002:a05:620a:2893:b0:937:d6e8:59b0 with SMTP id af79cd13be357-93c15d69efdmr436712285a.10.1790075726153;
        Tue, 22 Sep 2026 04:15:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2893:b0:937:d6e8:59b0 with SMTP id af79cd13be357-93c15d69efdmr436709485a.10.1790075725744;
        Tue, 22 Sep 2026 04:15:25 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1cf0dc12sm118533485a.5.2026.09.22.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:25 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: libceph: Fix multiple unsafe decodes in ceph_oloc_decode()
Date: Tue, 22 Sep 2026 11:15:23 +0000
Message-Id: <20260922111523.767373-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909150353.1164805-1-raphael.zimmer@tu-ilmenau.de>
References: <20260909150353.1164805-1-raphael.zimmer@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Raphael,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

