Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C22DF12F;
	Thu, 23 Apr 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967499; cv=fail; b=erSsh5kYKKQv7tMGYJfYPqHBnDk2SlpSQm/q9BHFH4socArWCropI8sHP+U/ah7vG8Lp60ZA/QSvJ1Kr7TwciEQ77mjcBgRyvZOb6kOvWOOF8ZkRrL6h2lVBzOjuD9srxnqK4smkOJejxks0QNdyuG2uRVpiBfVem4tG888YAI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967499; c=relaxed/simple;
	bh=l2120XGwpuvo8kI6jlA6qwdAFufYHe7hzoEoR4NMqi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DEZf4Oibhik37sg2dfc7THVLmWvdne9yycu6ntbmxQ2bf47uatGABi0twpm5RUuRb/f0tTfcHELX/sVMCEHPpTVGixV6diTjeOsQAlnPu2G9N/mR4eX5Q/NIJGSKT05B71nsJ8KiXJmynEwAWTSibj8nTyBQS0wtEq/zmDOp0OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W+RhNbFY; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W+RhNbFY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7QKUZ3944159;
	Thu, 23 Apr 2026 18:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=l2120XGwpuvo8kI6jlA6qwdAFufYHe7hzoEoR4NMqi0=; b=W+RhNbFY
	1kuBYo4zzZepIlAuhmvP8l7OVGhX0XdwdHP5lRTFXaUN8gHakJCs3m4846lLdQQt
	7GaRARuUAXxBlz+PTAXEkKKheXYrUUMuk75j7Jhah9v0zA0W6nZYfTaCErbYBkv5
	R6QoS0/qRJmFB3YXubQFoG1DcJwX2OD6bUhFb3L4Y7jK28MFHRj02UAuN7BY3h0/
	VkqmMaGvjXdW5hGi+laAdxhHyS1ZyF0uhxnoH+cBferj0nfllvLmbur1bo83XQQE
	XTXHeXbMYmWdbl6vngzFHWuZicbpbAfrAQhAXQywtBG9ZuN31owdccd3OvdDlZjx
	8mz4OQKVBMm3Yg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3sf4d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 18:04:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+Bqs63z9dFTScKdtChSK5JZeZqPAzqzgebv0dCxC07sz8LVLr5/D6XNcWKUDyQdzMA3DtVZhq4LvuxsbiU9fgsQuBxZDPBW095i3jllo9kwocw1tTF9Igu28C1FUWPUujpwwtq31e9IXE0fbjZsbLtD/uVPLy1hwJXZ3QOb7O20sdfS+uQy8WFMfh+pnbKOOni3KjHfxf6a/yXQNRnzRGcnmJYO0WkwzXFjOkrun0e71acftoWClE/fwVPiisVjCnuQIl02tLLsEocpjS00tnMPEJWhTgyxSTxsIx+p6wYgHNIvulJLk+wJ59+ptilof4G6GLKG+WLXcCypv2djSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2120XGwpuvo8kI6jlA6qwdAFufYHe7hzoEoR4NMqi0=;
 b=Qfti/GSVEHhuvnPy6LQfw2AY3APQqcfKjSYHB+K5n+05e4nnDry7Qpr0fIsdNA0GEPqymSvjpE1TtXGQzykWiLWZ7/T7Z0WrHeabqVLKmkSh6V9di3S4eGFcmTndHpzPJgQ7dr+4mAoqUwhBuh3cqEk9TMMdY3HvZa9CvzbIfmYKOJV8on1swzhpyidtlc7n8NDmgB8YAoPAfJkR6vJckTTzRfJ7zsrs7Htm29B6RZhBsCR1SSoHfuznWwq/yVJkVeMUy+MRw9CszBD4mCWee9A0XZqIwJuID7LLIQrxXmtAWAB66AcPu6Q5L6TY7qNV4iFppSlELaD/kafbgAxEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by EAYPR15MB7132.namprd15.prod.outlook.com (2603:10b6:303:2c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 18:04:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 18:04:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: Xiubo Li <xiubli@redhat.com>, "luis@igalia.com" <luis@igalia.com>,
        "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
Thread-Topic: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
Thread-Index: AQHc00uroiLyQ8XrRUuQ5liSmtmBwg==
Date: Thu, 23 Apr 2026 18:04:46 +0000
Message-ID: <4a2802b9a0c82084f833d5211aa3dd0033553a91.camel@ibm.com>
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
	 <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
	 <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
	 <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
	 <f957bdf6488b391b4329ff3cc892bfdc93c014fb.camel@ibm.com>
	 <847376cbf4408d12389545142311cb5883045937.camel@ibm.com>
	 <7e043aa928f13d043552ca650808c0383209f806.camel@ibm.com>
	 <CAOi1vP96JuBi5BhTdiVeL491ziy_hwJUm79TqOb=iPaxck1eyg@mail.gmail.com>
In-Reply-To:
 <CAOi1vP96JuBi5BhTdiVeL491ziy_hwJUm79TqOb=iPaxck1eyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|EAYPR15MB7132:EE_
x-ms-office365-filtering-correlation-id: 2be069e7-d121-4c4b-a5b8-08dea162cddb
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021|56012099003|18002099003|18096099003|22082099003;
x-microsoft-antispam-message-info:
 syNzJVhXs4dc8ZFUBMJAEqSQwfDWFBbdlwIQukXKtCBewi6s5/UHZIxzg6HTVA1Q1Hm/WFefksS0srH2mgbM/nEY87AXgW4gx8bSwMOQQnVaCa/yh0yn4i+cJYXpuzUHJtaMeed5cOYWJOhKmdzD5NpzfkyZeFI/JwO0g0G/qjIUqLW1nZgwN5ZILOH8nrlpA/wN5/U9yvcIzpjrfuxwA4WT2rcnlauTklVAosCzSArACw6EkY+f0iro+xHa9GLSNProXBaspaxEziqfqO9FEzZ7jNWF2Py9SkrDynnUxDdiKZs1OJH/wCfs1w+RrKMHStHi+ZrHQwt9aXEojwIuo9ziUgLGf0mDSAQQyNmtnp5bjlA8WATaL9VvRLDLPyGX0xYmG/9IiCPR6tYACP8zQnAg5NuJk11gNTeEhgCSfeMyqZiJicjVqLs8Xm5sle+iOSArni6Tg14SNBWtvkz5pdDhycLwBtx7ELS98q/+ies8Ht99VvXQQRh2vUnYqb0LHrk1EOhecuHcyRxo22E0nhIjXo6p1dA6nn3z2HvelLFm7bpFrv9NWDmzQPQQqtdXBAhdFf6IyXNDkxWtrzV9Q368CJTFraaSeJ9aHU5mxHUPuNiuBGTeLvqi+og42i4iYuRggZ+IAF3bVcuYorzbVBa0nGh34gnrm2oDeQ8J4Z9e8itWNdnTbeybwR0mqXBFsPuVI4muz/gEpdx/bXOQn3FzSHSOXe+b7ceTCVLO6GdeXAOZFHwyUcBlnWYmiXj37K2EIg4f4VKKdAhXtWnOcRtSPxn1TZ9Gs6pojunKMN0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021)(56012099003)(18002099003)(18096099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVBUcDlNeEhnNGJ3ZUtmemloeHRVQWtSUERpMEQ4VjlabkdhdmhMRGZ2cjFB?=
 =?utf-8?B?cVVIdmx1UnFYc3dHNWtnZDRDR0Y5cTV3bGhEN21rTkJSYnp0MnhlRHViNlYy?=
 =?utf-8?B?anNxZCtUcStoVFc1V2NWb08xa1JoMUUxcmkrdXNWMm9DNmlGN2k5V09DbWtY?=
 =?utf-8?B?cStsK1J1R3NzZjZvMkY3MXhqSE1KcGp3NDAwYVBNVXRjSWg0YW9YREFXNi9V?=
 =?utf-8?B?TEllUUVTbUt1UVlLaGkzVUJmd0JKZlVTa3ZWaHR5czc4MlUyWThRaGZjZUll?=
 =?utf-8?B?SzQzeGdTakExN1RtclR2RUVyZkIrMFFCVTdpN0tmOTRKRUxuTi9oTVcwRUpw?=
 =?utf-8?B?OC9sQ2h1REpzcG1kNVdOY0J4a0FGKzludW95ZCswcnIwQUZJRnRiNTNlVElC?=
 =?utf-8?B?bGpnSzEwa2tLbllmWmJRbTZaQlBDbkdIUDhzRWpDMzZkSUVOSk5vazBhVVFD?=
 =?utf-8?B?bG1ZMGdsdUxYWkdYaWJYeGpaT1R2dW92OUs4aFF2bm5oZFJVRS94Tk5oSVJS?=
 =?utf-8?B?enNiZ0NYckpsY0pHTGhBMm5UM1UybDZrcXRNTTdEMlRtMWR0S29JZjVlUmVo?=
 =?utf-8?B?RkJZdmpLSjVNZWFzQURMU3BSTEsvNTlJMkhaK29mQUlLR0pIZlg3Zk83T0R4?=
 =?utf-8?B?ZHpyMFhML2xURDBnMEFLNGNzUGhqOWg0bGlHUGwveTF2TnZtZGZzYi82UEdo?=
 =?utf-8?B?M0lrcnc4eGNoTlRITWxKTWtPWDN6U1dCc3U1My8xdWFrNUlkek4wZExqWkZP?=
 =?utf-8?B?Z2NaanNnMksySDQyYWlsNS8rWDBoU21keVVFaHFZditYYTBFNDU1N3hEd0Jx?=
 =?utf-8?B?Z2MyVDkrekwreGs3ZVJyOTU4dzhqQUJMMzlwbU9yTVByUituNG5rNEFISVkz?=
 =?utf-8?B?VVFjKzl2ek1IU1FMR2ZrcGZCeUxEbW03TGk3d09pVDQrdnlpUkxuOER1blFH?=
 =?utf-8?B?MUowaUNBdG9iTTR1MEhYQk53R1A5VHhDRldLaXFsZS9TS1NaVU9kT3g1Ti9K?=
 =?utf-8?B?a0RFamFkKzhydEkwLzBaTVlQQjkzMFR3OFVBeUlkWVp4dlFMV0dMN3RnNmVB?=
 =?utf-8?B?N1Y2QTlhNndyLzE0ZVZLS1Z5dStSREUzYWNKSGFuUkRVSjkxcVpVRXMrd3hM?=
 =?utf-8?B?enZKeVZBaU9FVHlyMzRodEt5bzJYeEM5cXNvSW1XVTNyVGVYaHFFbURuMDlx?=
 =?utf-8?B?eWlXeFV2aFlYYVU5alk5QzZ5S3VWZzFIUkQyUmdnMVBub0ZBNURrWGNqQU9U?=
 =?utf-8?B?M0hRbmJldzcydTA2UVBBcHhPazd0YkQwQ0V1NjFBcjIxVGNrSmdHVHh5ZVFq?=
 =?utf-8?B?a2FvNnpJYk5BaWJqSGdDc1RGQlBMR2hhMnhYUU9TRGtUTmRCK0RGcGxxdG5r?=
 =?utf-8?B?bEJmNW15Zm9yc3lIaW5tS2NhRmZsQ3h6WWpjOVYxc09WV1pqNDlRSzZiZkNO?=
 =?utf-8?B?SE5MWEd0RmI0N052b1pjMU55S2dSVnBBOUdVOWt6amdTTHVVbTVuVE5TWC9j?=
 =?utf-8?B?MVBHalhqSHM5VHZLb2RjN2MvRmh3dE5KMHJMOFhWZ3I0WGFsMlVnRXUvLzNP?=
 =?utf-8?B?YWFjNmsrY2U1ZityVW5kdUVOUHk2NmpoZU9STzE0RmRqTXY5TXBWMmtOYXJa?=
 =?utf-8?B?cldOMDhrRGFKUW1BWUdTbElJVzd5M1k1THZrTUJobEI3THlDWU00RnBELy9B?=
 =?utf-8?B?TXhOQzdQWHJQeDhMTCszb1NOQkw4SkJhMFBtL3QwTk5xT1FVaEpVMFlOc0xB?=
 =?utf-8?B?aERYcVhaU3RjM1FIY29kNVdHb2dXV0pOTjFqVWx4S2ZSNlFKSkNVNERuNmxt?=
 =?utf-8?B?cGN0Sk1HT1VBQ0V3TCtXbWtZN2prOVU4Ynh2RFJhTG5PYlJjdUpWdm1ReGhY?=
 =?utf-8?B?ZEwwekcxSWVNY1ZPUGg2L1JueGdsMG1IajcwellDczUvOUtrQy9OaHV4WjlO?=
 =?utf-8?B?MCtFTnpIZXZRWFZ0T1BSR3QrSVdFOGJ4SVp0akRySHVtMmI5MFpTVDJ1S3Bx?=
 =?utf-8?B?REViMTU4ajBVaHQ5dXNZdURYd2pxcUZBanZxMUQxNjlBUUU5cEFyTTZDY3Fu?=
 =?utf-8?B?ZGkxL3JPUDRVcS9sRmhpRW9OU0xTMXpXU3dqYVU2a1hVTXY5OUNHekNuTEx0?=
 =?utf-8?B?TXJIQmt4UHEwY3ZOempHUGRXS2xLVGZuSVNyM2FjaythUGhLTGpWYkV4S2xV?=
 =?utf-8?B?OXBnNkFZdXNYMkdFU3ZvVDFzTmdnTFFhcmI5b3M1WW90WnFZVHl1Wm1BUUpN?=
 =?utf-8?B?dUZoU0tja3U2YSthKzlGWnFCK1RvY1lwTjkwa1preC96bW9TZGVrSlRtaVB1?=
 =?utf-8?B?cUJkMVNWdVd1c3Q4MmdJcVNwZ2RCK0NIRTJDTllkVndLdWFqa3p0U3AxR3dU?=
 =?utf-8?Q?tcKJhJYY3valE7wmFlk5qYpST89ykAmoDljev?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84CC47AB5A5F704AA2B0F6E52ECFEE4E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dPsBG5IL8ChYCcozA4kLVromY+11wPSP/N12poUi9oXp9q5F0EGtCIbJA8h6qWAl+LaIqTh2ZKHg8utQBhRnwNPJouFm27QuKoiqBO0I9/n2wiXC0cxQvUhI+0c/bAi2zcuQt2pE5FoMxdz6hIjy+Z/tBznd/MwOVf4gVAkufg2/TOPAGND13868HZ+YlgrbNvJC5M/8q4IpiMX7QTjhAtZsePnhXW+nvLq6bq+NcEU2fERAT4zBVUMywFtXAGrHbpcySgmhEF+F17rIsFgtjTk6r9FHnefVNkl01YnM3ELb85KYvJYVjJv+g9uII/qDIsjVuW0UAIN2S3tzWj2peQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be069e7-d121-4c4b-a5b8-08dea162cddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 18:04:46.5755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88uaNF9byRAheTyznFekc5NHXVGypdlSJ+QTgR2dq/DTzgVs6KCUsam6YQcl/wbOG/5q6M3Tsu8tVXM/vsXFfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR15MB7132
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 94pFiKRpOPI6_A5xuxth8lK_8KRJA6y2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MyBTYWx0ZWRfX1Q2b+Xbp180Y
 iLdrKnN7iayD4wa3dCjueSuTfxnER0fTsqGizYGL8KVqEo0hVDbhWaDpdZImcrRNet3fX0fQjr1
 o97LmP+VQeIMxHUAfvliURyF6xSJsqJWbF8j38fSDGGmImkA74oIu3lCuSIYD1kDI+VXEZhYFfM
 X3NCBtJAH2NRtkQAst591T3u/5+NXjuTKheH8qlODb4WR4AB15jUtbugCzZfqdR0aqbgCE7Gq76
 t/Olm+hVN7+OEn8zFJuCuCm7Y8fz89uzSZ5hlEVGdtkjXwkfSo7qtwi2VJMLJ4rhlEO18ZmXqFF
 3xuBv9rAXUtg4ET7ci1DfxioIGe88Awaf5hHN6kgV2ixYMvTjqeA5QxBlebwC/RDUa7lEzs8LZD
 te9GPZDy4jNnCSACDrTbrc8X3DJXNiFbMMRYwMrkQOKXhM5YRP19SNezg/0ICV+jMBSg0v0TuTd
 z1v7q7KXoA+4q1rZSXw==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69ea5f41 cx=c_pps
 a=B/siD3iED6DfpLjspPGgKA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uhueTsV9AGpSPXklSBAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: O-BEug3ZBfPmix0mFCJVxJcZN-_bwVqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230173

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDExOjUzICswMjAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IE9uIEZyaSwgQXByIDEwLCAyMDI2IGF0IDEwOjQ24oCvUE0gVmlhY2hlc2xhdiBEdWJleWtvDQo+
IDxTbGF2YS5EdWJleWtvQGlibS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyNi0w
NC0xMCBhdCAyMDo0MCArMDAwMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gT24g
VGh1LCAyMDI2LTA0LTA5IGF0IDE4OjA5ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6
DQo+ID4gPiA+IE9uIFRodSwgMjAyNi0wNC0wOSBhdCAxMDozOSArMDgwMCwgUGVuZ3BlbmcgSG91
IHdyb3RlOg0KPiA+ID4gPiA+IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZSgpIGJhc2U2NC1l
bmNvZGVzIHRoZSBlbmNyeXB0ZWQgc25hcHNob3QNCj4gPiA+ID4gPiBuYW1lIGludG8gdGhlIGNh
bGxlciBidWZmZXIgYW5kIHRoZW4sIGZvciBsb25nIHNuYXBzaG90IG5hbWVzLCBhcHBlbmRzDQo+
ID4gPiA+ID4gXzxpbm8+IHdpdGggc3ByaW50ZihwICsgZWxlbiwgLi4uKS4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBTb21lIGNhbGxlcnMgb25seSBwcm92aWRlIE5BTUVfTUFYIGJ5dGVzLiBGb3Ig
bG9uZyBzbmFwc2hvdCBuYW1lcywgYQ0KPiA+ID4gPiA+IGxhcmdlIGlub2RlIHN1ZmZpeCBjYW4g
cHVzaCB0aGUgZmluYWwgZW5jb2RlZCBuYW1lIHBhc3QgTkFNRV9NQVggZXZlbg0KPiA+ID4gPiA+
IHRob3VnaCB0aGUgZW5jcnlwdGVkIHByZWZpeCBzdGF5ZWQgd2l0aGluIHRoZSBkb2N1bWVudGVk
IDI0MC1ieXRlDQo+ID4gPiA+ID4gYnVkZ2V0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZvcm1h
dCB0aGUgc3VmZml4IGludG8gYSBzbWFsbCBsb2NhbCBidWZmZXIgZmlyc3QgYW5kIHJlamVjdCBu
YW1lcw0KPiA+ID4gPiA+IHdob3NlIHN1ZmZpeCB3b3VsZCBleGNlZWQgdGhlIGNhbGxlcidzIE5B
TUVfTUFYIG91dHB1dCBidWZmZXIuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogUGVuZ3BlbmcgSG91IDxwZW5ncGVuZ0Bpc2Nhcy5hYy5jbj4NCj4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiA+ID4gPiA+IC0gcmVqZWN0IGBlbGVuID4gMjQw
YCBleHBsaWNpdGx5IGluc3RlYWQgb2YgcmVseWluZyBvbmx5IG9uIHRoZSBlYXJsaWVyDQo+ID4g
PiA+ID4gICBgV0FSTl9PTigpYA0KPiA+ID4gPiA+IC0gcmV3cml0ZSB0aGUgTkFNRV9NQVggYm91
bmQgY2hlY2sgaW4gdGVybXMgb2YgdGhlIGZpbmFsIHRvdGFsIGxlbmd0aA0KPiA+ID4gPiA+ICAg
aW5zdGVhZCBvZiBgTkFNRV9NQVggLSBwcmVmaXhfbGVuIC0gZWxlbmANCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiAgZnMvY2VwaC9jcnlwdG8uYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0NCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvY3J5
cHRvLmMgYi9mcy9jZXBoL2NyeXB0by5jDQo+ID4gPiA+ID4gaW5kZXggZjNkZTQzY2NiNDcwLi40
MmUzZmZmMzQ2OTcgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZnMvY2VwaC9jcnlwdG8uYw0KPiA+
ID4gPiA+ICsrKyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gPiA+ID4gPiBAQCAtMTUsNiArMTUsMTIg
QEANCj4gPiA+ID4gPiAgI2luY2x1ZGUgIm1kc19jbGllbnQuaCINCj4gPiA+ID4gPiAgI2luY2x1
ZGUgImNyeXB0by5oIg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICsvKg0KPiA+ID4gPiA+ICsgKiBS
ZXNlcnZlIHJvb20gZm9yICdfJyArIGRlY2ltYWwgNjQtYml0IGlub2RlIG51bWJlciArIHRyYWls
aW5nIE5VTC4NCj4gPiA+ID4gPiArICogY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKCkgY29w
aWVzIG9ubHkgdGhlIHZpc2libGUgc3VmZml4IGJ5dGVzLg0KPiA+ID4gPiA+ICsgKi8NCj4gPiA+
ID4gPiArI2RlZmluZSBDRVBIX0VOQ1JZUFRFRF9TTkFQX0lOT19TVUZGSVhfTUFYICAgICAgIHNp
emVvZigiXzE4NDQ2NzQ0MDczNzA5NTUxNjE1IikNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gIHN0
YXRpYyBpbnQgY2VwaF9jcnlwdF9nZXRfY29udGV4dChzdHJ1Y3QgaW5vZGUgKmlub2RlLCB2b2lk
ICpjdHgsIHNpemVfdCBsZW4pDQo+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiAgIHN0cnVjdCBjZXBo
X2lub2RlX2luZm8gKmNpID0gY2VwaF9pbm9kZShpbm9kZSk7DQo+ID4gPiA+ID4gQEAgLTIwOSw2
ICsyMTUsNyBAQCBpbnQgY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAq
cGFyZW50LCBjaGFyICpidWYsIGludCBlbGVuKQ0KPiA+ID4gPiA+ICAgc3RydWN0IGlub2RlICpk
aXIgPSBwYXJlbnQ7DQo+ID4gPiA+ID4gICBjaGFyICpwID0gYnVmOw0KPiA+ID4gPiA+ICAgdTMy
IGxlbjsNCj4gPiA+ID4gPiArIGludCBwcmVmaXhfbGVuID0gMDsNCj4gPiA+ID4gPiAgIGludCBu
YW1lX2xlbiA9IGVsZW47DQo+ID4gPiA+ID4gICBpbnQgcmV0Ow0KPiA+ID4gPiA+ICAgdTggKmNy
eXB0YnVmID0gTlVMTDsNCj4gPiA+ID4gPiBAQCAtMjE5LDYgKzIyNiw3IEBAIGludCBjZXBoX2Vu
Y29kZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0IGlub2RlICpwYXJlbnQsIGNoYXIgKmJ1ZiwgaW50
IGVsZW4pDQo+ID4gPiA+ID4gICAgICAgICAgIGlmIChJU19FUlIoZGlyKSkNCj4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihkaXIpOw0KPiA+ID4gPiA+ICAgICAgICAg
ICBwKys7IC8qIHNraXAgaW5pdGlhbCAnXycgKi8NCj4gPiA+ID4gPiArICAgICAgICAgcHJlZml4
X2xlbiA9IDE7DQo+ID4gPiA+ID4gICB9DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICBpZiAoIWZz
Y3J5cHRfaGFzX2VuY3J5cHRpb25fa2V5KGRpcikpDQo+ID4gPiA+ID4gQEAgLTI3MSw4ICsyNzks
MjcgQEAgaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZShzdHJ1Y3QgaW5vZGUgKnBhcmVu
dCwgY2hhciAqYnVmLCBpbnQgZWxlbikNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgIC8qIFRvIHVu
ZGVyc3RhbmQgdGhlIDI0MCBsaW1pdCwgc2VlIENFUEhfTk9IQVNIX05BTUVfTUFYIGNvbW1lbnRz
ICovDQo+ID4gPiA+ID4gICBXQVJOX09OKGVsZW4gPiAyNDApOw0KPiA+ID4gPiA+IC0gaWYgKGRp
ciAhPSBwYXJlbnQpIC8vIGxlYWRpbmcgXyBpcyBhbHJlYWR5IHRoZXJlOyBhcHBlbmQgXzxpbnVt
Pg0KPiA+ID4gPiA+IC0gICAgICAgICBlbGVuICs9IDEgKyBzcHJpbnRmKHAgKyBlbGVuLCAiXyVs
ZCIsIGRpci0+aV9pbm8pOw0KPiA+ID4gPiA+ICsgaWYgKGVsZW4gPiAyNDApIHsNCj4gPiA+ID4g
PiArICAgICAgICAgZWxlbiA9IC1FTkFNRVRPT0xPTkc7DQo+ID4gPiA+ID4gKyAgICAgICAgIGdv
dG8gb3V0Ow0KPiA+ID4gPiA+ICsgfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArIGlmIChkaXIg
IT0gcGFyZW50KSB7DQo+ID4gPiA+ID4gKyAgICAgICAgIGludCB0b3RhbF9sZW47DQo+ID4gPiA+
ID4gKyAgICAgICAgIC8qIGxlYWRpbmcgJ18nIGlzIGFscmVhZHkgdGhlcmU7IGFwcGVuZCBfPGlu
dW0+ICovDQo+ID4gPiA+ID4gKyAgICAgICAgIGNoYXIgc3VmZml4W0NFUEhfRU5DUllQVEVEX1NO
QVBfSU5PX1NVRkZJWF9NQVhdOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgICAgcmV0
ID0gc25wcmludGYoc3VmZml4LCBzaXplb2Yoc3VmZml4KSwgIl8lbHUiLCBkaXItPmlfaW5vKTsN
Cj4gPiA+ID4gPiArICAgICAgICAgdG90YWxfbGVuID0gcHJlZml4X2xlbiArIGVsZW4gKyByZXQ7
DQo+ID4gPiA+ID4gKyAgICAgICAgIGlmICh0b3RhbF9sZW4gPiBOQU1FX01BWCkgew0KPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICAgIGVsZW4gPSAtRU5BTUVUT09MT05HOw0KPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ID4gPiA+ICsgICAgICAgICB9DQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgICBtZW1jcHkocCArIGVsZW4sIHN1ZmZpeCwgcmV0KTsN
Cj4gPiA+ID4gPiArICAgICAgICAgLyogSW5jbHVkZSB0aGUgbGVhZGluZyAnXycgc2tpcHBlZCBi
eSBwLiAqLw0KPiA+ID4gPiA+ICsgICAgICAgICBlbGVuID0gdG90YWxfbGVuOw0KPiA+ID4gPiA+
ICsgfQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICBvdXQ6DQo+ID4gPiA+ID4gICBrZnJlZShjcnlw
dGJ1Zik7DQo+ID4gPiA+IA0KPiA+ID4gPiBMb29rcyBnb29kLg0KPiA+ID4gPiANCj4gPiA+ID4g
UmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0K
PiA+ID4gPiANCj4gPiA+ID4gTGV0IG1lIHJ1biB4ZnN0ZXN0cyBmb3IgdGhlIHBhdGNoIHRvIGRv
dWJsZSBjaGVjayB0aGF0IGV2ZXJ5dGhpbmcgaXMgT0suIEknbGwNCj4gPiA+ID4gc2hhcmUgdGhl
IHJlc3VsdCBBU0FQLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhlIHhmc3Rlc3RzIHJ1biB3
YXMgc3VjY2Vzc2Z1bC4gSSBkb24ndCBzZWUgYW55IGlzc3VlcyB3aXRoIHRoZSBwYXRjaC4NCj4g
PiA+IA0KPiA+ID4gVGVzdGVkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29A
aWJtLmNvbT4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gQXBwbGllZCBvbiB0ZXN0aW5nIGJy
YW5jaCBvZiBDZXBoRlMga2VybmVsIGNsaWVudCBnaXQgdHJlZS4NCj4gDQo+IEhpIFBlbmdwZW5n
LCBTbGF2YSwNCj4gDQo+IFRoaXMgcGF0Y2ggcmFpc2VkIG15IGF0dGVudGlvbiBiZWNhdXNlIG15
IHVuZGVyc3RhbmRpbmcgd2FzIHRoYXQgdGhlDQo+IGVudGlyZSBDRVBIX05PSEFTSF9OQU1FX01B
WCArIHNoYTI1NigpIHdhcyBwdXQgaW4gcGxhY2UgcHJlY2lzZWx5IHRvDQo+IGhhbmRsZSBsb25n
ZXIgbmFtZXMgbmljZWx5IGFuZCBtYWtlIHRoZW0gZml0IGludG8gTkFNRV9NQVgtc2l6ZWQgYnVm
ZmVyLg0KPiBTaW1wbHkgcmVqZWN0aW5nIGxvbmdlciBuYW1lcyBzZWVtZWQgdG8gYmUgaW4gZGly
ZWN0IGNvbnRyYWRpY3Rpb24gd2l0aA0KPiB0aGF0IGFuZCB5ZXQgdGhlIHBhdGNoIG9uIGl0cyBv
d24gd2FzIGNsZWFybHkgbWVyaXRlZCBnaXZlbg0KPiANCj4gICogKDI0MCBieXRlcyBpcyB0aGUg
bWF4aW11bSBzaXplIGFsbG93ZWQgZm9yIHNuYXBzaG90IG5hbWVzIHRvIHRha2UgaW50bw0KPiAg
KiAgYWNjb3VudCB0aGUgZm9ybWF0OiAnXzxTTkFQU0hPVC1OQU1FPl88SU5PREUtTlVNQkVSPicu
KQ0KPiANCj4gY29tbWVudCBvbiBDRVBIX05PSEFTSF9OQU1FX01BWCBkZWZpbml0aW9uLg0KPiAN
Cj4gSSBkdWcgYSBiaXQgZGVlcGVyIGFuZCBzdGFydGVkIGEgZGlzY3Vzc2lvbiBpbiBbMV0uICBU
aGUgcHJlbGltaW5hcnkNCj4gY29uY2x1c2lvbiBpcyB0aGF0IHRoZSAyNDAgYnl0ZXMgYXNzdW1w
dGlvbiB3YXMgYSBtaXN0YWtlIC0tIHNvbWVob3cNCj4gdGhlIG1pbmltdW0gbnVtYmVyIG9mIGNo
YXJhY3RlcnMgbmVlZGVkIGZvciA8aW51bT4gZW5kZWQgdXAgYmVpbmcgdXNlZA0KPiBpbnN0ZWFk
IG9mIHRoZSBtYXhpbXVtLiAgQ0VQSF9OT0hBU0hfTkFNRV9NQVggdmFsdWUgaXMgbGlrZWx5IGlu
Y29ycmVjdA0KPiBhbmQgc2hvdWxkIGhhdmUgYmVlbiBzbWFsbGVyIC0tIHNvbWV0aGluZyBhbG9u
ZyB0aGUgbGluZXMgb2YgMTc0IC0NCj4gU0hBMjU2X0RJR0VTVF9TSVpFIGluc3RlYWQgb2YgMTgw
IC0gU0hBMjU2X0RJR0VTVF9TSVpFLg0KPiANCg0KVGhlIGxpbWl0YXRpb24gY291bGQgYmUgMjQw
IG9yIGJpZ2dlciBvbmUsIGJ1dCBhbnl3YXkgd2UgbmVlZCB0byBwcm9jZXNzIHRoaXMNCmxpbWl0
YXRpb24gaW4gcHJvcGVyIHdheS4gQW5kIHRoaXMgcGF0Y2ggaGFzIGV4YWN0bHkgdGhpcyBnb2Fs
LiBJcyAyNDAgYnl0ZXMNCmxpbWl0YXRpb24geW91ciBjb25jZXJuPyBBcyBmYXIgYXMgSSBjYW4g
c2VlLCB0aGlzIHBhdGNoIGRvZXNuJ3QgaW50cm9kdWNlIHRoaXMNCmxpbWl0YXRpb24uIEl0IHdh
cyB0aGVyZSBiZWZvcmUgdGhpcyBtb2RpZmljYXRpb24uIFdlIGNhbiBleHRlbmQgdGhpcyBsaW1p
dGF0aW9uDQphbnl0aW1lLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K
