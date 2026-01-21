Received: from bjy-spam.kuaishou.com (bjy-spam.kuaishou.com [61.16.102.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D9314D22
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.16.102.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981774; cv=none; b=gU+7swaUde3UsDCdyodvuRtaLEGeVlNgMyIClNEza+9unEO1aywxJfvmR6sUVrkDTNDO5H+Zl11hx/Vd82VVHbPByAPCo5uHOM02xLSNx6zeW/3xIhhKOktjgXjrgbvIdX57rgKmjkpLCh86phHFBq/NFKl/ktjh9H6evNqdVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981774; c=relaxed/simple;
	bh=DvPKHH3gQoGOlaqdMur2aKkdRgP9yJNV+MSw13GHKkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u5NUtNw06rrMjRksMC1VCY0S6ce1CUEzUssh/PbaC3i5+EcSLSamPu8ahzN53qOgEqJT+QWR+z632DO178uG2wTbSxN/Z9ibgBD53WfVEnTLd9br7QyIp0+yLe70J9NZO2taJ9mN7Aqf2oUM5KhBKx3G7mxWIWGazzSVCQrLd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=azfX6NWB; arc=none smtp.client-ip=61.16.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="azfX6NWB"
Received: from m7-spam01.kuaishou.com (unknown [172.28.1.161])
	by bjy-spam.kuaishou.com (Postfix) with ESMTP id AFA1A5C753;
	Wed, 21 Jan 2026 15:33:07 +0800 (CST)
Received: from bjm7-pm-mail04.kuaishou.com (unknown [172.28.1.4])
	by m7-spam01.kuaishou.com (Postfix) with ESMTPS id 4dwwsC39pSz18W7Hx;
	Wed, 21 Jan 2026 15:33:03 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1768980783; h=from:subject:to:date:message-id;
	bh=DvPKHH3gQoGOlaqdMur2aKkdRgP9yJNV+MSw13GHKkk=;
	b=azfX6NWBY9VS6sOL6nE5PijY5dZWWj2WJ1koIiOZurXat2RTp97hQxBfh9EfuNdsz4m/tSKK7Vu
	+aLPeELmDP+hZySwZjvfflgAO+uK6E4T45bSUCq3/QCClcXRbeU2t7Qi3MN90djS3PjondT5lpYjl
	uI/c0jybyyVIiXIDYkg=
Received: from bjxm-pm-mail03.kuaishou.com (172.28.128.3) by
 bjm7-pm-mail04.kuaishou.com (172.28.1.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 21 Jan 2026 15:33:02 +0800
Received: from bjxm-pm-mail03.kuaishou.com ([fe80::5a6:8f25:a72f:54f1]) by
 bjxm-pm-mail03.kuaishou.com ([fe80::5a6:8f25:a72f:54f1%9]) with mapi id
 15.02.1118.020; Wed, 21 Jan 2026 15:33:02 +0800
From: =?gb2312?B?wO7A2g==?= <lilei24@kuaishou.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
CC: Alex Markuze <amarkuze@redhat.com>, "idryomov@gmail.com"
	<idryomov@gmail.com>, =?gb2312?B?y++zrw==?= <sunzhao03@kuaishou.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogILTwuLQ6ICC08Li0OiChvs3isr/Tyrz+IaG/UmU6ICBbUEFUQ0gg?=
 =?gb2312?B?djJdIGNlcGg6IGZpeCBkZWFkbG9jayBpbiBjZXBoX3JlYWRkaXJfcHJlcG9w?=
 =?gb2312?Q?ulate?=
Thread-Topic: =?gb2312?B?ILTwuLQ6ICC08Li0OiChvs3isr/Tyrz+IaG/UmU6ICBbUEFUQ0ggdjJdIGNl?=
 =?gb2312?B?cGg6IGZpeCBkZWFkbG9jayBpbiBjZXBoX3JlYWRkaXJfcHJlcG9wdWxhdGU=?=
Thread-Index: AQHcCDM6okr0JGqdDkKALGmq7zHgfLRdWgkAgOVIkbGAAABUZoABwPQAgANi9Tr//8L+AIAVqmGJ
Date: Wed, 21 Jan 2026 07:33:02 +0000
Message-ID: <26ab430040f0406087f4f6a2241525ce@kuaishou.com>
References: <20250808070819.18878-1-sunzhao03@kuaishou.com>
			,<1d51b68168de62cc852fc147fb5e2dc8fbd9373d.camel@ibm.com>
			,<409ca87f8add4a80a7927981059b3c5f@kuaishou.com>
		 <5af9d165d05d4dddbb6c5d6d9d312367@kuaishou.com>
	,<896a69bcc26e1d808e6dfe2d35e25c8b9f8b7f02.camel@ibm.com>
	 <df02fae47a2c45c284d5269a51a2ddd5@kuaishou.com>,<ebc291d2ae5cb3702f67831dd1da932d66177ae2.camel@ibm.com>
In-Reply-To: <ebc291d2ae5cb3702f67831dd1da932d66177ae2.camel@ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2xhdmEsDQoNClpoYW8gYW5kIEkgaGF2ZSBmb3VuZCBhIHdheSB0byByZXByb2R1Y2UgdGhp
cyBpc3N1ZS4gDQoNCjEuIHRyeSB0byBmaW5kIDIgZGlmZmVyZW50IGRpcmVjdG9yaWVzIChESVJf
YSBESVJfYikgaW4gYSBjZXBoZnMgY2x1c3RlciBhbmQgbWFrZSBzdXJlIHRoZXkgaGF2ZSBkaWZm
ZXJlbnQgYXV0aCBtZHMgbm9kZXMuIEluIHRoaXMNCiAgICB3YXksIGEgY2xpZW50IG1heSBoYXZl
IGNoYW5jZXMgdG8gcnVuIGhhbmRsZV9yZXBseSBvbiBkaWZmZXJlbnQgQ1BVIGZvciBvdXIgdGVz
dCAoc2VlIHN0ZXAgNCBhbmQgc3RlcCA2KS4NCjIuIEluIERJUl9iLCBjcmVhdGUgYSBoYXJkIGxp
bmsgb2YgRElSX2EvRklMRV9hLCBuYW1lbHkgRklMRV9iLiBESVJfYS9GSUxFX2EgYW5kIERJUl9i
L0ZJTEVfYiBoYXZlIHRoZSBzYW1lIGlubyAoMTIzNDU2IGUuZykNCjMuIFNhdmUgaW5vIGluIGNv
ZGUgYmVsb3csIG1ha2UgaXQgc2xlZXAgZm9yIHN0YXQgY29tbWFuZC4NCmBgYA0KQEAgLTM5NTAs
NiArMzk1MSwxMCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfcmVwbHkoc3RydWN0IGNlcGhfbWRzX3Nl
c3Npb24gKnNlc3Npb24sIHN0cnVjdCBjZXBoX21zZyAqbXNnKQ0KICAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBvdXRfZXJyOw0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBy
ZXEtPnJfdGFyZ2V0X2lub2RlID0gaW47DQorICAgICAgICAgICAgICAgaWYgKGluLT5pX2lubyA9
PSAxMjM0NTYpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiaW5vZGUgJWx1IGZv
dW5kLCByZWFkeSB0byB3YWl0IDEwIHNlY29uZHMuXG4iLCBpbi0+aV9pbm8pOw0KKyAgICAgICAg
ICAgICAgICAgICAgICAgbXNsZWVwKDEwMDAwKTsNCisgICAgICAgICAgICAgICB9DQpgYGANCjQu
IGVjaG8gMyA+IC9wcm9jL3N5cy92bS9kcm9wX2NhY2hlcw0KNS4gaW4gYSBzaGVsbCwgZG8gYHN0
YXQgRElSX2EvRklMRV9hYCwgd2Ugc3VwcG9zZSB0byBiZSBzdHVjayBvbiB0aGlzIHNoZWxsIGJl
Y2F1c2Ugb2YgbXNsZWVwKCkgaW4gaGFuZGxlX3JlcGx5KCkuDQo2LiBpbiB0aGUgb3RoZXIgc2hl
bGwsIGRvIGBscyBESVJfYi9gIHRvIHRyaWdnZXIgY2VwaF9yZWFkZGlyX3ByZXBvcHVsYXRlKCkN
Cg0KUmVwZWF0IHN0ZXAgNCB0byBzdGVwIDYgZm9yIHNldmVyYWwgdGltZXMgKDUgdGltZXMgaXMg
ZW5vdWdoIEkgZ3Vlc3MpLiBBbmQgd2UnbGwgc2VlIHRoZSBkZWFkbG9jay4NCg0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IFZpYWNoZXNsYXYgRHVi
ZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0Kt6LLzcqxvOQ6IDIwMjbE6jHUwjjI1SAzOjU5
DQrK1bz+yMs6IMDuwNoNCrOty806IEFsZXggTWFya3V6ZTsgaWRyeW9tb3ZAZ21haWwuY29tOyDL
77OvOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBjZXBoLWRldmVsQHZnZXIua2VybmVs
Lm9yZw0K1vfM4jogUmU6ICC08Li0OiAgtPC4tDogob7N4rK/08q8/iGhv1JlOiAgW1BBVENIIHYy
XSBjZXBoOiBmaXggZGVhZGxvY2sgaW4gY2VwaF9yZWFkZGlyX3ByZXBvcHVsYXRlDQoNCk9uIFdl
ZCwgMjAyNi0wMS0wNyBhdCAxNjowMSArMDAwMCwgwO7A2iB3cm90ZToNCj4gSGkgU2xhdmEsDQo+
DQo+IFRoaXMgaXNzdWUgaXMgdmVyeSByYXJlIG9uIG91ciBpbnRlcm5hbCBjZXBoZnMgY2x1c3Rl
cnMuIFdlIGhhZCBvbmx5IGVuY291bnRlcmVkIGl0IGZvciBhYm91dCB0aHJlZSB0aW1lcy4NCj4g
QnV0IHdlIGFyZSB3b3JraW5nIG9uIHNhbWUgaGFja2luZyBtZXRob2RzIHRvIHNwZWVkIHVwIHRo
ZSByZXByb2R1Y3Rpb24uIEkgdGhpbmsgaXQgd2lsbCB0YWtlIG1lIG9uZSB3ZWVrDQo+IGlmIGV2
ZXJ5dGhpbmcgZ29lcyBzbW9vdGhseSBhbmQgSSB3aWxsIHNoYXJlIHRoZSBtZXRob2RzIGhlcmUu
DQo+DQo+IFRvIGJlIGhvbmVzdCwgdGhpcyBwYXRjaCBzaG91bGQgYmUgYSByZXZlcnQgcGF0Y2gg
b2YgdGhpcyBvbmU6DQo+DQo+IGNvbW1pdCA6IGJjYTlmYzE0YzcwZmNiYmViYzg0OTU0Y2MzOTk5
NGU0NjNmYjk0NjgNCj4gY2VwaDogd2hlbiBmaWxsaW5nIHRyYWNlLCBjYWxsIGNlcGhfZ2V0X2lu
b2RlIG91dHNpZGUgb2YgbXV0ZXhlcw0KPg0KPiBJJ2xsIHJlc2VuZCB0aGlzIHBhdGNoIGxhdGVy
Lg0KDQpTb3VuZHMgZ29vZC4gSWYgSSByZW1lbWJlciBjb3JyZWN0bHksIHRoZSBtYWluIGlzc3Vl
IHdpdGggdGhlIGluaXRpYWwgcGF0Y2ggd2FzDQp0aGUgY29tbWl0IG1lc3NhZ2UgdGhhdCBkaWRu
J3QgaGF2ZSBnb29kIGV4cGxhbmF0aW9uIG9mIHRoZSBpc3N1ZSBhbmQgd2h5IHRoaXMNCnJldmVy
dCBjYW4gZml4IHRoZSBpc3N1ZS4gU28sIGlmIHdlIGhhdmUgYWxsIG9mIHRoZXNlIGRldGFpbHMg
aW4gdGhlIGNvbW1pdA0KbWVzc2FnZSwgdGhlbiB0aGUgcGF0Y2ggc2hvdWxkIGJlIGluIGdvb2Qg
c2hhcGUuDQoNClRoYW5rcywNClNsYXZhLg0KDQo=
