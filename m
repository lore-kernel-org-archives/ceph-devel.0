Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B133D4EC;
	Tue, 28 Apr 2026 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395902; cv=fail; b=mb3HB97Sx/vsUJQPJS91en/fmAn+27c82tWq8ezeQdI2gDOF0QRjiiNo0SbHrcCPtA/Y7RQDHNNjw8WLkVPvgMJaEzt8gCP23RlqkXNplFlC8E5w57LOOGOr+f17VCM8yhSU59e89Sd41VlGArJraJK07WrBHW3Iop64Ad7RVvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395902; c=relaxed/simple;
	bh=x5rVBp9lA0zslwbBEaMwykIkEExs2kukEqVzZ7KRSnU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kfNwO2pjgwG775DbGlPLEs4DuSRBL+vjAKLPye8B4YwpokeIQ4vL7ixS61ra1ITWhKxLyny4I2um8Sts0k91u6ewQup7uViHshUKXK/648jZFHZae2JEXuT5z1NmtyLhm7Tdxa/YW0N/dqXgwbpfkMLPZ9OlKBlgr4nW9Q0dlAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OB0rdgc9; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OB0rdgc9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SDtUV51473100;
	Tue, 28 Apr 2026 17:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=x5rVBp9lA0zslwbBEaMwykIkEExs2kukEqVzZ7KRSnU=; b=OB0rdgc9
	rY5LFnp20lkETIhGHbsS4ORhV/l0fnLPv02fcU0M7Ll+T4V4mDMCqNA53l6pkBQW
	BD1htQwxY8m/TO8oXl4puHt24FeEuIun9nMKhyje+z11wWRGYVd3EApI7HkKkmEz
	M5yjVhwrakuqDgKmy7f5lb/GcvmmPTRDMWWp5A2W6ily1FGO2M01Azmsg0GeLNZz
	pV7hBW/aJaSeJrmDx6KE3gfP1X6wTKbrh5EkAhjEoxtZhEuu6PHHK/saR/9QoPum
	wT0lnUPtrNyZJr9HEQ0L0z+7Q3JyvOHxLWZXKqYJw8xKHOtR2GzoN0i3H/2lUfTe
	eV2RSHxkXp516w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vde12-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 17:04:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tks1V99f5D0Zb/ov0yhK1ZqJ8iRskHX4Xf7GlqVxE66YlHWZbV7U8tk/Lx6Zcw7zoKgJYOTNzgzaOiHX3+/VBPTArzMSu/tvoxoKjWBUaTHEEXWPxqWx93mEj3eAx0XxUVq+1hZuB/OeYCG/WW8njn4e4WW2s9+6bOf4cnNDqzddPWAh17oAinbZH4ReumecJw5DsrWRYsRPMyBU06XaevkAYJBdcZihohX1BMs0eyYwyNj91fPJ7FtV1LcZa1Ex0nXq/xw4LkcJiyUSfAnM3MY62Eg5805JjO/LrFE3I2XZlaos/QqoBrW5Sz6omCfSBrE6Wk93EzO+BS/FrJdEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5rVBp9lA0zslwbBEaMwykIkEExs2kukEqVzZ7KRSnU=;
 b=WstLEeRZ057024nywS/GejZ9VmwnR1/hnMjACVEtTQ7o+cGdNFOdlKFZYcOk8S36rC0Bn40xMyztoitbUKDWXtD2ugjyW6D7a8XJbgLTg6NeqUAcQ4O/9t4BkBOfn2MeoiUHQqg0ofc5TIfVOeCBReg4yo/qXZSBAYPhT4beij0WSUG79fK88fuDjrR4OZNfMrfGMXJ3eDtRkmWeAfUpjlOPYaq/RjsidV4Tc51qVEE38K/ZjvP1SlV45ZfDv62eEJfU2zk9//6xlCoe1BXJnlELfBPGqN+L8ArGgmFNsPCD4ofRp+kXzxhy8HHyTS3Dam4pqeeENFloupNSKUAJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5686.namprd15.prod.outlook.com (2603:10b6:510:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 17:04:47 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 17:04:47 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "lilei24@kuaishou.com" <lilei24@kuaishou.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "sunzhao03@kuaishou.com"
	<sunzhao03@kuaishou.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "noctis.akm@gmail.com"
	<noctis.akm@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: Re: RE:  [PATCH] Revert "ceph: when filling
 trace, call ceph_get_inode outside of mutexes"
Thread-Index: AQHc1BvhpQJT1Qtc3USMj5s6uWaEfbXzV3IAgACg5QCAAMGpAA==
Date: Tue, 28 Apr 2026 17:04:47 +0000
Message-ID: <ab347a1021a5d1d32bf41f6f59cd56b6408516a7.camel@ibm.com>
References: <20260418041241.17892-1-lilei24@kuaishou.com>
	 <8a17ed01f4d98c93ef53521e8ab3fc313678af70.camel@ibm.com>
	 <f5c1c6e44aa2bb1799ab67dd4569e15ddd443c06.camel@ibm.com>
	 <ACE74C42-7D08-4BB0-8ED1-D0468AE63DDD@kuaishou.com>
	 <62414b7cad425347fd6ea5f46d7d48dc4a4f0705.camel@ibm.com>
	 <37AC14F0-8B00-49A4-892C-B93AE6E9D79B@kuaishou.com>
In-Reply-To: <37AC14F0-8B00-49A4-892C-B93AE6E9D79B@kuaishou.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5686:EE_
x-ms-office365-filtering-correlation-id: 64c2eb11-fa63-4eae-3912-08dea54840e7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 fxICDPUNa1l1ggzHiSnyutiwQKvF3gJt5UN+xYVvzQ3/Rre0E/yOMsFDV+80oDPAlrCuuf1oZ7X6Y7kHZcWqgC4Ou+DEzS3Wh2i332g5eCQJRh7ApD7b/htDQbh2uQEV/Wu/FvDDl9KUOCokCTakzdd9b4ZYfMfhE1M9FPX+9awBH+Gpy2JKetf+74ciNg+swT7l3zaHoxYmkfCCm8URnoO7tb9icZa7y+EM0ms0jvr1ANhIVGDKXOEq6IHKEjDxUrOO8HOkpQjL5HUEznY+NCdX9u5BjqToFkLPF1xOFiCr1Fq7PdJ/lYow6N/H73X51XDr16SYOsSR7m8JQ8VDO2XIBGPE0io1/hzSHtJQiqRIgjAtptLVOEDfioZJMv4cAfReFDdE2hz9Sge59Uv0g4ZtPJzeOS8SouVTOlK37ZnrCpXhxrs3psTMB9y8X/oppa2EROReVrqo+5+0byFUHAmCgFd5AxWFxXFgmhcZ+u93elCuSvOY5L+b4ep1f7sL9qGbqv9v6jHhmcKoqhztUYGSdNXV5g+/AJS5sCM2ypNyOdJM5NfSDN6jMoojw+QCfZfybULZe84lnZ/b2Lu28w63UchnvLUF6reVcJd2FZ43QWn3HCFY9TnMBUkbqe2NoluONdV+ggnQJGtQFpjAcA4s+qUdUFgJF/HE9fAvsrpxpLHRY74RFYZsYM3BRzSDud5yjApNi3m0+bUXClvizwI4EEm9nOBqSq2UcHP3btppYN3sV1Tc8OJ+EWRWXRrITD6mzEqk2BloNVj8A3wIwt37m2yCXu2o1t2eS4Q61OU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3Rha1NaMDR3S0F1NlBhWUt3ZkpsT0JSUmZvazV1cXdQc1l6d2JtTW1yOStQ?=
 =?utf-8?B?dmFKVjhJNFFyaWpNTXFMaTBreWhhK3dvUEhpcWZnSDNFTWtrTVZzNjRUNCtl?=
 =?utf-8?B?dEkzNmpXenVSQWlWOG9GK1FKZzc1ZC9iSGRXMUxnbFpwL0dmbnVUaWI0c2Rn?=
 =?utf-8?B?cHNGYWNzTE4wWDliZ1pSTnJSUllEWkNyV1VFdjJSZFlkN1lrUm5ydEIrR0Rl?=
 =?utf-8?B?Yk5PMU92SUFzd1ZVZnhJTnkzRHpmNVZtbDRld1BxK3hXQmpsT1g2MU5ERXdm?=
 =?utf-8?B?bGw3cE1qbXVyNUc0RnZ6Kytqc2M4VkZPVDI0NlJPUmdvRTZ5MXZaU0FINUNy?=
 =?utf-8?B?dVBSNHR3cXl3RXZjcy8rUGtWaGdGaCtTRmt1eGJ0UndwTG12QWlQdG9vVHVK?=
 =?utf-8?B?WTcrN1F0ZEp0Z3oxM3VGUms3Y3BGTjZPTkhxUm5jbmdoM1hFVVkxb0ZLZUFh?=
 =?utf-8?B?d3hEWEFhSE1wYmdabkZ1QXVtQVlaTUpmMjg0REQyVlVCTG9ud296R1oyd1I0?=
 =?utf-8?B?cHRtQUd3SXdVY2ZHT1NuOHBmYWliajAyR2N0SHJkOFhFelJNV0FBdHh1QVI2?=
 =?utf-8?B?aDdTL05KWDU4azJPaGpPZDdnSEdScmVnTHh0UGF1Nm8zSDhmeWgrbXZEL0lY?=
 =?utf-8?B?eFVLOFd6VVpzZVhwRCszS0JuMGhkNVZOMHFZNTU2YlUyR3JaMnkybXdON2l5?=
 =?utf-8?B?SStCOTF1eXg0YXVGUThNQWJjT3I2MzFnT1pmQ21SaDdBR0JoODd1aUU1Qjlo?=
 =?utf-8?B?ZHhoU2ltdDBMNWgvN1c0YTBQa0lzMkt0ZjN5QUtvYzhqZ3dEUmNQUTY5emVB?=
 =?utf-8?B?ckF2RmRDSUFCaytUcnI3ZDY1SnczVVNXZHJnczBmNTd2SXRiUmdhL2RIVTNQ?=
 =?utf-8?B?UEg0YUdrR3ROdGtGRFBEeFBWeDliKytMSFFmaytJQzhzaytrVzhVOHg4V25N?=
 =?utf-8?B?cmJtYU1TQjhKMHg2bWdyNHc2dTBIYklUcThRU0NtaVlqVkgrNllMTGRGekpn?=
 =?utf-8?B?RmlFejYrMXl5aHBJVUgwckRUSjhDcXZMb1YzdC9oMWRmVWhGZ3FxVzQyL09N?=
 =?utf-8?B?MWM1aGdTZmhmQXp4THZsWkZTWDFHZjVJMXdmeTVvTnhOTGxzK0VYK3lZek1O?=
 =?utf-8?B?SjJudmFDZm5VM0pOcEdXQUU3OVVCZ2dxakNWNElNNGxKRHcvYVpaNGQvYU9v?=
 =?utf-8?B?cUJBUVlwRTBrZWh0Y0tHQlQ0QzdpMnR2WE5MbjZiaFA2Z2s2ajZHMHlSZi9o?=
 =?utf-8?B?Szg4WHRheUMwQUk2M0xxRTlXNWtKbkZWOWZlNmRkS282aWFub0N2QXV4YnMz?=
 =?utf-8?B?bzNqdTRIUE53enU2T0kwWjJzTUhRazhFeVdzem9vYS80ekFwalZZWllnZXVX?=
 =?utf-8?B?eHE0QkdVb3JnU2NBOCs1MDBjd25Hcy9PMEVIYWtBRmpvaFIzQUN6dUZMUFM2?=
 =?utf-8?B?b21hdUhzcmlzMUVRR3ZpbExPR0NvQlFqaUVRMkhaelhtNVZJb3dwKytRRldp?=
 =?utf-8?B?SldPWndrQkxqQzZJblJIVlNnTGs1T1ZYaE9pR0wxekd5QWNNelNncEZQWTZZ?=
 =?utf-8?B?M1ZkbnVSeW1yQnd6SCtKSUtCZ0FXeTlJV3AxcVY5QVdqemYrMmtjZDVRdTNR?=
 =?utf-8?B?K0J6R3QzSm40US9iMnZheFppMXBtTkx2RzNUTm4vTXYvUkVIWG9PUE1RQkpL?=
 =?utf-8?B?UnpQWGdqRStBZU5rbU9RU3Y3RWJxeXJtQkhuOE1GZjJ3WjF2a2p6Ujc1N2NB?=
 =?utf-8?B?MGhvbXp6RlVvNHVEQlRUWVB1WUk5RW5PSU01SHdkOUN2bXliM3gwbVBuMDlB?=
 =?utf-8?B?SzVqSldHek1DQjBQWklxSWlHMnFrMFFqQjJkQ01sWWZybGM0akl0M242Ti9I?=
 =?utf-8?B?V0h1SHFraWtNNy96UThXQWpqeml1bUFVelhyTDlNa2hubDZjZVRKT1BqNmVy?=
 =?utf-8?B?NlJMbmlYUC9QVk0rM0ZWL3hnelBNT1AvY1dZc2VsakJwbGFBc0FEVEx3NjVN?=
 =?utf-8?B?ZnQ5VTU0QWlZUTNNQnlPV0lSbkphM0JJZFBqSTZyNGlBRkVhMmdYZ2tjTnR6?=
 =?utf-8?B?LzZ4ejFYNXNLYlZhbEp3K2FNREg1L05teElNY1hsOXJXZVh5b0FDVjhSazBR?=
 =?utf-8?B?WHdiandiQTBYY0VOSk1aSFIzN3UzNXQxVlZ1Zy9hS0pvTzBEdTZkNzF6UE43?=
 =?utf-8?B?YmdncHEvYmlFcHFrV1FsM2k3YzFpWlo5cGtIb1cxSXNTUUVpbm5wUml4d0dw?=
 =?utf-8?B?UEJkYUlJV3I5Z01lcnZFYjM5WlY3MVpoaGR1WXZaanJsMmFIV0F6ZCtHOWhN?=
 =?utf-8?B?eWRtTFhXeFBsOE5TQVhvblVZSElIMlBMSFg3VDlzL054a0JJYnp6NXlYTlhx?=
 =?utf-8?Q?L6RnhsB94mpsa/8r2x29WgUHUZVQLWuD/Ay9c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B26A9A4D9C477C4F9D890ED53AB99E68@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RY0F9LWmTiyItxX3/gcXdQwMw8DMHiLMOPOOCD7tOzWJwfmEDQhbY+vS+pmSarRFdPnTaCmJKLfRjpDttzyotYcrJ0byPZuRJq9N9LSexJ3SRWsOs1Q6WY3j4m3LwCeMGBll1eDsT9td9NKBF4ug4I8J3s5TIBFNRPkBYqUjOK/DCh07qqf3nN9Lma+EmurgWfFxXXplU3GT6jPoHkriiNKTYAqXppFxDlKnuntAIvmvAS5kM0GcukCa17wjGT1rG6GQMrnMfRcS88nYvpg3PyKzTV4mIbQzHE+/LhXLN7hlXFualpUwVTPr3FsgrFH1UKM4eNVBTGzXIJWqccVE9A==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c2eb11-fa63-4eae-3912-08dea54840e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 17:04:47.7871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3Gn0iv/iFgpQ1UqnJa7Qsgg2TjoD9HrMG65X6DZU0mFkzzAsjv9YBW34mGP6Stio1CO7GpSklecCoTc0Tpn2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5686
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f0e8b2 cx=c_pps
 a=1g1g+NiJF5nyOkqFb40SOQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=hiXvQZlH-DbLSgeI:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=ygk0MHEVVsZvuTthHfUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BxNoyMzce_BzDOye9x1ulsLEW5lIyucL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE2MiBTYWx0ZWRfX4ygSMbokkv44
 iM2syVSJmE4n1qzXRmxa0RVnx//z2LojkErWUKWP35G+hYOlG+Ca814Rz8TwVc48Re832yhF2fr
 96y1ewAeGgjL0BZFuB09gmAxaJY17EYvqOTa0J5EKHu2NdTcxcHVuFvICQHPZbfpMeBEcP99ONX
 YV0Hs1YSwPHpN+mvvREfKyGHpimuO8PSH9wzyO1fR+iG6TZUfQoafl3NdPgQNle1XJiGj0Hdu7A
 EaWpLofG4s1NjL7wZaCFG2b2DHAWs6mupMlrY43DAfdV9/ErhR26Y0LXw1MXQeVreR7tqu0m17w
 G9PunuJsrmeNcB8SxzQEeveNbTPldfPWXaAG2dhcRgerOQHGh6nnyKb6K2Nwq/iMFqFj6qbI+fM
 GPIpwvko154hAEA+AziGQZjZCe8/DJZxMEn9NbIdPPY3y2Tl59roWLEW0Y+yQksEKyeYKjkjl4y
 RzDV8tMLVJDN6HIfHKA==
X-Proofpoint-GUID: zzWRtvLNjJv9rLLAyBbgcN8rSDNTdJI6
Subject: RE: Re: RE:  [PATCH] Revert "ceph: when filling trace, call
 ceph_get_inode outside of mutexes"
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280162

T24gVHVlLCAyMDI2LTA0LTI4IGF0IDA1OjMxICswMDAwLCDmnY7no4ogd3JvdGU6DQo+IA0KPiA+
ID4gDQoNCjxza2lwcGVkPg0KDQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgSSB3YXMg
YWJsZSB0byByZXByb2R1Y2UgdGhlIGlzc3VlIHdpdGhvdXQgeW91ciBwYXRjaA0KPiA+IGFwcGxp
ZWQuIEl0IGxvb2tzIGxpa2UgSSB3YXMgImx1Y2t5IiB0byByZXByb2R1Y2UgdGhlIGlzc3VlLiBJ
IG5lZWQgdG8gdGFrZSBhDQo+ID4gZGVlcGVyIGxvb2sgaW50byB0aGUgaXNzdWUuIEJ1dCB5b3Vy
IHBhdGNoIGlzIG5vdCByZXNwb25zaWJsZSBmb3IgdGhlIGlzc3VlLiBMZXQNCj4gPiBtZSBzcGVu
ZCBzb21lIHRpbWUgdG8gYW5hbHl6ZSB0aGUgaXNzdWUgcmVhc29uIGFuZCBlbnZpcm9ubWVudC4N
Cj4gPiANCj4gPiBIYXZlIHlvdSBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgb24geW91ciBz
aWRlPw0KPiANCj4gSeKAmXZlIHRyaWVkIGdlbmVyaWMvNzAxIGFnYWluIGZvciBzZXZlcmFsIHRp
bWVzLCBidXQgbm8gaXNzdWVzIG9jY3VycmVkLg0KPiANCg0KSSBhc3N1bWUgdGhhdCBydW5uaW5n
IG9ubHkgZ2VuZXJpYy83MDEgdGVzdC1jYXNlIGFsb25lIGNhbm5vdCByZXByb2R1Y2UgdGhlDQpp
c3N1ZS4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSB3aG9sZSBhdXRvIGdyb3VwIG5lZWRz
IHRvIGJlIGV4ZWN1dGVkLg0KU29tZWhvdywgSSB3YXMgbHVja3kgZW5vdWdoIHRvIHJlcHJvZHVj
ZSB0aGUgaXNzdWUuIDopDQoNCj4gSnVkZ2luZyBvbmx5IGZyb20gdGhlIHN0YWNrIHRyYWNlLCBJ
IGJlbGlldmUgaXTigJlzIGEgZGVhZGxvY2sgYmV0d2Vlbg0KPiB3cml0ZWJhY2sgYW5kIG1lbW9y
eSByZWNsYWltaW5nLiBUaGlzIGRlcGVuZGVuY3kgY2hhaW4gaXMgYXMgZm9sbG93cw0KPiANCj4g
MS4gU2V2ZXJhbCBEIHRocmVhZHMgYXJlIHdhaXRpbmcgZm9yIHRoZSBvc2RjLT5sb2NrIHRvIGJl
IHJlbGVhc2VkLiANCj4gMi4gVGhlIG9zZGMtPmxvY2sgaXMgaGVsZCBieSBrd29ya2VyL3UzMjow
OjI0MTA5MiB3aGljaCBpcyBwZXJmb3JtaW5nIHdyaXRlYmFjaywNCj4gICAgYW5kIGt3b3JrZXIv
dTMyOjA6MjQxMDkyIGlzIGFza2luZyBmb3IgY29uLT5tdXRleCB0byBzZW5kX3JlcXVlc3QuDQo+
IDMuIFRoZSBjb24tPm11dGV4IGlzIGhlbGQgYnkga3dvcmtlci83OjQ6MzA4MjkyIHdoaWNoIGlz
IGN1cnJlbnRseSBjYWxsaW5nIGRvX3NlbmRtc2coKQ0KPiANCj4gQmVjYXVzZSBvZiBtZW1vcnkg
c2hvcnRhZ2UsIHN0ZXAgMyBoYXMgdG8gcmVjbGFpbSBtZW1vcnkgYW5kIHdhaXQgZm9yIHN0ZXAg
MiB0byB3cml0ZWJhY2sNCj4gQW5kIGZyZWUgc29tZSBmb2xpb3MuIEJ1dCBzdGVwIDIgaXMgYmxv
Y2tlZCBieSBjb24tPm11dGV4IHdoaWNoIGlzIGFscmVhZHkgaGVsZCBieSBzdGVwMy4NCj4gDQoN
CkkgYW0gZ29pbmcgdG8gdGFrZSBhIGRlZXBlciBsb29rIGludG8gdGhlIGlzc3VlIHRvZGF5LiBC
dXQsIHByb2JhYmx5LCBvbmUgZGF5DQpjb3VsZCBiZSBub3QgZW5vdWdoLiA6KQ0KDQpUaGFua3Ms
DQpTbGF2YS4NCg==
