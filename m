Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B68276058
	for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252480; cv=fail; b=Dx+rLKzgx2yKlRRM7ny95I9f8j0OdE91ZIR1v6BAfWpfs/YESCX/L34vyYnZe4l6kRIrfD/+sZWoHG9boFGJlF65j5Sp2AUjlgqQaNxoJRP9djGT77sUgVu8sgJfHsVc7iwG1q6oyIsQ48HQhC0BwHA5LKWxbKtdFxk3asa1I7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252480; c=relaxed/simple;
	bh=rZq3zw/TCJ18bNxxOAti1UPqqpZvurxLSC74GmKXVfE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HAbGI01CpoUxfAUdanuhU/qL5g+B8S1DgatXyJNB7QnZSlr9MygQ9c3JTDReyjeXzi79FaajBcTX60u5l7ecdDLMGgO8G24xL4xh3jfVuCKrIs6ZcB2GSy76xM1hMjWcedv6BQBHbiqA3ZYzZ+bWfErE1EnaiCBJRAK72k4vyjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xsr9fiLs; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xsr9fiLs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BE4rJr1487567;
	Wed, 11 Mar 2026 18:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rZq3zw/TCJ18bNxxOAti1UPqqpZvurxLSC74GmKXVfE=; b=Xsr9fiLs
	h+eStViLqJeXS+p9veGQ964hdedQNu2FZdLLaXE3YKSl3D44yvwYwGLZPYUGCwbA
	EBY+gD6a0ho1rHEWsTyo8nUveI47w6AnBdSP7gsI5V/lpxgHs/N1Kmn1DzqOCznz
	gYpaLMgxYrSuPCbdjDgM/5DdY9I57x3iBYkXKAWaI7/8iGPs800FTtiS49L6Zr+t
	KCDjXN9bTmSvhxDs+oozGLEgRyciry/cYIsW/BhZtSoADQPxkNezodanCWOA56qT
	nIU0N1hjBo0LtKO1Gfo3RRgmNLD1BL0uq5+5HOZcag3RidltrF1fAOudQ+dxfe4x
	UY0iM0tbU7SjzQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcungr3v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 18:07:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjGae2QAjhCcJC5KOZ/u79nUVs3VWb77DTwhdkotLUWel3UzsncpRm4JjDSLO8gK4fzXPh2LdpcvXvued/sGD+xKd0ycqS3smC/WyWl1fZFa6lPCQEa6HfnAGfGYmeJu9kyBOvWbAo2aGEQP831pPcqsn9KArRroxZretLkjsEmGlDYtHJoNskEs65MS00KlxB8CCstpbmr4uC+kIhqFWKhbiw6GyJs6yx8HkIGjAGavefdBKqC52F4LSjceislurdGAa4QNUyLjn1eVQqpHGRHwdeWNhyya4VzvPiRe8xGjCquLfVEwSDiNI6p8p0f3cVm4XjSYXQF67PmECREP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZq3zw/TCJ18bNxxOAti1UPqqpZvurxLSC74GmKXVfE=;
 b=nvBUehdZGG4qPpF5g6/ts83Lwx2KmMxxYhrWnQcgh7bHOI1TbU93yI5O6Rx9Gpga7LugCHGr+Sm/b/Awx9eng6UCTGfSrh/rWqOCOc1aYYUEC8De1eR38bzTctkEHJN3Qphqh5S+2wlVpWe1Q+7s2q2WqhX2lz/ijW7Fvyh0DkcSdvroY8abNlymU461aIkDJHSBDyoZuYHwxVQ3BNsO7TI7gS0YMRBKO3PWj3mcJPgQvuEMzwCr2sRWGWqc8PN+r7Umu7h/Pwm94yStMdGxlqlNePc1x6P6D7zbvbk6+8M5pkKckhZhSrnOb8+nOnsegTdOibpBqSka/PSN//2BOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by DS4PPFFAB2B5BD7.namprd15.prod.outlook.com (2603:10b6:f:fc00::9d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 18:07:44 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 18:07:44 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH v2] libceph: Fix potential out-of-bounds
 access in ceph_handle_auth_reply()
Thread-Index: AQHcsYH1YYPFYPl/b0WSD6P5B/z5GQ==
Date: Wed, 11 Mar 2026 18:07:44 +0000
Message-ID: <6ad9dbe9d50b38b92a6a775650ff6457193c48c6.camel@ibm.com>
References: <20260310142815.3747443-1-raphael.zimmer@tu-ilmenau.de>
	 <f26dfec7535ea353bd78606a2db11a21d9cd4e96.camel@ibm.com>
In-Reply-To: <f26dfec7535ea353bd78606a2db11a21d9cd4e96.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|DS4PPFFAB2B5BD7:EE_
x-ms-office365-filtering-correlation-id: b3de91bc-aea9-4c3f-ed42-08de7f991815
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 x77WJXwUNsy38qeCAHnZZNmg0QG7BtdDV72pTZ+1HdlSbQ9zw0fGDJqWNekEXkxmIUPuXOqb0ZA80Sp98xaj7ziILQustfipMeMvdVndsy5BuTQ8e/RG41N4Vxs5NVhxRCTGwwuC2Ut1RAxHzbXgxkwQ3mkWctzZuaL+jjeWvkqf7SD4VQQjH34lvgK5cYkN9P4bGbOR/DGfQ76mFNYzaCidMdZMqtwa4yLFcdTfZtKKIxOEI2ZV8bQcIPWxPGV8buptkArLCw55auNV8Cw/kFc94+xXK92p2zoII/pPVrmtFjf3SV/QY6vOojsGrLXF14B2c6z9pJhji+h0OlCg0eTDf61SG9IEmf8CIc33n5NfrdAcT3r607Anj/nHSoT6twwxYsJDMeG2Kw3XMzcWG2K83V+p4Q/PZl8E0olMsCYagb+myyl8vgvsAAzz2qvU+aDB6887YyTZ/B3eBnHMvyAq4qR0TmDhVlH+8phEI1T9ePd1D6Wlv7CdPHItXfuaaRMXFbMJJc77G6CmXzNhWdOnwch923LlyJuc9Xsi3QuJTGB0MR/HZK9inEkLV50mBoM3dTmwFSWUjk+JajDPihveWMG875xn3cXbHZ5nHmTTyO/0pnEBF4A6t1VgRYboqxnnyBCr/7RmC+l3gQbQjrJ34aqWKaVIMYTCfkpVElSRKq8fIcY0tN+SBMadj5gDoG1G89PNP5WQOdxxoUtzheqB9kZTIpCOwa+J6C0XaA2DdgpGCyCxwtAmlXE1PQR92F+uJCWL0Xz70Ua+m8biL2EO6Lej+901rJmcHeN1Vb8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3NQcTNXZWxVL056OWpOeVlIcm9sK0kwRyt1NzNicTVHNVhBY3ZyR3V5TFNo?=
 =?utf-8?B?cHVOK1JpSHI5VmpibHFGckRNRTNpUTFTRW1vaDFKd1lqeGd2U1JYbmxiL3lN?=
 =?utf-8?B?anFTYnNVRTlPWTY5bXFBd05KdU81QnMvVk9RMG5kRUhyWS9BSGN5Q3hSOVlq?=
 =?utf-8?B?dHRJTGVRU2xQanYzeExidHVvRlk4RHpVUEwrMFQyWGRXMFhrdUpMMHRkM3U4?=
 =?utf-8?B?NDgxbllLSmNCYjIwTThsSk83S3lZZ2tIK1FVVy82WHgrMHVvSmFERFo5bjNJ?=
 =?utf-8?B?RnkwT0VXRUEzc2txYm91K0xTRHNmZElySjAxaDRPak9NTUhuc2lFWEU0V2p6?=
 =?utf-8?B?MEdpQlJFVDl4Vnl3WVJYVUhVSnVpaEpqNGxjUEhRMnBldWZ3UTNTQld1Z0JD?=
 =?utf-8?B?a28vcTNXRGVDZ00xc1NXYVdIcnJ2SnlnZDZiYjRmcnRmWlZ1RUlnL3JydHlL?=
 =?utf-8?B?WnQyTHF4RE43ZkNMZmVpVmJFV0dYR1VZaEFDTHJJQUQzNE1WeUp5WWtveHZS?=
 =?utf-8?B?RlVaSzMrNWVCVFd2YnU1Y3pRZlY3NThKdjdRMWFJaWdQRHRFZER4dyt3V0FR?=
 =?utf-8?B?ZkZJMGRzK0FTTXZudmJqTUhZOStZY0E5Nk80TEhRemIydmMyWW44RGZsUTh3?=
 =?utf-8?B?T3J3bGFrQXhqMnhXekFZRUlmcnVnQkZDeHM4dldZN2kzMWZBQzBqaHIzaEF1?=
 =?utf-8?B?VW5ERitKVCtUYVh0NEhGTVJuRnFEcGlub2xyS0ZaYklHVmFFMnY3eDAxa003?=
 =?utf-8?B?VTRLdEpoT01FOVVSbjlUdHZnVVd1Y1oxODhIdkQ4VmhkVm1JUnV4QWhSVS9L?=
 =?utf-8?B?VzFTdWcxM1N5ZnpEYXZzOWNlamZtNWVSU2FPNjZtNW5WeFVJVEJYbWhKRXpE?=
 =?utf-8?B?YVB5L2tvc0dzbThRRWNhQTFURXMwSFhHSzYwQ3lXbGpHQUNUZi9ZY296Q2NT?=
 =?utf-8?B?V2lzRkJkNTR3UVdhZGhpTnVhYUROY2cxZ0ZCZ0VoWlduNTNEaVlpMUZIV2gr?=
 =?utf-8?B?UG85NGZ0QTFpd0J1Q2NiWjVxSldoeWVqU1ZqcjFGK0ZOSEwwRUFWa3IwZ3Q1?=
 =?utf-8?B?UnJVT085aDhsR2VqZytqR0trMEpndDhzOFQyZlB3T1orV0lteUM1NmsxK0Er?=
 =?utf-8?B?NDlNNmYxcXNtR2V6d2U5VXhkQ3NVTzN5TU1HNlNPM2FqNjVKYmVodlNBa2Y0?=
 =?utf-8?B?Z3o0Qit5VjQ5b2ZYUzJEMGNpclNieGhrRGdreUdrY0Y0MkQ0RVdTd2Y2Z2cz?=
 =?utf-8?B?ME1LeVFSRWJxTEhTck04bitweWFKdzB3VlRDejBzZm16VjhGcDZFTzhoK0h4?=
 =?utf-8?B?R3FHMDU2SkZKc1loeHlDbWUyVXlEVTF1cWZHMmo2ejNZRkxSRzhHU281Q284?=
 =?utf-8?B?T1gybEF1MStNSlo5TmRBbHgzVFA5VGw2by9vVytkQnNxNnczU0kvZ0JOZE80?=
 =?utf-8?B?V3ZJcmpIT3JaT3lkUHBQZHNqYTBaaUF2bkc5NGt3YVM0VlI2bHNZandNbWFR?=
 =?utf-8?B?ekxLN1ZHM2xQYWFqN1RhSTZLNm12RGMyellzcEhkM3cxRzBSQTg2R2xmZFVJ?=
 =?utf-8?B?UFFjdGpvSUdLU2RrSS9PZkJmRFNGSmhTaUlZSlJKYVNmVjZDRTJaVmVxaGIx?=
 =?utf-8?B?cWpzTTBwajlTeXFMbVlkZE82YTVabTU1dFR4QjNsaEtsclVkaEtQcFlzSHNF?=
 =?utf-8?B?Y3Ezb2VrMVdOWWpTQjVhWFlOcW5UejBqcGRqUXpKcTIvSytmTmp3aGo4TktE?=
 =?utf-8?B?d2p5ZzFOak8xc0ZoMHIyUEk3RlFWU0UwbENaMW1QdUU2di9yUEY1elV6a1Fy?=
 =?utf-8?B?TlBRWEgrR2ZVbTB4SmRpWnF5Q0E5VldEV0lBcTZLV1VieEpXdHZFcEkrU20r?=
 =?utf-8?B?RStRR3lYM2VROUZmWEVRTDVMd2ZsbmdIZmU0TW5VS3NveVN4ZTJiZDdKV3lN?=
 =?utf-8?B?TndhNTllcjJVVHArcGlxNGRSWlBHTDkwSjVzL3ZyZElCRnh5MXpTd3Q0ODFH?=
 =?utf-8?B?UHdJTWtpUitVYjcrSXdwNU9OYlVYVFJCSTd0aXhaMHk2SHVsb0dBeHJmbVEr?=
 =?utf-8?B?ZmFYbUhIZ0NacUlKSDIyM0RZS1d5SGMweVc4WDZFUnJqWndVY20rRG03QkpX?=
 =?utf-8?B?d1U1MkpjVnp6Z3ZXbmxyRDcraXZBRWR1R21iUTBzUDZSZloxZ2QvMjN2Y2JP?=
 =?utf-8?B?WXozUFpwL3ExeEJyYzkxVlVZRTF1VThwKzRsQ3FyNk5UQ1lDdFhUODdSeDZ5?=
 =?utf-8?B?b3hwanR5WkVUdkk0ZTRSTTg1bUxYM3dadHZiSjhUenpoTXhJZVphUnpRYkRq?=
 =?utf-8?B?d2pIRjIvM2pUUDJNT25mVnZYbFNCN1JYRHlRd3ROWWwvempvRWR5QWlOemEv?=
 =?utf-8?Q?uLcHpfg5OfOUdC1xAPo1Ro9aPh5pX5pgwOu7+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31D71ABDB4853B41BE8E82721BEE6A2A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NWe2y7FrBp5jpUvOwM+Y4V62vWgJqc+FVXo8Xh7ma2RueLF9uCefINLMW7KS9aDN6V6BjLx6lqyyf87rlHQ7mHOoGHWdq8PDU2x/riYWRU9+jAvBxW2m+Kgcn+0TlPJcxJ+1kpsTErwEcj6lDK7WNQe5gQmzkm6EnFkDE0CMNGiVuyvXQEw2RPAb5no4h6u2fcSf9j+RGaTpM0tndR4TtA79mujUNbkutu7vcWvh3lSSvCF6CkJZ+s4TdQEJkrrOdLDvvEt6gT5nzxlCFsLCeafC2F+1mjdLc3mlXMYE7BNaXpbHzXuUk/HOUqtKtMHDKZQLDbGPxM1UoEi9XgY65w==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3de91bc-aea9-4c3f-ed42-08de7f991815
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 18:07:44.3980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XD8PqzwH8Vuu88o/2TRPB8b9t+N7hs98s41tDyPNeY6MY7DJsr4Fj//6BWxjIwckmgb9CyrXKfYHdGkePyOxow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFAB2B5BD7
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 93zWnziYvmUCzXi_r_tgVXRc6wlpse-6
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b1af73 cx=c_pps
 a=EPZJxM4MYJNUcCtligPUUQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6X-IYPjw_pHFGEfm8mAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1MiBTYWx0ZWRfX7gH5ITECQywA
 apuQfIetwozmadzbSB6iax64GRdoXFpL1bOWbvCSqX7AdbZSYewBcIH1a4/Mwm1rAuyTSSiDZ9w
 9/JrlAZxigMnWE6mZc/tXd2Ksj/M2m/NskaDGV8XxYnopLwziSNWQUFRv3gk1S2YrQIzM0PY5Rd
 EGW6qbA+Pnhhj//Xdic3Tqdwp59zol4Rtt7uZZqXT8r2Ecu4I9wL3+GEitU5ubutohORu5/lg69
 JOrY3rDWOf7U0AfCxSmND/hnscymDM4YdL2yK9tHXQdMHGIxH03tGs03WJshVgg7L/1i8n/GuKi
 eC2lbrVoJNF6KtCaHvtIIOzc9iqxTuEGeHs6Vttfz2SXqyIIJ4eRu9/c4U88PzeRL7d6KnrcoBd
 ju9I9V6xUWQ/DiEAbgnwtAkM6O1Q51YftXzCu8t0/XRgYanSB936ceC+p4zib/HmzcDWPYHo3z5
 oEef1QDhYO5s5SS9UEQ==
X-Proofpoint-ORIG-GUID: 7NooaiPMC_DN-ps-Gm6L-N0gG8b1_nYI
Subject: RE:  [PATCH v2] libceph: Fix potential out-of-bounds access in
 ceph_handle_auth_reply()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110152

T24gVHVlLCAyMDI2LTAzLTEwIGF0IDE4OjIyICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IA0KDQo8c2tpcHBlZD4NCg0KPiANCj4gTG9va3MgZ29vZC4NCj4gDQo+IFJldmlld2Vk
LWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCj4gDQo+IExl
dCBtZSBydW4geGZzdGVzdHMgZm9yIHlvdXIgcGF0Y2guIEkgYW0gc3VyZSB0aGF0IGV2ZXJ5dGhp
bmcgd2lsbCBiZSBPSyBidXQNCj4gYW5vdGhlciBjaGVjayBhbHdheXMgbWFrZXMgc2Vuc2UuIDop
DQo+IA0KDQpJIGRvbid0IHNlZSBhbnkgbmV3IGlzc3VlcyBhZnRlciBydW5uaW5nIHhmc3Rlc3Rz
IHdpdGggYXBwbGllZCBwYXRjaC4NCg0KVGVzdGVkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNs
YXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
