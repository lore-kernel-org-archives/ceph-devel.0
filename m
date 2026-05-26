Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8A405C51
	for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820265; cv=fail; b=pipBKFeLe+NA7FVTJnUSd6ujl4VBaMo1DNDdcrAMJl160s7XmbQs+rpeFctBeE9vOyE6OnaEySp/EYhLpivAi1H4meT/zL6+H8yUJtFLGB2hZ6tV/rn/HWi7/t7gHXYyQtCNSbkPACsFNsDbEbogCI2zWp0Ml4wuvjqXNoVYWmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820265; c=relaxed/simple;
	bh=ALyIfmNHJf+ycT5V9WQbrjRMEaP2eOUj0cBDTz43FvE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=JOTiwcjmDF0XV5PEe2KXsv0IHxxZVQRYql0VhaesijX3ugBMizrurrfWDD9je3A/Ijy82DMyKUHS1RHSiGke8XGQoRh/A4/LdQYB5bDNJYsjCGhdVnvpPv8i18omY8Rvy11HQBHjdgoUW0zJFN3MN9KWeSPRvtQoNlsKMuTGw+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L/oDpEMp; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L/oDpEMp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QD8WGa1938621;
	Tue, 26 May 2026 18:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ALyIfmNHJf+ycT5V9WQbrjRMEaP2eOUj0cBDTz43FvE=; b=L/oDpEMp
	SKLC6WkeUtcTw+ow6Zh0ZG+HwlPpPDPVoIhFrHzxDp7hMC3zH4D6Ht7bwTtfzpKd
	0fyG7KUYbceEcOmg4J1LrqaRq2SCF8ViqAuPHu+3tfe9ava96FksoN/SdgAG1Ij2
	RUV+v0k4aeDMYeJp/h0rRQfGPNi+UQcLSo7xeII2Dt/9XeELxJTv8yRz8RghJkWE
	7Z8dTfgasKk4alKZYLCZ7pMuuxJUrIKwPiPU9/8xCz/J5fE+czxnNN14MlvofyMf
	UIXFBniVx1wUqKhGxoQzJPzt1IiEi+hLKATogAGahk0DWw48s/gP7MDhTFIIFQIk
	eWKjiU3r/uqZ4g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc4n16-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 18:30:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp6FXZeSRhf9M2uIWx9TIcDTGonFlxLgQf4mBi8DDdqj5kCoUO0GtT7LXu8/fBWTQCMY7r/u836+j7+pvJOcrWqW9zU3DxAJrG5kwPY9HNKQH/omfmPUTTUBxe9sOVDNvlO1C7XLT/LuUIuenClJz9CqXFiOKK8HW/CBzmfNRaba+k8tBlpmfV2zrZA08pc5Ls6guLxrhnrE1svAtIDL6ecgqUw9pvlDUlzbcUBeUNypy5rN6b0P1qDBMcblzX8jUPIra5Pgv0xq4/ufQsDW4VTo11o2aWWIFbJqPKUg+MZIKi/xvlzN5/jvFEdpDhi4cld5oAhcvjoNSlmEil6hew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALyIfmNHJf+ycT5V9WQbrjRMEaP2eOUj0cBDTz43FvE=;
 b=oUxM772szWrm0y/BcFvHYpXUy7cEHQJI0hqYNVW6vWhPCShZQsMVlqvu6bilOhLlXtDBPSRoQJyylbO8xLyeRjwgizgpY31lAg7KBDL5vQgqVJLW4tRDI+s3um4WiPQgPWlHYSr5YHP/D2XZYrWgBQ6kGFNR5ozDj3S/QKayQmhPYCjjn1m4jKB9d4MloEl8zsEvDAYg0qAzhdesj8g66r2zuCO5/5m3mkUZ2lcRNNlv+EfbuL/8rElxAQ8w2A84yUTiJMEey43OotNDAPxjUmn1a/FdJ16HM4DNgcbmCvG29ZHLmyPPxoRDfdrwMMjHp62+FmVyhWTCnd+qaP/l8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5533.namprd15.prod.outlook.com (2603:10b6:208:41a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 18:30:45 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 18:30:45 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] libceph: Reject monmaps advertising zero
 monitors
Thread-Index: AQHc6gbIuoqvKWjIzEOp2W3klmHaobYgp3eA
Date: Tue, 26 May 2026 18:30:45 +0000
Message-ID: <502b1825d71f4ec870b64ec8257946a916bb0fee.camel@ibm.com>
References: <20260522154420.3324836-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260522154420.3324836-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5533:EE_
x-ms-office365-filtering-correlation-id: 9d25c355-53f9-4eec-57ef-08debb54e686
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|38070700021|6133799003|56012099006|11063799006|3023799007;
x-microsoft-antispam-message-info:
 UoEbnYWgbuzTQ3H59hDQr7C0VqoT37SnCD7DFWmXDdAu1xNwGkxmWX37yWINuxpSHzhu4eGW+teRU4P4yKZncxIW9xBO5Hcl5QdnisDio0ysc2AkZKlixOmSAK4PcN66DE5pLmDmQyXNNk3GhIwm4Iy53cg5JOYNuNsUc2qc2PvxgcpP3yEHt0EeGnJ89WP+XUuw6nSh0IVvdRZb690PG3NOB0Rdr96ebnLs4UOLZJKuDvBE6mZ/IeOamersTdcmw/g2xd4bFyQR9WWAS4KO8Lwlk8GaDgDOaYiqe0BidFTxZWUG0j4UkeziuVlVldB30Fh2EVxOlrPCPvJRRVfjpGS5gQJ8JHugnMMDMwnHUZ3m7D1J6lvvLKN/SEOMTcFq+W6QGxtyD7y1TyhabUtMqmZOhxRSXiXI+Nb2dlQewY1WgGqwDZxEIX/qMZ6h2sf8X1S3vJHmqTwVjco3A5234Ix5IXfMb1/448AOIUxzmsGAnacHv7nFl4Gzz0y8sR+xTsUQO0nFBH/eqEe9DMnLMzlKAXkdUA9ZxCXIaKDgtWzReBprxNLfuWwn6gp7VhvMLR5Ydm+9h2nY5R6gTwOnbzBvA2KIO5v/gVhryJ2h8jGlzQ8ZKabFr+rRRjXwnx/FumyM82gpZ2//VOcYepxTZwCAU0T1UdsaGp7uxvAn5Fg/yLlJGOITE2znPh0j1ekOysTPETeXcRlfWSMSPXBLfT9JcQWOtQvOrX23R3+RlvL/mWTCuUXCG0+/VClTw+BD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUx3Q3FzZEVDZFVnRERwVFJ6K3Y2dU1GZUZSSU1sczJIRWJ2NHJ6M1JPeEox?=
 =?utf-8?B?Z3Z4VVVLbko5U1Fuc2pTTVNna3B4L3RMdEV6MkpaYjRnc2hJQU5rdDZhRE0r?=
 =?utf-8?B?dWkxVThCYW9QSTVoR0t2d2JqeHJtWlBxaEk0UWhnbmo2ZFoycWR3NWh3R2hB?=
 =?utf-8?B?aEl0cUdaVno3SDlJQTZYMFlTN0t5QmUxK2VHM2hqMlk5cWQ3ajdTWDgycjRN?=
 =?utf-8?B?Z0FyTHV4THNLVzlobHR3VE4zKzB5dUUvUVQ4QStBdTRFL1FrWUpkSGNkekVZ?=
 =?utf-8?B?a2w3UVk3NlFmT2o4Qi82TjJWeUwvYklHaWtxTUQ0aFVwTHdxdVo3Ny9wQndP?=
 =?utf-8?B?VGQyYlpUVXpzbW5VZmhGbjlWclE2eDBlNmxZWFVZcjh4eWlYcExZaitpYVV6?=
 =?utf-8?B?TGdPR3dMZVZkMmlibXdSVVZVZ0djamswd09waU1Fc0E3UmtyalZPL2hVQzE0?=
 =?utf-8?B?ZFpES29ldzRVcVRjdGd3ZFNLWkhBTzJkV3lnRVFHdWdLWTlhaTZyWGR3a3Fr?=
 =?utf-8?B?bjVYbGVKVGxQa2NvUCtjck50L1NzYngzdUQrMlFIWHYzYnFBTjB3endzVE1C?=
 =?utf-8?B?VGhia25xcWdoRlJCOWE0ejFqc3FnN3ByTGR3UXdPc255WitxbStMdEFBbVp1?=
 =?utf-8?B?U3pISTFZN3owc0pFWXdpcG1OMVg2MmplMXIrUUNFL0RIV0NWbXloa2xKdmpt?=
 =?utf-8?B?MVE2dVdaZzN0YkdzT3VaeldiUXEzaVRiNnpRcXNjM2ZYYU5KQktLMURvVXdh?=
 =?utf-8?B?NmZiVm84c3lyc2EyZFk2RzFRNjlvcnVkZkRBdFFvTUpOSXI3ZFB3NCtyM2NT?=
 =?utf-8?B?MnRjdHpPZGNSQ1Vyd2oxcWVYRnp2LzhjQ1FGSG9vNm1BUzlIa3Q1UEQ2dHNT?=
 =?utf-8?B?TTByUWJKaGplcXczYmExazJwanZlejh1a1lTMloxS2s5L3VVQXkwaFI1b0Jy?=
 =?utf-8?B?TXhMbm9DYVFiL1BXVVc1WXlMdUE1YmJTUWZsS2JYQTVOSVg3NkQwdHBvZkNZ?=
 =?utf-8?B?QjdpOGFaVzBpTXpYTWxqZjE2Y01UbGZSS2FvTmhKMHJqMFc0ekt0NFZVOEV6?=
 =?utf-8?B?OTcyMFlpdTJuOWRyUVVHdmc3RVVaS1lDK0huTE1iRklDSnk4cHJNZ1k5RTZ4?=
 =?utf-8?B?ZlJRcS9hSUVsb3Y3VlFHOS9XaHRhWWhkTmtRRktJTExqbjZoVmkrU1dvdTlr?=
 =?utf-8?B?MTlScFR4Y1VVUjR2N3hLdThCWmt3RTFiRS8veHh0a3hFMFkyMng0c2lvRmxI?=
 =?utf-8?B?cUcvbEtiMlNlaE1NKzlqZXFmdUFqeEUzMEJ2OTJMcWJYakNqY1pRbDZWWlRY?=
 =?utf-8?B?VnpTNHd3M0Q0UlFweW5yY1NwM28xS2ZnZkZBZmZjWEZKc000VVpVcEZXWXRu?=
 =?utf-8?B?V290TS8rcVBHYS82S09KSjRjeVRhUjUrejlVTmVpbHFBWDZZM1RJYjNDSXdO?=
 =?utf-8?B?ZDRqdVBxeHVqS00wSEJUNFVDZFpvWWx2VVRUeXBWRHV0SjBuNXdkSFBQTVFP?=
 =?utf-8?B?K0R3QkpFRnAybmphQTFZM1YvT0hNOHVGNXMycmRPNk5UU3dDTU1SM0Q3aVJR?=
 =?utf-8?B?ZTlNK0ZXUnBiSDlQcGg0VnRJekJNblZkNmxWczZSeDhReDdjS1FjejU0Vytw?=
 =?utf-8?B?SUNzNWRpOEpqODNiM202aEhwQUUzcnVRVnZxK003RU9yVkZQalgzZjh4dHNV?=
 =?utf-8?B?Zjc2U1FNQjUrS0NPenZ3RWRrYkxlc1BXWTJSdVZMRWVXanFTcFpmM0dtR2JQ?=
 =?utf-8?B?aUJLYlo5OFFTTjdyalYxTnhtSWhWb0E5QTd0eW4wT1M0SWV0TWdIc3dIc2RN?=
 =?utf-8?B?NnlhT09qQTQ4a0t2T1h3cGNsRzIvQVlDbk5SOHZRREZxalJ0MmR4Mm5yMHJr?=
 =?utf-8?B?SzVOcElaZmZWdDlHbmxzVmtuSVE2UlV3YXM4NUhBTDNQc1RVc2loeUQ3ajdB?=
 =?utf-8?B?KzFyTzBLVmhuTG5vOGZ2aDdtVjRTc2ZQaGJnRVpOcEF5L1dtVitmUkZPQ0s3?=
 =?utf-8?B?MGZFa2gzaWowZzl5cldMVmhXQUI1WTIyd1VNVmVzSFRFQW10UEVnSi9DTU1S?=
 =?utf-8?B?YmVCcHB3S2hkZ2lQdEFuTGJFQmdOWHg1SWZQejFuKzljMXEvblZ5SHkxVnNy?=
 =?utf-8?B?NkVSZ2FnNmVBbHoyWUdKQUVLSXgzdzNzY1lXR2FJOUcxWEM1S2Z6blFPc2Nj?=
 =?utf-8?B?WkZuNVBpdlVmOHFRTmRhRW5vc1VTV3R4dkNKaG1GUEFUcWxXem1yQU40a2Z6?=
 =?utf-8?B?YjlpYWxSR0owZDZFd2h5NlE3NDNlUU1OWHZVQmRhNEdjMWRiNVNBaVM1eDNO?=
 =?utf-8?B?Y0VVeGZKK0Q2ZGRNN1RoNEFRK0FzSytrSWNad2VQWjQwR0NIWUZOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEB15515FA3A994B9A0A326588CD5634@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EzSf6CwyInoeGj5MbU7BDe3plBhpANCNZ2YHkjZ3EMCOEBJpJ+FLGp15HsR5R9+/LR23GelkbtaquYVdzpC0ciaG+52ik+x5DK5fY4PXTDcZNNm+y4gPLEerqUSEfpDMMzxtzFW9Klgb8VdraqG/T5lVQETohabYQ4NSmtFqOmF3PCOEM52BdflOxeNzbs3mxBG/mN41VV/w5j0+uYWqqMiPRBJxH/NBYHXPkbkMkiMk7Fa3ksuujzdL4Jm5mB5QF6JYf50cFA6zEbEQ2hzWSFq6QSE9nSsOFEB8G8eW9W2YXEGdP8WRUfR6E7yD1PArouG2jyJtvtHi1pu3t+WgzA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d25c355-53f9-4eec-57ef-08debb54e686
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 18:30:45.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2FlV2fJ0PJYShU0NilKc8rAucyoHFKi2rZbPIwBfA08hbcyfLWpeGm/i9Ogl+G+nwh5UGM7C7fVLd1k4AfgMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5533
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a15e6da cx=c_pps
 a=0w/E51Vap1Xy1BB5zk4tLA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=x5LM6GFI2K00_0GYXUYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FczTl5a5q1s2U-rLOH6ivOJ-Jtl0B7mM
X-Proofpoint-GUID: O-b4HoKXZRWvwPE1x2PzAlnKR4WkPDJb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE1OCBTYWx0ZWRfXxQAasJrx06FU
 1BrUmMLwa/cBMTph9ATwaWdGFswx7SoppUST73p4g47mQ5DxgP9XM3SuM/5NQ+/yFZyFkIaw3LP
 yFArwXB/Oj5KlxQ/arWdKSkY5/FwgdjhUQWMcC+BeDAPgd8vTcptd5yi1le3ruEAn+kS3vBzJdq
 0OGjVdeOeF1y9jMBm/y3QIxqwqlEhHhST597gLwldi536/BLl5P1pWmp0T63PSYsw5hllOfY1Of
 X5lGRL0/zbaNBihG4jzRxc18VtlWbSiNKOAylcnT/Oq2308Zr8O0t3tDBhZ4++qkHEaMRv/fXFw
 017H/D0njuz7ru3dUELYvhk8NO0zrVh4zH9Z1YiMMGlcJ5zgUSTkhJK1piCIpy6Y25KBnylXzuy
 RfiFClK1yyKlWZMzFCXtslucbGVJWEjLnolYfy1I1q6ifhK0ycSa/YIwE8PUdYWCBwiyqGjm3WC
 K6hVY9P4eTcbzXN2Obg==
Subject: Re:  [PATCH] libceph: Reject monmaps advertising zero monitors
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260158

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDE3OjQ0ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gQSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfTU9OX01BUCBjb250YWlucyBhIG1vbm1hcCB0
aGF0IGlzIHNlbnQgZnJvbSBhDQo+IG1vbml0b3IgdG8gdGhlIGNsaWVudC4gVGhpcyBtb25tYXAg
Y29udGFpbnMgaW5mb3JtYXRpb24gYWJvdXQgdGhlDQo+IGV4aXN0aW5nIG1vbml0b3JzIGluIHRo
ZSBjbHVzdGVyLiBDdXJyZW50bHksIGEgbW9ubWFwIGluZGljYXRpbmcgdGhhdA0KPiB0aGVyZSBh
cmUgemVybyBtb25pdG9ycyBpbiB0aGUgY2x1c3RlciBpcyB0cmVhdGVkIGFzIHZhbGlkLiBIb3dl
dmVyLCBpdA0KPiBpcyBpbXBvc3NpYmxlIHRvIGhhdmUgemVybyBtb25pdG9ycyBpbiB0aGUgY2x1
c3RlciBhbmQgc3RpbGwgcmVjZWl2ZSBhDQo+IHZhbGlkIG1vbm1hcCBmcm9tIGEgbW9uaXRvci4g
VGhlcmVmb3JlLCBzdWNoIGEgbW9ubWFwIG11c3QgYmUgY29ycnVwdGVkDQo+IGFuZCBzaG91bGQg
YmUgdHJlYXRlZCBhcyBpbnZhbGlkLiBGdXJ0aGVybW9yZSwgYSBtb25tYXAgd2l0aCBhIG1vbml0
b3INCj4gY291bnQgb2YgemVybyBjYW4gc3Vic2VxdWVudGx5IGNyYXNoIHRoZSBjbGllbnQgd2hl
biBhdHRlbXB0aW5nIHRvIG9wZW4NCj4gYSBzZXNzaW9uIHdpdGggYSBtb25pdG9yIGluIF9fb3Bl
bl9zZXNzaW9uKCkuIFRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZQ0KPiAiQlVHX09OKG1vbmMtPm1v
bm1hcC0+bnVtX21vbiA8IDEpIiBhc3NlcnRpb24gaW4gcGlja19uZXdfbW9uKCkgaXMNCj4gdHJp
Z2dlcmVkLg0KPiANCj4gVGhpcyBwYXRjaCBleHRlbmRzIGEgY2hlY2sgaW4gY2VwaF9tb25tYXBf
ZGVjb2RlKCkgdG8gYWxzbyByZWplY3QNCj4gYXJyaXZpbmcgbW9uX21hcHMgd2l0aCBudW1fbW9u
ID09IDAgcmF0aGVyIHRoYW4gb25seSB3aXRoDQo+IG51bV9tb24gPiBDRVBIX01BWF9NT04uDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1tZXJAdHUtaWxt
ZW5hdS5kZT4NCj4gLS0tDQo+ICBuZXQvY2VwaC9tb25fY2xpZW50LmMgfCAyICstDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9uZXQvY2VwaC9tb25fY2xpZW50LmMgYi9uZXQvY2VwaC9tb25fY2xpZW50LmMNCj4gaW5k
ZXggZDJjZGM4ZWUzMTU1Li42YzVmODMzNzkwNTUgMTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBoL21v
bl9jbGllbnQuYw0KPiArKysgYi9uZXQvY2VwaC9tb25fY2xpZW50LmMNCj4gQEAgLTExNCw3ICsx
MTQsNyBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbW9ubWFwICpjZXBoX21vbm1hcF9kZWNvZGUodm9p
ZCAqKnAsIHZvaWQgKmVuZCwgYm9vbCBtc2dyMikNCj4gIA0KPiAgCWRvdXQoIiVzIGZzaWQgJXBV
IGVwb2NoICV1IG51bV9tb24gJXVcbiIsIF9fZnVuY19fLCAmZnNpZCwgZXBvY2gsDQo+ICAJICAg
ICBudW1fbW9uKTsNCj4gLQlpZiAobnVtX21vbiA+IENFUEhfTUFYX01PTikNCj4gKwlpZiAobnVt
X21vbiA+IENFUEhfTUFYX01PTiB8fCBudW1fbW9uID09IDApDQoNClRoZSBwYXRjaCBtYWtlcyBz
ZW5zZS4gQnV0LCBJIHRoaW5rIHdlIG5lZWQgdG8gcmV2ZXJzZSB0aGUgb3JkZXI6DQoNCmlmIChu
dW1fbW9uID09IDAgfHwgbnVtX21vbiA+IENFUEhfTUFYX01PTikNCg0KSXQgd2lsbCBsb29rIGxp
a2UgbW9yZSByZWFzb25hYmxlLCBmcm9tIG15IHBvaW50IG9mIHZpZXcuIFdoYXQgZG8geW91IHRo
aW5rPw0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCB1c3VhbGx5LCBDZXBoIGNsdXN0ZXIgaGFzIG9k
ZCBudW1iZXIgb2YgbW9uaXRvcnMgKDMsIDUsDQpldGMpIGFuZCBub3Qgb25seSBvbmUuIEkgYW0g
dGhpbmtpbmcgc2hvdWxkIHdlIHNoYXJlIHNvbWUgbWVzc2FnZSBpbiBzeXN0ZW0gbG9nDQppZiBp
dCBpcyBub3Qgc28/IFdoYXQgZG8geW91IHRoaW5rPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAg
CQlnb3RvIGVfaW52YWw7DQo+ICANCj4gIAltb25tYXAgPSBrbWFsbG9jX2ZsZXgoKm1vbm1hcCwg
bW9uX2luc3QsIG51bV9tb24sIEdGUF9OT0lPKTsNCg==
