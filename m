Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859E225788;
	Thu,  2 Apr 2026 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153582; cv=fail; b=F6R84BMMoYEfPi5LVwjHRYmrhSKaMhOcNezX220oV0O3bFHqaipcAIsruZTU/TqKOI9lGG6T5ExgZf311+wI9ykGW/VJvia0/lPgvPjDH43R8NoD8Nxy2juxtirZRVwD30NkpwvlfmMK7tEitEyA2h3hqrg4tZjYkVTnMUxix2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153582; c=relaxed/simple;
	bh=OcpQZA7mHqNe11AEjRxzNopieUC/OT0nfzrOG8oZKFU=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=OyLKExTnnR47aKgR5SxMW7bF0GKIfZebVTrbOLDnwq7mJHXMwpLWmCWI+MU75AcUJMsZ6eWvk0AQ1ALjIe50+gopX+B6hRXVJjRc/HiAO+uzKZ1h77XlaDMkdq8uAApTXGKlvoT/p7O/ImX/a2vPGFWKjjwmiMcv5Hzm5Fo90wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nnarZ6/X; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nnarZ6/X"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632HJ49T169440;
	Thu, 2 Apr 2026 18:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=OcpQZA7mHqNe11AEjRxzNopieUC/OT0nfzrOG8oZKFU=; b=nnarZ6/X
	DTSdTSwNHpSbTl7fLYywbH2duEcf+/40SyhdBcOFdIkqixqjaC66SB0feqEaz1bd
	Yoy1DYAZuzugyG1sfcnHULmmQBI4TFpH/1CUlklZMCFYYNsCeh6UfRHBlM1HMAZf
	1TAjsapP5RoVBCU3Q/SiiS+7nsDQDYaLZ2ThwwHD7W1OZJduz9ujVgFJ0KwzCZ18
	fQL11aKnnpjQHuFTKiZasYAxcvS9NBWO5GdVBUWSA3VoMIY5mMB8Ecs6eYrX/Am2
	Tee/zZTlm6BEkG+Vieekp1JaBSAYeuR/PgYidElJq7+tqEM0h7sBPsDf0loJK9IJ
	ik1iw+XVzezAVQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3dyr4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 18:12:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVRwwjPSJKvBaz10Woe2+xzqpEYO1gloHjiQpkUIjPqFpmg42u8FmiNuvcT9av9IffPbaRG/IC8VlVyTPb8e0hdMIvX6+Cm/cRo1WDhWoLbduHfNOujPb6dFLER/9ExrNLVwvfHoh2jWCK5OgPqa6+ODSf1rHWcoUEtqlK0sBUxE8KSFApjhRyBiHhbCuyw2HYwJSQXPRqc7yXjY4E+hyK4QlqdGyHx66psHp3MTYi24s7Kdd1Gx1ARBm517NoDOQ2FKX2IDpDKk7gVw1S/h2I9Lmpa5vOEsO3Mhq8mv3tucuJzMdIu+cWpXzWC8Sn3Vo2B7bXkkxkz97Gi6992mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcpQZA7mHqNe11AEjRxzNopieUC/OT0nfzrOG8oZKFU=;
 b=FpX2T9ytV1GprUb2jlQ4DArhG6ftN9wi+kRnUvEdH7pvioBIwz9QtMLuqRqqvGDaOtulqmus+GgeePhnxWjDqEzluKc1xMRJ/4QMnjGbbZwJPJCHjO7lC6A9D0qUsWNTnJVvQMtcKQy2xvASm01SXBdPCl6Coqya9d7GAVYDDkdPCRHsvW3PWdBkK7w60RqGGsIIOtY4O/4JUmSB+Yl+2v+htOT9r/z4D6hPmMjaz5aD5haLaJFMapN5TDtrTrEKxg/qZq3QpLwqri6hmvS/dYuy6xY3Vch2M9DguX3a9w4YTHJHokH5T7LCSYtvH+tj3gcWCtlPP1GKSsb0QEjLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB5068.namprd15.prod.outlook.com (2603:10b6:303:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 18:12:53 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 18:12:53 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH] ceph: clear `s_cap_reconnect` when
 ceph_pagelist_encode_32() fails
Thread-Index: AQHcwsxSIC0sOA105kqRvjIc+xq7qQ==
Date: Thu, 2 Apr 2026 18:12:53 +0000
Message-ID: <a14adf2a0b021ca604d1de2252b3c63593b4b001.camel@ibm.com>
References: <20260330084319.1357751-1-max.kellermann@ionos.com>
	 <edbc43fe2e234c41e1c72275c176fc22dc773a58.camel@ibm.com>
In-Reply-To: <edbc43fe2e234c41e1c72275c176fc22dc773a58.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB5068:EE_
x-ms-office365-filtering-correlation-id: c7084432-a0d6-4f88-2bfb-08de90e37585
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 D3hdhrAQPe+5BLXRXZRCn7drHjGo0wNxo0VRGRR7ibcNb/FVKmutFza6B4jeMpSFLYSArlCrWG/JWgxOCcCZaQuTilBqyMVHg5ZBqVeBafenHlc2/zwkJvcgzR+phdAXrVWTXGPUR5mixFGLKVxYZIs677vpvfqFzH4gvmIjdF1zATHGFMm9sHOW/G2B3fJbRRuQZGV5LogvHzUGm4l5+qoou6kyipnDo/IfmpNjKbTQ2Akq3TdKBVO2fIxmDPYptz4PohJRUwuKWuLnTc6/wv3IGQWAvTqnoRlFSesJpbWSHro+JnVVhSh2j7TBIyf/KZE8ObmtzjxXCuyEHjtZNldfXloz0MSDbWV7jgsDc0o3CQPTGnhGFH2qrtYAf6Kt/C9NIMlEUzCYXpvfEQKm1BL/VoI/L54ddPgc6E9sXF0/iGHQRyZXqQoRNo5er+jM3i7QX3/mMtGWlLsd9nSTT88mB3Rq2LMmA3S65OxPZMLn+K/Gf0aDqLgZCGwmnaW4MBr21qYSC1RC4BXZbjvuLf8BpqwMFFO7d9Ksjqw7L0vmYG6ukOiyLgjzBeFTzcmPzd70VjO8k9LO2p/hHkXGZbYUJjuQoaog0VCDt73eGYNTVRS0eJn6vC+hag3pEtRkdVEjHa0VUnUzMJlazUoP9NXn9uaY9RtD+fbtNdPV6wbF9gk3WkEHj1rltF5t5f4TkVt0PS3i842QUJwr66Zqza9Yruaei6DIm9tgvYPUeKrXGOAv5zbgz2k0XCMcyEr4CkNSPnaKS0mQk6u2tx084H49Su5r8AYS/eh+77wd+2E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVd5V28zSVRGUlJzL0lYTTVWN3V6ZmZaMXBRdVc4bWUxWElNRzhnOFlzTE80?=
 =?utf-8?B?UW11eEQxK09QUVdJQ2hBbnVvT3ludVJDWkM3Ykl2c0wrUVpRZGc1cUpHRXkx?=
 =?utf-8?B?c3RBY1d4bStPVlNnK2tjeSt0V1J1Mit1b2ZPNHpJazkvZVVIeEhsbnlXcmRs?=
 =?utf-8?B?V1d6K0lHbmp2MDZHMTgwenpaOEF5MlF3c29hZllQYTJBK0U0TWpmVnlxMGl5?=
 =?utf-8?B?UzJ6Zm5RM0ZtTzJhd1k2M0JLbm9YM0xNZjJ0NTdaeTM0M0lmbTc2emRINEgv?=
 =?utf-8?B?YWdRaHg4U2ZjSnd4Sk5PdnRXT2FrVVRzSXRJUGJEQ2xlSTBXcWdOclM2QTBC?=
 =?utf-8?B?WHJJbGRpdTJ4OFBMZ3NIelJmbTMwbHhjY1oyTE1XTGx2THR5QmY2MU5wTDV5?=
 =?utf-8?B?dGdLd0d3UzNmSSttVFlpbk5CZWdjV28wUUxIS253SGxhMS9TMUw0MGhjTjRC?=
 =?utf-8?B?dVp0ZWptWE9EcnFZNEZnZEl4ZS84TUdyc1UzOGI2VE40WnlWVDhyeUViYWFq?=
 =?utf-8?B?ampuZXlFeDVUN2ZwanZ6Nk5WQUpNZ1o0TXhaUStaK3RhOE1PT1RuaTJDVVl5?=
 =?utf-8?B?bXpiQXp4QnZqdWVsYllsYlBJMEtsaTlJOHNxOUJsKzFoOFM5cXd3T0tvcTFk?=
 =?utf-8?B?THVvSW9sTE5FYzJjMmsrTzcxMjVHRnZYZ2ZlSjVSOSswMUV2dzYzS1ZCU09B?=
 =?utf-8?B?MDk2YTZPNzhmWndGY3dOeGlQc1pyVVVmT3VMTFFxeCtrY2IwOTlQNFd6dTd1?=
 =?utf-8?B?d3FkU2JpNVBYaGxFMlcrbUYrWVZ3bXFxcFpZa1JtVG1NcnNuSWtpcngwZzRv?=
 =?utf-8?B?SmtQbkcvWWxZMWErY0UwMS9QUXNaRlQwbDYxWXF4dUs0S2hLR1IzY1pSU0F3?=
 =?utf-8?B?TmQ2N0tNWSsrbFVMdUZQdHhoUVFWOXVtZlA1a21rQ1l5ZjNwMkdVMEtqczhD?=
 =?utf-8?B?SnZDTTd6Uysvd0VHelFNdjdNRThOQlhMRXhtOGJDanIzeUduR0k4d0V0SFpk?=
 =?utf-8?B?Z1VLTnNoSHFWT3ZaVkJnTlIxVUlYUWpkTVd3elZ1UWMydDlDbTlRc2ZoM1Er?=
 =?utf-8?B?b29YY2dmQ21aaGJKVVRESmp4eVBkQjZQL3p0Y2xHWVdLeER6OEl3R0trRFdr?=
 =?utf-8?B?c1Rvd1JZYk80bU9iZHIxbmhJampkeHI0QkZJZGI0OTEwSWtHdDdnbkhJVDlp?=
 =?utf-8?B?SlcwQ1FRMHYyUENzdXBmZzlGelNPTWFqa2JsaDZzenYzbUVCMmlqK29xa0J5?=
 =?utf-8?B?K0dvL0tORXhoSnloeUdXa0dpQ2JQODhrNjJnVHE0RS9WaXBkd2FtVE1SM2R3?=
 =?utf-8?B?ei9PSy9UYmE1bWF5N2FSY00yMlowd2s2YWU0UlZOc2M2eTJONHY1NUdBalVz?=
 =?utf-8?B?NXVaWElQVkdRRjlrVHVtQVNiSzJ6alZsNFhzUUN3aVFkVmhwZHBYMVI5YWNy?=
 =?utf-8?B?N2huTTMvWEw5d2QxNkFHUkhxVGZGK0VIN2FJUlVYTVRXYzNBSlJRU1hESW01?=
 =?utf-8?B?UWwxM1oxQkhiWG1hWXVaOU10akVsK3lpRW1HYk43cjlWVHQ3V1NUUHpYUHpq?=
 =?utf-8?B?cjduaTkzV2NRZlZQRW1qQUwvUzcyc2c4NzZyWkpubDJuQ2pCaThQalZNRUpL?=
 =?utf-8?B?U2dVVTQ3ZlNhaUU3dWtOdnAvdHBnUjR1a3FqVUpTanhiL3Z1cTBRdHVBdTFI?=
 =?utf-8?B?YlA5RkdUT1Rwb0sycTRNODR1QTk5Y1lubFBvUXBJc3NRNURMTEVBa1VSL0Np?=
 =?utf-8?B?RndCL2RqRG82UmwrVi9sSnZWU25EeEVTWDVDb3M2bXhkbVRVSjV6aHJSbmtt?=
 =?utf-8?B?OWhnRlVlNGMyVFBRNE90azltZWtBV0x4TWUrNFZEait6N2tlWmZ2VHQxRkxp?=
 =?utf-8?B?QllzL3V4WkRvYkEvVUhLRmQ4SERWeHdhRnhMd2E4d3NkbGhlNUQ3VXY3Q1VR?=
 =?utf-8?B?QnNSTDJzZTVTNHNscEFJREFWU3AvVHhEckhTbk9pR29Rc1NCSGpaajI0VXpa?=
 =?utf-8?B?UEo3eGp5NVhKNTBhUWJObTJtUnZYVC92VnVQNnBNZ1VVa081SWg4U1hxYmZo?=
 =?utf-8?B?SW9OYjJEUy8zQmw3ZlR3ZGtxT2N6MmFRVm9iMXZaSk9qNWtIL3RlUGJuTXFj?=
 =?utf-8?B?SzhoZ1d1NjNialJCcit1ektEZDRNN2ZSVjJFcXlacXd6RzllUjdtQ2x4YVZ6?=
 =?utf-8?B?ek1GSGRwL1VEY1ZBQzdaQUh3MDd6dHB2ZnJsbjRmWS9zYWgxUHdaV3Bod21s?=
 =?utf-8?B?VkhlejJHaU42WlpVRjd1YTRFdDBFYnl0ZStpTXZsdk1pRm5lZ3lNaGYrVGNT?=
 =?utf-8?B?NVRuK2E3L1lrd1BTS0UrSlV1V25NQWJlcWR6MGREeDloYnowc1IyUkcrWElE?=
 =?utf-8?Q?R2DK18Jz/vV7YjiftMjTikWLM8omfhH/x5NvU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17EC92495529D041B987C394FE41474E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rZV7oF1/t/2k8ay2oKlPOp5EFDLP0jjnnsolz4RoGXLOwFDqkn+ONjslrQ/XgIQo20mofbgSuBZjDkKu7yfF4oDDYpHDpqUPWd4dyP/yOJXJ/WWRlpk39p5CsiiqCVHn0Wsn3jveyzlPQ1npkXKdICranzTRgShHDDiymn26/KTKgcfPOmbDrBMHezegSrjCXrfCKfK2SIZ8j3y8Fu86EV95irLJNpkiVUckuJfb6TV4XRzjBHeIUim1J9fzV8t9OLTIwRpqqgqyUmRqcKW3OCAZ4uTRJO3C323K0x3clhuYUSXos+KmFW4A6Am9cwIwBQviBl36CwRlkHHLzLS65Q==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7084432-a0d6-4f88-2bfb-08de90e37585
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 18:12:53.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AK29sH5E8WRqvRDsDff/In5v86i5N5N+6aTcRLVRebjtL2DVQW7PZf74gq++wlZACA+2vccPlwDGsQiTwJUWJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5068
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4A83dZiUQHx3sQnFJOTqAbU1cvYJLrdo
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ceb1a8 cx=c_pps
 a=9FhzUGQqNQs6ZJfz/MkW+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=UgJECxHJAAAA:8 a=VnNF1IyMAAAA:8
 a=Ij7NdymO11z3dQ7LjjoA:9 a=QEXdDO2ut3YA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-ORIG-GUID: 4SIjzmAJ1xWy_2EPsPlXlsiRNPTtfdPi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE1OSBTYWx0ZWRfX+rkcogrywV7F
 9dqfhwVw1coW6qtroWN/Xbny0j5CFbXnkkaemenQ9TJw08+FGq9aCKYsEtKRt+tvMR/AtmIDRXH
 a5Tib7LsU9po1Df4w7k7vac5WYLc7xTcxPNI9X+Ri/0tFAipeWxSHWvtKc/bBCOAWOH5MSs5OfH
 QJTPpDnRNNWWLVCi8B4/DpvS7SeimertDjePF0MGBs/lvgEPcIieQou2/NiMjceQ9LPnSfv1xB0
 /dw7PXux7y2iUagCQp3gX41HNF0JkKkxRXL4TIqmk+e8wRK/qZ+eprA5MiESTRax16zUQUF2YAB
 dJ0lxDxGKCp3dfESoUdiJOHq/XSBQ0ypp6aPDlcGyhjS27GW1sG04lyAEoRY2BD6H/gw2W/Q73x
 4cp+UGwoBsagUrxr0+6Zb5T+EK/xV1KQxmQ4SZzn/0SddlKPYAeIYfNQX8XB+qWGy3SldKVtZ+O
 Dn/OQnRTzbn9XDVbqwg==
Subject: RE:  [PATCH] ceph: clear `s_cap_reconnect` when
 ceph_pagelist_encode_32() fails
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020159

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE3OjI5ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIE1vbiwgMjAyNi0wMy0zMCBhdCAxMDo0MyArMDIwMCwgTWF4IEtlbGxlcm1hbm4g
d3JvdGU6DQo+ID4gVGhpcyBNRFMgcmVjb25uZWN0IGVycm9yIHBhdGggbGVhdmVzIHNfY2FwX3Jl
Y29ubmVjdCBzZXQuDQo+ID4gc2VuZF9tZHNfcmVjb25uZWN0KCkgc2V0cyB0aGUgYml0IGF0IHRo
ZSBiZWdpbm5pbmcgb2YgdGhlIHJlY29ubmVjdCwNCj4gPiBidXQgdGhlIGZpcnN0IGZhaWxpbmcg
b3BlcmF0aW9uIGFmdGVyIHRoYXQsIGNlcGhfcGFnZWxpc3RfZW5jb2RlXzMyKCksDQo+ID4gY2Fu
IGp1bXAgdG8gYGZhaWw6YCB3aXRob3V0IGNsZWFyaW5nIGl0Lg0KPiA+IA0KPiA+IF9fY2VwaF9y
ZW1vdmVfY2FwKCkgY29uc3VsdHMgdGhhdCBmbGFnIHRvIGRlY2lkZSB3aGV0aGVyIGNhcCByZWxl
YXNlcw0KPiA+IHNob3VsZCBiZSBxdWV1ZWQuIEEgcmVjb25uZWN0LXByZXBhcmF0aW9uIGZhaWx1
cmUgdGhlcmVmb3JlIGxlYXZlcyB0aGUNCj4gPiBzZXNzaW9uIGluIHJlY29ubmVjdCBtb2RlIGZy
b20gdGhlIGNhcC1yZWxlYXNlIHBhdGgncyBwb2ludCBvZiB2aWV3DQo+ID4gYW5kIGNhbiBzdHJh
bmQgcmVsZWFzZSB3b3JrIHVudGlsIHNvbWUgbGF0ZXIgc3RhdGUgdHJhbnNpdGlvbiByZXBhaXJz
DQo+ID4gaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWF4IEtlbGxlcm1hbm4gPG1heC5r
ZWxsZXJtYW5uQGlvbm9zLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvY2VwaC9tZHNfY2xpZW50LmMg
fCA2ICsrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jIGIvZnMv
Y2VwaC9tZHNfY2xpZW50LmMNCj4gPiBpbmRleCBiMTc0NjI3M2YxODYuLjRmYTQ3MWQ5YjNiMiAx
MDA2NDQNCj4gPiAtLS0gYS9mcy9jZXBoL21kc19jbGllbnQuYw0KPiA+ICsrKyBiL2ZzL2NlcGgv
bWRzX2NsaWVudC5jDQo+ID4gQEAgLTQ5NTYsNyArNDk1Niw3IEBAIHN0YXRpYyB2b2lkIHNlbmRf
bWRzX3JlY29ubmVjdChzdHJ1Y3QgY2VwaF9tZHNfY2xpZW50ICptZHNjLA0KPiA+ICAJLyogcGxh
Y2Vob2xkZXIgZm9yIG5yX2NhcHMgKi8NCj4gPiAgCWVyciA9IGNlcGhfcGFnZWxpc3RfZW5jb2Rl
XzMyKHJlY29uX3N0YXRlLnBhZ2VsaXN0LCAwKTsNCj4gPiAgCWlmIChlcnIpDQo+ID4gLQkJZ290
byBmYWlsOw0KPiA+ICsJCWdvdG8gZmFpbF9jbGVhcl9jYXBfcmVjb25uZWN0Ow0KPiA+ICANCj4g
PiAgCWlmICh0ZXN0X2JpdChDRVBIRlNfRkVBVFVSRV9NVUxUSV9SRUNPTk5FQ1QsICZzZXNzaW9u
LT5zX2ZlYXR1cmVzKSkgew0KPiA+ICAJCXJlY29uX3N0YXRlLm1zZ192ZXJzaW9uID0gMzsNCj4g
PiBAQCAtNTA0Niw2ICs1MDQ2LDEwIEBAIHN0YXRpYyB2b2lkIHNlbmRfbWRzX3JlY29ubmVjdChz
dHJ1Y3QgY2VwaF9tZHNfY2xpZW50ICptZHNjLA0KPiA+ICAJY2VwaF9wYWdlbGlzdF9yZWxlYXNl
KHJlY29uX3N0YXRlLnBhZ2VsaXN0KTsNCj4gPiAgCXJldHVybjsNCj4gPiAgDQo+ID4gK2ZhaWxf
Y2xlYXJfY2FwX3JlY29ubmVjdDoNCj4gPiArCXNwaW5fbG9jaygmc2Vzc2lvbi0+c19jYXBfbG9j
ayk7DQo+ID4gKwlzZXNzaW9uLT5zX2NhcF9yZWNvbm5lY3QgPSAwOw0KPiA+ICsJc3Bpbl91bmxv
Y2soJnNlc3Npb24tPnNfY2FwX2xvY2spOw0KPiA+ICBmYWlsOg0KPiA+ICAJY2VwaF9tc2dfcHV0
KHJlcGx5KTsNCj4gPiAgCXVwX3JlYWQoJm1kc2MtPnNuYXBfcndzZW0pOw0KPiANCj4gTWFrZXMg
c2Vuc2UuIE5pY2UgZml4LiBCdXQsIG1heWJlLCB3ZSBuZWVkIHRvIGNvbnNpZGVyIHJlZmFjdG9y
aW5nIG9mIHRoaXMNCj4gZnVuY3Rpb24gYmVjYXVzZSBvZiBzdWNoIGlzc3VlLg0KPiANCj4gUmV2
aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiAN
Cj4gDQoNClRoZSB4ZnN0ZXN0cyBydW4gb24gNy4wLXJjNiBkaWRuJ3QgcmV2ZWFsIGFueSBuZXcg
aXNzdWVzIHJlbGF0ZWQgdG8gdGhlIHBhdGNoLg0KDQpUZXN0ZWQtYnk6IFZpYWNoZXNsYXYgRHVi
ZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4gIA0K
