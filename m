Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBB313550;
	Fri, 24 Apr 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055520; cv=fail; b=d9Z8cpXPZAHmXfBD6wQnzSaZC1CzxCdRLLvMSnsxDajiobt9AEkseMHBWubb2Jy4dOBZaJhD6qtrW/A5+LlXiTI+0uWB+2PMpD/8+3YMWon5XTRXjDU1WzMer+sm9wSLYI/jPyD3sJV3XAsSo9tnz90S/lU4/jJo/XWFr1g3g14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055520; c=relaxed/simple;
	bh=Ak6P49Xps9x0orFS9XyzM0kuGFCkCWfIZUoCr4+4TVU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qDoN/Ln3o7b0eXIa1hGSIMItL7MXw8SH4z+MkqHEUsDjRROpj8gFYI13GHQLEtCameMr4BtuzsjIdqBUX1PS+ibdLv1DXcc8qJ4rpfBdsyxaYqG70NAkXe/4TteUcxoumIsv8zw/uaQbwqeqhdTpL8sL38pxN2OrbMXp/jsXAY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FV3mEk8S; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FV3mEk8S"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OCxRjg3515292;
	Fri, 24 Apr 2026 18:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Ak6P49Xps9x0orFS9XyzM0kuGFCkCWfIZUoCr4+4TVU=; b=FV3mEk8S
	3AlWR7+zgIJgmFvv8lw+oOdyRvZCIqy75fCNhMiALzYx+paktFzkgtyaLp0z73vS
	twOim3P6cgZ/3fqHfCq7hz20HOCa3+X/E86CQS6j/610o3LBn8+RiM4DHRh0yTWn
	2ofHyUoLBYhEyQlBIQNDFlnW72kIuqXyMkuumb/Sxv2S/tnVGo5L2ARKAp/9hfA2
	7fhzC2YU80LPknwJ9XHaTT+VLxZ/aBWMTskCF3S0ogZw8aKhA2QHADU9ckLE4yXX
	/tzZtS4djcNr/VBceOEC1ZvTKj6ZFouaLMWQ8J9FB7jwRg+yZtIOAD2/F65osGFB
	XmR9Gj6ABQgUBA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2fc6b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 18:31:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7T+G2D/B+EojrSJhGKuWXyH82q3W2jj9AxzJaFi/BCzNHdPkEYtE6nMv0y4XHBfpT2JhywN8Voee6HpVGTdEgOvIVGTM9C2j5r7rqOLV4OnXhckFRcS3HmdDVJYLUEyf3dShtOXGpTbz0zQlN/6vTLJyVyLmFCOwMt1yZ438+YPeB2k8yNrAM6VKdcZhx5P3RyaFP+BzzlqshTEyp75OUyU6w3964oVtsG74K3fCiAuG3B+z+qy7iyGCOBih9kHpt+slEAZztOq486t+maV0N0PjiVPkLIfg/2TwZU1fYw5VDe9n4m7/izE+HIGgi0FK1n17KncJ6LhrzU95RyROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak6P49Xps9x0orFS9XyzM0kuGFCkCWfIZUoCr4+4TVU=;
 b=nLOeExSecJ2t5vtJCZc+F9U9J+d/QFB18KobTRxvJCuDyKTVGWMR563ZzkLkAgK15juUWv24hSSJu5/Lf1vIZPGoXZS0FNq4EERPkDs/N+xEt4SI2rMmOAzHMFUDT96ic7N3w6Yfv8lKZw28mxJKZ7CffGfQegWbWwpi8ySLGiW1VATYDmA83mWL3wL/l+L9sTOmiCKG9ytqNpGIXPTUM29aOuq2ApXHm3tSpHKdS6WhZGCMF3EhZpcbiulYZ/rNu37P7PZOGUOrN4xYX90lvmpPp9j/yNtlIiNfYaf/6VNVbU7b4KW4UYylNSn8ueaSxkkzduxfDwcFdGrGKT7LpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV8PR15MB6509.namprd15.prod.outlook.com (2603:10b6:408:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 18:31:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 18:31:39 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "luis@igalia.com" <luis@igalia.com>, Xiubo Li <xiubli@redhat.com>,
        "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] ceph: bound encrypted snapshot suffix
 formatting
Thread-Index: AQHc00uroiLyQ8XrRUuQ5liSmtmBwrXt8qSAgACX8QA=
Date: Fri, 24 Apr 2026 18:31:39 +0000
Message-ID: <52241308ec39916b0e703e4a8d3d6d1c29d52244.camel@ibm.com>
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
	 <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
	 <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
	 <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
	 <f957bdf6488b391b4329ff3cc892bfdc93c014fb.camel@ibm.com>
	 <847376cbf4408d12389545142311cb5883045937.camel@ibm.com>
	 <7e043aa928f13d043552ca650808c0383209f806.camel@ibm.com>
	 <CAOi1vP96JuBi5BhTdiVeL491ziy_hwJUm79TqOb=iPaxck1eyg@mail.gmail.com>
	 <4a2802b9a0c82084f833d5211aa3dd0033553a91.camel@ibm.com>
	 <CAOi1vP8PUPzqbp32HqQ=UKoMrepdto7kK3OWue3HAvpzccz_Hw@mail.gmail.com>
In-Reply-To:
 <CAOi1vP8PUPzqbp32HqQ=UKoMrepdto7kK3OWue3HAvpzccz_Hw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV8PR15MB6509:EE_
x-ms-office365-filtering-correlation-id: b5845f00-5686-49b2-425b-08dea22fb9b1
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003|18096099003;
x-microsoft-antispam-message-info:
 PkB5AWPzLJ/KlYFI5QxcyJWSCzOvEh/LVEEb0ZJNzweVrUwMynwXXedLE43bYx/aUqXruSIZ1o4DSBJITIXfhsxgo70RDv7J2J2vW59tXlRoS0387ap1Zm6hr6QcFy/bN8DqU7j7AYRyx7Qb03G/p2ptRqkh4fG1/kPM7Fsz8Ye+wEbxVBuZawPubidLWx/Kwem5Bye5rufiuktbjUlP+9AwrxzjJzaiAPXpth25UXyzxRy/aoK772bjfR4TxrZz3OZPVkCQM/ifhJk1IPkTYJtHNmnQ71SCmiVncMeN81ft8bCvZ79bDmtvKpbECOaI/he3XtaXRD6M/YM2Ip0JRlAVIeDQmQ8LIpI7g0kljtnXKv1K3XlskIW5mwbzjWSwQxVJ/Y++cC/VtV5IBjf2N6xFGpnnaaLinjE3R9kah49NESCVx2jwFMs6/WzQTA8U71RzCqy5ITKwBBR2vJbt5CNAO+mayVjZP7vcSRs3gtdc6EFokOoG6IarVnjrHYuagGowFcXYEao3TJxq9VPCnd+CnDFo9hmmAzn7o6s53iUpehB4RummWVyBoirosTUME2XP9aAZ9OBYO+MaTZZH45XGCMFLcDR6Ko/j6vuiSyvJV+GZMP0llCLHLvLM9dY1dQSrtfcL725NQZw02Xn3sYE5FT3bc8INSPhtmbK1Clw2yHih3m/celM2Xdihrl2JD5gTcDKMAsLKLYVr4EiaaDPaeHX8tNLkLfi6J7EXBozwz5kMO80JkUIdCLttY0mbKjq52z61B7ZPIH/WL1DdJnwgGKqukMfzPYA2ljcOQfs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(18096099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW1RTnlGKzlkU3hMM0NlaWdCTVF3N2JBM3pQUHo1M2gwWWNVa05ZNFhSMXlw?=
 =?utf-8?B?WUFWZy9NdjFGQzV4c2crb3ZQdmxWYWlmUllxSVdiMnFDWlZSeVdzaExHRDVi?=
 =?utf-8?B?YjVDMjZtQ2hLbWt6UUxjTVBuUndaamNJazdrbDZGMThsaWxEUjVxRnhsb3Ev?=
 =?utf-8?B?V1kwamttcTViS3YzL3NtRldFVmJHQjdNNDg3WkpYK1dpMGVmL2d4VFZqc2Mr?=
 =?utf-8?B?aFVLaFRHeWNESkxiQnJveUt4S1h2RG9jVGlQL2NVclhFRUV4bFEyMit1R2Jl?=
 =?utf-8?B?eVlncXcyNnl3UGRJdHMraUh5SSsxbHFqdlRlT29uVkNNU3B1QzRncnNtNXVs?=
 =?utf-8?B?UWdRSVd5OC96blV5NUkzRUxuWkVIZkIybE12UEhOVXo4WmkyV2pHZXdnWVJZ?=
 =?utf-8?B?cWU3OGZLN3NXcG9ZU0czczQ2Yzc5SlRPV1p1VkNTbXJUL0NWZ2dHV28rYTBm?=
 =?utf-8?B?d2x6VVNzbXpOTzI4TnA2cnN2YkhqM3FOS1BLQVhSR295aGxnZHRHY0Y2TUR2?=
 =?utf-8?B?NHg4dHJoUnVqNm8rMXBEWm1VSHFaNE1tUWVvR01IdXp6WUI1cWtYeVVIZXBt?=
 =?utf-8?B?dVk4VEdPTENBbUZoUDN3UHBFODhlNkpZYWhQK3FmUGJIOHo0ZkFncDF4dXZz?=
 =?utf-8?B?U1hqS2ZPRE9za2dOWEJmL0g2VXk3V2piSFRCQmNNLzRJbTFZZTFhejBtaWY3?=
 =?utf-8?B?Y0czL3ZoOSsxajh2WWMvRkpqS0phSkQyV1BweG54akp6eEhUUEN1Y0hCV1VV?=
 =?utf-8?B?aFpPK2RpRS9kNE1tZXhSSWJ3TUNKNG9DcFB1WGZkOU9nRDZuR3p0M0lyWFJa?=
 =?utf-8?B?K1NPZERjL3kvKy9iM2I3eXd1MWZQNXNYOFl5dmxWNmM4QjFyYnJuZnB4UXRh?=
 =?utf-8?B?T2wwQk1tMjhzR25PczBqYlRwMGk1RjhUS3BOUVQyVkVBVDVCVWQ0S1VZTkNC?=
 =?utf-8?B?a28yc2hWNlExbXFNeDJ0aEw4QWhGWVoxVmhIdGVzQnl3Ujdia0M4VjB0RjM5?=
 =?utf-8?B?T1RuUEpXK2ZuNE9UdUpsMkdPNFlxMG1aQXNUK2tuTlo1MXppM1dESEFVT3Jl?=
 =?utf-8?B?aXQySU5sMzVZU2tUVmFUaHJ3NFBQVlcyZG5vVEVBdThHaGhBWE5Cb3hiZGVV?=
 =?utf-8?B?WXRYMEM1NWQ3MkpIVUhKVTR2cmdrRm9jcGFrWlRhTWdHaDI0cko5Ukhaa0lC?=
 =?utf-8?B?NGFmWGxGaXUzVjJoQW5ZcWdSVXVrNUhUaDdVcHl2R0E3dnJJMHYxK0REVzdU?=
 =?utf-8?B?V0JvS0NJckw0b3FqdnBWNTdsL2xWMTB4MnZzVlBhSDkxVkRkRHd4YXlEVUZE?=
 =?utf-8?B?b0RWSTVZU3NoVThoaWh3YVdKNytCTFQ5V0MrRU5aMG9kbGcxakp6VlUyZTFx?=
 =?utf-8?B?c2JHUjdnRWwvSDJUaDR0UUJGTERwcitObkk3Tlc4NnBpUDdvZmZGdlJJUlhI?=
 =?utf-8?B?cUIwNFl1dTJUR214SFFxY3pDVUdGOFFsV3NUQytrWGF6QmZmL1JtempVSHhI?=
 =?utf-8?B?RnE2ZWM1VTI0QytJMWV5NnBReGIxRkI2QnQ3SDRnUUpHTlYrUE5KdklBMm0z?=
 =?utf-8?B?ZURldEhicXBMbGhDemRLZlI5UmQ3YUVNUDJJR3JxNG43TTR6QkpPKys1UHNG?=
 =?utf-8?B?U1BRcTNTN3p3ZWxoUVJRZWc0SEUyREgrMHV5ekZuNGtEeUJHZUcvUVlUazMv?=
 =?utf-8?B?RHJsOXI0ZEJYaFNuOS9oV1h6dE54RXYvNDhuWWp0WFVDcjJ3ekxKZjVmVzFK?=
 =?utf-8?B?a01GZVdoYzhzdGlNREZzQWdSMndDbFRVd0xweWtobkJXSDI2dFlqSGUwVDdS?=
 =?utf-8?B?MzltdEFBRTBjdDU1YzBkL2ZpTDhKZUVvSVZuYVF1T21RRWd4aU4rSktQTXdN?=
 =?utf-8?B?cHZlVU45eEN4K2FyM21FeEJPM3RUU3dtVW9ySHhJUFc3c3ZMUzFWTEZtUUpo?=
 =?utf-8?B?OGF5ZGRWSytaVk1sS2JuZ2ZzQVlXYnBnTm9LNlBkRGl6YjBzY2EySWhSeUp5?=
 =?utf-8?B?eW1DSDZieUhkQndRSzUzSWdLTy9lUWozMkE2cHdud013SVgwTUk5OUpWRFlt?=
 =?utf-8?B?K3JZYVUwV0lPUm9rKzBWKy9IcVBrakhlR240YWRwRkMweHhOVG5jdW80U2Nu?=
 =?utf-8?B?UCt5c0ZoL0owQVpTd1N0czN3TUNka3pLaU5ROFBJVTFacXp4enVhS3V0Sk9x?=
 =?utf-8?B?clNmWjdxZE1TUUhlbXNQcDBwZ0hKV2JNaEx2WWlyWHlIZUdLUE13cStlRGVx?=
 =?utf-8?B?OWYzRy92RVBaQ2diTlZ4cGJ1QzJsd2FTWmxFOWhpNXQ2U25nNUpLQjZNcVgx?=
 =?utf-8?B?ZlBjTWRMRnRMa1llVUJQblgzR1JvVm9naVJPVnVSVzRzdFVPQytDV213MlpV?=
 =?utf-8?Q?kf0GaRWYGBGMS0H3GmjG+rLyZjhGKe/hE/nO7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C5F855BAAC7DD4B95A9D806BB4CD6D7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MeYDmW0i36J4fH402Bje2KYPN2F4OwDBY+uGJJunvv9NAtf2WMoHGr2LZJdyaYi1/u4yUDpYSq1fIdcSXC24rMUI5Qm5n42N+JivNElQVTw+L8rAdGDOnlYnmG9wFnTgPwU11C/SiiHboSBMuoLHR4qwiMimhuIqat9ufHxMFOkXUbU28XveMhGhn6kYXj8iuprAbdelo6YFqw2AjSgJ4CRVjslfQneRh03OhUiOJrmp4uUHaDkYWqN0gRVDYm8zbNaK4OEHugnYVi/Vw/80tWpVV9wlRR4FiTAQLYJWdaBs+FIKG69CrTmIUC0BM3YrHZEPsL2/NMrCQ7nHonSCfw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5845f00-5686-49b2-425b-08dea22fb9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 18:31:39.5623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIIb3fmqdfVVzJu4KPqY9G06Bi/B5DTn6KSRHpbiclWjuP3n8wj0+b8MGp9EK2txx+zFSjsvQRhbcPyiu1wKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6509
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3OCBTYWx0ZWRfX4FJO2VpHWnwQ
 A2TgWpdM8caaFrxLYfFk7wRNn/c8pZ5qHzSAH/uq8/j26tLe/wmxLRBk3y1v9B/YfJKezLPEKKA
 qYranB8DxqS3iifsp71MTqfOCwoRAJ6GMzu5XVuYbwjfr3CW6caO8zZkwN9A3fThiy/M+Sh1tZI
 uO7WyaYpd3wSHH1YqxTNcfVzf0DbhvdzT0U+awXEgkLOd2wMc8uSGIgDDpX9AsrrCY2FbxkU3m3
 Fh7LKXStBABrQS2jnAOdK6Fp56UOb29biZYqDFXZJdDC2JSb8DlMQFdIyAl4YLA4nFf3lZHZ0I6
 aUH2M/6a0BSp7LOYx4VAhqiVbt1WRP9v87Mrt28N0vCPba5UGca/9lnfhorl3Mrv3PGtwljmsWB
 lnS40Zns6pH3YN5vIx7k5hWex+lysz3XL1OKkjg8EK0nXMB8gajqqeDgCV5hTW9AY63jnBjORyi
 uRGLa7IUVekx+GHMK4Q==
X-Proofpoint-ORIG-GUID: Az7sTfvxS0M7jTinjzLWJpwSqldYZ_aL
X-Proofpoint-GUID: SmW5TVMK-CYSY-1svsSsrN2O0n76t_lB
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ebb715 cx=c_pps
 a=FRwzarAYk3lDJRtuO2pFeQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=IFKJO1zSgqrcHu1WaI0A:9
 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240178

T24gRnJpLCAyMDI2LTA0LTI0IGF0IDExOjI3ICswMjAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IE9uIFRodSwgQXByIDIzLCAyMDI2IGF0IDg6MDTigK9QTSBWaWFjaGVzbGF2IER1YmV5a28NCj4g
PFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAyMDI2LTA0
LTIyIGF0IDExOjUzICswMjAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+ID4gPiBPbiBGcmksIEFw
ciAxMCwgMjAyNiBhdCAxMDo0NuKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbw0KPiA+ID4gPFNsYXZh
LkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBGcmksIDIwMjYt
MDQtMTAgYXQgMjA6NDAgKzAwMDAsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiA+ID4g
PiBPbiBUaHUsIDIwMjYtMDQtMDkgYXQgMTg6MDkgKzAwMDAsIFZpYWNoZXNsYXYgRHViZXlrbyB3
cm90ZToNCj4gPiA+ID4gPiA+IE9uIFRodSwgMjAyNi0wNC0wOSBhdCAxMDozOSArMDgwMCwgUGVu
Z3BlbmcgSG91IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5h
bWUoKSBiYXNlNjQtZW5jb2RlcyB0aGUgZW5jcnlwdGVkIHNuYXBzaG90DQo+ID4gPiA+ID4gPiA+
IG5hbWUgaW50byB0aGUgY2FsbGVyIGJ1ZmZlciBhbmQgdGhlbiwgZm9yIGxvbmcgc25hcHNob3Qg
bmFtZXMsIGFwcGVuZHMNCj4gPiA+ID4gPiA+ID4gXzxpbm8+IHdpdGggc3ByaW50ZihwICsgZWxl
biwgLi4uKS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFNvbWUgY2FsbGVycyBvbmx5
IHByb3ZpZGUgTkFNRV9NQVggYnl0ZXMuIEZvciBsb25nIHNuYXBzaG90IG5hbWVzLCBhDQo+ID4g
PiA+ID4gPiA+IGxhcmdlIGlub2RlIHN1ZmZpeCBjYW4gcHVzaCB0aGUgZmluYWwgZW5jb2RlZCBu
YW1lIHBhc3QgTkFNRV9NQVggZXZlbg0KPiA+ID4gPiA+ID4gPiB0aG91Z2ggdGhlIGVuY3J5cHRl
ZCBwcmVmaXggc3RheWVkIHdpdGhpbiB0aGUgZG9jdW1lbnRlZCAyNDAtYnl0ZQ0KPiA+ID4gPiA+
ID4gPiBidWRnZXQuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBGb3JtYXQgdGhlIHN1
ZmZpeCBpbnRvIGEgc21hbGwgbG9jYWwgYnVmZmVyIGZpcnN0IGFuZCByZWplY3QgbmFtZXMNCj4g
PiA+ID4gPiA+ID4gd2hvc2Ugc3VmZml4IHdvdWxkIGV4Y2VlZCB0aGUgY2FsbGVyJ3MgTkFNRV9N
QVggb3V0cHV0IGJ1ZmZlci4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFBlbmdwZW5nIEhvdSA8cGVuZ3BlbmdAaXNjYXMuYWMuY24+DQo+ID4gPiA+ID4gPiA+
IC0tLQ0KPiA+ID4gPiA+ID4gPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiA+ID4gPiA+ID4gPiAtIHJl
amVjdCBgZWxlbiA+IDI0MGAgZXhwbGljaXRseSBpbnN0ZWFkIG9mIHJlbHlpbmcgb25seSBvbiB0
aGUgZWFybGllcg0KPiA+ID4gPiA+ID4gPiAgIGBXQVJOX09OKClgDQo+ID4gPiA+ID4gPiA+IC0g
cmV3cml0ZSB0aGUgTkFNRV9NQVggYm91bmQgY2hlY2sgaW4gdGVybXMgb2YgdGhlIGZpbmFsIHRv
dGFsIGxlbmd0aA0KPiA+ID4gPiA+ID4gPiAgIGluc3RlYWQgb2YgYE5BTUVfTUFYIC0gcHJlZml4
X2xlbiAtIGVsZW5gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAgZnMvY2VwaC9jcnlw
dG8uYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiA+ID4gPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvY3J5cHRvLmMgYi9m
cy9jZXBoL2NyeXB0by5jDQo+ID4gPiA+ID4gPiA+IGluZGV4IGYzZGU0M2NjYjQ3MC4uNDJlM2Zm
ZjM0Njk3IDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0gYS9mcy9jZXBoL2NyeXB0by5jDQo+ID4g
PiA+ID4gPiA+ICsrKyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gPiA+ID4gPiA+ID4gQEAgLTE1LDYg
KzE1LDEyIEBADQo+ID4gPiA+ID4gPiA+ICAjaW5jbHVkZSAibWRzX2NsaWVudC5oIg0KPiA+ID4g
PiA+ID4gPiAgI2luY2x1ZGUgImNyeXB0by5oIg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gKy8qDQo+ID4gPiA+ID4gPiA+ICsgKiBSZXNlcnZlIHJvb20gZm9yICdfJyArIGRlY2ltYWwg
NjQtYml0IGlub2RlIG51bWJlciArIHRyYWlsaW5nIE5VTC4NCj4gPiA+ID4gPiA+ID4gKyAqIGNl
cGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZSgpIGNvcGllcyBvbmx5IHRoZSB2aXNpYmxlIHN1ZmZp
eCBieXRlcy4NCj4gPiA+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ID4gPiArI2RlZmluZSBDRVBI
X0VOQ1JZUFRFRF9TTkFQX0lOT19TVUZGSVhfTUFYICAgICAgIHNpemVvZigiXzE4NDQ2NzQ0MDcz
NzA5NTUxNjE1IikNCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiAgc3RhdGljIGludCBj
ZXBoX2NyeXB0X2dldF9jb250ZXh0KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHZvaWQgKmN0eCwgc2l6
ZV90IGxlbikNCj4gPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ID4gICBzdHJ1Y3QgY2VwaF9p
bm9kZV9pbmZvICpjaSA9IGNlcGhfaW5vZGUoaW5vZGUpOw0KPiA+ID4gPiA+ID4gPiBAQCAtMjA5
LDYgKzIxNSw3IEBAIGludCBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0IGlub2Rl
ICpwYXJlbnQsIGNoYXIgKmJ1ZiwgaW50IGVsZW4pDQo+ID4gPiA+ID4gPiA+ICAgc3RydWN0IGlu
b2RlICpkaXIgPSBwYXJlbnQ7DQo+ID4gPiA+ID4gPiA+ICAgY2hhciAqcCA9IGJ1ZjsNCj4gPiA+
ID4gPiA+ID4gICB1MzIgbGVuOw0KPiA+ID4gPiA+ID4gPiArIGludCBwcmVmaXhfbGVuID0gMDsN
Cj4gPiA+ID4gPiA+ID4gICBpbnQgbmFtZV9sZW4gPSBlbGVuOw0KPiA+ID4gPiA+ID4gPiAgIGlu
dCByZXQ7DQo+ID4gPiA+ID4gPiA+ICAgdTggKmNyeXB0YnVmID0gTlVMTDsNCj4gPiA+ID4gPiA+
ID4gQEAgLTIxOSw2ICsyMjYsNyBAQCBpbnQgY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKHN0
cnVjdCBpbm9kZSAqcGFyZW50LCBjaGFyICpidWYsIGludCBlbGVuKQ0KPiA+ID4gPiA+ID4gPiAg
ICAgICAgICAgaWYgKElTX0VSUihkaXIpKQ0KPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICByZXR1cm4gUFRSX0VSUihkaXIpOw0KPiA+ID4gPiA+ID4gPiAgICAgICAgICAgcCsrOyAvKiBz
a2lwIGluaXRpYWwgJ18nICovDQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICBwcmVmaXhfbGVuID0g
MTsNCj4gPiA+ID4gPiA+ID4gICB9DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAgIGlm
ICghZnNjcnlwdF9oYXNfZW5jcnlwdGlvbl9rZXkoZGlyKSkNCj4gPiA+ID4gPiA+ID4gQEAgLTI3
MSw4ICsyNzksMjcgQEAgaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZShzdHJ1Y3QgaW5v
ZGUgKnBhcmVudCwgY2hhciAqYnVmLCBpbnQgZWxlbikNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+ICAgLyogVG8gdW5kZXJzdGFuZCB0aGUgMjQwIGxpbWl0LCBzZWUgQ0VQSF9OT0hBU0hf
TkFNRV9NQVggY29tbWVudHMgKi8NCj4gPiA+ID4gPiA+ID4gICBXQVJOX09OKGVsZW4gPiAyNDAp
Ow0KPiA+ID4gPiA+ID4gPiAtIGlmIChkaXIgIT0gcGFyZW50KSAvLyBsZWFkaW5nIF8gaXMgYWxy
ZWFkeSB0aGVyZTsgYXBwZW5kIF88aW51bT4NCj4gPiA+ID4gPiA+ID4gLSAgICAgICAgIGVsZW4g
Kz0gMSArIHNwcmludGYocCArIGVsZW4sICJfJWxkIiwgZGlyLT5pX2lubyk7DQo+ID4gPiA+ID4g
PiA+ICsgaWYgKGVsZW4gPiAyNDApIHsNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgIGVsZW4gPSAt
RU5BTUVUT09MT05HOw0KPiA+ID4gPiA+ID4gPiArICAgICAgICAgZ290byBvdXQ7DQo+ID4gPiA+
ID4gPiA+ICsgfQ0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ICsgaWYgKGRpciAhPSBw
YXJlbnQpIHsNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgIGludCB0b3RhbF9sZW47DQo+ID4gPiA+
ID4gPiA+ICsgICAgICAgICAvKiBsZWFkaW5nICdfJyBpcyBhbHJlYWR5IHRoZXJlOyBhcHBlbmQg
XzxpbnVtPiAqLw0KPiA+ID4gPiA+ID4gPiArICAgICAgICAgY2hhciBzdWZmaXhbQ0VQSF9FTkNS
WVBURURfU05BUF9JTk9fU1VGRklYX01BWF07DQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+
ID4gKyAgICAgICAgIHJldCA9IHNucHJpbnRmKHN1ZmZpeCwgc2l6ZW9mKHN1ZmZpeCksICJfJWx1
IiwgZGlyLT5pX2lubyk7DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICB0b3RhbF9sZW4gPSBwcmVm
aXhfbGVuICsgZWxlbiArIHJldDsNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgIGlmICh0b3RhbF9s
ZW4gPiBOQU1FX01BWCkgew0KPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICBlbGVuID0g
LUVOQU1FVE9PTE9ORzsNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgZ290byBvdXQ7
DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICB9DQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+
ID4gKyAgICAgICAgIG1lbWNweShwICsgZWxlbiwgc3VmZml4LCByZXQpOw0KPiA+ID4gPiA+ID4g
PiArICAgICAgICAgLyogSW5jbHVkZSB0aGUgbGVhZGluZyAnXycgc2tpcHBlZCBieSBwLiAqLw0K
PiA+ID4gPiA+ID4gPiArICAgICAgICAgZWxlbiA9IHRvdGFsX2xlbjsNCj4gPiA+ID4gPiA+ID4g
KyB9DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAgb3V0Og0KPiA+ID4gPiA+ID4gPiAg
IGtmcmVlKGNyeXB0YnVmKTsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gTG9va3MgZ29vZC4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlr
byA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBMZXQg
bWUgcnVuIHhmc3Rlc3RzIGZvciB0aGUgcGF0Y2ggdG8gZG91YmxlIGNoZWNrIHRoYXQgZXZlcnl0
aGluZyBpcyBPSy4gSSdsbA0KPiA+ID4gPiA+ID4gc2hhcmUgdGhlIHJlc3VsdCBBU0FQLg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIHhmc3Rlc3RzIHJ1biB3YXMgc3Vj
Y2Vzc2Z1bC4gSSBkb24ndCBzZWUgYW55IGlzc3VlcyB3aXRoIHRoZSBwYXRjaC4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBUZXN0ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlr
b0BpYm0uY29tPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQXBw
bGllZCBvbiB0ZXN0aW5nIGJyYW5jaCBvZiBDZXBoRlMga2VybmVsIGNsaWVudCBnaXQgdHJlZS4N
Cj4gPiA+IA0KPiA+ID4gSGkgUGVuZ3BlbmcsIFNsYXZhLA0KPiA+ID4gDQo+ID4gPiBUaGlzIHBh
dGNoIHJhaXNlZCBteSBhdHRlbnRpb24gYmVjYXVzZSBteSB1bmRlcnN0YW5kaW5nIHdhcyB0aGF0
IHRoZQ0KPiA+ID4gZW50aXJlIENFUEhfTk9IQVNIX05BTUVfTUFYICsgc2hhMjU2KCkgd2FzIHB1
dCBpbiBwbGFjZSBwcmVjaXNlbHkgdG8NCj4gPiA+IGhhbmRsZSBsb25nZXIgbmFtZXMgbmljZWx5
IGFuZCBtYWtlIHRoZW0gZml0IGludG8gTkFNRV9NQVgtc2l6ZWQgYnVmZmVyLg0KPiA+ID4gU2lt
cGx5IHJlamVjdGluZyBsb25nZXIgbmFtZXMgc2VlbWVkIHRvIGJlIGluIGRpcmVjdCBjb250cmFk
aWN0aW9uIHdpdGgNCj4gPiA+IHRoYXQgYW5kIHlldCB0aGUgcGF0Y2ggb24gaXRzIG93biB3YXMg
Y2xlYXJseSBtZXJpdGVkIGdpdmVuDQo+ID4gPiANCj4gPiA+ICAqICgyNDAgYnl0ZXMgaXMgdGhl
IG1heGltdW0gc2l6ZSBhbGxvd2VkIGZvciBzbmFwc2hvdCBuYW1lcyB0byB0YWtlIGludG8NCj4g
PiA+ICAqICBhY2NvdW50IHRoZSBmb3JtYXQ6ICdfPFNOQVBTSE9ULU5BTUU+XzxJTk9ERS1OVU1C
RVI+Jy4pDQo+ID4gPiANCj4gPiA+IGNvbW1lbnQgb24gQ0VQSF9OT0hBU0hfTkFNRV9NQVggZGVm
aW5pdGlvbi4NCj4gPiA+IA0KPiA+ID4gSSBkdWcgYSBiaXQgZGVlcGVyIGFuZCBzdGFydGVkIGEg
ZGlzY3Vzc2lvbiBpbiBbMV0uICBUaGUgcHJlbGltaW5hcnkNCj4gPiA+IGNvbmNsdXNpb24gaXMg
dGhhdCB0aGUgMjQwIGJ5dGVzIGFzc3VtcHRpb24gd2FzIGEgbWlzdGFrZSAtLSBzb21laG93DQo+
ID4gPiB0aGUgbWluaW11bSBudW1iZXIgb2YgY2hhcmFjdGVycyBuZWVkZWQgZm9yIDxpbnVtPiBl
bmRlZCB1cCBiZWluZyB1c2VkDQo+ID4gPiBpbnN0ZWFkIG9mIHRoZSBtYXhpbXVtLiAgQ0VQSF9O
T0hBU0hfTkFNRV9NQVggdmFsdWUgaXMgbGlrZWx5IGluY29ycmVjdA0KPiA+ID4gYW5kIHNob3Vs
ZCBoYXZlIGJlZW4gc21hbGxlciAtLSBzb21ldGhpbmcgYWxvbmcgdGhlIGxpbmVzIG9mIDE3NCAt
DQo+ID4gPiBTSEEyNTZfRElHRVNUX1NJWkUgaW5zdGVhZCBvZiAxODAgLSBTSEEyNTZfRElHRVNU
X1NJWkUuDQo+ID4gPiANCj4gPiANCj4gPiBUaGUgbGltaXRhdGlvbiBjb3VsZCBiZSAyNDAgb3Ig
YmlnZ2VyIG9uZSwgYnV0IGFueXdheSB3ZSBuZWVkIHRvIHByb2Nlc3MgdGhpcw0KPiA+IGxpbWl0
YXRpb24gaW4gcHJvcGVyIHdheS4gQW5kIHRoaXMgcGF0Y2ggaGFzIGV4YWN0bHkgdGhpcyBnb2Fs
LiBJcyAyNDAgYnl0ZXMNCj4gPiBsaW1pdGF0aW9uIHlvdXIgY29uY2Vybj8gQXMgZmFyIGFzIEkg
Y2FuIHNlZSwgdGhpcyBwYXRjaCBkb2Vzbid0IGludHJvZHVjZSB0aGlzDQo+ID4gbGltaXRhdGlv
bi4gSXQgd2FzIHRoZXJlIGJlZm9yZSB0aGlzIG1vZGlmaWNhdGlvbi4gV2UgY2FuIGV4dGVuZCB0
aGlzIGxpbWl0YXRpb24NCj4gPiBhbnl0aW1lLg0KPiANCj4gSGkgU2xhdmEsDQo+IA0KPiBNeSB0
YWtlIG9uIHRoaXMgaXMgdGhhdCB0aGVyZSBzaG91bGRuJ3QgYmUgYSBsaW1pdGF0aW9uIHRvIGJl
Z2luIHdpdGgNCj4gKG90aGVyIHRoYW4gTkFNRV9NQVggd2hpY2ggaXMgbmF0dXJhbCBhbmQgYXBw
bGllcyB1bml2ZXJzYWxseSwgbm90IGp1c3QNCj4gdG8gc25hcHNob3QgbmFtZXMpLiAgVGhpcyBm
dW5jdGlvbiBoYXMgYSBidW5jaCBvZiBjb2RlIHRoYXQgaXMgdGhlcmUNCj4gc3BlY2lmaWNhbGx5
IHRvIGhhbmRsZSBsb25nZXIgbmFtZXMgYW5kIGF2b2lkIGFueSBhcnRpZmljaWFsIGxpbWl0czoN
Cj4gdGhlIHBhcnQgb2YgdGhlIG5hbWUgdGhhdCBzcGlsbHMgb3ZlciBDRVBIX05PSEFTSF9OQU1F
X01BWCBpcyBoYXNoZWQNCj4gYW5kIHRoZSB3aG9sZSB0aGluZyBpcyBzZXQgdXAgaW4gc3VjaCBh
IHdheSB0aGF0IHRoZSBlbmQgcmVzdWx0IGlzDQo+IG5ldmVyIGJpZ2dlciB0aGFuIDI0MCBieXRl
cy4gIDI0MCBpc24ndCBhIHJhbmRvbSBudW1iZXIgLS0gaXQgd2FzDQo+IHBpY2tlZCBvbiBwdXJw
b3NlIHRvIGxlYXZlIHJvb20gZm9yIF8gcHJlZml4IGFuZCBfPElOT0RFLU5VTUJFUj4gc3VmZml4
DQo+ICgyNTUgMSAtIDEgLSAxMykgYnV0IGEgbWlzdGFrZSBhcHBlYXJzIHRvIGhhdmUgY3JlcHQg
aW4uICBJbnN0ZWFkIG9mDQo+IGFjY291bnRpbmcgZm9yIHRoZSBtYXhpbXVtIHBvc3NpYmxlIDxJ
Tk9ERS1OVU1CRVI+IGxlbmd0aCAod2hpY2ggaXMgMjANCj4gaW4gZGVjaW1hbCBlbmNvZGluZyks
IGl0IGFjY291bnRlZCBvbmx5IGZvciAxMyAobGlrZWx5IGJlY2F1c2UgaXQNCj4gaGFwcGVucyB0
byBiZSB0aGUgbWF4aW11bSBwb3NzaWJsZSBsZW5ndGggaW4gYSBzaW5nbGUtTURTIHNldHVwPyku
DQo+IA0KPiBJTU8gdGhlIHJpZ2h0IGNvdXJzZSBvZiBhY3Rpb24gaGVyZSB3b3VsZCBiZSB0byBz
ZWUgaWYgdGhlIGhhc2hpbmcNCj4gcGFyYW1ldGVycyBjYW4gYmUgYWRqdXN0ZWQsIG5vdCBpbnRy
b2R1Y2UgbmV3IEVOQU1FVE9PTE9ORyBlcnJvcnMuDQo+IA0KPiANCg0KSGkgUGVuZ3BlbmcsDQoN
CkNvdWxkIHlvdSBwbGVhc2UgcmV3b3JrIHRoZSBwYXRjaCB0YWtpbmcgaW50byBhY2NvdW50IHRo
ZSBzaGFyZWQgcmVtYXJrcz8NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
