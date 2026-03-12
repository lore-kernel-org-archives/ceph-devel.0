Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6E22A4E9;
	Thu, 12 Mar 2026 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345761; cv=fail; b=qX1v/Du+Y4e+KBqU5YC08t6HYBNTv7T3lm6zPldJTVP0Buhy3Tt1NLRHdzpgeVverrvsyoqZBi5di93Sm1Jnihh8wSndeXZx3VDMnlglcvbjSeSQRCJ9qEhVCtGs82SM8kl9cRIuVuSJaqwH947V2EiYjWsCM4V+5NVaIrPaoQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345761; c=relaxed/simple;
	bh=KLfhS4zzkwQ3MXo1Ea6p72lQlWG1OxQI22NVee5DK30=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=AXuvCPyxT48Ls7u4Ask0NKEZFpsjjOizo00In/SA6hFjYblcke+QerNDFLkYQe12/ae+VXSxvc7Z5Ki3XnKZWDvYNv4+QpByJmPcfy0z8dkwMqAOlo2kwUUuFNDh87DP4zeQ0OPYxD0r6CnXUTbPUSd3/4xy7uLitB5z7qYTI5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/NKU3yN; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/NKU3yN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CExjMs2308262;
	Thu, 12 Mar 2026 20:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=KLfhS4zzkwQ3MXo1Ea6p72lQlWG1OxQI22NVee5DK30=; b=C/NKU3yN
	PYwOT6tY3boyuApLzyvtJfioBIXJxkSozCZP3NOjj4DYoByKNZ8z3D+C0NfStcfn
	bPEKcIKRa8KnAvETGNELnjRdhrdTrp7qdkGyF7HdsM2j352ziOhZarpNQk0NyLnU
	SmzME9kChW5zDxVBQrrtshw96tp5e74l5gOadgQcTrhnFi6Hlref6c3T0nZCWVtu
	ec8XrJ8tsvRHmWIgvdqiSz9M3xWMFAAbO3wc6ZZpwJ+b++pmCAImzGklVB1dCAdo
	adpFieaXyyf4SoO0KuZfPSVxR1Kt1UjO1Briwduc7Nf/wyx9Mhb/wLXxslmMYm37
	/NbJfSgfZI9fTw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96cg8c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 20:02:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynXQWYNlO891nCqd2Q9Hq4TtY5vqF/SvORaHbApuHffyfBz7kJBFWA9VzMy/FYzmPmc4f+8WwHtMZykFDfJeKp3XbeKnwP6OCISuR1uvoaCwBVrnRhUqyxnSRvgOq45q5gxqzwaS3rO+6+Cq0PyQKBoJSblib/+BWDYa8791ghcBd02I7/5ptcE9ocbtLuzj8nRosys5E3IPGgM+YcJlpDKy5Q74s1+8jfxPgxIUXXSGJXaib46hK5Tt6RwOlruBVv9oudXz6OyCII/G9xEIW6Dq4UD0c+ypbDp/G6ByBUE0lPQfHhjrx9cA4rOWmcwe2iToeAlV8hRYaVq6rJMRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLfhS4zzkwQ3MXo1Ea6p72lQlWG1OxQI22NVee5DK30=;
 b=EgHgd73Jzv1hUfAV0XkE0Xc7hRdB4TikXu92JqPNfq10F4Cy1uRT8hVklpipgWn7hH2W2FPQS7ThTBXewdktr0BEPHxQKSItiCMwuPo1EH2o/AVFB0aGWRuKziM3cIy30qo7jdrs1BKiO3uYeQfCVmw26U0brBvRN2+HcF6A3LGeOtc8tIv/PsXo+Fstk+6mIGkUGqJ3EvVNCcCaYnkhxxS3AC1MlKxoWKn7DYM527Q3y70lyYNyC2ro4AzaDTezSfwvaq2jRV3W5taJeqjlCqMa4mOKon2te/xOajZZ7tx4B9zN4paIBQVgMP7M9AjNoG6S9ilaYvv9OIPQgEtvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB6056.namprd15.prod.outlook.com (2603:10b6:208:44a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:02:34 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 20:02:34 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Thread-Topic: [EXTERNAL] [PATCH v1 08/13] ceph: make ceph_start_io_write()
 killable
Thread-Index: AQHcsfkDgnRryqFnT0GPXcW2shiK0LWrUmGA
Date: Thu, 12 Mar 2026 20:02:34 +0000
Message-ID: <a86dcbd27a3f2a17d16046ecc9c19d91ab093549.camel@ibm.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
	 <20260312081619.40854-9-ionut.nechita@windriver.com>
In-Reply-To: <20260312081619.40854-9-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB6056:EE_
x-ms-office365-filtering-correlation-id: a56350ec-cd34-476c-c681-08de80724d1a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 RRDqhvzBuHBrRnupa7xSwNFY8muVLXPqSaG2sKujJNvm5se60N1LZzQTRMAKHI8yMZCxHdMFU0iMzYdj+rhCrLToFTU80ZhTbTb7BlrN9QlY/C92E48JIjS0tuHIgoF46Adu909n/Flx1P8xNPk9SBO4L18keiY5ssL9DLsfYczZ/2KwgHum1qx+tBRW3u1myf8602pAVcCPokA5XGCoMk+hOoElBxmIzADg6HSKES+aymDyl4yuksxc4Vi7d7oq78xD9Tj/2WFWIqHnsuRubuzDNQ+lre22FGroqNxoAK4e69BcDYOccDCv3EDqz/oZdpeYyRlV+hxCUaoyqmm6YkaTwNJ1J8U3Z36fDFx1nEEHiGM8VLnMBPSioZHUtuHmRrPWZ1ZaUtNSr+8ETyteTqF+iswKi/NlJsDTnGFgMJ0xfYzGtvwLlAkIri3Z4XxdgT4b+7+GK2FrPa4Tr5D834ZgAkIQzRzB3CMWejoY8QIvVRkpelpIfy8szzuzwnjT7/tDiZdC9RYM1GDiWp3oOKMCogT/XmZX3sacEQNGm1cWL3SIGDaLwNt4wNFCVvcnBBRF5JLSZA9RFE8kPpu+lmxM5fL4AAcOCByTJoy0vT5yLtev9hlBCkBvPrytRK/1dafkNtQxiSlVhhmo9EtiIl9L+4/Ej8pD5HzqAbgNQt1mrveLn0yhlNZdJ8a/GbxLOMGRzRcBnlJG1yYLKSw/N6IEvaql2uPrg1yz/cv05yQZ3se9eTzkDK6QtRHUX9N9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmRKa0x4U0o3RW1QUjZna2dkdTZjdkZVdFZpUzhhNUwwdktJRW1ONk1ETWFi?=
 =?utf-8?B?d25mWnFjeU9zSnFNTjBTOWtpMU5CUXNKcVFoWlRJMXRvb0U3TFBPa1JBQW1m?=
 =?utf-8?B?b1ZlZytmWFBmUzQwRmxTeDE1ZmF0TTNzK1hRZGRVbjRZcmgrVE44WkhrZ0hQ?=
 =?utf-8?B?b3hOTHUxMUFrY1VkSHQrTlBxQXdQbFU2bkIxZ2xaTHc1eEFLOHRQMWduZEcy?=
 =?utf-8?B?M05KU1VTV3ZjaExqWmMvQndIYXgzZS9JUTRoQkE1TFA5eGxpKzRuZFprWnc2?=
 =?utf-8?B?VENmaGZNUGN4MlA5UnExSnpNZGlRRmVxN0tmTjNzdkpJSTNad2NvNnhVRVRO?=
 =?utf-8?B?OFZSU0g0K1dhMGxQekJGaTdXek1GeTVDeHE3SG96MHR4S0lOK2ZFeTlKZTl4?=
 =?utf-8?B?QnFoSFRuVlM3S3pYWmp3NThwaGg1clBOVzhiQ3pscGRtNmdsS3ZSSlA2NDVz?=
 =?utf-8?B?Q2RJa1loY3NpUGI3dkhCeE1yWjNzQ2U3WWJ3L0lCd3VXNHFmcFlZckJCNmxX?=
 =?utf-8?B?YjRaUXVWN3J3TEg1MUNXRGJYNlNQTkhWODZJMktCa01VN1RJVFdQNmxjN2lW?=
 =?utf-8?B?cUxvSE5vb3BZMFRoOG53SE42M0Rra0tqdGQ5Q2pTR2hKeVpLd2t1cFVYWGx6?=
 =?utf-8?B?OFRyM0hKLzdFYVpiZmhCQzdhREd6Y05zTzZxelNGdVRocDdoZ2lyNStLeXdl?=
 =?utf-8?B?c1V2V1VReXhUMWRFL2NLYkk4K3lObzVKcEpuOGRNTzhZL210bElFZXM4U09x?=
 =?utf-8?B?S1FKa3kzMEc2b0Qzd3NOYnBnc1VhaXB3U2xjbGxMcENqSk53SE1WQXBOemRw?=
 =?utf-8?B?bVd0dFNlMnV6b3JaK3J3eXJobGpxUU15bnBlbjZyL2N1STU0aVZDSlhCcWhS?=
 =?utf-8?B?bUppQ3RqMFo5ZENGQ2VoZ1RxOG12UmJLYU9KNy9RejcxZi9IbUovNERzdWlJ?=
 =?utf-8?B?aEd0YlB0KzNBanRURGRpWUNOYlNWdmVvNGFKa0tleVZQbDNtbnpjYXpvMU5w?=
 =?utf-8?B?ZjhYeDRmYVFhTTVXbUN3cXh2WW9zVTF4M1puQ0N6enJlZC9mVy9FODZRbTlF?=
 =?utf-8?B?RG96Tk5MRnA5bjIxbC9hRXZ2ZUROMjNtK3hRVm1CdDBtNnl0dWxuTDRuQkw1?=
 =?utf-8?B?V29DMjVpK3VaQk9TbjI4NWtveHBxS1MyR3pZNzhrMTMrdnNnNDBsQ3ZLQ3lE?=
 =?utf-8?B?cTdNSUMxSmozZy92OG92L1pvV1pGSkMyTkNLa3ArZERlRTZ1WXIxS0wvL0RY?=
 =?utf-8?B?dUFyNi8zdTQxL3lOcGltREs1RVFjdHFTdXRlWnNVKzhaaTBpZFhHWXJEbXk0?=
 =?utf-8?B?Y2N0Y1c0R2owMTJhQTA1THEwZEs3Y3ZYUVd1WjJPZ3dBbHB4YkE2dExXb1d4?=
 =?utf-8?B?SHNFQldzVlMxeGtTN1dOVGdHb1BYY1Vsd1Q2bXpmL3hhSzUxdGh5ZGhNZXRt?=
 =?utf-8?B?MUlYRUliRUh3dHNkN1QvaGFycWt0cE8wRnFsSGRkdmVET3lyRU4zSDM0L0NN?=
 =?utf-8?B?Yy9jZU9yd2xDWVhhN25pbWRmSUFrZ28yNDhaOVFpQldEdGFQSVhtbGxFQmVq?=
 =?utf-8?B?aE9lWkpQWWFDWDZ4UXk5Yzd2VmdVM0dxcTFkaUpmOVVKOEtyYjZhOVg1UUhj?=
 =?utf-8?B?amx4TzdzalBzbFN6Q05DWUJ0M0N6S0libUh3SGE1NzVsTWhhTS9IdWFxbkp6?=
 =?utf-8?B?c1hkYUpOREx1ODFGcktIZGxIUWxmeDRiaGNMd0ZNNnZ0ZmNnVFMzL0lqS3ll?=
 =?utf-8?B?NU4zTkVKeTE0ZFZZVitlWDFCajNrUWRZQzNLOGJ6THQ5c1hxQ283Q00xOWl0?=
 =?utf-8?B?OHRqNWQwQ2M0SEw2UXc0LytoR3JWZmRKUVdkdEhlRUZ2L2h1dUlRR2lralRU?=
 =?utf-8?B?MVpteUFZeVZobmdyVkVBck1MSjJhQjVrdWl5MU4wNktMYk8yZ2lydmhrK3VS?=
 =?utf-8?B?OGVnOFR1RzhBaTUxMndveVhHSlNaejJLMm9Wa3BnUDhpcGQvZERYQXF4UFZJ?=
 =?utf-8?B?ZFVmeVd1eTlSdHNYTTZXUW41WEwrUENkU0FiOFZoR3NHSTRoSkJhVW5UWmh3?=
 =?utf-8?B?NktGY2lXOXdsSTUxN1dVa01LNlJKdnQvVFEzVk5tMzIrbG1ITnV6QStWaE1L?=
 =?utf-8?B?YnE0dVNsT2NHUVBsTWtENUM0WTdLMUkxSVExNW44WVZ5bm11RGFBN2JPWHVV?=
 =?utf-8?B?cHB2WHU3T2JSNmZQVkRiVXBPNW1oaiszVjhuMi9jNE9pSHJaUE4rM2lCbitv?=
 =?utf-8?B?c3lqMDRXc01TcFhYZ2x1TDFpd3oxUG1aVEtheFRwQXQ4Ui9BYzZua3NNeWRR?=
 =?utf-8?B?UkpERG8yNkxiUXdjcGUyc2d6a3d6bTRMN21WR3ZaWkJFNXFEcDN1dXkxQjZt?=
 =?utf-8?Q?IHYRGNrMOcDy99FDNRGoTGAfCxUcONd0esK+j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74BFDF99BD25D446BF73CA98F42BB2F6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	umbPrpJGX7DRILv6HiAS1k4MekA/EAiwILUmvXzq3TSfA/DMaWnMxesOxgrx4z/oyQqVeM7mSOfSJFYpOa0+9Y+LAj76myO0XlPZ8E+D5cYN9HUPs8pRWG8G4LNBHhzGHRHGSmqR0GaArobceuQ6XwQvSQ3sqdystZxd3neoI7reSYjBuaY2O881He/TfcIgvqFstoXj62YIJP7rV7IPUiTkE1lcLIBIVumK8ELJSmbA/QpfnGuKgXTU8EThHJ4G0C/Rong4vFdypx0RbziPC8cZdt14NapcaqscUICjZtvbSM7Yyx1xki0yeXrtDOsWYHp7q0cFg4/xe6Qp8PotoA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56350ec-cd34-476c-c681-08de80724d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 20:02:34.0908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGic181pYgCzTkDkG9QLfxoxKnZC1ioVqEpsN2QIrbL8lsVHsckfcIYUs9Y9iUB4vparjyofIrgA58a3YePW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6056
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE2MiBTYWx0ZWRfX6TGudSzAXEXX
 rbjMx7yt5FCP8QWzskJNHlQeT+7mYO3LnwtnzEHo3IroHP6JD6KIXW9LoWV1mc5k7SQQKL0J9pR
 zcOxfsxx07NgxuVe1iwjN6nkftzzFvw0A/rfPUXxSzbffALBkmpngCRMc4lXTLAH+lZy62ouPpv
 4v9JdQ2c/C8RHBHRwrD9K3soPx5xvojjtObkosgKcVetVrByM1WSv9rulMUtIAXiaklFFWj1/X9
 CyLxFstl0Uh7MB9ex1oenz7MDAD0VLzNiTqYe9mlk/8L76uaeOW3JCbWnl5KDKV7pxyEE1FuIPB
 kkgJghHXKWviKyp+/6Aubu7Qoho/Ra/PxmcCc0/vr22HdgTGRXPTvkPFa280xQbkZwZad6j5G2z
 xiPfKFCYbcu+WI/yj7M2pTLBF8AqGCSykzFRsIuAhWsbgEi25/w8zgQ1NbXB9pAZ156LqLfOzwU
 DjQ6ZBeIlPidXgd+WsQ==
X-Proofpoint-ORIG-GUID: mIP_CpcHScN1k1qt4AFO1u7NariZrtfg
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b31bdd cx=c_pps
 a=snd9/+/+5efdJOckOpJmHA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=P-IC7800AAAA:8 a=t7CeM3EgAAAA:8
 a=oYHe2yb-Yh4DQnbku_YA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 8Aiurg6xBqDO_c_C0Pz7W6gar2xB5p8U
Subject: Re:  [PATCH v1 08/13] ceph: make ceph_start_io_write() killable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120162

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE2ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gV2hlbiBtdWx0aXBsZSBwcm9jZXNzZXMgd3JpdGUgdG8gdGhlIHNhbWUg
ZmlsZSBhbmQgb25lIG9mIHRoZW0gaXMNCj4gYmxvY2tlZCB3YWl0aW5nIGZvciBNRFMvT1NEIHJl
c3BvbnNlIChlLmcuLCBkdXJpbmcgTURTIGZhaWxvdmVyKSwNCj4gb3RoZXIgcHJvY2Vzc2VzIGJs
b2NrIGluZGVmaW5pdGVseSBvbiBkb3duX3dyaXRlKCZpbm9kZS0+aV9yd3NlbSkNCj4gaW4gY2Vw
aF9zdGFydF9pb193cml0ZSgpLg0KPiANCj4gVGhpcyBjYXVzZXMgaHVuZyB0YXNrIHdhcm5pbmdz
Og0KPiANCj4gICBJTkZPOiB0YXNrIGRkOjEyMzQ1IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjIg
c2Vjb25kcy4NCj4gICBDYWxsIFRyYWNlOg0KPiAgICAgY2VwaF9zdGFydF9pb193cml0ZSsweC4u
Lg0KPiAgICAgY2VwaF93cml0ZV9pdGVyKzB4Li4uDQo+IA0KPiBUaGUgaV9yd3NlbSBpcyBoZWxk
IGJ5IGEgcHJvY2VzcyBkb2luZyBmc3luYy93cml0ZWJhY2sgdGhhdCBpcw0KPiB3YWl0aW5nIGZv
ciBNRFMgb3IgT1NEIHJlc3BvbnNlLiBPdGhlciB3cml0ZXJzIHF1ZXVlIHVwIG9uIHRoZQ0KPiBy
d3NlbSBhbmQgYmxvY2sgaW5kZWZpbml0ZWx5Lg0KPiANCj4gRml4IHRoaXMgYnkgdXNpbmcgZG93
bl93cml0ZV9raWxsYWJsZSgpIGluc3RlYWQgb2YgZG93bl93cml0ZSgpLg0KPiBUaGlzIGFsbG93
cyBibG9ja2VkIHByb2Nlc3NlcyB0byBiZSBraWxsZWQgd2l0aCBTSUdLSUxMLCBwcmV2ZW50aW5n
DQo+IGluZGVmaW5pdGUgaGFuZ3MuIFRoZSBmdW5jdGlvbiBub3cgcmV0dXJucyBhbiBlcnJvciBj
b2RlIHRoYXQNCj4gY2FsbGVycyBtdXN0IGNoZWNrLg0KPiANCj4gVXBkYXRlIGNlcGhfd3JpdGVf
aXRlcigpIHRvIGhhbmRsZSB0aGUgbmV3IGVycm9yIHJldHVybiBmcm9tDQo+IGNlcGhfc3RhcnRf
aW9fd3JpdGUoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IElvbnV0IE5lY2hpdGEgPGlvbnV0Lm5l
Y2hpdGFAd2luZHJpdmVyLmNvbT4NCj4gLS0tDQo+ICBmcy9jZXBoL2ZpbGUuYyB8IDkgKysrKysr
Ky0tDQo+ICBmcy9jZXBoL2lvLmMgICB8IDkgKysrKysrKy0tDQo+ICBmcy9jZXBoL2lvLmggICB8
IDIgKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2ZpbGUuYyBiL2ZzL2NlcGgvZmlsZS5jDQo+
IGluZGV4IDY1ODdjMmQ1YWYxZTAuLjAxZTRmMzFiMWYyZjMgMTAwNjQ0DQo+IC0tLSBhL2ZzL2Nl
cGgvZmlsZS5jDQo+ICsrKyBiL2ZzL2NlcGgvZmlsZS5jDQo+IEBAIC0yMzU5LDggKzIzNTksMTMg
QEAgc3RhdGljIHNzaXplX3QgY2VwaF93cml0ZV9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3Ry
dWN0IGlvdl9pdGVyICpmcm9tKQ0KPiAgcmV0cnlfc25hcDoNCj4gIAlpZiAoZGlyZWN0X2xvY2sp
DQo+ICAJCWNlcGhfc3RhcnRfaW9fZGlyZWN0KGlub2RlKTsNCj4gLQllbHNlDQo+IC0JCWNlcGhf
c3RhcnRfaW9fd3JpdGUoaW5vZGUpOw0KPiArCWVsc2Ugew0KPiArCQllcnIgPSBjZXBoX3N0YXJ0
X2lvX3dyaXRlKGlub2RlKTsNCj4gKwkJaWYgKGVycikgew0KPiArCQkJY2VwaF9mcmVlX2NhcF9m
bHVzaChwcmVhbGxvY19jZik7DQo+ICsJCQlyZXR1cm4gZXJyOw0KPiArCQl9DQo+ICsJfQ0KPiAg
DQo+ICAJaWYgKGlvY2ItPmtpX2ZsYWdzICYgSU9DQl9BUFBFTkQpIHsNCj4gIAkJZXJyID0gY2Vw
aF9kb19nZXRhdHRyKGlub2RlLCBDRVBIX1NUQVRfQ0FQX1NJWkUsIGZhbHNlKTsNCj4gZGlmZiAt
LWdpdCBhL2ZzL2NlcGgvaW8uYyBiL2ZzL2NlcGgvaW8uYw0KPiBpbmRleCBjNDU2NTA5YjMxYzNm
Li5mOWFjODllYzFkNmExIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2lvLmMNCj4gKysrIGIvZnMv
Y2VwaC9pby5jDQo+IEBAIC04MywxMSArODMsMTYgQEAgY2VwaF9lbmRfaW9fcmVhZChzdHJ1Y3Qg
aW5vZGUgKmlub2RlKQ0KPiAgICogRGVjbGFyZSB0aGF0IGEgYnVmZmVyZWQgd3JpdGUgb3BlcmF0
aW9uIGlzIGFib3V0IHRvIHN0YXJ0LCBhbmQgZW5zdXJlDQo+ICAgKiB0aGF0IHdlIGJsb2NrIGFs
bCBkaXJlY3QgSS9PLg0KPiAgICovDQo+IC12b2lkDQo+ICtpbnQNCj4gIGNlcGhfc3RhcnRfaW9f
d3JpdGUoc3RydWN0IGlub2RlICppbm9kZSkNCj4gIHsNCj4gLQlkb3duX3dyaXRlKCZpbm9kZS0+
aV9yd3NlbSk7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IGRvd25fd3JpdGVfa2lsbGFi
bGUoJmlub2RlLT5pX3J3c2VtKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAg
CWNlcGhfYmxvY2tfb19kaXJlY3QoY2VwaF9pbm9kZShpbm9kZSksIGlub2RlKTsNCj4gKwlyZXR1
cm4gMDsNCj4gIH0NCg0KV2hpY2gga2VybmVsIHZlcnNpb24gZG8geW91IGhhdmU/IEJlY2F1c2Us
IHdlIGhhdmUgdGhpcyBmb3Igdi43LjAuMC1yYzMgWzFdOg0KDQovKioNCiAqIGNlcGhfc3RhcnRf
aW9fd3JpdGUgLSBkZWNsYXJlIHRoZSBmaWxlIGlzIGJlaW5nIHVzZWQgZm9yIGJ1ZmZlcmVkIHdy
aXRlcw0KICogQGlub2RlOiBmaWxlIGlub2RlDQogKg0KICogRGVjbGFyZSB0aGF0IGEgYnVmZmVy
ZWQgd3JpdGUgb3BlcmF0aW9uIGlzIGFib3V0IHRvIHN0YXJ0LCBhbmQgZW5zdXJlDQogKiB0aGF0
IHdlIGJsb2NrIGFsbCBkaXJlY3QgSS9PLg0KICovDQppbnQgY2VwaF9zdGFydF9pb193cml0ZShz
dHJ1Y3QgaW5vZGUgKmlub2RlKQ0Kew0KCWludCBlcnIgPSBkb3duX3dyaXRlX2tpbGxhYmxlKCZp
bm9kZS0+aV9yd3NlbSk7DQoJaWYgKCFlcnIpDQoJCWNlcGhfYmxvY2tfb19kaXJlY3QoY2VwaF9p
bm9kZShpbm9kZSksIGlub2RlKTsNCglyZXR1cm4gZXJyOw0KfQ0KDQpUaGFua3MsDQpTbGF2YS4N
Cg0KPiAgDQo+ICAvKioNCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvaW8uaCBiL2ZzL2NlcGgvaW8u
aA0KPiBpbmRleCBmYTU5NGNkNzczNDhhLi45NGNlMTc2ZGY5OTk3IDEwMDY0NA0KPiAtLS0gYS9m
cy9jZXBoL2lvLmgNCj4gKysrIGIvZnMvY2VwaC9pby5oDQo+IEBAIC00LDcgKzQsNyBAQA0KPiAg
DQo+ICB2b2lkIGNlcGhfc3RhcnRfaW9fcmVhZChzdHJ1Y3QgaW5vZGUgKmlub2RlKTsNCj4gIHZv
aWQgY2VwaF9lbmRfaW9fcmVhZChzdHJ1Y3QgaW5vZGUgKmlub2RlKTsNCj4gLXZvaWQgY2VwaF9z
dGFydF9pb193cml0ZShzdHJ1Y3QgaW5vZGUgKmlub2RlKTsNCj4gK2ludCBjZXBoX3N0YXJ0X2lv
X3dyaXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpOw0KPiAgdm9pZCBjZXBoX2VuZF9pb193cml0ZShz
dHJ1Y3QgaW5vZGUgKmlub2RlKTsNCj4gIHZvaWQgY2VwaF9zdGFydF9pb19kaXJlY3Qoc3RydWN0
IGlub2RlICppbm9kZSk7DQo+ICB2b2lkIGNlcGhfZW5kX2lvX2RpcmVjdChzdHJ1Y3QgaW5vZGUg
Kmlub2RlKTsNCg0KWzFdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y3LjAtcmMz
L3NvdXJjZS9mcy9jZXBoL2lvLmMjTDExMA0K
