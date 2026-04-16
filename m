Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4934B1B4;
	Thu, 16 Apr 2026 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365864; cv=fail; b=sZ755hmLg/0CTOB1OFiIwd0QR52f5RLN8mRkRNEiU4kKywBA9ZSYgQ81xgmi3xeTnyQ+SwVx2PAU4KeezPOGCRG1fEoWuJQKXTIz7O5c8HtC3qPOE2ZK6njARHh182+qXg0VKGMC3Gu5Ad2hNJrR4BmGfp+X+Raam7IPFRZAdlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365864; c=relaxed/simple;
	bh=/cgp0yV8HnmZauH0cQJfc2i55qp0oQ9W2dQDSaK8+CE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=fMp7RAFugrL2hWSBMMUBDJcOzeKPKavJZB6Dr/khhB0Go3V3nxHQ+kAT00FKW7nzbdBUOvHMjv5/l6qbx+s7QxGZRMQh6uZ/olTu3fI+PA1inN23cdbngZxEvha5/2QkPmIex6Hsuf5F/p0GP/tQvBIsV8EQvtf+vvUmYXzVqEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S0SX/C/+; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S0SX/C/+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G7LFYC1833234;
	Thu, 16 Apr 2026 18:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=/cgp0yV8HnmZauH0cQJfc2i55qp0oQ9W2dQDSaK8+CE=; b=S0SX/C/+
	D1+GHsuaFLeIA1BdZXBl40fWK4wzoEvDf8+h3YyXxVe5sJ/LbKx5mkVFTPQwvUil
	qN+jZDfeK7lEGkXimUQ8m8ceADw6wKpp6+zEuIPsXuCeHpBPeQmz56ORGjwEGt6D
	ikHF1Tct2eWowzL48e36Mj+ZL+UjXEr/HH/Ap81wbYB0wrVT+PXn1CDgcrlLT33g
	y1I5P+PpZkCHPp4FIPTQaXUqPwxWpzvmOsvxKMsjdOt/wFX7P0vZuOm4TDOvTVjj
	RO7+NKYlsltkw6Mu48COuk3He+dNLHAasb4mrmwMTGvG35EKhSkDouwf8JlfmmHv
	ffP8/6Nk9fvnCA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rq4fc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 18:57:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBfmJ6gg2GmXwkQ4+x2xSlD9Iv09miLYptSltLUho6dvPCaKCVZwFFRhndK0VokB8a7UVSV3nwr+5FTIAS9fkJ+dH30vaYsVf9UiUYnAhxd6ZS+sHQ6fupraecHxD6edqm41LAs7gIkNOldLdeYX08l0LH5XGEG+3ke3iPU+EZgYsCAfvpCcE2KURelO335GDge8NAG9DpA8djtOz4lmTbRzfxDWsUvk0zkClrnvFJDBd8DHh+kaSE8pHWVxwdWje+XazMHGCYGsbiB22325BUdzbf0HwlLbsM81P/6RYczDyTThEbmz7YKMuqyZDEEmF6XjuVLxm3cvGUz5+EBZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cgp0yV8HnmZauH0cQJfc2i55qp0oQ9W2dQDSaK8+CE=;
 b=vRfx0Q+ibM8Y1vK+E3oSZcEE9cbsPaQ5RI0aGqvEUVsM2r1HOVAupjY8ZlTi/ZZdOZ/1TZL6xkhvPYbhFeCeFVQUw5IzkIOdtUSucdEk0Wc7jLZ9YpuXpJwX/pN2bgL6iut5HR4TarLnfl2dEvYWSkNd35TbgDq/b3P5tL2Wcq8G+UvFF9qvbyuSwQJix0U98WvgZ5Uoyrf75tyvpJgKJqjYVG4RaRpPZlIh+E+5se9U8wHocIgwSyUFvNNs9QY1Hrz3geoQTME1D4lXTSBoNDNcLixJaoXLt2bhHCep28GJA9v1nq1pLZyNoS2x2DdCCHgOkHb0y09zDnXu4AfVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4534.namprd15.prod.outlook.com (2603:10b6:a03:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 18:57:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 18:57:36 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "cfsworks@gmail.com" <cfsworks@gmail.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC/BUG] Use a bounce buffer for mds client
 decryption
Thread-Index: AQHczRFCXnoVJP6Q6U6qvBG+s9W0DLXiC6OA
Date: Thu, 16 Apr 2026 18:57:36 +0000
Message-ID: <18a64f2f10e0764e887369e7a22392e44bc4c5e2.camel@ibm.com>
References: <20260415034020.11530-1-CFSworks@gmail.com>
		 <c18a6e57671d339a179202a077130ebf1686f1ff.camel@ibm.com>
	 <CAH5Ym4ga7miUQE0K-cJA93Ya7w62P69MAN27R5cBiYnudoOHdA@mail.gmail.com>
In-Reply-To:
 <CAH5Ym4ga7miUQE0K-cJA93Ya7w62P69MAN27R5cBiYnudoOHdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4534:EE_
x-ms-office365-filtering-correlation-id: cd398d0d-f421-483e-acab-08de9bea0665
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 zc08gn3Vp4nD3ZoaaR47b8lbuZXQBNXjD9Qe9Dln4tt+HI9YiPT3BjGAI7hQ2LlgHLY0yE4lytpZSSVypMbsV+jU+uSPFX8efZPeR93ST2spkBd83Ab9fVfOvVSWfjDwjoMQXSJfoXX3BfmATjt4mwySQfHOQdmb40MS6ePTq9kBuZP+Y4hP1VoT6/mPQKJ9CLbKb8Ocd0q6aOjK5wOxUmWTj0zzSyZt+3d1iW7I98uDiYyqKGBu3R+gwZeHT2HvG11djcMeE7uE7iR0jyL7v+iZCvVRf/+M/Kq93q10Clg1gBu3Su/fN1T+5r6YZct/g0QxEF7rgqbnSGfATkFo/hkDj3btmMKc6WpD0qs3y/2s3lJuONf3xmGMGPhD+wqnW0xanWSRqUiJ26QCW8CrmhI8JmuW8Wc606cqqb1ol6AH8vDqE8Atc4Hv5UE7ktJ2ybyqVXaBlNwvWWgJKJORTRF7d4ObkSy2WZQ8haC/G4Z5ZgALRb/M2F++iGpW2jbT3qVlSe6lWcJYpQzgO44wsAa4PLWb/W8jeoSTfnHCx419GaltK3Ou+CG+V/qsf1DlibYoMZQ5vSFn55PnrxULHpFVhBVLlombgY5D8NF74paH2V6+Z7Uxg2WLOyapbjJjs9EBYsxXRnEXeHm1D4YAfNsmxQWsEqhlD7uVkbdSrblEuMHnZQ/5WoeDt92DIVwqtvq6TWWwqXjz5gbTe1mQyxrl247NRDSukHXN0EWbosQfkryojQfscISlxswa+Mv99gQRGOofDCv54IRBbKMKOEXL0xz65q9neBL2+nyw1cQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW9DcnRmNWIxd3U3TXdIR0d4SmQ3UGp1Vk82Q01EVzFhREFDaDRweU1jQVc0?=
 =?utf-8?B?V3R4c095Z1JNL1c1YlhhMVNHZWhWelBsUWtIaUVmSU1aRVQ1eFpyYkVDZnZO?=
 =?utf-8?B?OEFRN2lyYzFjaWtwb09idXpBazZsUnFJcGVFMXFUc2dUYXRUV2g1SVFHTmoz?=
 =?utf-8?B?MW93OWZkdkRiTmVUNEZlY3pRMDdGS2FGODIwdlM1YWFsWlFuN1dOd2FERi8r?=
 =?utf-8?B?Yng1S0NZek54cUI4ZlJxYmR0YkRmamZBK1NQSENtOXJPUkZyUkR1aWV2T3lv?=
 =?utf-8?B?d1BYTTVhNVdvQ1BHc1E1K29reittNUcrUWd5dHBvTjJzVzhtOUJ0RUsrdnZn?=
 =?utf-8?B?eVZMWm5WYWdib0p3VkNvemFtMUdjL0krMEthcVllcFI3VytvS3RVYjFldlc4?=
 =?utf-8?B?MSt2dlB2OWRKS01QS2JoVkMwdllwRTVYa1E2bUN5QVBsbytGT0lOdnRHeWJr?=
 =?utf-8?B?dW4yM2NyeUYvTVhxdzZXVlFISXBDWGRURmdOcGl4bjFwMEMvT0k1dUFCTWN5?=
 =?utf-8?B?L0RlS1UvQTRDK0NYd1EwdjZQNnh2NVYxSnF3eDBnQnZBYkp2bkFMR05YNitm?=
 =?utf-8?B?MTNuYmd0K3BqSmlGTzFSdUpKKzRwTHc5S0ZiY3lCMmF2UGU3d3UwN3VacWJ3?=
 =?utf-8?B?NkVwWWlMcUxZTFY0NHNkclp0MERJczAwdHFXZEpRS0xtZnBkL2NOcHNZcXA0?=
 =?utf-8?B?N29XcjloK0lGQmZSRTAzRkdhUjY3SXE0WEFzYUhpSUNUd2hMcXBndHVYTWh5?=
 =?utf-8?B?MEdLc1FmckorUXordTBYcGdXdlVJa2VFUjJoMWZpN0RiY1p2dlczWmJPOGRp?=
 =?utf-8?B?NVhjZ1EzL0hJcG1FbEs0QTJGdGZIdkoxR3FUZ29qMm1IT3lwZGxQZ2V0MUhz?=
 =?utf-8?B?VWxCU1R2dFVXT1ZRT0ZhQ1krUTFLd3Q4WGlYZjZIb1BXUWlQVHFhZTZQcEht?=
 =?utf-8?B?NEVmTDJyUnpiTTZobnQrNHdnUjRhYm5WRU5rN3JwenBmaitpaHpMODJCa1pJ?=
 =?utf-8?B?MFlFLzVLSWZmenZQbGk2dEFUeCtYV0hzVnJpeE54T2NkMDIwSktTYjNoMysv?=
 =?utf-8?B?dGhlUU90ZlNmSzI4a0RwVFUzeitraXpDekdvRjdWbU5IbUdQODFEaEptajVD?=
 =?utf-8?B?YVQ0dVpwc01tWU1PczdETHpScDlDQnFRTFhJUlNnUWdVbUlQUG9VZFhHNHNm?=
 =?utf-8?B?U3ZyTEgxbnFaNldOelM5SlJSdExHWklEN25EMEpOV2txSVhKSzl1YTRuZFg4?=
 =?utf-8?B?UCtWWmdTcnR4bGkxV2E4bERrbmNNbFBNT3dORnpya3JMcWhpYy9OUFdJWFov?=
 =?utf-8?B?NHhURElnck4yRGdaYURmdHF1cUdFSVgxZzhqR0dRQUNBeFFYR2R3WTdzSHFT?=
 =?utf-8?B?VUtkYlUwYkFocnlqRGZhaFdEdmRtQ0ZuYWJuMzVCbUlNWjl1dW01aHFLM0xi?=
 =?utf-8?B?dnRQcmRTQ2lOMmtEL3F3aTFQaU5kNTErc0IyeldyL2NYMTl0U1JOVjdWeVRM?=
 =?utf-8?B?ajIya3JpUHV1d3MzbGNiSkVVR2VZeUlUczFhSUZFN2ZqUldoUis0Qk02aGtz?=
 =?utf-8?B?b2tpbzl1dnJydjhSSHFwdDV6RnY3dldBcXk5RWZBM2Ewd2RNOGZrb3BQODZx?=
 =?utf-8?B?L0prWEp4RUhnZWV1WmVBd2tCVGtYS1o4cmtTK2tROWptNE1MK1BlZFpZL2x0?=
 =?utf-8?B?MXgyaGxGR2lURWZ2cnplUVA2VFJjbE9nWDJOZkFPVndsRStqajRWWlRIYWRO?=
 =?utf-8?B?RnkyRXVTdVBDQnRVd3pKczVPZmViYmM4WFFYbFlVeUM1bkFvR2JtTXVCQXVh?=
 =?utf-8?B?RHMvTUZjRzdTN2cycFJqamh1bC9STWp2WDgxYmZwMmlMRFlPSTFqTXdKeGFQ?=
 =?utf-8?B?M0xyMmFJemtNUnQzRGY3TnlFbVdoSm80MEpiZUtYRkJ6MGc5ekh4cEJIZHVC?=
 =?utf-8?B?RXZZa3BZcmxqREk2Z3BQZWlUZjg5UnV1Q3orRU1WK3U5eHc3VVViTWl0ZHY4?=
 =?utf-8?B?M0V1d3BZNXZmWjk5Wms2eU03R1lyelpRVVpQcDlNTGRrZ2JtZ0cwVDVyd3I0?=
 =?utf-8?B?R1BqbXVMcWs3dzkwaTRuV2hGaUNIcytnTHZQbUlhNm1odm1VSWtYU3VCd21a?=
 =?utf-8?B?bmZtNGV6bTJGWjF2cmdCNjBFcWtoUC9hYlo2VE55aG9EQTNoY0ZTYktWcGJs?=
 =?utf-8?B?NGtrbVdoZHgvM1JoMnBTb3hleElYeXNGOFpsejVHR3lRNUpTUEJkdk1qNk1y?=
 =?utf-8?B?UTZGK2Z4ZzVFbW52cGFja1IvamJnYlJxWnNDTk5KSnNrYVV4Q2VTN2xBZU1E?=
 =?utf-8?B?L0ZzL1gvY3RKdDJIWS9rT1dGQjIxeEJFdjJCcytxNyttbk9sRXhJQWI5bFJM?=
 =?utf-8?Q?g5CH6N9vAYwhZx/DOggNa30UPqZTJDD2rhLYr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9951E5DDB4E594D991E93882D069D1E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vTYWo7vWvrsxnDz4gQBlWxwJIIuhooWl3iTPI3AK0LydD4/g+Q8/nx/MkmAKa+MXHKMznwk7yXetmdREW1iuD9r6XjoDj5jrl6E85a9dSU9T9ZAt/5hb161xROYRe75zUjzdUJVp1Ka2vRhk25F/N+9BZEekEWMFGMLdTUUW7M3DR+zKbUa4A9j/k8D9ZF7PvBBpjyJv4qfNYh3e1EOc/3xrTdvFAicJgI757J3UEqZc6pGV7LlrOWRTNy1jmw/6d68KldgiV0S1swAlL/8BgJsLqijAsBM5qjwwrpFPwemkpA9TEkRWypjRivzYcAxfPdt6bxcLh70KfDXiy7LVog==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd398d0d-f421-483e-acab-08de9bea0665
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 18:57:36.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBhoCD1C9IWh0uufM6l1msVJvzR5IJSZu5s/O9MBu8/+a6SnJ877fCWlVSwQip3J3dDb9dgKh6VlAbQYy7sZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4534
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE3OSBTYWx0ZWRfXy4iaJjqrGeNs
 /Iv7JEJYSBlsqRcPXsndlrXDnHRNIH3czpd+/7/wJ9oTHXWYRKV39j7deUqH9SqFbpEz4QfLngI
 xC3BmSoDXOAoq2cKz2lZpl5bgmABWTZrMf3LYlivD3O3JhNP13/H57C9WlfQ5PlOE+oSSXuFEye
 VnrWPac7keROg4QiThKOE//BXYStcL4rWj9dIB1v/hhAZf7UGgXZoqYcZ8HH4c7P/kYxyR5FAU5
 u00kFjLi+C9y4Zwt0zfZNpZimJJenrA1eHjIFm3xhiN37Q37CHfpAcJzv6xZsO9TBEwzXoB4Kis
 93eNEzVZqYvqFGruJ5Tlrun5l7NxVf3ZYfXp9hT84spHPNHSFoGgtm3eM73Pd2sXOSfk9NidWjy
 OZ422IDRwq+hx7Wlnt5irC5glJAJn5UfKWyRkuAyED8S7OrvWUbGVDEer+odgVOBWMeBJyhjBwu
 X7uM3LKHzwK7GF5pcOw==
X-Proofpoint-ORIG-GUID: w1lpxHuBcfF6AwrUr_WvFSEG-I3TelHz
X-Proofpoint-GUID: qctMGX2UexxdY_6Rn5Ti5P8Ha9ENS5IA
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e13124 cx=c_pps
 a=ir2fm1PSN58pTRYNFrLYRQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=tGtDFP918CJG98U3LQAA:9
 a=QEXdDO2ut3YA:10
Subject: RE: [RFC/BUG] Use a bounce buffer for mds client decryption
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160179

T24gV2VkLCAyMDI2LTA0LTE1IGF0IDEyOjUxIC0wNzAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4g
T24gV2VkLCBBcHIgMTUsIDIwMjYgYXQgMTI6MTTigK9QTSBWaWFjaGVzbGF2IER1YmV5a28NCj4g
PFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDI2LTA0
LTE0IGF0IDIwOjQwIC0wNzAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4gPiA+IEhpIENlcGggbGlz
dCwNCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyBhIGNvbWJpbmF0aW9uIFJGQyBhbmQgYnVnIHJlcG9y
dC4gSSdtIGhvbGRpbmcgb2ZmIGNsZWFuaW5nIHVwIHRoZSBwYXRjaA0KPiA+ID4gdW50aWwgSSBn
ZXQgY29uZmlybWF0aW9uIHRoYXQgdGhpcyBpcyB0aGUgcmlnaHQgYXBwcm9hY2guIFRoZXJlIGFy
ZSBzb21lIGVkZ2UNCj4gPiA+IGNhc2VzIHN0ZW1taW5nIGZyb20gY29tcGxleGl0aWVzIGluIGNl
cGhfZm5hbWVfdG9fdXNyKCksIG1ha2luZyB0aGlzIHBhdGNoIGludG8NCj4gPiA+IG1vcmUgb2Yg
YSBzaG90Z3VuIGJ1Z2ZpeCB0aGFuIEknZCBsaWtlLg0KPiA+ID4gDQo+IA0KPiBHb29kIGRheSBT
bGF2YSwNCj4gDQo+ID4gPiBJIGhhdmUgdGhvcm91Z2hseSB0ZXN0ZWQgdGhpcyBwYXRjaDoNCj4g
PiA+IA0KPiA+IA0KPiA+IEV2ZW4gcmVhbGx5IGdvb2QgdGVzdGluZyBjYW5ub3QgZ3VhcmFudGVl
IGZyb20gcG90ZW50aWFsIGJ1Z3MuIDopIEhhdmUgeW91IHJ1bg0KPiA+IHhmc3RzdGVzL2ZzdGVz
dHMgcmVncmVzc2lvbiB0ZXN0aW5nIHN1aXRlIGZvciB0aGUgcGF0Y2g/IFdpdGhvdXQgdGhpcyBy
dW4geW91DQo+ID4gY2Fubm90IHNheSB0aGF0IHlvdSB0ZXN0ZWQgeW91ciBwYXRjaCBnb29kIGVu
b3VnaC4gOikNCj4gDQo+IE5vdCB0aGUga2luZCBvZiB0ZXN0aW5nIEkgbWVhbnQ6IHRoZSBuZXh0
IHBhcmFncmFwaCBkZXNjcmliZXMgdGhvcm91Z2gNCj4gKnNvYWsqIHRlc3RpbmcuIFNpbmNlIHRo
aXMgaXMgb25seSBhbiBSRkMgKGxhY2tpbmcgbXkgU2lnbmVkLW9mZi1ieQ0KPiBhbmQgdGhlIHVz
dWFsIFFBIHRoYXQgaXQgaW1wbGllcyksIEknbSBjbGFyaWZ5aW5nIHRoYXQgSSBoYXZlIGF0IGxl
YXN0DQo+IG1hZGUgdGhlIGJ1ZyBnbyBhd2F5LiBJIGRvIG5vdCBwcm9taXNlIGFuIGFic2VuY2Ug
b2YgcmVncmVzc2lvbnMuDQo+IA0KPiA+ID4gSW4gbXkgbGl2ZSAoQUFyY2g2NCkgZW52aXJvbm1l
bnQsIGNlcnRhaW4NCj4gPiA+IHdvcmtsb2FkcyB3b3VsZCB0cmlnZ2VyIHRoaXMgcGFydGljdWxh
ciBvb3BzLT5wYW5pYyAzLTUgdGltZXMgcGVyIGRheS4gU2luY2UgSQ0KPiA+ID4gYXBwbGllZCB0
aGlzIHBhdGNoIH4yIHdlZWtzIGFnbywgSSBnZXQgbm8gZnVydGhlciBwYW5pY3MuIEkgZG8gbm90
IHRoaW5rIG15IE1EUw0KPiA+ID4gY29udGFpbnMgYW55IGJhc2U2NC1vbmx5IGRlbnRyaWVzLCBo
b3dldmVyLg0KPiA+ID4gDQo+ID4gPiAtLS0NCj4gPiA+ICBmcy9jZXBoL21kc19jbGllbnQuYyB8
IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZnMvY2VwaC9tZHNfY2xpZW50LmMgYi9mcy9jZXBoL21kc19jbGllbnQuYw0KPiA+ID4g
aW5kZXggYjE3NDYyNzNmMTg2Li5hNTgzMDMyYzAwNDEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9j
ZXBoL21kc19jbGllbnQuYw0KPiA+ID4gKysrIGIvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4gPiA+
IEBAIC00MTQsNiArNDE0LDkgQEAgc3RhdGljIGludCBwYXJzZV9yZXBseV9pbmZvX3JlYWRkaXIo
dm9pZCAqKnAsIHZvaWQgKmVuZCwNCj4gPiA+ICB7DQo+ID4gPiAgICAgICBzdHJ1Y3QgY2VwaF9t
ZHNfcmVwbHlfaW5mb19wYXJzZWQgKmluZm8gPSAmcmVxLT5yX3JlcGx5X2luZm87DQo+ID4gPiAg
ICAgICBzdHJ1Y3QgY2VwaF9jbGllbnQgKmNsID0gcmVxLT5yX21kc2MtPmZzYy0+Y2xpZW50Ow0K
PiA+ID4gKyAgICAgc3RydWN0IGZzY3J5cHRfc3RyIGJuYW1lID0gRlNUUl9JTklUKE5VTEwsIDAp
Ow0KPiA+IA0KPiA+IERvIHdlIHJlYWxseSBuZWVkIHRvIGludHJvZHVjZSBhbm90aGVyIGJuYW1l
IHZhcmlhYmxlPyBDb3VsZCB3ZSB1c2Ugb25hbWUgZm9yDQo+ID4gdGhlIGJ1ZmZlcj8NCj4gDQo+
IE5BSzogY2VwaF9mbmFtZV90b191c3IoKSByZWRpcmVjdHMgb25hbWUubmFtZSB1bmRlciBjZXJ0
YWluIGNvbmRpdGlvbnMNCj4gKGUuZy4gbm8ga2V5IGF2YWlsYWJsZSksIHNvIHdlIHJpc2sgbGVh
a2luZyB0aGUgYm91bmNlIGJ1ZmZlciBpZiB3ZSBkbw0KPiB0aGF0Lg0KPiANCj4gPiANCj4gPiA+
ICsgICAgIHN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkX2lub2RlKHJlcS0+cl9kZW50cnkpOw0KPiA+
ID4gKyAgICAgc3RydWN0IGNlcGhfaW5vZGVfaW5mbyAqY2kgPSBjZXBoX2lub2RlKGlub2RlKTsN
Cj4gPiA+ICAgICAgIHUzMiBudW0sIGkgPSAwOw0KPiA+ID4gICAgICAgaW50IGVycjsNCj4gPiA+
IA0KPiA+ID4gQEAgLTQ0MSwxMCArNDQ0LDE4IEBAIHN0YXRpYyBpbnQgcGFyc2VfcmVwbHlfaW5m
b19yZWFkZGlyKHZvaWQgKipwLCB2b2lkICplbmQsDQo+ID4gPiAgICAgICAgICAgICAgIGdvdG8g
YmFkOw0KPiA+ID4gICAgICAgfQ0KPiA+ID4gDQo+ID4gPiArICAgICAvKg0KPiA+ID4gKyAgICAg
ICogYHBgIHBvaW50cyBpbnRvIHRoZSBtZXNzYWdlJ3MgYGZyb250YCBidWZmZXIsIHdoaWNoIGNl
cGhfbXNnX25ldzIoKQ0KPiA+ID4gKyAgICAgICogYWxsb2NhdGVzIHVzaW5nIGt2bWFsbG9jKCks
IHNvIHRoZSBidWZmZXIgbWF5IGVuZCB1cCBvdXRzaWRlIG9mIHRoZQ0KPiA+ID4gKyAgICAgICog
a21hbGxvYygpIHJlZ2lvbiAtLSBidXQgZnNjcmlwdF9zdHIubmFtZSBtdXN0IGJlIGluIHRoYXQg
cmVnaW9uLCBzbw0KPiA+ID4gKyAgICAgICogdXNlIGEgYm91bmNlIGJ1ZmZlciBpbiB0aGF0IGNh
c2UNCj4gPiA+ICsgICAgICAqLw0KPiA+ID4gKyAgICAgaWYgKHVubGlrZWx5KGlzX3ZtYWxsb2Nf
YWRkcigqcCkpKQ0KPiA+ID4gKyAgICAgICAgICAgICBpZiAoKGVyciA9IGNlcGhfZm5hbWVfYWxs
b2NfYnVmZmVyKGlub2RlLCAmYm5hbWUpKSkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBn
b3RvIG91dF9iYWQ7DQo+ID4gDQo+ID4gS2VybmVsIHN0eWxlIHN0cm9uZ2x5IHByZWZlcnMgYnJh
Y2VzIGFyb3VuZCB0aGUgb3V0ZXIgaWYgYm9keS4gV2hhdCdzIGFib3V0DQo+ID4gdGhpcz8NCj4g
PiANCj4gPiAgIGlmICh1bmxpa2VseShpc192bWFsbG9jX2FkZHIoKnApKSkgew0KPiA+ICAgICAg
IGVyciA9IGNlcGhfZm5hbWVfYWxsb2NfYnVmZmVyKGlub2RlLCAmYm5hbWUpOw0KPiA+ICAgICAg
IGlmIChlcnIpDQo+ID4gICAgICAgICAgIGdvdG8gb3V0X2JhZDsNCj4gPiAgIH0NCj4gDQo+IEFD
Sw0KPiANCj4gPiANCj4gPiA+ICsNCj4gPiA+ICAgICAgIGluZm8tPmRpcl9uciA9IG51bTsNCj4g
PiA+ICAgICAgIHdoaWxlIChudW0pIHsNCj4gPiA+IC0gICAgICAgICAgICAgc3RydWN0IGlub2Rl
ICppbm9kZSA9IGRfaW5vZGUocmVxLT5yX2RlbnRyeSk7DQo+ID4gPiAtICAgICAgICAgICAgIHN0
cnVjdCBjZXBoX2lub2RlX2luZm8gKmNpID0gY2VwaF9pbm9kZShpbm9kZSk7DQo+ID4gPiAgICAg
ICAgICAgICAgIHN0cnVjdCBjZXBoX21kc19yZXBseV9kaXJfZW50cnkgKnJkZSA9IGluZm8tPmRp
cl9lbnRyaWVzICsgaTsNCj4gPiA+ICAgICAgICAgICAgICAgc3RydWN0IGZzY3J5cHRfc3RyIHRu
YW1lID0gRlNUUl9JTklUKE5VTEwsIDApOw0KPiA+ID4gICAgICAgICAgICAgICBzdHJ1Y3QgZnNj
cnlwdF9zdHIgb25hbWUgPSBGU1RSX0lOSVQoTlVMTCwgMCk7DQo+ID4gPiBAQCAtNTE0LDYgKzUy
NSwxMyBAQCBzdGF0aWMgaW50IHBhcnNlX3JlcGx5X2luZm9fcmVhZGRpcih2b2lkICoqcCwgdm9p
ZCAqZW5kLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIG9uYW1lLm5hbWUgPSBhbHRuYW1l
Ow0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIG9uYW1lLmxlbiA9IGFsdG5hbWVfbGVuOw0K
PiA+ID4gICAgICAgICAgICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgIGlmIChi
bmFtZS5uYW1lKSB7DQo+ID4gDQo+ID4gU2hvdWxkIHdlIGhhdmUgdW5saWtlbHkoYm5hbWUubmFt
ZSkgaGVyZT8NCj4gDQo+IEFDSw0KPiANCj4gPiANCj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBCVUdfT04ob25hbWUubGVuID4gYm5hbWUubGVuKTsNCj4gPiANCj4gPiBUaGUgY2VwaF9kZWNv
ZGVfbmVlZCBjb25maXJtcyB0aGVyZSBhcmUgZW5vdWdoIGJ5dGVzIGluIHRoZSB3aXJlIGJ1ZmZl
ciwgYnV0DQo+ID4gdGhlcmUgaXMgbm8gTkFNRV9NQVggY2hlY2suIEEgbWlzYmVoYXZpbmcgb3Ig
bWFsaWNpb3VzIE1EUyBjYW4gc2V0IGFsdG5hbWVfbGVuID4NCj4gPiBOQU1FX01BWCwgc28gb25h
bWUubGVuID4gYm5hbWUubGVuLiBJIGJlbGlldmUgd2UgbmVlZCB0byBwcm9jZXNzIGxpa2V3aXNl
IGVycm9yDQo+ID4gaW4gbW9yZSBjYWxtIHdheS4gV2hhdCdzIGFib3V0IHRoaXM/DQo+ID4gDQo+
ID4gICBpZiAob25hbWUubGVuID4gYm5hbWUubGVuKSB7DQo+ID4gICAgICAgZXJyID0gLUVJTzsN
Cj4gPiAgICAgICBnb3RvIG91dF9iYWQ7DQo+ID4gICB9DQo+IA0KPiBBQ0sgLS0gd2l0aCBhIFdB
Uk5fT05fT05DRSgpIGFzIHN1Z2dlc3RlZCBieSBBbGV4Lg0KPiANCj4gPiANCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBtZW1jcHkoYm5hbWUubmFtZSwgb25hbWUubmFtZSwgb25hbWUubGVu
KTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBmbmFtZS5jdGV4dCA9IHRuYW1lLm5hbWUg
PSBvbmFtZS5uYW1lID0gYm5hbWUubmFtZTsNCj4gPiANCj4gPiBGb3IgbXkgdGFzdGUsIHRoZSBm
dW5jdGlvbiBpcyBjb21wbGljYXRlZCBlbm91Z2ggYWxyZWFkeS4gSSBiZWxpZXZlIGl0IHJlcXVp
cmVzDQo+ID4gc29tZSBiZXR0ZXIgcmVmYWN0b3JpbmcuDQo+IA0KPiBXZWxsIHRoaXMgaXMgYW4g
UkZDLCBJJ20gc2Vla2luZyBmZWVkYmFjayBvbiB0aGF0IHJlZmFjdG9yaW5nISBJIGFncmVlDQo+
IGFib3V0IHRoZSBjb21wbGV4aXR5LiBXaGF0IHdheSBvZiB3cml0aW5nIHRoZSBmdW5jdGlvbiB3
b3VsZCBiZSB0bw0KPiB5b3VyIHRhc3RlPw0KPiANCj4gDQoNCldlIG5lZWQgdG8gbWFuYWdlIHRo
ZSBjb21wbGV4aXR5IG9mIHRoZSBmdW5jdGlvbi4gSXQgc291bmRzIHRvIG1lIHRoZSBuZWNlc3Np
dHkNCm9mIGludHJvZHVjaW5nIHNvbWUgc3RydWN0dXJlIHRoYXQgY2FuIGluY2x1ZGUgdGhlc2Ug
dG5hbWUsIG9uYW1lLCBmbmFtZSBhbmQNCnJlbGF0ZWQgaXRlbXMuIEFsc28sIHNvbWUgc2hvcnQg
ZnVuY3Rpb25zIGNhbiBiZSBpbnRyb2R1Y2VkIHRvIGNvbnRhaW4gdGhlDQpvcGVyYXRpb25zIHdp
dGggdGhpcyBzdHJ1Y3R1cmUuIFRoaXMgZGlyZWN0aW9uIGNhbiBtYWtlIHRoZQ0KcGFyc2VfcmVw
bHlfaW5mb19yZWFkZGlyKCkgbW9yZSBjb21wYWN0IGFuZCBlYXN5IHRvIHVuZGVyc3RhbmQuIEkg
dGhpbmsgdGhhdA0Kc3VnZ2VzdGVkIG1lbW9yeSBtYW5hZ2VtZW50IGxvZ2ljIGNhbiBiZSBpbXBs
ZW1lbnRlZCBhcyBhbm90aGVyIHN0cnVjdHVyZSBhbmQNCm1ldGhvZChzKSB0aGF0IGNhbiBoaWRl
IHRoZSBtYW5hZ2VtZW50IGxvZ2ljIGZyb20gdGhlIHBhcnNlX3JlcGx5X2luZm9fcmVhZGRpcigp
DQp3b3JrZmxvdy4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
