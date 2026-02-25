Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084F2D7DEE
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049442; cv=fail; b=j3EycZsJmH5PrTshWrOjhJVnFJ596ri3vD2AqdDq9emDnzb0FflcWpg+7D5fkgKzRBgE0wOQ929IbVmCdWxWrDZXg9Y2GsSpJ31jJC5w1Fqa8RYkJgvyMUhy2Y2wdsoBEFQuN36upjv560HM3pHchHsCLkFEWtjpeFUhfjrLpP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049442; c=relaxed/simple;
	bh=ThLcNfSZBSd/apkqUH44iS1yVvf8pTwiCf3sAE8Cqhg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=fzFbyxLZFVSkBMdzBmJTpJXz0XpoUGcpE/t76ILY+uZrscDMdoIpUtfEd4hpGa/Eto58HyBh9+ougLe9nmiFxFOufU1FIgaUEd6WzezVJc1DM8+Mz8MHtpIOittA+ga8I0wBxJcc8WnBXZkc7NwNgo7zaNH3NF0/dDiCX7PVrNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H/k3NnQE; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H/k3NnQE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PBvPjq2817486;
	Wed, 25 Feb 2026 19:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ThLcNfSZBSd/apkqUH44iS1yVvf8pTwiCf3sAE8Cqhg=; b=H/k3NnQE
	MS48y4QIB4NZmMrXl9mbfbfSniOsADxrs5TUxV7D0NBtqlHawzFqIKlHs0fUZhMM
	fuZ0MMCG1AuLTCEuJyvhBhKMx/SlwPgaNzAxD06nztmKonwFpO7/Y07Xm7oX8Qjf
	0PPTovJPOXHj4dNGT0x/kf8WROZdZLMmVR+eKs6oJYsU9pQpaI5urL5/hmsiO42b
	VCuRLM5ipoRMNYLt3iVw6T31FD264hFIUhNKOVqj6NU0Fm2IIppGsCewaLkGT/bH
	jmWrmY1E9Q3oxDK+nEhnaARBKrm/o7eDnJeJgU6Lf3jU1wJ7b713J3iKEZX9GBaV
	7L3IjsdAd4JmlA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24ghptx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 19:57:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLOwrqVRD8l5k0RZu3yIigEc+0wnP3N5cxss0UWYCsYaFS3r01NsGx1xSU18u+SFNgTJ702wyOs27y9RcK/TxAsmRYZGUr7S92QrOWrTnOL8+yfCJ2P1g2ltZfn67fnd4oeLO+afYanKkiZ3qffy2qL/5BGq1iL8BOP6E5UPqzjVi8dZxjR2sHjVI3xvxDin+TGvCTGePeum8xsN/yB6yLig6ON/Bz38uG3/BuW/7CE5ZXdVTUWXTWOBfS7Nnbg4kBB8DNjdj+2ETpSLIcpwOxJjKznrK4xXv7AZZy/8npd7LHxNykMGPUXIg/28xrfDp+A/6+DMbEdPNEDSAfxKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThLcNfSZBSd/apkqUH44iS1yVvf8pTwiCf3sAE8Cqhg=;
 b=gZcjQ/fxxXEMQgvIXyzdCBGx8xC0gJz13Ha57S/56C4Z+0/axHHch/ktZOVPS3RXuArtY1ljY47rMuNFD43fdmO8o13jFv/BT4W8pUg54+CVbLCwEhucDkmn78z3oRgXlwwKIH8lfiuHYvr8JXwjR0812MoxOSqIREJzdRrWZTCzKANGap2EPQyC8Oi+Upp/Abfb1bsCXHMS+Q1da5NhHbHxlPIsQ+bqcCJ10mqAQ2jFcbfzVMaY5VZDsSAzk/J2QmAWeKi4EgQN9IlundGlwM/K31ucuHKnddddR0rPcbDuibFeFMW6JNJkW0NA5IJfwKgEJ/hT4+ibWXqICPajeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB4922.namprd15.prod.outlook.com (2603:10b6:303:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 19:56:57 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 19:56:57 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH v2] libceph: Use u32 for non-negative
 values in ceph_monmap_decode()
Thread-Index: AQHcppDlT5zUbzypmkKpoJ2lD2dCQg==
Date: Wed, 25 Feb 2026 19:56:57 +0000
Message-ID: <0b58a78f9703e9683ea56a6c2867f95c839d79ba.camel@ibm.com>
References: <4d5abe5c-2f93-4359-9aae-38f21ba0485b@tu-ilmenau.de>
	 <297c11fa7f42e2487266ec3c29e581f4ffda022b.camel@ibm.com>
In-Reply-To: <297c11fa7f42e2487266ec3c29e581f4ffda022b.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB4922:EE_
x-ms-office365-filtering-correlation-id: d91ac85e-bc37-4c6f-9397-08de74a80849
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 382PDFl1MmS2oe4Fn3bApVCJDijFndrkmBndK0hPnVDmGOkp1CBeAo9+s8K2lTxAsgZDYnXV5zo4wszQg6sXdgk+J0azL1bMCz/MknLNc2CW66csGIXs4eXUUyeLBmCrw0XbgyErpbOcDBGTFTh8Z2m9igzFI9QQFPxR9kvriWU/PkYW0dbd8AGW4Q76DYSzooyEmtHUPgFnhe0N1HFUah5HIx5TTwkp23t9u++VzhUTQ+moteVTgUxklVcrUfsFn818vLZeLDlMnXzGAUiX8vflhOb5qFcCeAFn8nIFeDE5JcmoN9DPnJZyR+O7AYNeceO8Nig5tNQ0rHFUat665kImUUIcZXp5h6oGyCYSNeIAYw4iyLRkKJotyVIkl+aX3ccSWpiM5oyZePIBKxh7tsj+2s59q0xIP/JJJRG1zkUQydiPXHK1jHgELys7uQTdDqJrlcnLO7RB7ep+RoPjUBZd3kSW8zx1ZYg5/kTa1OxhTeT4CK4Hz+TeU32Wt7NjfjKhvqvGPP3gxjgJRQq0gRdhEggCUpV7A6DZ7ICLUILj32s43UrcQ1PQUiEqDUB/KJNrR7E3+aLgJNKZfrjTQHXXOvKjrFg6OZihtdSfbGyekrKTwzd183loOqqGJHednuGIeuCDhvb5jpP/U0R60SixU0QJmxlsuhX70VyCYWth7mDIv19TN6WbHVayJN8NIIk/KO2mXEBinZH062YnsXGayAO74ioAb258bmmco0BYP2xspZuGzCqWMsGXx23pLuzyCvpMULexPu3O9sWWk3wUaYTqgdk+p1mEH3tF0z4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWFIYUtHMjVXU3F0eFdyRkZtSUN3ZzFJelByWmRJanoxQ09BM3R4WGtOUkMw?=
 =?utf-8?B?TDRXZVpOcE1Gd1h0QlI4anhHK3owaDJsMXgzUDJhaGxhQSswMis4eUR5eUdu?=
 =?utf-8?B?WVVvMVNBZzlCWFBxekNDUEQwQXBMa2VGOGMwdzc0RE4zcE5hTHlwWGRraTlI?=
 =?utf-8?B?cXplc2o4WG9vcGJZTld5L2pDWExHMVl4YWJoRFdwaDE4WnRnMEFEYU5aS3lH?=
 =?utf-8?B?ek1ZWGFxL1hSeVF5bDhGSCtDemtxMUJMdk9yb0pvR2lpZTFNVXRqK1NFdktK?=
 =?utf-8?B?c25ON1A5VDd2SkhiQy9heHdBTEF2ejVqSks2V3VOU1BBUC93c3dKTGFtMTZP?=
 =?utf-8?B?VTJqMFdML09kenVTSFhNVVZhZjBwdVkzclFPb2FyQVhGK3o4UkNWRzVOcnRS?=
 =?utf-8?B?cTdDSVBRSlhyc3B6YVFqL2FFcWFtZHhJVjkweUdOVmxOelpBSFU5MkNCNC9w?=
 =?utf-8?B?aDRTb25ZWnlFTCsxci94UGZ0UnhBWWxva3JRSXdMMHBmVlc1dHY5Nis2QVly?=
 =?utf-8?B?dStMMjZmQmZtK0pwM3RlSU15U0VPcGV2T1hQYXBkOEViVzNUaUJTOGxGbGZw?=
 =?utf-8?B?ZjRaVXVRbDlhVXRXOFlzSk9uYVdvN3EzMnF4UExnd3ZFaUxxZlc0Q2syUTlX?=
 =?utf-8?B?cEVTK1BLdFp1WkRkemdIVnYvTC9ZWGZsVGJhdVltaWxVQ2RWbWJKQ0hmZ2xW?=
 =?utf-8?B?SmRMVy9SNTNlYzlMSnkwTlF1ZjIvSk5vdnJMT1dDM2thUGQzYU9LcUQ5d1hD?=
 =?utf-8?B?OStwM3Fsc1dXTk1xWW8rWkd0WVpsdnRXb1lzUHZJc0FoaEM4bDJHUGRpdXNK?=
 =?utf-8?B?eklYajlsaE5IQXZXU0E4RkJ0ZVZJbXJ0a3kzdGdxNDhxbDZoS0RFUGx2bC9S?=
 =?utf-8?B?RUFjQit4YmNpWlJIZTBiNnMvM0dIZk5sTnF1d3JTNEs0MlBHT1B2UWFXV29u?=
 =?utf-8?B?SEk3emVxbHppbzM2QkxDelhWQ1Nta1dmUFlEZnoxRk1ETHZLZmhzUlZSZzds?=
 =?utf-8?B?TWdjQ0NidWJJc25PTTI0NVRoWFdheFJibXIxVElwL0NtbkYyQ2dEaHNhdXpo?=
 =?utf-8?B?MVllNEhkRnN5aVN5bXJKSlowdjI2NXAzMGJ4K04yanMwNytVZ28rTENvT3F0?=
 =?utf-8?B?Zi9nREU0aW4xaEpIVUczellEYTBkR1ZzMDF5TVV4dVVXcW03enlxR2E2WExp?=
 =?utf-8?B?RFcvRlpQWVRMa0U4MEhkaWxRVkM1K1BORnpBNFkycXFVd3JZU2FTOUQrbERk?=
 =?utf-8?B?bXcvYzRKVjRGNTQ2TmRIYzh2Tm1rTWY1ZFAvUXRKTjhqcU5tRTFjR0pFTmxu?=
 =?utf-8?B?REd3VkI3M2xEclhXWFJSVFRoYm51WXZQdFd6UGd4QXc5ZHJ0RXk2WkhiV3RX?=
 =?utf-8?B?bU9uMGZrR1p1MGs2dkxlUElGSWJPNlpoaW44NzNVcjZIL3ZEOURBQURnRUdi?=
 =?utf-8?B?Ny9qRVVXU0dZZFFHdzJiOGI4Y0NiVjdKd3RzK2pOTXhscXEvTkN6WFRKV3Rr?=
 =?utf-8?B?V3pzdnJ6bHBsUlFIZDVBM2dBVS81dU9TbmRjVDVsMU9UeGl3d1VZUUJtTWZP?=
 =?utf-8?B?d3lZOGVDWnM5UUdTdjJKckpUN1dxWnF0a29WMktvVWxuNW1veHVySDU4N09r?=
 =?utf-8?B?QlpDbWJyYVdiNkJ1RnoweVdBa0EzWDJNdXRGNFdVZ1VWcnFta1NSdnlhaEpY?=
 =?utf-8?B?UVJmZW00alA4NFgxZXhwdHNRUERJT3h1TWJWQlRuV3RtTXlmSEZMaWt5WDBT?=
 =?utf-8?B?Ky9OWGRwQTBsdDF2ZlF0cEx6NDFCY0FINU9nQVZCTUprZ3ZIU3QzaEJ3b1p4?=
 =?utf-8?B?bGthSmx4bGZqbERPL2JIR0Z2d3YyKzNRbFhRTUYveHNCajhyTWZZTldlQ2Zt?=
 =?utf-8?B?VHJNWFlCOVlDVVdPT0hrWFdQMDh3YUU5MWQrSGhNMi9TMDNyLzZyRzFCME1Y?=
 =?utf-8?B?Ukx3QzJZYzVPcCtpenZZaUR3UFhDQ2xkbmdhZG8zRVVJaU9lS2t6ajRMZlNq?=
 =?utf-8?B?UnR3OXgyMVhJODJkY0VMZHZCWUtMQXhnbkI4L05MM1dieGNONDQ4b09rcndU?=
 =?utf-8?B?bnlubExXREZEOGliYytDK3ZUWHNYVlFLbThmTVdxZ3JwOGxScjM4bGlVL3pV?=
 =?utf-8?B?UUp2SytlTURGaGNTczhINkJHRFZqcXhNUjYweGs2SW9Yd1VJS0FQRnhkc1RQ?=
 =?utf-8?B?czJJUFFkRWc5aVRWVHZ1U1I2bGZUZXRwNTVPaEM2ZkJGUDZsUzRNUjRGaUpP?=
 =?utf-8?B?WUhlNzZMSkxFYUdSWGMyTHdwaE5KdW9mTUE0czhWYmplWEJ2S0NXWlBYWTFG?=
 =?utf-8?B?T0U0dDJYMjNkR3grY2tFaENJNUtWbjRDWTdHdTF6QktQZWx5U2lLZDZZSXlq?=
 =?utf-8?Q?aQtVvUlyhhpVdnCk+eXIKIAY7bJ9iR6FAha0a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AEF8886D348BE43AF5E09A01969E080@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91ac85e-bc37-4c6f-9397-08de74a80849
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 19:56:57.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9Et57dKUoj5ZbQskOTxKr2wDdFi/w28b+oCQiscxuVzFDaiWlZ0Vnt+PuUcMGzmotl2OqRawTcog/pZLTeXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4922
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699f540d cx=c_pps
 a=sTSJOlcUIwiiAZkT7IHz4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=TIfcdihVYL6D9cUBdowA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q-8tFN0t4pNVJbBu1GK3nYoOSimUEmC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE4OCBTYWx0ZWRfXzKgamElZLWyy
 VO/3poS59+IAoaec43HnaAPaw4GRORNqtRn9t9jSsPRKMRl7BnfS+32dHXW3IPFFNKBfxVEqV0+
 SuRliz93HCXKwXBwhznQxj48MlJaiMNsIAyOAEshHMT4mo8Nc9iy2gznQw6t/qjEkLXGk6cvzt1
 UoO3GlLQThpJ0MwzE1jwhE3tM/3XeK7oUZBy6WG0M/jMv+ixxRSesuK4v+aFCXNjIToPcMdofjv
 u1MzMnq4q3AhVRKN1azo5Q5S7cMiTAHGaIIhZcEEdtSa1i0/P4F5d4vHr0iylmpysyxzutICInI
 0zPMr0WHW7JKZrHsprXsUignzil9Eta/vj8pqgmKvhK0uk2KXMt2JBpWb9tUea+Q+4cf4st1Nu0
 fz6aM5NWbEZdzn7qgOd/HO1pWfYCNsx9j4wJ/eJmdEnzxFqx8lhQZmmGNRf7GD7kJpU5aZRJQMj
 VKp/TBEz4+GvhLiT2Iw==
X-Proofpoint-ORIG-GUID: Go8656PX1MhNKdWWFTQGmtfkxBqshfJM
Subject: RE:  [PATCH v2] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250188

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDE5OjM1ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFdlZCwgMjAyNi0wMi0yNSBhdCAwOToyNSArMDEwMCwgUmFwaGFlbCBaaW1tZXIg
d3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB1bm5lY2Vzc2FyeSBpbXBsaWNpdCBjb252ZXJz
aW9ucyB0aGF0IGNoYW5nZSBzaWduZWRuZXNzIA0KPiA+IG9mIGJsb2JfbGVuIGFuZCBudW1fbW9u
IGluIGNlcGhfbW9ubWFwX2RlY29kZSgpLg0KPiA+IEN1cnJlbnRseSBibG9iX2xlbiBhbmQgbnVt
X21vbiBhcmUgKHNpZ25lZCkgaW50IHZhcmlhYmxlcy4gVGhleSBhcmUgdXNlZCANCj4gPiB0byBo
b2xkIHZhbHVlcyB0aGF0IGFyZSBhbHdheXMgbm9uLW5lZ2F0aXZlIGFuZCBnZXQgYXNzaWduZWQg
aW4gDQo+ID4gY2VwaF9kZWNvZGVfMzJfc2FmZSgpLCB3aGljaCBpcyBtZWFudCB0byBhc3NpZ24g
dTMyIHZhbHVlcy4gQm90aCANCj4gPiB2YXJpYWJsZXMgYXJlIHN1YnNlcXVlbnRseSB1c2VkIGFz
IHVuc2lnbmVkIHZhbHVlcywgYW5kIHRoZSB2YWx1ZSBvZiANCj4gPiBudW1fbW9uIGlzIGZ1cnRo
ZXIgYXNzaWduZWQgdG8gbW9ubWFwLT5udW1fbW9uLCB3aGljaCBpcyBvZiB0eXBlIHUzMi4gDQo+
ID4gVGhlcmVmb3JlLCBib3RoIHZhcmlhYmxlcyBzaG91bGQgYmUgb2YgdHlwZSB1MzIuIFRoaXMg
aXMgZXNwZWNpYWxseSANCj4gPiByZWxldmFudCBmb3IgbnVtX21vbi4gSWYgdGhlIHZhbHVlIHJl
YWQgZnJvbSB0aGUgaW5jb21pbmcgbWVzc2FnZSBpcyANCj4gPiB2ZXJ5IGxhcmdlLCBpdCBpcyBp
bnRlcnByZXRlZCBhcyBhIG5lZ2F0aXZlIHZhbHVlLCBhbmQgdGhlIGNoZWNrIGZvciANCj4gPiBu
dW1fbW9uID4gQ0VQSF9NQVhfTU9OIGluIGxpbmUgMTE3IGRvZXMgbm90IGNhdGNoIGl0LiBUaGlz
IGxlYWRzIHRvIHRoZSANCj4gPiBhdHRlbXB0IHRvIGFsbG9jYXRlIGEgdmVyeSBsYXJnZSBjaHVu
ayBvZiBtZW1vcnkgaW4gbGluZSAxMjAsIHdoaWNoIHdpbGwgDQo+IA0KPiBBZnRlciBzb21lIHRp
bWUsIG5vYm9keSB3aWxsIGJlIGFibGUgdG8gZm9sbG93IHdoaWNoIGxpbmUgMTE3IGFuZCBsaW5l
IDEyMCB5b3UNCj4gbWVhbiBoZXJlLiA6KQ0KPiANCj4gPiBtb3N0IGxpa2VseSBmYWlsLiBJbiB0
aGlzIGNhc2UsIGFuIHVubmVjZXNzYXJ5IGF0dGVtcHQgdG8gYWxsb2NhdGUgDQo+ID4gbWVtb3J5
IGlzIHBlcmZvcm1lZCwgYW5kIC1FTk9NRU0gaXMgcmV0dXJuZWQgaW5zdGVhZCBvZiAtRUlOVkFM
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhcGhhZWwgWmltbWVyIDxyYXBoYWVsLnppbW1l
ckB0dS1pbG1lbmF1LmRlPg0KPiA+IC0tLQ0KPiA+ICAgbmV0L2NlcGgvbW9uX2NsaWVudC5jIHwg
NiArKystLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL21vbl9jbGllbnQuYyBiL25l
dC9jZXBoL21vbl9jbGllbnQuYw0KPiA+IGluZGV4IGZhOGRkMmEyMGY3ZC4uOTRhN2E4MmNhNDc1
IDEwMDY0NA0KPiA+IC0tLSBhL25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiA+ICsrKyBiL25ldC9j
ZXBoL21vbl9jbGllbnQuYw0KPiA+IEBAIC03Miw4ICs3Miw4IEBAIHN0YXRpYyBzdHJ1Y3QgY2Vw
aF9tb25tYXAgKmNlcGhfbW9ubWFwX2RlY29kZSh2b2lkIA0KPiA+ICoqcCwgdm9pZCAqZW5kLCBi
b29sIG1zZ3IyKQ0KPiA+ICAgICAgICAgIHN0cnVjdCBjZXBoX21vbm1hcCAqbW9ubWFwID0gTlVM
TDsNCj4gPiAgICAgICAgICBzdHJ1Y3QgY2VwaF9mc2lkIGZzaWQ7DQo+ID4gICAgICAgICAgdTMy
IHN0cnVjdF9sZW47DQo+ID4gLSAgICAgICBpbnQgYmxvYl9sZW47DQo+ID4gLSAgICAgICBpbnQg
bnVtX21vbjsNCj4gPiArICAgICAgIHUzMiBibG9iX2xlbjsNCj4gPiArICAgICAgIHUzMiBudW1f
bW9uOw0KPiA+ICAgICAgICAgIHU4IHN0cnVjdF92Ow0KPiA+ICAgICAgICAgIHUzMiBlcG9jaDsN
Cj4gPiAgICAgICAgICBpbnQgcmV0Ow0KPiA+IEBAIC0xMTIsNyArMTEyLDcgQEAgc3RhdGljIHN0
cnVjdCBjZXBoX21vbm1hcCAqY2VwaF9tb25tYXBfZGVjb2RlKHZvaWQgDQo+ID4gKipwLCB2b2lk
ICplbmQsIGJvb2wgbXNncjIpDQo+ID4gICAgICAgICAgfQ0KPiA+ICAgICAgICAgIGNlcGhfZGVj
b2RlXzMyX3NhZmUocCwgZW5kLCBudW1fbW9uLCBlX2ludmFsKTsNCj4gPiANCj4gPiAtICAgICAg
IGRvdXQoIiVzIGZzaWQgJXBVIGVwb2NoICV1IG51bV9tb24gJWRcbiIsIF9fZnVuY19fLCAmZnNp
ZCwgZXBvY2gsDQo+ID4gKyAgICAgICBkb3V0KCIlcyBmc2lkICVwVSBlcG9jaCAldSBudW1fbW9u
ICV1XG4iLCBfX2Z1bmNfXywgJmZzaWQsIGVwb2NoLA0KPiA+ICAgICAgICAgICAgICAgbnVtX21v
bik7DQo+ID4gICAgICAgICAgaWYgKG51bV9tb24gPiBDRVBIX01BWF9NT04pDQo+ID4gICAgICAg
ICAgICAgICAgICBnb3RvIGVfaW52YWw7DQo+IA0KPiBMb29rcyBnb29kLg0KPiANCj4gUmV2aWV3
ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiANCj4g
DQoNCkkgaGF2ZSB0cm91YmxlcyB0byBhcHBseSB5b3VyIHBhdGNoIG9uIDYuMTkga2VybmVsIHZl
cnNpb246DQoNCmdpdCBhbSANCi4vdjJfMjAyNjAyMjVfcmFwaGFlbF96aW1tZXJfbGliY2VwaF91
c2VfdTMyX2Zvcl9ub25fbmVnYXRpdmVfdmFsdWVzX2luX2NlcGhfbW9uDQptYXBfZGVjb2RlLm1i
eA0KQXBwbHlpbmc6IGxpYmNlcGg6IFVzZSB1MzIgZm9yIG5vbi1uZWdhdGl2ZSB2YWx1ZXMgaW4g
Y2VwaF9tb25tYXBfZGVjb2RlKCkNCmVycm9yOiBjb3JydXB0IHBhdGNoIGF0IGxpbmUgMTANClBh
dGNoIGZhaWxlZCBhdCAwMDAxIGxpYmNlcGg6IFVzZSB1MzIgZm9yIG5vbi1uZWdhdGl2ZSB2YWx1
ZXMgaW4NCmNlcGhfbW9ubWFwX2RlY29kZSgpDQpoaW50OiBVc2UgJ2dpdCBhbSAtLXNob3ctY3Vy
cmVudC1wYXRjaD1kaWZmJyB0byBzZWUgdGhlIGZhaWxlZCBwYXRjaA0KaGludDogV2hlbiB5b3Ug
aGF2ZSByZXNvbHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29udGludWUiLg0KaGlu
dDogSWYgeW91IHByZWZlciB0byBza2lwIHRoaXMgcGF0Y2gsIHJ1biAiZ2l0IGFtIC0tc2tpcCIg
aW5zdGVhZC4NCmhpbnQ6IFRvIHJlc3RvcmUgdGhlIG9yaWdpbmFsIGJyYW5jaCBhbmQgc3RvcCBw
YXRjaGluZywgcnVuICJnaXQgYW0gLS1hYm9ydCIuDQpoaW50OiBEaXNhYmxlIHRoaXMgbWVzc2Fn
ZSB3aXRoICJnaXQgY29uZmlnIHNldCBhZHZpY2UubWVyZ2VDb25mbGljdCBmYWxzZSINCg0KV2hp
Y2gga2VybmVsIHZlcnNpb24gZG8geW91IGhhdmU/IE1heWJlLCB5b3VyIGVtYWlsIHNlcnZlciBj
b3JydXB0ZWQgdGhlIHBhdGNoPw0KDQpUaGFua3MsDQpTbGF2YS4NCg==
