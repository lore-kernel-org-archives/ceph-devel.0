Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A55C24A076
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2026 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091295; cv=fail; b=YDE9GXoRWb07zWTW1/UBe+65CVnmjIEOkYEC63apCio4c4RPp+/Qz4+hTv4ngYV68xyzCGZgMf+Olwy3VS4eH5BNK3dcu15Ay21bdDKFsDZ6Jamn9O76a9IDnPmR7sUv5KoXMY7b0Q9w1lAkGDOQGj90p8mDsbcCfaUsHHV1zIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091295; c=relaxed/simple;
	bh=B5KRzrEY63WASmwQPtX7EPZtcjzTGWMJPIxhWKgWWIs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=CGzp44NeVVfRPIOywHAwXLsP97D23Nk3ewYv2pEYuAAOnJyS5NKe7gMO1JDKR/mNlwiy6VRKYeWWbLXLl0qUvHp3QA0Q9hF2qNmSw+E6VnulIUrunWoum1pLpwVwGprV9xof7qQvfmznB+RToMKl6qPszQhrN1UPRmNaeeGNc38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ku4SIqD8; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ku4SIqD8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646CF80D2807278;
	Wed, 6 May 2026 18:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=B5KRzrEY63WASmwQPtX7EPZtcjzTGWMJPIxhWKgWWIs=; b=Ku4SIqD8
	R0rcjD1YdicEC82EvX4uM2mIAn0Nrr39s1EVf7G5xLZeI1yVHYBpaYQW8tESy9Y+
	d1a+umA6U1j0Vmtdx38cS2N6QDxynCLNze3qpuXHB/7oE3t4pzyZdpOI0XnOYiEb
	S2IKdqLVtngyXVB8hfDqfDy+erbUAqRgn47Dy/Q1Fn66Mf2ncHw1dAhrYtbNMG55
	ThJCFiGEcTQmshMnMhjNTEIJ6V5uxe15mPN39ToaQw4gakh/pOywjPHbS0PXa/GI
	JeHZbBfzMOZ5gI1Xg81d+obaoFqqwAM/VOs/ZfKQ3o7TOi35X5QeMnUIYAnJT1vZ
	BAVkuyrJvUcyCA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4se98-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 18:14:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuwmaL7a91ZQGvfWx4yKV14QHnezyTDqxmazgT7jdoFVDrxIJHunb1XakJq8yJ454fvsAIgiLhr8ZiTyfnMPrN9kb6rHP+wL5OS4VnMVK6ig3pDF4wIhdhWHCd+8ErURn30Bf5g9NOEO1Qf9ADJINK45fH7xhqGGy8eykFkN7wwkOQDty2QH3vutnpNu8irsxy/V4QjrZzGEIw7SZagkfvQPPF/JSdTWnYe3XjCu99VDfRfv1xeye9rXxXzqSfS0DSQyQOiBic/vyQYDR+edqtsF7jSMEOSp5chOyNtP8Nm1itIuO4kQfVeT2TMGBTirINA4++MRdm4rqccaDqrmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5KRzrEY63WASmwQPtX7EPZtcjzTGWMJPIxhWKgWWIs=;
 b=HYanZYBrpi41yEjA+S2QqU3RDoXFXza1szksH2RAsDEPCBVzOr1bE4ofG9vy/JOJIDPEQOCjKz7PhWhf/FJOz55mvX+m3MCSMoezbGhtjRhx3wGLB5b8+LxLce3AWlbGY620uwX9qLacxzn5bAnSig3NtqyP9Hky1wmFFblKs5xHrLKcLl3rISKDyUmdzAqGEj+PGkTysbzRbE9PK2r9CxSpWjsMGZrCb4OKgyGA+ExpQsq90qKbeIOeoUhBwMrWR3mHX0yUL5wylmJYt9V6HSs2eVNFCEMAcN72xokuhULLTbOnC8wenqZXP7KPi6KIjLo1fYJwEHwqWDHHiB4J3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB6845.namprd15.prod.outlook.com (2603:10b6:510:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 18:14:43 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 18:14:43 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Fix potential out-of-bounds
 access in osdmap_decode()
Thread-Index: AQHc3VjjFP/Q7rvKeU2CkBAfcLsCdLYBTbkA
Date: Wed, 6 May 2026 18:14:43 +0000
Message-ID: <5e0fa20df4322f6facc80dc6270a59b0361de410.camel@ibm.com>
References: <20260505090812.500588-1-raphael.zimmer@tu-ilmenau.de>
	 <ba35c81180e74517613e3dad41e5f5a938be4137.camel@ibm.com>
	 <ce329dd4-54b7-4bbd-ac9c-7ea18488e0e8@tu-ilmenau.de>
In-Reply-To: <ce329dd4-54b7-4bbd-ac9c-7ea18488e0e8@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB6845:EE_
x-ms-office365-filtering-correlation-id: 06aabce8-ee5c-4f1c-14b2-08deab9b592b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 hoJiIHXpWmQNSS7EplzVPIJr0NODkyWY0vQrCv8eNNb+sC5aDQ1oF5EGT8RkBS1SXPtjX98yUDWbhfI7SKuOarkdsznTyCDFMtw8jCKr4FW0A4mMCX0/oU6fG+2EIoAo8AtxNOxSCYa4886WPJoJNMIK13qder4TezeV6CNKrO1/G59W/HbaTJEWp3tXvF0SPu+hP0WeNNoy2hGWH68aAM/CcufvEJKYLFvO+PMtMo2CphQabmrfRrE7Hhi8SvRQ468OewJoL7Xoh1+7Uf/otIlVaB54eVIFUIQiz7/V4bZymm/843exBnFjOMFeHK9YA+R3JM5uEOkMYOEWx3VL24+fArVBznoKQjMF66r1D9qmdIGcMPBXqfK9kHYnEmRuqyEhGenwz+H37Di0XeU801GHFXUXnKrvwVpxutWKnVB2eBfsymyv86Da5p2XHJqEH5qe0+FW2rDC28kmnaRUPzNlj61u8xvgYuU+Y2d0lRJgJRf/164H+o12/yxuEqVCVEMeFKQs8UETs4U0L+4AliatMVsglrTcg6R6a+14ovk3xpleh5DdURPJrxt0HoB5tI9FFaD3QSdWS0sBO6VZs6a0GQAXX7qRgT22f9xph/mUst0ipDcp7d1Rw0CgmI3U5j+uqQU/orSJ3x3f5x88wF1nVg+vXhCEDxR4gV8pSmdrNDXJFI0KSyM7xSf6+qSEBWNL3jEkaz4m4Fmd7zcqTSi1CmbF2vEQE4PkAK+9MyoyHDAUSpIwvCSOe9XspaBA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1lDZUpIQ0lYSGM4aGtPL0wvZlZZZWNBaHZHdWFOR0JaYllxWWVwMW9MZjgz?=
 =?utf-8?B?KzViYk52ZEZTV1dIUXNJQkVaMXczRktENWxpaDlqOHhyaFdickFIV3d6K2tr?=
 =?utf-8?B?ekRsSWlMZTZRTndqYXpneHFxSE1qbGxjRmFNdjRwWVgrMkxsVkdmQU1KQUQ4?=
 =?utf-8?B?UzR0UTFZKzVqdmlYSVdTSS9TTnhBYXlpWExHVlg2ejJxVWJoS1BmN0ZJZmRB?=
 =?utf-8?B?eXZkSmtObS9DUnorWXJlcmQ1UVBFeWNiNEdxZnVPd21NaWVrUWxCUWlLUSt4?=
 =?utf-8?B?WmU5U1ZnZGxrVmQrL2JGOTAyY2Q5aGpSY3BxYU1uQWdNK3ZWUDVZS1BwYVlt?=
 =?utf-8?B?cVJQOG12NzQ5R0RSMkJkM29HNTFxSzZBOHhSdFpuSXNWdlpleVBiMmIwbGNY?=
 =?utf-8?B?MjNzOUJ2eEVHWWMzaGc2eEJnVVNhcFQza1NDbFp6TlkvWnhUMTZKbkxQTEpJ?=
 =?utf-8?B?Tk92VEJuRDltdytyVytRaGd3VlRUUGJrekM4eHVBSjF0Nk82cXFVbzJqaW93?=
 =?utf-8?B?VXh1Z3pDM3YycjJRS1ZHeUkrd0phZkpXUDMrbjV0SVdXVEtRMXZTWnNOM3pk?=
 =?utf-8?B?S1ViUTdKbGRuWGNwY1lkNHZaV0wveVZtZUZhK0wxMUdhNklIb0lxelZhOWQv?=
 =?utf-8?B?NGNkTlgwY1UvMGRoKzNQSGRqK1JaSzFYNmhGOWp3MHJpNk9nUVMxU0VKTEVo?=
 =?utf-8?B?NUlmakJYMUdQNFVmVlU2aDZ0dGptVGsxOTVlSUx5a2w3NDhaUGs0bUs3NWZL?=
 =?utf-8?B?bERyOHJId3JVamQvdlNFeEtJUFlIS215eW5GUCtDeUZqMEtHUWRQakJwSkh4?=
 =?utf-8?B?ZHNnZGJ3a0s1OHRFMzIraTFXMEplRWkyR2pnNENvY2R0cytiUGZBeHp6OEhF?=
 =?utf-8?B?Uk81UUFnMENRZHcvcXMreExpWkY2N3V5RDBhb052NFpCWVRLM3hoSjlva1J0?=
 =?utf-8?B?UFhJT1ZsVzNuZzZuUDQ1TndhVWw4YXVkMU9NY2RnRHc4WlEzSGM3YlAwczFS?=
 =?utf-8?B?MHpFc2MyOFdtL0RYd24xclRDTEJDZ1hFMHo5amc2WjhIcUhBU29idExFcmhp?=
 =?utf-8?B?TGFVaWdLZVhRRnFMQnlITE9WeU5jUU1GcTNiejlJclJDSzZDSkVVdUt3djlp?=
 =?utf-8?B?UHZGY1prK2lqZVd4Z2RWWVNFMnZyQ3F2OXY1bFQ0bi9HN3IrZnYwRVB3N1Rq?=
 =?utf-8?B?bGcrUWZFQ09nWkxORUlqaGtWVDNCbG00dHh4eXNWZFRCS0U1QWYwektxaWhX?=
 =?utf-8?B?dHNtNEVicm42QzVJZnhPRzJudWY0V05DZnFkYlNMMzh5cVhuWnBvdU5nQnFn?=
 =?utf-8?B?UkxaZkdxajZLKzBFWWNjblBEeEZJajhaU3JOc0pUR0J5NWphVld1L0VCUFg5?=
 =?utf-8?B?eGk5azkrWVhiK2lXMlUzZnI4QWF3aW02Um1DZmF0cEcybXNFanZCSEdOaEY2?=
 =?utf-8?B?enZYZ2tOa2ZqVDQ2cWNGMlZHRCtVK2FvN2czZko1YWorWGVLSTZMNXQrVWMz?=
 =?utf-8?B?OXRKNzlKb0lSblZtZ0lJNmlua2o3dy96SzVjdTAxZWhOL0R6M0lyMmRGV0gz?=
 =?utf-8?B?cURXUU1nYUhDUnQrRDBWL0lyL0J0M3E1c2xzeDdiVXRubCtxd3hHbEt2bXNI?=
 =?utf-8?B?WW5OeGtITjNOM1ZqM2ptMk1iaGQ3MDVlbGtUcnliTExLOWhqbEJQS2RlV0U1?=
 =?utf-8?B?ME9sb1NlTmI1MGRISkxJWTJJM3BiaVRCNCtya3VmWUdCajlTYkQzMThQYXhU?=
 =?utf-8?B?SUM2MVBFK2pPemRmRmNXc2EvSENvVXIzMlJncEQ1UlFmL3ZkMjk2aU1oUzFx?=
 =?utf-8?B?NTFldXpPR3ZoZ1MvYm14dVBqOFZyL3FwQWZ3ZXF2OUprUVhKUTZMaUtxZmY4?=
 =?utf-8?B?RkszSFpwU2p2VUR5MXI1cC8xRnVKbEQxSC91SEpHU0JJa0xwTXMwdWREOHF0?=
 =?utf-8?B?ekpLWmZQZ1ZlQVkwSmwrRjhnVWtsQ29xTUxrQnltUGVMbmh0WGszWk9oZHd0?=
 =?utf-8?B?bVlKZ203VlAzL1h0b0NpQVVmMzFodlZPWGM5dFdoZjl6TlF6UFNlVEVYWkJo?=
 =?utf-8?B?eFlVZlJPMkZZY2pCd1VGQ2kwYjdGc2NOdUZyQXJBSGFMQUIrYTlNUytBNW5U?=
 =?utf-8?B?MWFMNlB2dEdiUS92c2d3eVBEYUQ5elNoRTFqLzkwa2ljaGtjQ1creU9VSEN6?=
 =?utf-8?B?c1J3WGNzWjdiZktqVHIwNzFudWZGTkVWTVV0MXRnejZ5TkRLQjQxM2FCU3M2?=
 =?utf-8?B?TkFJbjk0UWlFdS9DSmRBOWovMlgzbG03TVh5NzFJc1l3a3J6bnJzamNncGNS?=
 =?utf-8?B?aUt6a3d2VlBibnhKSW1QbERPbFZSZWdnMmNtbzBJelBtNVN3aDU0WHZSUFRM?=
 =?utf-8?Q?kNvUCJI6nkfcpE74=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFF1F8AE9465ED499D6B0D19A789B591@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IOmRcQr6hbywbzsa0XMCTYx+rkYyxDAjv4Vjf97ItXJmt0lZg7uGQ9jHKUbMoyFepamLv+FEyZnVUpHc1Xg0rYGffaR8jktvO4xxkveiXzHDNzV3Rr1lwULSaoBdPOfJXI5zaqRna8wf5/2Kj3dZ3I4ecX02F178Bk2+zYDfmLeLeRCim1T5NB1Yt/eQrNN8uVr+ds2WoD5Vyd88UslP8m7mdZOVgL4Va/cARW0x2wfMBfnxtsaWu1KbT5Wj1ZXbt8ODSrE78WujlNHbMsx2fn9dP6XaM0hwKUO3Ya1W5Wm1YykceIY4CtIllVNYtme47zOvYkOm5bxC2G0kKmU2HQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aabce8-ee5c-4f1c-14b2-08deab9b592b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:14:43.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EleSqCulv79nVSYnvbgJGD0HzCcGLPe2qxltgDbIcBdt8zMioENAiQf8PjMXU21aY9wC3YSDr7DY4WLB898EGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB6845
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3NyBTYWx0ZWRfX6bIZYxZR3XGo
 4XagFl7XevPCgNOA8XZLEwHsfOmcEY8el5sPvSb/nx4koYRDGXYnvOUWsvmHZLZYbjckAm/R0n7
 zS73Zstsk+pzeRrJMtDZIl7T2yD7/jGsbqTMspBaQhSulAznJ2VRG9y80Pmdq6LsrFi50V1p0Ne
 7e+X7//o7VlpCNqWLUZrS2sO2Dq6geYyu0eGwtSirhdgGTNw5hxt/qKn7qBEAN7w/68wEU/Fdeq
 eZNoDK+/cU/sv7aZP3TPcUqKfanv1re1bVBMst6iSCZeKM8Sa7bqL7th+LXoy63kWPF4BhOkU2P
 6vHWcv9wPe63UaommT6YhmR/oXbRMM4tQpiin79SinbPBdPid7jTFGDIizSol839/q1yE7d6BDz
 crcsX2J7FQKcEwoz3AC9vD+0C+rW4GzEBdt8Zw3sNHczU0PFZwcLAtf8I7oQV94yfsLTvjc+j1u
 6sX+Yo7UBhWv0P1j6PQ==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb8516 cx=c_pps
 a=zYvZvYGA3P9ImFnKnvSfFQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=lHH1npIHQMxudio1m5cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iSefV6GptikXqyU9TZxzeYl8Y33HVL8q
X-Proofpoint-ORIG-GUID: 6iGNv8oNt749NMTpYaRhj-7BiWVWC2VN
Subject: RE: [PATCH] libceph: Fix potential out-of-bounds access in
 osdmap_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060177

T24gV2VkLCAyMDI2LTA1LTA2IGF0IDE1OjA0ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gMDUuMDUuMjYgODo1NSBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgMjAyNi0wNS0wNSBhdCAxMTowOCArMDIwMCwgUmFwaGFlbCBaaW1tZXIgd3JvdGU6DQo+
ID4gPiBXaGVuIGRlY29kaW5nIG9zZF9zdGF0ZSBhbmQgb3NkX3dlaWdodCBmcm9tIGFuIGluY29t
aW5nIG9zZG1hcCBpbg0KPiA+ID4gb3NkbWFwX2RlY29kZSgpLCBib3RoIGFyZSBkZWNvZGVkIGZv
ciBlYWNoIG9zZCwgaS5lLiwgbWFwLT5tYXhfb3NkDQo+ID4gPiB0aW1lcy4gVGhlIGNlcGhfZGVj
b2RlX25lZWQoKSBjaGVjayBvbmx5IGFjY291bnRzIGZvcg0KPiA+ID4gc2l6ZW9mKCptYXAtPm9z
ZF93ZWlnaHQpIG9uY2UuIFRoaXMgY2FuIHBvdGVudGlhbGx5IHJlc3VsdCBpbiBhbg0KPiA+ID4g
b3V0LW9mLWJvdW5kcyBtZW1vcnkgYWNjZXNzIGlmIHRoZSBpbmNvbWluZyBtZXNzYWdlIGlzIGNv
cnJ1cHRlZCBzdWNoDQo+ID4gPiB0aGF0IHRoZSBtYXhfb3NkIHZhbHVlIGV4Y2VlZHMgdGhlIGFj
dHVhbCBjb250ZW50IG9mIHRoZSBvc2RtYXAgbWVzc2FnZS4NCj4gPiA+IA0KPiA+ID4gVGhpcyBw
YXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgY2hhbmdpbmcgdGhlIGNvcnJlc3BvbmRpbmcgcGFydCBp
biB0aGUNCj4gPiA+IGNlcGhfZGVjb2RlX25lZWQoKSBjaGVjayB0byBhY2NvdW50IGZvcg0KPiA+
ID4gbWFwLT5tYXhfb3NkKnNpemVvZigqbWFwLT5vc2Rfd2VpZ2h0KS4NCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhhZWwuemltbWVyQHR1LWlsbWVuYXUu
ZGU+DQo+ID4gPiAtLS0NCj4gPiA+ICBuZXQvY2VwaC9vc2RtYXAuYyB8IDIgKy0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL29zZG1hcC5jIGIvbmV0L2NlcGgvb3NkbWFwLmMNCj4g
PiA+IGluZGV4IDY2OTM0OGQ4ODNmMC4uMjA5NWU3M2NjZjZjIDEwMDY0NA0KPiA+ID4gLS0tIGEv
bmV0L2NlcGgvb3NkbWFwLmMNCj4gPiA+ICsrKyBiL25ldC9jZXBoL29zZG1hcC5jDQo+ID4gPiBA
QCAtMTcwNSw3ICsxNzA1LDcgQEAgc3RhdGljIGludCBvc2RtYXBfZGVjb2RlKHZvaWQgKipwLCB2
b2lkICplbmQsIGJvb2wgbXNncjIsDQo+ID4gPiAgCWNlcGhfZGVjb2RlX25lZWQocCwgZW5kLCAz
KnNpemVvZih1MzIpICsNCj4gPiA+ICAJCQkgbWFwLT5tYXhfb3NkKihzdHJ1Y3RfdiA+PSA1ID8g
c2l6ZW9mKHUzMikgOg0KPiA+ID4gIAkJCQkJCSAgICAgICBzaXplb2YodTgpKSArDQo+ID4gPiAt
CQkJCSAgICAgICBzaXplb2YoKm1hcC0+b3NkX3dlaWdodCksIGVfaW52YWwpOw0KPiA+ID4gKwkJ
CSBtYXAtPm1heF9vc2Qqc2l6ZW9mKCptYXAtPm9zZF93ZWlnaHQpLCBlX2ludmFsKTsNCj4gPiAN
Cj4gPiBJdCdzIHRvbyBjb21wbGljYXRlZCBjb21wdXRhdGlvbiBmb3Igb25lIHN0cmluZywgZnJv
bSBteSBwb2ludCBvZiB2aWV3LiBJIHRoaW5rDQo+ID4gd2UgbmVlZCB0byBpbnRyb2R1Y2UgYSBz
dGF0aWMgaW5saW5lIGZ1bmN0aW9uIHdoaWNoIHdpbGwgaW5jbHVkZSB0aGlzDQo+ID4gY29tcHV0
YXRpb24uIEFsc28sIDMqc2l6ZW9mKHUzMikgbG9va3MgdmVyeSBiYWQgZm9yIG15IHRhc3RlLiBX
ZSBuZWVkIHRvIGhhdmUNCj4gPiBzb21lIG5hbWVkIGNvbnN0YW50IGhlcmUuDQo+ID4gDQo+ID4g
VGhhbmtzLA0KPiA+IFNsYXZhLg0KPiA+IA0KPiANCj4gSGkgU2xhdmEsDQo+IGZvciB3aGF0IGV4
YWN0bHkgZG8geW91IHdhbnQgdG8gaW50cm9kdWNlIGEgc3RhdGljIGlubGluZSBmdW5jdGlvbj8g
SnVzdA0KPiBmb3IgdGhpcyBjb21wdXRhdGlvbj8NCg0KWWVzLiBXaHkgbm90PyBUaGlzIGlzIGNv
bXB1dGF0aW9uIHRoYXQgaGFzIHNvbWUgbWVhbmluZy4gQW5kIGl0IGNhbiBiZQ0KcmVwcmVzZW50
ZWQgYnkgZnVuY3Rpb24gd2l0aCBuYW1lIHRoYXQgY291bGQgbWFrZSB0aGUgY29kZSBtb3JlIGNs
ZWFuIGFuZA0KdW5kZXJzdGFuZGFibGUsIGZyb20gbXkgcG9pbnQgb2Ygdmlldy4NCg0KPiBUaGUg
Y29tcHV0YXRpb24gaW5zaWRlIHRoZSBjYWxsIHRvIGNlcGhfZGVjb2RlX25lZWQoKSBpcyBkb25l
IGF0IG1hbnkNCj4gcGxhY2VzLiBUaGUgMypzaXplb2YodTMyKSBpcyBhIGNvbW1vbiBwYXR0ZXJu
IGluIHRoZSBjb2RlLCBhbHRob3VnaCBpdCdzDQo+IG5vdCB1c2VkIGNvbnNpc3RlbnRseS4gU29t
ZXRpbWVzIHBsYWluIG51bWJlcnMgYXJlIHVzZWQuIEkgZG9uJ3QgZm9sbG93DQo+IGhvdyB5b3Ug
d2FudCB0byBpbnRyb2R1Y2UgYSBuYW1lZCBjb25zdGFudC4gSXQgbWVhbnMgd2UgbmVlZCBlbm91
Z2gNCj4gYnVmZmVyIHNwYWNlIGZvciB0aHJlZSAzMi1iaXQgdmFsdWVzLiBJbiBteSBvcGluaW9u
LCBjcmVhdGluZyBhIGNvbnN0YW50DQo+IGZvciAic2l6ZSBvZiB0aHJlZSAzMi1iaXQgdmFsdWVz
IiB3b3VsZG4ndCBtYWtlIGl0IG1vcmUgcmVhZGFibGUuDQoNCldoYXQgdGhpcyAzIG1lYW5zPyBX
aHkgZG8gd2UgdXNlIGV4YWN0bHkgMyBoZXJlPyBXaG8gY2FuIHVuZGVyc3RhbmQgaXQ/IEZyb20g
bXkNCnBvaW50IG9mIHZpZXcsIGl0IGlzIHJlYWxseSBiYWQgcHJhY3RpY2Ugb2YgaGFyZGNvZGlu
ZyBzb21lIGNvbnN0YW50IGluIHRoZQ0KY29kZS4gVGhpcyBjb25zdGFudCBoYXMgc29tZSBtZWFu
aW5nIGFuZCB0aGlzIGlzIHdoeSBJIHNlZSB0aGUgcG9pbnQgdG8gZXhwcmVzcw0KdGhpcyBtZWFu
aW5nIGluIHRoZSBuYW1lZCBjb25zdGFudC4gRXZlbiBpZiB0aGlzIHBhdHRlcm4gaXMgdXNlZCBt
dWx0aXBsZSB0aW1lcywNCnRoZW4gaXQgZG9lc24ndCBtZWFuIHRoYXQgaXQncyBnb29kIHByYWN0
aWNlLiBCdXQsIG9mIGNvdXJzZSwgeW91IGNhbiBiZSBub3QNCmFncmVlIHdpdGggbWUuIDopIA0K
DQoNClRoYW5rcywNClNsYXZhLg0K
