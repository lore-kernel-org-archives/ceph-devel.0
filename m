Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489512;
	b=QnKPmV2YCCWaEeJPtAKDAP5lZQm4JODsARaK8ML4vrGxnas95CQr63u6jOgWp2hfEO8m
	 ae/xSgrgEjV4H8tLCxMuT88pm1J8gJQ2coWH5E4UhQwYqklrCg+tsoG+ygjFbdDFxvfKi
	 +e9hICrcmICbOtsx4DMVr69psy6cMbAsUROMDU52yic5ecGgQ76S5AmuW6SKM5HXSzjZF
	 0fye4KlK+9iSeYMfW3Xsp/jOsmnAkGs2GLJnNSfhM8Fc/WrTz5fhQzuRgLB4DCtNAOsgH
	 unSCy3xx13toRLzlfuOp2MaiWrObM+smfluzMmGy8ITf3jr3aRPnXtH7UJvoKXKfRjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489512;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=LosFSTGbZO+f/zG7X8uytuOE1D7kZdFxkLZIZS8x1Dc=;
	b=H6aEUidJxQUKo6R9wYpN2sHeC+yznZb1Pl4lBEevzeXQOSlJUnOudsRbULOkiG23klQo
	 jMAieuqVnuk2jlvLy3lR1vIAYJkY66yQszkzbMSBXFoWbDoirlVn3d1m1UtMPXxP2dzAs
	 e1hSl2g2AGW0Ew6ApmuNYY0xFgFUNxwFEGWUe2q+tVkASuxVR4v8/0AnlZyu15WjkpDBn
	 hKvFnHedz9d+2MqgJQZqm5JiKPSlNMPyhpTdAmzdvRK+ScD9K1h2Hv3SGr+mtIiP5uZwC
	 UIwyopRElNx/Zpn4I0oWm/5OublZ2qzm6f380A6VJPZ68JuKkJWn+hzF9RaIRxpZNxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O3TPlrj5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Vlk7i5RN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083C606A31C
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 13:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A083C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O3TPlrj5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Vlk7i5RN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794489510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LosFSTGbZO+f/zG7X8uytuOE1D7kZdFxkLZIZS8x1Dc=;
	b=O3TPlrj5d7OlnrPtdWoUIP9jevnjaZV4LQwKuQB3DUHVbRG2EP0ZAjeZqDegJb0wZLlCLy
	Dn2O1FiY7dqKoNBT9twcUb5OOSJqFx97x68kOS1xzMF4hrKWswGb6BxuKDdauaSOD9ZEs6
	P+PS999o91h+rf/QzpboO5B0zYTl7dE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-FUCF0Bv3OGSMoeupgtJscw-1; Thu, 12 Nov 2026 08:18:29 -0500
X-MC-Unique: FUCF0Bv3OGSMoeupgtJscw-1
X-Mimecast-MFC-AGG-ID: FUCF0Bv3OGSMoeupgtJscw_1794489508
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b6fb975053so5242948a12.0
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 05:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794489508; x=1795094308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LosFSTGbZO+f/zG7X8uytuOE1D7kZdFxkLZIZS8x1Dc=;
        b=Vlk7i5RN7azLsD0bG8mWjO2wpBgHg1u2dCYSh08/9z/i9vJzb0fZVhsAVGQakkAWxS
         ae5F0/F6oX0q7+m3Xy1V/ZpHxENIjaL/i1B4luVVx4w/Yyx6GKTTP5rU0weq2b3VduEX
         rqQltuCNQ+TxXC7mJ4xhHizidUStfl2nglVdwIe3m+QCbz66CDZez+JRQBUF5q2iQwNM
         K9hqpvZ4YrdbhiCDoNuaEZRGnFc+Ub24Cbi2Iqu/kxkp9aWvg4NtThqH4MtoPCHcpWbm
         m7PMX+tGK9rG0OVfkQGY2DFyKHd9oY8QytwZ8fYz02vTAdRPINZtpx4x7QzlsjGDVsNg
         8DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489508; x=1795094308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LosFSTGbZO+f/zG7X8uytuOE1D7kZdFxkLZIZS8x1Dc=;
        b=2Wd53CY8QWrbXP3sRSPCW1iLRkQ2dWfhY1GBHUlEE4qeHa+o7dF8VKTmXVMkhVJHfe
         5ErTkFB/EAlXOK7kiSrCn1h4M1HXW9hdTWcxplKXpfr52uOe/4J50RdScWVOhz9FSp8r
         DtR0sThMxnhYsp2DwPma8mNOMnxNyh9cCGuVgnuFDtyPHvM6Zm6SuTnSevpGHjGFoJJt
         kj56A7gnjLSJMIiUrpDjmfuotrZ+VLwtyJhkKPleEEv6ZGyvDtJuSjwau7nm89TX3mii
         60TzzlZ/2/8FB7tq+8khsf8JWMXgk9gNKRWDhWJlg6mnhTkDy21QGw/y2cGw2osWSFrO
         HKrg==
X-Forwarded-Encrypted: i=1; AL+hErHE0ZLzjQL9tWmbS/dR+OL/p8nw5p+hJ2MZUX1sZ6ce93c7n8Q/IpVPbKjXXxiDsd1752jLHnHu5jIg@vger.kernel.org
X-Gm-Message-State: APuU4Z9kyyCe/xyTUvSENy2WuKfz6/fFEy6r9pbDmkyMLI+5hSV/Avwd
	W0nuN4w4qwOx2HcUvJ96EMZfPfo9gIpknONsQu5yQdeTL5gxSF39o2dZafKj7HP4zBc738FgmcF
	CVgD/XRXQsBOWdnJe2yloiG60g3LU7S13sAnWnoGIJ9EyZMnc0LoxXVZqhy7M/zQ=
X-Gm-Gg: AYBFou2pQOAnHWLxC/YQVZhhLaU2bLFESVakOY4uhtwGfaQI3ubdP+0dXPJgZ9ZRSP0
	MbDRuuxkrWvJOPVNmKGv85G+s6ZySxXAi3zZlXNK3E+lUWwSNTFYfKeIS3lzNxkUFtVlZF2Srvk
	Jid+vchZHeAKbCcXdLbB/EnwzSjU4+Z7+mtS1VULNA9N9pd3qGHG+gwHTZemDSihpVkSMJIqGX3
	cnmU8moJ5A+ejI91FlTxDcNJorA9qhArBB96ewHVbyP7WbGtiUakmM0nCTp9x7Td3GQGAQMDiWk
	rC3boPu4xeVTAssW47iiXlPZ7uAY2Y9QvofrKVbwHGQzynwM+20CEPwYvOvIF0eyFo46a4dqCaq
	9OsF1GI0WFZweyHfCaYdcH5UpGM3LVrJ7W+sNZttGBpf4GO89vGYYGUwfhBC4i4OySRSxROQoX9
	hpY+Ut/5Ifxjen9D7QdhFOzArecdxsxek5w7enTjr/GVq5B4FlZBblhX5Ug90slmQq0bXpNqRki
	gwLPIOvjIz4AP/eo5Mni06EFAneKnW8xBaQX541kZbEns6ozpa8
X-Received: by 2002:a05:6402:49:b0:6b5:74dd:37ec with SMTP id 4fb4d7f45d1cf-6b77733eafamr2910406a12.1.1794489507910;
        Thu, 12 Nov 2026 05:18:27 -0800 (PST)
X-Received: by 2002:a05:6402:49:b0:6b5:74dd:37ec with SMTP id 4fb4d7f45d1cf-6b77733eafamr2910393a12.1.1794489507522;
        Thu, 12 Nov 2026 05:18:27 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7b2580ed9sm286477a12.11.2026.11.12.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:18:27 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubo.li@clyso.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] libceph: allow for multiple in-flight linger pings
Date: Thu, 12 Nov 2026 13:18:26 +0000
Message-Id: <20261112131826.3599035-1-amarkuze@redhat.com>
In-Reply-To: <20261110201025.255594-1-idryomov@gmail.com>
References: <20261110201025.255594-1-idryomov@gmail.com>
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

Hi Ilya,

Two further problems in 2/3.

linger_ping_cb() applies every ping whose register_gen still matches.
With osd_request_timeout set, handle_timeout() abort_request()s a ping
whose r_start_stamp is older than that timeout, and then
send_linger_ping() runs in the same pass because last_error is still 0.
The queued callback still owns that request: it stores -ETIMEDOUT and
queue_watch_error(). rbd_watch_errcb() clears the exclusive-lock owner
and re-registers the watch. The default timeout is 0, so a default mount
does not abort. Previously req != lreq->ping_req dropped this completion.
An older ping's error has to be ignored once a later ping for the same
register_gen has been sent or has already succeeded.

__linger_cancel() walks lreq->osd_reqs without lreq->lock. The callbacks
unlink under that lock alone, after handle_reply() has dropped
osdc->lock. send_linger() takes lreq->lock around its walk;
__linger_cancel() needs to as well, or unwatch can list_del_init() a
node the callback is unlinking.

Thanks,
Alex

