Received: from bjy-spam.kuaishou.com (bjy-spam.kuaishou.com [61.16.102.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78FF369219;
	Fri, 23 Jan 2026 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.16.102.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137747; cv=none; b=nFRSJC9RmbNcVPRWtSu9qO1BN1EdnbRrBmbI4BOub4T5PbuzKO7nbbpoPggphHn3yyFXBYU11aNGBuhsw1E6F6Iyms0yfP+FY7ixrEz6aQ6LgQyTSvTf8HN+OZsxzc7/7FZBq21MpLJq51bDxGQYKOfyu2778/bmRXCYkITUeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137747; c=relaxed/simple;
	bh=nVPhc0Jl7mkAoc6+LX4tHQ5v0KAz5pGC+uMQ1XxoalE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TtWVpwh3+MxhG1tIvjernMRBAxUnvKwbkJJIXaBeEKgM5ltYf3smA4uh0glzUMN1/B8VyyPpyPH+iyYW+9DdkjnXsUqVX9w/4ticYf/NtVVCCiNnIIM1gIoqLlCImi/C5XONkzCXKkzG88Te9gAdtKermwavVXlcbr7l7ROhVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=efTMITpF; arc=none smtp.client-ip=61.16.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="efTMITpF"
Received: from m7-spam02.kuaishou.com (unknown [172.28.1.162])
	by bjy-spam.kuaishou.com (Postfix) with ESMTP id 1341E2C000048;
	Fri, 23 Jan 2026 11:08:47 +0800 (CST)
Received: from bjm7-pm-mail02.kuaishou.com (unknown [172.28.1.2])
	by m7-spam02.kuaishou.com (Postfix) with ESMTPS id 4dy2vG5y9tz18Vj0K;
	Fri, 23 Jan 2026 11:08:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1769137722; h=from:subject:to:date:message-id;
	bh=nVPhc0Jl7mkAoc6+LX4tHQ5v0KAz5pGC+uMQ1XxoalE=;
	b=efTMITpFlJhKi75Pg6DpNdkP1+71AGq5GJsaUwKFL61x9j+U1qy7rt2hTxhSrJusyr0XWpLtzg/
	XKvbzN+gRVLx8ljS6dRKUohGB/OUoJunvgRuMavC3KkXaF/5BKizeDThJpdQauwI15Eh3p5JY+a6z
	qxd/EWLuTP1lZGvgc1M=
Received: from bjxm-pm-mail03.kuaishou.com (172.28.128.3) by
 bjm7-pm-mail02.kuaishou.com (172.28.1.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 23 Jan 2026 11:08:42 +0800
Received: from bjxm-pm-mail03.kuaishou.com ([fe80::5a6:8f25:a72f:54f1]) by
 bjxm-pm-mail03.kuaishou.com ([fe80::5a6:8f25:a72f:54f1%9]) with mapi id
 15.02.1118.020; Fri, 23 Jan 2026 11:08:42 +0800
From: =?utf-8?B?5p2O56OK?= <lilei24@kuaishou.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze
	<amarkuze@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5a2Z5pyd?= <sunzhao03@kuaishou.com>
Subject: =?utf-8?B?UmU6IOOAkOWklumDqOmCruS7tiHjgJFSZTogIFtQQVRDSCB2Ml0gY2VwaDog?=
 =?utf-8?B?Zml4IGRlYWRsb2NrIGluIGNlcGhfcmVhZGRpcl9wcmVwb3B1bGF0ZQ==?=
Thread-Topic: =?utf-8?B?44CQ5aSW6YOo6YKu5Lu2IeOAkVJlOiAgW1BBVENIIHYyXSBjZXBoOiBmaXgg?=
 =?utf-8?B?ZGVhZGxvY2sgaW4gY2VwaF9yZWFkZGlyX3ByZXBvcHVsYXRl?=
Thread-Index: AQHcjBWU3tkJ4jWmLUqBjj4PgS1JxA==
Date: Fri, 23 Jan 2026 03:08:42 +0000
Message-ID: <4C9E4C1C-942E-4C12-B9BB-245828D8B8FD@kuaishou.com>
References: <20250808070819.18878-1-sunzhao03@kuaishou.com>
 <1d51b68168de62cc852fc147fb5e2dc8fbd9373d.camel@ibm.com>
 <409ca87f8add4a80a7927981059b3c5f@kuaishou.com>
 <5af9d165d05d4dddbb6c5d6d9d312367@kuaishou.com>
 <896a69bcc26e1d808e6dfe2d35e25c8b9f8b7f02.camel@ibm.com>
 <df02fae47a2c45c284d5269a51a2ddd5@kuaishou.com>
 <ebc291d2ae5cb3702f67831dd1da932d66177ae2.camel@ibm.com>
 <26ab430040f0406087f4f6a2241525ce@kuaishou.com>
 <e93388c77ebad3d32a7a851031e3aea6a6991d31.camel@ibm.com>
In-Reply-To: <e93388c77ebad3d32a7a851031e3aea6a6991d31.camel@ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7C0DCC73B8EA44A8C75B6808C7E4EA3@kuaishou.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQo+IA0KPiBJIGFtIGd1ZXNzaW5nLi4uIElzIGl0IHBvc3NpYmxlIHRvIGNyZWF0ZSBzb21lIENl
cGggc3BlY2lmaWMgdGVzdC1jYXNlIGluDQo+IHhmc3Rlc3RzIHN1aXRlPyBJdCB3aWxsIGJlIGdy
ZWF0IHRvIGhhdmUgc29tZSB0ZXN0LWNhc2Ugb3IgdW5pdC10ZXN0IGZvcg0KPiBjaGVja2luZyB0
aGlzIGlzc3VlIGluIHRoZSBmdXR1cmUuDQpJdCBtYWtlcyBzZW5zZS4gSeKAmWxsIHRyeSB0byBh
ZGQgdGhpcyB0ZXN0Y2FzZSBpbiB4ZnN0ZXN0cy4NCg0KPiANCj4gT0suIEkgc3VnZ2VzdCB0byBh
ZGQgdGhpcyByZXByb2R1Y3Rpb24gcGF0aCBhbmQgb3RoZXIgYWxyZWFkeSBzaGFyZWQNCj4gZXhw
bGFuYXRpb24vYW5hbHlzaXMgaW50byBjb21taXQgbWVzc2FnZSBhbmQgcmUtc2VuZCB0aGUgcGF0
Y2guIENvdWxkIHlvdSBwbGVhc2UNCj4gc2VuZCB0aGUgbmV3IHZlcnNpb24gb2YgdGhlIHBhdGNo
Pw0KR290IGl0LCBJ4oCZbGwgYWRkIG1vcmUgZXhwbGFuYXRpb24gb2YgdGhpcyBpc3N1ZSBpbiBh
IG5ldyB2ZXJzaW9uIG9mIHRoZSBwYXRjaCwgYW5kIHJlc2VuZCBpdCBhZnRlcg0Kc29tZSB0ZXN0
cy4NCg0KVGhhbmtzLg0KDQo=
