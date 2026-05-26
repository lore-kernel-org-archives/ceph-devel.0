Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B62030A
	for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824801; cv=fail; b=PeBxdLeccep8pP+7JDIYd0ZMUHXpctIlDYrmqapLq5M7gihXkQYwJ9vRj4SWLXrdPbZjf/icscOFtBvoHiAp3qeN4aOsUcKFbMXKOrAcd4Zw8aHK9tZ+N/MRQvq7kZRX1iBjAnZDlHCLVGBwBwiiSU9EqrpBNZEUTPoaiSa4egQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824801; c=relaxed/simple;
	bh=apuimFCJSS7+rWZPe1sMyrq/9QO7f+6aEvWi1RPQmhE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BnHdRc8LLIOf3iewjtmTu5BoaZT1LlBsWVkDmXYf4jbh0pwZLm7OiDDI/1UIhnCaKHh3VSxo68m98rfOu6zYxQ2z2rklIxC4HvPmFqOTvewdR2BD7hkd3uA2J0YN8lnYd7tl7AGxi/CJ0Rjqg3lMOlhmy0yS5YIwy22uDpvs4h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oVaVeeF+; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oVaVeeF+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q8mMo62561051;
	Tue, 26 May 2026 19:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=apuimFCJSS7+rWZPe1sMyrq/9QO7f+6aEvWi1RPQmhE=; b=oVaVeeF+
	0hHRGsHRfWJNcUutcWvC6cW+N4bQ1DjTVCEqRCN5JbL/ZGTQwFoUUC0sY96bsb2M
	pnl1TNEqBF+tZ7KGH9RDRKbdjZXlVZNerRrr3g3klsCwxRhmIFbX3sa4dEoNdu+Q
	WPXyFtkd+U/Z9rCi7fpbQwRkSXSId05mufU4FJzFygGEowdxi8HZW9USTs1OFAjM
	ygbMw1ffUQ6zAGyG++TZaWfgM3xOBTMyJuf6wMADWkR8BtXwUhT2QQvisYfD4wHr
	5889htS5qcG1VgEcrQr66nJWg7VsGLq8vqHPhHnlSHLw504YOtmAJAflxlsJ/E5L
	Mw+RAC5i8MEd+A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq4y8x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 19:46:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMp1UAUGjM1jLGdpuv9JpI/A4gmabnax1H82ig1h5IA8pBWCxFGYdK9+VLGYjNYtRoHvINmoyY51KngO02Wp1WWjRPyaXpohFFl9czhBCr6Bdm8jUx0jlZhSAjGsTsK//ZhkGt5bYCTafysuLVAb3hQDpof3MtXiEn1AmDc7Sh4nC1/TVr/GdPUUky2hLjw4G+9au3yl7Y1mELZYyC2mfRwuFn7UTc3pfAHDY6y2ufBHw22V64TyqQ6MQMCafBH4FLmmUjcaTTZKQKgF9wZsP2TAZ1hl6YozQShI2x9C+PJtKCkbITmWYNJeZtXsUfNPpXM/MnDWsdNMYzEQMTYouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apuimFCJSS7+rWZPe1sMyrq/9QO7f+6aEvWi1RPQmhE=;
 b=ShLFtq4QX6B1EEJwXVU+g2zkM2MRfpsvy/KjiwLrmuvTgO9SR1ZoWy5BhoicIi7pWKtXlLYXYCUJIiw6MdBie/UQbOvyzsduL7oVkMvPKB8wcHZU7I6a+TDLps/0CrM+XSg2LeZF4swFVWVkcteuY22ZW6KJCwS7I62EmuBZQSRq+DeUdq+uDujCP75HgBqBaAwiBCJUYBPEJrzm2tIz8u0jf3iIe2CTlIWYZ94PNxyzDI2Bl7HW651lVOdb6N2qVXYsK/QuVp6tcKwrK56PQ3JDIcPhFMnw2y17/rEfKbWz88isKNejdunkE6GpfIfi9aBqFCekDyJg1pB+o1Cl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5925.namprd15.prod.outlook.com (2603:10b6:930:7d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 19:46:27 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 19:46:27 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "security@kernel.org" <security@kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Fix multiplication overflow in
 decode_new_up_state_weight()
Thread-Index: AQHc7TDl2VIENosa+kyWYWsviQIL7bYgtksA
Date: Tue, 26 May 2026 19:46:27 +0000
Message-ID: <0d08c0d7fb21e1ea834c7c75f9f0cf4c967f9c76.camel@ibm.com>
References: <8ece78d3-8a7f-4d7c-9619-ccc41f1bdd11@tu-ilmenau.de>
		 <20260526154443.3467352-1-raphael.zimmer@tu-ilmenau.de>
	 <47b69468215fd0748aa4ce95034b0a19ee8ccc15.camel@dubeyko.com>
In-Reply-To: <47b69468215fd0748aa4ce95034b0a19ee8ccc15.camel@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5925:EE_
x-ms-office365-filtering-correlation-id: 935c7185-c2ac-494c-e7fb-08debb5f79b8
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021|3023799007|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 RSETc1kL0/7zDvYiTte3LOS1rN9YjZ6fr+hCC05UuBTP+BUwNo5YpkH+CpdG7xWbbKTUA3dNpQBeInREIgdAy9yDZ7oZl+v6RPh8YUmI/f73WMEWgBE1DsSnRCz9IfZ53tA7uYHz0QWmBFLzRxZnZmf8u+jVQpmxu8enhEjoi6MPBA9z422efd9YOAZAJKUI3nFq+gJZQUAVdmUxatRzf5XeWjpXtdqnNLKTcDWlLDBULV9+MGLEnLCif45NOw5u+e7x8FHwWhg5RKe7hgUM1kXmbRcysxHwqj8O+kOu+1EvoMQPdLGDrpwf9H4BTvSeK8Kf4C90wZ/TkZ9zYc6mxZSwfauieuhODE+XdwVlODVPDKpOIvEVICl9E7dDlSa88qU+ovOFlb9buSwUyJRaIF+49alu0OWw0jzEFU/2PpkOOtF0vf0eHi+UNOQhmNVePcPK4kZ6F6kTe+KF8f8L+auC5PWFwG4qDJADFX88Ug9ynaGkFXxGkAYA1v7C5SDIaDTwIqdJcVk5xR4gRlZh16S70tLS7q7wiPA2LqnlO1JrLUHGiTxeqsvFpOt+6dI+XRmHjAMkN2mktw+nQGCQjXfx+xTYXPDpreutIv3mGuvJfntL03FPGLboT0NWd5Izk8BsPfsV/YZjppyn0aC75mjYmsXdolYqy3b9W4SO3jyNMBg6FNt7CZjteSam9qIByWyWTAJNZcbx2HmTXjmSPJyNKaERbl6EheuwDj4o86iDCihF/vXkZaj6Fp4vH+pQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021)(3023799007)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkpiM3l1SDhIYjFpZlB6eXdRbVE4Q0tuMTN2ckZPRU45WFcyNHJHck1pQ05K?=
 =?utf-8?B?TkRzTnBndTZrSDJxQ1pUdnpFYTBiOFc1SHNSQmloOVh0cjJnSUVvRnBsVFgv?=
 =?utf-8?B?ZmQ4em5jVmNpSmJ5TUR3dnY0RHEyYUpUWlJCb1UrNEkyd3lXWVJFNURHVkIv?=
 =?utf-8?B?YkhkOUtkZ0IyM21sUzNZSkZtUE40S0JmaGNTRWxvbDdIdTJ4RituNHBqK3I5?=
 =?utf-8?B?aWY0a00xbmlxcmp2UFh2U0RKemh1SS9tdnJ0L3ZvMVpqbWhRaWhCTytxUnV0?=
 =?utf-8?B?czhpUEFxRWZIYjdCSW5GaFhDd01NamtIbktndDNKdmFGNGlhK3FxMVk3MHA1?=
 =?utf-8?B?REFFQ1B6cE8zWjNnU2g2dEpQQ1E0Y1JRRmZNNnpRUlJaWmorSDVpTVpxK1pP?=
 =?utf-8?B?QVNBeVU2SVZqNVFTS1RJWmNUYW9NNnUzY09GaWVMWGdiLzJIbXZlV3UvUE5j?=
 =?utf-8?B?OWtPL1FXZWhkVGdzd1FlL1dTRFVrN1I4WjluRmJmZXoyRGU4WW5IQ2ZvQzBp?=
 =?utf-8?B?SElCZmIwOFpUR2p1WmRsZStwbkFsT3JyTzVsbVp6dVh6endOUjBoMlJMb2Qv?=
 =?utf-8?B?RVRLTmdDQ2FzekE1WlYvcjdjbXVMYkFLZkdETkJCQjNON1FTclEzRjdNQ29Z?=
 =?utf-8?B?N1VrUFhDVTZIdlFBaGZzSGtCeGo4OGFDWG1MdmkzQ044V2w2bkpReHBrME5m?=
 =?utf-8?B?bDB2QnlpMGRZSFdDRjFvSTNqV2E3VS9sTVE2Wlk2aWNoOC9SMURuSnFlbVJj?=
 =?utf-8?B?SzdsZEo5bkhFNHFYRlpBYVNXNXNoT0I2TFJZMkhic0p6bEZ1bXhwbE1IOUk5?=
 =?utf-8?B?THJGckY2SEhjNGJiY05Wd1BEdGVjVGxZWXlwOG9jbm9QTkN5eXMvbGVnSWpO?=
 =?utf-8?B?a1p6MXBEVEZoREZsbWM1QUVxdk5VSXRScDFaOFFKbGhSZ3VvaUxHVkRncVpn?=
 =?utf-8?B?cTZEWDhtQ25nVFlTTm9VMU9NNUU3dyt2WFdUcERUeEdHWE8xMlpQSGpYVksy?=
 =?utf-8?B?YmVJTmYrZ2pnS3RQT2FxQ2NFek8yeW1aamZpZW13Z1B3SnNXejFKYXdzdjN4?=
 =?utf-8?B?YzNQbFRpMUJpbTdVNHFDVGNhM2ZQTElrbVRicVRMQVNSVXYvd1h6UkZCV1U3?=
 =?utf-8?B?ZzQwUlU1WEpabmJVOHpqQnE4MUVFNFlQWUl1ME5udGZGK0xNK3pjdkJhNTBh?=
 =?utf-8?B?RXpaTmlzL3FOK3lQaWZpdEp1cHJ0NzdyM1Z1Sjl6ZVFQWURFVzRkZ2F3NWE3?=
 =?utf-8?B?UHg2OWQ4MWVOemdmT0VJWUpMTWptZll1a01sNFV1Y3hROHZubzlobkJNQ205?=
 =?utf-8?B?UXJncS9YSFI3N2JLb0NWTCtZakJvZkorTlRPcm41aTVFblA2Zkk2MVB1d2d5?=
 =?utf-8?B?QU5maWRVOVo0aSt2bTFMMnBwMkxjbkd4RHBvcDJxUTRIaHIzb2xXYjNHNWdB?=
 =?utf-8?B?YVRmNWpMek9xY0c1UHp4V1E4alZnQnVsUmRkTkxlQ0dMVVBkVlFBczlkUGxo?=
 =?utf-8?B?V3AvTzV2dk10T2ZMSkJFRDJxQXE4RkJKc2Jpd0F2Yk1UUVpJa1lYLzJUZzd5?=
 =?utf-8?B?ZG0zd21nbExPREFJVjRvbTBibmJtaXhmQnpNcWZWdEYvY2dYOFBiZVFZYW8x?=
 =?utf-8?B?RlJOQ010YnBxc29NV2RvL211Qkdlb21nbUVPNzFNMDR4ZFRPQzVYK1NST1I2?=
 =?utf-8?B?RXV6aWsrN1FZTVB1Tk5BN0kvWTAzcXRsZHQwTnV2Qmg4N1d6VW0zNFAxSnJU?=
 =?utf-8?B?aFdGalpibCsyRnM3VkpZWWh5M3FhbjBBL0d4b09kWFd0cm85UXNnVC9CelRw?=
 =?utf-8?B?alFrOEhWRFZXaWNVaFhXY3Z0dFZiS2paSTQ2SkZSendNYS9tQ1R2OGVSZ21S?=
 =?utf-8?B?WDh0dHZBOVdvd3doelZmRWM0QnlyMmliMmwrYjRQZUhZVjh2alIzeVdQOERU?=
 =?utf-8?B?WjJlMno1UWg3ZXY5T0xtcW1YUlZhSmVNSzZkbGhaMksxOHk1Qlg3S3plU0pw?=
 =?utf-8?B?Y2FISnBrWFU1dmtNVk9DcjFvcTNXa3RMNVNYSnlaWjM0QWJFb0xDdDJYY0xE?=
 =?utf-8?B?MzBWRnMyQmhnMm02U0tScWdhN2luQVBvaHA0UmFjdlZ6SEZPZVg5bTdhWkV1?=
 =?utf-8?B?Tnd2a1FiaktOblkwUklvNmRSSXhiQzlySjJJUUNsaVZybnY1RXEwenJVaWdP?=
 =?utf-8?B?SGxHa3RTdnA3U0wvOGNNSHBNaVhtSDRyWEQvRWFMdHQyU0tEM1Z4TGQzZld4?=
 =?utf-8?B?RHhQM3ZmMXhoelJkWm9wR1FzSEpaYm43ejlkbU1WT25FaFNEVUZSendua21N?=
 =?utf-8?B?K2pvTEhQQnBocWkvQm5mRXhmbk01RUFXQllUaytjaXNyemE2RHhpMEUwZGV3?=
 =?utf-8?Q?YDD6XENj5TwHu3LU9mvvvS9dsqfevlXk4UQO/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBCC2B93DF9E1346ADF3CD7DEE806CF1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	liBOFJZBnmLWqlCe8e1xwakYVwLm9CSnu/BrMQ6LZvQIgoAhQyHLqx10e/0jl4Y080SVjUoWaLsBkUwXl4hWxnKM09+zImF9BYNiO3zH53P0bkkvUbMnok9IGLF0b81gnyVEFz7jKP+KSpqzDGxCgpe8IKZml3oWmhdKA/oZUJhJDIEyMZ+h+wW+Wj8tOfeNdtZaf4V93juW60DLb50JLXLkq+TPyI62OQYrHPPyU0PT7yetrRIy/ed7B79KqV8qmXVPyrzWSBWeiwqRHAghZb+g3/A3f01HontxjQzdU5sNLKWdMF9vJ+FMFOcCjpP/K9ENxl3jtjw+A+7xbP+fIA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935c7185-c2ac-494c-e7fb-08debb5f79b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 19:46:27.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7b6P0HZsCsMcMx32dkHHsWPiCkQXp3TY0xi8KAq7imcjdqqS9PrTK/30NM7Ud6HixWQtukTpx3NGKWI5VS9SFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5925
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UESSxuU-F-0iCGXQKajzBNMB9SkBKpD7
X-Proofpoint-ORIG-GUID: bfo_-oSfkk-gOYkb7tyrhd3bAD8WVBil
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a15f898 cx=c_pps
 a=v9d8l4VwGb/BX2RVr192eg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=luT4n0fHJBfcchXFIMkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE3MyBTYWx0ZWRfX3nH1VH3ow+iY
 zM2V+0Vy64roGck7+mO6yvLrBlSDSavxrmUl/IATZ8p2WA2fBbVIRCb5z2z0LGpfHmfIRQa+axV
 FPPlPGycxSxX48jxMHXFgqf49kJFlzKvpZlwkbT880y+qB+gtzSfXQrY+bubghZHFSt1Gs9bdls
 uvR8UrjpLjrL8KEq58TlLbJJm9c1yGfQgqGz/NL4OhCKeC6vsRI9eXJSxQG/cZw6K44xc3wJAYx
 QppT6/axofqS5KHwSLbr6Uy5Yo2Is+/fPLZ8R0RQ0pi/YyWIOi8Kn4NbuN+1Nap4ZcHwBIExzYR
 fZdfiNtl7xTPhxm244GDZ3p3tYP0TBRaAALNC875GyUQ8yUS2xwq3jQpQuH11+ZvCD8qtwAizZg
 FDMtx+nqcVX3j4zgVdPSxNdMrXz1/ozlUZAm38V43BryfGedViF0EZw8Ti3/68C7mCwnm3Dl9gk
 glnHQdJiyDJwhT6ZcmA==
Subject: RE: [PATCH] libceph: Fix multiplication overflow in
 decode_new_up_state_weight()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260173

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDA5OjMzIC0wNzAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IENDOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZw0KPiANCj4gT24gVHVlLCAyMDI2
LTA1LTI2IGF0IDE3OjQ0ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToNCj4gPiBJZiBhIG1l
c3NhZ2Ugb2YgdHlwZSBDRVBIX01TR19PU0RfTUFQIGNvbnRhaW5zIGEgKG1hbGljaW91c2x5KQ0K
PiA+IGNvcnJ1cHRlZA0KPiA+IG9zZG1hcCwgb3V0LW9mLWJvdW5kcyBtZW1vcnkgYWNjZXNzZXMg
bWF5IG9jY3VyIGluDQo+ID4gZGVjb2RlX25ld191cF9zdGF0ZV93ZWlnaHQoKS4gVGhpcyBoYXBw
ZW5zIGJlY2F1c2UgdGhlIGJvdW5kcyBjaGVjaw0KPiA+IGZvcg0KPiA+IHRoZSBuZXdfc3RhdGUg
cGFydCBpcyBiYXNlZCBvbiBjYWxjdWxhdGluZyBpdHMgbGVuZ3RoIGRlcGVuZGluZyBvbiBhDQo+
ID4gbGVuDQo+ID4gdmFsdWUgcmVhZCBmcm9tIHRoZSBpbmNvbWluZyBtZXNzYWdlLiBUaGlzIGNh
bGN1bGF0aW9uIG1heSBvdmVyZmxvdw0KPiA+IGxlYWRpbmcgdG8gYW4gaW5jb3JyZWN0IGJvdW5k
cyBjaGVjay4gU3Vic2VxdWVudGx5LCBvdXQtb2YtYm91bmRzDQo+ID4gcmVhZHMNCj4gPiBtYXkg
b2NjdXIgd2hlbiBkZWNvZGluZyB0aGlzIHBhcnQuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRz
IGEgY2hlY2sgdGhhdCBjYXRjaGVzIGxhcmdlIHZhbHVlcyBmb3IgbGVuIHRoYXQgd291bGQNCj4g
PiByZXN1bHQgaW4gYSBtdWx0aXBsaWNhdGlvbiBvdmVyZmxvdyB0byB0cmVhdCBzdWNoIG9zZG1h
cHMvbWVzc2FnZXMgYXMNCj4gPiBpbnZhbGlkLg0KPiA+IA0KPiA+IEZpeGVzOiA5MzBjNTMyODY5
NzcgKCJsaWJjZXBoOiBhcHBseSBuZXdfc3RhdGUgYmVmb3JlIG5ld191cF9jbGllbnQNCj4gPiBv
biBpbmNyZW1lbnRhbHMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhcGhhZWwgWmltbWVyIDxyYXBo
YWVsLnppbW1lckB0dS1pbG1lbmF1LmRlPg0KPiA+IC0tLQ0KPiA+IMKgbmV0L2NlcGgvb3NkbWFw
LmMgfCA1ICsrKystDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL29zZG1hcC5jIGIvbmV0
L2NlcGgvb3NkbWFwLmMNCj4gPiBpbmRleCAwNzY3NjM0MjBiMWQuLjQ2MzhkZjdhZDIzMSAxMDA2
NDQNCj4gPiAtLS0gYS9uZXQvY2VwaC9vc2RtYXAuYw0KPiA+ICsrKyBiL25ldC9jZXBoL29zZG1h
cC5jDQo+ID4gQEAgLTE4NDYsNiArMTg0Niw3IEBAIHN0YXRpYyBpbnQgZGVjb2RlX25ld191cF9z
dGF0ZV93ZWlnaHQodm9pZCAqKnAsDQo+ID4gdm9pZCAqZW5kLCB1OCBzdHJ1Y3RfdiwNCj4gPiDC
oAl2b2lkICpuZXdfc3RhdGU7DQo+ID4gwqAJdm9pZCAqbmV3X3dlaWdodF9lbmQ7DQo+ID4gwqAJ
dTMyIGxlbjsNCj4gPiArCWNvbnN0IHUzMiBuZXdfc3RhdGVfbGVuID0gc2l6ZW9mKHUzMikgKyAo
c3RydWN0X3YgPj0gNSA/DQo+ID4gc2l6ZW9mKHUzMikgOiBzaXplb2YodTgpKTsNCj4gPiDCoAlp
bnQgcmV0Ow0KPiA+IMKgCWludCBpOw0KPiA+IMKgDQo+ID4gQEAgLTE4NjUsNyArMTg2Niw5IEBA
IHN0YXRpYyBpbnQgZGVjb2RlX25ld191cF9zdGF0ZV93ZWlnaHQodm9pZCAqKnAsDQo+ID4gdm9p
ZCAqZW5kLCB1OCBzdHJ1Y3RfdiwNCj4gPiDCoA0KPiA+IMKgCW5ld19zdGF0ZSA9ICpwOw0KPiA+
IMKgCWNlcGhfZGVjb2RlXzMyX3NhZmUocCwgZW5kLCBsZW4sIGVfaW52YWwpOw0KPiA+IC0JbGVu
ICo9IHNpemVvZih1MzIpICsgKHN0cnVjdF92ID49IDUgPyBzaXplb2YodTMyKSA6DQo+ID4gc2l6
ZW9mKHU4KSk7DQo+ID4gKwlpZiAobGVuID4gVTMyX01BWCAvIG5ld19zdGF0ZV9sZW4pDQo+ID4g
KwkJZ290byBlX2ludmFsOw0KPiA+ICsJbGVuICo9IG5ld19zdGF0ZV9sZW47DQoNCk1heWJlLCB3
ZSBuZWVkIHRvIGNvbnNpZGVyOg0KDQppZiAoY2hlY2tfbXVsX292ZXJmbG93KGxlbiwgbmV3X3N0
YXRlX2xlbiwgJmJ5dGVzKSkNCiAgICBnb3RvIGVfaW52YWw7DQoNCldoYXQgZG8geW91IHRoaW5r
Pw0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiA+IMKgCWNlcGhfZGVjb2RlX25lZWQocCwgZW5kLCBs
ZW4sIGVfaW52YWwpOw0KPiA+IMKgCSpwICs9IGxlbjsNCj4gPiDCoA0K
