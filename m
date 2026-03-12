Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43D32D441;
	Thu, 12 Mar 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344323; cv=fail; b=i59HF3vXGoIE9LAuo48HVtTwff6mnXxuQ5SxekN3WvxlDgiTkYNFOWVc0ZCr+ym3Xygie/zfAOMNB2ubNDYOOqnxc5CBgAfnejoQupQyFRaf1rwqbOrClCE6wZi8eSLUL1f8fRwTBIR5Q1kVmpfC75RlcObDKE4iwxrl4zp7wTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344323; c=relaxed/simple;
	bh=b5RVAllPYoC06eAEN5tMD4crxEwsJ2w6aB+mrtt3cxA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Opkjts2T4uaYzytkjvN4wvi5kgLscelFhLVQ9X57YX6Z7E5N1UoOFkewwRieQ2KFZwKx5OW9+d0tNSNTl8azal0DHQlWpL+SpHpEb+asp/1dImWj8dyssgN/f/sfay9fuHZtOrWfQL4NquTbrZp95LuNa+FLbaGJqDFY+BQx7Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qg9OXnWE; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qg9OXnWE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CF4drA2258926;
	Thu, 12 Mar 2026 19:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=b5RVAllPYoC06eAEN5tMD4crxEwsJ2w6aB+mrtt3cxA=; b=Qg9OXnWE
	qt+VdY7EMAVFVa2NoOicj75bn8cixtSWj29bigXjsKHUXRJLVtBAL8pF3wtsdyTv
	niyBdsHvHQON4RJs9OzhuUWU89tTlFp5DIvAfipqfh9JT+Uex+asywHv/IMK8oQq
	tkv7iU+X3WXf7MozJGmF0OER3Q92zXdq78ltYhDFYJP3k4TI4fr4x0DSFbVJAvnm
	WOnbWQe98Wbcb4asQY8RAGjyPZAEayD3o+CwFpPUpY/VqeY4uoTdWpe/kbFj2H5H
	pj4KnVpPtl8HQbGBzmUjKSu9a4aYSksPgWb5CmyafNAoCfK55hcybBxGcH6KOJeT
	FW184JOe5dTsSg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92cje5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:38:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjoyDli2BBAJ+OWXqSj6n1pVzwmsBYRfqoYVIycFCrWOpkuwtWDUrQebiRfsOgSpcFiXetrKcsLhYyj74j3+UxXApef/BY6zt1TaVkgpMfVBUDUD4UhiTy+FYTjjB+BHQC7Eru1sBNhBnIOEOaJxRwHdLR7Emo3GDmThkqxBnhaA1gmKljZaE821ErpKmWpywkxm6KraK1Eraequuxdl/i1ud9ubqF9pa7MgOitNvlY5TmRXR0U9fI7/Bs2+HZOxOzg1nabo4azjzSXJhNuo4CNTp2HRfajHXaNj3Mswv1rdX2twQFiREBDg+DgFjsIIBZVxEOS4yIRiJ14ianollg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5RVAllPYoC06eAEN5tMD4crxEwsJ2w6aB+mrtt3cxA=;
 b=yb4BXannQZq1+CgFiIVAsQ05qFWN6Dug2lYmt4AnTpIZoUzUTmg3oQrCVQ6WKfMGeY/onwJ1QtEnQzMQJJ0gyWJpv3u+87On9mEOf1t2sMQl7S/tMKIYa49Rv6YWQ+Nh/XTs6H+/6oRdn2uzwVruDUkEzL8Q38MCbR7WjyruTo1eqJRX2LqTxO8aDFuerisadsS4vvqTqdyKMX36fbuwYovYHQn6vONfGrk73kPVmAmSmUWrSKEr3SdWofHdpL+PNYyXIewUnWTdGSahuswpa17X91QMHQrvU2zOkfa7IMaCTVWHomtKUeC4lL+B+atfFECHI2xIkI/AZ4Lc4xgLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6530.namprd15.prod.outlook.com (2603:10b6:208:523::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 19:38:34 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 19:38:34 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Thread-Topic: [EXTERNAL] [PATCH v1 05/13] ceph: add timeout protection to
 ceph_lock_wait_for_completion()
Thread-Index: AQHcsfjhHtHuvk7ixkyoykECV3AtAbWrS6IA
Date: Thu, 12 Mar 2026 19:38:34 +0000
Message-ID: <81a8db5a7de48ec04435b9c31ec63514636c47e8.camel@ibm.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
	 <20260312081619.40854-6-ionut.nechita@windriver.com>
In-Reply-To: <20260312081619.40854-6-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6530:EE_
x-ms-office365-filtering-correlation-id: cba3b2cb-c1a6-4de5-f95b-08de806ef2f6
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 3Xke9fAX8/xiPe4HTnEaQwjnfUzv0RW8LQr3V+w1gm9YpB9Oeyhc3wa7drrOw9GHZnxNxM0vkgrz+jgysoYYZJB2B7/kjB6zxvkQ8D7yoTaiTgvptMC5SAIsC3uC/dfTSDYR8NmBVcEHdBAPVV4MDJICXbEM3UotuEmE0ZZIZyO13xHS25ZjB5vn7RgP1MPwrUwioBjnV/CNJPDGWfZgOa7sSlzmu40xUQlK5V7/ADoaW3ZcoDPbBpPTNnTmHLjoMlQd1CVKAPYJpFi9uWYfelV4pS3g6NuwT9oMyDo+/GjGlnWznHWYurOw0hPGCG55hlT6QZkWodyLRlBJOkz9uFHjOMdhT91xVVpifWraCPGqHpUMKghF7xrQNJnmlKeurgIIIdFbfQJjDH1L9YCE60HAqS6gp/uDhLy8mgp7yAWRVKW8E8rrInj1w/NqdJ/FF6ZrObsS4xJON69/uT2uIwRXxa0srUfsKN2wIAc1XRAgqi0rfOaZ8ZR5SLfD10Qywb3dvDxtDnuhhiq6DVdQMGjDRVfe/Iizf5w+YEW5rTuQJc7imPEj8qCYoVqX3q9vEXDBzhiQbZXzWrwLSi2Odq9Y65/8/Kl+DD77qj3vHCfIZIUKsFc8dJenRiKlwjIutTauBEuj0YZiohwuVZGoDTznk6RhJEp4ENDtzuUCiiXiXS2r/RDBK0TbpHLZu+/V9TB9tbLgSJQUqSSri8M+rtyRl0IhlytlHmEfGrpgtuqih5SGEWf9Vsp59YlSSJs1cmZwxLhtJD177dQC2cktw0ZvI3nw93ffdSYv0B7rZ6o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjY3U05McHlMMG9mYmJuNUxaUDc4bE9JN2VzaWFRNE5ITTk3aGc5ZXpwUFY3?=
 =?utf-8?B?aGhRcGNnSmZOQWt4bmdnZDdyUDlPZ0VSSnd3NVdpMXNMbmhzanFGYkRrcUpF?=
 =?utf-8?B?Z3RrdVRYQ1IzWXp4ZVBJa04vc096ZkI3bTBWWVBNdnZ3TmlOMXNpS0hQZSs5?=
 =?utf-8?B?dVJIa294R2FUU0ZrMDZHc0dVYzhLc2RXeUlrRmt3a2tqNmtrR042eUhwRVVh?=
 =?utf-8?B?dWIrTThVVURwUDVOVFhqdFFXN1VZeTZNbVRhTTlEOEkxcm1LUGN3TVh0SmJ1?=
 =?utf-8?B?THVwZ01udytHdWpIanNkNVU3MEN4cnE0b0I2RDFqMmZTSjVyaVVSRlhuTHM4?=
 =?utf-8?B?UW5UK0dKMHBoUW1QYW5OWkJJWkt6QUNablpoNk9EWUtwK2RMaHVFaStSMHRD?=
 =?utf-8?B?cWZpaGllUFpiM3ZvMFpNTXpCQnZvdjdwT0lwK0FkS2pJV2U3WmVBR21WVTRi?=
 =?utf-8?B?M2VSclplNW55bW5sbXc0ZHo3R2p6K1k3M1ZKK2RpSFpoaXZEZHJSdzN0em9X?=
 =?utf-8?B?YnZEZ0RUTlhUbUliTnQrMzRXR3NZS3MxeEtrRUNEQWNUK3N5VjZsV2pJdUZy?=
 =?utf-8?B?cllyQWUrdTYyeHpqY1hxb1IraGFQKzhKTURuSTgzTjIzYkFFOGl4bFNELzZE?=
 =?utf-8?B?dWYyMHFhcUd4S1BiWFMzSGRNTmxBQjlWOE1LU2tVM3Zhc0NxSXBqWkdpbDlG?=
 =?utf-8?B?K2laeURnUW1hMU1UMVg5dFArQnJya2k4UW40UElFV2hoSnJKdFFZNXlFTGlL?=
 =?utf-8?B?TGN0Q3pyR05OR3QxWkVhYzM5cVBaajRxZHlRMDNFYTRnaUs2S1hlVk1Ud2pO?=
 =?utf-8?B?d2tWZ05YT2hyZ0xkRDRHVno3bEh6ZWk2L01vb2ljYnVuMStJVkZUNkpQbjhR?=
 =?utf-8?B?OGlXZlE4b0JFM3ZFTG50Z2JjTVp3NTBVZGIxQ0xyREY0VlRnZzFrWmpVRkhz?=
 =?utf-8?B?aHZ2cDZiUVEzSzh4VmZJTjFJQmtvL0lJRko1T2FTMzUraDc4a25iUEh4NUYv?=
 =?utf-8?B?UEV6aFljcEp1ZDNzdm5yWkVjZFZ1OWdDSjdMS2ZadHR3ME1wOUtsZWo4K1gz?=
 =?utf-8?B?ZGFhblZGK25INGtFbFN4aElVWkdwQzFnSnBVMkhndTBDQmdOa1N5RmZXaWVW?=
 =?utf-8?B?dklOR1hzVDlGYWFJTHVVYmdQZmV6ZHJyWGxiNlAxdXdYZ0pyN1pEVk1zN21B?=
 =?utf-8?B?cmkzL3ZKK1M3S1piS0Zyc3VwVVhVSGJzL0FaRzBnYWx5d2xUek5tYzYrN2RG?=
 =?utf-8?B?RnVXT21ZMXpTTG5kUTR0dS95SGxjcTkwa3BFWGNGc3pzMFBLVkhTb01mWVIw?=
 =?utf-8?B?ZDU0ZEtCcStjVGUyeCs3bGt3UkMzOGNYZEg4Ym1USW9yQlo1UHhKcWsyQ1Jj?=
 =?utf-8?B?NnNBYmpybWhQTHJ6L0w2ODZxeGN3aGFER1VMZnNBZFNpSGFKcTVNRTBoOUk3?=
 =?utf-8?B?TzZCZHRHNXFmVnZTY0JiV1ZpOFV1WXVPY3R5N2NwNzhZeElCSDRrSysxcnFP?=
 =?utf-8?B?Q3dPYlZkSXkzTnlPc0FJNHdpUXBpcUIyQXdyTDBtcnVJWU1lbm5HWU9LWlla?=
 =?utf-8?B?RHpVZHpNWXdVWVBOTXp2bFREMkpLeDh6RmVYd0FFL1VuRFhwRSsxYmVVVk1X?=
 =?utf-8?B?aHQ0NlFJd1oyMHpKUmFvSElwTVp5SmwrNW11ckVlbmtWWXBkblRqUXNYM1Rm?=
 =?utf-8?B?MVRlY2pGYTVHcFUyNUwxaWNPaGZpNnlzUFl6U3I2QThoTHJRWndvZWNncGJm?=
 =?utf-8?B?Z3FaemZxVXVuMDMvazNtSGJIU25adHk4N3hCeWFvMWhVcGkvT0FtbjZUMXRT?=
 =?utf-8?B?ZmlDSEN0TG1iRkJ2MzZlQnpQY3FDbWhUWHBJNU44NGt5dnVGZ2drZjkrMkZP?=
 =?utf-8?B?dlp6aUVNQWcvQXdBWVUza1p6cjBHa3hoMW1lck51c1czazhYcGljeGVVZlhJ?=
 =?utf-8?B?bzlkZlgzSVp6U3h2UWliOUFoM2grekRDRUtGSnc3Q2gyekcxdkY0MTJ1czFO?=
 =?utf-8?B?aEM5eXI3b0grc3Y1MFIybFFweE14UTRpNHpxR2lMSDlRWDVVUmZJMDk2Nndo?=
 =?utf-8?B?bWpHcEs5MVM4UXV3WitTMnBlYUNSc1labm5WZWwxNW9SY1VBTGx6RUNseGZG?=
 =?utf-8?B?cWNrUDNqalhZWkZhTDA3bllIa2NYYTBEMFYzQnlFbDEvUGF3WG84aXNJUzZx?=
 =?utf-8?B?M1VRUGhJM2tjTXdpNVRRcFdCNXcwZnowdkpUNzgydU9heFd5cWhpSVdIUUFp?=
 =?utf-8?B?dUtyK1lZV3owOG00SVA0WVFMY3E3YkRPdFZlaFN0OEdpSjVtRXgyemFRekpY?=
 =?utf-8?B?a1NVWGlobm9mdy9IZHdLZlBTbDM5c0tUbnN2Q1Z0MmFUWngrTE1xa2kvbzR5?=
 =?utf-8?Q?lRCCO8sr0VPqpvxzX32cXczyVXv+7sQDvY1+P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C543751571679842A9DC867AB1025038@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VdfmumOLIWnNe0ohr1pZC5me5woPBvNT+azgrLmDN4J/cel2ayy7ZxxDLvDoJJbXV8YKldLBiT+ALWE1Ug6DKT2rEYzCMupRcFwES0SR4OXGHy5cnXR3EPx8IL0acVywpPtpLbsFKDy+C516UQKNLbF9+pjnBsOK3pLJhNbTy7m+7yMs8JQ4UI7VtL2WeJBHfd6QpiW6I4nTg5pBsj/yEkjIb28NY3ZvV6Gj6R/3NnHbbcrVnXW7WYCv2XwJS9cLjjYvM6NFDTnErLZImv09UXw+Ieil7jP9PY32KatLiIb1sx5Idt8/uUPaeVjR4jJss3AaoudIOfnbKbE4nIUHnQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba3b2cb-c1a6-4de5-f95b-08de806ef2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 19:38:34.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: plPtFv2yQjxLIq5TaEqAXLqRh4NFY/Mvwi4d02f0sK5SjUjhpBMHEThQiWiSxNZJlzlptGdY2K8y83VV53AbVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6530
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: WRewTdiMxfvTKCCimosfSSqaw_wvyS6_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1OCBTYWx0ZWRfX6br5o4n12LeW
 oMMd6+lZhuAaBmF6uZI+j9exrVEJRzIjSU6ovpZbxGCS0WaV3CIyNUVX/VH/7qqSdKVjBXBo61E
 1lPevkC+B21BNvNGHAiFPYaykA3FmvjN+aNEmxMsEMcoI+pNnmg/yEgaPGf/R9nOSWQzJhsVntV
 PerbOKK0ta5onr8JyrMPBujYksj5NM+n7vk5mv77WVLZCn8Oaswu4c5HpluyfUY8JnrkVoSnWo3
 gb//o3AhILa4Ys4/8NbmtRUlXJNXquN5tueLjR6AjUFm9Gm8WOMq5jVNIkoDsV5qdFJ2FcYv6fU
 Nwd6dzhzoI3y11w+1dZ7PnobWoRw+ODopQ8myqIzdFBOvwCOBCm4K1FB8ppY1KZlMUcV60jRiQE
 xRYSbsXlhTJjrDKsEziCAEsPRv/HLuUhfCeDToAfeniHdByftFzFk36TodjvAywfPNi3gLELPJ6
 1YdkZzHkUsSeoihjFRg==
X-Proofpoint-GUID: P-6wU8nnKdj7yQ7mxpylPptjsK21tV4L
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b3163e cx=c_pps
 a=6zE/HbjXcl5L3wBq6eN3xQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=t7CeM3EgAAAA:8 a=OWXNHnBeFHKUw1oMkfIA:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
Subject: Re:  [PATCH v1 05/13] ceph: add timeout protection to
 ceph_lock_wait_for_completion()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120158

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE2ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gV2hlbiBhIGZpbGUgbG9jayBvcGVyYXRpb24gaXMgaW50ZXJydXB0ZWQg
YW5kIGFuIHVubG9jayByZXF1ZXN0IGlzDQo+IHNlbnQgdG8gY2FuY2VsIGl0LCBjZXBoX2xvY2tf
d2FpdF9mb3JfY29tcGxldGlvbigpIHdhaXRzIGluZGVmaW5pdGVseQ0KPiBmb3Igcl9zYWZlX2Nv
bXBsZXRpb24gdXNpbmcgd2FpdF9mb3JfY29tcGxldGlvbl9raWxsYWJsZSgpLg0KPiBJZiB0aGUg
TURTIGJlY29tZXMgdW5yZWFjaGFibGUgYWZ0ZXIgdGhlIHVubG9jayByZXF1ZXN0IGlzIHNlbnQs
DQo+IHRoaXMgd2FpdCB3aWxsIGJsb2NrIGluZGVmaW5pdGVseSwgY2F1c2luZyBodW5nIHRhc2sg
d2FybmluZ3M6DQo+ICAgSU5GTzogdGFzayBmbG9jazoxMjM0NSBibG9ja2VkIGZvciBtb3JlIHRo
YW4gMTIyIHNlY29uZHMuDQo+ICAgQ2FsbCBUcmFjZToNCj4gICAgIHdhaXRfZm9yX2NvbXBsZXRp
b25fa2lsbGFibGUrMHguLi4NCj4gICAgIGNlcGhfbG9ja193YWl0X2Zvcl9jb21wbGV0aW9uKzB4
Li4uDQo+ICAgICBjZXBoX2Zsb2NrKzB4Li4uDQo+IFRoaXMgaXMgc2ltaWxhciB0byB0aGUgaXNz
dWUgZml4ZWQgaW4gY2VwaF9tZHNjX3N5bmMoKSB3aGVyZQ0KPiBpbmRlZmluaXRlIHdhaXRzIG9u
IHJfc2FmZV9jb21wbGV0aW9uIGNhbiBoYW5nIHdoZW4gTURTIGlzDQo+IHVuYXZhaWxhYmxlLg0K
PiBGaXggdGhpcyBieSB1c2luZyB3YWl0X2Zvcl9jb21wbGV0aW9uX2tpbGxhYmxlX3RpbWVvdXQo
KSB3aXRoDQo+IG1vdW50X3RpbWVvdXQgaW5zdGVhZCBvZiB0aGUgaW5kZWZpbml0ZSB3YWl0LiBP
biB0aW1lb3V0LCByZXR1cm4NCj4gLUVUSU1FRE9VVCB0byB0aGUgY2FsbGVyLiBUaGUgbG9jayBz
dGF0ZSByZW1haW5zIGNvbnNpc3RlbnQgYmVjYXVzZToNCj4gMS4gSWYgdGhlIHVubG9jayBzdWNj
ZWVkZWQgb24gTURTLCB0aGUgbG9jayBpcyByZWxlYXNlZA0KPiAyLiBJZiB0aGUgdW5sb2NrIGRp
ZG4ndCByZWFjaCBNRFMsIHRoZSBvcmlnaW5hbCBsb2NrIHJlcXVlc3QNCj4gICAgd2FzIGFscmVh
ZHkgYWJvcnRlZCAoQ0VQSF9NRFNfUl9BQk9SVEVEIHNldCksIHNvIE1EUyB3aWxsDQo+ICAgIGNs
ZWFuIGl0IHVwIG9uIHJlY29ubmVjdA0KPiBUaGlzIGZvbGxvd3MgdGhlIHNhbWUgdGltZW91dCBw
YXR0ZXJuIHVzZWQgdGhyb3VnaG91dCB0aGUgY2VwaA0KPiBjbGllbnQgZm9yIE1EUyBvcGVyYXRp
b25zLg0KPiBTaWduZWQtb2ZmLWJ5OiBJb251dCBOZWNoaXRhIDxpb251dC5uZWNoaXRhQHdpbmRy
aXZlci5jb20+DQo+IC0tLQ0KPiAgZnMvY2VwaC9sb2Nrcy5jIHwgMTQgKysrKysrKysrKysrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9sb2Nrcy5jIGIvZnMvY2VwaC9sb2Nrcy5jDQo+IGluZGV4
IGViZjRhYzAwNTVkZGMuLjU1ZGQ5OTQ2MGI4MWEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvbG9j
a3MuYw0KPiArKysgYi9mcy9jZXBoL2xvY2tzLmMNCj4gQEAgLTE2MCw2ICsxNjAsOCBAQCBzdGF0
aWMgaW50IGNlcGhfbG9ja193YWl0X2Zvcl9jb21wbGV0aW9uKHN0cnVjdCBjZXBoX21kc19jbGll
bnQgKm1kc2MsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBjZXBoX21kc19yZXF1ZXN0ICpyZXEpDQo+ICB7DQo+ICAJc3RydWN0IGNlcGhfY2xpZW50
ICpjbCA9IG1kc2MtPmZzYy0+Y2xpZW50Ow0KPiArCXN0cnVjdCBjZXBoX29wdGlvbnMgKm9wdHMg
PSBtZHNjLT5mc2MtPmNsaWVudC0+b3B0aW9uczsNCj4gKwl1bnNpZ25lZCBsb25nIHRpbWVvdXQg
PSBjZXBoX3RpbWVvdXRfamlmZmllcyhvcHRzLT5tb3VudF90aW1lb3V0KTsNCg0KVGhlIG9wdHMt
Pm1vdW50X3RpbWVvdXQgY291bGQgYmUgY29uZmlndXJlZCB1bnJlYXNvbmFibHkuIFNob3VsZCB3
ZSBkbyBzb21ldGhpbmcNCmFib3V0IGl0Pw0KDQo+ICAJc3RydWN0IGNlcGhfbWRzX3JlcXVlc3Qg
KmludHJfcmVxOw0KPiAgCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSByZXEtPnJfaW5vZGU7DQo+ICAJ
aW50IGVyciwgbG9ja190eXBlOw0KPiBAQCAtMjIxLDcgKzIyMywxNyBAQCBzdGF0aWMgaW50IGNl
cGhfbG9ja193YWl0X2Zvcl9jb21wbGV0aW9uKHN0cnVjdCBjZXBoX21kc19jbGllbnQgKm1kc2Ms
DQo+ICAJaWYgKGVyciAmJiBlcnIgIT0gLUVSRVNUQVJUU1lTKQ0KPiAgCQlyZXR1cm4gZXJyOw0K
PiAgDQo+IC0Jd2FpdF9mb3JfY29tcGxldGlvbl9raWxsYWJsZSgmcmVxLT5yX3NhZmVfY29tcGxl
dGlvbik7DQo+ICsJZXJyID0gd2FpdF9mb3JfY29tcGxldGlvbl9raWxsYWJsZV90aW1lb3V0KCZy
ZXEtPnJfc2FmZV9jb21wbGV0aW9uLA0KPiArCQkJCQkJICAgdGltZW91dCk7DQo+ICsJaWYgKGVy
ciA9PSAtRVJFU1RBUlRTWVMpIHsNCg0KSW50ZXJlc3RpbmcuLi4gWW91IGRpZG4ndCBjaGVjayB0
aGlzIGluIG90aGVyIHBhdGNoZXMuIFdoeT8gOikNCg0KPiArCQkvKiBJbnRlcnJ1cHRlZCBhZ2Fp
biwganVzdCByZXR1cm4gdGhlIGVycm9yICovDQo+ICsJCXJldHVybiBlcnI7DQo+ICsJfQ0KPiAr
CWlmIChlcnIgPT0gMCkgew0KPiArCQlwcl93YXJuX2NsaWVudChjbCwgImxvY2sgcmVxdWVzdCB0
aWQgJWxsdSBzYWZlIGNvbXBsZXRpb24gdGltZWQgb3V0XG4iLA0KPiArCQkJICAgICAgIHJlcS0+
cl90aWQpOw0KDQpUaGUgc2FtZSBjb25jZXJuIGFib3V0IHNlbmRpbmcgd2FybmluZyBpbnRvIHN5
c3RlbSBsb2cgaGVyZS4NCg0KPiArCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gKwl9DQoNCk1heWJl
LCBzb21lIHN0eWxlIGNsZWFudXAgaGVyZToNCg0KaWYgKGVyciA9PSAtRVJFU1RBUlRTWVMpIHsN
CiAgPGxvZ2ljXzE+DQp9IGVsc2UgaWYgKGVyciA9PSAwKSB7DQogIDxsb2dpY18yPg0KfQ0KDQpU
aGFua3MsDQpTbGF2YS4NCg0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo=
