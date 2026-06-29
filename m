Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA63F1ACE
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749244; cv=none; b=pzhg+Hht9xOIMTm9YqMKEFPnj29eZbWCOaGCB5j8dHFKDLpyYfBrYMYIO3pUGmSeSdV6vFpKTR+akFSVC6KV1maYPCBSYDn5Wd/zJGDQ/nxFB3JDSxvGnwQbwGIgbuIIS/jhOEs6zh4/Ug/g8237Gkm5wetnPU/xDoXnljz0vJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749244; c=relaxed/simple;
	bh=YUVV5r6Rj2+lifVBLCv26L8g4xPnTIBA5GAEh/PWfRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yzk8+Po+Ptii0wxLUc+dlc33naPZAZn4l0Vxv1b2aSmQs1gTKf7AHEINLqyaqQ486m0ByBnZRaWxpWK0S+sF3dgRUxHucQnVOaMLX7vYQn+1iJ5/ku1JSYJ+fY/vqBqxjBMsWvcYAJPbHfeNjhRu94c2Bn4bZjaGtEd1p90nGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=N4tDB2sW; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="N4tDB2sW"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80e46c00f3bso9635757b3.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782749241; x=1783354041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YUVV5r6Rj2+lifVBLCv26L8g4xPnTIBA5GAEh/PWfRc=;
        b=N4tDB2sWl4nSKpAe8R/BEKdnu5pcsolB6JZsiJdtsOE8BIVEI8ErTN49egeKxL9RlB
         3R1m/MHSrYIlJoVsxIXBxOyz9B0wfEFSMN/ORHExzh46JMnzM7EtAx8ECBTS5Of25fG2
         LuGe+ya03AwHiv7OMBUa/h8e0J+HPpG2oZcn5t+tBjc0IXanze20CsSBRQMNDmURzkzb
         kdg1V65IACP0LhZEgzmJ2RUa2AkGKaxOC+wqm6fNzueVU5cN+A3YT0zHYOo+cUHYD5qx
         gmW9F43N5qZlQAtfrRQU2B/yfJW3VEdEWCrDYl9qLYDkdMw2pY2tqmSlo1aZg2hT/uAo
         3d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749241; x=1783354041;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUVV5r6Rj2+lifVBLCv26L8g4xPnTIBA5GAEh/PWfRc=;
        b=cD24bmc5KFhLfOFRiPEUVFmXrq0Dw5NXaUSJGH+YK+5LfHMVwjkXb6piFNNxs/xucm
         h8lR+ti0Ql6PH2vuAy6Jz5kCnhico+ZCadRNMvm2avudIRiFfkw16HO+hz2O0tpBT8ql
         rct/SfPUSDnxA6r6jO7WMr34on+dZ3qJDnPt6JAgBcvxm6EUminUNep7927Nk9ayzbUd
         HtZo4UvkuVyY3LY9yXjvgYAwNqyGqSBMiylUjqwD6RQuWowevYV8TPMIldiI/jUyIuwp
         bqSakFYxGB4ewUO7Fi7v7JZ+eWfO5TBXL8Av2/D/R3X2IAfHxEbIYxqqZ9AwQ33ntynL
         kl8w==
X-Gm-Message-State: AOJu0YwU1xq1+dzJAjy8R6zXeRNKOHX9gIzzkqXXRIZLBdXbjhCOZsv8
	qm4M5Q+kb9gzlma10PoSEtEIM33IFOdFe7HPUsbvo4qjwfVYEJQpYJV3Ej+x1BxVSfg8Y2Hgd5r
	oeZcF5AI=
X-Gm-Gg: AfdE7cmgRe7R0IG8c4WwsazTOAu3QX5owfmYkc4Za+Ph/jY25DUjCv5GT/r1aCLeGAE
	ugVOfsvfoexGNLdEa38RVtTT5+JF2chqDr/Xhv9NPiqHOwwA14+9dl0I/I4kARdYuQDoD6jUc17
	URKfPv1o24RZjFNIKdDf3SyG8nG6MhN7pBgPeNoH8L/13bs7LmS8S0e3x3jSRQotr0Mge5A8aLw
	wzTpyLw4VyL/Q3znqxG82dk4Pe/omDozOIE+uq4cpfJiUghMzXkMdCoBBGwAxhyw67aRwSGqqtV
	7Z5r8X8gQYqPpEwpy6zkwQ+6dgWyKm3ubsTanOpuVTRHQpmFmnSzs5WtwHpEZF+HP+zVOnvWMiD
	usT6922NQeqe6SAzkvk5KcOiqJ4eaolRRgeWQdBSOoppy1YRYKwNDWcDGVlkTmcEMIS0RZn1wAu
	KMiKm8NFgN79YJJ7vkeypad/iNmoG00dn3gzK3A4PMGvYIkdusoBjWzZHoU5CZjhgJ0GNmzZKPZ
	Av93qQ/OI7TW0LzNT9y/6poUZdLSOYw7SEgQCsdxfiR5QdeOaa7iVaUxY9x/HyjcifiMSjheRJ8
	9/Xojk4=
X-Received: by 2002:a05:690c:490d:b0:7d0:79f:339f with SMTP id 00721157ae682-810d990871cmr2021427b3.34.1782749241303;
        Mon, 29 Jun 2026 09:07:21 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8de144sm118033567b3.25.2026.06.29.09.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:07:20 -0700 (PDT)
Message-ID: <53bca5acac8aae5222218649745658d546a01195.camel@dubeyko.com>
Subject: Re: [bug report] libceph: potential out-of-bounds access in
 reopen_osd()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Mon, 29 Jun 2026 09:07:19 -0700
In-Reply-To: <f26c5b29-f72d-4c7f-a87a-0aa5e53cbfbc@tu-ilmenau.de>
References: <f26c5b29-f72d-4c7f-a87a-0aa5e53cbfbc@tu-ilmenau.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CC: ceph-devel@vger.kernel.org

On Mon, 2026-06-08 at 10:45 +0200, Raphael Zimmer wrote:
> Hi,
>=20
> I encountered a bug in the libceph module. The bug manifests as an
> out-of-bounds memory access when attempting to access the osd_addr
> array
> in an osdmap. The out-of-bounds access can occur in reopen_osd()
> (net/ceph/osd_client.c).
>=20
> The problem seems to be as follows:
> An osdmap contains information about the OSDs in the cluster. Its
> array
> fields, such as osd_addr, are allocated with a length that
> corresponds
> to the max_osd value in the osdmap.
> If a Ceph monitor or OSD sends a new (incremental) osdmap in a
> message
> of type CEPH_MSG_OSD_MAP, the max_osd value is updated, and the array
> fields of the current osdmap are reallocated.
> If the osdmap contains fewer OSDs than the previous one, the size of
> the
> arrays shrinks. This can result in having a connection to an OSD with
> an
> ID greater than max_osd, which is therefore not represented in the
> updated osdmap. If subsequently a connection fault is triggered,
> e.g.,
> by a malformed message, osd_fault() -> reopen_osd() is called. If
> there
> are still pending requests for this OSD, an attempt is made to read
> the
> OSD's address from the osd_addr array in the current osdmap,
> resulting
> in an out-of-bounds access.
>=20
> I suggest fixing the problem by adding a check to reopen_osd() that
> verifies the osd exists in the osdmap before continuing to reopen the
> connection.
> I will send a proposed patch in reply to this email.
>=20
> Best regards,
> Raphael
