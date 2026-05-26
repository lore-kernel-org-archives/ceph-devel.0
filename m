Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429283C13FE;
	Tue, 26 May 2026 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829058; cv=fail; b=RYInIRyXTTsHXJlqR7mOLxGjimCvbRq06mR2zdQG4lOiGuNYWtngSSn1ooi6dN7YqpkoPno47V9cIAepCAcA5i/d1QYs/M5WsSG1HxV2ylPksMr5WFfYDl+f8nNRYmaQUca3WyS6qQ8dGt4w1GSqnyGIc3Y2977Xd08uZ2rYX+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829058; c=relaxed/simple;
	bh=ztadpTqDNW4MgEyA8t4o6CKI3PrP6RfQJ2JKXFadRF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BYc2CPunjPVdVY++/95Zc2yAGBRNEGwpUYt+oKN6/3Zi2i9+3vIbbT30UzPu+L+f6FAaFbVmxLVeErfTDjbLlgh3iyF+PsVDvZyCtV5UDb0jKrqTth1SAXqrXijNzpmbjSu9JxNQ8FTq9FTr+yyPrbmiBjEi7afIdZOK1RE/kw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k5wV0vrJ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k5wV0vrJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QAF5Tx2120926;
	Tue, 26 May 2026 20:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ztadpTqDNW4MgEyA8t4o6CKI3PrP6RfQJ2JKXFadRF8=; b=k5wV0vrJ
	/ZWzpO/FdqGbcavCaelcIS8/DnuSmkMqybFwtWddS4sb+stl/aQvCNwjojTy6yJD
	oYBHw4kSjIb8ZrSCuuwysmLpNO/Tnx4wWO3LNvjpopLC0kSlRh9dUtzUuFIB3wde
	1ttldjbNGndbgexxLvgxGU7YtTqwgHGmLfBq463I3xp4xsku0ZZT9F/VZBBR8rRE
	HzfhZJ8l1ICKrxXWzq0dr92pzvOFxU4HCaA7EdrgewNrzish8LhNCh5t0hDActV3
	3s7Wh0rMVgFb47Xpq+r7ACMTiQ5UAD9BCgnViBE6iyrucUPnapbGyru9plxu3GjA
	29QyK0s/q0hIUg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdd77g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 20:57:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObCzasGqcye9SgVBS7oOqH7osG1qkBzu6Jx6XidQd29qeSETLahzbd4SRPrVySz6WwjkeB2zMePLPZP4QkWh4X/8/AGh75i64jnS4m5FwOfjYE5Pb+1G0IFepsFMmZCHW79LINAD8Z1Z52xghWBi8OyJfgfZPk6uhKCfmDx1L6aqAxD+OJcvkP7nMoYL3R3g/UzUG8uJLt7EEiWKf6zL/OGpcYw1YO2WPn5YZqL+edAqsPBnDvb68lc0uMhP3ROT/18Ju+FNa1zipNIvkxOQvakUp7wGJB1dctAnWPrvljJWT+fFIZY61rryc3QnkLMwTB/Y3TgC0ODlwQpNQtilOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztadpTqDNW4MgEyA8t4o6CKI3PrP6RfQJ2JKXFadRF8=;
 b=o77qClMQPrfAQYdkQX3KLkMIdyMWG2Btsc3yPfvY+ALTPEjkZQH+XjbhLMddBgNGr143Zr0ycsdGUVdnO/6B6Zd5kCNKDsz0hX73Rtm1dAbf+yMMxBXQHvVjzU6R7WdbRz7TyZCDo2jVP+tXveZvuL5I+0Wyx8W7NANqMEfhkrx8T56KAB61PUC6AU+vKnFXt2WQ5zXufspidisEjvWpGKX3/AWeGgfGOrMElv0V9cPv+L2QesFwCCeawwMzoD5LQjEn1cGzRJX1bZSNdZEr2M3So8I5Y8RLFJgF33Gf+RUNAHYRFANn38MtLOHTuCAdQSaVQtSiuklIaeoJHar/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB5520.namprd15.prod.outlook.com (2603:10b6:8:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 20:57:22 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 20:57:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>
CC: "jack@suse.cz" <jack@suse.cz>, "brauner@kernel.org" <brauner@kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        "neil@brown.name" <neil@brown.name>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>,
        "zhongling0719@126.com"
	<zhongling0719@126.com>
Subject: Re:  [PATCH] ceph: Fix ERR_PTR(0) in ceph_mkdir()
Thread-Topic: [PATCH] ceph: Fix ERR_PTR(0) in ceph_mkdir()
Thread-Index: AQHc7VI/kCqKsCSOwUq7h2dX4XX+0w==
Date: Tue, 26 May 2026 20:57:22 +0000
Message-ID: <4d3e957637bb27c6959c08fae2dce1690a6f1306.camel@ibm.com>
References: <20260520095428.69422-1-zenghongling@kylinos.cn>
			<d2cd070ded01305414815248032bbfc331c392ee.camel@ibm.com>
		 <20260520234153.7a89f0b1@pumpkin>
	 <5feb37e5f77d29d9a41f20df8ab1162fab7730a9.camel@ibm.com>
In-Reply-To: <5feb37e5f77d29d9a41f20df8ab1162fab7730a9.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB5520:EE_
x-ms-office365-filtering-correlation-id: 99fb61f0-adbd-41ed-7385-08debb69623f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|38070700021|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Xq0bGskBtzjKna5SD7WXlxyuGJFArF9Q0Gx7QOvT5HsDsTQsEKdrrvsU413LHyDmRxwCT508YuB7mUcMZ7+gRUgOCwEUTUegNuWi1FkN4Q9fX76GQIwFlMGhHles6vQ0K36We9yftwUJqV/rAf0m0Xl95hBgG5gjTaptafbWK8eZVg6+nmY9rYXKeNlNidfFfL+nML8MBJeP+W7gQNceiHVHjaqHt93O6hsWue6qgVYdHVjV7ouWUpI68J8yHFTj3o1t0Ypo5rzqXU0JXnWtsOULZ45bOApg8pDkHcsEsxDhoJwFLjYyDylcCFVlnDVfMhCTqF6TBTSKzzl0Xg2AU7EQj2eoEDZUMPv1koRB6fbmHTDEkdkpZOMZVCwsSRyRJBQF12QX3U43NWjb5rCIG1JYYJY8SRrUNiU5YKBLv1adveG7XsSgAfse9sBoIsdTKjtqoCVgzAkhBUUYjEe/XeCwrDr6Au6JH8GtGoq6aMXrwpyjCS1/fnR/BHJU1Vfc+1Z9UIOlziN+Lnn650qNxDty3tisMxsVoeFyEtE1UoRE7rA5klNiOF4KoBAs6wfn7n7QNtnrBWYiFPa+dNxMwdoj1+WClOU+Jktrekqu3DahuKoYnpEDNZPHXzL+M7L9dQETOrXAeZFawvL1oPoIn624SyIGT6tQfjmFMvyvWwN2IWOkOYxWWh8zCp4bG1zyIzJNmIvWNR0u0ZHg+YgX4LpkTUA6HpLA51xoc0IaaN/f9CoBt1qVaFYonnIerppb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkMxZUFqZzYzZVhnL25jaFplamZ3MENkS3JJbTN1UFJtVEtjM0lVSVBEdWJS?=
 =?utf-8?B?ZVlibzhML3JFSjJHNlJiTUZDNFU2am9uUi9LQUpHMDBOZmF1cDNFS1IzVTJt?=
 =?utf-8?B?VHpnb2RxZXB1RzNSQTRTVUZyd25VbzFQQjVUYXBaWVA4TlNHaG1QeWRhakJu?=
 =?utf-8?B?T2dTT3RWaXF6WjlTK0pUT2JEVFIzS01YR21HWnJSUHlrdnljb3pXTE1zTUVk?=
 =?utf-8?B?TjBkRmovaXF5clZwLzFJb0YwdStyblNlS053YjlMeVJsano1MTh1WjBESXJr?=
 =?utf-8?B?cUIxbmdqWVpmVkxMM3lSYlJnUDZHTThZREdxamdTSTV4U2RONE8zL2piOW1W?=
 =?utf-8?B?eFByU1ZpM3VnOTh4ZlhpNmJ5alJEUFdnclF0NVFEMlNJNG52U3M2cjZyK01E?=
 =?utf-8?B?SXVLUlJTUS9tSTRlZjhUSzJlVy92UG5SMVFOczFzc25jQnMyVUY3VDJRWjNG?=
 =?utf-8?B?WHJmeU9RYkNZRFRwVmEzeGllMlpWNzEwcGFtbzdkekpFTTZBbVNkZ3FWcUk3?=
 =?utf-8?B?Zms0c2pnUjA2alNrVVFFaG5SeHJQRXJxTE1xSHo1WVJKektzUnRQWU12R0hw?=
 =?utf-8?B?TzdIeFFqSzRJNnFTZ003bUNRYitPd2pyT1U0OHR6N0xKU3JJeWsxUCs5eWJs?=
 =?utf-8?B?Z2xQbXdRK3RnMXJqMDdERXBReklNSVF0YjFZL3ZKcTBlU25DaXFWSGk3NjZ1?=
 =?utf-8?B?T2hGN1Fya3FBcEJpaWFYbUE0Nk5idzIyY08yUzcxU3FjeHU1ZWV6Q29tVlBK?=
 =?utf-8?B?bXBpVHJwelczNlN0ZFU5Qkh1VHVOLy9iQVdWT3VYenBtQlhhSXpncEo3Ym1J?=
 =?utf-8?B?eDcrVENTL1VHN0J4OXA1K1JONkJLbzVlQTV2M3JQV21aRmRhNTN4TmdpYTQy?=
 =?utf-8?B?R1Y3UjYza1pRZmM3UFhNQWtZZno1UUpGRmVxWTllWmg2cXMvNlVIVmpVSHQz?=
 =?utf-8?B?YjQ5cFN0Um90MHMzbk5YcnJhVDRJbEVDK3Y2YzQyWmpGV1hndjlCckNpTyt1?=
 =?utf-8?B?VnJadGFNVEtyRnE2T2w0d3JsWTlZQUdwUnJXY0Z1QmZqcUZYc2QybUpQeGcx?=
 =?utf-8?B?WGZQR3lOQzg2RE9SYXlqMEEyaTFDV2NVNC9GMGlkYnB5M1FrbFZna3VMTm9l?=
 =?utf-8?B?OUQwa3RrMmtWZFE1T21uZXc2Z24zc0d6TGVwQzlNcE9sc3JvQ1JvK1kydHFq?=
 =?utf-8?B?K2hkZTF4aER6MW9nM0NkMXNVbkJZNXZYMi8xZ2tvMGJjekk1d3lwNCs1VGU2?=
 =?utf-8?B?UGR4OUFoWUFOcjRDMFZxelhOcFpNYmkwWm44VjVxT2hNekV6SnpQM2NkK2R2?=
 =?utf-8?B?VnRGSWozRHlqWXROa3I1amVCZEZBTWk4UDNLeG1haE1WRHczVzBtR3h2N3ho?=
 =?utf-8?B?NnZOMDJPc1U1UVlGMG9TZ1R5UlgzelBKVTBWTjFlcVRzSXVDWGlaNXpSNFBH?=
 =?utf-8?B?TllzcVFCUWNqbnlVU2tVNGphVVB4RkV1Y3NsVENjbnlKS1EwSFM1Qnp2MU04?=
 =?utf-8?B?bzJUSktrVTYxVnRXaTMwMUlKOTJuQUUzWGNMajlOZk1EQktieWY2cWdFV3JL?=
 =?utf-8?B?eWlKaHpPaTVwOWVEUHRnZktXMmdsMXFuc2xsV3VicXMzWEo1N24rd2lUOXAy?=
 =?utf-8?B?dUxFMXdOTkI5VHBPK0d0aXF3ajAxSTA2WmlJelRPK2pNYm9QaTVnbEc5WWN1?=
 =?utf-8?B?ZUlCSGJmMXovZTM1dE9RQmMvREJkQ1o4MkJkRXBkOWJLeFVBSHB0TFMzMWFF?=
 =?utf-8?B?Z3MyWWlpVjRhcFNVTG5MSlpXdzUzQlBPNXRZNG5QNVF3OGEvSytCVUVXSTRV?=
 =?utf-8?B?UnVFLzY4WlR1dm5UaGt0cVIrRzlNd2ZKT0NRWnFBUGhXTUxXa3UyRW1Jd2xm?=
 =?utf-8?B?MnhJcGNzQVVlQTk5b2Rqek5zSzhaeEZyK0oxQk85bHpyTGxyV0RsS1pTbnNM?=
 =?utf-8?B?Q0RqaEtUTWpia1k0SlhEMTBtc3JGYlo5SWZ4d00xamZteFdYdVZLY2RYSFkr?=
 =?utf-8?B?UE92Z1NhVTJQVjVZMDArbzRIY21YOG00MStKaDI5WWtVWlF0a2VTNk5rbnQ1?=
 =?utf-8?B?QVFvb0t1M0FQakd6UkkvTWozMUlrVldpV3czOCtHeGRFaExxRVY0b3c0SWhW?=
 =?utf-8?B?bkd0Q3ZPZmNWYzkxbjNPVFFIaS9sVXR3Znl2c0FERjJHbVg5NzU3Q3pLeW1i?=
 =?utf-8?B?c3FpU3UxNjB6cFJ2aXczeHM1NDl0cWROQ25Kdi9jVzZjRENlbVFFVGN0YW1Q?=
 =?utf-8?B?SjVLOVBndFJMT2ZjUC9hcS9kbEd0RWwyR1k5YjlUNUFQTDdCbER6NlV0TC9i?=
 =?utf-8?B?WEY1NUFkemsyL0VFc3g1cm1HSExKd1llYXRhWGxHYzZXQWJjNWwwQzZjVVI5?=
 =?utf-8?Q?yuh2thXeISO2ZDpL6BQbgXOuUePSSizaOBZ9J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEC209475CB42F43A455C7402AA99604@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GXInHrjzBkQo+WQuhKDG4pyPaV+P9E00xTbBuMqtQl7MYTM6wX81LKdrW6n6N4hzy+GQ+6oSAqwRDBCr9cHed+aX7gOpAZFwc+riyOUlm9OnlDy/Wxn8cPQDkEc0c6qbJDv77mNQ349+dpuII3e5Z3sh3cug3cqL3y/dTNbk8i1Dibl3OggAe63GA3Ht7YJbT6/5fVQ/ehKovMm2f24qjy5Ai6rdRgxvqLbWWyt2i/k+QJYQd33rukW0dNz0OGGIlLnt2LoW163r1RshjxDCPZNrdeGVWJz40JhGiIkJBWaOsLbAd1+aext1xeK3+40MLyG+sLFG9GyxXJQNpeMn+g==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fb61f0-adbd-41ed-7385-08debb69623f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 20:57:22.7100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCBKNIekuQI5Im39lHCbuxyXepaKAPhbF4er1ueOF+eDyIJywbBjIPpldROayjDsi9KXYIZP/UEGLKabk+vuBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5520
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a160936 cx=c_pps
 a=jY48VJWlCesAGUsWasdw0A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=v58Y35vW0u9X7un8fhUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 74vxiSP8SD6ilTPkoj9U8GuzKuWXecks
X-Proofpoint-ORIG-GUID: B-jPSfdhIYbkh4kqbx8vxuO2RJr6KiPE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE4MiBTYWx0ZWRfXw102WXApvocj
 Akmlbv+BBPO3nbn7hKCIkwVO9kkiEFQMa42LH49Ok7KiGZavVdVPTyEJraiaeD87iT4ZpCMQP7J
 514TgC4knMF2FqOdTedfzpYWBpAi3WRd0TzHltM9dzBUcj3RQgsS7Qfn83ZX7OmfjdePqZPWl5A
 9Ag94OTOSx0wLAV//uoT14nEN7wgZskFqzYX/1Lg13WsNIutz6sDpu6VyavJfGjFgJVj3ZnP0cC
 s+2oQKusbMBCwNnw9Ge9UtfgeZcB7IaC+L7P7xsamYh2dxeL65qclodaO5aA47LmdEKc972LxB7
 XmqumLJs7DTklx0GvKwfUj6eAGSNmKrNssJ/UZr13kKGlR69w7lb21hXLEuY+kljCfl5RjTKQeR
 nkT64OMRdKNLLFeQtg3hSQnr/jpajnZZb0iknjn8xg8LQmljbr6I4epDTadYximXZ/yexv8tDnJ
 MquRLkFJa+j8EU9s7zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260182

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDIyOjQ1ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFdlZCwgMjAyNi0wNS0yMCBhdCAyMzo0MSArMDEwMCwgRGF2aWQgTGFpZ2h0IHdy
b3RlOg0KPiA+IE9uIFdlZCwgMjAgTWF5IDIwMjYgMTg6NDk6MTggKzAwMDANCj4gPiBWaWFjaGVz
bGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBP
biBXZWQsIDIwMjYtMDUtMjAgYXQgMTc6NTQgKzA4MDAsIEhvbmdsaW5nIFplbmcgd3JvdGU6DQo+
ID4gPiA+IFdoZW4gbWtkaXIgc3VjY2VlZHMsIGNlcGhfbWtkaXIoKSBzZXRzIHJldCB0byBFUlJf
UFRSKDApIHdoaWNoIGlzDQo+ID4gPiA+IGluY29ycmVjdC4gSXQgc2hvdWxkIHJldHVybiBOVUxM
IGluc3RlYWQgZm9yIHN1Y2Nlc3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXhlczogODhkNWJhZjY5
MDgyICgiQ2hhbmdlIGlub2RlX29wZXJhdGlvbnMubWtkaXIgdG8gcmV0dXJuIHN0cnVjdCBkZW50
cnkgKiIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhvbmdsaW5nIFplbmcgPHplbmdob25nbGlu
Z0BreWxpbm9zLmNuPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGZzL2NlcGgvZGlyLmMgfCAyICst
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2Rpci5jIGIvZnMvY2VwaC9k
aXIuYw0KPiA+ID4gPiBpbmRleCBiYWM5Y2ZiNmI5ODIuLmFiN2Y3YjcwMTZjNiAxMDA2NDQNCj4g
PiA+ID4gLS0tIGEvZnMvY2VwaC9kaXIuYw0KPiA+ID4gPiArKysgYi9mcy9jZXBoL2Rpci5jDQo+
ID4gPiA+IEBAIC0xMTY3LDcgKzExNjcsNyBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqY2VwaF9t
a2RpcihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsDQo+ID4gPiA+
ICAJICAgICFyZXEtPnJfcmVwbHlfaW5mby5oZWFkLT5pc190YXJnZXQgJiYNCj4gPiA+ID4gIAkg
ICAgIXJlcS0+cl9yZXBseV9pbmZvLmhlYWQtPmlzX2RlbnRyeSkNCj4gPiA+ID4gIAkJZXJyID0g
Y2VwaF9oYW5kbGVfbm90cmFjZV9jcmVhdGUoZGlyLCBkZW50cnkpOw0KPiA+ID4gPiAtCXJldCA9
IEVSUl9QVFIoZXJyKTsNCj4gPiA+ID4gKwlyZXQgPSBlcnIgPyBFUlJfUFRSKGVycikgOiBOVUxM
Ow0KPiA+ID4gPiAgb3V0X3JlcToNCj4gPiA+ID4gIAlpZiAoIUlTX0VSUihyZXQpICYmIHJlcS0+
cl9kZW50cnkgIT0gZGVudHJ5KQ0KPiA+ID4gPiAgCQkvKiBTb21lIG90aGVyIGRlbnRyeSB3YXMg
c3BsaWNlZCBpbiAqLyAgDQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgdGhhdCB0aGlzIG1vZGlmaWNh
dGlvbiBkb2Vzbid0IG1ha2Ugc2Vuc2UuIFRoZSBFUlJfUFRSKDApIHJldHVybnMgTlVMTCwNCj4g
PiA+IGFzIGZhciBhcyBJIGNhbiB1bmRlcnN0YW5kLg0KPiA+ID4gDQo+ID4gPiAgIHN0YXRpYyBp
bmxpbmUgdm9pZCAqIF9fbXVzdF9jaGVjayBFUlJfUFRSKGxvbmcgZXJyb3IpDQo+ID4gPiAgIHsN
Cj4gPiA+ICAgICAgIHJldHVybiAodm9pZCAqKSBlcnJvcjsNCj4gPiA+ICAgfQ0KPiA+ID4gDQo+
ID4gPiBFUlJfUFRSKDApIGV2YWx1YXRlcyB0byAodm9pZCAqKTAsIHdoaWNoIGlzIGV4YWN0bHkg
TlVMTC4NCj4gPiANCj4gPiBJbiBwcmFjdGlzZSB5ZXMsIHRlY2huaWNhbGx5IG5vLg0KPiA+IE5V
TEwgaXMgYW4gJ2ludGVnZXIgY29uc3RhbnQgZXhwcmVzc2lvbiB3aXRoIHZhbHVlIDAnIGNhc3Qg
dG8gJ3ZvaWQgKicuDQo+ID4gRVJSX1BUUigwKSB3aWxsIGJlIHRoZSAnYWxsIHplcm8nIGJpdCBw
YXR0ZXJuLCBOVUxMIGlzIGFuIGltcGxlbWVudGF0aW9uDQo+ID4gZGVmaW5lZCBiaXQgcGF0dGVy
bi4NCj4gPiBTbyAnKHZvaWQgKikoMSAtIDEpJyBpcyBOVUxMIGJ1dCAnKHZvaWQgKikoeCA9IDAp
JyBpc24ndC4NCj4gPiANCj4gPiBCdXQgSSB0aGluayBzcGFyc2UoKSBpcyB0cnlpbmcgdG8gc3Rv
cCB5b3UgY29udmVydGluZyBhIE5VTEwNCj4gPiBwb2ludGVyIGludG8gJ3N1Y2Nlc3MnIHdoZW4g
ZmFpbHVyZSB0byAnYWxsb2NhdGUvZmluZCcgc29tZXRoaW5nDQo+ID4gd291bGQgbm9ybWFsbHkg
YmUgYW4gZXJyb3IuDQo+ID4gDQo+ID4gDQo+IA0KPiBTbywgZG8geW91IHRoaW5rIHRoYXQgdGhp
cyBwYXRjaCBtYWtlcyBzZW5zZT8gSSBjb3VsZCBiZSB3cm9uZyB3aXRoIG15DQo+IGNvbmNsdXNp
b24uIDopDQo+IA0KPiANCg0KSSB0aGluayB3ZSBjYW4gYWNjZXB0IHRoZSBwYXRjaC4NCg0KUmV2
aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpU
aGFua3MsDQpTbGF2YS4NCg==
