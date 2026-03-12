Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09031383C8C;
	Thu, 12 Mar 2026 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344527; cv=fail; b=MDT8xC3eTNHNj4MOvxrOFaGHBAnJ4r52V2L9qaJX4Ye42ZSA8Nm4epA6NQ3y4c6R+G9XFzNh+FPAIH3/iBgla3S7dJercqxUMzd5y+EAgX8wiG9cy+E5+T3D8NGaoZ6hcqfStvNPwAxI50FKSedTYEUIDtmYS/ZmFF4Kn0A/OGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344527; c=relaxed/simple;
	bh=YU+B6bqqkvf2BF9hJxN6lu9CJ2qia4YgWTYd1c0qtJg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=F/84hlia7LR6sWtFp9D04/z9/dfKpV9H9BLfoS5qtKPb6hOoTizzTuGiYAi58zSa/f2Uo6etvjGhKxPIAZP84JlY2SXhJfN60vINammAvseEY0FH29e+KcOCKGBjT4IwAvctNxggRg7Sc6GpiCMv660ylGMqWWRH/S/qOUMuwk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aaa/7Iw0; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aaa/7Iw0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CELI8J2303246;
	Thu, 12 Mar 2026 19:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=YU+B6bqqkvf2BF9hJxN6lu9CJ2qia4YgWTYd1c0qtJg=; b=aaa/7Iw0
	xhnn4VRzb1IOf2f4ARNari24vtXRe91NEkfrwzUMpAPBVIcl4iaf2OHaNov4DyZ2
	jkPmzk4HvZ1opVfofCeBygRkSjZWafhCcjQ4mC0YBAk1nUOLY+VCif34XUkkh4wk
	trSGZHhxPrPTi1PF/Sbr05oJoSnfPZrxq7unutPZeDKa18fb0l93gWrdPLrZUsYb
	/QRndYUzh2H/McoezIynhTLwrbmobJ/ivdB8tdBIBWosgMKsIpHJ5ySPYx7lLlma
	WyCoMGtfO7EjoB5n6mu4DL5M2MqayOYZjYZs9xzRAYWWZp9SSj4Nxexy2HfY0wTa
	QhAtzFEiq6ibug==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95vdp7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:42:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypx1TKJMHnkQgHcB5wMDwrDMhVuVYNne+U/CvCQ/dV3zccswv4aVTSQo4H1j6+YHfxQo2Fxrwx6NEt6ciwAJ5KA1+deU3uHR1mIFRW9CXffzNRadn5rwR5jr9vvK+DCL5GHVH1Ijn3skpiLJPS3Cfk6VlNJhngQ1PPYjuoORZTf6QVKudfjY92lJEBXqk7sxuvCdFAva/EhN/15IjzhQGwYH4Mdqhq8FyO9ka0RXELRH6fmr4SwQKv4vU4DcZp32CZDM31Ng0O8meMBqtxvfjOcDXwZJuPB/PJo+45tMfbpw4uK/CM8C39BSo8eVgYXdIAKmDcQoa/KP/kPmm5g4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU+B6bqqkvf2BF9hJxN6lu9CJ2qia4YgWTYd1c0qtJg=;
 b=w6cdwOpbeg7DRuSVvaDG+wFYph0vFn03d+C9D5Ukt75ytJyPvA/o66Tm2SuO9+N9ZlipwcgBxHIySUMJMCxlQlEuk5XYGJ4LelPUoJcTsoSVTb19I6O6K/pIW+pvCtml+zzEVM1v1iFNXsPM+qmSmYxNlB8h5jkyzHIrZlKQLUYJPskfefU89L3NDx0dGtyypX4KRvyWLKMP+HsVctiWIe/5Kfz4WrddNRGmZMqn5TAZ9L0KFmlHOsXfrKg4gma0oL/Ri6ur7VCLk10h2QLORzc6vXOYJRQxcDWjhB6ZAnMNm1mJp9rXRw41vQeJu8dW2dEC8t4o23+KEu8m5xCbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL3PR15MB5483.namprd15.prod.outlook.com (2603:10b6:208:3bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 19:41:57 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 19:41:57 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Thread-Topic: [EXTERNAL] [PATCH v1 06/13] ceph: set default timeout for MDS
 requests
Thread-Index: AQHcsfkI1Z3EazCSnEOP8AY+zLZTsbWrTJ8A
Date: Thu, 12 Mar 2026 19:41:57 +0000
Message-ID: <3e107cacda6f0eca6950545cca7c16c30fd82c8e.camel@ibm.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
	 <20260312081619.40854-7-ionut.nechita@windriver.com>
In-Reply-To: <20260312081619.40854-7-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL3PR15MB5483:EE_
x-ms-office365-filtering-correlation-id: 748cd27d-2c38-46c4-7bc1-08de806f6c0f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 7mXvOqoWNeqy4DincWn+HUosUl1p3vabqEBg46fJr3+AXRL2WqVEf8xbzWuerZBsQDwAz/IZz/gMC3AbCjAG81grb+YIbntUIUBgsLnlHcAZaAP/sA52tvKMUBiGZfEX9fgkpoSD2iH4PJSOzF1+v0ygFkI+mLuBcLp1rnAKKFhJ4/TkdZaPGK/3iaxUkJMzL2ZsablmK080NHE7FOkArhysg0jjjscx9ITfx2eslClP+wMy0p37uQBCv1NRIG7ybZjQ88Xu+hPnZ31pJ5xnH3bkz5Y5uVZIggqFolcEf16UuGNk5u6djSWuWskdPHso0i4YyL0D2B2qKCpIGlt/MSGAz7FsJJ7WnFwWylnuiPebjk1vTDG+xqV4ZyBrrVfep+oCzzSdbkEnmC5zFUwF2fJyZpv49fxwcaKcxJZSdTOycaBbkrb4sk2DaIQMKvbp21AFjLTfM0ufqZqZKXKxx8NWafnWlg5GhnAufpCPvJOv9hPhTTaZNm9e5l9YZJkgKZixVh+bCvxWVoaYMTxVhk8eETlf32EE7vDOMjd2EshppAlFH9qaqUYr1se099XMqwYeobureY+p2IZ+lu6smMzkrtY1LY871MwHPNR7322ZXQ4BnDY4ciXGjqeYVs2JLHUAT1I3g0S5NUkMGsM571kvU2xMg+jb/ljVo46JKGmwbF14qIijf2kS+A+3fdNlrSRRESGawlOO9Hx8PMVBy+BUn/tw6M/vov5QmUje5hMx6jJwv18Su89K4ggnNkdbbIdl9KOaKLPMVMmdkixyWR5EMcdlDArreL/vqq8gywQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekE1Q1ZuSFN1RnliT1ovdDhTR05sT1FCTXJMMXZVK29oOEtMVFQ3SHpnaXFW?=
 =?utf-8?B?Y1FCZUhKdmE2d3N6SXJnaWlDaDV5SkxERmhoMDFUdTFndXlOMmxsd1ZjclEz?=
 =?utf-8?B?WE5UV2NXaFNDT01ibGNPVEhWcXFIcmVBMzk4Zno0NmpvZGhudExFeW8ydVBy?=
 =?utf-8?B?V3E5dHdFVnR6anlhejlHY1phTW1ySU5Ka0FwNDJiSHZIVkNEeVYwQWhSQkZV?=
 =?utf-8?B?NnRmYWxZUFNZRFhDVy85U2I2d09tUUlFNEI5OTBtNXArZDVJOTZLdUl3eGpH?=
 =?utf-8?B?S0tkOW5wZlc1RkJpdGZzVjZYaUp5RGN4VHpnZVBEMW9OSy9wamF3eFlMZ25P?=
 =?utf-8?B?Y1hZQUV5MlhOand5NlY3Rnhubm9QcUpjTDJiRERITlNHMlJ6Rzl6MEJoRTNB?=
 =?utf-8?B?RlBibnBIMU9IZk4waGpjSHRPSnBpQUNFcWZXNHpCakQ4NlJ5bXplYUtvamR0?=
 =?utf-8?B?SW5uLzYydHJXekgwcitjSUdJbWFxbGFaRWZsWTVhUEZ0UzVDcUIrVTZ2b1hk?=
 =?utf-8?B?bnIxTHViR0t3dzN5ZUpRTU82ckJtdEkrd2pTMlROWkMwb2FBM3h6N0tBdVhC?=
 =?utf-8?B?TVUva3g4Wi9tSTlBUjhmTGZ2UnY5dHArUzBQZTZqTCt3UTBkM01uYSs0UWNy?=
 =?utf-8?B?am1SejJWeXV0N0p3VUVXMWRzLzRVZGNIdDNTMEUyZ0U5c2d0anRHQWZ0Vkls?=
 =?utf-8?B?dlI5cHpMZzdIWU9saEdUMERQVElkcHdZeXdrNzJScjlyQXF6RndhZWFPazJC?=
 =?utf-8?B?SjE0WXppTWlRU1FiWXd1SmxDWXV6ZFV6VFZpYnJjYm42aGJYUm4xdXN5ejNS?=
 =?utf-8?B?dTBraEhrY2MxenJwZmpNTjFWNGJqcXlya2RNdERlSkNlVTJlL0ptMkxHVHRm?=
 =?utf-8?B?VDVDN1RyYnFvUDNwVjl3bEJ5Yy9peStjeVBZYWZmMDM0Lyt0RDR4VHAxL28v?=
 =?utf-8?B?ZHQ1cFNSU0R0ejVxeHJvL0hWZVd4bFgxZE95dG9YWW5pbzBnalo3dUxaSWFa?=
 =?utf-8?B?OVdRRzI0L0hFa2ozeDdscXFDOSswOGZ5MWJZaGNLaVZidForVEpHN0I2QzAz?=
 =?utf-8?B?NzZjeVZmaUZSSG0xdDlHYzZtS3ZkeWVReVVoV0YrUnNGWXdoL2twQWlEZjY5?=
 =?utf-8?B?RTFZZ1ZzczBMOVhXMVhvZUd5NXdha2s0WVc2VmFDaFVmWHAzdEhLZlgzeTh4?=
 =?utf-8?B?cjk3QWdkSWpXSWFUQVBya0R3cWNoMDFPd0c4aXZSYzNSdUZweHlkdzJMdmlE?=
 =?utf-8?B?bmZQZ3BYbkpCL01zTkVSVUxSSlorUnB3K1k3UjloOWRYdnk1UWlUQ1FNVDkv?=
 =?utf-8?B?K25uL0h6Q3MvL2gwQ0s4ZkFEQnMyb21HMHVkVzdVQXFzYitRVksycFBabnNS?=
 =?utf-8?B?MzZsdzZGQndtTzZQclY5ZnY4VG11bU9IclBuSjBvTVVPTHUrSW02eGMrOWd0?=
 =?utf-8?B?NkR4anZNT3hBTjBuUVM2NmlpcU8zZjNib3VZdFNnb2Q3UStTdmZLMkRrK1hw?=
 =?utf-8?B?OWdJd2VWZFJJd3JEMzRmMlc0S0doa05vODN5RzRzMUtsVm92c0NYa3pEbVJ5?=
 =?utf-8?B?cStranJqdDRwYm9EbmpMeHFPd3BWdTNwaGkxb3dLK3RzQXRHaGNtaXBUNHlU?=
 =?utf-8?B?VTMvcFFCVktvSi9yRFpQSHU2bzVkemd4YUtoejBjZ3FTVjU1SHpiYzRveTVO?=
 =?utf-8?B?bGJmb3gvbXQ0TzFVaUdDbk5BWWlMRVFMUEZETVlPMTlOM010SFdPc29BdFpO?=
 =?utf-8?B?RnRpaDBOYmdhU1FaK3dvUXpUWFV1ZzVFeExiUjQxejhGSGdQRi9Qd1liRUZD?=
 =?utf-8?B?TmdwR1JCMCtndHJabmNNWFJSWjE1TlQ3SVhNT0dDZVpXZk5qZmd1eTNtVnlR?=
 =?utf-8?B?bVVtU3JScmNEZ05XVWh3SENTZ1FMaytnVDJtZ0tmaFQ5UW9tVldTVEVUYVdj?=
 =?utf-8?B?QTJwRnc4dFpTQVJHNE15SDVHY1Y3ZCtQRmUwMEhDN1U3U2V0c1NqK3d2ZXhU?=
 =?utf-8?B?S1hNeGwwMU1UUHV6cG54NXllVU5xOUxkeVpPUW5oczF4TFlleTJJQW83THp0?=
 =?utf-8?B?MktXcHBVdXRTRmpvUy96MEM3cytZc1NubnVuakUwbENYUDRUS3hDZS8xWU81?=
 =?utf-8?B?RWpSQTEwbERBdjZ3Wis5MUNXZXJPWXhYbExYb1FEVGgrS1p4V1ZNNWJwS0g3?=
 =?utf-8?B?WkxkcGhJaXFFeTBJYW5ZSDJlcFFaTE5YR0tNNFhsZVVlWnl5RlFtdXdMWlFL?=
 =?utf-8?B?eHdwOFE1blhONWdIUGpwWUp1SUU0T1YyamlsUHdVR2lwZzE0ckc5dUhBYlgz?=
 =?utf-8?B?cUdYdzJTZVQzL0JNVENpVkEzL1diSXhiWXgvY0YxMW1kYlRqWWpKK0tKNlB5?=
 =?utf-8?Q?NrxZ0wc7XaUtHSKFhXu8ah4k69yUth2OUG0cl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FEE517F9EEA394593D01E68D15BF061@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Ocv/ZyfGmJJ0JjBkyVhBSg7HvQeR48EZzfbSMS/ADKoluvDfpFH0gDJ5zkmZazSQX8atDKlDsSp7yYUa4+vdTPsPv03odBi6yRXkfbjIEX5v1z/xrQ8PJ73YqHz5/hJJa59arwH+yBEUj/zINmk0GgQeNxVckMQzVKW2zEH0zTGsnTQiLswMua3jEmGzD+yNDJsqahuCLIxQyEw7Ba2T0yrzFGGxaT+yB7gkoeCG/Fi11wQp6cVgXxRK/sgsfzCETMMAEXCnNjBu+zu2VrUFdQHgZJjE4pBb6JzCTnUyhB7zxYUf1O/uqGj+FriPgezUGUAQHpJZfT+TuHNmZ4yC0g==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748cd27d-2c38-46c4-7bc1-08de806f6c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 19:41:57.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ON3mk8ofOf1BMENJ+w+KBx1hI3sZBlK5D06TQm3UCkTOLuBm0AnyVYYxpQu8mypy0u/05IVcxfv34rAOf1Rkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5483
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1OCBTYWx0ZWRfX2u9AMBPDEhHU
 anUQOG9zgF54x8jiHQl4Id7ci7MsH12FFg4PvVfLNKvyV6sJGkmV3eyzb6/98ZemZ7VoQRTEscg
 Xss0FcpHjADfSEnKlVQ1tgF8rnfABUT1lGvrTZHJNjg/5wZQyC/Sxurt4iT7MnfbbANQ5QrcSmI
 AX2ggPwQfW8SZETs60baSg3PfpUpNAYbeeZQs1wx/taqhWR0zU4N6nA6V+TPkw+m1Mfias4MUAY
 K9JjSg6hxQGoxMz600jbe9Wsrcuei277Rxj17OKmdU9lc/vM1Szu9F25Zur4hSm7iLuqOqO/HeE
 S6hIScY9Yor8ZI1g794RpwGFGlEw5SG+RzuYR4MfbPePxiXfpM/KslglwdtnGbSiFXumDdkCBkR
 0gFN0igU+RCFfZC0yDcTbjsoGP5VQ62w3XDUF6/XkxijOWQR/HDJMdfG9okDJeUnNXPDqGgL767
 RXOVCpMLdYhUWe4NClg==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b3170a cx=c_pps
 a=hjCSP9ZXGz/ZSNNiZYHiPg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8
 a=iyrgyKr-WZEKz_h1vFsA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: MYsDi99JAdJCHUwyg-RFbZovr7kTTVMG
X-Proofpoint-ORIG-GUID: WjHZqNKNRdyErPx-9Ii3OsBwLSd9oilN
Subject: Re:  [PATCH v1 06/13] ceph: set default timeout for MDS requests
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120158

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE2ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gTURTIHJlcXVlc3RzIGNyZWF0ZWQgdmlhIGNlcGhfbWRzY19jcmVhdGVf
cmVxdWVzdCgpIGhhdmUgcl90aW1lb3V0DQo+IGluaXRpYWxpemVkIHRvIDAgKGZyb20ga21lbV9j
YWNoZV96YWxsb2MpLiBXaGVuIHJfdGltZW91dCBpcyAwLA0KPiBjZXBoX3RpbWVvdXRfamlmZmll
cygpIHJldHVybnMgTUFYX1NDSEVEVUxFX1RJTUVPVVQsIGNhdXNpbmcNCj4gY2VwaF9tZHNjX3dh
aXRfcmVxdWVzdCgpIHRvIHdhaXQgaW5kZWZpbml0ZWx5Lg0KPiANCj4gVGhpcyBjYXVzZXMgaHVu
ZyB0YXNrIHdhcm5pbmdzIHdoZW4gTURTIGJlY29tZXMgdW5hdmFpbGFibGUgZHVyaW5nDQo+IG9w
ZXJhdGlvbnMgbGlrZSBzZXRhdHRyIG9yIHRydW5jYXRlOg0KPiANCj4gICBJTkZPOiB0YXNrIGRk
OjEyMzQ1IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjIgc2Vjb25kcy4NCj4gICBDYWxsIFRyYWNl
Og0KPiAgICAgY2VwaF9tZHNjX3dhaXRfcmVxdWVzdCsweC4uLg0KPiAgICAgY2VwaF9tZHNjX2Rv
X3JlcXVlc3QrMHguLi4NCj4gICAgIF9fY2VwaF9zZXRhdHRyKzB4Li4uDQo+IA0KPiBPbmx5IHRo
ZSBtb3VudCBwYXRoIGluIHN1cGVyLmMgZXhwbGljaXRseSBzZXRzIHJfdGltZW91dCB0bw0KPiBt
b3VudF90aW1lb3V0LiBBbGwgb3RoZXIgTURTIHJlcXVlc3RzIChzZXRhdHRyLCBsb29rdXAsIG1r
ZGlyLA0KPiBldGMuKSB1c2UgdGhlIGRlZmF1bHQgMCB2YWx1ZSwgbWFraW5nIHRoZW0gd2FpdCBm
b3JldmVyLg0KPiANCj4gRml4IHRoaXMgYnkgaW5pdGlhbGl6aW5nIHJfdGltZW91dCB0byBtb3Vu
dF90aW1lb3V0IGluDQo+IGNlcGhfbWRzY19jcmVhdGVfcmVxdWVzdCgpLiBUaGlzIGVuc3VyZXMg
YWxsIE1EUyByZXF1ZXN0cyBoYXZlDQo+IGEgcmVhc29uYWJsZSB0aW1lb3V0IGFuZCB3aWxsIGZh
aWwgd2l0aCAtRVRJTUVET1VUIHJhdGhlciB0aGFuDQo+IGhhbmdpbmcgaW5kZWZpbml0ZWx5Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiAtLS0NCj4gIGZzL2NlcGgvbWRzX2NsaWVudC5jIHwgMSArDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL21kc19j
bGllbnQuYyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+IGluZGV4IDQ1YWJkZGQ3ZjMxN2UuLmFj
ODYyMjU1OTViNWYgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+ICsrKyBi
L2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+IEBAIC0yNjEzLDYgKzI2MTMsNyBAQCBjZXBoX21kc2Nf
Y3JlYXRlX3JlcXVlc3Qoc3RydWN0IGNlcGhfbWRzX2NsaWVudCAqbWRzYywgaW50IG9wLCBpbnQg
bW9kZSkNCj4gIAltdXRleF9pbml0KCZyZXEtPnJfZmlsbF9tdXRleCk7DQo+ICAJcmVxLT5yX21k
c2MgPSBtZHNjOw0KPiAgCXJlcS0+cl9zdGFydGVkID0gamlmZmllczsNCj4gKwlyZXEtPnJfdGlt
ZW91dCA9IG1kc2MtPmZzYy0+Y2xpZW50LT5vcHRpb25zLT5tb3VudF90aW1lb3V0Ow0KPiAgCXJl
cS0+cl9zdGFydF9sYXRlbmN5ID0ga3RpbWVfZ2V0KCk7DQo+ICAJcmVxLT5yX3Jlc2VuZF9tZHMg
PSAtMTsNCj4gIAlJTklUX0xJU1RfSEVBRCgmcmVxLT5yX3Vuc2FmZV9kaXJfaXRlbSk7DQoNCkkg
bGlrZSB0aGlzIGZpeC4gUmVhbGx5IG5pY2UuIEJ1dCwgbWF5YmUsIHdlIHNob3VsZCBjaGVjayB0
aGUgbW91bnRfdGltZW91dA0KdmFsdWUuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5
a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
