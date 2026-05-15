Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC438D014
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872965; cv=fail; b=lABJTebJ3Jbea2TlTy8IYPNFWd/zYUkbtUzI1hm9efi18/9J3H8FjjTL9urs+jRGo3tO0yn7dgCkg4sw8aL7gLiGtffBUFN1vN/QmabqX5f3j7GqobnYpZ3S/LNAKLbTHYDNnmbBDttizuAN1AZKrzN+P3oqCTzn50rtWGDN8Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872965; c=relaxed/simple;
	bh=HePGa3B1PhTb5lz9zyAQP+eSwm8SKqRlMxR+0NcRvO0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qHw8MsuORnaqoq5XakpFoz99ml8LYXQ6k4KKy3WzZS0+wiTzkEbaIEglBjSpPww3VpTbtvP3NT1GsOjwuVmfhS7vIipxsxeiZ1+rfI0JjZdKIZsm6NDgPeHRI0+KOLMAIT9HJwlCUIY4/KwPTss5WvBxNQ9YALqzGnvnRKHTYb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DskxprSU; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DskxprSU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FATrMg574732;
	Fri, 15 May 2026 19:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=HePGa3B1PhTb5lz9zyAQP+eSwm8SKqRlMxR+0NcRvO0=; b=DskxprSU
	BUy+LEi38dqkHskgUVyd4woSb9JbQUqkOIT8E2/tB1BUUv13ypJFiEkBUV25DxKz
	MeP5QkLCfMNg4sRflzbOOUzG3k5N4b9Ad1jJG6DZdu3rnTPyyvjHsWBl9OrLgTBf
	4lV8Yle6kqdPtqNiqN8kH5jSAm+zeiCiw1sTajWbYE0mrnZ6wlpiQpODDFu6A20w
	wcz9N0xDzIAncRQm6NZWADivo+BNuHQAQxB1oYQnzKnB6IcjiCscacdbZHAC9dhq
	c3yZxHjWAgptBtwRPHiIp01Rsj7j71au8CGMHi/+QGX0Wi9OTcx6i3NjWSgN+H03
	DHG8nqfpnlqTcw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m92mq38-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 19:22:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdhBKGWJ9voUmcfxCmx6BYCfLrEbXa/y81Y0gGFw8Erd0W4Rt+uV1wKogNc5+uMjdUMWesK+rwuWisDZHsqVKtIkmqvU59d5hWBfkVgncrP/1P180IWcKB/IM4n3utYEapPbS3GyaQ+vCs8Q2Rw9oUxQ2mHM32QfqcIjrz6mWH69kfUsXpWEIzdSOViIY4dZ4eTD7vXRgRHED3TjBHdvkvVK/MJ5nVSWE2W+osNpvxjoi7YMCNdiNgQgOIo7f7f5UG090GOvxTXxQEyNL8H43JlxTezRugWuFTuzjWPJNTawp122sVOWgIQ+6KRyUp5hizdfzNcXHwiC0c0y4kHssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HePGa3B1PhTb5lz9zyAQP+eSwm8SKqRlMxR+0NcRvO0=;
 b=QxDenuhR8JxJ7JiO+1akdG8oCQ6ojwreVPo7ITSa0sSHHORjLz7PAz9zpTLk/Sm8SHqxMglIHb4w6rV5S3xOR6YqPhNyUnaU52nd21+UrGwsXPEo8cwaCyU2Thfm80cJGXGMwzTGQkoCJoVg/YKKlAnbzVeEfvbFDoJZ9TiXrsje4fwopGR3Jsh8z1j94C27z9goOlP6U1MDEFExfxW/dzIwzzhNhqibdveYX32MBkiro+M9Z9VxcbDw2YcWNUAfRdZ/KK8hWh8CRcFy6rwu5uD0x5lYEoA46h3l7mu5sBwyQKritPevGRG3Bcmrvku1yfLL953i+UZHRyyTnDimvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MN6PR15MB6242.namprd15.prod.outlook.com (2603:10b6:208:47c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 19:22:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 19:22:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "security@kernel.org" <security@kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Fix out-of-bounds writes with
 oversized monitor reply messages
Thread-Index: AQHc5JMYC/EGeobHTEq5kBCalkBJ6rYPdyyA
Date: Fri, 15 May 2026 19:22:26 +0000
Message-ID: <acc9afe112e83e42a5c1d3a1560bed2cd3554900.camel@ibm.com>
References: <3f154565-9f37-40aa-b34a-be6f5c2b4463@tu-ilmenau.de>
		 <20260515133129.1595265-1-raphael.zimmer@tu-ilmenau.de>
	 <f919b66a7cc03dfd22231b87353ebeaf864e3d0a.camel@dubeyko.com>
In-Reply-To: <f919b66a7cc03dfd22231b87353ebeaf864e3d0a.camel@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MN6PR15MB6242:EE_
x-ms-office365-filtering-correlation-id: c31a23b8-d6ed-4106-9706-08deb2b74c88
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021|22082099003|11063799003|18002099003|56012099003|4143699003;
x-microsoft-antispam-message-info:
 bM9D8zMXOr6/Zc4Q8c9bvnquuL7UuJl+wVAsZeEuwR2pyu/Oo3WfWFhRGWTrX3SR3zz2qhindoTFrqa0gXqRzOHnv0vAcIpVfNaM1fb/Ud7rCCWL+u84E2Y7CMatPeMwJCcR9FYNUaLzg8hkPIpA7cDh1oE67mUjINCHMzIbuEyyZM0AHrDuSx3y7O1SamA5noC06G8j/ml2BJGD+txeSmp4mFDS1b/6N7HCtUSefufVdO9UJP5osB9RMfVdLFS9C9a0gAK4dca420JgjIgOK6KyQeKmuu20vHoTd3BPLKXzg62k3jxPv6G8zC+/1k6V7HWD+hu044XWvOgaS4GDLVDeb0/vgZeB2yxIGWYHU7m2lm3z1SesuKsxgqTM2mWqZ3jcGguZIQLhspNGmrO0YU0W6wictXtZJSUrzMnZ916Y6mQHP4XOn7pjPfasYMtXf98fds3CCz9ktDtuhlMH4HCigEVx1v0RmGOMOiOLaTkRiU6/RQWVlpMCHLyZmtJZaH6hUXTAviwO6erqzOAIGTmpprRrAfgxKQM/AFiQqI4swux6MqAHF5C8Nf0YsiFT9GB41TXfWGJwxjPsPGNi4D3crY9mo4qRnHEvgTdLgLI+Bs3rlR47HM+QqtbRa9hLp3dXaEg4QH1LdPJuR7hSgzWA0VaPMglSS2WDQogAks7Fkh9XK3L1dCrMlEoWszCyT+6TgCOl0tNWPlOgA7izsCwPE8Cu2SE0lEIGkVBkFSYz2pSEqA9n6MCZ9R9N0GGF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021)(22082099003)(11063799003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFgxTms0Ym1aUWVMb0xyOFNlQlN4V1JrOVpvV2VrV282N3RkWEZjOWRudWZL?=
 =?utf-8?B?MXJjT0lpTUh0d2tMU0djZ3pnak4yQ0RtYjllUU5kYzZqVm1NRkRJL3k4UC9a?=
 =?utf-8?B?dVhNR2R6cmpCNC9NcGZUWGJQRjIzSFgxS0V5eXZmc2g5c0pBazE4U1o5RHFa?=
 =?utf-8?B?WlBxMFQrME1lK0hyQ2FudU9UK2tITUJnYWJkRkFDcDFrNEJ1bG5qb0NTUVZm?=
 =?utf-8?B?YlR4RTZ5RUFOb0Q5UnUrcUZoWG5abGRRd1YwT3ZwcXBRUkhRZ1JvUFVzaDhn?=
 =?utf-8?B?dmNuanphcXhtS0hFK3F5bnNuckNGY2lLZVFTekhyY3VGNmlWQmxLZWlIUVVL?=
 =?utf-8?B?Y2M5c1B6S0YzUk5ZTTZqWWJVbGNCbGZOSDFJUGw2WmVoZHZHZ2FXbjBGV0tm?=
 =?utf-8?B?N0ZlcXh3NWludEZjUmxIdVU1K3lLQ3dZK0lDQVBVNkx3ci9jbFBZQmNUVU1J?=
 =?utf-8?B?ckJrcmdsSEZtZVBzYkg5bEpFRzI0YUZwenhSUXZzSmZtQjRmM2t3b2NmU3FF?=
 =?utf-8?B?ZnFqcFAyd2ZNaXNrVkdmUFN2YnBPOW1uK3FveWNsaWlEK1JwWk93bmFxUGZT?=
 =?utf-8?B?WDFhVFdVQ2czYWVXZy9scnYzUHdldyszL1hkMTZKbTA5YVFZOGpDcWlnenNm?=
 =?utf-8?B?eE1uZ055OWZTbHFzdTZsaDBnbGxzZ3NLa3J1R3dJT0dHT1grNUtkMGpET1do?=
 =?utf-8?B?UGZrZ3VWNUVaUUFKTGZKRithSG13MGt0VXd1L2lhYWRzSlY2UnlQNHF5TkVa?=
 =?utf-8?B?d1RPcUU0Tmp4dGQwUmtIanFlbmhRalR6U2h2YjFjRVczemxUVllXZFBhblhw?=
 =?utf-8?B?RDJjUDlNeG5NNDVNa2ZMaFc4YjJJcTdBSmcxVTVaK0QrcHp0VDU0Zy9pTllY?=
 =?utf-8?B?WVJ0RUFzWVFwc2xsRE9oK0kxQmxuVEQ4V1VFRy9LRXYwblFkalkxNXpTRU10?=
 =?utf-8?B?NFhLMGhjbU44dDMyNzhjU1pwcUxkd3ZjdDVNR2dtcC9BUnlVbWRGS3V3ckdy?=
 =?utf-8?B?Y1owblZVVnI1T09NeUtQR2Q3NkFVSzhyaXZaTUFoZStXcU85ODk4R2xHeEFF?=
 =?utf-8?B?ZjV3N3BOcUNhTUVpYzFLbGdXMnE4VHplMmcwTFZidkZDMjdiY0tTWUZ1UmVa?=
 =?utf-8?B?NVUyWmd1MEdjVDFvMjFmWkdtVDRuN3RPZDR0WEgvS0FLL2hqRzcveFhQV2Vk?=
 =?utf-8?B?Snltd3Jjd3d4MVN3ak8rSVVlcEhhb0NwVkRXSDN3N0kwMUFWYXBrTUozZlk1?=
 =?utf-8?B?WHVXQzRxd0hWQjNaUURlZ01Ta0tuUXF1TlYxM3V6RU5BeXRuYnkzOVZnbDEz?=
 =?utf-8?B?VWVreDVTZUZsSTVFcWd2MGhraWVjdlpsQVlqRHlUdnUwVTRBaHJ3Sy9mUmpj?=
 =?utf-8?B?REhsR3ZqTzNjVlhWSCtyVFFHaDEwVXIrM0luVXR1b2dNKytndGpUa2NheXhZ?=
 =?utf-8?B?TVN4RC9uMGFyekJ2VGs3bEtTVW1kSXdZaDd5VW1qMWwyQUpITWZhSkNVa1Ix?=
 =?utf-8?B?MjZCZ1V5OGVObDRFZ0ZHVkE0T2xUbnRBeXpkQ21QVlR6ckJrQnFZTXdvcXNs?=
 =?utf-8?B?bDB0ZU5BMVQrVnJVbTg5NmFTSUpTaUM3QU12bVpmSkMyTGlXS05Cd0c3V2sz?=
 =?utf-8?B?Ti9uL1paM0lvdHVhaUdQbWZ2dmZaMGtvZHlNcmtaU1pHZFJXUEZHT0RQdGZr?=
 =?utf-8?B?czZGQVlKVVFJUVFkOEwzcWNLeDQ5bWFHSkZxWFJoWkQvTTBEMDBMRFNVU3lD?=
 =?utf-8?B?OUswN0pGY2hEVUNmU3pXTFlQa1NaVFJZdEtlSHEwSHZGTE84eUFsZ1dzMitZ?=
 =?utf-8?B?ak13VnBzNnl5REllWU9oZ21mMUhzWFk0OUFtNG0vRVVBVXlzTElMUUpzWXY4?=
 =?utf-8?B?K2R1bXdxZ1I2WWVhdHV6N0tXNmliQUpNdmZGMzlva2hubVpwYlN2OTk3RS9m?=
 =?utf-8?B?a1FMWEYxa3NYUjB1aFNOMGZRVER2TVltZWJDM3hNQ0FXQmRRYmVXS1Y3enpR?=
 =?utf-8?B?OXcwMHVTNHR6TkYzM05nVnNBZmwxVDZaOWtkeFR0SHVvZWo4RzVmRHNRT1Fi?=
 =?utf-8?B?ZW5ENXpzdld3RGs4N2ZYdUExOWxUNmJ4U2hZVG5qU1RGSzlKbHl2MU8za1py?=
 =?utf-8?B?TXVZdnFDcHg3Z2dUbGJYSjIwQktEYjBMTy9YU2UzeWgySWNxM2hsRWU0UVdR?=
 =?utf-8?B?RkJINTVZS3BDSlQ3WWxmblVBT0RJYW5iSjNDZW1ER1lURndHejFjR0VvaXNT?=
 =?utf-8?B?REZnbStPUW1GNDVNQU9NbDJ0czd3WS9lSGpybVBaZUs3bUFES3h3dGI4WVVI?=
 =?utf-8?B?WDcvZ0YyM00rRWNobldKTjIxdFJyZ2JJSEhnSGZrOHhMOHBYWUNjVzhaU1VL?=
 =?utf-8?Q?mJCCS/7CtdVhPgPwGPxnRNFc9n4na6rrXPpOx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71B9D08BC3C56048873E0C2E7E88B6FD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XQZOjEXNvaGhZIKF0zwmSGPVE7wE2QunLaeYlyrFbngSpxf+3KF6RFLjmi0VgsM3nO9fnAYsmh5mDjXqybv8VjjBR4DpQLcs8//sW68MSVoE7F4TtiNMNigEt8Xe7FtONERpcFLYErJr69U1pMNLfWy4Mz8xPb/PZPVURLZp42yJNeiMUH3LuKhsAHRLMJZwXSVyZPx477lLr333ACCqAitfX9vwrlGQDqt9U6BUUWLH1xVW7Ogtbd2TrisnhNeUzlHF3oEri47x1LSYQIyM6FJ5MwUygyXBPJ+QWuo6M9Qp2CBTdhDmue6NvR1c+ds/h4ov0MonDV/raCEIBlesQg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31a23b8-d6ed-4106-9706-08deb2b74c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 19:22:26.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRWksnGGqjvvoAsy6HldZkLukRi/IKQ0hEF8rxqDxzXYyV5V6FO6J2OSFMjc2lgBS7nJTp7Bngsnobcyx14TIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6242
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE5NCBTYWx0ZWRfX52X3UFC3igrg
 L3Ps0xbLyQR699M4jtsWph2ChpHts15lZQPsBtg2c+4i13pzrNlFN18A36H59cEjAW97u0ZywtA
 fMkkyCEN+O7aGF0dwCUmV3oZF3a6Qv6d4Wp8SCVargOZka4+1+a0+xMXUwcQ1hPFHBNzrB7L2hN
 Mpt5iL67JfDeK+2yW57M3rP6ozMHSLgqsL4Wg9vRMKpxW0ibg2HPr5rNc0REcej4CwMMWkyHkSj
 dBoXJWfPOHSe4HAsJdLksD4aRgM7d1rc/4kcU7/q0ej4aVCZGGU/30VTddp39jVoSLYB+zXPC+F
 FFaLJGeSqF/twgzvbm/01hyQWrtJo3Um79R3srFSY//jAtqVHFT092i2sV3L2ESgO42vGJHCiiz
 SIAN31fLr2LvFVGZuqug2ivTmpE8BAYGZ2rysZn2ns/tsYqCKG9ld2yL25xoxUDoSg+YL0XAP87
 aHJbJk+l/zYxpZfyTnw==
X-Proofpoint-ORIG-GUID: GeG_NVVkorrX4Y66URQpkg-vO6V7DrWA
X-Authority-Analysis: v=2.4 cv=aNnAb79m c=1 sm=1 tr=0 ts=6a077275 cx=c_pps
 a=cGw96uMdUXN41aDBKcSctA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=I-aC4mGk7zJNyMg4khQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CC2XYGqUdY9gnIbRkvHwm_-myz0HrYg8
Subject: RE: [PATCH] libceph: Fix out-of-bounds writes with oversized monitor
 reply messages
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150194

T24gRnJpLCAyMDI2LTA1LTE1IGF0IDA5OjQ5IC0wNzAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IGNjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZw0KPiANCj4gT24gRnJpLCAyMDI2
LTA1LTE1IGF0IDE1OjMxICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToNCj4gPiBXaGVuIHBy
b2Nlc3NpbmcgYW4gaW5jb21pbmcgcmVwbHkgbWVzc2FnZSBvZiB0eXBlDQo+ID4gQ0VQSF9NU0df
U1RBVEZTX1JFUExZLA0KPiA+IENFUEhfTVNHX01PTl9DT01NQU5EX0FDSywgb3IgQ0VQSF9NU0df
TU9OX0dFVF9WRVJTSU9OX1JFUExZIG9uIHRoZQ0KPiA+IG1vbml0b3IgY29ubmVjdGlvbiwgYW4g
YWxyZWFkeSBhbGxvY2F0ZWQgcmVwbHkgbWVzc2FnZSBmb3IgdGhlIGdpdmVuDQo+ID4gdHJhbnNh
Y3Rpb24gSUQgaXMgdXNlZCAoaWYgZXhpc3RpbmcpLiBTdWNoIGEgbWVzc2FnZSBoYXMgYQ0KPiA+
IHByZWFsbG9jYXRlZA0KPiA+IGZyb250IHNlZ21lbnQgd2l0aCBhIGZpeGVkIGxlbmd0aCBvZiA2
NCwgNTEyLCBvciAzMiBieXRlcywgZGVwZW5kaW5nDQo+ID4gb24NCj4gPiB0aGUgbWVzc2FnZSB0
eXBlIGl0IHdhcyBhbGxvY2F0ZWQgZm9yLiBUaGUgYWN0dWFsIGxlbmd0aCB0byByZWNlaXZlDQo+
ID4gaW50bw0KPiA+IHRoaXMgYnVmZmVyIGlzIHJlYWQgZnJvbSB0aGUgbWVzc2FnZS4gSWYgdGhp
cyB2YWx1ZSBleGNlZWRzIHRoZQ0KPiA+IGFsbG9jYXRpb24gc2l6ZSwgZGF0YSByZWNlaXZlZCBm
cm9tIHRoZSBuZXR3b3JrIGlzIHdyaXR0ZW4gYmV5b25kIHRoZQ0KPiA+IGVuZCBvZiB0aGUgYWxs
b2NhdGVkIGJ1ZmZlci4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBh
ZGRpbmcgYSBjaGVjayB0aGF0IGNvbXBhcmVzIHRoZSBuZWVkZWQNCj4gPiBmcm9udCBzZWdtZW50
IGxlbmd0aCB0byB0aGUgcHJldmlvdXNseSBhbGxvY2F0ZWQgbGVuZ3RoIHdoZW4NCj4gPiByZXRy
aWV2aW5nDQo+ID4gdGhlIG1lc3NhZ2UgYnVmZmVyLiBJZiB0aGUgbmVlZGVkIGxlbmd0aCBleGNl
ZWRzIHRoZSBhbGxvY2F0aW9uLCBhDQo+ID4gbmV3DQo+ID4gbWVzc2FnZSBidWZmZXIgd2l0aCB0
aGUgbmVlZGVkIHNpemUgaXMgYWxsb2NhdGVkIHRvIHJlcGxhY2UgdGhlDQo+ID4gcHJldmlvdXMN
Cj4gPiBvbmUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhh
ZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+DQo+ID4gLS0tDQo+ID4gwqBuZXQvY2VwaC9tb25fY2xp
ZW50LmMgfCAxMSArKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvbW9uX2NsaWVudC5jIGIvbmV0
L2NlcGgvbW9uX2NsaWVudC5jDQo+ID4gaW5kZXggNjZjMGQ2ZDZiMzNkLi5iODRkZDJiZmU3N2Ig
MTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2NlcGgvbW9uX2NsaWVudC5jDQo+ID4gKysrIGIvbmV0L2Nl
cGgvbW9uX2NsaWVudC5jDQo+ID4gQEAgLTcxMiw2ICs3MTIsOCBAQCBzdGF0aWMgc3RydWN0IGNl
cGhfbXNnICpnZXRfZ2VuZXJpY19yZXBseShzdHJ1Y3QNCj4gPiBjZXBoX2Nvbm5lY3Rpb24gKmNv
biwNCj4gPiDCoAlzdHJ1Y3QgY2VwaF9tb25fY2xpZW50ICptb25jID0gY29uLT5wcml2YXRlOw0K
PiA+IMKgCXN0cnVjdCBjZXBoX21vbl9nZW5lcmljX3JlcXVlc3QgKnJlcTsNCj4gPiDCoAl1NjQg
dGlkID0gbGU2NF90b19jcHUoaGRyLT50aWQpOw0KPiA+ICsJaW50IHR5cGUgPSBsZTE2X3RvX2Nw
dShoZHItPnR5cGUpOw0KPiA+ICsJaW50IGZyb250X2xlbiA9IGxlMzJfdG9fY3B1KGhkci0+ZnJv
bnRfbGVuKTsNCj4gPiDCoAl1MzIgZGF0YV9sZW4gPSBsZTMyX3RvX2NwdShoZHItPmRhdGFfbGVu
KTsNCj4gPiDCoAlzdHJ1Y3QgY2VwaF9tc2cgKm07DQo+ID4gwqANCj4gPiBAQCAtNzIxLDYgKzcy
MywxNSBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbXNnICpnZXRfZ2VuZXJpY19yZXBseShzdHJ1Y3QN
Cj4gPiBjZXBoX2Nvbm5lY3Rpb24gKmNvbiwNCj4gPiDCoAkJZG91dCgiZ2V0X2dlbmVyaWNfcmVw
bHkgJWxsZCBkbmVcbiIsIHRpZCk7DQo+ID4gwqAJCSpza2lwID0gMTsNCj4gPiDCoAkJbSA9IE5V
TEw7DQo+ID4gKwl9IGVsc2UgaWYgKGZyb250X2xlbiA+IHJlcS0+cmVwbHktPmZyb250X2FsbG9j
X2xlbikgew0KPiA+ICsJCXByX3dhcm5fcmF0ZWxpbWl0ZWQoImdldF9nZW5lcmljX3JlcGx5ICVs
bHUgZnJvbnQgJWQNCj4gPiA+IHByZWFsbG9jICVkXG4iLA0KPiA+ICsJCQkJwqDCoMKgIHRpZCwg
ZnJvbnRfbGVuLA0KPiA+ICsJCQkJwqDCoMKgIHJlcS0+cmVwbHktPmZyb250X2FsbG9jX2xlbik7
DQo+ID4gKwkJbSA9IGNlcGhfbXNnX25ldyh0eXBlLCBmcm9udF9sZW4sIEdGUF9OT0ZTLCBmYWxz
ZSk7DQo+ID4gKwkJaWYgKG0pIHsNCj4gPiArCQkJY2VwaF9tc2dfcHV0KHJlcS0+cmVwbHkpOw0K
PiA+ICsJCQlyZXEtPnJlcGx5ID0gbTsNCj4gPiArCQl9DQo+ID4gwqAJfSBlbHNlIGlmIChkYXRh
X2xlbiA+IHJlcS0+cmVwbHktPmRhdGFfbGVuZ3RoKSB7DQo+ID4gwqAJCXByX3dhcm5fcmF0ZWxp
bWl0ZWQoIm1vbiBnZW5lcmljIHJlcGx5IHRpZCAlbGx1IGRhdGENCj4gPiAldSA+IHByZWFsbG9j
YXRlZCAlenUsIHNraXBwaW5nXG4iLA0KPiA+IMKgCQkJCcKgwqDCoCB0aWQsIGRhdGFfbGVuLCBy
ZXEtPnJlcGx5LQ0KPiA+ID4gZGF0YV9sZW5ndGgpOw0KDQpJZiBJIGFtIG5vdCB3cm9uZyB3ZSBo
YXZlIGEgd3JvbmcgcmVmY291bnQgb24gdGhlIG5ldyBidWZmZXIgaXNzdWUgaGVyZS4gV2hhdA0K
YWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpcz8NCg0KICB9IGVsc2UgaWYgKGZyb250X2xlbiA+IHJl
cS0+cmVwbHktPmZyb250X2FsbG9jX2xlbikgew0KICAgICAgcHJfd2Fybl9yYXRlbGltaXRlZCgi
dGlkICVsbHU6IGZyb250ICVkID4gcHJlYWxsb2NhdGVkICVkXG4iLA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICB0aWQsIGZyb250X2xlbiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgcmVx
LT5yZXBseS0+ZnJvbnRfYWxsb2NfbGVuKTsNCiAgICAgIG0gPSBjZXBoX21zZ19uZXcodHlwZSwg
ZnJvbnRfbGVuLCBHRlBfTk9GUywgZmFsc2UpOw0KICAgICAgaWYgKCFtKSB7DQogICAgICAgICAg
KnNraXAgPSAxOw0KICAgICAgICAgIGdvdG8gb3V0Ow0KICAgICAgfQ0KICAgICAgY2VwaF9tc2df
cHV0KHJlcS0+cmVwbHkpOw0KICAgICAgcmVxLT5yZXBseSA9IG07DQogICAgICAqc2tpcCA9IDA7
DQogICAgICBtID0gY2VwaF9tc2dfZ2V0KHJlcS0+cmVwbHkpOw0KICB9IGVsc2UgaWYgKGRhdGFf
bGVuID4gcmVxLT5yZXBseS0+ZGF0YV9sZW5ndGgpIHsNCg0KVGhhbmtzLA0KU2xhdmEuDQo=
