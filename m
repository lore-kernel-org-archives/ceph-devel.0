Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37522E974D;
	Thu, 12 Mar 2026 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345168; cv=fail; b=YdhVTUH7Jsupj/gsdC4PVZ2Ny2PkTZELSlalaejjtrD7saa+98UE1Muv+ra5cSy1FWxVinGHaLU2V2rk67pbc7ldeIqYlSopIKs78f1YVgl/K6mOv0TK2QIp8Bq38oRLTdu/33+98jZJl2EfYPbschu6IZV/nhTz2bTpmls5arQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345168; c=relaxed/simple;
	bh=q61f0eQRFrEPkfbf0b1RpNsD02KOXD7c8j9hpIK9lhw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Nh9/IErPShyeA/cxscvneS5E0G4nmHQ6PyMdMGJAuo2W5255clsc0HSlj7VubFl9FLuKLDTEhHszGwZlHeR42+RiSPcdErn0MwE5diHVGYTwA7U6V3XYqK0OoYpu+PqGMmHGd6tJ3nAGGR/znpcfFGbpdnD7zo9u2CDWFJ6SbC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NIWTuOjG; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NIWTuOjG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CF1Ug12281597;
	Thu, 12 Mar 2026 19:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=q61f0eQRFrEPkfbf0b1RpNsD02KOXD7c8j9hpIK9lhw=; b=NIWTuOjG
	eRk/DFQN8aS2fvW1gT1mEGrCjlAj+17it+YITLrK7yRb2oKAsJio1aMD2ytgVqaT
	uAC//DxZUqBq29vpB7L3SmJOIS+h7Rs1/DHtPw/4u8KbCdPRj4GK59bZYwiHZ22/
	1SDKrUKBQqvgdsg83IPeZKoYNxMzi/34vJhuhLipPWWmLBHZpu4obCn3Bs7EXkHR
	wxOqsN5Tv/tB7mx5w6CHVx64TldFWOpeVJJ+VE/fyXp8Dq/kzBipsW+KBs13OqMb
	2gT7cmtgLzbVDg1VQEXSgwOSukUcfeZspwnpJvO3dmTdaAyn4QMxcFi8PiLV72mF
	OM2t69CfpiwRuw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91mkyg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:52:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+HKPdHpL3Ot68BLo21iPOTNDgpdeMwxu2xfrs6lilmmI1XrB6vQ6gUX/xQu8EozJ4I3Wrc5bM78RvUHUbY2wbKdfixgubHnZb73iPKeKshdpsI/6lqGEmVXc+8b6MfVKhdXKzuIM3JKPDv6Yc2wdaDaiVxfmwGfMxBgPWDCLI1E3ENwEJ1JdHYSwLVDui9EUD8rBfP707rS8247t5+CWNIFIe2T0mvlV0ZQRzrTS7be56n4cHpOe92IMyAI0fbSvyyTc9wvdV6Sgqbvy5ae+HDXtaMiAuWxIDwD7HQLPbaAqQuKHJUD6b3ybq920Z93NrbGS/7MtP+P4gHqS2JqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q61f0eQRFrEPkfbf0b1RpNsD02KOXD7c8j9hpIK9lhw=;
 b=a+a3nRqiJhJZd5mfQ7Y3qe7AVdGr9UUSBaE9hU/fme8uo1y2wiGVY1v06eTglOQ2NJHVN4iUz7+ND2bATopTIyrWq/fBbxCkPV3aWpPePMdSGJ0LUexudl5I+PEKkRvXSmQjf3leOvclZUwY+QfjXV3crZPX/cjcbXAhhRx5hCIDM62rOsVcaDJlb9WcBXDOrXwUDhNWyZjZvj3gbTd1DZqagtZYJoxDT2/1V0DbPJwQChZVGOg3wrfGxZwgW/ljHehtz3XWRFbPnnHtny2TS/STX9b4wjrNG6c2xS6xgg8bEyznm2+YBrZy+9FkNLionFx/OUDR+/IEcXGzXq7QTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5723.namprd15.prod.outlook.com (2603:10b6:8:145::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Thu, 12 Mar
 2026 19:52:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 19:52:40 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Thread-Topic: [EXTERNAL] [PATCH v1 07/13] ceph: add timeout to caps wait in
 __ceph_get_caps()
Thread-Index: AQHcsfkP1HtdTFbL5US6Mw+mJFEazLWrT52A
Date: Thu, 12 Mar 2026 19:52:40 +0000
Message-ID: <31e62d37bdd9a45047a49804c6b3fc6f512ff0e2.camel@ibm.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
	 <20260312081619.40854-8-ionut.nechita@windriver.com>
In-Reply-To: <20260312081619.40854-8-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5723:EE_
x-ms-office365-filtering-correlation-id: fc1e10d9-372b-4ca1-2ea8-08de8070eb57
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 13IBlBLu903AQ8MRs31TgBSpLakKeHh8xpg0U5H6XOB4lyGy6ZPk+3N9V+4ggfg/PtDwcYOqDWl0MGlc3W/qB2gO2qVBZ5tUYs1K8BKVF2fNTa9H9jydTspbOGWyhHh2VstjU5dmL6c/bc+OAFLKCATHhGfZiEG3v9MoJlv3B21TSqoRHtNImxtucRntr44YdWXZSp/oyvofaocTfr+VXgzjpb2mZBW6Yyx0XtHFJQWuWuqC2FGRXD8meSkBib3ZoRSzGm8UKdKI02GjCq9tSOe2CqmsptWGMiLg+INU6EsMsoYg/PTSxRJ0ZuGOOhnhNxIgNYAKNh0XglqHABAF3Bn08/OtYlHI3IrHxKMoblVMgtzs0pN9tXG9W2K2SHHg6GK2OPbwYzhz2JBbiTT6Y97qHzKfDiNt9WkkpXMd5yAU+2rhnqMsXyUKVH+UaKPteHaQAvf70uyw1zGS/uDhUm53c8MHbb7HY8pf688px3kOQp7StDuJOrsSL1unRhqdD+OuV07OZSr2DnGWZGOJFNDWuiKOEndnQcYSAYC5+/xHJ2SQ8QwXT6X0mFkus0erbOXnrsLNddyNtyhyrh0/c33/YZEljCaqwD+pKJ65boA2j+uJOod7IyobvjBzlZKbStASTaXRa+uqQu/teEw4WIjle1UmCODIJ0XLByXv/IKshuzK2kOny+9AcI6nkOP4kRWbfyeB2zz8RPVp7GSqmJg9zT9H+THsPdObx2EFOjqDMNnJUg42fPjsd1xlqbtI3cyrsioVTp3WBQF420MaGyZk7pYOoMEDsYpjxlZSao8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkdhRzMvNk5HQzFsdm1pellxNEhqL3p5U3VYbUlQRm10RWRWZ05GTWpwYmJl?=
 =?utf-8?B?Zkt0QTRrN0k2VjV6K2lJQ1FqaGRDTHpXVTE1SWNGSkNlNHhLdG16UTFZSmg1?=
 =?utf-8?B?bCs3S1BhZlBLanNiY0xZWkNFK1YwcmlKcGtCcFNPdEx6Z0N5ZUVmR0g1cExj?=
 =?utf-8?B?Z3FGZWVLYTkxM3hZVE9NYjdRUnB2cGZ0a0NRaWhPNW9CZDNoWGZKeW5ZMnIz?=
 =?utf-8?B?RGw0QXdxWEpNMUUrekdrNzVjRWpSRGNLSmF2UmhoMENrN1hWQ0tQRnJPQzR5?=
 =?utf-8?B?dGdLQS93aS9SMXhncENnNHQ1TzcwQ2E0dlg4ZUxaaE55NSsvazhIYTgrcjBz?=
 =?utf-8?B?VFVKTVlnN0ZQWndiWEcyK0FSWGNocDRpQkprWnZUdXlJY2xWcHhqeTZvSGM1?=
 =?utf-8?B?dTVpOWFZVktjMC9lQVlLVFB3U3dadytxWDRFRWgyb3hORnRTMU5KanYzOVcv?=
 =?utf-8?B?ajF3ZzE2NWdZMjREYnJ0ODU5dFYyNk44MHRJU2Z6US9ZYmQ1VzZCTGs3bnp0?=
 =?utf-8?B?Yi9qMk9VNEF2bTQxb0RBcUlzR3Jud0tSY0FIY0xjSXNiaGd2aUNaUllNZVFB?=
 =?utf-8?B?aEZzM1lUVlRMTU05anhXc2RvUGhDZThvcEQxd21TV210KzhWZW91M0VuVTRZ?=
 =?utf-8?B?ejlFb0hmOUx4cUhCOHg4VXBiWTRjblFUOVhZM2hDdW5PRVQzL0FGdmo0Z0NU?=
 =?utf-8?B?R3NTclVhVWkybk1RcWRFMURJcGlYN0ppdnUzYi9BaVlEUytxTHRQMWw2anRy?=
 =?utf-8?B?WU1PV1ZQUkhHOC9VZEpYT0R1UUc2eWtHYUxReGhzdy9nK0lUZ2RrRitWdnEx?=
 =?utf-8?B?eGl5UDlzTXFRUHQxMDh1dFRwbUJIWjVjWnlibkZvQ3VnVDEzamxGTm9BUEN1?=
 =?utf-8?B?MXI5WFBMMGRxOEJLVXNsQjdHczhQaGg2cEpSU3JmU0tWcGxwblZ3K1FzYnJs?=
 =?utf-8?B?OHhPc3FKek4ySjdBMmhUV2h4V2ZiSVdUZENqSjc4UEdtQS9HTUZqcS9yclVW?=
 =?utf-8?B?Q1BnQVd4UktEbnpDZHZpZUR1UWZubnAxbGZQRWE3dHBtSTNHNmx4dFhxUUJs?=
 =?utf-8?B?dVhTbDFuQ3NEbFNtNTkwZW1GR2hjK3J2VHN6aG92bDBSK3Juejl2L01Ec09E?=
 =?utf-8?B?SENKdVJGRzNwMkhUL1kwWW1SR0cvYWJKb3ZET1hKNWs2VkwrR3hUUjJXRzdS?=
 =?utf-8?B?WkpCbzFoZzJOaWlUSmFsMUJsVnFnTm9KZ3JmOGswVTRTZFFSaDZYZmNhdXVN?=
 =?utf-8?B?bjV1emttR1htdTAvaXg5eC83SXJGZE5IVHMzVy9RSnJ5SHRiMy9CaHVMMm52?=
 =?utf-8?B?L21tRmFtTUMzb3k2clNGeDVMdTRROVpscG5Zc1loTWZaM0NVby9LTVplYlJT?=
 =?utf-8?B?c08rUDNPbHhOWVBnSk56cVZ1L21zZk1LbFNYejdzc2IwVDNUT0p4Y2xaWTJx?=
 =?utf-8?B?RnZhdVQvbnRkeHRtM21NRnFpSzJjcUtOQ1k0MUZibFFIVFNEcDdhaU9uUlM5?=
 =?utf-8?B?S0dPc0ZTNkIwNUFuTzhUTnhNd0JaNDhyeGIzVnBXc2VxeExndkJLbmw3Vi9O?=
 =?utf-8?B?UEtodHBXaHUyWWtweHVGUzBLdTdBOWxPK0pUU2t4RjV5SFZaK1pmU2JhVDdH?=
 =?utf-8?B?dnJqemI1T1lmRGhiUDZVcWNSWUk4azNDKzdXRnV0NTRoR1prL2ZIbjBVSEdu?=
 =?utf-8?B?bFZyRVFMSTA0bFRBUW1VbW4vYVYzeGNuYUhpRTFicVhtU25FOHlCOFovcWdI?=
 =?utf-8?B?TXV4WDZvRDlZWU04dzdtSjBSSHN3MzZjRmttb0Ira2Q4Rno5bC9jUTY3b0N6?=
 =?utf-8?B?amVuem5lNDJxdjM5R2NMQnd3WlBxRTZzUktnVG9QRk1EcGROZzJoTkx4a2dz?=
 =?utf-8?B?Uzg5Zk5DS1phbnUyN3g0MTd1amViRU04ZjZweEc3cDh5a3hwWUgySWxrTXQ4?=
 =?utf-8?B?TW1id1FJV1NEV2JZVXplZXBIVkdsRzFRdGE3eE1PNHdmNUJ4ejlWaDRMUnox?=
 =?utf-8?B?bVczaHR4Z1dSS3U4RHZqUldZZ2o1NVVvM1o4ai82d3BMS3hJblJVbXRzNURj?=
 =?utf-8?B?bFkrR2wrUm5teVNRS3RXZ2JFYzNDT3UwSGlWMFpZRzZBWXZjMEdjbE1IOXlJ?=
 =?utf-8?B?UHc5aURwK1MyYmM1d3pjOXMxeENrOUwya0l1a2cwRkZSR3hLbWdUQ0twT3I2?=
 =?utf-8?B?ZUtIZDh6SE1zdjBCcmt5TFdyWWZ4UmtFMnFyd2lZUFVTWE1LdnlzTlp5aE5M?=
 =?utf-8?B?RURnT3FHZ24ybHQ3QXc1WTM4TTRjMHZKNFI0dTNSZVVmL09wcXlHamJCWWxQ?=
 =?utf-8?B?UFZSZG40WFdHazBlYU5VeVVrMnQzQkNVZ3VVU1lCR3paRFZVK0NyNWRwRVhU?=
 =?utf-8?Q?+hm6SDJxrKga83pDyzfBrrrkRphRpC9ekLAGz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE34520C9F004643B88F5797EEFCE377@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	udUImoMsrBBJ2XRcn4Hf2csAd1I48SA5NJX7wkzU7S2ka7HjQ1XfaAIy8F1IYUirh5zAAIv5jQOkzpFFIji+GpqBNL9FAx6Ym3s+tcGe1n1P0GxfjjcYdC/iz/wv/iEWZYkWKts00F5eW4tgGDjkut67VWkDCowJoZXjZiMCcJBpyDwKptbHWyuwEFV9kxDRqL7pDQT8OFxq6q0nM6VttbqWS7P2STOlduOV/HCchJIaXmiHjAPEOC4JhY70C0khY2kSPfmVJskV4ARmTw07N88F3d9LOdAise2UTiVvFxK6D46Ax3YToVarizcLctiitUyczbwi5V46Nn1afyovvw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1e10d9-372b-4ca1-2ea8-08de8070eb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 19:52:40.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvDp1jir3enCFFI7gMyCYqIZnvydO0m0pheK9jfpqEdJn6T6BlT0/3bye53gTLzYtnCeGwMTxJaSNzU8f2eaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5723
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: n5HoH5zA5BNqZXANTwtRg2bBqrU54UqM
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b3198c cx=c_pps
 a=tP1g6Cq6k527JP85+VkTLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=t7CeM3EgAAAA:8 a=pnJfRi5apI2Q2atXiq0A:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1OCBTYWx0ZWRfX3V8729H34zpt
 IhjE/8qB1xKVK63NbIQc9BcTboyK3cVaqJO1Q5mpoF+P9r10N+MI6xC6f8h3wquVKX3ncdWWbq3
 RFXSL4y6mEPxc/N0tFSW6nxeq8JTEX+HNmqNx9OdgxWVBa06ndPZQbk9dBDNIrt4h3cXbbpKqkV
 l01cGwWI8u+P28vz9cN3+NrVFMIvCjeGIyfVESREl2UKo155OlYxrkquuT7r5QZzESKLb0bw5PG
 x27NAnJirU0kQN8Ti6tBV6I1mD3QTlfEZq1IWZJlTmXZMbqwoLJctbfMbarsQlqRBVa9BW7p1ic
 ss4eAvKQMW0kgXY+l/RNVCxrCmlRR72+TLohP9lgCXuq4q5ZiblKEbhAVZ3517Jrz9AyGhF2u5f
 aXaGeJz5EfbR9QxA3YcnhQjz65yIJ98grrkXluYK89XjmXgPxzNUCnYzyv58G25gBuEvxFSHovv
 jNFJ+Jgx0pQkmuhLxVQ==
X-Proofpoint-ORIG-GUID: AgH8H-O-27z8YLdtf8FzGtD3B5pekZ6k
Subject: Re:  [PATCH v1 07/13] ceph: add timeout to caps wait in
 __ceph_get_caps()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120158

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE2ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gV2hlbiB3YWl0aW5nIGZvciBjYXBzIGluIF9fY2VwaF9nZXRfY2Fwcygp
LCB0aGUgY29kZSB1c2VzDQo+IHdhaXRfd29rZW4oKSB3aXRoIE1BWF9TQ0hFRFVMRV9USU1FT1VU
LCB3aGljaCBjYW4gYmxvY2sNCj4gaW5kZWZpbml0ZWx5IGlmIHRoZSBNRFMgaXMgdW5hdmFpbGFi
bGUgb3Igc2xvdyB0byBncmFudCBjYXBzDQo+IGR1cmluZyByZWNvbm5lY3Rpb24uDQo+IA0KPiBU
aGlzIGNhdXNlcyBodW5nIHRhc2sgd2FybmluZ3Mgd2hlbiBNRFMgZmFpbHMgb3ZlcjoNCj4gDQo+
ICAgSU5GTzogdGFzayBkZDoxMjM0NSBibG9ja2VkIGZvciBtb3JlIHRoYW4gMTIyIHNlY29uZHMu
DQo+ICAgQ2FsbCBUcmFjZToNCj4gICAgIF9fY2VwaF9nZXRfY2FwcysweC4uLg0KPiAgICAgY2Vw
aF93cml0ZV9pdGVyKzB4Li4uDQo+IA0KPiBEdXJpbmcgTURTIGZhaWxvdmVyLCBjYXBzIG1heSBi
ZSByZXZva2VkIG9yIGRlbGF5ZWQgd2hpbGUgdGhlDQo+IGNsaWVudCByZWNvbm5lY3RzLiBQcm9j
ZXNzZXMgd2FpdGluZyBmb3IgY2FwcyBibG9jayBpbmRlZmluaXRlbHksDQo+IGFsc28gaG9sZGlu
ZyBpX3J3c2VtIHdoaWNoIGJsb2NrcyBvdGhlciBJL08gb3BlcmF0aW9ucyBvbiB0aGUNCj4gc2Ft
ZSBpbm9kZSwgY2F1c2luZyBhIGNhc2NhZGUgb2YgYmxvY2tlZCBwcm9jZXNzZXMuDQo+IA0KPiBG
aXggdGhpcyBieSB1c2luZyB3YWl0X3dva2VuKCkgd2l0aCBtb3VudF90aW1lb3V0IGluc3RlYWQg
b2YNCj4gTUFYX1NDSEVEVUxFX1RJTUVPVVQuIE9uIHRpbWVvdXQsIHJldHVybiAtRVRJTUVET1VU
IHRvIGFsbG93DQo+IHRoZSBjYWxsZXIgdG8gaGFuZGxlIHRoZSBzaXR1YXRpb24gYXBwcm9wcmlh
dGVseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IElvbnV0IE5lY2hpdGEgPGlvbnV0Lm5lY2hpdGFA
d2luZHJpdmVyLmNvbT4NCj4gLS0tDQo+ICBmcy9jZXBoL2NhcHMuYyB8IDE2ICsrKysrKysrKysr
KysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9jYXBzLmMgYi9mcy9jZXBoL2NhcHMuYw0KPiBp
bmRleCBiZWQzNGZjMTFjOTE5Li5jODhlMTBhNjM0ZTVjIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBo
L2NhcHMuYw0KPiArKysgYi9mcy9jZXBoL2NhcHMuYw0KPiBAQCAtMzA1NSw3ICszMDU1LDEwIEBA
IGludCBfX2NlcGhfZ2V0X2NhcHMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGNlcGhfZmls
ZV9pbmZvICpmaSwgaW50IG5lZWQsDQo+ICB7DQo+ICAJc3RydWN0IGNlcGhfaW5vZGVfaW5mbyAq
Y2kgPSBjZXBoX2lub2RlKGlub2RlKTsNCj4gIAlzdHJ1Y3QgY2VwaF9mc19jbGllbnQgKmZzYyA9
IGNlcGhfaW5vZGVfdG9fZnNfY2xpZW50KGlub2RlKTsNCj4gKwlzdHJ1Y3QgY2VwaF9jbGllbnQg
KmNsID0gZnNjLT5jbGllbnQ7DQo+ICsJdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gY2VwaF90aW1l
b3V0X2ppZmZpZXMoY2wtPm9wdGlvbnMtPm1vdW50X3RpbWVvdXQpOw0KDQpUaGUgc2FtZSBjb25j
ZXJuIGFib3V0IHRpbWVvdXQgdmFsdWUuIDopDQoNCj4gIAlpbnQgcmV0LCBfZ290LCBmbGFnczsN
Cj4gKwlib29sIHdhcm5lZCA9IGZhbHNlOw0KDQpUZWNobmljYWxseSBzcGVha2luZywgeW91IGFy
ZSB0cnlpbmcgdG8gY3JlYXRlIHByX3dhcm5fb25jZV9jbGllbnQoKSBoZXJlLg0KUHJvYmFibHks
IHdlIG5lZWQgdG8gcHJlZmVyIHRoaXMgb25lIGluc3RlYWQgb2YgcHJfd2Fybl9yYXRlbGltaXRl
ZF9jbGllbnQoKS4NCkhvd2V2ZXIsIG1heWJlLCB3ZSBuZWVkIHRvIGhhdmUgZGVidWcgb3V0cHV0
IGluc3RlYWQuIFRoaXMgd2FybmVkIHZhcmlhYmxlDQpjb21wbGV0ZWx5IG5vdCBuZWNlc3Nhcnkg
aGVyZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gIA0KPiAgCXJldCA9IGNlcGhfcG9vbF9wZXJt
X2NoZWNrKGlub2RlLCBuZWVkKTsNCj4gIAlpZiAocmV0IDwgMCkNCj4gQEAgLTMxMDQsNyArMzEw
NywxOCBAQCBpbnQgX19jZXBoX2dldF9jYXBzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBj
ZXBoX2ZpbGVfaW5mbyAqZmksIGludCBuZWVkLA0KPiAgCQkJCQlyZXQgPSAtRVJFU1RBUlRTWVM7
DQo+ICAJCQkJCWJyZWFrOw0KPiAgCQkJCX0NCj4gLQkJCQl3YWl0X3dva2VuKCZ3YWl0LCBUQVNL
X0lOVEVSUlVQVElCTEUsIE1BWF9TQ0hFRFVMRV9USU1FT1VUKTsNCj4gKwkJCQlpZiAoIXdhaXRf
d29rZW4oJndhaXQsIFRBU0tfSU5URVJSVVBUSUJMRSwgdGltZW91dCkpIHsNCj4gKwkJCQkJaWYg
KCF3YXJuZWQpIHsNCj4gKwkJCQkJCXByX3dhcm5fcmF0ZWxpbWl0ZWRfY2xpZW50KGNsLA0KPiAr
CQkJCQkJCSIlcCAlbGx4LiVsbHggY2FwcyB3YWl0IHRpbWVkIG91dCAobmVlZCAlcyB3YW50ICVz
KVxuIiwNCj4gKwkJCQkJCQlpbm9kZSwgY2VwaF92aW5vcChpbm9kZSksDQo+ICsJCQkJCQkJY2Vw
aF9jYXBfc3RyaW5nKG5lZWQpLA0KPiArCQkJCQkJCWNlcGhfY2FwX3N0cmluZyh3YW50KSk7DQo+
ICsJCQkJCQl3YXJuZWQgPSB0cnVlOw0KPiArCQkJCQl9DQo+ICsJCQkJCXJldCA9IC1FVElNRURP
VVQ7DQo+ICsJCQkJCWJyZWFrOw0KPiArCQkJCX0NCj4gIAkJCX0NCj4gIA0KPiAgCQkJcmVtb3Zl
X3dhaXRfcXVldWUoJmNpLT5pX2NhcF93cSwgJndhaXQpOw0K
