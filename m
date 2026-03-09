Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295712745E
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082182; cv=fail; b=aux4JjXbn1rBtHJSSj7pTgx4KVgn+QQluosCrPpiVIH5O+IWnX3+ROesZCBWPbXVdOQVqWNLEfUQZ5ztWFUhwebvVBuF2CCeNRSIenSx8FsRSPclYATOCfoGcXGLPLQwPEvzW5lpGp1BcAPPdZGJxwEGCZJ+I4Vy4/AEKYLEhWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082182; c=relaxed/simple;
	bh=t5HSZCNIGmTHwfiueNW7nuePJJ+6upTxA1coKZB1K+o=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=XdK91HPf0rvGU8m5g0ZVlsc1gPVivPDKHZuKTN2IkFBjNG2fONZQ69r7G/yM5IU0+M9dAMiKKy6RvWOcaUuoT1ynQwCRjXjb4S826nA6oCXz6kpZcb0kKQH4oPwHFWsPW2TPNx2eTfP1amsyD30kAlYv8bbCcGW6Y1j7VWmiUSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B+F3TUYN; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B+F3TUYN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HW7pe2350421;
	Mon, 9 Mar 2026 18:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=t5HSZCNIGmTHwfiueNW7nuePJJ+6upTxA1coKZB1K+o=; b=B+F3TUYN
	tYLiutaAyiSn/g14AHbX2CNdP6wiMWm2Eo6TEqxWVTXhvXSz8JRPHnQuwBf0F4Js
	D7zOcaKLrRL0rSdgoaZv8N4Y1Wq71LmfZTznzNCD0bpEfg4WkADI7xZCiM3/dXrE
	sksLyYt4qrEqPmQgPhRDIEx5PGXQ5DS7U5s8IDEQytHYv7ATjXJMEB+/VlVG9CUo
	pBNiuhaJXz1mA0hpPJaYeliBdSqkx/vIlKt6n1oH3TwNVTTKjvvkSNscAEHxH0Sf
	DA4JzbpehQbLnmtHrbFpq4PzgZCxKQDdOnY2MbuXT97nm2RlSe2BBI343q6N9f+K
	SPTNhuqVPfEQ1A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm8088-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 18:49:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJUrHq3njDO0x4AOexyJssqTUJzvosySiKGkbBPdvnPuwxEQvYE1sbfVNobCk+BW481xMAoV/Ls3cEl5Ob/ujpHwgywYCdPCJzW9eE4MBSN2TwPap6CbwpHKGURFqGJn/2KCi1D8Dm/rLogPW3/OU+csGGNeeYWP6SEenE70x5iuHNG1mRgO+brMxHx2D0sVjWyW+NMoKGPkaJfb5rBezoeSDut4gd5ISJSJdhmiuxgabYz9Tm5ZF3Vp0ODFlbdcwvG61Y7ZAY6rKC4UYAssRI0PMGzec4E0Pn0+WzZllNQaOtcyltPeMvIa6Z+bvavYzWjh7fLoffFW1mVjlQd4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5HSZCNIGmTHwfiueNW7nuePJJ+6upTxA1coKZB1K+o=;
 b=w2jtfLtMs3FyiF2LEsBJAQeBvw4YzCK0Rh5B8f6jl1WqbOnAuEmyqbQbi26dzjoZTH6ZBjCxOIKMEbUyUrKtB4mUIjQHzg/k+gTrfWaCkWtDBf27c9I0AZqiOHxVUcX4I800oVK1c4k2ECiTUBLwXpeMrzxv6aqx27HQq+OjZG6dBKw7gs/szPay3DwmGgbucIXI+EmyMZbyxkLLKXPvudOeCTqfNiMaxwGkNcY+rr3C3Yv8Dts2VFZc47zM7gkd1jyyZiubzbnvQOYVoXKUkf3NZuiwpkpI2Z39HgI+8GDdxTl7UW3Z0xoPtxGxQxxVEOgPYTjS1teIlniBT2OAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB6270.namprd15.prod.outlook.com (2603:10b6:208:44f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 18:49:22 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 18:49:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        Alex
 Markuze <amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] [PATCH] libceph: prevent potential out-of-bounds
 reads in process_message_header()
Thread-Index: AQHcr0gTeTZrFTGoQUuKUjW8EEaRlrWmjFGA
Date: Mon, 9 Mar 2026 18:49:22 +0000
Message-ID: <5815cbe7cb93857effc0757a765a15ef1a2e4cc9.camel@ibm.com>
References: <20260308220804.694227-1-idryomov@gmail.com>
In-Reply-To: <20260308220804.694227-1-idryomov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB6270:EE_
x-ms-office365-filtering-correlation-id: 8630f0a3-f53c-495e-dcd7-08de7e0c943d
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 bcH1oqvex6rrZ4JQ65E/zJ+YY717EqVmWZAgY+NiiILMGh1aG+FNugB03Pdt4U9RkyE/emjRz0NvNGwdlFE3HFpwWD/KQEf3WogoyoHfzMAd9L5u/iPH6j9zrfF4b0y5D57V0aydvWiVjUBy3c4fRR3s8oROYHfR56KHc7L6yWXAx85S7KKYBeMQLKeo9NKEEAZpawsda91/m9r1b+nQL+c3YmeojzQJG0QkHC35iTELqgv1no8q+r6UWwbR885P/HsGgJp+0K5KCnJ6hiS7tkZBefWvKWiHfs4i5PUUdGSwZ3yujQJ7jxrFq7+gNLhiOQMLo4LGBj6wj2TnClm40AJyfN3R9nI4rIYBS5xEi+pyAss3tIcGBRBVQ4fCu/BAwq1o3xKDv/a7aoJLKQlSX6E3QdN5iDEYxpW3VM+88J+mkfUhIrwBVkWB8D2CmZVnPEcPq9vUznpLhcCEZJWlNc9wGXzkAbQ6QgAdAgOKGHhBXdYW/mjCAUE27Mi2rpfM0JXHFFFMHBeBC+q4kOtK65SfXdkZ8XKotGjFzO+G/u4ZV09C5Llll6/W2HwBW7OJZxDdWWQz1TPjWjlJm3CMvIDQqm+lFkG4Ez0WojrtEl4Tsaga3Mv+75gkU0KrX2Y7hoq2tjcPcfOeTIAvxWF3fyih/W0XHXf0AgOIdwcyHp16g8i2SLCFRN6pV8hwyS0zN0A/H43NKt92h0JWiupi0p0LYr4sS3iHlL1HP6VG5Dva5cmMZ4P8b5mAss1WI76u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2hvZU9DR2EvUW1XYndSVDFnYU03Tm1GOW90ckd0VEd5RDVzMWpkMVZSZndJ?=
 =?utf-8?B?SWNpY0xpTkZvcDdHaUtVa1dRWlM4UVl6QXZTRElUbngyVGEzYkp6R3ltS0t1?=
 =?utf-8?B?dVBkL1JvcW9yRnJSVVNRRGo2WldNclVQVDhoNlVPUHh4eVBaeUl5VlMwemRy?=
 =?utf-8?B?anIzOTdQVytOeVg0MzVoa012ejZ0OWpNRTN3U0dnbmhocGtiT0FtZmNXYWJ3?=
 =?utf-8?B?TXU1L0pxWFVBNGdvMGFHamtqRUZiakRGdDZrOXdTQkd5Mm9ZeTRyMlFZS29R?=
 =?utf-8?B?ZDNZS1I0OEdNeit0ME1MQ292ZDZKTlp5Q0xrMmlhc2dvditpUnVrWWFPVFhw?=
 =?utf-8?B?QTliYzI3Mm5HcGhDdUt5UDFrR29hbitSbGRybWNqTU8xVlh1SHRGTDBrWlJy?=
 =?utf-8?B?S2RGZklpR3gzYnI4d1h3eDNaWkFtc2RMa3RGemkycmVaZTBSRWlEaXVWemg4?=
 =?utf-8?B?SjhoRFVUTjlraFh2TUZMZUlFS3VTV3FYN1Btelc4VHAzRFhjRmJwMGV1QXpq?=
 =?utf-8?B?RElzNGF4VkptNGRKdGllV1ErTU5EbE5NNndlbThpUnJEWFFiU2oydFVqUW9I?=
 =?utf-8?B?V1duNStJOHNnejlFUWZ2S0JiNnhzQitialNTVjZxbWE4b25XakUrYjVnaWpx?=
 =?utf-8?B?TzFGYVQ2VEZEdUt6QVdvVmhBUlErVE1KSllZVnBZTE5pditEVzRTaE5aRXZM?=
 =?utf-8?B?c2o3aWFzeklxaWYwaFl6akJRQmwyai8xa1V4TFV6RUpOZ1ZjOFBoVVFnNjB6?=
 =?utf-8?B?OVcrODB5WHRyQWZmSTEzUXFxZUZWS1p1S0JQK01aTDkyY0NLN25GZEwxY0RK?=
 =?utf-8?B?SERZZ2lzdVZ0K3YwOWRKZ3VwdVJveXpPUkx5WC9qSVFxRzg0Rlg0M2dJeUVF?=
 =?utf-8?B?TmFsKzk0UGI2U21hMWIrTlJnN1dLNkwzM0tXOFdsU1JMb1VETjg2OUlHREpy?=
 =?utf-8?B?cE1DZ2VDTDJ3SUJqVThFOGlmZjhmT3ZUVGxobHhJWkxOM1ZjSXZNeE01Q3l6?=
 =?utf-8?B?L05KNEE2dlllQjZrZ0dnTWNRcStTZ295bHRkMDFzMW5xbEQ3NlF5bmZMUVNi?=
 =?utf-8?B?RlBWQy9yQ0lVLy9WZXlTaTAvQ0lVR2lJQ2t5SlhTNmQ4RUJYcG85Q3lEQ2Yr?=
 =?utf-8?B?RkRWM0lKeWNWQ2dZeFlYNzByNk1mWGF4cGJlUG1PQzJJTVZSRjc5c2pSUXla?=
 =?utf-8?B?Vy9LdjRFWmkwTjNyTmI1VUhtL2N1NnRGL3lneWt6bTB5d3JUYlBocEY5U3ha?=
 =?utf-8?B?d3RTd1NmYzkvMDBrUnVWelMxMlk1OHQ3cEh2R3dDMHFNcWhaZTArNDVwdHJI?=
 =?utf-8?B?NE1mUW9NalVXRUthOFhmTDgwSm45U2srVXdEc2hmMkkzQmVWUkoxdnlBVmt4?=
 =?utf-8?B?Vm5kbzlrNHZIYkY4YnpoYW9mcEl0S3lxN2liWUpiZlVnTVRveTFKOVM1cms0?=
 =?utf-8?B?dDhzMFloaHhMMmdDbU52WDc4NWVkZUpodElSQmZtaEthV1VLY3d2bG5ibUph?=
 =?utf-8?B?Y3JJM1JTQjlUT1hNeUdsbzVxYmdlL3RkSkZseEgxSGVmZTJBRUNwQlhwMjh3?=
 =?utf-8?B?OFcvdU94YUpaQ2pzOERSU08zOXBad3ozUGVONzFkckRBTENFUzRCS0hrdTFZ?=
 =?utf-8?B?bGF6Zm5UQkpIY3p5Z2d0TGNiam9EU0FkdFhYeStXMmNmNUFKNDFCemM5aTho?=
 =?utf-8?B?Nno5Q0g5d2E0eGt6YlNXd3RKK21VaUYyWEpjRjIyTWJONWJBT245eWxRazRq?=
 =?utf-8?B?Y1o4Nnc1amNvZkdBcG5FenV6Q0FpZHlZMUJFNndBRjFYRTZhU1dwM2VkMzhu?=
 =?utf-8?B?OVdKdUF4Q1IvdjRtQ2JrTGZHY0UxS0FIa0s0ZXloTUE5ekpVWEJCSDFKSTNL?=
 =?utf-8?B?TEVrUDJhWXNDcHJGMS93SnVCYzMwSEZadVc5dkY2VHJMeG5ONVJ6L25BSHNI?=
 =?utf-8?B?dGlVQi9xRG5Bc2tlemRtUXV2OTdxM3djODgxREtPK3g5UVUzVnBJM2w5WWtU?=
 =?utf-8?B?Q2pWdzQwSFBjYVpRVG5va3hFUXViOFMxNEdYa3pvQmthd1g3bEdSWk83WFlD?=
 =?utf-8?B?bTZXSjczR3FDbGRWM3VJZmpEOS9jNk00WkpQVGQyc2MwdVZ0U3R5SXl0QzV3?=
 =?utf-8?B?cWxKMVplNnYxVHBVYWdWMS8yR2RsSVJhdGI1NFFHajNDT3IvS1lpcXBDWnh0?=
 =?utf-8?B?Um90YitXbWVZYXlyS0FCM3J2SDBjQVJIN1N0OVVuMVduUWpoU3JTN0lZdm1n?=
 =?utf-8?B?ZXhrZFo5cTFzN2Vhb1B6bFVpQTZZYWpJajdidHc4ei9XM3BybGNWMHRMZ1Jn?=
 =?utf-8?B?MmpzVmlDeVNLUGxlRFJsRTQ2RUlyWDlEM0MrcnM1ekNSSEFXK3pydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D9474376577FE44AAFCD0C7773AFB3A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	W0MPdIO/d6/82Yj3Uv8nbxPYvnZBV5H7MCLGT33wuVhuYIfDb6ix9TZJjYn5kpseePDmOYPPmnNdgANSsh4pUYFqGBQIFVfteKY65edgEqPxS/fzndIDL4knX2GIvzK/aefhMhWMX0h7F7piTWiKcAaBls0TGfrOp+oOFCE0ZJbneOt1lqn678gPvKjMwaGjnks3Se3O0CF4wI+UjdTn6jHuUzamG1tq8Vm0kJ2eHqP3nyAo83EajjjGs0ViU9xikOMo5rEgWQ7aBkl51vgIqJu2y4Z9KMQlGv0w4oWUmfNGVlyyZagGe/th/9shB6jrj8uq/QGWoz9n8FxNFEDZNw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8630f0a3-f53c-495e-dcd7-08de7e0c943d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 18:49:22.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfcXzuS9sZqXpio1TCnxuwzevJuv9LZ4Rvna7wn8vsmOGu7AxX7LFp3n8jWy12OsqclTwzRK2DGSYUGsHeC+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6270
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: utfpJlkdNwE08Xq2l34R3Kzpc9Vf99Vq
X-Proofpoint-ORIG-GUID: RXnKBbNtiW_t_uirGnS4qp6vcQdJdVdc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2NSBTYWx0ZWRfX5XWHSAhYnmnm
 RjkEtFixzg72Zqrgo7Nhze6BP8a8iPx96Zb1N1S80+4avEkLDyZIi4qf2242okXArdSTxBtNFcl
 s3QJET/2VGydPJnyIbFSDmkirVEzaljj1/7fWTPU7xRMfPEdzp8wdxz9d5i1CVlp7xQMaoIzq8v
 jeZulCWnSArffHR0o6kh6Zwk1U2//iIJCxu5GjJJxjAyeizOcsmxMmuNbYI5Utyhd/ZhCQsk+ou
 dkfxJiIEaYHAVE9j9nGfK7643K8KoxTe/rwPwLl2QRoSg5I3Vy7ZKE8dzUuwwgQ0y6y/A3pZYfQ
 sVCdiHQKclDAQrgua7jd+LoMyyA1xAS3NFUcLepSS52Dgujy0P2YKAMP5AVm1fCC3p/yeZNzUQr
 UxrN/Q5I8gE/7Puk91fM+nLOG8qULPHlx/UyBoVnD0kjr6QKnaB9prtI3PvYMy0LMdgP9HONpFV
 zSeO+Seov8IOrIMVs8g==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69af1638 cx=c_pps
 a=FXm+OvNBiSWvAu5LmLLQ3Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=I9dIw-Gu1-mpUgUVVcgA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
Subject: Re:  [PATCH] libceph: prevent potential out-of-bounds reads in
 process_message_header()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090165

T24gU3VuLCAyMDI2LTAzLTA4IGF0IDIzOjA4ICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IElmIHRoZSBtZXNzYWdlIGZyYW1lIGlzIChtYWxpY2lvdXNseSkgY29ycnVwdGVkIGluIGEgd2F5
IHRoYXQgdGhlDQo+IGxlbmd0aCBvZiB0aGUgY29udHJvbCBzZWdtZW50IGVuZHMgdXAgYmVpbmcg
bGVzcyB0aGFuIHRoZSBzaXplIG9mIHRoZQ0KPiBtZXNzYWdlIGhlYWRlciBvciBhIGRpZmZlcmVu
dCBmcmFtZSBpcyBtYWRlIHRvIGxvb2sgbGlrZSBhIG1lc3NhZ2UNCj4gZnJhbWUsIG91dC1vZi1i
b3VuZHMgcmVhZHMgbWF5IGVuc3VlIGluIHByb2Nlc3NfbWVzc2FnZV9oZWFkZXIoKS4NCj4gDQo+
IFBlcmZvcm0gYW4gZXhwbGljaXQgYm91bmRzIGNoZWNrIGJlZm9yZSBkZWNvZGluZyB0aGUgbWVz
c2FnZSBoZWFkZXIuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXBvcnRl
ZC1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhhZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+DQo+IFNp
Z25lZC1vZmYtYnk6IElseWEgRHJ5b21vdiA8aWRyeW9tb3ZAZ21haWwuY29tPg0KPiAtLS0NCj4g
IG5ldC9jZXBoL21lc3Nlbmdlcl92Mi5jIHwgOSArKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQv
Y2VwaC9tZXNzZW5nZXJfdjIuYyBiL25ldC9jZXBoL21lc3Nlbmdlcl92Mi5jDQo+IGluZGV4IDVl
YzMyNzJjZDJkZC4uZWQ2MTg0MzVkMzNhIDEwMDY0NA0KPiAtLS0gYS9uZXQvY2VwaC9tZXNzZW5n
ZXJfdjIuYw0KPiArKysgYi9uZXQvY2VwaC9tZXNzZW5nZXJfdjIuYw0KPiBAQCAtMjgzMywxMiAr
MjgzMywxNSBAQCBzdGF0aWMgaW50IHByb2Nlc3NfbWVzc2FnZV9oZWFkZXIoc3RydWN0IGNlcGhf
Y29ubmVjdGlvbiAqY29uLA0KPiAgCQkJCSAgdm9pZCAqcCwgdm9pZCAqZW5kKQ0KPiAgew0KPiAg
CXN0cnVjdCBjZXBoX2ZyYW1lX2Rlc2MgKmRlc2MgPSAmY29uLT52Mi5pbl9kZXNjOw0KPiAtCXN0
cnVjdCBjZXBoX21zZ19oZWFkZXIyICpoZHIyID0gcDsNCj4gKwlzdHJ1Y3QgY2VwaF9tc2dfaGVh
ZGVyMiAqaGRyMjsNCj4gIAlzdHJ1Y3QgY2VwaF9tc2dfaGVhZGVyIGhkcjsNCj4gIAlpbnQgc2tp
cDsNCj4gIAlpbnQgcmV0Ow0KPiAgCXU2NCBzZXE7DQo+ICANCj4gKwljZXBoX2RlY29kZV9uZWVk
KCZwLCBlbmQsIHNpemVvZigqaGRyMiksIGJhZCk7DQo+ICsJaGRyMiA9IHA7DQo+ICsNCj4gIAkv
KiB2ZXJpZnkgc2VxIyAqLw0KPiAgCXNlcSA9IGxlNjRfdG9fY3B1KGhkcjItPnNlcSk7DQo+ICAJ
aWYgKChzNjQpc2VxIC0gKHM2NCljb24tPmluX3NlcSA8IDEpIHsNCj4gQEAgLTI4NjksNiArMjg3
MiwxMCBAQCBzdGF0aWMgaW50IHByb2Nlc3NfbWVzc2FnZV9oZWFkZXIoc3RydWN0IGNlcGhfY29u
bmVjdGlvbiAqY29uLA0KPiAgCVdBUk5fT04oIWNvbi0+aW5fbXNnKTsNCj4gIAlXQVJOX09OKGNv
bi0+aW5fbXNnLT5jb24gIT0gY29uKTsNCj4gIAlyZXR1cm4gMTsNCj4gKw0KPiArYmFkOg0KPiAr
CXByX2VycigiZmFpbGVkIHRvIGRlY29kZSBtZXNzYWdlIGhlYWRlclxuIik7DQo+ICsJcmV0dXJu
IC1FSU5WQUw7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgcHJvY2Vzc19tZXNzYWdlKHN0cnVj
dCBjZXBoX2Nvbm5lY3Rpb24gKmNvbikNCg0KTW9zdGx5LCBsb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNCkJ1dCwg
SSBoYXZlIG9uZSBxdWVzdGlvbi4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgcHJvY2Vzc19tZXNzYWdl
X2hlYWRlcigpIGlzDQpjYWxsZWQgYnkgX19oYW5kbGVfY29udHJvbCgpIFsxXS4gQW5kIGVuZCBw
b2ludGVyIGlzIGNhbGN1bGF0ZWQgWzJdOg0KDQp2b2lkICplbmQgPSBwICsgY29uLT52Mi5pbl9k
ZXNjLmZkX2xlbnNbMF07DQoNCkJ1dCBmZF9sZW5zIGhhcyBpbnRlZ2VyIGRhdGEgdHlwZSBbM106
DQoNCnN0cnVjdCBjZXBoX2ZyYW1lX2Rlc2Mgew0KCWludCBmZF90YWc7ICAvKiBGUkFNRV9UQUdf
KiAqLw0KCWludCBmZF9zZWdfY250Ow0KCWludCBmZF9sZW5zW0NFUEhfRlJBTUVfTUFYX1NFR01F
TlRfQ09VTlRdOyAgLyogbG9naWNhbCAqLw0KCWludCBmZF9hbGlnbnNbQ0VQSF9GUkFNRV9NQVhf
U0VHTUVOVF9DT1VOVF07DQp9Ow0KDQpJcyBpdCBwb3NzaWJsZSB0aGF0IGVuZCBwb2ludGVyIHdp
bGwgaGF2ZSB2YWx1ZSBpcyBzbWFsbGVyIHRoYW4gcCBwb2ludGVyIHZhbHVlDQpiZWNhdXNlIGZk
X2xlbnMgdmFsdWUocykgaXMvYXJlIG5lZ2F0aXZlPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0KWzFd
IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5L3NvdXJjZS9uZXQvY2VwaC9t
ZXNzZW5nZXJfdjIuYyNMMjkwMQ0KWzJdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y2LjE5L3NvdXJjZS9uZXQvY2VwaC9tZXNzZW5nZXJfdjIuYyNMMjg5NA0KWzNdDQpodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xOS9zb3VyY2UvaW5jbHVkZS9saW51eC9jZXBo
L21lc3Nlbmdlci5oI0wzODYNCg==
