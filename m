Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6A3ED5D9
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083444; cv=fail; b=o0Cxe2BvwIkqKOkub0aCQx83qku7V37MhkJmcaFP6uRAfC36OA/zeJCx9ZLC3OipqnAd+y1HPRcQXN0xJtfKaSF1VfxK2mf6yyXl31nuN6B1gCQAZeQ9aIpnhawSnB5JrH5r5XMSVjaS6X9aS6FQjWQ1bPRoC1Gv5HXuG8j3HEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083444; c=relaxed/simple;
	bh=W9PSVdp5olohuYQwR4+wp9driukBLHlXVENfOijRy2c=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=gPRXfqHQp9gLYQEBtaHyhOiG6oFtbPZiQL8MdxDyX2kZ0l/puD9+zX1zqz8Hp06uM0lVMdobp4Pea8CMtrywbis2AJePVJOUoGzh71gwuntkSUO8ieHaHAt1UvKlrtZ8LoVKhzMie9RPxlOptNAq/u9DHVNPNKymZ9iNEuSHOiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RHSZGkAK; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RHSZGkAK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629FmZ3D1527158;
	Mon, 9 Mar 2026 19:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=W9PSVdp5olohuYQwR4+wp9driukBLHlXVENfOijRy2c=; b=RHSZGkAK
	8MgkaCPoqMzi2SD8T0fdCk1JGeI3wFmw/dZ6LCgIHOdYK4ZwZ9VnMKkPiWopUHeL
	OXXv+VKlumZjAHNZ7S8SPIzrmLvD7YeumnXFHmaaMAqzacZlD6IOIkIwT1J9oKr6
	QNTA+psd3/ZI3TYNtcsxc3E6CF3gUhhEUoU/D4ePnR//6lC95ar0ejHWWM/t3Qvc
	6EwnRkdydruuRwKUbjylocoEw6tF5DKmdyuO4ANryRRdjTH5+lLUXuFsqMo8C9uB
	asafAmsrcMz/d9RLOekI638w0Wv5h9X2ZQeZ4nUTEH40Sd8c2lnH76smB5fW+jgu
	np9nWYR9uQ3eWg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun7sg6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:10:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+kWkvQbPKigJH6VHDqv8tgiCFEX6b83e7Q+ZPp4X6S5aAppJKxSr5TWNdJ32nGNn9rCZmWlh1+ih+j20wojSUVKdeitoaT6Rhd/DMemxV14qWak6p9pPbm6QhmFIpFqrArObnRsqbWhLmf+9/waitowSh8XhoalRUL+eIwfEKKc8f5BbHdk+3SlvXiSw+HThan1poCMhkuME1ko2pAwzCQV9DZEvwO4cqa/UDavMAAE1ruz74bIlCjXax/TGAZhB8Xw/uti1Xk/LwHZmNE6NvzVtKaSavCqmr6+xMWARzApr6Dt2KRCSz2nGin5rpN6E4F4PCy17amnH928FLpEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9PSVdp5olohuYQwR4+wp9driukBLHlXVENfOijRy2c=;
 b=LTLc4bABrmVlQYsWRxI0tyOOngHrrerP+aMQxr0noZIibwCcfzJMuGl7/UrXBJ2CUIpkge19F/AOUhrQ+VWpbICdsl/5qIS4yx+VP7hSjigYXPQfKysz6DNLJSK9DCe/b83UxyfNuJBiwLJ7mgI9STIlTWUX0JvicJTlteiETgvDvLzKCnpfvDx3T7Rub7PD9uMj52I6p3kWCKP86D+ofvoOk5RdRhtNLEv4HeWSvhAa/g0sC2k83Hnh4YTrkTOsa2rciD/LMvYxMMCw86xBrTkXd1nhOHb7knpzM3PCfCzeYBDKaUIxatkV0V/L6+Qa7jumXeknxGVPYU6fj+O0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPFCAB1AF183.namprd15.prod.outlook.com (2603:10b6:f:fc00::9bc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:10:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:10:32 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: prevent potential out-of-bounds
 reads in process_message_header()
Thread-Index: AQHcr/dlVL3CUj6f1UmXb5/tuUlaH7WmkNyA
Date: Mon, 9 Mar 2026 19:10:32 +0000
Message-ID: <7c73a1047d2195e5006046c061851ad1437ba0ea.camel@ibm.com>
References: <20260308220804.694227-1-idryomov@gmail.com>
		 <5815cbe7cb93857effc0757a765a15ef1a2e4cc9.camel@ibm.com>
	 <CAOi1vP8-fDD_nQQvbSrqrHzAa-OPqBpNjk3kd53UdqqVzRMR5Q@mail.gmail.com>
In-Reply-To:
 <CAOi1vP8-fDD_nQQvbSrqrHzAa-OPqBpNjk3kd53UdqqVzRMR5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPFCAB1AF183:EE_
x-ms-office365-filtering-correlation-id: 8be1fcd7-9667-4706-b8c0-08de7e0f894a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 3UZCVCORTlkX52ak7kwrmqZGC+9VkBDpVO37wcjRs6E+NeLMVhjG8Ev2tzyVRmvwUuBhLMWryKDmPhZdQpSGVD7m5OduaIQbZqGZzLWOmR5bRLjUf6FyJo17peiS7mWOquMKwCpXrPZC22TqbRY5LmqQIsJg+SX1XGifoC6YcocvvD3DSZO7SNvIFKyXHTMVB1le2MFO4lMGzd0YR5k9jZhWTzIDAj2a25y3BQbDFZlRTV1NtShQdp0Yg+otBPdXzOlkIwqo1/VW72ggJCoYhG8VB7Nbkde5BKuuXStWDKzB7+yOtUz3mtLeGU5Ndzm4zgL5NdWkM76yIrb/INELD0HIQzPYzR3boZovjwY1SuYIgzvepLnPJKQFqEWlW1lcxP/l07LHvgVYKFO3KoD1Iti9oFURZjRwGsFr+pTlzcc+t7aoqlDTYh8LDnRRrd9L6uilpR49hpsKLdGPw+D/lpyikldz8q0oqA78wBI1CCZbyiUw2jVrY7dROO/laLC3onJOt/NZI5QQrcHwKTkvBedGPNCU+lDzaytKFZEOltAUehorNo50X0IeXDYJBxzU19vi7Xg31WcVJJQNX2hL/XCSIRB3K//Ls7kB7VtGlKFJLVwe1XpF2yWiQh6HNGz+d0YkuupW0nsL10Fj7Xo0FGKBfHRV5lJHorR0O0xM/+yAlSYNKEIfSpAj6Np7NWHWAKzPeLoW17OWD6AsKZ4/Z92oUPoBM2PbOCn6GWS+YQcGGeX6ZlzXepYjEDBBGqucTcd7QUSdCyYvJIkQk1C/H0f+YLfWO/zGEQaPCU94X+o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWNkMUFES1RPZzZCMkx4L3pzOEgvd3ZMaEY3bnNqNGlNTTVWcDFFRFArKzds?=
 =?utf-8?B?RFN1RXlZZjM5MWtjMnhXUmpzMldQTW1ONE1rV3dYSVF1L3NiVFQ5dUg0T2l0?=
 =?utf-8?B?dTJSeEdlYkpURHE2ZzJBVjhHeTdQYldsR3lsd1c0ckdUUlcvTWJtZ3VyWGJR?=
 =?utf-8?B?blhzamxKeSttRmtzclBDdkpBR05keitRWU1FQnpXbG8relJJSXZWMU9JRFlB?=
 =?utf-8?B?Kyt6QlE5eEZ6aTdkNGZ2Z3hiWWE5QUtjN1NjYWtXNHl3dEE4eGNCVyt0NlRw?=
 =?utf-8?B?TjBIMmVHQmJwTzU0OW55ak9HQWhWUHhLczNDd1RkaUxVWXhOakxHOXVxemZI?=
 =?utf-8?B?YnE3bjNhZGRWbkVmajJ3SVduSVYxc1J4bElSL09rRHZDUTBDTFpLMlkvZGhs?=
 =?utf-8?B?NWEvRHdLN0tIaUZRSHN4N2NycDBwTmN0UE80RVp5SUNHWWV4ZTk3OUZLU1JR?=
 =?utf-8?B?VE1hVkJ3ZTNFZHB2cExuV2hyV013RFlKeThkV2FXTkxDSFJBazBrZDk5Vzl6?=
 =?utf-8?B?dUJiemlTSzJrREpqVjhzck5UM2VMaVl3LzUra1RHaWVlaU1iNnNvUm8vYVpw?=
 =?utf-8?B?RTdRSmZyb1laanF0bUhMbk5kV015WGJxdjVRNExPakpha1Q3WTBHaUxLYVFP?=
 =?utf-8?B?M3VJUFhiMnp4V0lBdHNxZzM4dXZSSVdob3hyd0tiZTdOOWg1dE1IZlkyUU1L?=
 =?utf-8?B?T3N3MlFDcjk2MnQxSWlFeCt2V2YyYmVMM2pjVXYraCtzQkROT0tSL3Rha2RJ?=
 =?utf-8?B?NUcyN1NZU3U2dUlzWE82UzEvSlJsMW5aeWgycnVSNXlSa2R2cjhucHRFaUJT?=
 =?utf-8?B?UU9udC9GR1ZUWEVYZGJHVkM2U2dlNWpXaDFrU1lJZE16T3V4NWgvZThzbGxQ?=
 =?utf-8?B?K1pQZWxnNWpJcTNMbmtCbVNORzNIdXYyZ0ZKMVc2S0N2T01Peit1ZVFWcTVq?=
 =?utf-8?B?MTZFalRPcko5cyt0eHVTblFiNjYrVUxWVHE5bEhTZXI3MiswSVZidE52cW5C?=
 =?utf-8?B?ZnV5c3o4UVd1aHhpRjdjMENZam9sM1lGY0x1NzMvZ1pDdWpGQnJwZHdDWDNX?=
 =?utf-8?B?ZFM5TkVzVnpmS2xjV3hUUnE1QXMxM012MG4wNXEvaVp3UXBJN29xTFlxaXFJ?=
 =?utf-8?B?T1NxYTlJUjBFSDJ5NkpjNDg0ZHFaQjI5ay9oSnJwRkpmMi82MHhYUE1aWjdv?=
 =?utf-8?B?c1FHUDN1NEFPLzZTaGJER1V6NlBseTZGZUlIa3RiU24vdGdHUFptRXh6Y25h?=
 =?utf-8?B?T3FheEtTR3ZkMjdVMEcvcDFLMm12M1FhaTVjTy9MaFVrbEZ1eFZOTmlCY0pI?=
 =?utf-8?B?YWJ2QUlIUDdXZTZWVmxhYVlGMG5ySC9YOXFVR0FuVEJjclVCcVAxcWx5dkRY?=
 =?utf-8?B?QmRaeldPbGpqQStPbnprU0RmZHlsN0hlN2FYd1U2dE1WNCtEbTdoNUVSWXg2?=
 =?utf-8?B?aEpSQjRCYnJDTkhQOXRONDVBSmVmaVUwdm5aV2I4Uzh3S3c5MVJXZDVrSVJ6?=
 =?utf-8?B?Y29LbzNDOVNFYjR5eWVGVUY5cFJ6UXNuTCtUMXR2aEtYbmVIaUdiVGQ3bUhL?=
 =?utf-8?B?c2s5MTlQRTJTWDJIdmVGUURSVnB6RVZSTXcxTmtHU0FsRUZxUEJXUEVFckJm?=
 =?utf-8?B?cW94RFVXVjVNRFE5eDV4b3NBdU9Wb3RqSFEwbTArT3M2Rk5BTmI2cjIxZEdw?=
 =?utf-8?B?TEZHR2xoZ1h3SzRWbXZYYnJRcDBxSUs4MTRUN1BHM2RiRDdEM2NvaVM0WTha?=
 =?utf-8?B?VXJRU3BPNXhiV2tnSDc4Q1pJVDlxRURjVkZNTVkvTGZuNzgxdjFjdDhUb3da?=
 =?utf-8?B?TDJzemtNOTlNMjVEQ09Ua3NNcE9UTnBmNnJzRUJZNzhKTkIrdWxvejZmcTl4?=
 =?utf-8?B?bEI5bkp0UkZvV0RWckd4SkJtVENMbThRZHJtN2dpQkgxYjNpbVlNT3RDNWtI?=
 =?utf-8?B?eDB3dEFsUEl4RDdhQWNWZmJtM0NXNW5oaFpzdzQ4MnBZVTVrckJJSU4zS2xy?=
 =?utf-8?B?T01BV01IZVF0eU1xVU8xNG51RnE3MTYyZ1lhbG5TUmtOTHVTM0ZGSE9GdmJx?=
 =?utf-8?B?VC9OekNaUFUwWFRWMHVpYlExNVFqMnduWTVEMWptWkF6NlNydzRaemxhL2dH?=
 =?utf-8?B?cUdoek1nYlJLTE5LVFZGNFdJek1IOWVPU2ZFd1NmbHcyUG5QRitvTzZsQ1dQ?=
 =?utf-8?B?eW1mdjdaRFRSdklkNEVtWVlQWHVZN1VaMzloV2d3TU5kZ1FZV2pndXV6RE5Q?=
 =?utf-8?B?bE1WTWxEZWtYSlFDUk5BSGhUdmdLMGQ3b1ZEMXM4MG1pQlJlUDRCaFRLQmcr?=
 =?utf-8?B?UkxQZTRUbFVVTDhtVFJvam5wSThxZjR0a3VzSG1IbjhKNVpMKzJnbGFwZXJR?=
 =?utf-8?Q?fVBSIpRKfGNjk/fUKAoLuUZc1u6c/2mRvE9ty?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B91CBA409271434A9ABA69323F9BC2A4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dMc9o0Driv5Hvu4E2PqWQ1oO5kJ6dipRqypuGeWGnQ1b0u9PCCBSCyzIQk76du8fjSI+inC4Olt+0HAM1y68kOKEXlKQsshRIafyyDnCyG4IEVKzI/9tg/7GANJl2VDJqpQUfqaf189uyOZLNOqh/6Wai5Z5Wz3TwvpymqO6KCmcYl07slcKVPB/JQX7KlMCNja3t70yYbU60RuztizORUy9dOvLV7gJFPTBbsm/XS+JdD7GqpyL+Q9kTNP2PuzDuY47LCyD1ypmzPZzB6nlFijGUp+jYtXOEml+XNiCCIOlfna14pd+bCHPnZn1xfIurm/h0IcWtyt4UWyAwR59LQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be1fcd7-9667-4706-b8c0-08de7e0f894a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 19:10:32.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5se/TgZYnqCFxVywhmqDfZNc4OhwaJZNPCvWydf3YzU+7GJv/fQkID9S3SwCRjGcKZu2hERt+HO7O2GzKgAGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCAB1AF183
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: mc4j3i1IA8xEOlxdGQqLeS5sF_SGDwtJ
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69af1b2c cx=c_pps
 a=AdSExLHk7727Th38kKp3hg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=3hAf2EIJecq8avkHUxYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2OSBTYWx0ZWRfXza5TNtr7zORY
 M5wmdXjYAED1xoY/IejyRJxoQszznbwNwcslSZ3082c/UoBAxANvBcX52q9Cc2+VqBX6h2HFj2l
 VffFO3xttZyScuBKrvUdpqOadgrfJsr3BwHFNcYGIdMH77tufT+Zq7IOpKMaKrnfiAzuOsdwUUs
 h8oyLe0f4B+gPOEwnWMVGb6j37rNmXpKfddUz+K7KRwfANzVGh3uM7ydTtDKmFFkihyhI6YhG7b
 hNg0K4ahVd8C3z/bjQWanMGc8/QlS7137X+1+M/81/1hb8BCjl52lWZPg5R9h5YxuOU9UrGuaYA
 r5iOoi8CVDR44sNl3cNU1MJ1dFReoQy9YsQsAiJt3Hiyw09vWV0gmGOU8R9E+6jevBNWbG9JMJu
 46agqCXp3afJIFZjGRJIRuJWV+txZ0kSSi1Blwadm8+MeCJwNonCNENptW3L0LNlJ2WkyspM4un
 FouHdCokywUzEngkuSQ==
X-Proofpoint-ORIG-GUID: aqTKO9zSMi6lRil6BbnpTG8XGex9tZq1
Subject: RE: [PATCH] libceph: prevent potential out-of-bounds reads in
 process_message_header()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090169

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDIwOjAzICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IE9uIE1vbiwgTWFyIDksIDIwMjYgYXQgNzo0OeKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbyA8U2xh
dmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBTdW4sIDIwMjYtMDMtMDgg
YXQgMjM6MDggKzAxMDAsIElseWEgRHJ5b21vdiB3cm90ZToNCj4gPiA+IElmIHRoZSBtZXNzYWdl
IGZyYW1lIGlzIChtYWxpY2lvdXNseSkgY29ycnVwdGVkIGluIGEgd2F5IHRoYXQgdGhlDQo+ID4g
PiBsZW5ndGggb2YgdGhlIGNvbnRyb2wgc2VnbWVudCBlbmRzIHVwIGJlaW5nIGxlc3MgdGhhbiB0
aGUgc2l6ZSBvZiB0aGUNCj4gPiA+IG1lc3NhZ2UgaGVhZGVyIG9yIGEgZGlmZmVyZW50IGZyYW1l
IGlzIG1hZGUgdG8gbG9vayBsaWtlIGEgbWVzc2FnZQ0KPiA+ID4gZnJhbWUsIG91dC1vZi1ib3Vu
ZHMgcmVhZHMgbWF5IGVuc3VlIGluIHByb2Nlc3NfbWVzc2FnZV9oZWFkZXIoKS4NCj4gPiA+IA0K
PiA+ID4gUGVyZm9ybSBhbiBleHBsaWNpdCBib3VuZHMgY2hlY2sgYmVmb3JlIGRlY29kaW5nIHRo
ZSBtZXNzYWdlIGhlYWRlci4NCj4gPiA+IA0KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiA+IFJlcG9ydGVkLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1tZXJAdHUt
aWxtZW5hdS5kZT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IElseWEgRHJ5b21vdiA8aWRyeW9tb3ZA
Z21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgbmV0L2NlcGgvbWVzc2VuZ2VyX3YyLmMgfCA5
ICsrKysrKysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL21lc3Nlbmdlcl92
Mi5jIGIvbmV0L2NlcGgvbWVzc2VuZ2VyX3YyLmMNCj4gPiA+IGluZGV4IDVlYzMyNzJjZDJkZC4u
ZWQ2MTg0MzVkMzNhIDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0L2NlcGgvbWVzc2VuZ2VyX3YyLmMN
Cj4gPiA+ICsrKyBiL25ldC9jZXBoL21lc3Nlbmdlcl92Mi5jDQo+ID4gPiBAQCAtMjgzMywxMiAr
MjgzMywxNSBAQCBzdGF0aWMgaW50IHByb2Nlc3NfbWVzc2FnZV9oZWFkZXIoc3RydWN0IGNlcGhf
Y29ubmVjdGlvbiAqY29uLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
b2lkICpwLCB2b2lkICplbmQpDQo+ID4gPiAgew0KPiA+ID4gICAgICAgc3RydWN0IGNlcGhfZnJh
bWVfZGVzYyAqZGVzYyA9ICZjb24tPnYyLmluX2Rlc2M7DQo+ID4gPiAtICAgICBzdHJ1Y3QgY2Vw
aF9tc2dfaGVhZGVyMiAqaGRyMiA9IHA7DQo+ID4gPiArICAgICBzdHJ1Y3QgY2VwaF9tc2dfaGVh
ZGVyMiAqaGRyMjsNCj4gPiA+ICAgICAgIHN0cnVjdCBjZXBoX21zZ19oZWFkZXIgaGRyOw0KPiA+
ID4gICAgICAgaW50IHNraXA7DQo+ID4gPiAgICAgICBpbnQgcmV0Ow0KPiA+ID4gICAgICAgdTY0
IHNlcTsNCj4gPiA+IA0KPiA+ID4gKyAgICAgY2VwaF9kZWNvZGVfbmVlZCgmcCwgZW5kLCBzaXpl
b2YoKmhkcjIpLCBiYWQpOw0KPiA+ID4gKyAgICAgaGRyMiA9IHA7DQo+ID4gPiArDQo+ID4gPiAg
ICAgICAvKiB2ZXJpZnkgc2VxIyAqLw0KPiA+ID4gICAgICAgc2VxID0gbGU2NF90b19jcHUoaGRy
Mi0+c2VxKTsNCj4gPiA+ICAgICAgIGlmICgoczY0KXNlcSAtIChzNjQpY29uLT5pbl9zZXEgPCAx
KSB7DQo+ID4gPiBAQCAtMjg2OSw2ICsyODcyLDEwIEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19tZXNz
YWdlX2hlYWRlcihzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sDQo+ID4gPiAgICAgICBXQVJO
X09OKCFjb24tPmluX21zZyk7DQo+ID4gPiAgICAgICBXQVJOX09OKGNvbi0+aW5fbXNnLT5jb24g
IT0gY29uKTsNCj4gPiA+ICAgICAgIHJldHVybiAxOw0KPiA+ID4gKw0KPiA+ID4gK2JhZDoNCj4g
PiA+ICsgICAgIHByX2VycigiZmFpbGVkIHRvIGRlY29kZSBtZXNzYWdlIGhlYWRlclxuIik7DQo+
ID4gPiArICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICB9DQo+ID4gPiANCj4gPiA+ICBzdGF0
aWMgaW50IHByb2Nlc3NfbWVzc2FnZShzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24pDQo+ID4g
DQo+ID4gTW9zdGx5LCBsb29rcyBnb29kLg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBWaWFjaGVz
bGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCj4gPiANCj4gPiBCdXQsIEkgaGF2
ZSBvbmUgcXVlc3Rpb24uIEFzIGZhciBhcyBJIGNhbiBzZWUsIHByb2Nlc3NfbWVzc2FnZV9oZWFk
ZXIoKSBpcw0KPiA+IGNhbGxlZCBieSBfX2hhbmRsZV9jb250cm9sKCkgWzFdLiBBbmQgZW5kIHBv
aW50ZXIgaXMgY2FsY3VsYXRlZCBbMl06DQo+ID4gDQo+ID4gdm9pZCAqZW5kID0gcCArIGNvbi0+
djIuaW5fZGVzYy5mZF9sZW5zWzBdOw0KPiA+IA0KPiA+IEJ1dCBmZF9sZW5zIGhhcyBpbnRlZ2Vy
IGRhdGEgdHlwZSBbM106DQo+ID4gDQo+ID4gc3RydWN0IGNlcGhfZnJhbWVfZGVzYyB7DQo+ID4g
ICAgICAgICBpbnQgZmRfdGFnOyAgLyogRlJBTUVfVEFHXyogKi8NCj4gPiAgICAgICAgIGludCBm
ZF9zZWdfY250Ow0KPiA+ICAgICAgICAgaW50IGZkX2xlbnNbQ0VQSF9GUkFNRV9NQVhfU0VHTUVO
VF9DT1VOVF07ICAvKiBsb2dpY2FsICovDQo+ID4gICAgICAgICBpbnQgZmRfYWxpZ25zW0NFUEhf
RlJBTUVfTUFYX1NFR01FTlRfQ09VTlRdOw0KPiA+IH07DQo+ID4gDQo+ID4gSXMgaXQgcG9zc2li
bGUgdGhhdCBlbmQgcG9pbnRlciB3aWxsIGhhdmUgdmFsdWUgaXMgc21hbGxlciB0aGFuIHAgcG9p
bnRlciB2YWx1ZQ0KPiA+IGJlY2F1c2UgZmRfbGVucyB2YWx1ZShzKSBpcy9hcmUgbmVnYXRpdmU/
DQo+IA0KPiBIaSBTbGF2YSwNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgc28uICBmZF9sZW5zIHZhbHVl
cyBhcmUgY2hlY2tlZCBpbiBkZWNvZGVfcHJlYW1ibGUoKSBhbmQNCj4gdGhlIGZhY3QgdGhhdCBp
dCdzIGEgc2lnbmVkIGludGVnZXIgdHlwZSBpcyBhY2NvdW50ZWQgZm9yIHRoZXJlLg0KPiANCg0K
T0suIEdvb2QgdG8gYmUgc3VyZS4gOikgUmFwaGFlbCBjb3VsZCBsaWtlIHRvIHN1Z2dlc3QgdG8g
Y2hhbmdlIHRoZSBpbnRlZ2VyIHR5cGUNCm9uIHVuc2lnbmVkIHZhbHVlLiA6KQ0KDQpUaGFua3Ms
DQpTbGF2YS4NCg==
