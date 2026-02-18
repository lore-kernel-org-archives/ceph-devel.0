Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BE3491C2;
	Wed, 18 Feb 2026 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445211; cv=fail; b=HW5yz0K0mdkLcC0ngWSYkjxUd96o0J0F78CEE8d5ITl/2U3Jkx5K7IKS3rpRmPVwGNk8zM9nQD2AJiR/H0aHeVvopN0la+iEJxslZj8ZPyi9whaw0Ql2bCiyVvX2l+LHZRcuyFgYs3nP1DmILq0OJL92/pw/Pszt+tCqOiBSrZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445211; c=relaxed/simple;
	bh=qHRTFAjEX2SAK7d0m9dNnKGP8RARqO5qqJ7G96wvIF8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VHAFzSWyg5eQBaRQNnq6tE1FulxVfyeRsOC6yAevGR7pez63uMlkOYGfaIZYggkVlUfuBuZmpYvmrvPDh0WiklpyiefienmsHyMbsvHLqHUOydgmISXVZBwQr+h9dX4R4ku5faQ736RMFxlC317YU5+b5SmjGCYoKhmq24eYoDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k3GtboX2; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k3GtboX2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61II4xob2749445;
	Wed, 18 Feb 2026 20:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=qHRTFAjEX2SAK7d0m9dNnKGP8RARqO5qqJ7G96wvIF8=; b=k3GtboX2
	1cJD1XtmOrGvfAEIwh8Od7KKBYt4KeIa7t0FP8sXz7/WfoQJrSHQyMUI31pQFUyD
	ebXfT0Nm5Q+BY/0c+picJPwXnyKNVyf53V7azIeEUpNatYcvv7JIwLLpVKIHid58
	gwUuw5LfrzLXiSkRJEUUNIMBNeqyv1WtV6D6LOrSR6yDaDIQyYJafsFoULfb8q6g
	s+dK9Q23U8Y/ks6xtpLhnd1D4hMbJP5tSaRV7tpyzsgCTc5/HNZWDe2OoHQWk1yU
	NzHADxK/dDLB5K14eqoIH9a8RuB0UBsGq48e0zm65bIcmtnBsryYVYHhCNCjF0Ll
	I8jkevMbR6010g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4khv2c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 20:06:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCVC595Svi4miQ7QgygQjHNkhQ9FdUp4N6yq/tgTd/bU4RLyeYSeQK1s51wPzt9q0zz4MRhEDK6jk+jJ8IN8xBuluAQVWHvNtg+t0IEPUMpt2m4f6XgQNgOuzF4qXvbFpD32ubAfeZT+/y6SlL4UQqZub42U9AAc1lRREnSnIa0YHFpJJ6yQs30qrjdPiV3OaugWmGydAXcowA0LKPKwIkEh/+yxf4KRQiAtCVwrLuk1e044Q4UJCuE4NkcUzoFjYRGwOglul+tKHqxc6hYxohPIoMQZ5c6sJQcMkQnfF/crPms+vMcxqrRkU7WBnTHWpIv9Z9rBufHHhkpm+NODaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHRTFAjEX2SAK7d0m9dNnKGP8RARqO5qqJ7G96wvIF8=;
 b=oxQLS23GP7bVJ1d8uBtBYRN6eecIXoN25qYTIVkivO3XBUjYX0PgjfEk9frxPxrcibDrdfc0HC1Mrd6t8ywbzC8evh/L+Ck9iOectlofwZwNKvKN3RwReREc6aFjWvBMNnC1f0hzfS/qDN5a80WOOgpW+ywjdLESfPW42jogZOcpN+rQqeP3Ke+A+0ai7emkuVkYEPsZQ/Az/owqyZvgHV7xLOtYy+rQ3MwyeLuUCHmF/1y7bSqdy7q8mcrN4procp4b4JCSFf3hgyUx4GtIPIFt5X9DuDyPjLphacmAdslJVjOs6cXeJJVtZ3xsuoO8BbAOb9OtTxdOAN+a425gag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM6PR15MB3848.namprd15.prod.outlook.com (2603:10b6:5:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 20:06:43 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 20:06:43 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: add timeout protection to
 ceph_osdc_sync() path
Thread-Index: AQHcoQ/g1BymeXT240OLdLv6cReNT7WI4hIA
Date: Wed, 18 Feb 2026 20:06:43 +0000
Message-ID: <21c408e72e1b074368b21f89a4bad5119710f95b.camel@ibm.com>
References: <20260218194945.47707-2-ionut.nechita@windriver.com>
In-Reply-To: <20260218194945.47707-2-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM6PR15MB3848:EE_
x-ms-office365-filtering-correlation-id: 9aa3fecd-3874-4351-a12a-08de6f293c6d
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkprRm9obmRpTWY1SUtZcERlWVp1T2U2bVc1Z2xCVGt4SXBHL3J3Y0w3ZW9X?=
 =?utf-8?B?Z1EzdUJYcC9hclUvME5ZZGNOSHVSTG9US3ZsVDRUMVVuYmd0dUx0dDg2Tldj?=
 =?utf-8?B?K0R4dWtPTFRGZG42WnBoS3hUQjNnODNwdGQ5SzAveHFjbXBNK3FCc3hBYUY0?=
 =?utf-8?B?bFBGZ2dqOS90MnhaV1Zta3U5Z3gyaC9hUXI2R25oS2Nqalo3dCtYRVZpdys4?=
 =?utf-8?B?S3drVVBmZkNJUTZxOHFVcm9ydWdKS01xZjRBMmVpT0g4OE1sZHpoU1dGQ2s5?=
 =?utf-8?B?TjUwaG9ZaDRwcndFTU9KbGxQcDJNcE9NVnRldGl5TFdwL01ZUXhqYnVsbnpQ?=
 =?utf-8?B?TjdibnBIRUJZUWRPdG9ZcGhHejRvN3YzYlgwcTdDY1FkU1doeVFHUmJZZ0d2?=
 =?utf-8?B?ME5jRjRCVytqaVUwekFYWncrS2JZekVsRjRlRCsranZzOXhCbTdNMlNPSzQv?=
 =?utf-8?B?VXRkR05Cdy8wRnJqVWduVmszb2lCc3hPcnBmUE5hYUIzNkEvN2kzeHVncmI3?=
 =?utf-8?B?ZEs3R1h5UHZ0RGtqcklOU3J2YUtWZVFDSVB2bVBucDdLTWJSY3hnK3dZMFI5?=
 =?utf-8?B?cGZZREI2OEZCS3RmK2lJcFY2MXMzYitEY1VKL1RleVF6YlBOcERzRVlxclZ6?=
 =?utf-8?B?UWRLOWFhRlZQN1FiL0RseWdJZUtnS3pZWjFYZE1MbWpiQlVYZzZqR2RXR21M?=
 =?utf-8?B?NFFLeVAvQkU0WFFVNEpkNHp5SnRUcDdzSVpaVFJIN1VoVkZ2T3MvL2J3dUE2?=
 =?utf-8?B?RXBxRWJ6VkhwdUFTMWJMbWhadWRpWmczbi92OE1RMENRbld0ajgrTFNEN1dX?=
 =?utf-8?B?dUUzek5vWXZUdVZCQlBpdkdHRmJkZ05JWHdLZUFPbGZyMHZsUHJOOFZIU1E0?=
 =?utf-8?B?SGZtMEZZYS90VWROSkZibjFXbG1yNDFnTXRXMUFwQmIrMGUrZzRtNmkwUFdQ?=
 =?utf-8?B?YnhjTG9JZmFCQkRXN3pCRVVVUU9Qbnl2M2xWUGZKUHRPeVN6SlNZZ0p5TFFV?=
 =?utf-8?B?eVF0WUFvSzNQRDVIZ0xsK1JpQnpMWGFNQ0kyU1cyZTlaOTZnN0xvd292RmFC?=
 =?utf-8?B?TytSVjNTb0x0ejBScjM2cVgvam5QZElxYjRpTm5CRTVRYmFIZnk1eTFERE9J?=
 =?utf-8?B?WG94V0NjZjBhK2ZuTFlzYjVVVkZKc1lIcU1UbDN2YUVhcDFBbFAvUGJyQjZo?=
 =?utf-8?B?Y1VBc0hZUk9Td1d3WmdYMFkxK2VuQnA1TTlyTGlTemtDb2RRMndqeWYyMWRB?=
 =?utf-8?B?OTZOa0pMRWRtNWpaV1hJRkwzZGVvUktjTnp2OWNSc1BBRkp1azFtdHFWcU5Z?=
 =?utf-8?B?ZW1ySUs2WFJhTkxlWTl1UHk2c2JiWklvUXVFSUMwV1FEakd2aTlrMUhkZDZk?=
 =?utf-8?B?clFOcHAwTURDdUdqckx6QlJHcXJnL2ZBT1QyRmgyY0s1MFVZdm9TRnVNbVJu?=
 =?utf-8?B?R2w0clREdTc2UTFxNmJxL2g1cEJTQmlLcmZPbU43azVJWXdPUjhVMTBXanls?=
 =?utf-8?B?WWZwdlpCMTE3aFFEY1hpWDBnNUl0ZlBEY0lLcHFpcml3Z3NEOUpvclBlai9R?=
 =?utf-8?B?SXBsTUNpYmovc0tYcjlhbmpWV0FSWU1mTWtZRUh0eWFBbnZQVUdYZnZuMkdH?=
 =?utf-8?B?eVJWYU95WWM5bUxIc0NFeDBiRG5PdFpNK0VyTTZBZWFZMC9MSmZiRytIL2d2?=
 =?utf-8?B?cTZGWC82dzR5Z2FPcVZndVhiOUEyb21nWDc2OW5kVFhoSEZ1clZobGZpd3gy?=
 =?utf-8?B?VmplRW42RG1HWVFIVm1zSkFMUzJ3ZWFPVkFvS2dQV0lzY3I1Zm16WmhnNEs5?=
 =?utf-8?B?M3R5b1NzZklFOUpxaFZSYmxGZzFNKzVGU2R2UnZOZFB3c3VHL2NPWHFrUFNC?=
 =?utf-8?B?QndFeG9Nb0ViQzBiQVZiS0wrNS9IenRrOExBTzJQMmE2dGcvOVFhd3FwSGpM?=
 =?utf-8?B?TjFXdmMrd1crUG9vR1RKSzI2N3VWTmgxZjlPdGpWVHNFYllVWnRUb2xjODJU?=
 =?utf-8?B?T29SSFM2Z1poMytlSnBCVUVDdWhkbFNmTm94aDRGcmpINkh4ZExGVnhoQ0dq?=
 =?utf-8?B?bHRTdDVHZ2kxT0NnUGNPbTVLZnBsRHNpZitWY1RHSnZwbGhKaGNWSmRWT29G?=
 =?utf-8?B?d24xNkwwYnV6a3U1VEkxRkdsSWJxZFNPRS9Ja3I5ZXpLV3V6ekUySUF4Qm5E?=
 =?utf-8?Q?TXTPrea98XjMYmBKys6E8hk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmIya0xJV3VMUnZOc3dKWEZVbjA4KzNGeE40VW1YdTdYbDVRaVl2RUVWOVQx?=
 =?utf-8?B?bVhYZE5acXdaRmg5NGorZlpuWWd5Zm1HVVZjRnRBMmFTL2pvTkdxaEZ2M20y?=
 =?utf-8?B?bFFIU0dIanVwQ25wQ3JPSnlMR2hlT3hOTFo2Q0g0d3BqUkJ1VVVOdllzMkRk?=
 =?utf-8?B?WWd0dnU3bTZnRDFpOWNVS3NHT3FoTVA3WWNPc1Y1NGp5MGFtTkgySDl3eUZQ?=
 =?utf-8?B?cTZjVDJOME5NVjFZalcrZkhUNVE2L2dRVEVqTlRDSTh0Q0lXejZZWWd6bGdF?=
 =?utf-8?B?SC9FNFlOZERpaHgvZng4RitFTDY5ZkpzZmNNVTR1TnNRakVReUpVWWl0S2VP?=
 =?utf-8?B?U3hCckV5QTgxV0FwWFp0MWw3UUVSSVdxaHlvK0hqRnVtZm1aam5NeC9hU0dZ?=
 =?utf-8?B?TTRLNEhVcStoc2NIR2NLNkJ2WHRMeUVxbGJRVHg4WWNqVElkUDgyM1I4OWgz?=
 =?utf-8?B?a3daTFNPYVQyMDc0WmtzU2ZiUUlLMGMwTDVBWW5LUGNhVktXeG5QN2dxUkZh?=
 =?utf-8?B?NHhMWXFhNzU0QVpTd1FsZG83dWlmdHlzOGtLMHk2Q21FQlBla3owYWZCZmpi?=
 =?utf-8?B?ZU51MWtxSWFLaDZGRHdqS2JPcVNJMlpER3NScE1PVkxkMVZJSmg1dE1aKzcr?=
 =?utf-8?B?NlptYURnRUMyZmV2emR6RHBudDhnVkZZZUJSNXAxZmhkc1ZsS0xLbXZ1UmFu?=
 =?utf-8?B?S2wveklVQms0Tkd6WVA3NXNhTnB3a2EySHhrWk9aQ1YyVU0rTlNmOVJoWGNt?=
 =?utf-8?B?dWJ0WWpWTVpuaVgyRzNNMHh3QjFsenlYZ3FTVm9NZjhkMVlxdzRqeGdvSVJO?=
 =?utf-8?B?N2g0S08wOWdlZW5BL0NxQ1NxOGdDeW5LV2VyTS90SHFGY3BKRy9xRUxhWnRn?=
 =?utf-8?B?T2d4WlF5UGJGWXN6SkRwWEYxenhIdGJxSnlZcE8vdHRMK3dTRHowOVFjNDYr?=
 =?utf-8?B?WFRuUHNNK3JsNmxFZzUxMGZ4VFF3cEljZlB3Z2FYeXEzTHFCajd5MytuOFlB?=
 =?utf-8?B?a0RiWjloTi9sTERDOTUwdUptRzh2SnowUDYxdEVrKzd2RGJuRWxoQUJlUXJ3?=
 =?utf-8?B?WEF4RW14NFhFLzFkaG9IRHZtaXZyNlV0dWErU1E1OTVtRVdlOGNrL3FqNkFt?=
 =?utf-8?B?dTdRYzNDYmhlSEJCam5xYWJxOSs2ejJHZkprNHJjNmYzSWhVMmpXYnV3WDFk?=
 =?utf-8?B?VndzVkJSdzUxUEtNWHBaMGdvSHFxS2ZITzBzOTBMRFFxbzVpVStOSWFGQ0k4?=
 =?utf-8?B?alZUT3VPS3JvU3lZMmtBalNvQVFhZDZzL2h3VGV0UjA1VEl1VXBLcVlqZyta?=
 =?utf-8?B?VmFKeFhGY2FVRVVFSS9vaFlYYXNSc1dBbFRoUkltQ0p0cFBPRnU3K2FNS2FD?=
 =?utf-8?B?VWlhcHl3VFN5NEFudTRxRzZHemU5eDZIcENDbm4vOWJGNTIra2hHZDhRWHJK?=
 =?utf-8?B?Y3JGVzNaOXlncjg1L3ExcTV3MllRVmEyUVQrMFdiN3JnZElSZmt2M1ZxYWNP?=
 =?utf-8?B?aXNCRUhvWHk3S1FjL0l4MlV4QmdJNGt6N1JLZWYyNlhKbzNRQ0N0RUJjWFE4?=
 =?utf-8?B?dlZUQ2g1Wlp2L04zNGEzckhlRFdKcDdPVGcvdUlTSEE2ZHBFaWF2cGdYL1BG?=
 =?utf-8?B?RHpSRGVFVytQQjg3eGJmR1pTK09sSnNveUkxbWgrZGhiRHFSVFBSUkJrT3FE?=
 =?utf-8?B?QzhEbVE1Q01UVHFmREZpeDlzd0R0VlZOVHpZSEY1VmU2dDdBWWhaNzRaYmdW?=
 =?utf-8?B?cEtQR2JmQjlia2VXMEJ0ZzNBVXpONURDZEJ6WThDMXY2UXBNeTNDSU81TWt5?=
 =?utf-8?B?OFZ0a1pzUHl2M2pzMlNJNTFVa1JpRExVYkMvT25ucVB0UWovLzlXaVBKaits?=
 =?utf-8?B?MG1CZk1jcEtqRm1SR2M3c1pWbzJ5WnZBL3dCNGlLa3h1Q3hXODNXYncrajV4?=
 =?utf-8?B?NGZzbXd4TUdDWVI2eXR3dWZrdGU5WGI2SC9lQjNqQWlaTWhFcG12WFBZckhN?=
 =?utf-8?B?d3kvTTlmZHM3eFpEOXdJYldiVXRIUVNjTTJJVGRrZzJ3QSthTldyUjAyM0p1?=
 =?utf-8?B?YnkzZzVlampReGJzR04yZFA3cWZSakNhWHRKWGoySlpiQ2cwcU01ZjFyYy9P?=
 =?utf-8?B?U25BWWlXMVJVYkw0U2drSG5jbVhybzdrak1UaU8rTndIWVpLSlJRS3B5eldR?=
 =?utf-8?B?citYWjB4SHdYOW5SZzRPZWlLQVgzTE04OHc0UVVlcTJIUDdaSE9hcEZ6dERN?=
 =?utf-8?B?UHFsMWFKMnU2RmhpQ1Y2VDMvNWNtNk01VHAzb1MrcEhPNnZVVFZpVmk2ZFJE?=
 =?utf-8?B?MHk2bW85dXFQTkluczcrLytyZUVGSXlzU2xIRWd1Vi9Hd2NCektmai9HRWo2?=
 =?utf-8?Q?zW7CHaoime4XTJVN6sOxfIfp477cmpXsZrDpT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA7C18F20C1634488F51C081F4458220@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa3fecd-3874-4351-a12a-08de6f293c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 20:06:43.1176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWOYFSGgNw5Hj2bDWyDeUp+0odCIzmHy+UdAfxZZ2wzoCu1murR618LpIgDpEtsE40MdSsboQ5odEuu+o4C4OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3848
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE2NyBTYWx0ZWRfX1K1poakPq1C5
 dfMNxHPbCKUpfKlwX+Lu/ImVx4qtF6C9Kvx6ctUhhds9eLzWBR0GTUfclHDiK8FG/l/5zVI/cMt
 i+JS++2pg89F9xLdNpbLH8vdRmtQ8YyXQvWB12YSTNTg3WRvEm8E6riZTclNzaQmnjTACTf8pQ2
 2Cbl3EYnMoumbHm+HmqMm9qYrpS5oLn+GhxAikPFWXREn6VeORb0sQJrvr98zrBai/6X6g1v6bV
 AFzbeT1X7IjM3MNuS3hVthsTzcSjMtwkN6Xk90UrL0FUozbYR0/Biyi5zV4Kh/Dzh+cLWIg8opO
 kuU38oQWNyIXXNtxeqbvfWgHi6NRfF0ZR9F/M90ns3DJfsT3vT9KzfavIVPnPbls5uF4UVjt1Z4
 EneoymR9q31LDvb6g24A3Rcb6SDPLkExFB+RYzSumeTWw3UbIEyxixzYmZk5krSm22nKUsN2d27
 4S3CBs/cMBW47JuqLgw==
X-Proofpoint-ORIG-GUID: n9Xqup9BnajkcKtawn9c7WL9qb5nPJpP
X-Proofpoint-GUID: 6GBgoDI3huVfAlFZgdMFiCCPswwCwf4u
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69961bd7 cx=c_pps
 a=JigUrrSO7vm3KiUpdjzzBg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8 a=FeZ2cnvEVFr8odVMoEYA:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
Subject: Re:  [PATCH] ceph: add timeout protection to ceph_osdc_sync() path
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180167

T24gV2VkLCAyMDI2LTAyLTE4IGF0IDIxOjQ5ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gV2hlbiBhIENlcGggT1NEIGJlY29tZXMgdW5yZWFjaGFibGUgKGUuZy4s
IGR1ZSB0byBJUHY2IEVBRERSTk9UQVZBSUwNCj4gZHVyaW5nIERBRCBvciBuZXR3b3JrIHRyYW5z
aXRpb25zKSwgdGhlIHN5bmMgc3lzY2FsbCBjYW4gYmxvY2sNCj4gaW5kZWZpbml0ZWx5IGluIGNl
cGhfb3NkY19zeW5jKCkuIFRoaXMgZnVuY3Rpb24gaXRlcmF0ZXMgb3ZlciBhbGwNCj4gaW4tZmxp
Z2h0IHdyaXRlIHJlcXVlc3RzIGFuZCBjYWxscyB3YWl0X2Zvcl9jb21wbGV0aW9uKCkgd2l0aCBu
bw0KPiB0aW1lb3V0IG9uIGVhY2ggb25lLiBUaGUgaHVuZ190YXNrIGRldGVjdG9yIGZpcmVzIHJl
cGVhdGVkbHkgd2l0aA0KPiBzdGFjayB0cmFjZXMgc2hvd2luZzoNCj4gDQo+ICAgY2VwaF9vc2Rj
X3N5bmMgW2xpYmNlcGhdDQo+ICAgY2VwaF9zeW5jX2ZzIFtjZXBoXQ0KPiAgIGl0ZXJhdGVfc3Vw
ZXJzDQo+ICAga3N5c19zeW5jDQo+IA0KPiBTaW5jZSBjZXBoX29zZGNfc3luYygpIGlzIGNhbGxl
ZCBiZWZvcmUgY2VwaF9tZHNjX3N5bmMoKSBpbg0KPiBjZXBoX3N5bmNfZnMoKSwgYW4gT1NEIGhh
bmcgcHJldmVudHMgdGhlIE1EUyB0aW1lb3V0IHByb3RlY3Rpb24NCj4gZnJvbSBjb21taXQgZTc4
OWU1MjUyZmRhICgiY2VwaDogYWRkIHRpbWVvdXQgcHJvdGVjdGlvbiB0bw0KPiBjZXBoX21kc2Nf
c3luYygpIHBhdGgiKSBmcm9tIGV2ZXIgYmVpbmcgcmVhY2hlZC4NCj4gDQo+IFRoaXMgaXMgcGFy
dGljdWxhcmx5IHByb2JsZW1hdGljIGluIEt1YmVybmV0ZXMgZW52aXJvbm1lbnRzIHdpdGgNCj4g
UFJFRU1QVF9SVCBrZXJuZWxzIHdoZXJlIENlcGggc3RvcmFnZSBwb2RzIHVuZGVyZ28gcm9sbGlu
ZyB1cGRhdGVzDQo+IGFuZCBJUHY2IG5ldHdvcmsgcmVjb25maWd1cmF0aW9ucyBjYXVzZSB0ZW1w
b3JhcnkgT1NEIHVuYXZhaWxhYmlsaXR5Lg0KPiANCj4gRml4IHRoaXMgYnkgYWRkaW5nIG1vdW50
X3RpbWVvdXQtYmFzZWQgdGltZW91dCB0byB0aGUgYmxvY2tpbmcgd2FpdCwNCj4gZm9sbG93aW5n
IHRoZSBleGlzdGluZyBwYXR0ZXJuIHVzZWQgYnkgd2FpdF9yZXF1ZXN0X3RpbWVvdXQoKSBpbiB0
aGUNCj4gc2FtZSBmaWxlOg0KPiANCj4gLSBjZXBoX29zZGNfc3luYygpOiB1c2Ugd2FpdF9mb3Jf
Y29tcGxldGlvbl90aW1lb3V0KCkgd2l0aA0KPiAgIG1vdW50X3RpbWVvdXQgaW5zdGVhZCBvZiBp
bmRlZmluaXRlIHdhaXRfZm9yX2NvbXBsZXRpb24oKQ0KPiAtIENoYW5nZSByZXR1cm4gdHlwZSBm
cm9tIHZvaWQgdG8gaW50LCByZXR1cm4gLUVUSU1FRE9VVCBvbiB0aW1lb3V0DQo+IC0gY2VwaF9z
eW5jX2ZzKCk6IHByb3BhZ2F0ZSBPU0Qgc3luYyBlcnJvciwgc2hvcnQtY2lyY3VpdCBiZWZvcmUN
Cj4gICBNRFMgc3luYyBvbiBmYWlsdXJlDQo+IA0KPiBPbiB0aW1lb3V0LCBwZW5kaW5nIE9TRCBy
ZXF1ZXN0cyBhcmUgTk9UIGNhbmNlbGxlZCAtIHRoZXkgcmVtYWluDQo+IGluLWZsaWdodCBhbmQg
Y29tcGxldGUgd2hlbiB0aGUgT1NEIHJlY29ubmVjdHMuIFRoZSB0aW1lb3V0IHNpbXBseQ0KPiB1
bmJsb2NrcyB0aGUgY2FsbGluZyB0YXNrLiBJZiBtb3VudF90aW1lb3V0IGlzIHNldCB0byAwLA0K
PiBjZXBoX3RpbWVvdXRfamlmZmllcygpIHJldHVybnMgTUFYX1NDSEVEVUxFX1RJTUVPVVQsIHBy
ZXNlcnZpbmcgdGhlDQo+IG9yaWdpbmFsIGluZmluaXRlLXdhaXQgYmVoYXZpb3IuDQoNCkkgYW0g
c3RpbGwgbm90IGNvbXBsZXRlbHkgY29udmluY2VkIHRoYXQgYWRkaW5nIHRpbWVvdXQgaXMgdGhl
IHByb3BlciBmaXguDQpQcm9iYWJseSwgd2UgaGF2ZSBzb21lIHJhY2UgY29uZGl0aW9uIGluIHRo
ZSBjb2RlIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQuIEkNCnN1c3BlY3QgdGhhdCBzdWdnZXN0ZWQg
c29sdXRpb24gbG9va3MgbGlrZSB3b3JrYXJvdW5kIHRoYXQgaGlkaW5nIHRoZSBpc3N1ZQ0Kc29t
ZWhvdy4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IElvbnV0IE5l
Y2hpdGEgPGlvbnV0Lm5lY2hpdGFAd2luZHJpdmVyLmNvbT4NCj4gLS0tDQo+ICBmcy9jZXBoL3N1
cGVyLmMgICAgICAgICAgICAgICAgIHwgIDQgKysrLQ0KPiAgaW5jbHVkZS9saW51eC9jZXBoL29z
ZF9jbGllbnQuaCB8ICAyICstDQo+ICBuZXQvY2VwaC9vc2RfY2xpZW50LmMgICAgICAgICAgIHwg
MTUgKysrKysrKysrKysrKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9zdXBlci5jIGIvZnMv
Y2VwaC9zdXBlci5jDQo+IGluZGV4IDAwZDQxNWFmOTY4MC4uZjVmZjhmNTA1Zjg1IDEwMDY0NA0K
PiAtLS0gYS9mcy9jZXBoL3N1cGVyLmMNCj4gKysrIGIvZnMvY2VwaC9zdXBlci5jDQo+IEBAIC0x
MzMsNyArMTMzLDkgQEAgc3RhdGljIGludCBjZXBoX3N5bmNfZnMoc3RydWN0IHN1cGVyX2Jsb2Nr
ICpzYiwgaW50IHdhaXQpDQo+ICAJfQ0KPiAgDQo+ICAJZG91dGMoY2wsICIoYmxvY2tpbmcpXG4i
KTsNCj4gLQljZXBoX29zZGNfc3luYygmZnNjLT5jbGllbnQtPm9zZGMpOw0KPiArCXJldCA9IGNl
cGhfb3NkY19zeW5jKCZmc2MtPmNsaWVudC0+b3NkYyk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0
dXJuIHJldDsNCj4gIAlyZXQgPSBjZXBoX21kc2Nfc3luYyhmc2MtPm1kc2MpOw0KPiAgCWRvdXRj
KGNsLCAiKGJsb2NraW5nKSBkb25lXG4iKTsNCj4gIAlyZXR1cm4gcmV0Ow0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9jZXBoL29zZF9jbGllbnQuaCBiL2luY2x1ZGUvbGludXgvY2VwaC9v
c2RfY2xpZW50LmgNCj4gaW5kZXggZDc5NDE0NzgxNThjLi44NzE4MjdlMmRkOTggMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvY2VwaC9vc2RfY2xpZW50LmgNCj4gKysrIGIvaW5jbHVkZS9s
aW51eC9jZXBoL29zZF9jbGllbnQuaA0KPiBAQCAtNTg3LDcgKzU4Nyw3IEBAIHZvaWQgY2VwaF9v
c2RjX3N0YXJ0X3JlcXVlc3Qoc3RydWN0IGNlcGhfb3NkX2NsaWVudCAqb3NkYywNCj4gIGV4dGVy
biB2b2lkIGNlcGhfb3NkY19jYW5jZWxfcmVxdWVzdChzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAq
cmVxKTsNCj4gIGV4dGVybiBpbnQgY2VwaF9vc2RjX3dhaXRfcmVxdWVzdChzdHJ1Y3QgY2VwaF9v
c2RfY2xpZW50ICpvc2RjLA0KPiAgCQkJCSAgc3RydWN0IGNlcGhfb3NkX3JlcXVlc3QgKnJlcSk7
DQo+IC1leHRlcm4gdm9pZCBjZXBoX29zZGNfc3luYyhzdHJ1Y3QgY2VwaF9vc2RfY2xpZW50ICpv
c2RjKTsNCj4gK2V4dGVybiBpbnQgY2VwaF9vc2RjX3N5bmMoc3RydWN0IGNlcGhfb3NkX2NsaWVu
dCAqb3NkYyk7DQo+ICANCj4gIGV4dGVybiB2b2lkIGNlcGhfb3NkY19mbHVzaF9ub3RpZmllcyhz
dHJ1Y3QgY2VwaF9vc2RfY2xpZW50ICpvc2RjKTsNCj4gIHZvaWQgY2VwaF9vc2RjX21heWJlX3Jl
cXVlc3RfbWFwKHN0cnVjdCBjZXBoX29zZF9jbGllbnQgKm9zZGMpOw0KPiBkaWZmIC0tZ2l0IGEv
bmV0L2NlcGgvb3NkX2NsaWVudC5jIGIvbmV0L2NlcGgvb3NkX2NsaWVudC5jDQo+IGluZGV4IDJm
MWM0NjFlMGZmYy4uNjdmOTk1NzlhZDBjIDEwMDY0NA0KPiAtLS0gYS9uZXQvY2VwaC9vc2RfY2xp
ZW50LmMNCj4gKysrIGIvbmV0L2NlcGgvb3NkX2NsaWVudC5jDQo+IEBAIC00NzQ0LDEwICs0NzQ0
LDEzIEBAIEVYUE9SVF9TWU1CT0woY2VwaF9vc2RjX3dhaXRfcmVxdWVzdCk7DQo+ICAvKg0KPiAg
ICogc3luYyAtIHdhaXQgZm9yIGFsbCBpbi1mbGlnaHQgcmVxdWVzdHMgdG8gZmx1c2guICBhdm9p
ZCBzdGFydmF0aW9uLg0KPiAgICovDQo+IC12b2lkIGNlcGhfb3NkY19zeW5jKHN0cnVjdCBjZXBo
X29zZF9jbGllbnQgKm9zZGMpDQo+ICtpbnQgY2VwaF9vc2RjX3N5bmMoc3RydWN0IGNlcGhfb3Nk
X2NsaWVudCAqb3NkYykNCj4gIHsNCj4gKwlzdHJ1Y3QgY2VwaF9vcHRpb25zICpvcHRzID0gb3Nk
Yy0+Y2xpZW50LT5vcHRpb25zOw0KPiArCXVuc2lnbmVkIGxvbmcgdGltZW91dCA9IGNlcGhfdGlt
ZW91dF9qaWZmaWVzKG9wdHMtPm1vdW50X3RpbWVvdXQpOw0KPiAgCXN0cnVjdCByYl9ub2RlICpu
LCAqcDsNCj4gIAl1NjQgbGFzdF90aWQgPSBhdG9taWM2NF9yZWFkKCZvc2RjLT5sYXN0X3RpZCk7
DQo+ICsJdW5zaWduZWQgbG9uZyBsZWZ0Ow0KPiAgDQo+ICBhZ2FpbjoNCj4gIAlkb3duX3JlYWQo
Jm9zZGMtPmxvY2spOw0KPiBAQCAtNDc3MCw3ICs0NzczLDE0IEBAIHZvaWQgY2VwaF9vc2RjX3N5
bmMoc3RydWN0IGNlcGhfb3NkX2NsaWVudCAqb3NkYykNCj4gIAkJCXVwX3JlYWQoJm9zZGMtPmxv
Y2spOw0KPiAgCQkJZG91dCgiJXMgd2FpdGluZyBvbiByZXEgJXAgdGlkICVsbHUgbGFzdF90aWQg
JWxsdVxuIiwNCj4gIAkJCSAgICAgX19mdW5jX18sIHJlcSwgcmVxLT5yX3RpZCwgbGFzdF90aWQp
Ow0KPiAtCQkJd2FpdF9mb3JfY29tcGxldGlvbigmcmVxLT5yX2NvbXBsZXRpb24pOw0KPiArCQkJ
bGVmdCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmcmVxLT5yX2NvbXBsZXRpb24sDQo+
ICsJCQkJCQkJICAgdGltZW91dCk7DQo+ICsJCQlpZiAoIWxlZnQpIHsNCj4gKwkJCQlwcl93YXJu
KCJjZXBoOiBvc2Qgc3luYyByZXF1ZXN0IHRpZCAlbGx1IHRpbWVkIG91dFxuIiwNCj4gKwkJCQkJ
cmVxLT5yX3RpZCk7DQo+ICsJCQkJY2VwaF9vc2RjX3B1dF9yZXF1ZXN0KHJlcSk7DQo+ICsJCQkJ
cmV0dXJuIC1FVElNRURPVVQ7DQo+ICsJCQl9DQo+ICAJCQljZXBoX29zZGNfcHV0X3JlcXVlc3Qo
cmVxKTsNCj4gIAkJCWdvdG8gYWdhaW47DQo+ICAJCX0NCj4gQEAgLTQ3ODAsNiArNDc5MCw3IEBA
IHZvaWQgY2VwaF9vc2RjX3N5bmMoc3RydWN0IGNlcGhfb3NkX2NsaWVudCAqb3NkYykNCj4gIA0K
PiAgCXVwX3JlYWQoJm9zZGMtPmxvY2spOw0KPiAgCWRvdXQoIiVzIGRvbmUgbGFzdF90aWQgJWxs
dVxuIiwgX19mdW5jX18sIGxhc3RfdGlkKTsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gIEVYUE9S
VF9TWU1CT0woY2VwaF9vc2RjX3N5bmMpOw0KPiAgDQo=
