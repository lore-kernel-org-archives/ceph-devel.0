Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022104.outbound.protection.outlook.com [52.101.66.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF936215E
	for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705743; cv=fail; b=NEBt0nwxbWM+1NwXIq2Q0RK2EYK30cBxpNLrfEnqRQeLl1qcTxV+C5PyKs0PcnxkVoRxoXIZLks54iJl+tWvteUAU5LIr3ie4RK8u3OUFrc3C9L5pQufsEt2mbCblvdUlqI78qdMhZgt4GrHKLJ6A+rfll0leD5XtBOz8oNRs2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705743; c=relaxed/simple;
	bh=4c4qPxTlk/5qSIMmI6KwnGXtYnEaf532rQY0X4/8DjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XlZSoUTDN+eZApbVoCl1JqLSBpC4KgaKIA5ggKbe9O57m3nbjO73QFTOzoUAv/YKBJW8E6V1BiHmFKPJ/MoLlFEBRuHJ90ol3mwqDoMvtuNxPvO4B1WfgFoSeyPIbrjpOA7FFUFPmraGrsYdCdgriikR3FzgIwPjoNsifnmkYm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kx.com; spf=pass smtp.mailfrom=kx.com; dkim=pass (2048-bit key) header.d=kx.com header.i=@kx.com header.b=ueFjFQLt; arc=fail smtp.client-ip=52.101.66.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kx.com header.i=@kx.com header.b="ueFjFQLt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwUKC7XBkNsM4JNF9x4ttfl9pFNsCgLxBCY2Hr3RwCJE0fJJQPCz2NGEseT32TjfYwd10LdHSyNwwq9DfcGm+szGT5Gs1e/9YlHtq/DcW47SMFGV7p05H8zf4JCndclT686Yoas0CRYEbbXaYuD/qK4LR+14I7idmu/4XBOv16vGlEdjmC5Qy+rc0Z5vyTLBcKeNcXGijpvfodTgqHjDotW4Nq5mUdpsZxxiPXGpnBvYiq+OjKfoQG4jB4KTVMKlAFaDhH2gFYtckxX/M4OGx69C1q9j8E85ND4kewKp46jIZmXKAQKg+6xzVVFuDSeTf3fyduVDaLf01pfnOx/QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c4qPxTlk/5qSIMmI6KwnGXtYnEaf532rQY0X4/8DjU=;
 b=vue1JI57+g30AisZnmWlBsHKYP9H2hCsMeWp7ecXrkHywWswYBGl6MXRlJkBNdvke/SbqAVoSpsuQXFOsh859YpDZ9zn7s0+43rTei7AP4p8Wc066cZX/bjNIXDQoXjO89vsaZpdLrX6G3EeQZ2q6LDM8Tw+h7azQJ4KzhzSLH5cIPj6TIlPvxxwybh8RkrDXTn6QFz5kwnA72tncRXI8pF1x6gnlcBZnD8fsgZ4/3zal1YZBASsg0aSDTAGIYKElHXevkMzJuSBgNnhKDaBwuGD3QqChY9TTVvsR4RNOrmSeKISNMinPEOrljoubHpWev6tmdSQSFophFwogNSV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kx.com; dmarc=pass action=none header.from=kx.com; dkim=pass
 header.d=kx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kx.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c4qPxTlk/5qSIMmI6KwnGXtYnEaf532rQY0X4/8DjU=;
 b=ueFjFQLt1yhkXCLfG8V/4q26SNnK4DCG99bAerOAkE9LOEr8GvTKfPBoF/dpfCy3b9vgalCtvG+AafZJouFNwraQe3IQ7ldcwnfU1mK158NQ7PIpDLfneZZwbSV7T/8Kkk7Mppdw26y7Ps/MTw/gXlvCu+uFaavbtGoxvVDhdZcpAxokjYIIZWV7tfkJIkohQYwdq5RxEBCjgU/pY5HnApnTGTTNATlwEkjo/ReTHiJu1P1eRjrILhTIWuvhS7TQI0jou6vkIGCWKGJcvWsFvNYj/XHZBq0JdGoa6gDozvBaOnb+1g4Pfu0gwzuD+yCcNRoql9YBkfHLrCdHPdaQ7g==
Received: from GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ae::7)
 by PAWPR10MB7246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 18:15:36 +0000
Received: from GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a82e:3f55:c85d:7542]) by GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a82e:3f55:c85d:7542%2]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:15:36 +0000
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
 Ad1J453OFY2uoDx/ROiPZd0eA4o9DQAClFgAACVv1QAAAFGYoAAAfTwAAAAHsNAAALufQAAqP0+AAADnagAACw5e8AAsvi8AAAh2RpAA++6FgAAFkv3Q
Date: Tue, 29 Sep 2026 18:15:35 +0000
Message-ID:
 <GV2PR10MB6138251631686158C69FD365DF8C2@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
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
In-Reply-To:
 <CAJ4mKGZcJG9y2tmStFA_qsY8=ihhc_9Y8-t-Y3E3yxW5E0v71Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kx.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6138:EE_|PAWPR10MB7246:EE_
x-ms-office365-filtering-correlation-id: a9b8e72a-8cda-451e-7b4c-08df1e55a898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|376014|38070700021|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 PxwkBLEdlS23iAK0/ECUKUgGytTkPzgfF/OXeED0sRDeFOhoN/0vouGIim3XN+3WJT2TPaPuHhBOuxbPE3sOrMXBoLLIYqRksTNPNxtdI9vf4/eaM3CrV/3N1xnXF5hzfEmOhAa0EiZL9Dw1hb6UFlg9TN6sizmdCItLj+Rn3Mpsy/EYYkiGM5jcvML9WvMWSe3DMiNgEVESZ48iQlmpzfrhTMfqV7+TgXP4oz0AQHMOPveAFzoiR7EL9Rv11WZNmEbVXEbDnqd0pjT+GHIV64kO/uzKWccw+oED12SZibWtDUdxhbyOzO3QikC4+ohmSVCOnWOS64xz3QJJCqgm01hgFHgXQ656uzl4dR8nV11P/RcFZ7k5ok2XhucU4hIbF7wdpGfIrehuxwqM84guZ0z0fN/ktKYvPQsAIdpjsJkUF+7oiWPhcAiaQgpgUShSh+VuPJ3s/1jk6lHnikktjJ34plPNdo9fl8KszhSejGrRXN4j3UUw08AkBIvww0sBx5ymCrQVg7VF/z9M2h1kgnkjWrK9smhw7+hAYJQZsKr1dkHm17rOohpCm7jf/tG+jbadYluNWctAOa0f/ILRUEYRiUA7/sHJz3awJ5o/OUdBKP25b3ksqHd/qJumZjupSPAZ4g2k6GTe15XN88VSc8q0Vzwoxud0IbvNHptRrDz1+IsLstN3enyKMRKiB6bR2SJaXeIRiYAi4KTqIavWXVpa6hHw7o9KWsA+sxzm0T8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1pTVjY0Ny9KYytEVlVCNVc1cjNieVYyeVVRc0txTVE0NkxpQmlkWFFoSFA1?=
 =?utf-8?B?Z1Q1eWNHVThwTDltTlJGRXBxMk9GVkNNYUNyNGxtSEo0OHZuNGRBaThXMGds?=
 =?utf-8?B?VDc3dWMwU3pzMWRlNVU3cFRCY3oxbkZsYUNrc2ZPbC9yS2F6N2NkWkVlS25r?=
 =?utf-8?B?OHhreTlYNTVvalVQMjVNVGtPWEVYdmgxVjVoelNXS2t0azZWS3dDcUFCNkZP?=
 =?utf-8?B?Mld1RjBva2pGckhvMHVoUXM4ZFZDeHVPcC9VMENlQ2xtaEh0S28veUoveDlO?=
 =?utf-8?B?c2c4Y2V6ZnhuOHBXdlNxbGUweHlVdVNzaC9KUUhxN21McXh3ZEhpbEFrYktZ?=
 =?utf-8?B?bGJWbnFLQ3U3U3pBRkRsZ2VBRDJTVGRuejdhN3lYMXVCMmZ1SFhpRWRtL21v?=
 =?utf-8?B?Q2d2eDZYcHErRGtiQ1J3OVNCQW1wUkNhOVpLYWpreEZiQnhMRjY1RU8xMEIy?=
 =?utf-8?B?RklzajFER2NaNEtpa3N0T0sxUC9WYk85QVkzSUFQYzBXQmNrNWlZaXlPb2Jv?=
 =?utf-8?B?aFo0bDBPRnBmWmNjZ0pvOXNFTmZOam9pSlJML2lQOHlEWnJERnhRR1BkVUNi?=
 =?utf-8?B?MjF5MFNMUytGS0h2dExSWCtrclp4d3l2R21jV2Z1ektYM3BRTEx2d213ZHJR?=
 =?utf-8?B?V0J4REJwd0FBeldsNzBuV24wQlhyMGpvVHgzSWJRSFpMdTRwMDVZb3hHR2k2?=
 =?utf-8?B?TFRuOHJpekxaRDJBYnhMZTJyWnZhWlZDOXpFc0VmQ3BMTWpwblRLZTFUclZv?=
 =?utf-8?B?a0EvV3VvaTBSa244TVBsWGdYOXoramJGTEFPM1ZRSzRONGU4cGdrRDI2SjFP?=
 =?utf-8?B?aXp6UVhCOHFHb3F1WmoyYU5SeUFYWlBZSWVrWGZxNHlTQkFaYnBwa2plZ0NI?=
 =?utf-8?B?aDYzRzlxQ2g4TnBWeW1DUFc2c0FtRkMyQzlDcmtxR0N4MC9qa1hHZmpVOHNv?=
 =?utf-8?B?SmVERUZkaEhnOFJQYVp5K0pVbUdJSS9QcWU5djc0Y3RYS3BKbkhXYmJkMHBU?=
 =?utf-8?B?cHNJREVOOTdJdTJRM3dBaG42MnZCaml1ZmxKZXhUWXpjSWtHazExSFZIN1Vv?=
 =?utf-8?B?T1BwUzAxNHVTQTRTZi9nWGhzYS92YktxMGY2azZSTXR0b1ozcmxOTHlCWFlW?=
 =?utf-8?B?elorUEk1VzVMN3hNQXRZWDgxOE1XZFErTmE5dlU2Q2R0MjdvR3RGeGlxcG8v?=
 =?utf-8?B?TXhiaEhnRmt1WUlsY1c1QVZPMnljK1NNNEhrdjhVbHRGdFJnMFR5RjcrQUFa?=
 =?utf-8?B?TVNsMkw0ZlNMejU3Q1VyZDJVSEN3MWxYa2lrSm90KzFYemhTNUtDdkZqenha?=
 =?utf-8?B?STRIWW1pdkw2cEpDYUNDdzlTYi9OMDNteVlER25uL0ZVcGFpRkpwZ21KRjJH?=
 =?utf-8?B?WEgyVUY0eXdyMDVEM0pGOW4zUjJiQ25YOEp4WXNtOGF0Zko1SEllQW9BSDJN?=
 =?utf-8?B?cnJFQS93VE5XRlIyRnBMRlpZOG5tdVJUM2FKL295UHhodTR5Nko3bFRxZzVV?=
 =?utf-8?B?cDdaVVFiWHVlK2VEdkRjY3pzYUNlR29Wb3l4L1R0SC94WEVkR0YwckdyNEVW?=
 =?utf-8?B?OVk1ZEp5cVNsZU9OOVF5alFVYTJYc09UMmhlbG5BL2g4UkZQTDNxWXpXM0V0?=
 =?utf-8?B?L2JFNHhzb0NBWWx0TWQwV2srdEpkd3hLOFVPZi9LYTJpT3Ywb3hZMzZRS1dG?=
 =?utf-8?B?aVNFRjRIRERZQ09zQ0UvZ1gwRk9DZDk0Ulk1TFNvVlVsUUFOTnVITUFvNFJk?=
 =?utf-8?B?TWlGK1JkZm0zeERWbTNDcE11YlZnTHRWemVXQncvbG44SUxTZXNQRENpU2NR?=
 =?utf-8?B?emkrM0tBb0N5VnFuemREUUJMQkw5QjRER0ptL0dqa2o1dHhGRVY2c05RYVZW?=
 =?utf-8?B?T1EwOUhEd2FHSEp3UjhyM2NoblhaYzNxUUlDbE5EbW9ERDhRc09zdnBrQjl2?=
 =?utf-8?B?UUl0VExFUU1pdTFld2FjczMxN01uM3RrSmNoejFTMXdobzJrcjhHMHYwZjkw?=
 =?utf-8?B?aENxZ2x4MkxLYVhvQmUvVkNLTlJHam8vMEN5b3QxWGM1MHBpc2NpV3c1TVgz?=
 =?utf-8?B?R3ZxemM3UDUwRVVDY2J0c0QveUQzaVphUTgzdS83VXJYcHdrUEs0VXpKQzNW?=
 =?utf-8?B?RUhjdG0wV3NYT3liZHBCZ1hyS3pYcXJhVUVkY0JJMEJOUkhVU3ExMGhrK2l2?=
 =?utf-8?B?dGJ4Nm14a2RBcWt3T1hmRHFKLytNRlRpL0V4OGFlR0Z6MmlJZGdvQTNibFpK?=
 =?utf-8?B?MThMb21mMGt1YkRkeTVFaDBTbzFkS2pZNzl3MmdpT3Rqay9sR1JYeWY1MXRC?=
 =?utf-8?Q?Io/qe9nDibs7vKWd2B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b8e72a-8cda-451e-7b4c-08df1e55a898
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 18:15:35.9407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b006032-f7cd-404e-8f6f-4719f041417b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKDJ+1guhxBB2QV2EZ4sJfIT3xMVFX/M0MfnyaWTZ8cohsoYk8PUq9o5izu77rjxnP4+On0D2X9WSdtT4DXHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7246

SGkgR3JlZ29yeSwgd2UncmUgbm90IHVzaW5nIGZhc3QgRUMgKHdoaWNoIEFGQUlDVCB3YXMgaW50
cm9kdWNlZCBpbiBjZXBoIDIwLng7IHdlJ3ZlIG9ubHkgc2VlbiB0aGlzIG9uIDE5LjIuMykuIEFu
ZCB5ZWFoLCB5b3UncmUgcmlnaHQgdGhhdCB0aGUgZnVsbCBwb29sIHJlcHJvIGlzIG1vc3QgbGlr
ZWx5IGEgcmVkIGhlcnJpbmcgdGhhdCB3ZSBleHBlY3QgdG8gYmUgcmVwb3J0ZWQgdGhyb3VnaCBm
c3luYyByYXRoZXIgdGhhbiB3cml0ZSAoYWx0aG91Z2ggaXQncyBpbnRlcmVzdGluZyB0aGF0IGl0
IGRpZG4ndCByZXBybyBvbiB0aGUgNS54IGtlcm5lbCB1c2VkIGJ5IFJIRUwgOS4uLikuIFdlIGRv
IHJ1biBmc3luYyBkdXJpbmcgb3VyIGFwcGxpY2F0aW9uJ3Mgd3JpdGVkb3duIHNlcXVlbmNlIGFu
ZCBsb2cgdGhlIHJlc3VsdCwgYW5kIGl0IGFwcGVhcnMgdGhlcmUgd2FzIG5vIGZhaWx1cmUgaW4g
YW55IG9mIHRoZSBpbmNpZGVudHMgd2UndmUgc2Vlbi4gKEJ1dCB0aGVuIEkndmUgcmVhZCBlbm91
Z2ggYWJvdXQgdGhlIFBvc3RncmVzIGZzeW5jIGlzc3VlcyBhIGZldyB5ZWFycyBiYWNrIHRvIGtu
b3cgdGhhdCBwaWNraW5nIHVwIGEgd3JpdGUgZXJyb3IgdGhhdCB3YXkgY2FuIGJlIGFsYXJtaW5n
bHkgZnJhZ2lsZS4pDQoNClJlZ2FyZHMsIERvbWhuYWxsDQoqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KVGhpcyBlbWFpbCwgaXRzIGNvbnRlbnRz
IGFuZCBhbnkgZmlsZXMgYXR0YWNoZWQgYXJlIGEgY29uZmlkZW50aWFsIGNvbW11bmljYXRpb24g
YW5kIGFyZSBpbnRlbmRlZCBvbmx5IGZvciB0aGUgbmFtZWQgYWRkcmVzc2VlcyBpbmRpY2F0ZWQg
aW4gdGhlIG1lc3NhZ2UuIElmIHlvdSBhcmUgbm90IHRoZSBuYW1lZCBhZGRyZXNzZWUgb3IgaWYg
eW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwgeW91IG1heSBub3QsIHdpdGhv
dXQgdGhlIGNvbnNlbnQgb2YgS1gsIGNvcHksIHVzZSBvciByZWx5IG9uIGFueSBpbmZvcm1hdGlv
biBvciBhdHRhY2htZW50cyBpbiBhbnkgd2F5LiBQbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkg
cmV0dXJuIGVtYWlsIGFuZCBkZWxldGUgaXQgZnJvbSB5b3VyIGVtYWlsIHN5c3RlbS4NClVubGVz
cyBzZXBhcmF0ZWx5IGFncmVlZCwgS1ggZG9lcyBub3QgYWNjZXB0IGFueSByZXNwb25zaWJpbGl0
eSBmb3IgdGhlIGFjY3VyYWN5IG9yIGNvbXBsZXRlbmVzcyBvZiB0aGUgY29udGVudHMgb2YgdGhp
cyBlbWFpbCBvciBpdHMgYXR0YWNobWVudHMuIFBsZWFzZSBub3RlIHRoYXQgYW55IHZpZXdzLCBv
cGluaW9uIG9yIGFkdmljZSBjb250YWluZWQgaW4gdGhpcyBjb21tdW5pY2F0aW9uIGFyZSB0aG9z
ZSBvZiB0aGUgc2VuZGluZyBpbmRpdmlkdWFsIGFuZCBub3QgdGhvc2Ugb2YgS1ggYW5kIEtYIHNo
YWxsIGhhdmUgbm8gbGlhYmlsaXR5IHdoYXRzb2V2ZXIgaW4gcmVsYXRpb24gdG8gdGhpcyBjb21t
dW5pY2F0aW9uIChvciBpdHMgY29udGVudCkgdW5sZXNzIHNlcGFyYXRlbHkgYWdyZWVkLg0KKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCg==
