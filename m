Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155863815E1
	for <ceph-devel@vger.kernel.org>; Mon, 18 May 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129629; cv=fail; b=k3Q+qEEDnaLn6tgfs3CN0vfeRjMCJkrX+WFRADbVE1cFID2E15J+02GMqVUX7iuZoy+vxNHl+BWmIFTVrLaGgxSSLEV+9ESNJhTnMZLIVR2asYGOwf40natP8wXiATs6mhsTY+uAH4/dtnNq0Z1WaHZJkM3hYSajQqi0hsGWm3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129629; c=relaxed/simple;
	bh=bBWvAOOR0ZSgiJZlpM62I921oWPuAdFUXvf4H0Wqajg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=idN8+TNWmJKXk4nuvJn27W9jzlRUy59q+xSVlOAhkg6Ylovlt0VP85+WCqmOzImwUo/9vUCtzP/tP3uMvC3ebCgogkIzHxTpYrHENB+mm+7NSFi2ph3gnc89v3xmA72xL4gu9CpcdCzTtdnyTYhY9BU9v1tfOHMcDCH5ua3nz8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FxrtNwwt; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FxrtNwwt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I6pVK93913287;
	Mon, 18 May 2026 18:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=bBWvAOOR0ZSgiJZlpM62I921oWPuAdFUXvf4H0Wqajg=; b=FxrtNwwt
	BltpCFRrH9aEeGkr7D2LQ2At5WJNIEgXnfqpEYm4CRIZGMU+q1ZajUHckhFzO17+
	E3rcQvSfl3UoxulpfiYk1qvKdsMgiMc7zGLcrwJ/ZNoXkteXrWVtsFFEDStwQsyr
	VkrzucCp6xITUJar+yqQN5QrLepf3rX4af27RS9byTPJDTV0XkPbmDR4ZL1UjVao
	0+rZ456HvOh/0jryjQ9dvdEB43z5tdNKTe/C9gRKSlxriA5LHDHvTkqmxBHP2cyI
	2IgOUe5CsLVn03YrHbs3wSlp+Eiww6Tcc+dLn/SJWH/PN0kXsQbr/YmjlvyfOQSm
	2vEZZtQGJ4zlHw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xsjn1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 18:40:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkKOP6LWRO8t+vj+fmVEzSsGmTxg5+BciGgA/3+6J+LWXd/nYaNO/DQgkwgG2OYlYfMk/S76cOg3qX1nxVGrqG7VXtvSZSlFY9OLxSie3O8+LtSBSbfVFPGnA5EVQAmAqPQmdqIrW9+zAy0cAcTv8KhOS2iJTsnfDmiWW2aTUiKq4SDTP7wr0xS2ecWVYG0vi2DFD+kS/kK+kDgTHPtXLia/XSD0u+Yaj1HDmD4dvzw6eBXPx8TuyVUZSeafh8iC39v9eM12dLyDvJywumpAHmccPAyp7oq1hl72q3ykuBboLqLcvQipujY55ncwNGt9hu1veWIOLapuoaDKMzvHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBWvAOOR0ZSgiJZlpM62I921oWPuAdFUXvf4H0Wqajg=;
 b=VsbfvrVbLWdJNnhx2X9D0ES4muHUdH8IBuhNNvhUoGUpTb8PX5RxGzQnKg3VvSApL9iX21G5RhXoaxm1mimi294yk8jnEWudlUibNN4upzBnbKiY5cTk8DSkliZWXnmYaYiteaSiXEBMaHF/28jcwnHCuABqJcWitBMzsVV+AcvLxq4Nxjm4q+UzBKISnz6lQnNfiOx5eWIa4Lg1/KropNGYBgdx5yPSKZI6ZlFWUVbyrfY8P0QdYDRTkkTm+cTdT1mPol8S0cjxFw5l2LkPJ5Ifs0myNyRu2V3koBnxtHm1h/Nh+B9HReNsjjbGFnTONfO3d0uxAyTK3q/dQA4hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA0PR15MB3886.namprd15.prod.outlook.com (2603:10b6:806:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:40:15 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 18:40:15 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "security@kernel.org" <security@kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Subject: Re: [PATCH] libceph: Fix out-of-bounds writes with oversized monitor
 reply messages
Thread-Topic: [PATCH] libceph: Fix out-of-bounds writes with oversized monitor
 reply messages
Thread-Index: AQHc5vXEPDa34aVR1k+UdjREmAzWlA==
Date: Mon, 18 May 2026 18:40:14 +0000
Message-ID: <1de39d9ee01ebbaa17b1aa0b61a462c843e84ed0.camel@ibm.com>
References: <3f154565-9f37-40aa-b34a-be6f5c2b4463@tu-ilmenau.de>
	 <20260515133129.1595265-1-raphael.zimmer@tu-ilmenau.de>
	 <f919b66a7cc03dfd22231b87353ebeaf864e3d0a.camel@dubeyko.com>
	 <acc9afe112e83e42a5c1d3a1560bed2cd3554900.camel@ibm.com>
	 <1aeaa00c-d83f-4788-a5f6-5dfe1c1b70f7@tu-ilmenau.de>
In-Reply-To: <1aeaa00c-d83f-4788-a5f6-5dfe1c1b70f7@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA0PR15MB3886:EE_
x-ms-office365-filtering-correlation-id: 1136a911-1acd-484e-e88c-08deb50ce6da
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021|56012099003|22082099003|18002099003|4143699003|11063799003;
x-microsoft-antispam-message-info:
 5LP0bb0jWKDjjTN+VYo2oyR9VwAEAjJIHKw/6l6/NwraLqiO/c5q3uTTBCapteqeno+lDYUVysosLlOOtaZdSAiIecHSD5RkuOR1zeAq79HTHI3Sx07IdkhrFrFHb8cuL2WFX73LyAQd1lHlzws/p/LdfMJsnFU025W4yOXE2+dUuCJ73FB0G1PRtRclZ0jARXZyuzvDOLNTKZGj5XY+8oi+WgYbs0M188hs5nhd6Ivwe4x87LRycQGXU9MbGOkLax16kSQtFsfHCtt0geyF0VvETP6aPxh5/O0AUwDsxZV2Ahzi9Ng2LN2k7bfzmy25kRRWWgXdkgICcTnSCGtvmCwGKdjP18imFDJO3ncOIzJDD/uyHBRutpxqyQYKWHOjXJPUUfmnCr5nGvnt06qyhekei4poOriPgSol39x1+Bp2Lq74GByXHLMmwZQayyyU5jdWpmY+0iCG8gUj6Y+HSmBwa86OU2KWPrb1xrmGlmtQZt5vdDzYufna3fzwBfuKe3sE/HpHnc7ONjWS3Iae++rsuVhyAAP54+EEJksjlgRBt+p3OwWLCfDI00XfCWldYJFjAz4ZL27t1P2j0Eh742eNwTG1LcJHYQZfi2SnXD7zYzndHBPc/Xlh4JeKZJufG+REOX5Hh6tkbrNESzLknmpwR09U3XGauFyYTC57wUtvCczHAFtBBR2ifl9ZodtxUTN2RmYI2XLYpljAlqB3OtGMhv2QljlAV2aLxVl9u9AjaKjrpKAU2JvbdYgWkj8k
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1ozYlh0dFYrdXM1Z2JtdlJmVjVQWjZ5TVhwVkUzY21RdU94VkZPNzhmd3NN?=
 =?utf-8?B?Rmp2MWdGRitZTHVZNzlHU3VUSUlJcjhMcWw2M25RSERyNU14ZEtiUVNVWDlo?=
 =?utf-8?B?cDhmaGJnTUxSem1ld0pYRGx2ZXMzWlk4T0xtQ29MKzJrSk95dDNHWUcwTUtn?=
 =?utf-8?B?RW9pNHFhNU1leWFCSTc4M3BZYW9MTkQrS2kvUmhIN3Bady8xbnhSQ1F5Wkl4?=
 =?utf-8?B?ZkM3SUM3eGF0NnhjU3djWVR6TVVXYTBaSDhFa3BMdzZ5Rm1qc0ZaRCtyalUw?=
 =?utf-8?B?dmxiYUV1bEZwaGpNZ3hRVnNiYjNxOTFCMVYwT0hVY1psdzMrNmlGRW1rTzln?=
 =?utf-8?B?RVpmZUdPMnJ0VlhhRlZHZnY1c0NsWWJmTHJ5T2c2ZHZKOXo4eTFuWDVDUFRv?=
 =?utf-8?B?VUNieDNIaU85ZktXdTRTWEVNa2srcVJ1NUZlVm10Q1VMTE9DbEFreUxmbE1m?=
 =?utf-8?B?eVVKLy9WTGdDbmZmUnc0dnNUQjlqTFAwRlFpdzVyNmNKdUJ2M0wyTzlpT0lN?=
 =?utf-8?B?UUcwVlE3QjFJeWFnQmNXZElGcUlka3RKOUFIb3I1dk5WaDJMUGx2TmNQaDBu?=
 =?utf-8?B?aUFFRHVhTHdDcldYeFNwY0pjdjhZOG1CZXNVRU5qcU1CNVNnNnNGNlRzR0Nw?=
 =?utf-8?B?Um0vRWFna3pTWDhOZURoTGMrTGNZbnFjWkhZZVl5c3ZpemI1WGRFOUNPdlU1?=
 =?utf-8?B?cGQzZG9rOUsrQTM0VExzZjd3M0pGS2lqc09aUnFEOEl5YVRQdnBma0cwc09K?=
 =?utf-8?B?ZzJxVU52S2dnbGoxdFc1YmtnVDVocUY0VDd2WWZtWVVDTHZjVXZJUGdwMklR?=
 =?utf-8?B?dXhKS3BjQzE5MHJ6anRXYVdVSVJNc3U3OElwYU5YdWlkTElaalRhaUUwOGJW?=
 =?utf-8?B?QjU5cTBFQnBRdUZ5YmFhZ2VQZUYxT3ViK2h1aVJ2bXIwa25hN3VFWlpBUUoy?=
 =?utf-8?B?Sko5Tnd4M096NXhyMkhtcVhycjAvNGxmbU9lK3ROc3c3MHkxNGRKTXZWNHdG?=
 =?utf-8?B?Uk9WajMyNlNOWTR6UHkxTlJ5RWtsVXpGVTg4NDMvc2w1SkNudUhTUWtvbkQ4?=
 =?utf-8?B?Z2hlM1hGLzNGZVFOd3ZoMkIvWUFyVWhLWXlNbG1zSzJlU2lRaTNxSVh4cm1o?=
 =?utf-8?B?MUx2OHV4VC9NNjI4ejU2ZGZFbVAzKzZZV0lYN01rVmR6aFJpbWVDOG9aNWRC?=
 =?utf-8?B?NldSUU1Jczkzb3Z4RENwM2lnL3FVRWtnY2xTNXArOURrMnpscXNPKzRWcXZ5?=
 =?utf-8?B?cTVmak15R1lYSmVxZXd4Yk10TXB3VnRkVU84ZUJoWEgrYTBCRVYybTV0T0c1?=
 =?utf-8?B?cWs5MWc3QmNQcURvTVdOeFNkSXFuVWpDMDhmZGZTMFFucnp2ZW83R0R3L3pQ?=
 =?utf-8?B?enFtbWE2Z24veFE0RTlTNEdDUjhabTl4THdKMFAwekl0SUthbDFVRjhTeHll?=
 =?utf-8?B?N2pYZVhVRTgvUnV2a2N2NG9TZUplN1VPeFRSSTJIOUduVUQ4UWVNN0xQV3Qr?=
 =?utf-8?B?UnM3T3Y4Lzk5Z0pxazZBbkxpNnFwUnlleVJ5QlIxNVF2UGJ1VEJHbk9LWmRJ?=
 =?utf-8?B?b0xFTVR6TkpZQWY2eHR0bk9MRjFGT0thSlZLM01semxrbGdEUzlOUFRqcCth?=
 =?utf-8?B?UUJ3RjVWTnRSWDFGQzdSTFJWWjNrNVlNUklPSnFVSW8vRTlVcDAwRlRQZzhO?=
 =?utf-8?B?enQ3dHRYSEhvanFIVHFSRFA1b3ZqYms0M0hvV2xGWEVVQURzL05ya3lJU2xD?=
 =?utf-8?B?dzQrWUdVbm1Pd0l0NkJIc0lSZEQ2Y0gwYytkWFZqbXNIK1lyeHBTYUo3aURq?=
 =?utf-8?B?N000VllnR0tXT2x0dkQ5bTZEbDI0T0tqUEpUekpCeFYxelg5MC9YVEEzcFkz?=
 =?utf-8?B?SFJoaDIzeVJSOG5FbkVPN1g1ei95NFBuWlZyNEEvUENKYUN0VXdxcVVXVENH?=
 =?utf-8?B?bThrNS9ZdWNsZEdQcFptT3FtSW1RRkkwRDRJeE5PUldETVRWQzhDMHdQaVVn?=
 =?utf-8?B?SGxOMW1YTitXV2tML2RpOUhZQ0cxYmxlNktMOGpleVRjaU5iZVJsRzNpTWJu?=
 =?utf-8?B?TGpZaTFSUkNsYXgzYmxvMkZJOU5xWmQ3WGJLeHdyL0p0c3NXazR2UVAyOEdG?=
 =?utf-8?B?MWxQSVdQTDA3QW0zTGxSaXZmbTJPK09JWWh3bnk3dVZoRmJBSW90bDloUEtp?=
 =?utf-8?B?MXRyOVVINDYyaWJiV3hld1hwNWdmamVZejIvR0pjL01pNnUzeFJNVGc0TnVU?=
 =?utf-8?B?ZWUxVWJ4eThDMUFEejc1T0l3VEZXOEFwMmVxczkvdDBVOWRDQ2VibGZVd0w4?=
 =?utf-8?B?Yk0ydVROMEJsWUZIbzBiUktkbFVPS0FENlhTaW5EQmI5SHo4UnIwRUREMGhI?=
 =?utf-8?Q?PR9vxSa4q2A6urAZaq6+128/UERdloY/IahxQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19D62B8FF8B88E458D039F7DD368325A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Q9UJxp5KyUU+0mrfuqcv8MLq7Armf90lQCMRhspYvqq4Jdo5IpMEV9iuQDM8te8zJA7ye5xtJ8wlLMlPjcCKmkmp/aJneSUrO/CXxdHUOA/bmIZgj7ZHBcrVw1rBLzYHZq8lmuZQXLIe6zrI+57+UmWrecsnF6ToVWOEzueJFZG5OqK6FryGrhsaDlfn9hQU05W3A6VdHNu2rsj1yByjOnq2PKW2jKDTby3lAoQp0I93vpzvgVd6gFZyLIJRpfs3adPfgJ7ZaEp+CG8vX5YpLyc+4NLPXPDkO3GqJ38Zy6twida+zreCGfhhs48LQEIhLBQEyJ273bWXGcsAI+KNYg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1136a911-1acd-484e-e88c-08deb50ce6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 18:40:15.0022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwzA3sPgj/6/ZII/XL9Kju2WWkqUdtmZcpGyLHI8YhlPraRjBe4iysfkdXk3D/d9FYfTN0OgxRhJTJZNa7jlWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3886
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4NCBTYWx0ZWRfX0YqP5y8BWOqa
 1OA0jxa4WLW/xNBC4NMebkf2NI72dPmuFKrGZodZQrIqb/2CFY0hXZbP5R6Xr9GpET5Ka7ztONd
 KLBbIcPBowKNWIw2OVRZZKpX2W4olsAAv2msV2Xx4vJRzJ6cCkp7m0Kh0YxQBWuY09n5r8rLyn8
 SrTgqEh5BRejgMKNrEpeTdNP4vEHBAKVzVS/xTD3TIZu9lIA2benL3AXb7+oA/2ZtMUgekYzUuS
 IEAtEf/Hzalboy2E4sC3rQnn+wdXayKaVwduQmjwt654Kf4h/3I2LMJAqj/fzosZZjgRaqGT53k
 kF4ZjfiNg8GZ9fAkhkHm6i9bs1Rw0og/83dxuJJV2R2mo8jzsxM8mvsaCh4EkBM6XSFQnDMWr5D
 LpQVCyLOWf9aX4+GN6Ja8vxLsRzwTygoMYcm5AAhXoq23pP3KvYyn7Qxdm/JJg+g9iBrks9G2Qg
 6t/ZLiS9nC6yOISEApg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0b5d12 cx=c_pps
 a=LBR8CsJoUNkXwF8+XrmcNA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=H2r022sgr4EAamKu5UAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xOVJ9JP-1GCyET5GYBWCrPPU3VjNts8I
X-Proofpoint-GUID: A_0WXHzR6_cSnEJ3qJ-ZkgX4NJRHln80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180184

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDEwOjMzICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gMTUuMDUuMjYgOToyMiBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9u
IEZyaSwgMjAyNi0wNS0xNSBhdCAwOTo0OSAtMDcwMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3Rl
Og0KPiA+ID4gY2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiANCj4gPiA+IE9u
IEZyaSwgMjAyNi0wNS0xNSBhdCAxNTozMSArMDIwMCwgUmFwaGFlbCBaaW1tZXIgd3JvdGU6DQo+
ID4gPiA+IFdoZW4gcHJvY2Vzc2luZyBhbiBpbmNvbWluZyByZXBseSBtZXNzYWdlIG9mIHR5cGUN
Cj4gPiA+ID4gQ0VQSF9NU0dfU1RBVEZTX1JFUExZLA0KPiA+ID4gPiBDRVBIX01TR19NT05fQ09N
TUFORF9BQ0ssIG9yIENFUEhfTVNHX01PTl9HRVRfVkVSU0lPTl9SRVBMWSBvbiB0aGUNCj4gPiA+
ID4gbW9uaXRvciBjb25uZWN0aW9uLCBhbiBhbHJlYWR5IGFsbG9jYXRlZCByZXBseSBtZXNzYWdl
IGZvciB0aGUgZ2l2ZW4NCj4gPiA+ID4gdHJhbnNhY3Rpb24gSUQgaXMgdXNlZCAoaWYgZXhpc3Rp
bmcpLiBTdWNoIGEgbWVzc2FnZSBoYXMgYQ0KPiA+ID4gPiBwcmVhbGxvY2F0ZWQNCj4gPiA+ID4g
ZnJvbnQgc2VnbWVudCB3aXRoIGEgZml4ZWQgbGVuZ3RoIG9mIDY0LCA1MTIsIG9yIDMyIGJ5dGVz
LCBkZXBlbmRpbmcNCj4gPiA+ID4gb24NCj4gPiA+ID4gdGhlIG1lc3NhZ2UgdHlwZSBpdCB3YXMg
YWxsb2NhdGVkIGZvci4gVGhlIGFjdHVhbCBsZW5ndGggdG8gcmVjZWl2ZQ0KPiA+ID4gPiBpbnRv
DQo+ID4gPiA+IHRoaXMgYnVmZmVyIGlzIHJlYWQgZnJvbSB0aGUgbWVzc2FnZS4gSWYgdGhpcyB2
YWx1ZSBleGNlZWRzIHRoZQ0KPiA+ID4gPiBhbGxvY2F0aW9uIHNpemUsIGRhdGEgcmVjZWl2ZWQg
ZnJvbSB0aGUgbmV0d29yayBpcyB3cml0dGVuIGJleW9uZCB0aGUNCj4gPiA+ID4gZW5kIG9mIHRo
ZSBhbGxvY2F0ZWQgYnVmZmVyLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBwYXRjaCBmaXhlcyB0
aGUgaXNzdWUgYnkgYWRkaW5nIGEgY2hlY2sgdGhhdCBjb21wYXJlcyB0aGUgbmVlZGVkDQo+ID4g
PiA+IGZyb250IHNlZ21lbnQgbGVuZ3RoIHRvIHRoZSBwcmV2aW91c2x5IGFsbG9jYXRlZCBsZW5n
dGggd2hlbg0KPiA+ID4gPiByZXRyaWV2aW5nDQo+ID4gPiA+IHRoZSBtZXNzYWdlIGJ1ZmZlci4g
SWYgdGhlIG5lZWRlZCBsZW5ndGggZXhjZWVkcyB0aGUgYWxsb2NhdGlvbiwgYQ0KPiA+ID4gPiBu
ZXcNCj4gPiA+ID4gbWVzc2FnZSBidWZmZXIgd2l0aCB0aGUgbmVlZGVkIHNpemUgaXMgYWxsb2Nh
dGVkIHRvIHJlcGxhY2UgdGhlDQo+ID4gPiA+IHByZXZpb3VzDQo+ID4gPiA+IG9uZS4NCj4gPiA+
ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhcGhhZWwgWmltbWVyIDxyYXBoYWVsLnppbW1l
ckB0dS1pbG1lbmF1LmRlPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBuZXQvY2VwaC9tb25fY2xp
ZW50LmMgfCAxMSArKysrKysrKysrKw0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvbW9uX2Ns
aWVudC5jIGIvbmV0L2NlcGgvbW9uX2NsaWVudC5jDQo+ID4gPiA+IGluZGV4IDY2YzBkNmQ2YjMz
ZC4uYjg0ZGQyYmZlNzdiIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9uZXQvY2VwaC9tb25fY2xpZW50
LmMNCj4gPiA+ID4gKysrIGIvbmV0L2NlcGgvbW9uX2NsaWVudC5jDQo+ID4gPiA+IEBAIC03MTIs
NiArNzEyLDggQEAgc3RhdGljIHN0cnVjdCBjZXBoX21zZyAqZ2V0X2dlbmVyaWNfcmVwbHkoc3Ry
dWN0DQo+ID4gPiA+IGNlcGhfY29ubmVjdGlvbiAqY29uLA0KPiA+ID4gPiDCoAlzdHJ1Y3QgY2Vw
aF9tb25fY2xpZW50ICptb25jID0gY29uLT5wcml2YXRlOw0KPiA+ID4gPiDCoAlzdHJ1Y3QgY2Vw
aF9tb25fZ2VuZXJpY19yZXF1ZXN0ICpyZXE7DQo+ID4gPiA+IMKgCXU2NCB0aWQgPSBsZTY0X3Rv
X2NwdShoZHItPnRpZCk7DQo+ID4gPiA+ICsJaW50IHR5cGUgPSBsZTE2X3RvX2NwdShoZHItPnR5
cGUpOw0KPiA+ID4gPiArCWludCBmcm9udF9sZW4gPSBsZTMyX3RvX2NwdShoZHItPmZyb250X2xl
bik7DQo+ID4gPiA+IMKgCXUzMiBkYXRhX2xlbiA9IGxlMzJfdG9fY3B1KGhkci0+ZGF0YV9sZW4p
Ow0KPiA+ID4gPiDCoAlzdHJ1Y3QgY2VwaF9tc2cgKm07DQo+ID4gPiA+IMKgDQo+ID4gPiA+IEBA
IC03MjEsNiArNzIzLDE1IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tc2cgKmdldF9nZW5lcmljX3Jl
cGx5KHN0cnVjdA0KPiA+ID4gPiBjZXBoX2Nvbm5lY3Rpb24gKmNvbiwNCj4gPiA+ID4gwqAJCWRv
dXQoImdldF9nZW5lcmljX3JlcGx5ICVsbGQgZG5lXG4iLCB0aWQpOw0KPiA+ID4gPiDCoAkJKnNr
aXAgPSAxOw0KPiA+ID4gPiDCoAkJbSA9IE5VTEw7DQo+ID4gPiA+ICsJfSBlbHNlIGlmIChmcm9u
dF9sZW4gPiByZXEtPnJlcGx5LT5mcm9udF9hbGxvY19sZW4pIHsNCj4gPiA+ID4gKwkJcHJfd2Fy
bl9yYXRlbGltaXRlZCgiZ2V0X2dlbmVyaWNfcmVwbHkgJWxsdSBmcm9udCAlZA0KPiA+ID4gPiA+
IHByZWFsbG9jICVkXG4iLA0KPiA+ID4gPiArCQkJCcKgwqDCoCB0aWQsIGZyb250X2xlbiwNCj4g
PiA+ID4gKwkJCQnCoMKgwqAgcmVxLT5yZXBseS0+ZnJvbnRfYWxsb2NfbGVuKTsNCj4gPiA+ID4g
KwkJbSA9IGNlcGhfbXNnX25ldyh0eXBlLCBmcm9udF9sZW4sIEdGUF9OT0ZTLCBmYWxzZSk7DQo+
ID4gPiA+ICsJCWlmIChtKSB7DQo+ID4gPiA+ICsJCQljZXBoX21zZ19wdXQocmVxLT5yZXBseSk7
DQo+ID4gPiA+ICsJCQlyZXEtPnJlcGx5ID0gbTsNCj4gPiA+ID4gKwkJfQ0KPiA+ID4gPiDCoAl9
IGVsc2UgaWYgKGRhdGFfbGVuID4gcmVxLT5yZXBseS0+ZGF0YV9sZW5ndGgpIHsNCj4gPiA+ID4g
wqAJCXByX3dhcm5fcmF0ZWxpbWl0ZWQoIm1vbiBnZW5lcmljIHJlcGx5IHRpZCAlbGx1IGRhdGEN
Cj4gPiA+ID4gJXUgPiBwcmVhbGxvY2F0ZWQgJXp1LCBza2lwcGluZ1xuIiwNCj4gPiA+ID4gwqAJ
CQkJwqDCoMKgIHRpZCwgZGF0YV9sZW4sIHJlcS0+cmVwbHktDQo+ID4gPiA+ID4gZGF0YV9sZW5n
dGgpOw0KPiA+IA0KPiA+IElmIEkgYW0gbm90IHdyb25nIHdlIGhhdmUgYSB3cm9uZyByZWZjb3Vu
dCBvbiB0aGUgbmV3IGJ1ZmZlciBpc3N1ZSBoZXJlLiBXaGF0DQo+ID4gYWJvdXQgc29tZXRoaW5n
IGxpa2UgdGhpcz8NCj4gPiANCj4gDQo+IEhpIFNsYXZhLA0KPiB5b3UncmUgcmlnaHQsIHRoZSBj
YWxsIHRvIGNlcGhfbXNnX2dldCgpIGlzIG1pc3NpbmcuDQo+IA0KPiA+ICAgfSBlbHNlIGlmIChm
cm9udF9sZW4gPiByZXEtPnJlcGx5LT5mcm9udF9hbGxvY19sZW4pIHsNCj4gPiAgICAgICBwcl93
YXJuX3JhdGVsaW1pdGVkKCJ0aWQgJWxsdTogZnJvbnQgJWQgPiBwcmVhbGxvY2F0ZWQgJWRcbiIs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICB0aWQsIGZyb250X2xlbiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlcS0+cmVwbHktPmZyb250X2FsbG9jX2xlbik7DQo+ID4g
ICAgICAgbSA9IGNlcGhfbXNnX25ldyh0eXBlLCBmcm9udF9sZW4sIEdGUF9OT0ZTLCBmYWxzZSk7
DQo+ID4gICAgICAgaWYgKCFtKSB7DQo+ID4gICAgICAgICAgICpza2lwID0gMTsNCj4gPiAgICAg
ICAgICAgZ290byBvdXQ7DQo+ID4gICAgICAgfQ0KPiANCj4gKnNraXAgc2hvdWxkbid0IGJlIHNl
dCB0byAxIGhlcmUsIGJlY2F1c2UgdGhpcyByZXN1bHRzIGluIHNraXBwaW5nIHRoZQ0KPiBtZXNz
YWdlIGluc3RlYWQgb2YgcmV0dXJuaW5nIGFuIGVycm9yIGZvciB0aGUgZmFpbGVkIG1lbW9yeSBh
bGxvY2F0aW9uLg0KPiBJbnN0ZWFkLCB0aGUgbnVsbCBtZXNzYWdlIHBvaW50ZXIgc2hvdWxkIGJl
IHJldHVybmVkIHdpdGggKnNraXAgPSAwLg0KPiBUaGlzIHJlc3VsdHMgaW4gcmV0dXJuaW5nIC1F
Tk9NRU0gZnJvbSBjZXBoX2Nvbl9pbl9tc2dfYWxsb2MoKS4gVGhpcyBpcw0KPiBhbHNvIHN0YXRl
ZCBpbiB0aGUgY29tbWVudCBpbiBjZXBoX2Nvbl9pbl9tc2dfYWxsb2MoKToNCj4gIk51bGwgbWVz
c2FnZSBwb2ludGVyIG1lYW5zIGVpdGhlciB3ZSBzaG91bGQgc2tpcCB0aGlzIG1lc3NhZ2UsIG9y
IHdlDQo+IGNvdWxkbid0IGFsbG9jYXRlIG1lbW9yeS4gIFRoZSBmb3JtZXIgaXMgbm90IGFuIGVy
cm9yLiINCj4gDQo+IFdvdWxkIHlvdSBhZ3JlZSB0byBsZWF2aW5nIHRoZSBjb250cm9sIGZsb3cg
YXMgaXMsIHdpdGhvdXQgYWRkaW5nIHRoZQ0KPiAib3V0IiBsYWJlbCBhbmQgc2ltcGx5IGFkZGlu
ZyB0aGUNCj4gCW0gPSBjZXBoX21zZ19nZXQocmVxLT5yZXBseSk7DQo+IHRvIHRoZSBtICE9IE5V
TEwgY2FzZT8NCg0KSSB0aGluayBpdCB3aWxsIGJlIGVhc2llciB0byBtYWtlIGFueSBjb25jbHVz
aW9ucyBkdXJpbmcgdGhlIHJldmlldyBvZiBzZWNvbmQNCnZlcnNpb24gb2YgdGhlIHBhdGNoLiA6
KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg0K
