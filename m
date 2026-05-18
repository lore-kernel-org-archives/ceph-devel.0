Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05152D838E
	for <ceph-devel@vger.kernel.org>; Mon, 18 May 2026 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129504; cv=fail; b=e0ihqBz//51PoKVubuX61c9blYq4CoVsRSYSMhjq7xcBYBv4dK817uHMLXDdzBW978kiYT0IFY+cvN7RGJe8qKb0VL5uLAoF4195cXgi0whUZw+8CpdqKIv1JAxKsl/V8wGxbUGmIqU3v2U0yNjYDHT/BnvNTldjExgAx8zCd2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129504; c=relaxed/simple;
	bh=8f4aT/Fhjnbj/u3V2cgJ2v3lReCIQsaLVVRW5HWPcKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COty3oIxTIHY/FegwfRlxiOQJl3P1pLaxqrrpfstw5fga1BAAXQM0Hn0rJLIj1oSWaGZPoDHqkUw1bt1z0Fi8lIo0VCr6mkZMQym1pmLZwgdaNz+NS3tgWy6JoUZeEmPAQyRI1G6HvTCBcTghqKKU8LL9UwC2nXZlsge7nT5AOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AefcePm9; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AefcePm9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IHlucN072884;
	Mon, 18 May 2026 18:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=8f4aT/Fhjnbj/u3V2cgJ2v3lReCIQsaLVVRW5HWPcKU=; b=AefcePm9
	exUjHcr1pp3+xwvTMTTTNvS3ZQCym/J1/obEvOxBmOSisvjp9fSyImNerKyJmOyg
	buw3Ozm7zvLVtBJFnlts+NHpbpP8g0Zwtug6/3AQu9W1O1mm+8Wi80xIY/pmXysA
	HTJisKDYCVndsiN44He5TaWFVvMur1ztS0Zkq/OLOqrIKR8ZHE43hFPvQDoiuWWX
	rkkaPYA5Zr56x2f2Uw7mELULvqRi1usRG7FDQOyEAbn4XsmZo3uvFiXEeVk3Pwrw
	FDZLcYhy6mhttTh0QyGw9moMt08G/MWOB2btJlFJfFBCXsvZfnI/hvL3iz7JbW72
	j2xvAp/ofo7Gvw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mhgwb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 18:38:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVexy1quilqhXWzgpCzktcsrrP8ZuEgEeDzyusgKVCLIM784KdVAy17x6wy/pjaVkcDd/tjIvlPfyp9Ih3hV5t9+9o4v+Hk8cA0hPGSO7QeSzbUYJXLmhwMRVZjWfAWrluyenvp/ptWToQuBmwAP/6Wt1wwaygv4wJnQTw6TDKAO9kSeJaiOFuppAI1qe4a3XxOguYYYvmPN+c26cHg58edH4YCKxOw/i2X8X/czI/kRU0NiFif0/GXW2eXWU4fmvxipulr9UBLnIrE8YXxICQGW2fCF9AX3v5TZacMLvrtzjBlIbT5cQyXXFMzz2rUNtG6aHy0o5+T6Dj208ysQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f4aT/Fhjnbj/u3V2cgJ2v3lReCIQsaLVVRW5HWPcKU=;
 b=a83XDIK4ODuvXpPfiAWhJWoNuDDd0M6ESIzAB9AAyKW1VlRqQo7gaQ2GxjzFcOcR1UMKknz6E6jXwWUl8Q/wFTn2zArsp60XjYr1/QkUwC2uYf66c/xq3FyiURk0I5GXSjajgeYo5L7f81F9XaKOVLPZSgeUTVhOzWgcHWs0RYLaD4+9gG9Wug0ubQ4AVuNpzON6v1lJgKkZD0vUiJ8B/nGAvz9Y/Loh4bWb0a33dt7ivPmlFTmMnmlldJzy4ReVKWolKZQr0gLoK+uP1uJK1R2Pf/sDCTS5N39AXeRGO/cFodX76R7FIWWETq2ipshdI1YIovivn4FWDZKQoEz0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA0PR15MB3886.namprd15.prod.outlook.com (2603:10b6:806:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:38:04 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 18:38:04 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v2] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
Thread-Topic: [PATCH v2] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
Thread-Index: AQHc5vV2GojSYIS410u7Iaa2A49Q6Q==
Date: Mon, 18 May 2026 18:38:04 +0000
Message-ID: <59bb89377b9f4cb6d532b576e9e8fae5b88e926c.camel@ibm.com>
References: <20260515081132.1570541-1-raphael.zimmer@tu-ilmenau.de>
	 <9011b6c7ed764ef48b4bf7a10d16957e8135e18a.camel@ibm.com>
	 <94daa02f-2f37-4462-94f1-518da132e063@tu-ilmenau.de>
In-Reply-To: <94daa02f-2f37-4462-94f1-518da132e063@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA0PR15MB3886:EE_
x-ms-office365-filtering-correlation-id: bf167aeb-07cc-451e-9e53-08deb50c98e4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021|56012099003|22082099003|18002099003|4143699003|11063799003;
x-microsoft-antispam-message-info:
 S9MsLKJDZXupjAWxWhb2qoPbA+Ep8CIw9bfVFzLs1kr8ZmoK4Jj2BHyQkexnBghD+sFmhUyqZA2Q5qoFH9azT/Wnfa5KjP2bZRllfsN33Z427ripNHA0J4pVNiETFjPGSg1xjaau5juqAD6KHumYr8uqmbs7IwsIk40Xw4pkqv/HXIaJRDx8O+qZxoxXL89NkjRhGSdMeJhCS8MHDffMs8vm14dpEn1rN7mcqFtztr4HgYn1J0D8wqvXF955XSx0Nujg2Ne9zJFYNI4oUqvOHLRpNsWrqTLW49KY7lKkXmJ7qwSXIsI7SnZobCnQSd28vWeb1AQDuGzfKefGudemsCmnCOLifHT+I9lEZ5WLj6jE6ON/zi235jhns8Yv/p2zTOdhWbtvqX/4dewkk6FUtdb8VhYJOE7Bq61vIQBg/EB1wSvNeKCur4BjdRqrm4TZUUQw6wgL+/0sS8COXPq7Av5QnWJ25UuLcZd1dG495rn4HpcwvUPELQhG2gangZclYv+YVq0e8W1MqoHYWhQB0gnta4/k9XMUr1n9GEQEXh/HKx/Iwx73TzZ7ZdadPbpr8P4fIXZDdMMZ4k28WQ5VVMQTvfkivjfAvrbBgn8cEFO3idtuR7Ops/u9ovoI+Bq/52VRHmn3gPPwMnaFaVkI2MhrvahcEOgAOp0uqgNFccXc5x3BMXkMJnE9rtXG+yPYFm45Vm82MZ64rxaYrT5kY6GKQWbRYKfVPbpXzv77JezAhg+YIKq0yk+rx/wyLYFD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHo5WXpiMzU1OVVuTDNnOGo2cWhqUERjbUlZQkR4QUhlUGUzUmRmclFpQkFX?=
 =?utf-8?B?cUtNMW9IdHlKK1BvUnZ4REdabis2bkRjU2N2Z2IzQnhCVXhiV2E4SlEvWkVW?=
 =?utf-8?B?eHVBSDI3amt6ZFJEZHErUDkweGV2QVdhMW1YZmtIbyswdytUOVJETW9FVCt1?=
 =?utf-8?B?azVRSCtRVjU0aVM1OEN6Nk5RUTBuSERKcktIOW1jd01SVzExR2cyQmd3YmRr?=
 =?utf-8?B?dTNxTzRiakNiYmwyM1FxaFh4MVpvSmF1VHBQWWszN3Z6RFlkNnZ6OUJvakRN?=
 =?utf-8?B?SXROK1dwS1hsR0M5OXRWTm9vOEMyN0xQc0taRUs1U2RudURpRzRBWmVDdlZx?=
 =?utf-8?B?RWxzNjkyQUZLMDdLTnViOENuaUg3cGhOajcxUXpEaHdibW4xWDZEbVl0czJ2?=
 =?utf-8?B?UkxtTERjOURPL00wRHhBUE1tN3pBTFJOYUgrOGQwRkkvVXJxdVF3ZDlnVlhB?=
 =?utf-8?B?LzdEdlc2OWo3YWY1RSt2MmpyNUJ3LytMQzhRZGEzVlgzK1V2VXV5TW93dW9m?=
 =?utf-8?B?ekdDYm05TW5rSkJQQ0dMVEZma0lzUlRmQVNGSGtpcnJ6YW92NWQvQmM1cVJI?=
 =?utf-8?B?YVFJVk5IeUJSbTFSZTFSZURwajRjbXFzc21CeTVOaUYrZHVaVTNnTW81L3NV?=
 =?utf-8?B?R3krTHlIWjNycEYxZ0EzVVpoNlVSamFYdy9QbFNxUnZhQ0tMUlJPeXI0UDhL?=
 =?utf-8?B?eGNkSTQzVDBzM2NhT0d6SFVGV0JWOURMN0w3VlJvRzJhY1kzeFljQXVSWEQ4?=
 =?utf-8?B?UE9CcExiM2d5Vm85TzhvQVFvL3h0YzIxZm9zMS9aZUtGcFdQeGxDcEJWbE5U?=
 =?utf-8?B?M0l2aHBYTUxHZUtMZDQrMVYxcFBrY1JONjJpNlpuVFRxbHVRbzk1bDFaSXgv?=
 =?utf-8?B?ZEZRKzVWZWE3TlhLcXdBalVjLzdnaUtWbzlYdmlQbURuRGJHZXF3TDhsbkRh?=
 =?utf-8?B?ejlUamNNZk1iZEVLc3hhQ3Q5TGg4UmdIUTcrZldSVVVUdDFEOU8vWko4QWtl?=
 =?utf-8?B?NjlJUU9SYS9uR1k5YTJudjVtTHRWWllhK3piRFQ5ZWIvTzFucU1TRFFtN09P?=
 =?utf-8?B?bFR4aDkzSFJTdGVxaGorMWpYbkZzblNQbEVrQTZsL1VVWHBnczFlNmJielJx?=
 =?utf-8?B?ZjdrUy9xWEVMYWVEMjhZRE90TTI3OUxxbExtNUN5VWRzbGY1SVhqSTBjaTk4?=
 =?utf-8?B?dUNrRktGNmEzV3llRXBOUnc1MEE3SUUrZFBGOVpkaTBVME4ycFgrMnhLSVdW?=
 =?utf-8?B?c29CUFlYa3haMTF6MDJtcmg0NlZqQ1hOSHh3dmZRQWN6TlRGU0l0V2x0MU9w?=
 =?utf-8?B?RzdFS3BuVmlJR1Z4UVR3SnJFNHRFTTh6THFvRXFnNUs3K1poV0Jvd3dyQW9o?=
 =?utf-8?B?c2pMNnRCMkxvN3NmbkhwcC9xUS9HV1kweE0wMDFwaVp0ejVEUkIrNWtTMGNY?=
 =?utf-8?B?azI0bzR6aTZMb2orN3M0eVJFNFZkdStreE5jYVJyRlh1ZTFtNG9NbW1hdXJG?=
 =?utf-8?B?eEM5N1dyRVdNR0pKbGVQekdPZFNxZ0ZBRm1kSi9MbXhIWFJVdUZmTVF0azlE?=
 =?utf-8?B?U0lOcXpLbUVOYmp2SVd0cG9lRGlYc2YzMXh1UHFXc0tNU0VqRlprWGZFaWoz?=
 =?utf-8?B?ajBycUZuckJORTJ1TVV4MmVmN0hOdUtBYnJYRW1oNWNVQWJtbmdkZXhMUHZX?=
 =?utf-8?B?cTZaa200UmlGNmRCWVB3ZytZYW9TR2JlZ3BXK2V6K2lhQkd2U0NJRmdINXI3?=
 =?utf-8?B?bnczOHNIQXd0bEFZdnYyRlN5TUk0SkFHZmRnZ3hKT3ZOMmp6NmhrSWRLREpS?=
 =?utf-8?B?U2dZTUQxdjUrV0dySEg4VC9EWWRlUVo5TWl6Uko0eXoySFVKc091Ym5oN0cr?=
 =?utf-8?B?V2twRjdnYjc1V3lvYThlTm9QN21uR3NPdGJsRmdvdHlqT3lOOTBDTDZzaWNs?=
 =?utf-8?B?bGtwaTMwL291Y0xpc2FOMWcybDFvdXNpUlJNd0pHUVN0VXlHZXAyK2Nab2Ir?=
 =?utf-8?B?U3A2R3gyUTcyTFBxNEtxRjl1ZW1SMFVCRmpETUN0UkZ6T2RweGhCcjBPWG45?=
 =?utf-8?B?ckFyZ1FrZWhjbUhqdjVxMy9yclNhVWpqMmVxSDZoY1V4a0d1bDQvb3ZybDlJ?=
 =?utf-8?B?NWJyZGVHaGxCNDYxeWFZWUFHcElBZ2c2anVaTmx5ZmFmb09iUDVQZjE0QTJQ?=
 =?utf-8?B?cGMvYXF0Yk5wcGg0TVpac2laY2RJTjdhZDlKYUlnTmNNZVF1UjR3bitWU3lZ?=
 =?utf-8?B?ODVWL01NbzZmK2p5SGVVMXI2cTFBU1Uwb3cxYTF3cFVTVGlWNUpKZGZZRlg1?=
 =?utf-8?B?dkw0MzNJRVdNRURIWU53MVFzTFpBOEtEK2RnZWZXaFR1U2IxYWZxZHBHQUZ3?=
 =?utf-8?Q?1JlA09oE2zF/+lfFF+iw1G4Xf4A2nlV67RVzq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35F3C25BFC71974E9B626A48D8BAA3C0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IGD1rMuZp/fxUwVY/qAphYW36ZT/7EOPPgi3Y6+rxR+nHw2ae4zYkOeW7Vxo1J6bcUHsJLplh/DL5gORIkcfEUdJw4xCvtDGC2jg7cP98q7x57A9sfH/Pg3pQr++whEelV1qPuhfV3e/6Gs3w/L5OGlK9Lq/sRGXHBYyQDR88O/9lx2mV7CZoajSrSO+dQmav7/vycPjskFc4hn5VK6pkv8QBBTz6Y1HpYbu3RTqzoQdxm5BxYIHeMLA1Dsxp3fkjRj0s8Y/gmU9sNdwYDBni8Gj2fSyWK6QGnAr+6mW46231MReaZYw0lPVZ16du0LbLv4NZJtW1bbXjmQMwP8g9w==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf167aeb-07cc-451e-9e53-08deb50c98e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 18:38:04.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WB/vVx5hVGTjpSc2Bib84p0wF6MH1hYkeKlvTsFXrCkt37ZEpu0N34Xwcg0UW8O1LA5r0lUZIl64C/38lSp3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3886
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5whC9g5jIaQ5ZP4PiaXn3A1Eb1a3loS4
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0b5c91 cx=c_pps
 a=Za6wG3+qag5e9bFCWm8neg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=YWGksQbDYPSk2q7LLpMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gKmQZ-G2p0tEwFEFSK5pbNdh0VC-fYgI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4NCBTYWx0ZWRfX5ws4CeCPR8o4
 UpTLwTb3ZUhXK2rTlfhsMLLSia6+YlqXhxLfzdAh8iKeVv5St18LvqP/4J+CQqQXcGXNok6w3fj
 qd5h+1aBSouCwoKhoWoDFuA+ZN2QmL3klDi53/PXy89hucPpkt4fDwSYihg1btHIaQ6ROFBAema
 YbGApTaZ7j04rQUud3QD0YT/fQCiOSlP3/ESL+04gV/LE7vMxObKZkUXOm6i/t+NH8UL02xRVFr
 Frv3RhV1LfX3X5emqOA85icqizg4ylEldyoqNkp0R8BvHl5nvJJZLZthST3USvuT9/2XuUerlC1
 5RiJ6jO2S6x/SrChz29l72AIMJC3yit3sJq0rmaM7veE4IdVtREq3OWmkUDw3/ky0PrxpUqnTxq
 9tz/Gv3gSyvfWkh3aNVlKl3STJLwPq3/uQsX+ZhplYfHYmsS+3CFgCGYqxUjnWjX8OqQKOCawXa
 BnMWrSqe8GcsWmui8hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180184

T24gU2F0LCAyMDI2LTA1LTE2IGF0IDEwOjQ2ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gNS8xNS8yNiA5OjA1IFBNLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gT24g
RnJpLCAyMDI2LTA1LTE1IGF0IDEwOjExICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToNCj4g
PiA+IEEgbWVzc2FnZSBvZiB0eXBlIENFUEhfTVNHX09TRF9NQVAgaG9sZHMgYW4gT1NEIG1hcCwg
d2hpY2ggdHlwaWNhbGx5DQo+ID4gPiBjb250YWlucyBhIHBnX3VwbWFwIHBhcnQgYXQgaXRzIGVu
ZC4gV2hlbiBkZWNvZGluZyB0aGlzIHBhcnQgaW4NCj4gPiA+IF9fZGVjb2RlX3BnX3VwbWFwX2l0
ZW1zKCksIGEgbGVuIHZhbHVlIGlzIGRlY29kZWQgZnJvbSB0aGUgbWVzc2FnZSB0bw0KPiA+ID4g
ZGV0ZXJtaW5lIHRoZSBudW1iZXIgb2YgaXRlbXMgYW5kIHRoZSBzaXplIG9mIHRoZSBhbGxvY2F0
aW9uIG5lZWRlZCBmb3INCj4gPiA+IHRoZW0uIElmIHRoZSBsZW4gdmFsdWUgaXMgZ3JlYXRlciB0
aGFuIG9yIGVxdWFsIHRvIDJeMzEsIGFuIG92ZXJmbG93DQo+ID4gDQo+ID4gVGhpcyBwaHJhc2Ug
c3RpbGwgc291bmRzIGNvbmZ1c2luZy4gOikgQmVjYXVzZSBsZW4gaXMgdTMyLg0KPiANCj4gTGV0
J3MgbWVyZ2UgdGhlIGRpc2N1c3Npb24gb2YgYm90aCBlbWFpbCB0aHJlYWRzIGhlcmUuDQo+IA0K
PiBJIGRvbid0IG1lYW4gdGhlIGNhbGN1bGF0aW9uIG9mICIyICogbGVuICogc2l6ZW9mKHUzMiki
LiBJJ20gDQo+IHNwZWNpZmljYWxseSB0YWxraW5nIGFib3V0IHRoZSB2YXJpYWJsZSAibGVuIiwg
YXMgc3RhdGVkIGluIHRoZSBjb21taXQgDQo+IG1lc3NhZ2UuIFRoZSBwcm9ibGVtIGFyaXNlcyB3
aGVuIGxlbiA+PSAyXjMxLiBsZW4gaXMgb2YgdHlwZSB1MzIuIFRoYXQgDQo+IG1lYW5zLCBpdCBj
YW4gaG9sZCB2YWx1ZXMgZnJvbSAwIHRvIDJeMzItMS4gMiAqIGxlbiBjYW4gbGVhZCB0byBhIA0K
PiBtdWx0aXBsaWNhdGlvbiBvdmVyZmxvdyB3aGVuIGxlbiA+PSAyXjMxLCBiZWNhdXNlIDIgKiAy
XjMxID0gMl4zMiAtPiAwIA0KPiB3aGVuIGNhbGN1bGF0ZWQgaW4gdTMyLiBCZWNhdXNlIG9mIHRo
ZSBsZWZ0LXRvLXJpZ2h0IG9yZGVyIG9mIA0KPiBldmFsdWF0aW9uLCB0aGlzIGlzIGNhbGN1bGF0
ZWQgZmlyc3QgYW5kIGluIHRoZSBuZXh0IHN0ZXAgMCAqIA0KPiBzaXplb2YodTMyKS4gVGhlIGZp
cnN0IHN0ZXAgd2lsbCBiZSBjYWxjdWxhdGVkIGluIDMyIGJpdCwgYW5kIG9ubHkgdGhlIA0KPiBz
ZWNvbmQgb25lIGluIHRoZSB3aWR0aCBvZiBhIHNpemVfdCBvbiB0aGUgcmVzcGVjdGl2ZSBzeXN0
ZW0uIEFzIEkgDQo+IG1lbnRpb25lZCBpbiB0aGUgcmVwb3J0LCB0aGVyZSBhcmUgc2V2ZXJhbCB3
YXlzIHRvIGFkZHJlc3MgdGhpcyBpc3N1ZS4NCg0KT0suIFlvdSBzdGF0ZW1lbnQgaXMgIklmIHRo
ZSBsZW4gdmFsdWUgaXMgZ3JlYXRlciB0aGFuIG9yIGVxdWFsIHRvIDJeMzEiLiBXZQ0KaGF2ZSBs
ZW4gZGVjbGFyZWQgYXMgdTMyLiBUaGUgdTMyIHR5cGUgdmFyaWFibGUgY2FuIGhvbGQgdmFsdWUg
bm90IGJpZ2dlciB0aGFuDQpVMzJfTUFYICgweEZGRkZGRkZGLCA0LDI5NCw5NjcsMjk1LCBvciAy
XjMxLTEpLiBUaGUgbGVuIHZhbHVlIGNhbm5vdCBiZSBiaWdnZXINCnRoYW4gMl4zMS0xIGluIGFu
eSB3YXkuDQoNClRoYW5rcywNClNsYXZhLg0KDQo=
