Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C5374E46
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825960; cv=none; b=AuL3ZbGtKRtq8R5BZ3QBP6qGj4uer1SlD1h7lh3msq3o5hbFqQjGzR5ukhBTovzDwvr1gW1yIGPPl1xclTiqXwOKVUhSg9ztX5U6yMpg+T2Ysf0rhICV/si6S9n9bX6kVMIS1ZSUwSEi/VGOzu5uF7RH9HAyXzltGRW5IkjSDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825960; c=relaxed/simple;
	bh=GJmZ3H2skT6fM817BKeZuZm5Oxv1vcfERG3g8NXaPyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dt2s9j0QhvARt6w9NnK4rlprtVw1ssskjv5aXSfRgNTNCxw9uZGa4Y/6fytrj0fZrKDwD2Zq6bZ0fZIqi6rGu4X4k6jCKczMwYV4N+5a6/GkDIizMxP0ifT8t0Yi9ZhPd6nCO0i10iF7pgC+/5m8dEcK8sAt8SDPwaLAtd0OERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=gQFRQaOF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="gQFRQaOF"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e83f1f15aso6555297b3.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784825957; x=1785430757; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJmZ3H2skT6fM817BKeZuZm5Oxv1vcfERG3g8NXaPyk=;
        b=gQFRQaOF/R45V83E+vH4E7cbsvi5Q5EPtU8KoeZ+aNo/V3WaZXNHJlXGZ2I/NoGccC
         uAbgXuUjIdxZpg/czw9aJBefG3Y0+8h90x6W5IkCstUhC4uL1cD5oUI6XsFjY0qJjifj
         8AsthoNR8uN429WipSZ6mlmeECGBDRrXLQMjMhyqqz8r8gtUprj0Yl5GomhXjgaSfEVv
         nC73TIqOCbjIw7TcVPqEjQ4q4eUXUTXuWLTKkSN8SlZS8nU7nGrpJSYuk1htNB2ojeYk
         KcykflRAdb1BtIDkYWl85mDyH/8OLRM48mLbTvyPQ6kmmqDCMYxij+HKh5FH+Ltm9DRl
         WaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825957; x=1785430757;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GJmZ3H2skT6fM817BKeZuZm5Oxv1vcfERG3g8NXaPyk=;
        b=ajGfCkl9C8J6XUCiy6UjCMsG2hqI9FvbKIZ8eAXunmJVgZ6RCcL9TvF7TCtp7is0Yx
         Rrlr3hdXao6laWxgOJ4BV1xqGiHx6x+e65rLZcsJT5RMkHkLcm2dh4zr27hmYuA0AZfn
         fp54KdOC9lTvhS0Z4aS4XQIOu7AR76HajMV4UKZoP6LfNNBDvdrk4fat7oxlvKXiZ/hU
         fW4vidiXXWD/qWSrC94J+6XI+yCMkG2NBhSeACuoy348njmePUejP7DImxKRWLgMudeg
         nwAEXZy+b/J4GfjfLFQ2c35bq5uCb2SdpUqn9XNIfbsqB8vSw4lF5maXOBlXN2AyYzIM
         mIaQ==
X-Gm-Message-State: AOJu0YwG6czn8LFPMMvlXbLB0RRBp8P20GoK7Hy992BTjWifkdsJsbui
	hHGctdjJ/lXglkqEVO4O8ydper+Y3mj2qDdzGU/dac0Mq0C9xnVNND4nxNyyiIfRQFQ=
X-Gm-Gg: AR+sD11SJF/NzxdT/f+IVBFoyUHt0BHbPeLAGFDulcCT2kh6k/AZtNsjL9QvtARN+pI
	ycacakkfopBEXOnGDXRwdy8H3zzSTYHeLiCeBmyUIOH5vEIeuOa3VVWKr2i42Z6oTl/9FsnlSZ8
	fxF0TLWXXSB8a2VA0bwTDxBjhiRL8kp/UHdzEcf1IwOrNNNwbPSIQv9XbOhXenWwIIaAw+DFe5r
	bDMCoM1XWdHpUSfXCH7dQCEfemi1yKmFw7A+ztAf+MUbtXAapQKuXO0NksH6PBig4nETh/baTU1
	zjONyAy5uW9XLMH2YuNmKCHlRwixkYRSUUtm38eITL2Buybp8T33hv/qkpNCbaG3tuxBmXxseU6
	s+UO1vFKJpLzIHtxghRJVZ7M3hyLeEvONW/I/Ph5tmIzXmFxzuunTDlgmxlSd2Y09HusNv5jURQ
	ReqyeMbzLn/bF5jtKJN0mck1pcFob0JwMQARqbxntlHBE0UgCH37Sv2RbnrMqLxBmWsgw9YXJYX
	HOeCHD4NB6PE8cLTijZTkxYwRClWQprXJ1U38hUdEwgUIiD+w+kUi7egbwY9YDVZY2vT48=
X-Received: by 2002:a05:690c:9a84:b0:7ef:9fd9:db07 with SMTP id 00721157ae682-81f4d3b5baamr10860447b3.12.1784825957564;
        Thu, 23 Jul 2026 09:59:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8af4:3b7a:515e:7808? ([2600:1700:6476:1430:8af4:3b7a:515e:7808])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33d9fd2dsm31607727b3.30.2026.07.23.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:59:17 -0700 (PDT)
Message-ID: <0c01ca7ecdc824a366344890850a34e39b5d2251.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] ceph: use GFP_NOFS for cap flush allocation in
 writeback path
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 09:59:12 -0700
In-Reply-To: <20260723-b4-gfp_nofs-v1-1-c06b40354ec9@clyso.com>
References: <20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com>
	 <20260723-b4-gfp_nofs-v1-1-c06b40354ec9@clyso.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI2LTA3LTIzIGF0IDEzOjQ3ICswODAwLCBYaXVibyBMaSB2aWEgQjQgUmVsYXkg
d3JvdGU6Cj4gRnJvbTogWGl1Ym8gTGkgPHhpdWJvLmxpQGNseXNvLmNvbT4KPiAKPiBjZXBoX2Fs
bG9jX2NhcF9mbHVzaCgpIGlzIGNhbGxlZCBmcm9tIGNlcGhfd3JpdGVwYWdlc19zdGFydCgpIGlu
c2lkZQo+IHRoZSB3cml0ZWJhY2sgbGF5ZXIsIHdoZXJlIG90aGVyIGFsbG9jYXRpb25zIGluIHRo
ZSBzYW1lIHBhdGgKPiAoY2VwaF9vc2RjX2FsbG9jX3JlcXVlc3QsIGNlcGhfb3NkY19hbGxvY19t
ZXNzYWdlcykgYWxyZWFkeSB1c2UKPiBHRlBfTk9GUy7CoCBBIEdGUF9LRVJORUwgYWxsb2NhdGlv
biBoZXJlIGNhbiB0cmlnZ2VyIGRpcmVjdCByZWNsYWltCj4gdGhhdCByZWN1cnNpdmVseSBlbnRl
cnMgdGhlIGZpbGVzeXN0ZW0gd3JpdGViYWNrIHBhdGg6Cj4gCj4gwqAgY2VwaF93cml0ZXBhZ2Vz
X3N0YXJ0KCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvLyBp
bm9kZSBBIHdyaXRlYmFjawo+IMKgwqDCoCBjZXBoX2FsbG9jX2NhcF9mbHVzaCgpCj4gwqDCoMKg
wqDCoCBrbWVtX2NhY2hlX2FsbG9jKC4uLiwgR0ZQX0tFUk5FTCkKPiDCoMKgwqDCoMKgwqDCoCBb
ZGlyZWN0IHJlY2xhaW1dCj4gwqDCoMKgwqDCoMKgwqDCoMKgIHRyeV90b19mcmVlX3BhZ2VzKCkK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNocmlua19zbGFiKCkKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdXBlcl9jYWNoZV9zY2FuKCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHJ1bmVfaWNhY2hlX3NiKCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlub2RlX2xydV9pc29sYXRlKCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpcHV0KCkgLT4gZXZpY3QoaW5vZGVfQikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgW2lub2RlX0IgaGFzIGRpcnR5IHBhZ2VzXQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaWxlbWFwX2ZsdXNoKCkKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNlcGhfd3JpdGVwYWdl
c19zdGFydCgpwqAgLy8gcmUtZW50ZXJzCj4gd3JpdGViYWNrCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2VwaF9hbGxvY19jYXBfZmx1c2goKQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAt
PiBSRUNVUlNJT04gLyBTVEFDSyBPVkVSRkxPVwo+IAo+IEFsbCAxMSBjYWxsZXJzIG9mIGNlcGhf
YWxsb2NfY2FwX2ZsdXNoKCkgYXJlIGluIHdyaXRlIG9yIHdyaXRlYmFjawo+IGNvbnRleHRzOiB3
cml0ZXBhZ2VzICh4MiksIHdyaXRlX2l0ZXIsIGZhbGxvY2F0ZSwgY29weV9maWxlX3JhbmdlLAo+
IHNldHhhdHRyLCBzZXRhdHRyLCBhbmQgcGFnZV9ta3dyaXRlLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IFhpdWJvIExpIDx4aXViby5saUBjbHlzby5jb20+Cj4gLS0tCj4gwqBmcy9jZXBoL2NhcHMuYyB8
IDIgKy0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
IAo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2NhcHMuYyBiL2ZzL2NlcGgvY2Fwcy5jCj4gaW5kZXgg
ZjhkODk4YWQwOTFlLi5jYmFlYmVhYzA2ZjcgMTAwNjQ0Cj4gLS0tIGEvZnMvY2VwaC9jYXBzLmMK
PiArKysgYi9mcy9jZXBoL2NhcHMuYwo+IEBAIC0xODc1LDcgKzE4NzUsNyBAQCBzdHJ1Y3QgY2Vw
aF9jYXBfZmx1c2gKPiAqY2VwaF9hbGxvY19jYXBfZmx1c2godm9pZCkKPiDCoHsKPiDCoAlzdHJ1
Y3QgY2VwaF9jYXBfZmx1c2ggKmNmOwo+IMKgCj4gLQljZiA9IGttZW1fY2FjaGVfYWxsb2MoY2Vw
aF9jYXBfZmx1c2hfY2FjaGVwLCBHRlBfS0VSTkVMKTsKPiArCWNmID0ga21lbV9jYWNoZV9hbGxv
YyhjZXBoX2NhcF9mbHVzaF9jYWNoZXAsIEdGUF9OT0ZTKTsKPiDCoAlpZiAoIWNmKQo+IMKgCQly
ZXR1cm4gTlVMTDsKPiDCoAoKTG9va3MgZ29vZC4KClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1
YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPgoKVGhhbmtzLApTbGF2YS4K

