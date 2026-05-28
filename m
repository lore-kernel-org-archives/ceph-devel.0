Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0632B130
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005741; cv=fail; b=NnStMX0khWo7LujLmISP2qjVMzLlw6F6syQfg4YufK1LYj8DGDgBtn9ExfnkLBHdVhuZ3abmM3lyQFn2HLIZVOianKOG+hxj/3BJKSjDgQ4aNiDe4rFNWo9lQMyW2lj/uPag/SlnOcj79ogGj90B3fH/0uo0IV9rdy/lEPYk5sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005741; c=relaxed/simple;
	bh=F9sMv0TFhTiSvofJxXTYel/RPU7NeIMicWReLK59+To=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VihOiScuCIflI3GLJ00yPsN+ojLawdgxz2iRBRL5C3A8Nq9t+8/6pVFEi9OsJ+UoKPZnWvlptDhpXMjVRtknSUGSZUG4Frl47626DDj4ZF7gCRZr8Zbb6wkT6jCXDfqj+VfMZq96c88d9ewJToEoWCQ5QduCSdgw4TpClct9+b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qu88qQy4; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qu88qQy4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLluhu1468200;
	Thu, 28 May 2026 22:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=F9sMv0TFhTiSvofJxXTYel/RPU7NeIMicWReLK59+To=; b=qu88qQy4
	2o3W3ELsMj7giKhKG4QZq2r8nB55D+maGgt5oFHPcZ40jVYr3PR8NYwIGlHCEFDq
	hOBC5F084nCuOBljGFs0OEbGTbfVp58Gx3p6SqhZajV5btaZOekJDICf9e29TcQL
	vlt8RHWjycxCSrhSwJmrBugN1aWYzxJgCZDc/Rdw0w6/ScTMi0zVvYF9PnSNtpID
	2coSzuKb3N+tyeeWsr5aSg0HBWrwumvae1QxkIlOqnZQ1weAOLzxHVhk8J4BOOH3
	cI6V/RAEkp5KrQTlXETLT8DSPNKnVx4ZQyK+BrISmdKDB/fLtJbiKTHHGnnJuo3S
	OMuVkxoPvneckw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886deyq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 22:02:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9xiBPCrP+SqBUTjOYOGpXZPC2LvF1AI+MrsvQ/Uei9+RIvYs86fjWQ1B2LkawTPY8cBuHlVxFwJLekT6kl8wXrau0mnL3+EFowEjSkJ5Ha8gdDhBENfswndg2RM7rlQuN1Mc3UYfF2mdaFSr65OtpB4tf8y7rggw+HaWo72QAAgs2O8rVpSd77cDXxkHnApHPPgwmhyiNgF8ZHwCFTX20kvnZXrBFuJhyu81FsKIIhUjNLrrVkGKOo6WK7mfGGgAUGmiRUKQpI+a7Y5aiEzeJ4HjlNaTL9ddhJrMisEhnWywiouxQK6oJcVvHxc4Hxm0zReAt40QW+iMxc5KgJZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9sMv0TFhTiSvofJxXTYel/RPU7NeIMicWReLK59+To=;
 b=GZ+cRjgGfsSAI6uMWgWkG4OpghXmw2V5Sr5oCv3RbgEkCOJ8qQJuLKU3chEUyIgGff2bNh9Zsmi06cDQ/o7bVSDeahaMCN4J75dH7lqPGYrXSbfdOCVvBkRoYUjWXPhGQyc/yzD43hCI8m0eCNfjvyz7t3473a+budTIUMxwm1jCiKXVv6olTMe/F+ZEdt9jLhZ71EBrAHwXThkx7fD/wUFii84HE3c/OHz5OS3afGfJoToxOP9gkCszgy71tIRaSnKHiP101AWgSM33u+/GxUq0pvfQbRk79RKpSWdsYCr7qF5W3MBW3Sz/Bws3zf5RixOJcFE/+eNAnVrNIMIC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB4985.namprd15.prod.outlook.com (2603:10b6:303:e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 22:01:57 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:01:57 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hexlabsecurity@proton.me" <hexlabsecurity@proton.me>
CC: "security@kernel.org" <security@kernel.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        Xiubo Li <xiubli@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [REPORT] fs/ceph: malicious-MDS kernel OOB read
 via unbounded snap_trace_len in CEPH_CAP_OP_IMPORT (since v2.6.34)
Thread-Index: AQHc7mmRCYgHgLo8O0+p6652EIJDSbYj/l6A
Date: Thu, 28 May 2026 22:01:57 +0000
Message-ID: <449e934b182ba6d8f6f4912f71bd1263630396d6.camel@ibm.com>
References:
 <cEUA87QPkzfvf28KWaj4f8hEVYBkHl6Gc9sqTYM2Ld-H76SJIpst6wVPSu55qpViAeMPeUWyLrYyDQTzG8Mj969WqjThU58gj56D1GF8X8g=@proton.me>
	 <2026052843-unread-quicksand-1da9@gregkh>
	 <ved5l12DIYeOrtpiOyxLZX4Q6ns8pHePwLZ9NSRbYVkoN2MgZWVMYx_5pR-MwzWqQlZ6AeWTI0PWWqprXZx0nCkjSTGR8Mv2GEsKBjIzf0o=@proton.me>
In-Reply-To:
 <ved5l12DIYeOrtpiOyxLZX4Q6ns8pHePwLZ9NSRbYVkoN2MgZWVMYx_5pR-MwzWqQlZ6AeWTI0PWWqprXZx0nCkjSTGR8Mv2GEsKBjIzf0o=@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB4985:EE_
x-ms-office365-filtering-correlation-id: 1e2072f1-7ba3-468d-15cc-08debd04bc6c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021|22082099003|18002099003|5023799004|3023799007|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 MlEbKhE64cmiwYMtTaBiJgnEc3n+haGiTl9YbpJLmeH38XwKWdayYcCnmPikghZz7KEvMRi3Pd78aUoP7pLLj7ypQbpG7VQUmzwOCvagmHsrWZeb2xanU+crPA+17DiLeo2FoRU/8hizinY1vB7kXP4WnKwWdzJ/JFM5ALdk2MpY1wBvG8K4woMo6OZz2UvYAyXDvPYNP6l5eMlRR00RjDqm8H3eDMRV76FGoIUVM2KJNqZpQxIVC74EwYwA8/Ykvjjz5sXAYm/sELT5h6VONpcqwKdFdvE/i12I4DNIcd3yL0T5T+lwsmPoQ9bcHkXFWIuOcBzSTfDzkR52MaF1cdBAtQCnNy6eCs4x5SxMwBlyxb5EXgDUtO/4oc1J2LHZiD/R54IlTkfMKt7rPhrqOQJ8isUKWHLPP4b5L11CDqkWYQwXLiTWnnhZXM5TQsEInS/RfOnE4+G/jE02kTqcvmM06kBqa1vsO84UNbU0KnxX0gMwP+o3C9iuaJENYC8dHxROh/y3ytWT3anEq81MGPmfMLgPS3FXY8F80ePNO0x3szPISYprWDbRJ2d7EFkshdZTQuz/wfS4Sh8kvEwuYByYBci+TU+7pvrZu1Vz2EWN8xck+ZoWZ/KEMU4hxNQc70wTKaAjXW3EdZKKucagySKQ8unC3TD6VSrXgeHDc6BWRO2NW1lF4VCClzApLR0i1d+EftTw20ffMkXFzVsaMDJP00vMVjyaHPm8M1AqLKPXYLVPJvT1JklvUmur1Vch
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021)(22082099003)(18002099003)(5023799004)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3Q0RlZVOUJqdGw3L1lXcnJFQXZxOUhibkVwbkJRN21nMWNUaG5zMlpDUE91?=
 =?utf-8?B?Vkc1b1NFL21yRm1nditJZkFSV0tUVlh1NGY1ajJLaW93ZG5ZMk9ON1BHc3dN?=
 =?utf-8?B?UFVPU0JnNHhFUmtpSXJjVnJhY21TSHdKYTgxbmhKQlNTREhNdmV2L1BOcTdw?=
 =?utf-8?B?RlYwd0ZURFRSbndBM2xDUWpYVHhVSWlNSGVLditCZkRKQTNZc0Y4SkRPS0dW?=
 =?utf-8?B?OXJCbksxOFVqTlVwNTlsajZUTDhrdE5tczVOczBRb2FGcGpwc21aY0tlaVJJ?=
 =?utf-8?B?WXIrZ21NaWhLRG9tSGErVld2ZXNzdWtNWEhKTU1HNlZHK2VQdnRPUHZpZTYv?=
 =?utf-8?B?KzJsZldoTTk5czBrcVV2ZjM0VXVRZ05kd0JEMWFqWWEwbjJoUHhpYkE2VXFL?=
 =?utf-8?B?VUpLLzJGMVFvV2w0YXlFcUhZU05jeG1HaTlOeVpMK3pRZFplVWZqUW5Wb21Y?=
 =?utf-8?B?bkJ6STZaQlRzazdKUHovelVLM01FSjFYNWoxakRNWXZMby9Mcm1DQUs5OHpP?=
 =?utf-8?B?NkxXWE4yM09pejZYMzkwVzZpUVpNRTV0SWFTOGJDekZXa2Z4RXFubml4d1pK?=
 =?utf-8?B?dVQ4clRaUkZYQUtEbXJOdkI5UTRHcGd3Qk1RcHUrRmF1dGN4MjdZQyt5cVNp?=
 =?utf-8?B?MEIvZ1R5UUc4dzZPRkdSNEYvSDhMTy81TVI2bll3TS9wSHZXMXV6ei9ZMUQz?=
 =?utf-8?B?cldyY2hWUXJKN3hoU2hVVEUwQjN0ZW4vL21seDdVKzU2dUUvem1Cam50TWtW?=
 =?utf-8?B?QS9zdGQrQU4zbWF5NUJwbDF4ai91S0VibkQ1OGZ6NWZoL0hjU2txL1kvVngy?=
 =?utf-8?B?ekkwamRoUVpzWnFqdkM3WUVBWTdYcmw2d096M0gxVVp3NThxZWpYcExPOElz?=
 =?utf-8?B?ZjBoRWU3WmduR0JyNy95TnJtZUdWSFpueU51bnVjY0FFa3hvSUZZSFUxd2xq?=
 =?utf-8?B?cUtJdnhPUEJpdjQwak1kVHJqTitGVWpqZGRzaXZ1UExlM3R4R3o4a0Q5NDZ1?=
 =?utf-8?B?ell3QWlaSGN5MUFEZytHbFRwR1ljU3VWTUZSWnV1Sk1rWms3KzY3OHF4OWtP?=
 =?utf-8?B?TmxDOE1mOHkwRXVtS1I2blAybnZES1h5d084akFFZnlaOGYvcU5LWmN5UVNh?=
 =?utf-8?B?VkZFcDNWY2tpb0FCdFlaQ2ZNcjRkMWFOSTJDelN3NWVuNnBMQzU3WGxLeGI4?=
 =?utf-8?B?V2FEUlBqem9PZkY0Z3pDZGhnUm1MeG1WaXY1UUtsYmpUR2Y1bWhXUTI2M0hl?=
 =?utf-8?B?WFhlMEFvdHk4dHpiMFR6c2YxR2x0c2pxZFBhcjRvUmVib3lGSnFwQy9IbXV3?=
 =?utf-8?B?T2FWWTdaNk1JUEpPbk9adjdSdXdrOHE3bnd1V015RDR1RXAvbzFsZUY1YWxh?=
 =?utf-8?B?OVZCR1padkpCVE1jK2pkcnJZTkRBSzZLdnhHYUpTS21HSkNPYlVIVTZnY21T?=
 =?utf-8?B?bnJhWGh4K0kvb05TeUpUWTFvdkMzb0lBZURtMHZ0VmZORmltRE9yQlZwQXZB?=
 =?utf-8?B?bk1qenQ2dC9GSHpTekJ4d1lubmo4d0VDRlBBNmxETVlrMmF2SGdCeHNnMm5u?=
 =?utf-8?B?ZUxydzhBQzh6U2YyTUxIVE5PYUJ4T3FCTnlUZkdaKzA0TDZTcHJUMEZZU0pw?=
 =?utf-8?B?RUptTkI2cG1HUFRZeDYvcGRDWTdld3AwbGZ4VHVmWmE2dzc5MjNDd2dQNmZO?=
 =?utf-8?B?NmJPT2RtTkFqay9BaWVPTkRiVWxSOGM3cFZJY3M0WWhORHI2ODFIc3dWYlRx?=
 =?utf-8?B?enNEM3FjU2VNcVV3QmY5blZVbTZrR0hMNGxNdnZ0TE00TjFLMC96UnJQckpu?=
 =?utf-8?B?VXVaVXBPK3huOTNXNTlDYlhHNGQwRFZvMVhPdVR0R2tucW9mTk85NTBkNC94?=
 =?utf-8?B?RmlZVlVLUWJ1VDNsOTZhTDJEa2s2cytVNTN3RmhoZEtGR0ExSlJUR1k2Qjdn?=
 =?utf-8?B?QkZDWTR6NXg3eEQ1ZEVybnRBNHBvbXBjQXBDaWRodGdKdUFlWFdtcU42NDBZ?=
 =?utf-8?B?My8yRDFLSEFmNHBPNDBsc0FvSWJnQUtoV1BjYzUxbUpmNW03YVJmeVdyWThj?=
 =?utf-8?B?T1Qra2ppY3l4aE5vN1UyZXkxTFhqeDMwVmZkdGtWbDR2WU9YUVRwdmFxenpa?=
 =?utf-8?B?YWc5K2w0a0dubUZjNTkvUVFTY1VHa3JmTmhITHpsbFZ6dDZUblkvUVUyZmRT?=
 =?utf-8?B?SEhYdU1Zb21NZHlhKytKM2FKbTI0b2J4ZmllamVmSXlENkNWQU84bi94V1NV?=
 =?utf-8?B?WGk3MXhzQ0ZZNVBhWmFabzJ2Nm9RTUJVT1BzSWxkbjVSR2hEdHZoeGI0cmZq?=
 =?utf-8?B?T0FwOHBPeVA5ZWNOS2lYTW0xWlZHbDI1cnFnZHg3QWF6M0pYYUh4VUhSVnRG?=
 =?utf-8?Q?vhyzTs2b9NQP0wocki9521Ti9P2y+75vCiQHE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <073BC8A0C3813C49BC98192B588BE349@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pARQX+XkJ2tm/Td0DC3XrGvhWpHS29s9WsShqpLLXVPlcrsLq7oVSbNuMf0ueZ4z1uBwUDIjqPzkSJ2VlIAX8Q4xkwat/6Dhi9geVCOWe/lKlRogXzvrL5R+q4ClQAhAGSex3Wl2xlrUmuvcT5mG/wH8/cdwDuDYQVlLSv85DTSfZRVwTUc0WdWrbZh6YYVh9wK6Xi1ClRAjWEGrYqDYcnqUz9AhOw5CmkKH6EZ5GQ1REXrnb9CBK/50DDqCO+XbCZFz/SV9UQ3LxJg6o3b8vC/a/7oJzz4GZjf6dPRA6MeHlUBm1YLyVZxbVzW/E4YnLI+ZwoCPwMxKyaVWp0GLRw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2072f1-7ba3-468d-15cc-08debd04bc6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 22:01:57.1017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g+PGmCogRSS9kf9uqMuSLhNZx0XZRBMumbNkQxCqZh7NUeXtz7CV8kLN8OEmaRPucdh7aGbQ+iSeokRx03wlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4985
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 3XoDqtiOYYwJXJMz6VAYMqylOO9IonbV
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a18bb5c cx=c_pps
 a=Wsr1RZNaL8V8irrcAsW+4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=16pE8xRjAsNLPaksrDkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIxOCBTYWx0ZWRfX3Zy8pqgxBb3M
 k/7nFvuQEXzUl6jOL2MQWnJqHjaHPofwaS5VW7eUP3uJNLAC3+/C2xL3veyFutYGZRwnBKhjIRE
 7EONBooVo29+x89qEe3r7cyj49Iqu577SWLZbmUEVLF17zwO7+MIlbnENR+FeIkXQASEchAYbhn
 Ioe80uTqpsTj56MzsjAFiAwb2XD77UAdFe05e+H7fdwZCDtinJX61aAm7aAjW76K/AdJgE1X0Eq
 ktXuTPLWIkhQm+1X4+fgylxaJepKiHyHEFpXQc8Bj2rBKPFdlmtVcAbrB4L5zPHWZ/BVSleXvFh
 iJgmZMyUO/XaN3nKZ85DLF/88LbO8CjAxktGLThH5Lt9x43K8upVSnq/bBzD0dDQfEE13VXle9d
 07hPzDR4l4evaTs4rxF51OZNvt8ySsCNEkBwhvfA50iDXrseo6yZ3xuzxEHk9UgG1CNfOgxy2yg
 bw7Zli0lGYjzKwznZXg==
X-Proofpoint-ORIG-GUID: zDvQU56l4fn2OASah1rfn-Rtj7N5JDoX
Subject: RE: [REPORT] fs/ceph: malicious-MDS kernel OOB read via unbounded
 snap_trace_len in CEPH_CAP_OP_IMPORT (since v2.6.34)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280218

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDA2OjEzICswMDAwLCBoZXhsYWJzZWN1cml0eUBwcm90b24u
bWUgd3JvdGU6DQo+IEhpIEdyZWcsDQo+IA0KPiBBcG9sb2dpZXMg4oCUIEknbSBhIGh1bWFuIHJl
c2VhcmNoZXIsIG5vdCBhbiBBSSB0b29sLiANCj4gVGhlIHBhdGNoIHdhcyBhY2NpZGVudGFsbHkg
b21pdHRlZCBmcm9tIHRoZSBvcmlnaW5hbCANCj4gcmVwb3J0LiBTZW5kaW5nIGl0IG5vdyB3aXRo
IHByb3BlciBDQ3MuDQo+IA0KPiBUaGFua3MsDQo+IEJyeWFtIFZhcmdhcw0KPiBJbmRlcGVuZGVu
dCBzZWN1cml0eSByZXNlYXJjaGVyLg0KPiBIRVhMQUIgU0FTIChyZWdpc3RyYXRpb24gcGVuZGlu
Zykg4oCUIENhbGksIENvbG9tYmlhLg0KPiANCj4gRnJvbSAxY2UwNzY5YmE0YmE2OTFiODc5ZmNk
MzU5MDBmNmMxOTlmYjdkYThjIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KPiBGcm9tOiBCcnlh
bSBWYXJnYXMgPGhleGxhYnNlY3VyaXR5QHByb3Rvbi5tZT4NCj4gRGF0ZTogV2VkLCAyNyBNYXkg
MjAyNiAyMjozMjo1OSAtMDUwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIGNlcGg6IGZpeCBwcmUtYXV0
aCBvdXQtb2YtYm91bmRzIHJlYWQgaW4gY2VwaF9oYW5kbGVfY2Fwcw0KPiAgc25hcC10cmFjZQ0K
PiANCj4gY2VwaF9oYW5kbGVfY2FwcygpIHJlYWRzIHNuYXBfdHJhY2VfbGVuIGZyb20gdGhlIHdp
cmUtZm9ybWF0DQo+IGNlcGhfbWRzX2NhcHMgaGVhZGVyIGFuZCB1c2VzIGl0IHVuY29uZGl0aW9u
YWxseSB0byBidWlsZCBhIGZha2UNCj4gZW5kIHBvaW50ZXIgKHNuYXB0cmFjZSArIHNuYXB0cmFj
ZV9sZW4pIHRoYXQgaXMgbGF0ZXIgaGFuZGVkIHRvDQo+IGNlcGhfdXBkYXRlX3NuYXBfdHJhY2Uo
KSBpbiB0aGUgQ0VQSF9DQVBfT1BfSU1QT1JUIGNhc2U6DQo+IA0KPiAgICAgc25hcHRyYWNlICAg
ICA9IGggKyAxOw0KPiAgICAgc25hcHRyYWNlX2xlbiA9IGxlMzJfdG9fY3B1KGgtPnNuYXBfdHJh
Y2VfbGVuKTsgICAvKiAzMi1iaXQgaG9zdCAqLw0KPiAgICAgcCAgICAgICAgICAgICA9IHNuYXB0
cmFjZSArIHNuYXB0cmFjZV9sZW47DQo+ICAgICAuLi4NCj4gICAgIGNhc2UgQ0VQSF9DQVBfT1Bf
SU1QT1JUOg0KPiAgICAgICAgIGlmIChzbmFwdHJhY2VfbGVuKSB7DQo+ICAgICAgICAgICAgIC4u
Lg0KPiAgICAgICAgICAgICBpZiAoY2VwaF91cGRhdGVfc25hcF90cmFjZShtZHNjLCBzbmFwdHJh
Y2UsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNuYXB0cmFjZSAr
IHNuYXB0cmFjZV9sZW4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGZhbHNlLCAmcmVhbG0pKSB7IC4uLiB9DQo+IA0KPiBjZXBoX3VwZGF0ZV9zbmFwX3RyYWNlKCkg
dGhlbiBkZWNvZGVzIGEgc3RydWN0IGNlcGhfbWRzX3NuYXBfcmVhbG0NCj4gZnJvbSBzbmFwdHJh
Y2UgdXNpbmcgY2VwaF9kZWNvZGVfbmVlZCgmcCwgZSwgc2l6ZW9mKCpyaSksIGJhZCkNCj4gd2l0
aCB0aGUgYXR0YWNrZXItc3VwcGxpZWQgZmFrZSBlbmQgZSA9PSBzbmFwdHJhY2UgKyBzbmFwdHJh
Y2VfbGVuLg0KPiBXaXRoIHNuYXB0cmFjZV9sZW4gPT0gMHhGRkZGRkZGRiB0aGUgYm91bmQgY2hl
Y2sgaXMgdHJpdmlhbGx5DQo+IHNhdGlzZmllZCwgcmkgPSBwIHJlYWRzIHNpemVvZihzdHJ1Y3Qg
Y2VwaF9tZHNfc25hcF9yZWFsbSkgcGFzdA0KPiB0aGUgbGVnaXRpbWF0ZSBtc2ctPmZyb250IGJ1
ZmZlciwgYW5kIHJpLT5udW1fc25hcHMgLw0KPiByaS0+bnVtX3ByaW9yX3BhcmVudF9zbmFwcyB0
aGVuIGRyaXZlIGZ1cnRoZXIgb3V0LW9mLWJvdW5kcw0KPiByZWFkcyBvZiB0aGUgZW5jb2RlZCBz
bmFwIGFycmF5cy4NCj4gDQo+IFRoZSBlbGV2ZW4gbXNnX3ZlcnNpb24gPj0gMiAuLiBtc2dfdmVy
c2lvbiA+PSAxMiBkZWNvZGVyIGJsb2Nrcw0KPiBhYm92ZSB0aGUgb3Agc3dpdGNoIGVhY2ggY2F0
Y2ggdGhpcyBPT0IgdGhyb3VnaCB0aGVpcg0KPiBjZXBoX2RlY29kZV8qX3NhZmUoKSAvIGNlcGhf
ZGVjb2RlX25lZWQoKSBoZWxwZXJzLCBidXQgdGhleSBzaXQNCj4gYmVoaW5kIGEgaGRyLnZlcnNp
b24tZ2F0ZWQgaWYsIHNvIGEgbWFsaWNpb3VzIG9yIGNvbXByb21pc2VkDQo+IE1EUyB0aGF0IHNl
dHMgbXNnLT5oZHIudmVyc2lvbiA9IDEgcmVhY2hlcyB0aGUgSU1QT1JUIHBhdGggd2l0aA0KPiBu
byB2ZXJzaW9uLWdhdGVkIGRlY29kZXIgaGF2aW5nIHZhbGlkYXRlZCBzbmFwX3RyYWNlX2xlbi4g
VGhlDQo+IHNoYXBlIGhhcyBiZWVuIHByZXNlbnQgc2luY2UgY2VwaF9oYW5kbGVfY2FwcygpIHdh
cyBpbnRyb2R1Y2VkLg0KPiANCj4gVmFsaWRhdGUgc25hcF90cmFjZV9sZW4gYWdhaW5zdCB0aGUg
bWVzc2FnZSBmcm9udCBidWZmZXIgYmVmb3JlDQo+IGNvbnN1bWluZyBpdC4gIFRoaXMgaXMgdGhl
IHNhbWUgc2hhcGUgYXMgdGhlIGV4aXN0aW5nIHBlci1kZWNvZGVyDQo+IGNoZWNrcyBiZWxvdyAo
aWYgKHAgKyBmbG9ja19sZW4gPiBlbmQpIGdvdG8gYmFkOyBldGMuKSBhbmQgdGhlDQo+IGV4aXN0
aW5nIGdvdG8gYmFkIGNsZWFudXAgYWxyZWFkeSBjb3ZlcnMgdGhpcyBleGl0IHBhdGguDQo+IA0K
PiBSZXBvcnRlZC1ieTogQnJ5YW0gVmFyZ2FzIDxoZXhsYWJzZWN1cml0eUBwcm90b24ubWU+DQo+
IEZpeGVzOiBhODU5OWJkODIxZDAgKCJjZXBoOiBjYXBhYmlsaXR5IG1hbmFnZW1lbnQiKQ0KPiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBCcnlhbSBWYXJnYXMg
PGhleGxhYnNlY3VyaXR5QHByb3Rvbi5tZT4NCj4gLS0tDQo+ICBmcy9jZXBoL2NhcHMuYyB8IDIg
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9jZXBoL2NhcHMuYyBiL2ZzL2NlcGgvY2Fwcy5jDQo+IGluZGV4IGQ1MTQ1NGU5OTVhOC4u
ZDUwYTYwYWY1MDc5IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2NhcHMuYw0KPiArKysgYi9mcy9j
ZXBoL2NhcHMuYw0KPiBAQCAtNDM2NSw2ICs0MzY1LDggQEAgdm9pZCBjZXBoX2hhbmRsZV9jYXBz
KHN0cnVjdCBjZXBoX21kc19zZXNzaW9uICpzZXNzaW9uLA0KPiAgDQo+ICAJc25hcHRyYWNlID0g
aCArIDE7DQo+ICAJc25hcHRyYWNlX2xlbiA9IGxlMzJfdG9fY3B1KGgtPnNuYXBfdHJhY2VfbGVu
KTsNCj4gKwlpZiAoc25hcHRyYWNlX2xlbiA+IGVuZCAtIHNuYXB0cmFjZSkNCg0KQXMgZmFyIGFz
IEkgY2FuIHNlZSwgdXN1YWxseSwgQ2VwaCBjb2RlIHVzZXMgcmV2ZXJzZSBwYXR0ZXJuOg0KDQog
IGlmIChzbmFwdHJhY2UgKyBzbmFwdHJhY2VfbGVuID4gZW5kKQ0KICAgICAgZ290byBiYWQ7DQoN
CkJ1dCBpdCBpcyBjb21wbGV0ZWx5IG5vdCBjcml0aWNhbCByZW1hcmsuDQoNCj4gKwkJZ290byBi
YWQ7DQo+ICAJcCA9IHNuYXB0cmFjZSArIHNuYXB0cmFjZV9sZW47DQo+ICANCj4gIAlpZiAobXNn
X3ZlcnNpb24gPj0gMikgew0KDQpMb29rcyBnb29kIGFuZCBtYWtlcyBzZW5zZS4NCg0KUmV2aWV3
ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpUaGFu
a3MsDQpTbGF2YS4NCg==
