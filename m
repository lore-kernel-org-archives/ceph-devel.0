Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021104.outbound.protection.outlook.com [52.101.70.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350A484230
	for <ceph-devel@vger.kernel.org>; Mon,  5 Oct 2026 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206866; cv=fail; b=fGChPeEHBkX04XMkM2B/LbNxUGqecSWRKhW6L9uXw6qiNGlYxCquDwcY3Oa+TBJgqIO6oTMCG6aEC/o8nZIsxtqpEsblBn1uTJOM1vEmHQh+gp0trP18YIrj7U9hWk3DohNLD0/WAXQkRFkvHzpOhwO6AEVIyG9e2mzuqMsvTBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206866; c=relaxed/simple;
	bh=3AaI3oOpWNa9FF0GV8cfyVIGuaYqq0qvNqd1WOcInQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XrnLMdbiwK+YtWB/njlHl+5DqIK5SpW2l09NFu7xnZCYDPDYW1cdZD3oK5RV/vrX045P4rW6OKQ7cnI+5YzJBApkFUA+u4HN6G0QaaxB3JKyvnUyYI7+RmXtU5lZbKah/IIX6e5olatHlf9NqRU6Y3c4AO2gqHWibuNd7X+rj30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kx.com; spf=pass smtp.mailfrom=kx.com; dkim=pass (2048-bit key) header.d=kx.com header.i=@kx.com header.b=g5y7Waod; arc=fail smtp.client-ip=52.101.70.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kx.com header.i=@kx.com header.b="g5y7Waod"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMa260Rv34m5fm/qjJRWDaXQMQQKUQDcyAobXHRP/NN78nmuLbQr+ibl6nb+DnIBRwtQpBT4jKPsCySJeKvJLRSw8EqeXUXj3qJzmsH+uzssLYj0yEvuHrviPqoUVzcqdvtr/ySB62hsQnBEmswAqJ1bbBQRTdJwPXV5/ldJZ1QKawyUNqtyhxNTyLgyQ1KCD3Iwztjx/d8QVX0bL3K2+I5GfjoRfZwuMHgshJWHPLZHhTo4xe/11/lbRv+Q1F7I9nh2/82/JxCVBAUbYANKvO5BiX+VfaJ1+FHKiaZTxdI2kdIwhSvBZUruN83FpItqPt13l1JLkGK8pTP+SYFbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AaI3oOpWNa9FF0GV8cfyVIGuaYqq0qvNqd1WOcInQc=;
 b=DQgX69+rXwAzFIT9XmpOZvEHUkzBeI1F/xXEVX4Ou0pBW+6FhaDExdtWh1Kiq9xc3SPxIvTlPQUR8EkqEwWugGAQzu+wWMdg22QRRvy5JI/M8ZUrHQepWechTt4c2DVALlkuv09vE0SPdS843MoS5wePcJhjtZGd/NT+AUG//uByq5fyp3sf/0G6JwlNnjV12ae70z8M8iZkH12mCTwwPrzHV46sU0CxTLII7IsqSArOuS2BYOGetyfhIsJ/eb0vGCWRfEyzNyUoOC67u7pQFBIWMs8lRLQNox0BmR+V37jbK28iYThWI4+KCmUBy1UF0xRZPNALcwi7cpDhRP0oSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kx.com; dmarc=pass action=none header.from=kx.com; dkim=pass
 header.d=kx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kx.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AaI3oOpWNa9FF0GV8cfyVIGuaYqq0qvNqd1WOcInQc=;
 b=g5y7Waod1aRlZzuSNW8XqaMKcyUs/YzlTRJBtcm+1mXUS0msp97SVztfBhdqRPuFAjxU8IGtCFDy8Cruu534m0xGJaELLLSPr2kE+R3NbhMqoAaRuRNyqjOy5Zjod3ZDJ3+zBjq8tFfugn+Bnm0P/ibmu1DKiolZq2Yuld+e8aydN+25XY+LoVJQtT1qlM7clouxjxaHikyPn6AnvetIfwQ4fS4u2G+xMCApqctbAwPEsrJMoSnqeERDmYBx5+iLKgNPKJB5QTDTSY7aZZACjMoRfwlekh6MVOkarv4/lV8KhwnRqNGrBRtWeMLk/MkTb94iCQVxdU1C08lmdSgNzw==
Received: from GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ae::7)
 by MI9PR10MB992282.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:27:15 +0000
Received: from GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a82e:3f55:c85d:7542]) by GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a82e:3f55:c85d:7542%2]) with mapi id 15.21.0451.022; Mon, 5 Oct 2026
 13:27:15 +0000
From: Domhnall McGuigan <dmcguigan@kx.com>
To: Gregory Farnum <gfarnum@redhat.com>
CC: Alex Markuze <amarkuze@redhat.com>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>, Liz Norris <enorris@kx.com>, Brendan McAllister
	<bmcallister@kx.com>, Pavlo Piatkovskyi <ppiatkovskyi@kx.com>, Pierre Kovalev
	<pierre@kx.com>, Oleg Finkelshteyn <oleg@kx.com>
Subject: RE: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
Thread-Topic: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
Thread-Index:
 Ad1J453OFY2uoDx/ROiPZd0eA4o9DQAClFgAACVv1QAAAFGYoAAAfTwAAAAHsNAAALufQAAqP0+AAADnagAACw5e8AAsvi8AAAh2RpAA++6FgAAFkv3QASPeL4A=
Date: Mon, 5 Oct 2026 13:27:14 +0000
Message-ID:
 <GV2PR10MB6138A05127803D0F8FB2559DDF962@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
References:
 <GV2PR10MB61387727F5B89B621AD8307BDF842@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAJ4mKGYf8KDH368dfxp1d3GQ5boUcewYxcbdB1cWSt=JR8oy2A@mail.gmail.com>
 <CAO8a2ShV8X+z1=FPUjZ+voQi2SCsSdauwv2a2wS9dBzt+bk1bA@mail.gmail.com>
 <GV2PR10MB6138FA66DBC7CE7434418686DF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAO8a2Sj=iRe62a+pO-7wAdYUQa59KObRsop8zus+KXCxp9GF3g@mail.gmail.com>
 <GV2PR10MB6138225665859A9E2054D4CADF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <GV2PR10MB613812F687DC650520DF45B8DF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAO8a2SjJ2u1BFPhnLohno9hy7qBgrFTb0rEHdHpBawQN+njb5Q@mail.gmail.com>
 <CAO8a2Sie7eftzio6Dq6UWaTc3TLFa-tQvM2TSDnq_6saF0hqOA@mail.gmail.com>
 <GV2PR10MB6138AC7FB5C40F1A0C35496BDF822@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAO8a2SiVduifBLiSW2fBUK+O8y1Efg5UU3RTfxVxpPFE1wf_iA@mail.gmail.com>
 <GV2PR10MB613843B97C5B19FC3BA53526DF812@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAJ4mKGZcJG9y2tmStFA_qsY8=ihhc_9Y8-t-Y3E3yxW5E0v71Q@mail.gmail.com>
 <GV2PR10MB6138251631686158C69FD365DF8C2@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <GV2PR10MB6138251631686158C69FD365DF8C2@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kx.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6138:EE_|MI9PR10MB992282:EE_
x-ms-office365-filtering-correlation-id: 610f4197-0f1a-4cd4-a4fe-08df22e45edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|56012099006|11063799006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 6AERy76/DiaIH5A8MqdwpSV6EX3xQ416FkLrFdyEtuLe0S2Fmh/eEHrf2QplXjJAn3jiRVsD/mJs5fTwjo1jejmt9GmNC2dUwLNYUSd3sioVFEBqp52oWj9UnAzPYgmuoRgPqStyHot4U6xDPo6WSyMckgAf6BlN8j1XJjn7Dc0IWC+iMd3slxyCoENJ8/bT9KRoMYdLe3jjDkGiWkAA2QDpWfoiP4FbPxb2tEg6J1vuSD90+gbuTNU3K6ytetZwpGI2w/59WrOc083/WEXJ5GAyylZ8A+aFTlWWzj5HI4sbcOHxHuTh9IyLC7Ml+cp67GBpTUKPBcnmmcwMxiyM8IxtinWgmyXaYloBKKFs5oUudIEVAyq9hnillP2IJTupsrVayKKD9z9gYxQvJfX5PBzVqunvDXJ/IKKnssTXh47+I6PUMDSf7n/IgFlJjxjFfE9R+RqUPR9Bw/j5IkTF8wag8aV5OhT3kFY9PXwsA0tFgjBPNZyqXMNS3BpEsTR82jBEESLtD4QhYYVG1dscFiQS7PaoXYk5vA6Bt2hDcEV2QmSjTzj6tLUs05KHFCepc8g7pln9L8mIuOTA2W4hW4DZJA/Qh/kcn6qIq6444Vd9Y1lhgEgvHoxyn1TzSwuzqLgJajQ86EpJ/cWzQaEPu3p+6IOfAoAWIKVnks0Cc+aFET+JixuXLdgfHhAI2nEb7zmri0DuYbfOtbsMmJ+lIrtxkSFgd4feOVEBQrqkYy4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dW9mOHRBUEFvbWQrQy9SL045L0RTWG1ZeVdqSWNBVG9qdFVLbFN1d2s1ZWN2?=
 =?utf-8?B?UkRhc0RaMVRyNHBsY3ZDN1QyeUlxMnFsVDBSNzNMREltQy9Mdy9UU01RMnlv?=
 =?utf-8?B?aVhCR2FGYU16RFhZOE90NmlhWmVCZW0xTDNHTGgvenRsUDRnWTgrUXgzWGU3?=
 =?utf-8?B?K2FTcXRITDlxWUR2RnJLUUppamlHWlk5VkE2TGZrek94YzQ4UVE1Z3hFZTdT?=
 =?utf-8?B?Q1dHNFpEeERUVnR0eWtNTHVTUmpaYXgzNnNnbXhveTNySzhXYjJSb2JtOE9y?=
 =?utf-8?B?U0VLaTlWM2hkckpMQ0NsNDJZR2NwdFBlRGkrem9TQnc0dnJjbFVqbko5Tlhs?=
 =?utf-8?B?WEtyWEtpZWhGZHhHMUdsZnN3ZTNJSEt4M05LZU4vOVhUYW95MitKRkVxTzVS?=
 =?utf-8?B?R2N6TndEVWpvZk5QRVUyOUN2V3BteEFEM0VySUdBT1licWliNEszNzdCZHpm?=
 =?utf-8?B?M1RRdG55V1BVTytTeTd2QTRPSHJJaDZTUXplR09xWEVzL3UySU53bWVkZ0g0?=
 =?utf-8?B?cHFiMXZGSGRnNzA1T01BRURJYWs1d3RHdXA0ck1pMm1rL0o4Z0c2a3luR0lX?=
 =?utf-8?B?MEtJRlVWREhIYXNWTWl0L0kweWRjVElzKzFqOFh4bDVMNlZWc1I3RXhIdmtp?=
 =?utf-8?B?TFFOQXYvajhiMWZQNFRucUczWXhRMnc2Tm5WcElmMjBxYlRHTE9GaHkyYXFx?=
 =?utf-8?B?M1JpUGE4VW9VY1RBMVlMeUtQMThpRWFlK0U2cmxrRmZ1Mm8yc2NYNUlZUGtJ?=
 =?utf-8?B?eWZCb2dyTDh0aVpOa1daTXMwSlRGOGdSTWE1NklKNkpMNDViU0swbm9xRWNu?=
 =?utf-8?B?TVhXeEtuR2VEK0dWRENoYzZXV3dQeUZCUnBDS0dSTThwRjlJTGhiQzlvYVY4?=
 =?utf-8?B?Q3VHYldaamRsenZOejFTSG1ieXhaaXl0bWpIMlZnQktLdGFPMmVGSGlYNWJm?=
 =?utf-8?B?Y2tTbGJwUTlWQzNrNFRuK3ZLUmVUL1JlTE5makJOdy8xUm1UVGZBM3IzbUJV?=
 =?utf-8?B?SUxZekhEMTFRZFNEVlZyNHBCUUIwVytnM1g0Q2ZmSFpIUzdHS2o2Nk9pMUds?=
 =?utf-8?B?Vjh2aGJaYjhEcURiVSt6ek16T3pEVHBKamMwZVB4UU5wYWtQSlppeFVwcVkx?=
 =?utf-8?B?NE53bUxXTnhLb1ZlVENaNlNzS1E4a3BLMldGd0RZTG0vTmtpTVc4aWV4cDgv?=
 =?utf-8?B?SGRTNVdWbzdRN1FhVURobkllczVjV0U0SW9iQmhXNDJ3SnYzdUw2d2pDTjQ5?=
 =?utf-8?B?dFhzUzlwMm9CcUplbnBHU29DM2NmYVdaL0hMai9oanAzbnJ2bk05Mng3Z1NY?=
 =?utf-8?B?bzdHMW9PaHhmUWF5VUE3WUpkOG1qZStnZXFtc2I1ckxkS3FGdTROMkNXN0tQ?=
 =?utf-8?B?TWdxTlp3NnBvWHZNYjNReWpsbEE2RFpUWlc2QjVNMXl1UUJ0WE9UN0xzM3d1?=
 =?utf-8?B?c2t6ZmtlMjBlMDFHTm5UbEtrbG02YWdkME9tM1RrRTl6QXUraEdHUER5RUI0?=
 =?utf-8?B?bkJvbXVyQ0xOTTlFZitvVmRmamp0QzZQcVE3YXpuZXQ5UFZuanBYZ1lVMVI5?=
 =?utf-8?B?azlmNEtNVDFHSkcyd3lsaEltMGpZV1M1R05RcDRqRDZiZ2RPaTIweEZaSC9U?=
 =?utf-8?B?cHNSYzVIMjVJQ0JqZEV1TUt0SHVSOU9yQ3BpWjVMekt0UnlBZ055UnBYZEho?=
 =?utf-8?B?a3A2K3RadXVuSEtwYm1zb0xkYWNiRE05Z0t4TUtGM1U4cDEySTAxdzhTekxm?=
 =?utf-8?B?NDhWeDY0STJpbWxYT0VBNWtVRUJ2RHdicnAzbVlvZktEOE41WW56V1A1ckxT?=
 =?utf-8?B?bXd0NDJQWVJpblhMMkJiQVBjTUpiem4xV2FHcXZSVnQwM05oSzE4OW9mUE9Q?=
 =?utf-8?B?TFF6dmwzWVpBa1hrTmJLWEhWeDB4Q3VNYXJ4QUdsbDNnNTlCMWl1ODR4V0c4?=
 =?utf-8?B?b1ZxbHFZbnQ3U2FjNmQya3g0N1k3bW1nUDlHSU9TQW9sR0NTYzVWRlJoQUdj?=
 =?utf-8?B?eCtFUTA5aWRzR3FGS3hTVUlhVlV6TjVlOUxQaXhZcU5OMW1NVmdPRUwzb01p?=
 =?utf-8?B?REpFUE9lT1FkRTFadVg5cW5ReXlMdjQvQ0RRSnlFVW5SV0ZKOXlkYnlPM01q?=
 =?utf-8?B?OUZTa3FYcnozVTNhdytqb2FBQkxIbHRZeUtHUnk5d015N1FPRHhjYVFtanBJ?=
 =?utf-8?B?S1RjdHg5Ukgzc1pTTzhBQndUWjVsQ2R6eHRKR2tYY0lGenRiQy9XVXBCb1Vu?=
 =?utf-8?B?ekowY0xQak96TUlnVTdQR3M3OG5DNzFrNTJwaFFWQ2RWRG9UZjlSUWxjSU5V?=
 =?utf-8?Q?WYZb/EovuYf0GlePzP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 610f4197-0f1a-4cd4-a4fe-08df22e45edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 13:27:14.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b006032-f7cd-404e-8f6f-4719f041417b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/nJDQ4LHWJnM4HEnOQqYutD893lyGrZpWmaQqreU6euIuz54PTno5ZACOQ2RRC/W/eMU3uNAHS+PtS8uvxtMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992282

Rm9yIHdoYXQgaXQncyB3b3J0aCBJJ3ZlIHJldmlld2VkIG15IGFwcGxpY2F0aW9uIGNvZGUgc2lu
Y2UgYW5kIEknbSBjb252aW5jZWQgdGhhdCB0aGUgKmFjdHVhbCogaXNzdWUgKHdoaWNoIGhhcHBl
bmVkIG9uIGEgcG9vbCB3aXRoIHBsZW50eSBvZiBmcmVlIHNwYWNlKSBkaWQgbm90IHNlZSBhbnkg
ZnN5bmMgZmFpbHVyZXM7IHdlIGxvZyB0aGUgcmVzdWx0IG9mIGV2ZXJ5IGZzeW5jL3N5bmNmcyB3
ZSBydW4uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEb21obmFsbCBNY0d1
aWdhbg0KU2VudDogMjkgU2VwdGVtYmVyIDIwMjYgMTk6MTYNClRvOiAnR3JlZ29yeSBGYXJudW0n
IDxnZmFybnVtQHJlZGhhdC5jb20+DQpDYzogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQu
Y29tPjsgY2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IExpeiBOb3JyaXMgPGVub3JyaXNAa3gu
Y29tPjsgQnJlbmRhbiBNY0FsbGlzdGVyIDxibWNhbGxpc3RlckBreC5jb20+OyBQYXZsbyBQaWF0
a292c2t5aSA8cHBpYXRrb3Zza3lpQGt4LmNvbT47IFBpZXJyZSBLb3ZhbGV2IDxwaWVycmVAa3gu
Y29tPjsgT2xlZyBGaW5rZWxzaHRleW4gPG9sZWdAa3guY29tPg0KU3ViamVjdDogUkU6IFtCVUdd
IGNlcGhmcyBrZXJuZWwgY2xpZW50IDYuMTIueDogd3JpdGVzIGFmdGVyIGZ0cnVuY2F0ZSBvY2Nh
c2lvbmFsbHkgYmVpbmcgbG9zdCwgbGVhdmluZyBob2xlIGluIGZpbGVzDQoNCkhpIEdyZWdvcnks
IHdlJ3JlIG5vdCB1c2luZyBmYXN0IEVDICh3aGljaCBBRkFJQ1Qgd2FzIGludHJvZHVjZWQgaW4g
Y2VwaCAyMC54OyB3ZSd2ZSBvbmx5IHNlZW4gdGhpcyBvbiAxOS4yLjMpLiBBbmQgeWVhaCwgeW91
J3JlIHJpZ2h0IHRoYXQgdGhlIGZ1bGwgcG9vbCByZXBybyBpcyBtb3N0IGxpa2VseSBhIHJlZCBo
ZXJyaW5nIHRoYXQgd2UgZXhwZWN0IHRvIGJlIHJlcG9ydGVkIHRocm91Z2ggZnN5bmMgcmF0aGVy
IHRoYW4gd3JpdGUgKGFsdGhvdWdoIGl0J3MgaW50ZXJlc3RpbmcgdGhhdCBpdCBkaWRuJ3QgcmVw
cm8gb24gdGhlIDUueCBrZXJuZWwgdXNlZCBieSBSSEVMIDkuLi4pLiBXZSBkbyBydW4gZnN5bmMg
ZHVyaW5nIG91ciBhcHBsaWNhdGlvbidzIHdyaXRlZG93biBzZXF1ZW5jZSBhbmQgbG9nIHRoZSBy
ZXN1bHQsIGFuZCBpdCBhcHBlYXJzIHRoZXJlIHdhcyBubyBmYWlsdXJlIGluIGFueSBvZiB0aGUg
aW5jaWRlbnRzIHdlJ3ZlIHNlZW4uIChCdXQgdGhlbiBJJ3ZlIHJlYWQgZW5vdWdoIGFib3V0IHRo
ZSBQb3N0Z3JlcyBmc3luYyBpc3N1ZXMgYSBmZXcgeWVhcnMgYmFjayB0byBrbm93IHRoYXQgcGlj
a2luZyB1cCBhIHdyaXRlIGVycm9yIHRoYXQgd2F5IGNhbiBiZSBhbGFybWluZ2x5IGZyYWdpbGUu
KQ0KDQpSZWdhcmRzLCBEb21obmFsbA0KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioNClRoaXMgZW1haWwsIGl0cyBjb250ZW50cyBhbmQgYW55IGZp
bGVzIGF0dGFjaGVkIGFyZSBhIGNvbmZpZGVudGlhbCBjb21tdW5pY2F0aW9uIGFuZCBhcmUgaW50
ZW5kZWQgb25seSBmb3IgdGhlIG5hbWVkIGFkZHJlc3NlZXMgaW5kaWNhdGVkIGluIHRoZSBtZXNz
YWdlLiBJZiB5b3UgYXJlIG5vdCB0aGUgbmFtZWQgYWRkcmVzc2VlIG9yIGlmIHlvdSBoYXZlIHJl
Y2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IsIHlvdSBtYXkgbm90LCB3aXRob3V0IHRoZSBjb25z
ZW50IG9mIEtYLCBjb3B5LCB1c2Ugb3IgcmVseSBvbiBhbnkgaW5mb3JtYXRpb24gb3IgYXR0YWNo
bWVudHMgaW4gYW55IHdheS4gUGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJldHVybiBlbWFp
bCBhbmQgZGVsZXRlIGl0IGZyb20geW91ciBlbWFpbCBzeXN0ZW0uDQpVbmxlc3Mgc2VwYXJhdGVs
eSBhZ3JlZWQsIEtYIGRvZXMgbm90IGFjY2VwdCBhbnkgcmVzcG9uc2liaWxpdHkgZm9yIHRoZSBh
Y2N1cmFjeSBvciBjb21wbGV0ZW5lc3Mgb2YgdGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgb3Ig
aXRzIGF0dGFjaG1lbnRzLiBQbGVhc2Ugbm90ZSB0aGF0IGFueSB2aWV3cywgb3BpbmlvbiBvciBh
ZHZpY2UgY29udGFpbmVkIGluIHRoaXMgY29tbXVuaWNhdGlvbiBhcmUgdGhvc2Ugb2YgdGhlIHNl
bmRpbmcgaW5kaXZpZHVhbCBhbmQgbm90IHRob3NlIG9mIEtYIGFuZCBLWCBzaGFsbCBoYXZlIG5v
IGxpYWJpbGl0eSB3aGF0c29ldmVyIGluIHJlbGF0aW9uIHRvIHRoaXMgY29tbXVuaWNhdGlvbiAo
b3IgaXRzIGNvbnRlbnQpIHVubGVzcyBzZXBhcmF0ZWx5IGFncmVlZC4NCioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo=
