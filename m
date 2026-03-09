Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EA23BD05
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083269; cv=fail; b=HpNn8dCqqzU3dD1fP2JfFNXZzIymGD0Wzhs9q4l4g1L7fTjRZXQQ7z10CNT195la3KhdwHDvDjBQCRrmub5fyVIdhmoDH/cGskhq9+I/89ushBCgZo3lk6LWrTSzB+aLJ9AQwlFnKYp6SCmshmjc9wou48R05zwAgF3Ayi7shFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083269; c=relaxed/simple;
	bh=wDJMxQfH8fkfXqVllxAElOERzpdkIEdb8ijK59jAx5M=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=FcseaGjRqx22ih7TygzA/QnzcWzlCWhXyWj3RGej/5CkG4ztrbPwl1nWqkGfW+DECxQQQysmmE4Nn09U8RSSOK04wak5Y6Dv0IcfVMThL0aKuydBHUcbR9feMEQarHlY+ROdRWtkNXirfd5UKghbLZL68KZ3nBlx+2xclDS3EoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N4SaWgAo; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N4SaWgAo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629FlmRj1609981;
	Mon, 9 Mar 2026 19:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=wDJMxQfH8fkfXqVllxAElOERzpdkIEdb8ijK59jAx5M=; b=N4SaWgAo
	MRsakZxa3fWuLDHZ9Ry+aXWStbGK0udfRkNTopqO6et3dTOYTs4hS5JAiRFR3lTh
	UfVeWHdnfeNzFedAsnO+IYLf5QsoI6V6sNGH1DMbeSeoErpS+drnssYjU2wOFcWd
	xqLXdmVq/Sk8NzcXCtt+2oiGKTTlgTuEQHBVlMUKJcdT2gvG/mZOGZQ/LCKPXSrZ
	6MFT1sGEkOi+/tmtRfeuGtpYro2bGhbW1Canyu/f7j3h0UhQ6x7x6wXxzhMF3YT+
	RmET/mQnsk641qv+six0ZPUycoSG1+kfR1sRsPEs85HjwRnIdh2RqUo8cJj1vl+Z
	YK/xppQOR3ZwGQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun7s6m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:07:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE6xqSHfpb5I3UcuB9xtrxbhDgHgn5qid23iIHBQytlxmGiPVZkwmkuWqqEQKzpKvSZ2D1xyXahQSaRDzar0+YReIbuUITiUTyA55G1Gf1/TQYms/Bh5X7xKnSSzsaTFqF/jnsNWmtFkVVKGOxUGBRjl725TIxW+s9kqD4w3Q2b2hoUe53vRkih+rmyqgLW0Xw+Ra26c5XlZZ8RfEnCRRxWz40H1uaxma7+gTQ0uN3pwSJCV5+xu4XAasii1xepk/0/218OQoox6cwKrJifHLz5KOW3pHWN4vD4ZWvLgLmwSs/GiZ/vsGfS9MOGKOmmNVtK+x8Cm9+g32eSP6sbP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDJMxQfH8fkfXqVllxAElOERzpdkIEdb8ijK59jAx5M=;
 b=egE333jS1OPnFUgYCxP2NyuKhG3AHRuf/80edDDRPYHYvACaIKap7SiSEDVlx5nnU+1unHrWk5tXbYfQLXz+GqqArjV3mJuCx1flVh8chukaDe4hFSsxPjSt5hegA0u5x3CmO53AzZgl5NqXs5iYTLIm50prETqhTZ56voP8JSrfgwlmFek/CCDMtZtgYZCjvQ0PIyHZjaltkFx6gAD8EguRZD3k0oU4dJIwHLCu+DolqsgqoRgqTPkMzNjQc3AQFP9wasmE2CUYuzdySnzeKFJrPVxU2zV67Nrhk6wCpqloO/1yUDun+fCbXXkDr1h+Y2vo95jHPLDLvI/fm3b+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5451.namprd15.prod.outlook.com (2603:10b6:510:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:07:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:07:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        Alex
 Markuze <amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] [PATCH] libceph: admit message frames only in
 CEPH_CON_S_OPEN state
Thread-Index: AQHcr0hr5tScegKBeke6s1+pCeZQh7WmkWSA
Date: Mon, 9 Mar 2026 19:07:33 +0000
Message-ID: <3a512051f8108770e4eb79c486ec5692fe894bb5.camel@ibm.com>
References: <20260308220942.694505-1-idryomov@gmail.com>
In-Reply-To: <20260308220942.694505-1-idryomov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5451:EE_
x-ms-office365-filtering-correlation-id: c0a824a2-7f23-4f97-c028-08de7e0f1e5e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 iN+2P6vSZ4pbKY6+dkv2xonQNU+ZE0CtpIHunQOfXi3ryYLqErPgmI3pjc/d8bP++1whk41EggH+fbFRaX7wUOj6CesVNw6fkLfquO+NHpAVuOmb4hgKje2Ovap+LUlumkIfJf/Ei+WasSJn5sHfqksHUrX8wDkXe2gQNb8P71cYdp41V6xw1zgmu1IT/bTMw/XOAVBW6PTJXacJvAHouVUSCQ+U3TIGhyMLQm2p/DSeFHWirTgn2kAHOmI9T/yekuscLortCAIfkD0igd8Jp69Y88CmibcKPRIcYnYDfLb7hhBpAIt2XpYZRzoH1DEmgrnnsv+eNpVkvPiXuRezzTzdLE7dld7b3ckZ3lB9cSZtZX1wdCfJjzPCeyciGHG7I8kdEcYHXGKeFgSfKwBu2hs0IvKKS4OHFQv9mpj/TDe7WQalyOK3rYMm2yudFdnMM3VhJ8ffYnLbBzSble1VhmgvKpzV4+kshTYp6ixB0sn7jcV4IAsBJ4rL6YXfl8J9g8iB9UdyzuGIOLdCS5hS8W8/rYq5mTbc0rn7/dotkHV9KsRuXp45GGyW5/8hn7RwFahaia/dXwarziP75jZ8PPyj09HrhCPD8AE8Zb60pY1Dp1QGBYyFymeizfoUN65beLpoPzkDCWImWxgcHixNmyVpUp2tBJ8yPq3G3n6oih5khH27tXGGg+tCbXbDgcF9ZmcsRVC3XZ3mJV3UAMNGR7Unve7u7r9kzep+m9d5lKBJ8noBIyUORtZqhVGI365z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWp5WGtEbFBXL1VlTUJ6eWRWNFVlLzgzdUJNYmtoeHFzaW9FcDRoMDd2c3Fo?=
 =?utf-8?B?VlQ1VWpLTWc5aVZ6VkdVbDJTYmhvZU5NeG1WdTF0Nk1hUjRnZEVyUU5ESEdm?=
 =?utf-8?B?c20vcjl3SHlWQ3JqOHhtbGpIaTB5RmlWRjUyYTR3NVQ3cmkva2picEkzcFpm?=
 =?utf-8?B?czVua1grS3dMWWhCSkxOdDhML1ByeGRnUFhJSGo5Um5OR1BPUGFhN3loNDdT?=
 =?utf-8?B?b2FFbk9OU2FYamhFR084RjhsQzJUVW9XSjlzRWRRaE5xN3FrM29QdWUrS3dB?=
 =?utf-8?B?SjhoVE9qMXNwaDh6TXY0K1hMd3gvbmRWdlIxL201bmhlazhXcVV6dnk4Y2pH?=
 =?utf-8?B?RkI4UTMzZURGS1ArdEU1dzFGYTBXanJBaGhJWHNTck1pbjg1SHk0Z0t4eVZr?=
 =?utf-8?B?UmVqRTRrbWEweEpFNUNXTVpSUjI4UmthOWk0RGRGZGg1bHBSSitaZmhZbnZR?=
 =?utf-8?B?Y2FBYTVjQzVJeDQ0OHAvVkZJakwzY0xGcjAvR09RV0VNai9CL1l6SWtFYk1N?=
 =?utf-8?B?ZGpxVjdVQzhrV3ZVVHZTNEFJRXp4OWhmM2dudU5BeHZYVy96YWs0bXprMTVT?=
 =?utf-8?B?c0NuS0FBS24wQ2tEMlpwWU5neXJnUHVUZ3M1QWkwVmd3ZVRNVXEvM3ppSUx2?=
 =?utf-8?B?dll6Q2IzNzNwSnhmR05yU0RjRFRIQUJBNksydS9tWCsrUDNidXg0TjM0MEl5?=
 =?utf-8?B?NzJ0WTZFa2RZRm5FZ0ZTYmdqS3EvdEVBV1dCNUxISDVoUHZ3Rml2dHJLMnJ0?=
 =?utf-8?B?S2M0OFRBVDNwRENxdFQrK2x0bGZZQUdZdnRTM2g0a2pvQUYzTDZ2TFc3b0pU?=
 =?utf-8?B?V08xVzYyaWdGUGpqbVEzaGNOSEY3NXNYTjVuNUpWVEFlMzhnek1aclVDU0R0?=
 =?utf-8?B?ZjdWVC9FQ1RYc2FFQWhmUHVmZUx6bEJUcmRManZDVkdDNUJkeCtHbm1mNnFM?=
 =?utf-8?B?T2lhYlJBR08vM01XelJmbTk4UlQ3NEQ0eFRLd1NYZjJzUEhmZ0NXL0FmYm44?=
 =?utf-8?B?WGp1ZS94NWxTNERLUFRaQWhuUVVTeWxwR2lvb1gxUjYrcW1CcFJ0ZFZicEps?=
 =?utf-8?B?ZDhXejludGNkSVBpMUV2UlBVdUhRUFJGVUJKMDc2ZWdmWkhPRElTdUpTRHJZ?=
 =?utf-8?B?aFhmMEdrM1ByM1kxWWp1cTJiWFlLMmxwUTBOSnRIOCtPelNuVnhnclRhWStY?=
 =?utf-8?B?TkM3N3lNMVBmTmZaU2swcjVSTjZTSWZiQndkaGhSWHVlNm1WbUdwOGk1ZEJ3?=
 =?utf-8?B?Qk4zQ2hqYVhENnlNbG9nT0lldERSbDVzYitWVEc1YmRveGcyZXlRRWpwS0FN?=
 =?utf-8?B?NDY4bzc1WmlqeG02MFdxM0ZhUUFidXJVdE14N2wzUkNGU1c0WWZqanVrR0kr?=
 =?utf-8?B?RGY2U2Y2Y3Q5L2kwZzJ2UUwzWkZoQ1BtdlBmd2wzM1p1QVBKdjRkcUNva3lB?=
 =?utf-8?B?WjM0b3FUR2lmMGZTT3pmR3l5QXREUHJUVFpKZ3E0WmtudkllY1o1RzBqZ1N5?=
 =?utf-8?B?TW1hZy9Oc21XanZlRy92VHZRRnJqTEpXZHZlQ0w4WTJtZzV4OUllUnVud0NF?=
 =?utf-8?B?M1Q3OVJKNzd5YXg3RXRRcWFjdDdvbG9xM1IyTHVpRld5MnV2OERCUVdrYkM1?=
 =?utf-8?B?MW80TjdmMHB3RlN3NkJQa2lPOStFRDVmeExRQmlBSTVHR1VNTjNaLzZLVjdj?=
 =?utf-8?B?TXdmVVFOd0RKelVFWHJtSm8yS1hscXRWYVlwSG4wcVN3TGdXR1MrVWkyaG90?=
 =?utf-8?B?ZjUzWG9YbDBrdUs0K1BYSk52cG1HS0tlOEpVOCttRHdFOXFHc0hFeCt3Vzhm?=
 =?utf-8?B?SXcyS205UGlZRG0xVWx4ZnVEMGJGUE92bU00WGlVajhSRHVraG1VN2ttUjR4?=
 =?utf-8?B?ckdIeW0xSGN0SDkyWUxQRXBDWU1qa2J1RDVGSXBCVzNlVHc3Mks5SFdkRTVX?=
 =?utf-8?B?SUFQMkFnN0t4TkZNRXNqSDV5RFpGQ2RmSWJUaDZUNHc4MjdlKzAvWWNpQWM1?=
 =?utf-8?B?SWFvZGlNQUZiR0YzQ1Z3L0w0bTV4RE5LekpUU1d6NVk0SFVwR2UvRkkreUdj?=
 =?utf-8?B?YkFUblovV0lEOGwyalpKVUhsWDdtVXA0bFZWZWQzWGN4NDBZUkdEWEdWMTVw?=
 =?utf-8?B?MmZPK3Npb2c2cmo0Zy9OWGtNS2Z5NU41M216S0xuem9Cd2M5NHN2c0t2YXcy?=
 =?utf-8?B?d3ZRdnN1b0dWTVRDcjVka0FIaGhCMTlCeWRuU28xejRMaG56bnY5U01pMkFE?=
 =?utf-8?B?Vm91RmxtVGpZRlU5Rkdia3BWNzZCUEM3aW8rYjB5dXBvWk55YnpJSUZiVVZu?=
 =?utf-8?B?SWY4dkM5azFCVXJGQ0M5Z3lNdy9ZamhjUnhlaXVmZlQ4L0dhalZNZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCBCACFB35218D4CA6B7BE46FC6CCE0E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	aPqrEZCdkhkEkdur98CtjhfHCpfb2+uM6AMKJrX/2/aDRCnw51JW+o/kQMOT7KxunufFNLe3tsgT6Em7IjToZa1oeOq3DWLRDLzjDul3d1mjv/Sg4W8W28YO2Yp6snIIkT0WdybujM8IEIsHN7KdCgrkdyIatlVs50ZtWumzWraHvhl33Jc1G35+joaFrmhxed9/9xyZqzZZBVocuLtXaIpSlGiWKDh3FL3j+pXlYZ4xnoMhDGxqFNPDyHKcSSzh2qtnoxfT/EHR9iHggW2sViJJa3ABJL/gR0ZcvB3XPq9Dhf9en8esc17gAE+vbIj37MdSWQz4XAkpc3FxQUUdJw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a824a2-7f23-4f97-c028-08de7e0f1e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 19:07:33.1469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPkRGmpGaZJKB1wcuTmLOwMNt66WVxYgb9eeSQgrijovI+DsTbV/sx2yUgzMYkIdKJuRZJI+VRfv+JIv3X1tTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5451
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7jNUFTT0idkDsi3siU3InOcUKFFMWQu9
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69af1a78 cx=c_pps
 a=LyZwXkN/zJaPlZXKe3eCLA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=0_2ZDlqivQYk2k1T2qgA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2OSBTYWx0ZWRfX+MQiDGe6A3sF
 N9YEJOzPWg2pH7cum5zwvFQdNf+2B8PX/maQYVFtaEGtMWk9fsPK4Z3jPq4SA4v1IyQJb/oeBN8
 RX+3iEbg6rlA0d0M0HgwG8hUN/D0NX++OQguFlzTfjpF7R82S63Jd0gB6tBR4IzHKp7BDsvNdS1
 FMvis5EuUD66plh0xp6OAtfxIzlOyW1EXrrgpwRrrnUwhb7F1rpH/7bBzeqDuVFuzXlAtT1loe1
 kzw25DTVJuZjwrAkMP4UcwcPK4hXNuES6rbhiXz9O+4Lc5MtyRuXy9uMvxSl5ErlWATp7Lct3YK
 xl54p4rCBaXbLhsY3olfnq7xcjqoyBy79VKGym/PDzT1cxuzEB1ti4xfsBLaWvpus+fbk6+jDxu
 1tl5FkZY31eN0VoPqEcXWULmf+itJfYIJ40ht4pZER7/XyLZ6DkxTf0TDrNUvjUBgvL1NUMILku
 QJaw9Bc2hSjhb4jsD4A==
X-Proofpoint-ORIG-GUID: oK5dBIYjjPthuZIhypztkR9qURTcn47c
Subject: Re:  [PATCH] libceph: admit message frames only in CEPH_CON_S_OPEN
 state
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090169

T24gU3VuLCAyMDI2LTAzLTA4IGF0IDIzOjA5ICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IFNpbWlsYXIgY2hlY2tzIGFyZSBwZXJmb3JtZWQgZm9yIGFsbCBjb250cm9sIGZyYW1lcywgYnV0
IGFuIGVhcmx5IGNoZWNrDQo+IGZvciBtZXNzYWdlIGZyYW1lcyB3YXMgbWlzc2luZy4gIHByb2Nl
c3NfbWVzc2FnZSgpIGlzIGFscmVhZHkgc2V0IHVwIHRvDQo+IHRlcm1pbmF0ZSB0aGUgbG9vcCBp
biBjYXNlIHRoZSBzdGF0ZSBjaGFuZ2VzIHdoaWxlIGNvbi0+b3BzLT5kaXNwYXRjaCgpDQo+IGhh
bmRsZXIgaXMgYmVpbmcgZXhlY3V0ZWQuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KPiBTaWduZWQtb2ZmLWJ5OiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT4NCj4g
LS0tDQo+ICBuZXQvY2VwaC9tZXNzZW5nZXJfdjIuYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9tZXNzZW5n
ZXJfdjIuYyBiL25ldC9jZXBoL21lc3Nlbmdlcl92Mi5jDQo+IGluZGV4IGVkNjE4NDM1ZDMzYS4u
YzRkZGY3OTExZjdkIDEwMDY0NA0KPiAtLS0gYS9uZXQvY2VwaC9tZXNzZW5nZXJfdjIuYw0KPiAr
KysgYi9uZXQvY2VwaC9tZXNzZW5nZXJfdjIuYw0KPiBAQCAtMjkwNSw2ICsyOTA1LDExIEBAIHN0
YXRpYyBpbnQgX19oYW5kbGVfY29udHJvbChzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sIHZv
aWQgKnApDQo+ICAJaWYgKGNvbi0+djIuaW5fZGVzYy5mZF90YWcgIT0gRlJBTUVfVEFHX01FU1NB
R0UpDQo+ICAJCXJldHVybiBwcm9jZXNzX2NvbnRyb2woY29uLCBwLCBlbmQpOw0KPiAgDQo+ICsJ
aWYgKGNvbi0+c3RhdGUgIT0gQ0VQSF9DT05fU19PUEVOKSB7DQo+ICsJCWNvbi0+ZXJyb3JfbXNn
ID0gInByb3RvY29sIGVycm9yLCB1bmV4cGVjdGVkIG1lc3NhZ2UiOw0KPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gKwl9DQo+ICsNCj4gIAlyZXQgPSBwcm9jZXNzX21lc3NhZ2VfaGVhZGVyKGNvbiwg
cCwgZW5kKTsNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJuIHJldDsNCg0KSSBhbSBzbGln
aHRseSB3b3JyaWVkIGFib3V0IHRoaXMgcGxhY2UgWzFdOg0KDQoJaWYgKGNvbi0+c3RhdGUgPT0g
Q0VQSF9DT05fU19WMl9BVVRIKSB7DQoJCWJ1ZiA9IGFsbG9jX2Nvbm5fYnVmKGNvbiwgY3RybF9s
ZW4pOw0KCQlpZiAoIWJ1ZikNCgkJCXJldHVybiAtRU5PTUVNOw0KDQoJCW1lbWNweShidWYsIGNv
bi0+djIuaW5fa3ZlY3NbMF0uaW92X2Jhc2UsIGN0cmxfbGVuKTsNCgkJcmV0dXJuIF9faGFuZGxl
X2NvbnRyb2woY29uLCBidWYpOw0KCX0NCg0KSXQgbG9va3MgbGlrZSB3ZSBhbHdheXMgcmV0dXJu
IC1FSU5WQUwgaGVyZSBiZWNhdXNlIGNvbi0+c3RhdGUgPT0NCkNFUEhfQ09OX1NfVjJfQVVUSC4g
QW0gSSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0KWzFdIGh0
dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5L3NvdXJjZS9uZXQvY2VwaC9tZXNz
ZW5nZXJfdjIuYyNMMjk4Mg0KDQo=
