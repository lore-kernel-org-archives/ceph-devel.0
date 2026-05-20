Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA73A3E79;
	Wed, 20 May 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302980; cv=fail; b=AoiZxKfyfbndSIG/0zt4nXOAdhbuDAmR+ful36dOKGPCnPw+SWh53fsTdvtFHhEk8kt5bsQaFLct2jaHfLL0c9su/6MBKuSW+wQb80vWwad6PWacGlo/ImWxA9SuGhukuSXXxMelaaHlOKoKlM01UKVvThoeTLRoCSUgd1lCy5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302980; c=relaxed/simple;
	bh=B4MzrfUCDV5qa3PSXZ3UoKOmUUq3DIWNPYQeNuQDUeU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sSwGKOT/S0Te+Py7A4FPiovUPk38uUo1ULTE0Y/MNbTbPlNw4FgAZZea9n+JJOnnqppfPd29s0Ag+2R/Gr3FWia7zz2L7Lolk5hE1LeK+x+ZLAJIUb2iVfIvn5ASqHz9rhSXCJMy5mi2azJK1IP24jK8P3zXr8Ha+uCCKM3ugbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kOFsEGjB; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kOFsEGjB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KF6Swg3505643;
	Wed, 20 May 2026 18:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=B4MzrfUCDV5qa3PSXZ3UoKOmUUq3DIWNPYQeNuQDUeU=; b=kOFsEGjB
	pnwH/fQuRa3vcWscvC5YySlMqLwsjWgT6Szb6mVWwNZHklLLKZkbpGyl92gbNaR0
	NbPSqr89TZtbuxhyqrBKMR+NmXLCY5rLyz/p+Nhiwod2k4l5eUSadRYR0JagtukM
	eCu1bzQEZiDa7iPioAb30GNgKLWZJlJjHt6ncPb9QlA7S2v5uX1BHW8YFlvXxK+Y
	V7qkTjdfU0QpiGxHUQYvYwTc8msc2kB5Viqq0WuMQOj20Nyw5sduTsC5aw8qU8FS
	R2tAjy5o87r2YPgmYGwX31AJlwfMmzP2CN4YK5Tieom0Wwjuh40+N9wRo7wPVnNQ
	v6ibAPwSfoycmA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mufe9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:49:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIXfSU6PIxXGqDnBdc1QtMDQ1ErP6fjYS/8MOITyRhxx+g6qQ457HzAlJ0PxQrY7gWB2K+64LsIyDUKacqtBwJlYdRzMp1zbJwbz1ETpStks1WjsM3V1XOqnI9DwNvQyd7RwulwH94PoqoORxyXU6xmtnmAL8FqNV+ciOVDljjt7RHfA9r+hU2/644pEpag6mpJySYV+Q1bfv1B5LtXdMHLqbJOM5yKv4wdrmFpyu7D9kpkarekozQLJHiXjZww+5aumLJxt6omFHBcSUGDQUx27yKJUzbD1gX9ep+msMUvNRTzFMKu5ocQWa3D+F4o7HFYLsNMZ5UCeufzhBcjRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4MzrfUCDV5qa3PSXZ3UoKOmUUq3DIWNPYQeNuQDUeU=;
 b=L3bhe8KujQ2jJSa3Rj9ocf0zGnCK4HEWQaszSkCG9baheIpd7FZWwJK1P+NM3WBYC0xWyhjJ5sZxUj55vyRftB+2m2oheoPDBE41gEdhD/NM9jcGJJEVoEKVicH3aS1Avd1aT2jr+c3go+MMz22UR9emIrVrndnFETKTb1euC+ONpQ9+F3oHfKt45SjyHOmwlzSF/RQm5dScKWAZ1bmj5qYf8VHvhvZYpKSZB1kUnP4D4HnumFt9MF4Fl02DP/R4aJm4NMpOeIzfVVjWI+KlZmsF2aJzT9JFx53rrqnzq7sG3rPXP3QYHnEcnCp3M1D+eT6RtTPA/hgmOkw/YrTQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV8PR15MB6666.namprd15.prod.outlook.com (2603:10b6:408:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 18:49:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 18:49:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jack@suse.cz" <jack@suse.cz>, "brauner@kernel.org" <brauner@kernel.org>,
        "neil@brown.name" <neil@brown.name>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "zenghongling@kylinos.cn"
	<zenghongling@kylinos.cn>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhongling0719@126.com" <zhongling0719@126.com>
Thread-Topic: [EXTERNAL] [PATCH] ceph: Fix ERR_PTR(0) in ceph_mkdir()
Thread-Index: AQHc6D+H7PHgwc4bNkqqy/cTjJGwv7YXQjoA
Date: Wed, 20 May 2026 18:49:18 +0000
Message-ID: <d2cd070ded01305414815248032bbfc331c392ee.camel@ibm.com>
References: <20260520095428.69422-1-zenghongling@kylinos.cn>
In-Reply-To: <20260520095428.69422-1-zenghongling@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV8PR15MB6666:EE_
x-ms-office365-filtering-correlation-id: e4e6280d-1604-4d0c-fb6c-08deb6a07fb1
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|22082099003|56012099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 qf0S/4quMYqYyffxIfgUqJqdQh3ab1IBRb1MaOQnhj+lLgUSPkTmA69t3dVW5d087Pk7mfFqWq9ZYwv0kb3ZYdQrpoQnlJuMNU60zbVuy4bowRiap4wuNSxiswRpblM42mxdDEQAYOvvff4HrubZHgCqnkrgIgnRrPcn0KQbbT5DOO6AEv/N0RXq5ekclu37oDHw0hDqtR5Bf2JbhBwLCueS0wgvgmxYzMqReGw1HGmsU/EnEh0D9oP+4rmNYBWae+5P/TAQa9KOK964EelbFmkIFvx0k7a1qmkAAHa7QLI146/te8DKQBROmlvDoHYrVSnfqYhPSXTTSX/H6hHNbIaVr3gUekOEBJGMyTSYKzbsV6XCfMW5W80C3rd47AyYfJ6850k6FDkIQhSz8gYac6vNQJEA+y9Yp190/cfBwDsRX3o8ybAI8JEewHeXOMYcbWqW2s0X4rkghriRMnATrIJLGNy9JNho0DtnL0YwypIZznFfiiB3JmHQI8V2MXHIx14YdXRzE9iV+L9pJp7gLMxRr/hwA3wWBqj58imwLFC/jDd7wG+HvsJkhj77sDBkWJpnpqQylaleX9PFcpXvzcqI5mSsTBW0VX4uepVs6EK7Rnpa+4vwE74SYJpWKn6rLBO8DsJzINR2LaZd2+n0mmUNt/2mzICnmm4ghjdYVnSQKEZtF/eqcGEolbY/Q1YXyZZBaWx8UGJP61qZphUpt2SFbJpajv0Di6i4+B6ygRQkkhoVixXlDmgF1k5Ftglx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(22082099003)(56012099003)(18002099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TndEUTR6ZUdSMUV5SVZSQTRPK1NNZUtSc2JWcEptRkpkTGdZOWpHTU05YTMy?=
 =?utf-8?B?bGJibU5ZUHFGZTlSd3BZdnZ2cFFxVDBxZUhORSt5ZkxidXNjdWlEbmhOMHVD?=
 =?utf-8?B?dlBPcTJpWWtkVDM5ZHhzYjNMSzdERVdnVVhwSHQ0Um43aWxKZU9Jckg5RGpI?=
 =?utf-8?B?QXRuZlg5SWRZYVpMN0dpekFWdCtBYlI5RWhhSFRoc3M2N240UTVHbHZndEZ6?=
 =?utf-8?B?ZDlta0lXdTBoNXltd0pZM2V5aVg4UUYvVFRLN25OV3RXS3JXd3ppVkNQTllO?=
 =?utf-8?B?RS9pdUhyRkN1cHdqMHdrbGN3dUZ6bFpvbjR0eGRaWXVQSXZwVnpRY1p6UFh5?=
 =?utf-8?B?UGFqTWhQT1hIekxhVTFtUUlTY2dJRCs0dldnOHNQYjRQUCt0c0ZXSExTREtX?=
 =?utf-8?B?emFFa2lqaWdqNFJWZXBDYXBDNFFyNTdQS1RsZzloeWllOElkdk42cGZRejRJ?=
 =?utf-8?B?QzVFeHRjbTN2VENhbTdrT1RpNVBERXcvTXlRMjZTSTFaVjJkaTIvYXBJNU95?=
 =?utf-8?B?c2UvZXNjM2ZSb1pGalc3REhFVzZNekxwbkJIZjU5ZTZTVEdsbThIVW4rR1l5?=
 =?utf-8?B?aUw0QXA3WlovUGwwR2VSV2JBY0lvOWNnQ0ZMNlJxRVJGZXJnUGt3T0RkS3Za?=
 =?utf-8?B?TjVoUWtLOGRDV3pGbloxcjJhclB3SE9yRTVYR0tQdGNXa2tuSlFtVVlVR3VV?=
 =?utf-8?B?R1M4MWpoRDczU0JoVWVYcUJJQ1hWL21Gd2Mxd3NES1YyVzRZV004Y0FPTTBz?=
 =?utf-8?B?NlVhcm5NTldIdkQ5Vjk5NElHVys2WWs0OXlQbzFkTGwzS3loZlJKMWVkTS93?=
 =?utf-8?B?NHlRc2xyQUJOV0RRM0RYY0JtSVZwRFJENlVnOFBQUFdyeXNaNG1vTGtFNUFR?=
 =?utf-8?B?QUREMjY1V21Rb3RhZWFQQUREd3lwUE52SGFUcERjNDdqUUZxT2d3b2hnanA3?=
 =?utf-8?B?NWJOVllJWHI3VXp4eHZrYzlMWWcraWpsWTIyVEtWaC8rUjk0dXgrZjlTbExv?=
 =?utf-8?B?TDhzMG1iNzR0aE01Vm1HUzhLa3RoZy9oNzRSVTc3TjNJalhlczBvcmJraGhN?=
 =?utf-8?B?UzhGMkxLRm9ZaTRiTGdqVkhyVStHTTRpVnc3emd6ekg0a0lpQlExSmxka2JP?=
 =?utf-8?B?alZ2b0RxczFhVi9FcXo1MVZMY1hOZXJvMHJqVHBiOTkrUWlnYTV2bDdlUmpV?=
 =?utf-8?B?ZEtBdlcvNUxTTHlGcnhmVStuWW5UZkt0VlZEdjY2V0NpUlhiRk42WmVEaWha?=
 =?utf-8?B?NVRSY2w4YVFnRkZwc2tXY2Y1T1FOemtIOHJ3K0QwaS9DbHg0VWszbktxekxK?=
 =?utf-8?B?aURXNEdEbnpmb1hUTllad0U4bmdFSUVram9xdFA0aUhiSTFWVmdsZEY3cC8v?=
 =?utf-8?B?eVM3VTJuQUFodlhPdVRXYTRqY2F3NnZmM3l4RnJRME5qR0J3a3RIVzJUdWhL?=
 =?utf-8?B?Skh2Ymo3QUdTdldpeEN3WkZ2VHYrSjl0cGpMUTRxMEtkTkxmQnFBMUZCQi9K?=
 =?utf-8?B?V0hGVXlNOUN0S0N6UDVWa1NvWHF2Wi9nZFNFQVpjRFhzT3drZTM4d3UxN2cw?=
 =?utf-8?B?b1NBelM4bWZON09tNkFYcFZKeUpQbG1HWTZiTWVFN2lqSDlwZkdpTkkwVTRE?=
 =?utf-8?B?MHpscTlyY21haGE0SC9HNHZjSFd5cml3OEFmK2VkaGNFRmIwZUdKS0Y4V2xI?=
 =?utf-8?B?WVhpVnJvemZ0dTRsM0gvVjg4R1FPU1d1ZjZjTEFNcDRTbGg1cE1SNXJJbUZP?=
 =?utf-8?B?NUlYcUd0MWZsdUVKY3lQdVcwejVZZithS2R3RUU0WkJuNXJJcjdtMXQrMXdw?=
 =?utf-8?B?MVJCVGZSSXM2TWY2Q0VNeUpFN1ZuMkZZZjZvL2VrV1pzZ0c1bHlSdmhFWTYv?=
 =?utf-8?B?d05Zekc0cDhoaFVseE1yc0xZbTVYTFFIS0VKMm1PZ3FoS1ZsMkZsa3lUcVJC?=
 =?utf-8?B?THJmZjBnZzVlbHllSnBRUUFZZFgvV0kyc05HeEg4eHI2d3Avc2hER1E1UXI2?=
 =?utf-8?B?RDlHeHAxRHpWNUJHc2pwdEZIVlZ6blFDcExKNzN2dDU1WlVBcm5pbS9hKzhx?=
 =?utf-8?B?R3Zibml6VStyTG1OREQ1VW52MGhSQTg4L09JbGk3Y1U3QXVsWjdjMDZwVjdQ?=
 =?utf-8?B?LzNXTkxPM3JLODNjckpoMFRVTVFnZklOcUNkcHorbzRMWlZzdXhBVFlBUmtj?=
 =?utf-8?B?WmFFaUxwcWo0bDlBRHV4bXdYY3dKcXdVbVZXd29iMjdHaWdQc29XQkI2UVhS?=
 =?utf-8?B?Sk04VkgyaStxZDQ0amlrVFY0UGxyRWE2NkxnVjlncnNNSEVBTDIyclVQN2p6?=
 =?utf-8?B?ais4YUxMUDlOakFSajZrbTZGanNWL2tXUllzTklUc1NYR1VRemI2cW1pdmYy?=
 =?utf-8?Q?cDmQdPETNbSY+4we39tpJ5+CsXU7QzbZ/QvjQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48EDC079F43A5E4B915001CC20E5DB64@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DEBmV1Jdp9NGAgvaLIRFNi0TVXfbH4RpU+JjJ3biL4AAfsDRJeHoky1efqywNutHa7XAjGjrUBWdNSn4D7EWodUTErl0FIjAl+hh1fzRAjQg1l+HsH3Q5sJkd0MGslk9zxcChr+QdMcfd5OrHxh+ToafJSeq0Nf839WjA2dz+EipugndV4lSK2vKD5ut0l1s5LeRMyAh4EAkOEJN2Hb3QeUMTpMdxN3BW4bDuQOdUqIbBCzIIkiZ5vxrCs/OY29jnJKLPLnTVw627cUYZA+gb3s2uEYP3pSYS6tALUtBSe6RujRO6vkWAdw4uC00/E9dvoVfxNlamKGHqedgsT0GeA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e6280d-1604-4d0c-fb6c-08deb6a07fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 18:49:18.6566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/3mPPPNvgtNE//cOCU0jQIqiviw0NVy6yxGc6DJ7NKRv2rQsorxI1m2oho7XgbXhA2ukzdbPPFbFqO9IfqiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6666
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LsQqFG_IbrxxtHXxEfXtj1l90hw9r6-S
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0e0232 cx=c_pps
 a=SqiBG769zjf53VTvhFyIdA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=IwYZnHCrTWuxvp6nU2IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5QC0N8NPKonK12fYyr4ZYxxjZjhoj49j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE4MiBTYWx0ZWRfX/ZdcPi1ULDK+
 7slAYyMpuL2fyxJsYCJhcBCP1GcwNGFOgmyhLtSOzbTGpC2NfG+Ut7Y04emqWAR6ixzJS2PWciz
 An+msZu3VZXfNpGH8MUJ2De0ool+vnIcAPPH38TRe6NgTM2yUoynhb+ZpM6b1ZlPlVQAgkVl+r0
 X5raSk//Oowz7PtlX4gDneWCc8RmYzH/0vvQyNEPeD11tEmKqPq4YXReVYsaES/P2dKHtX3KzQm
 ua6O+ExBvEEZzFhY9SvIk2aFJhiT6JIzNkUbWRVAYBxdZcMn4Ijs2xaXMypZK6grOpoV1RDY4RT
 vDwrrs2o+1gHeXDfWD2HruD0ypbA8gsU3ZDfIf9BcVQGtMvHcnnmiNFse/bAfgkkjKK/CPjTiEQ
 NtWuWYtl4uzK5wXESM1zqqCKNosvUF+zvxI+ZAarDdJOV5h+mJ045Rl31eXLyf6RzI85XLQxSyF
 jzg/6IXulRlCOeidGaw==
Subject: Re:  [PATCH] ceph: Fix ERR_PTR(0) in ceph_mkdir()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200182

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDE3OjU0ICswODAwLCBIb25nbGluZyBaZW5nIHdyb3RlOg0K
PiBXaGVuIG1rZGlyIHN1Y2NlZWRzLCBjZXBoX21rZGlyKCkgc2V0cyByZXQgdG8gRVJSX1BUUigw
KSB3aGljaCBpcw0KPiBpbmNvcnJlY3QuIEl0IHNob3VsZCByZXR1cm4gTlVMTCBpbnN0ZWFkIGZv
ciBzdWNjZXNzLg0KPiANCj4gRml4ZXM6IDg4ZDViYWY2OTA4MiAoIkNoYW5nZSBpbm9kZV9vcGVy
YXRpb25zLm1rZGlyIHRvIHJldHVybiBzdHJ1Y3QgZGVudHJ5ICoiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBIb25nbGluZyBaZW5nIDx6ZW5naG9uZ2xpbmdAa3lsaW5vcy5jbj4NCj4gLS0tDQo+ICBmcy9j
ZXBoL2Rpci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9kaXIuYyBiL2ZzL2NlcGgvZGly
LmMNCj4gaW5kZXggYmFjOWNmYjZiOTgyLi5hYjdmN2I3MDE2YzYgMTAwNjQ0DQo+IC0tLSBhL2Zz
L2NlcGgvZGlyLmMNCj4gKysrIGIvZnMvY2VwaC9kaXIuYw0KPiBAQCAtMTE2Nyw3ICsxMTY3LDcg
QEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKmNlcGhfbWtkaXIoc3RydWN0IG1udF9pZG1hcCAqaWRt
YXAsIHN0cnVjdCBpbm9kZSAqZGlyLA0KPiAgCSAgICAhcmVxLT5yX3JlcGx5X2luZm8uaGVhZC0+
aXNfdGFyZ2V0ICYmDQo+ICAJICAgICFyZXEtPnJfcmVwbHlfaW5mby5oZWFkLT5pc19kZW50cnkp
DQo+ICAJCWVyciA9IGNlcGhfaGFuZGxlX25vdHJhY2VfY3JlYXRlKGRpciwgZGVudHJ5KTsNCj4g
LQlyZXQgPSBFUlJfUFRSKGVycik7DQo+ICsJcmV0ID0gZXJyID8gRVJSX1BUUihlcnIpIDogTlVM
TDsNCj4gIG91dF9yZXE6DQo+ICAJaWYgKCFJU19FUlIocmV0KSAmJiByZXEtPnJfZGVudHJ5ICE9
IGRlbnRyeSkNCj4gIAkJLyogU29tZSBvdGhlciBkZW50cnkgd2FzIHNwbGljZWQgaW4gKi8NCg0K
SSB0aGluayB0aGF0IHRoaXMgbW9kaWZpY2F0aW9uIGRvZXNuJ3QgbWFrZSBzZW5zZS4gVGhlIEVS
Ul9QVFIoMCkgcmV0dXJucyBOVUxMLA0KYXMgZmFyIGFzIEkgY2FuIHVuZGVyc3RhbmQuDQoNCiAg
c3RhdGljIGlubGluZSB2b2lkICogX19tdXN0X2NoZWNrIEVSUl9QVFIobG9uZyBlcnJvcikNCiAg
ew0KICAgICAgcmV0dXJuICh2b2lkICopIGVycm9yOw0KICB9DQoNCkVSUl9QVFIoMCkgZXZhbHVh
dGVzIHRvICh2b2lkICopMCwgd2hpY2ggaXMgZXhhY3RseSBOVUxMLg0KDQpUaGFua3MsDQpTbGF2
YS4NCg==
