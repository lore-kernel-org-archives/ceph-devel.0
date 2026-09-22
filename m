Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023115.outbound.protection.outlook.com [52.101.72.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C24F85A0
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078500; cv=fail; b=YlW9anUcwMiTwUezAkEvUaEJSz38h9wweN/L4KW5IoV0d8iJnpIBoRNXsh4+XHfblcKUeMV/vXhIJoQFFLSRXqWcRJq7GZPQx/LjNAgQRy65MPyZQcKKoQhEi5/vxc7Taj3v0U+iebCgiuWGIEWTpwKht7t+1nyZsU/RiXYXO7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078500; c=relaxed/simple;
	bh=RWlDSJ9dP+jPxGuMQe91wdiE3jNSvnJZY/B4zmHYjx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKJD6yLb0hjALoRAMxJZi/pwRqwcfnuD2AYWptL9VLKHf04A6u1ahOhWlk44H5/wPfeabth5JCVajN/PnkKOzD0oRf8KkfaA28EzDIgVsx8ZxJu9kmg8Be9/KEcmedDEim68DDsLq7vjV/9II6/MUMdmLPy8RaQvimANo89zHoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kx.com; spf=pass smtp.mailfrom=kx.com; dkim=pass (2048-bit key) header.d=kx.com header.i=@kx.com header.b=lZgS9B2U; arc=fail smtp.client-ip=52.101.72.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kx.com header.i=@kx.com header.b="lZgS9B2U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLSImUPZRG/c5Gfr31i56hYWsBmURugCAaWeP0KNEC0scS+FlLZeCsUIdvfo9pH97QiYRPNFMpx8WBCV2kBLwZYgymcA/DmWC4Op0z9EHyYldBoD2EZltsddmm3sYMLfn6Hcmp8Rpk2pXOXhWV1VzmwnPhw2oVDO2WE9z9a+gpnmwdtgM9LgzOJgV0oHi0PflvD+KTH5MTI0TE5a1x4Ow3e0my07xxrxxZflCjFZLLR6BZVQQr0w1eymDXiHuMheD55CjTVp7HjLhM7hIZcBucfNCxmxaZX5R+BVxRj9qEFCwgBGQe3zTHim+riKKKUTwETH40fUbJa70plcJO7E1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWlDSJ9dP+jPxGuMQe91wdiE3jNSvnJZY/B4zmHYjx4=;
 b=jnBJgcKDkswaZw1U6JbJ8ovMjKWBQg+KwLWziGxHXAgomD6SFib0L4U7yijHx7JnoVXVqKY95e0gOOOGy/gYxImJmN8C72r52ke2zpingcVCJ7YWzRj8etlmVn83/gczFnj8NAjIyqI2aNsYU8Kn9R2hRmwIyL44Ssrj3YxXBrlOtso+HUN9GTh+VWFgCGL+RocW3+rt33Hn+F75ZFYRtmBFnpEOPYM3qckGVoqSKlPOdjRuUjF4edbwnReQELr3KdriQLI41vnTXuKSMV1TfbNS0s0tehuCePUzsmXYegX6GgwJPmUqDYTK3+IH1Lyz3buNpJkFh/Gya7/IUmDxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kx.com; dmarc=pass action=none header.from=kx.com; dkim=pass
 header.d=kx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kx.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWlDSJ9dP+jPxGuMQe91wdiE3jNSvnJZY/B4zmHYjx4=;
 b=lZgS9B2UkLXrTrbnQVZiObQTj+Tb7DSO4TpolPlf/SXjnvirCyB9WGvFjJJStmNScZe1Km/tOj4IdNzB+TjQ54h7cdtetlxSEhjl/oiukV9sASp1LyZqG+Rv+vl2/dvPuaw6Kfr2qc09MISyxMNpC7DeWniHl+coGnSFpOBsxtzGsvG5h+Em6dg7E9xSUp5dc7dZi1Lnx65VLKYs+HXli8pHwWTSAC6E6cRxhZoCErJNKN+kdvZDihLCd43hNRezxXfEynuD8VShUK1rmgEQ8nx3f1wNQC0EFIW9JE3w3RFA/Vf8B1X6k/fl4umTIdWyyesR9byUNFrhkIgX0iUmTA==
Received: from GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ae::7)
 by VI1PR10MB3741.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:134::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 12:01:31 +0000
Received: from GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a82e:3f55:c85d:7542]) by GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a82e:3f55:c85d:7542%2]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 12:01:31 +0000
From: Domhnall McGuigan <dmcguigan@kx.com>
To: Alex Markuze <amarkuze@redhat.com>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: Liz Norris <enorris@kx.com>, Brendan McAllister <bmcallister@kx.com>,
	Pavlo Piatkovskyi <ppiatkovskyi@kx.com>, Pierre Kovalev <pierre@kx.com>, Oleg
 Finkelshteyn <oleg@kx.com>
Subject: RE: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
Thread-Topic: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
Thread-Index:
 Ad1J453OFY2uoDx/ROiPZd0eA4o9DQAClFgAACVv1QAAAFGYoAAAfTwAAAAHsNAAALufQA==
Date: Tue, 22 Sep 2026 12:01:30 +0000
Message-ID:
 <GV2PR10MB613812F687DC650520DF45B8DF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
References:
 <GV2PR10MB61387727F5B89B621AD8307BDF842@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAJ4mKGYf8KDH368dfxp1d3GQ5boUcewYxcbdB1cWSt=JR8oy2A@mail.gmail.com>
 <CAO8a2ShV8X+z1=FPUjZ+voQi2SCsSdauwv2a2wS9dBzt+bk1bA@mail.gmail.com>
 <GV2PR10MB6138FA66DBC7CE7434418686DF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAO8a2Sj=iRe62a+pO-7wAdYUQa59KObRsop8zus+KXCxp9GF3g@mail.gmail.com>
 <GV2PR10MB6138225665859A9E2054D4CADF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <GV2PR10MB6138225665859A9E2054D4CADF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kx.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6138:EE_|VI1PR10MB3741:EE_
x-ms-office365-filtering-correlation-id: 38185702-4d9b-496d-236c-08df18a13d85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 dB/id4ppueYkzrLE1+j3XjB3wf9fEN/DH14mcr810oz+VVcdwlJnbfxXIyiyNLo9TCXXjf8XTB0lkon3M1rxBQPgqjoxUIP0rNWizex7QmIfAF7ZL+282s3Q43PWGBX1qKIIU3UPP8MDcBEy+Ij2GWgLWxxvOGYtnhYreSpvjAl/Hn9PGxXKBE12OANdKPnwIQL1FQIduUMQF6p02l7CQ+pg+fDBkRzKy21p/9diNcV/mtfcFQOTJRBhpxmlaRvic3IVV/B5FWw0kpPw5iMPVuKcGkUnpQnitlMOap1e2NB1bFIkVbDt2Xp6iT3kOXcgWWaDIMncFSIr1XIJecoGUgLgSt+4WQdeyUhQza+UBJByiCpcWJ1CqWm+llLobTjdikwWDEgzZdcRlfuuM+bol3upNPghN0lP1r7bwQtua5okizrfRLH6Zv3tWNjMRZnsE2+yD9iFWSDWvNMxJNodVXkSs8GpKfTgDxrILGsu3buewQE2RtVJaryzKJliXY+iRukp8AFIauRUA24tvsq+wr5XKmRSRTJO0sV3zYBD5R5gedm58aF0+YGDScX9l0zdfrHASIj+diO2UKLW8I6t6TfxdpanOODc42RRvK6MBQC/qwCZYVeXIBf2JuOgUTBpQx84JdwJj6B+7G0fZXsmSkW/M19NZFsKorB9kxh2givLA4+eclF+v911Nd2aAIj1UJRu5EhzZ0FWerToBlGdrsklsj8aIi/hpBOuVUteufs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW9FRVdCQy9mNVI3YWIvZjIybVVLZ01UL3Y5WFd1ckllUG40NnpNb29yTVB0?=
 =?utf-8?B?ZVdwSFVwbnpVL1F4ZUJtdUpIdE1sbWFrVzdmc1RBeFlUeHZwUi9YSnI2OHhV?=
 =?utf-8?B?M2FMS2tNOS9NNSsrNWxHZzMxM3JJZEJmTTFJTzVqT09jSmltSEQrY1EyUEor?=
 =?utf-8?B?d0J4TXVjaDZxblRzTjRlNW02U3VJa2kycGU3eWk4Rk5ZMnpwd2hEeGFnaWti?=
 =?utf-8?B?ZmlEa2NoQ2tYRUlVWHBHMnp1MXZtQS9CSFdUOG5jakllelFEaHo1YzVQWXlp?=
 =?utf-8?B?K2FjUlZxQWFUQmo3eTI2b1hMV0kwT2dOZjFZYkRENHVCektKZDdzR3BkU3pX?=
 =?utf-8?B?OFVSV3pLUHA2cTZQYTcwL0Q2Y1FEaWVmZ2xYL1FHN0tHbllVUzB0NnYrU29P?=
 =?utf-8?B?MlB1N3ZBdS9hNlZDckNRZTlDcThJMmJMalgyNWpEYzBlSHNpeU1IcldyVGVl?=
 =?utf-8?B?aGllVlBIenIreUhyNTExWTFRMGZGRVB6eXNKbWw2WFBleGNWR3pMeE5pSmtT?=
 =?utf-8?B?UjRPcWF4dzVUeWo0Wm9kdEpNbG45RlJMeDJOdTAwL0xVMmpRVTk2R2dtdzJ3?=
 =?utf-8?B?dW5ldjFFN2RCVjJMM1dVL0NoZVhuMndxbk9IM280UFh4ZDdaUWJJSkd3bXB1?=
 =?utf-8?B?R2x1TlFvQWwvVlQ0d1Q2OC9QK0Z4UFFrb2FFWHlZbVZKdTVDQngySHh5N01B?=
 =?utf-8?B?bk51NHF5UFhBQnZCQVBjSFk1cmQzeDBzM2phZUJMYnB1ZmF0TFJveWx0WnZv?=
 =?utf-8?B?OUFVVFVIeVAwc3lWWFVCNnRzVnNoSXVMaUVJaHppSWwwenRHZUJaVlpTVVEy?=
 =?utf-8?B?WHM2R0hUOU5WbEdlZTZqVnRFMzRzMTR5QTA4dW16aGZnWTRTMlJ5R0xTd3VQ?=
 =?utf-8?B?RU1MSEdNaHpOdWhpamcrU2xlTUZ2eUtpemtMUXBJTUNDQk5HaTRXbUVYL2lw?=
 =?utf-8?B?WjZyM1J2Rjl6dDMwWEJGOS83bVN6WmFhTzN3a0s3aWYzNTRyTXZod1IvUjli?=
 =?utf-8?B?VGFiaFdMdDNISmkrbHJqcVdZa0JRRWR0V282c0xDQVdHUHh6c1dPM2lyYmtD?=
 =?utf-8?B?K3lIQzFpSGN1WjlvajRpcnZ4bUN0M2k0RmFMMDlpYmVodjMvYi9FRHRlUTZi?=
 =?utf-8?B?OVBteU03bnd2Z0hPZVdqOHlTYnNzeVBHcTk0ek43MEtzbXJ1TlRZNjRhRnpa?=
 =?utf-8?B?cERVc3doQ09qUE9qWTFkNDRUMkxzYzUycWVZZEdXb0xSQXVQb2ZweXlyZVJa?=
 =?utf-8?B?RzBWV0RiMVhPTzJRSXdpNVZKd05xcUxEdlo0UjNOYUpYYzlibDdWeTQ3VnNO?=
 =?utf-8?B?V3N0RDJSS3hINThENlp6SGRDUTJ2NXZlVFVyQkhmSWJ3aG96T3hGOUNkWDFr?=
 =?utf-8?B?UnVyK3RWSkkwajhRMUxTRC9sU21zbmlQL3FWMzg3eUthZWJvMC9vVVpiaVhk?=
 =?utf-8?B?dmoxcnhLcmNGM001bzQzUE1aTXdMTmRjR1AycFI0dDYrSTdPQlZaQ1h2dktO?=
 =?utf-8?B?a2t1SGVobytPcGtjdkgrZngzeldLQlQzcUhxY0kzQmcxRHltU05vaExuaDEx?=
 =?utf-8?B?Y1JEUnExTjVDbE4yVFVPRGs2cjBFTGFnZWFYMHpWbStSb1NUNUpkQnJ5VHp4?=
 =?utf-8?B?VkNmSVY2YjlJaU9rUHFTbzlxWWFhakJ6SXdPMm82TWwvZWsveDZyNTl1WVlp?=
 =?utf-8?B?MTVUcDZxUzVrSDMwUHBYdzZOYUpERUdUS3hBbUMrZG5hZndmbnduQm9DNlQv?=
 =?utf-8?B?QmxoZUo0bjZsQU5vc1RYa1lPc2dKbFoyRHpnbWVaR0RwRmxEaTNGbkNDUmUx?=
 =?utf-8?B?RDE3amcxYlhKYzJKdnNBU0Q3Z1dvYzhrRHFsUklPU3BEUDdQOCtlOUd3UlRU?=
 =?utf-8?B?Nm1oZFZ2YU1FSXhVbmMyMEEyZlQvdko4cGNTVFJyNHdjZW1jK2w4SG1DNmNF?=
 =?utf-8?B?YU9UajFJQjNFQW45bkliQWNVSWFETVRPd04zWjVDU1ZhYkpMOXMySDdNclpp?=
 =?utf-8?B?aDBRakFMQmhPalhlUlZyUGhVZkljNEdreDZMcCtlcTR6djNjZkFjTmVEUVFk?=
 =?utf-8?B?eitRMWFGeVIzL2tmcy9YN1h1dnU4VEN0VGtqbVlDWmlQcjdQaW9WdUM2c3B4?=
 =?utf-8?B?Ulo5WVgxS0JnOHI5M3ZNNitoQ093bnFxNndrdGVrMjZ1b3J3M3lUNExWT2cx?=
 =?utf-8?B?ZzVKdTdzVkxBZVhxaHBmeDYxb0VIZkhCZTlkSmtpb3h2QjVGZ1p5UDZjQ0Yz?=
 =?utf-8?B?UVFsUmcrK0xqODlSaTVDbnZEZ2tKdTM1NlVqdU80VWo0cjFnUDZ2aGRRMy9J?=
 =?utf-8?Q?RHiGCHLqknr1/uIydM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38185702-4d9b-496d-236c-08df18a13d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 12:01:31.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b006032-f7cd-404e-8f6f-4719f041417b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkayQFu4QUxvLH7Ub945ufW2xJH7PqbyA2aqoHoFOfokF24OIcUTlfHxivJVAnU+EIq7mvm9TJVJ7WTKvW5dCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3741

U29ycnksIHNlbmRpbmcgdGhpcyBiYWNrIHRvIHRoZSBtYWlsaW5nIGxpc3QgYmVjYXVzZSBJIGZv
cmdvdCB0byB1c2UgcmVwbHktYWxsLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogRG9taG5hbGwgTWNHdWlnYW4gPGRtY2d1aWdhbkBreC5jb20+DQpTZW50OiAyMiBTZXB0ZW1i
ZXIgMjAyNiAxMjo1MA0KVG86IEFsZXggTWFya3V6ZSA8YW1hcmt1emVAcmVkaGF0LmNvbT4NClN1
YmplY3Q6IFJFOiBbQlVHXSBjZXBoZnMga2VybmVsIGNsaWVudCA2LjEyLng6IHdyaXRlcyBhZnRl
ciBmdHJ1bmNhdGUgb2NjYXNpb25hbGx5IGJlaW5nIGxvc3QsIGxlYXZpbmcgaG9sZSBpbiBmaWxl
cw0KDQpXZSBoYXZlbid0IHlldCBiZWVuIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSB1bmRl
ciBjb250cm9sbGVkIGNvbmRpdGlvbnMgYXQgYWxsOiB0aGUgYmVzdCB3ZSBoYXZlIGlzIGEgZGVw
bG95bWVudCB0aGF0IHNlZW1zIHRvIGdldCBhIGNvcnJ1cHRpb24gYWJvdXQgb25jZSBhIGZvcnRu
aWdodCwgd3JpdGluZyA0MEdpQi9kYXkuIERvIHlvdSBoYXZlIGxpbmtzIHRvIHRoZSB0cnVuY2F0
ZS1yZWxhdGVkIGZpeGVzIHlvdSBtZW50aW9uZWQ/IEknbSBnZXR0aW5nIG5vd2hlcmUgdHJ5aW5n
IHRvIGZpbmQgdGhlbSBteXNlbGYgYW5kIHRoZXknZCBiZSB2ZXJ5IGhlbHBmdWwgdG8gcmVmZXIg
dG8uDQoNClJlZ2FyZHMsIERvbWhuYWxsDQoNCkZyb206IEFsZXggTWFya3V6ZSA8YW1hcmt1emVA
cmVkaGF0LmNvbT4NClNlbnQ6IDIyIFNlcHRlbWJlciAyMDI2IDEyOjM5DQpUbzogRG9taG5hbGwg
TWNHdWlnYW4gPGRtY2d1aWdhbkBreC5jb20+DQpTdWJqZWN0OiBSZTogW0JVR10gY2VwaGZzIGtl
cm5lbCBjbGllbnQgNi4xMi54OiB3cml0ZXMgYWZ0ZXIgZnRydW5jYXRlIG9jY2FzaW9uYWxseSBi
ZWluZyBsb3N0LCBsZWF2aW5nIGhvbGUgaW4gZmlsZXMNCg0KV2UgYXJlIHVzaW5nIHBhdGNod29y
ayBidXQgaXQncyBub3QgYmV0dGVyIHRoYW4ganVzdCBnb2luZyB0aHJvdWdoIHRoZSBwYXRjaGVz
IHdpdGggZ2l0IGxvZyAtLWZvbGxvdy4NCg0KSSB3b3VsZCB0cnkgcnVubmluZyBhIGZyZXNoIHVw
c3RyZWFtIGtlcm5lbCBidWlsZCBhbmQgc2VlIGlmIHRoZSBwcm9ibGVtIHBlcnNpc3RzLiBJZiB0
aGUgdGVzdCBpcyBmYXN0IGEgZ2l0IGJpc2VjdCB3aWxsIGxhbmQgeW91IG9uIHRoZSBwYXRjaCB5
b3UgbmVlZC4NCg0KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioNClRoaXMgZW1haWwsIGl0cyBjb250ZW50cyBhbmQgYW55IGZpbGVzIGF0dGFjaGVk
IGFyZSBhIGNvbmZpZGVudGlhbCBjb21tdW5pY2F0aW9uIGFuZCBhcmUgaW50ZW5kZWQgb25seSBm
b3IgdGhlIG5hbWVkIGFkZHJlc3NlZXMgaW5kaWNhdGVkIGluIHRoZSBtZXNzYWdlLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgbmFtZWQgYWRkcmVzc2VlIG9yIGlmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMg
ZW1haWwgaW4gZXJyb3IsIHlvdSBtYXkgbm90LCB3aXRob3V0IHRoZSBjb25zZW50IG9mIEtYLCBj
b3B5LCB1c2Ugb3IgcmVseSBvbiBhbnkgaW5mb3JtYXRpb24gb3IgYXR0YWNobWVudHMgaW4gYW55
IHdheS4gUGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJldHVybiBlbWFpbCBhbmQgZGVsZXRl
IGl0IGZyb20geW91ciBlbWFpbCBzeXN0ZW0uDQpVbmxlc3Mgc2VwYXJhdGVseSBhZ3JlZWQsIEtY
IGRvZXMgbm90IGFjY2VwdCBhbnkgcmVzcG9uc2liaWxpdHkgZm9yIHRoZSBhY2N1cmFjeSBvciBj
b21wbGV0ZW5lc3Mgb2YgdGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgb3IgaXRzIGF0dGFjaG1l
bnRzLiBQbGVhc2Ugbm90ZSB0aGF0IGFueSB2aWV3cywgb3BpbmlvbiBvciBhZHZpY2UgY29udGFp
bmVkIGluIHRoaXMgY29tbXVuaWNhdGlvbiBhcmUgdGhvc2Ugb2YgdGhlIHNlbmRpbmcgaW5kaXZp
ZHVhbCBhbmQgbm90IHRob3NlIG9mIEtYIGFuZCBLWCBzaGFsbCBoYXZlIG5vIGxpYWJpbGl0eSB3
aGF0c29ldmVyIGluIHJlbGF0aW9uIHRvIHRoaXMgY29tbXVuaWNhdGlvbiAob3IgaXRzIGNvbnRl
bnQpIHVubGVzcyBzZXBhcmF0ZWx5IGFncmVlZC4NCioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqDQo=
