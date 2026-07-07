Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E25420877
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449948; cv=fail; b=jcTr+8EtOhakNwet3O6vEHe1xc0bSLSWjjKKVu7DW3zHpwMVZtyMKjrtfVJFub1bDa8aLF0zTds5LtYrPCvDO4mr07JEaB6hHnZrO5OlOiW0TgcFxB1+DswYlxxnvC/y5TrOF59i858NgA0d4szNBiulQ4j8R2NIc8Zw6CSJo+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449948; c=relaxed/simple;
	bh=VJUkSTdUR0u6p+MuD6E4YXyMFOiW8ajj1kq8oNh/5Mc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=rKzFfAQRF5cNcYtk4TnZdUpP3FMpQ35Dcs4s8KjL59Sofyui0Ovldpy4Lgcfssk8h5k2r3R9iezquxKI0GVfjQNZgurvuZtWjuNYbMmKCuUyy5Zt9pokC/fKZDeL0Xm4+En6hX/EhMxNf2F273C5BiyjrpdyJMf5svRD6bHDnvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kvW/wsJz; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kvW/wsJz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FmQ7C4085074;
	Tue, 7 Jul 2026 18:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=VJUkSTdUR0u6p+MuD6E4YXyMFOiW8ajj1kq8oNh/5Mc=; b=kvW/wsJz
	sxICX8iSifigsYgmFPeUO9ASOKcIqdCwgzuB1xdiE5PvCBGJnTs1n8TXUxQ4UOXX
	k7wmNGTzRREFaGqUE0QZ0K2IQgScOB8WekYfCyMz1B2zS9WUg0oKUdlZ4xq7WS1F
	rzQurtqiI1q3fbr7gzMwhOkpiDk1k/pcEYtuz39QfrOpeo9+6BufvrcSKwmaYfKX
	A0B/iLLTpM5htxBofPAy17+OlJNn/MF/mjEl3jnHg+G6AGXuu2jjg2F8j1Mf32xv
	pYKVBNaNCUUIrsAv22gNlvxAyYOCf4pFffwl7GEK2l+iA5PI2jpOU3JwCSJgkTQU
	Pi1s4pFcylrclg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4rtdy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 18:45:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9+aNgCMVymnH1L3PEANFNULZ05gD9LrtCyx+UPh62z0/gErerIHw4aTgc4ucN+0l4PQ8ymmlD4K3vwW3HF13XfFVN40wVobD5jjfZo1KjYXPodW6/eHyaIgiJNWGFILOhap28T8pKJonkDtPKwKhivDs00ws/V70ThYPICR7i3GzpMXVB6ECNcC7gp1hjEs6KufgOC/Dx7b/2+YDuHY3rKjTumkORoDwVhm3I6FqICVLr22+JxnOA5O+VxTeodqlYZn41WurNz3Vg25AG4AEx01WHyQjDXNlec/emBO7xNWlkUx4lJ0VJ7Q6Ys+gkX9A4zgoXW3pUJQz2WKtYCHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJUkSTdUR0u6p+MuD6E4YXyMFOiW8ajj1kq8oNh/5Mc=;
 b=PkuSuwIaWuS//8PpoN2zqpsjOhWSv6ayWbY5sPtkgX2o4yfV0DLDqPIF3g9aDvdkZ3IepNB/JUIK0sKDrEOsjKrO/xcyc2OVwPwvr64tXRkwJTcj/R0u7m+BmqzQ85zzC4oBkMwVA+UcsPRkPiftPQGPrqX67+QP9IMM8jH7JqbRFqiIYX6AonDptDBhyuAAW+zEbx0yf280f65eEGZe6hORTX2chlZzw07D2WbbWMDIFUsJFfxURNuJzp8RIiEtZ4sVP+7ARhHSDZAQHOfS8qqwKTuzrZslpHF0NhZGhaTdvWngFwF8RUVpxKZRtp6fi7Do1z84IptUukyv2TB+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH5PR15MB6971.namprd15.prod.outlook.com (2603:10b6:610:2f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 18:45:39 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 18:45:39 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "xiubo.li@clyso.com"
	<xiubo.li@clyso.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 00/15] ceph: add binary logging (BLOG)
 for CephFS
Thread-Index: AQHdDhhsoOQtAonTN0uqNcwWSDtFarZiZWmA
Date: Tue, 7 Jul 2026 18:45:39 +0000
Message-ID: <630ef289fe4eaf4c78bf3b7572d294a64e3e97ce.camel@ibm.com>
References: <20260706143843.1980879-1-amarkuze@redhat.com>
	 <20260707134235.2235224-1-amarkuze@redhat.com>
In-Reply-To: <20260707134235.2235224-1-amarkuze@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH5PR15MB6971:EE_
x-ms-office365-filtering-correlation-id: 9eadaa8d-1bb2-48b0-ddf9-08dedc57f102
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|376014|4133799003|4143699003|56012099006|11063799006|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info:
 XC4Uv+5rRxghONhbQop7uPC+9KZlr0l18kKLX7Cxg4rx6N2Zk8ZFxzzTRt6nzPp+G89NYK9Tl05O4SbbryYyMdiIz2ieEyF+Xk2Zxcp4Rrr78WnyFG3hTmS4a5L1vtVFPIkTHVD977On3zDtmx0ryLyPJ0UxWkm5COv0VsEBFk1CWuwmXD+xbGRUsnIivsYdZM5ERkoke3u724cms8xuqos4udG/De2NzTvaeGPolSK3n5KisALePMadWLDUAL0EPboRVBRCDCotUMPWnLzDW5akvi8ZhKJy1UYNxt/dmdTny93I1TUPAajn9FxKmj+ScG84/ORpTWiSxVlLZAiXb6kqlXOMTsZN4KY5WuPpZggR8fbaw+ZcNWt39qs8vh8GhS0ld2YThR8RtybKGLT9/c+vzkY+rgVlqTt6+u6rWbN3UpcbUnHepHoLFZxXOQvNt8QBAPFSHwjNSY5xw/sZopzbY6wBxLodHd4bTJYNWWjGdArkyErbGMtQmbulW3vsv2nNZ6VQTxVtDWJ4e66nVI5N7IhcTdvDtx7h2L444T/zn1rmW/OHljy9cgwu1uGTmZAxQYTsTKxAV8LJ35HGwmbeR6RxN0C8x7srb+dCci+t5MuV9abqxRVMLO+3tU9dLBivu2InTmbzYGKE5rm87PeBwwdpj1cOP/8jBLNKN94=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(4133799003)(4143699003)(56012099006)(11063799006)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWV5Zjh6Y2xva29wcmdMZ0ZnUDhoL1dZTi9yOTBzMklmUGhIN0o1MFVvUS9Y?=
 =?utf-8?B?N0ZDNTNONTFLbUNac1Z3a2MybTZ1OHdDWnZLZTVURHBJWTNTNTZnWHpwdC9D?=
 =?utf-8?B?RHR2SGdFcytBUG4wSDdhRCtFNit5cnRDTVk2Qy9Oa0h2NG1uM2JKaUNIeCtM?=
 =?utf-8?B?b21rYXIyODgrdERlT1JQQnZHQjZkYWkyV1lZSU5EVkozNkwzclhHTWJKaVdP?=
 =?utf-8?B?R2R0V1BROGZQdTJsM2txckQ1L3VhV1hyMGNSUzV3ZWw4MWxXaStzNElaUHZD?=
 =?utf-8?B?TXFnVURMU1dsbHhQU2tZZGdTSnZ3ajk4MUFhV0h4NCtBZEpwNzFXcks5NmdS?=
 =?utf-8?B?aUpZK29RMlMzUndOTFBzSnc2cTNWMWY3L3ZRQmQ5cG9Mbkp0NjlSV2NwcUVW?=
 =?utf-8?B?RkV2dnpqN1lWNVVkRUduVFYvR2ZWNW1zWjdwUmgrTjFLQXI0ZUhDTFA0dXZv?=
 =?utf-8?B?R01tcXBnV01pY0E0MUtVN2xjR2cyMGtPSkxoZTYrNmMwdHpQYzQ3eUpwMkxp?=
 =?utf-8?B?VzhDRFRGc1ZmZEFGUlRjd0NiTG1iYmtNaTVEQUo4eXVjMFVuYjF4aVhacXFL?=
 =?utf-8?B?c3oxSnJYcmJEKzZ6THlrUzFDQ1NGRXk1cjZPSk9YSWg5eExxMzk0dCtIekU2?=
 =?utf-8?B?RlJieTVxOGQwQ3BGZlI3VlQrQXBsWlIrcFdRaDdzbkNrUnY5cVVTYkhZVmlF?=
 =?utf-8?B?Kzd5RmtjNGpwRi9RZDhLWVdOSjBDV203UzVOSWlva0VVUUdjdkhVam5sNUhm?=
 =?utf-8?B?WFV0Z09MQ1pMdGYxb1YwLytmUnJxOXFZZFI1dkwwZHBURjUraFpRYVhtMjUr?=
 =?utf-8?B?VGlaTGptMUFEV3VpN2s2Snd6UUErOHdPWEhYV1ZwaXY4dGZrM2VYMG8yaFJl?=
 =?utf-8?B?aWZCMnF5dUJZd3VwMHErbHZVRzcrOU5PbmR4U2pveFFJZDY2VDdBcDNRK0ZX?=
 =?utf-8?B?dTdrZ0QvdlI3bi8wWHJWZWlISmQ4TWtKNzlzNCtCMUcrRkxtVGtPZWg2eGph?=
 =?utf-8?B?RXgzWWJQTXZCS2FDMEFKQXZyOWxWSTRHTjFGM21IUmpNRlQrSThvSXFrNUMx?=
 =?utf-8?B?QkF1blNvb0phZGM1dHVpYjVhWjRjbmo3K3dNZGtzSnc5Sm9jQkxaSUxaaGgw?=
 =?utf-8?B?bVBFSjBLem95NnRjU3B1MFA4NU9jV3Q4ZVYxMzZRSEo4VGJENW1EUVd1dlNP?=
 =?utf-8?B?QXJzaGdrWGpxQU82NTh5dTZvTXRBS0tCRXIySlFiK2xNQk8yWFdxREJBVXZI?=
 =?utf-8?B?ZUxQTTcyU3dtaVprd1BoR0MyTW1nbWRqS0VqK1VzL3UvbUtaMkJOTmtudzZo?=
 =?utf-8?B?eUJxcyt4T2ppZ0xiNnNVM05KTzRWcHZ2VS9BVHpVeFRpQWs5bUoya3F4L2ZI?=
 =?utf-8?B?dVlSZXJkeC9iUC9jQ05ST1FpbDdIc1pjTEtNTmxlYUNuOVR0Tlc4VGZmTVVJ?=
 =?utf-8?B?UVN4Skt0NWZSaW5wbnNFQTZYTEhwRlA2K0hkNDZVMkJSOGZ5cGh5Z0haQjFI?=
 =?utf-8?B?NUNqWXFCVU5HU2Jnd251elo1eUpUR2JIS3FNaU52OUV0ZTN2NDdLS3A0NkhO?=
 =?utf-8?B?V0VJdTNCYlJjNUdSSUlEOEY4b014L3gzVndXTlNlRVEyN2JNQ3BxanQ4cHlv?=
 =?utf-8?B?aHRQU3ZJS3ZES1J2enBVVVBQUys5VjlpV3lXcnBhOTV4blIyMnpJVFlXMlFq?=
 =?utf-8?B?Z3hZZ0ptZllpcUoxMWNyeHhHTFlmbk93Zmx2WVZOd0xOUkkrR0JqbDBoRHpL?=
 =?utf-8?B?ZGVxOU9ESXFSTFRNSmd1aWJQSHlTSFFrcXUzVDZvcmdQWGlYRW1GZmcxZC8x?=
 =?utf-8?B?RGFuODExL25xenEzdC9SUE50WG9OTkJQN1Z6OXlqYWtRR2JISGMxYU10TXVB?=
 =?utf-8?B?V0RnL256QzlaZVJOWTNJeW1yR0grSlBMK2x2UHoxWTNBYnc0enl4UFZ5M3ZF?=
 =?utf-8?B?VElYNlRyK2d3SmZJRE9LSHZGeE5qQkJtbnJSV1RzYzAzYUxkeDFuWlpodGlY?=
 =?utf-8?B?TkhBV1lFK3Z5M2FqU205YWxDSUs3NjVEaXBKSGEwNThRSFhpblpQUEJtWWw0?=
 =?utf-8?B?MCtjVlRIYlBkbWR5NkhybU9iUDQ0YS8wcGFjTmE4MER4dk1uejl6T0N5b3BY?=
 =?utf-8?B?Z3l3ZWlrMjRIcGtpSnRTMHRmVzY5clBEZi9uaFBnR0JySTBpQnR4Sitzdm11?=
 =?utf-8?B?MjRCanRwZEUzcUlJaGxFY1dpUHBMekMzQTkxRyt6dmYxNXZiQXc2cWpUT0di?=
 =?utf-8?B?cHJxS1padnpKdGgxeExKU20xS2VzajQrSmFYQkhSanRIRWJ6NmRpclBMY09t?=
 =?utf-8?B?RTB2azRFYmk2RmJkSysvS3crRTFPc01jL1p6UjdtL3hyYS9qZE5BY3p6TnJn?=
 =?utf-8?Q?AyhR7Q3NaAiJs5ZdidcyO30i8XBngMYP8VfbE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A976ABDAFBE18749BE561CB9BB21CA0E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	JE6/bQVL46DOsd5C4nB8z76BoR+bs1IWg+Pxyc8/Nd1ZZVWfZ1/xi0AqF8I+SqyaqIKqdNYjHrV5RHbFOiMlvnZr/9kgreVotCaxdNXqWWm2CVPYzuc1tpnutyc4r94/oUfzMA58HJff3aylduDUYlL0+dKHxGBbgck5bQCrF7+mRXveZjAm52XXkMIrgAc/F6fFwVTGIpEAs8zFNYqeSVZq6pjwKhQSXqsT/uASWPL7aB7pilVoagUDxgtE+KZmKyJlm+X7NfGb18s7uIJ4UaJWGdvBa+ol6KEuEC2M+Pl/hguI4l6JGBjSzCyx3boKphKp8z/ZV6QX2DPkO5MBfA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eadaa8d-1bb2-48b0-ddf9-08dedc57f102
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 18:45:39.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrtOh4QgpaZ8wN48ALnSdm3OeY0B9wnu9n6aUj+NvJgmHCuBtSovcaM9Hmfp3fcIK1Ll3XBP3XpN7m2++RvUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR15MB6971
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: FvX0DnTdwTIRuOj7F6kX8pcjYunOoF2R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfXzeuyjYzTGxHH
 2d8IH8tO6mzk32iTQuuu9osAVi6TSYWm/evu/o/mM658o0Bo8F4KXd50yb6QKpylUBgJOPwfilJ
 wz+mrVtWQcpVo1r6G0+r3/j6gcrcIwcnB37FvRUnvR7iddCe2jfJcHb2ZQ4mSqdSb4jeCsAVt6J
 gvEOVrUHyW/0KVwkaYGlesFzuzdfwhur0Ihv+GEha2LvJEb40WgM+S0OVr15nv+ly0TF3Rnvxm4
 BEhjFLOq7eXmCbjDA2zBayG1Fw3JWT/XQgc6rUO7q6IdGNnTjlY3/a2En0TQeHI2umyQtbTOfdk
 P7hPmqkaxIoLC1ecsUiIQ2IfZ5ig4PFRbslv/l2VxUt//vzmZie0FNsPWlS13xMapALoaOI+HCZ
 I9Hlz2x15BezqI3ucGUgnnjYk5IEr9K1zXjgq5A4MRTTRPjQwtIARA5sgUX2KxbmuKPLt8pdHyR
 BghViclyvm6lfVhsRAA==
X-Proofpoint-ORIG-GUID: XRNm73FvFrG7l1_ZJNJt95K14PRpZHXD
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4d4956 cx=c_pps
 a=JJStoDgKLvGmSPu1zToK9A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=gdsmsdw9yaMiQ5uEKHsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX72nidEn/hJzo
 Zf6m+tw3GyCOUfP//1etlkIfdFusna+59NE9oBLIT9gWE1USMGIh0Evv03TSffog6fXuCeK/YAF
 r9JXx9IRV+wHKUrhXhyYKvjkonynPAM=
Subject: RE: [PATCH v2 00/15] ceph: add binary logging (BLOG) for CephFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070180

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDEzOjQyICswMDAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IEhpIFNsYXZhLA0KPiANCj4gVGhlIHNlcmllcyBpcyBiYXNlZCBvbiBjZXBoLWNsaWVudC90ZXN0
aW5nLCBub3QgbWFpbmxpbmUuIFBhdGNoIDkvMTUNCj4gdG91Y2hlcyBtZHNfY2xpZW50LmMgd2hp
Y2ggaGFzIHNldmVyYWwgcGF0Y2hlcyBpbiB0ZXN0aW5nIHRoYXQgaGF2ZW4ndA0KPiBnb25lIHVw
c3RyZWFtIHlldCwgc28gaXQgd29uJ3QgYXBwbHkgdG8gNy4yLXJjMi4NCj4gDQo+IFRvIGFwcGx5
Og0KPiANCj4gICBnaXQgY2xvbmUgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3Yy
L3VybD91PWh0dHBzLTNBX19naXRodWIuY29tX2NlcGhfY2VwaC0yRGNsaWVudC5naXQmZD1Ed0lE
YVEmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdL
cTRZNFJBa0VsdlVnU3MwMCZtPWVCNDFqRXJrc2R5Y1pHWjZaZ2lWQW5iUko5VnhjQnFkTXY1eWdQ
c3hFS2RtRjdOTnRaX3hEenNwWWFWQ19iYjUmcz1ISC04V0R5aGlOZVBybUNmeUQzTmpyVTl4Qy1i
R3lQSDZjTE5ncjlrVTBFJmU9ICAtYiB0ZXN0aW5nDQo+ICAgYjQgc2hhemFtIDxtc2dpZD4NCj4g
DQo+IG9yIGp1c3QgcHVsbCBjZXBoLWNsaWVudC90ZXN0aW5nIGRpcmVjdGx5IOKAlCB0aGUgc2Vy
aWVzIGFwcGxpZXMgY2xlYW4NCj4gdGhlcmUuDQo+IA0KDQpJIGNhbm5vdCBhcHBseSB0aGUgcGF0
Y2hzZXQgY2xlYW5seSBvbiBjZXBoLWNsaWVudC90ZXN0aW5nIHRvbzoNCg0KYjQgc2hhemFtDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9jZXBoLWRldmVsLzIwMjYwNzA3MTM0MjM1LjIyMzUyMjQt
MS1hbWFya3V6ZUByZWRoYXQuY29tL1QvI3QNCkdyYWJiaW5nIHRocmVhZCBmcm9tDQpsb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjYwNzA3MTM0MjM1LjIyMzUyMjQtMS1hbWFya3V6ZUByZWRoYXQuY29t
L3QubWJveC5neg0KQ2hlY2tpbmcgZm9yIG5ld2VyIHJldmlzaW9ucw0KR3JhYmJpbmcgc2VhcmNo
IHJlc3VsdHMgZnJvbSBsb3JlLmtlcm5lbC5vcmcNCkFuYWx5emluZyAxOCBtZXNzYWdlcyBpbiB0
aGUgdGhyZWFkDQpMb29raW5nIGZvciBhZGRpdGlvbmFsIGNvZGUtcmV2aWV3IHRyYWlsZXJzIG9u
IGxvcmUua2VybmVsLm9yZw0KQW5hbHl6aW5nIDE2IGNvZGUtcmV2aWV3IG1lc3NhZ2VzDQpDaGVj
a2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50Li4uDQot
LS0NCiAg4pyTIFtQQVRDSCB2MiAxLzE1XSBjZXBoOiBhZGQgQkxPRyBwdWJsaWMgaGVhZGVycw0K
ICDinJMgW1BBVENIIHYyIDIvMTVdIGNlcGg6IGFkZCBCTE9HIGRlc2VyaWFsaXphdGlvbiBzdXBw
b3J0DQogIOKckyBbUEFUQ0ggdjIgMy8xNV0gY2VwaDogYWRkIEJMT0cgcGFnZS1mcmFnbWVudCBh
bGxvY2F0b3INCiAg4pyTIFtQQVRDSCB2MiA0LzE1XSBjZXBoOiBhZGQgQkxPRyBtYWdhemluZSBi
YXRjaCBhbGxvY2F0b3INCiAg4pyTIFtQQVRDSCB2MiA1LzE1XSBjZXBoOiBhZGQgQkxPRyBsb2dn
ZXIgY29yZQ0KICDinJMgW1BBVENIIHYyIDYvMTVdIGNlcGg6IGFkZCBCTE9HIHBlci1tb2R1bGUg
Y29udGV4dCBtYW5hZ2VtZW50DQogIOKckyBbUEFUQ0ggdjIgNy8xNV0gY2VwaDogYWRkIENlcGgg
QkxPRyBzY2FmZm9sZGluZw0KICDinJMgW1BBVENIIHYyIDgvMTVdIGNlcGg6IGFkZCBib3V0IGFu
ZCBib3V0YyB3cmFwcGVycyBmb3IgQkxPRw0KICDinJMgW1BBVENIIHYyIDkvMTVdIGNlcGg6IHN3
aXRjaCBNRFMgcmVxdWVzdCBwbHVtYmluZyB0byBzdHJ1Y3QNCmNlcGhfam91cm5hbF9pbmZvDQog
IOKckyBbUEFUQ0ggdjIgMTAvMTVdIGNlcGg6IGFkZCBCTE9HIGRlYnVnZnMgaW50ZXJmYWNlDQog
IOKckyBbUEFUQ0ggdjIgMTEvMTVdIGNlcGg6IGNvbnZlcnQgVkZTIGlub2RlIGFuZCBkaXJlY3Rv
cnkgcGF0aHMgdG8gYm91dA0KICDinJMgW1BBVENIIHYyIDEyLzE1XSBjZXBoOiBjb252ZXJ0IFZG
UyBkYXRhIEkvTyBwYXRocyB0byBib3V0DQogIOKckyBbUEFUQ0ggdjIgMTMvMTVdIGNlcGg6IGNv
bnZlcnQgY2FwYWJpbGl0eSBhbmQgc25hcHNob3QgcGF0aHMgdG8gYm91dA0KICDinJMgW1BBVENI
IHYyIDE0LzE1XSBjZXBoOiBjb252ZXJ0IHJlbWFpbmluZyBoZWxwZXIgcGF0aHMgdG8gYm91dA0K
ICDinJMgW1BBVENIIHYyIDE1LzE1XSBzZWxmdGVzdHM6IGFkZCBDZXBoIEJMT0cgc21va2UgdGVz
dCBhbmQgY29sbGVjdGlvbiBoZWxwZXJzDQogIC0tLQ0KICDinJMgU2lnbmVkOiBES0lNL3JlZGhh
dC5jb20NCi0tLQ0KVG90YWwgcGF0Y2hlczogMTUNCi0tLQ0KQXBwbHlpbmc6IGNlcGg6IGFkZCBC
TE9HIHB1YmxpYyBoZWFkZXJzDQpBcHBseWluZzogY2VwaDogYWRkIEJMT0cgZGVzZXJpYWxpemF0
aW9uIHN1cHBvcnQNCkFwcGx5aW5nOiBjZXBoOiBhZGQgQkxPRyBwYWdlLWZyYWdtZW50IGFsbG9j
YXRvcg0KQXBwbHlpbmc6IGNlcGg6IGFkZCBCTE9HIG1hZ2F6aW5lIGJhdGNoIGFsbG9jYXRvcg0K
QXBwbHlpbmc6IGNlcGg6IGFkZCBCTE9HIGxvZ2dlciBjb3JlDQpBcHBseWluZzogY2VwaDogYWRk
IEJMT0cgcGVyLW1vZHVsZSBjb250ZXh0IG1hbmFnZW1lbnQNCkFwcGx5aW5nOiBjZXBoOiBhZGQg
Q2VwaCBCTE9HIHNjYWZmb2xkaW5nDQpBcHBseWluZzogY2VwaDogYWRkIGJvdXQgYW5kIGJvdXRj
IHdyYXBwZXJzIGZvciBCTE9HDQpBcHBseWluZzogY2VwaDogc3dpdGNoIE1EUyByZXF1ZXN0IHBs
dW1iaW5nIHRvIHN0cnVjdCBjZXBoX2pvdXJuYWxfaW5mbw0KQXBwbHlpbmc6IGNlcGg6IGFkZCBC
TE9HIGRlYnVnZnMgaW50ZXJmYWNlDQpBcHBseWluZzogY2VwaDogY29udmVydCBWRlMgaW5vZGUg
YW5kIGRpcmVjdG9yeSBwYXRocyB0byBib3V0DQpQYXRjaCBmYWlsZWQgYXQgMDAxMSBjZXBoOiBj
b252ZXJ0IFZGUyBpbm9kZSBhbmQgZGlyZWN0b3J5IHBhdGhzIHRvIGJvdXQNCmVycm9yOiBwYXRj
aCBmYWlsZWQ6IGZzL2NlcGgvZGlyLmM6NTQ2DQplcnJvcjogZnMvY2VwaC9kaXIuYzogcGF0Y2gg
ZG9lcyBub3QgYXBwbHkNCmhpbnQ6IFVzZSAnZ2l0IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoPWRp
ZmYnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoDQpoaW50OiBXaGVuIHlvdSBoYXZlIHJlc29sdmVk
IHRoaXMgcHJvYmxlbSwgcnVuICJnaXQgYW0gLS1jb250aW51ZSIuDQpoaW50OiBJZiB5b3UgcHJl
ZmVyIHRvIHNraXAgdGhpcyBwYXRjaCwgcnVuICJnaXQgYW0gLS1za2lwIiBpbnN0ZWFkLg0KaGlu
dDogVG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNoIGFuZCBzdG9wIHBhdGNoaW5nLCBydW4g
ImdpdCBhbSAtLWFib3J0Ii4NCmhpbnQ6IERpc2FibGUgdGhpcyBtZXNzYWdlIHdpdGggImdpdCBj
b25maWcgc2V0IGFkdmljZS5tZXJnZUNvbmZsaWN0IGZhbHNlIg0KDQpQcm9iYWJseSwgc29tZSBy
ZWNlbnQgcGF0Y2hlcyBpbiBjZXBoLWNsaWVudC90ZXN0aW5nIHByZXZlbnRzIGZyb20gY2xlYW4N
CmFwcGx5aW5nLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==
