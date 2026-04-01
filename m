Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396882DCBF3
	for <ceph-devel@vger.kernel.org>; Wed,  1 Apr 2026 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074695; cv=fail; b=h8heYG0BvmMQe5c3YM3nHcXu2yv/gjyzrNlz1tmqVRxMSyimgWmZ2yhTLx/SBgAuuseTGOqeewzUj9BeB0LPNjgz9/8EA6aBjzyX8dyNYruB0usl4NXzMh1rxgtW5qXO3HPMznmytrRZgNthoU1cWj8g4xdTJkqHyMKc+OC1SBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074695; c=relaxed/simple;
	bh=oRKftNASsD7mb8RE3cnmX6O/wKic+WyHLnfW/aEW5qU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=hAt1ulEHvolrfJiXPni3rhtE/cuV00Pggf+raZrZ+9ovoj7Ls3BGdPWfXi3UW23pyABsEzAvPgvAsR1M+iVouDWIb97cNnS2Xt4V1W+0sOqH8Mcg4qKUw8lY8XxiQUT558LxKU5vEv8gpd4eH9hhVGLIvXviEtQdIhRXSde5b8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LK1VLQxz; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LK1VLQxz"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631BNBZG237813;
	Wed, 1 Apr 2026 20:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=oRKftNASsD7mb8RE3cnmX6O/wKic+WyHLnfW/aEW5qU=; b=LK1VLQxz
	3lY306Yh1ow3Q9hBsWAimbnnOe2Uho/F9ogE9aiujIzhZgx+pMvAtvlPocnBTT4b
	IWqolQI5NjKCerZ5635SNh1d1jdmBhf+12fW7FLjLJVR7/J/PXs+jReQjs4cYj3H
	uk8cUDNlhw1YRIUWMWAu3xpYjzyDe5DbWCTJturFP90DQ9mLd/gKzHSyhpWbMGY9
	6d+HD5xm/tIKeL6CTETsyYXQjYMXLYw6hy//Vk2wGS/7uzB1gi9nA9k0DyG2tGjr
	UtvpI3GFVVDysDgv9NrwEq5elRy9u68N6E1QL4pwwT7rp7fKWJzFpZsEfO9XDO3Q
	QNie856VY8y1Zw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g224pq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 20:18:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwLIH2XTbk8OMKkKbt4QGVf5t41+Byf8HAfCuYjxjlCzZh2Oqh9neBf0rfC9oIOCbnmguzKGd2YJ4Bjz2Jhrp7WyVhn3KYakKOJWG+IMAD85+lryiHY4/koU891m0URI7c8mq/sdDDaw78nWp/AnRhylsjeotVJHsORrxrtCnz5xiON8lmEJKKgU+APf72ZFKW/6Ans9SNh44PSAhypkdgWZhgbYaKWKQ5jUp8llPrnk+FSKj7PhGWZOeJnvAABr1X8NEPIOAL8sHmPmNCJfd6AAHKy2c4x0OGDyhuoZcRNKuZBK1FeHoB8eV76mcVY1Xcelb+L+yRO5rlh2M6/NQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRKftNASsD7mb8RE3cnmX6O/wKic+WyHLnfW/aEW5qU=;
 b=YOF2bxTCm6CzIGjooqWyVP0w22Z3VK+9ta5m5SQotDy69mdw6JXCMdBBX4hK3sc8XAW0iV6mITmMs55l+uYZjdodu+q+zGSaFntHd//36Bduy6uUA5jkbSi1wB3tHBQIMTewFW6yD5veDNa/VzTSHeu+kAmLRfNvw9a6FdMMoC8tR0/wNgvu1xBzy4ZhPgEtiyMy38PeNlZH9RjtF3n/6QvPeE5WRNGzC7IAU/PNzhxPZKgi9RCAPp7O/5tWTTrDUdktxbCcW1SZTX9oNA73mYnR+pmfk/yLrFJBwnXQr7l51jzx8iOVpGjcGttmHoccDjq2vT2b8KaBOURhK68HLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5642.namprd15.prod.outlook.com (2603:10b6:510:27f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 20:17:57 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 20:17:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:[PATCH] libceph: Fix potential out-of-bounds
 access in crush_decode()
Thread-Index: AQHcwhRKH2AIoPpZq0CnCouiu/f0GLXKpRaA
Date: Wed, 1 Apr 2026 20:17:56 +0000
Message-ID: <d526ed150a7701095f02b73c302e06ec45eafc7d.camel@ibm.com>
References: <20260401135132.3642689-1-raphael.zimmer@tu-ilmenau.de>
	 <513d275666da93b1430124955e515704361a43ec.camel@ibm.com>
	 <264caf34-2b06-4dda-9c8b-a1e46d940621@tu-ilmenau.de>
In-Reply-To: <264caf34-2b06-4dda-9c8b-a1e46d940621@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5642:EE_
x-ms-office365-filtering-correlation-id: ee3411e6-994e-413f-8020-08de902bc35e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 /JBXqU1/AlMJ4be3qf5hxTwK90D1sZIVuESgdM8BFj4H3ClOHblPgV18Kw2/dGi0/nht10DN9i6McBzt0ZJWxb5Gp1BGiZVpcIObpGVcq1x1fL9Ntk/Utb+RY2d13LdKrRtUQo1mshYYNVKkYS5ywpgSjZXiDghtiEWPEVPQ9t4TYMOO/vDePUh6U4ZR5mYvbcoHuIWj84Vnw7O76viXxGGwjoqTMyQmJ3UJDXMaWxibWM1v6Ibu7BHqxkMgRBEqNP1OS15N9kQWUUysOS2M9YU3kmWHHjRFlzmz4kRZmAEVIjGI3OyeV4rGPllv3v05xmgbtKksfa/x2RBRnwn7mxvLIP4OCxBBSfzRxUfRY0mYRLvU8RsCpnIDLozoOdYum/y9etASuIld5LHc0Zf1v14MTIdQIQp6MtVaoJnyuKlRMVYdCOGC+8NjBmfx+XvOuGOJBnvmQ/HCX3ogNsgnXnvDcNqD3GiZXSQpfrUoXNFMTDkGi/s7s7xiFD5Eweyg+dKIZudFc1PWhYCwGejZwTz/Sb1sVnFR7PTmrczJdf6ILeEkQF2vedUCzG8iJ07gqoj/MmGp0OE6QI3QhSR2eouxw/UJNIs+QzUgVkLPlVK1iOuV69gB+fx9kXIJKR5hsIz/ezfR9oh/b9JH3utxKKxHMVvPINBwsu4An83UXWywDqZm0PiSPt+zUEsZT23oHthY97CAbkVQdtb8uTTLb8qt6TRFFJFGIdCveWNK7XYJjc9GRDHTpCFcI4+Aoo7f2tux98Q9nFNqNmim081E1NtHaW1r2hkJ0bm21CpsGbI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0ExQnBVbGpxSFZMZWE4KzlLbStzdjdSZkJYc0xZak5tR05mQWxFa2VMWUdq?=
 =?utf-8?B?SFZZZG5mRWVyUmoxdGdMd3AxRUJZU3FYSndXZ3RMMDJKeUNhb0xKVFE0Q2JR?=
 =?utf-8?B?VmFoNGdBUEx6b3YwN3VRRVNTNmllVzVvQkdObWRSOVJVK1FicTI0Zk1oOTNV?=
 =?utf-8?B?TGF3YTRuUTdpOUpKVDB1OVFkMDlvNFhYdGE2UGkycHkzaXFYNWhncnBBaEtJ?=
 =?utf-8?B?ZUNmMm82MGtwaFhrVkRNL3BTOXZxUG96cGdKUmN0M1NEckhqOEdDMENnTTVl?=
 =?utf-8?B?d1A0eXZNcFZDUFRGZERpTFV4eGVaTTFnVm12SVBiRTdsd2IyL3dYSkJreGFK?=
 =?utf-8?B?aVdnYzZjTCszdWdDcmN2bUEyOVJHN093ZXZHYmFTeFNTYzdoL2hXVmpKZmtp?=
 =?utf-8?B?dHRJL1lEK3pBVGJ0MDZtWFJ5NWE4RXF2alhScDJvYkFESzV1WVhyWjRidGcx?=
 =?utf-8?B?YXhKbUJlS0gwRTlVejZzNjFVRW1qeVpLdDhidGQwUlBiQjlkM0M1N3RnVlVF?=
 =?utf-8?B?Mzc3TEhtMGFmQTM4RWVONGtVZGpjOW1Pd1JoRm0vTnVJbkhkZFN3amg3Kzc4?=
 =?utf-8?B?R3lRa3R5QmZpUllhNnBkazJ3WGtyLzhrREJocWZ3WDZZSG0vWE8rS2lVUDkr?=
 =?utf-8?B?SDVlaVc4Z28zWC9mUUg2cjl5M2I1UW9tZUhRUElFa0dRdEdMd01QeU15bXFR?=
 =?utf-8?B?OWtpcEtLNyt3MEpmb2l1eTVGU1phWHpBK0c2cUFBWWV4NVBCVzM1WHpuZ280?=
 =?utf-8?B?ekZzNGV5dHFQMEErQ2FpTjV3RVZ1U1U4SHlpQXQ1N0ppNTh0d1VmbUozSXFF?=
 =?utf-8?B?S1kvdVRRMmxRT2llRVZpWGFKekJlMHRTOTBzMXJlRGxGUnB5STZpSlhDMVRW?=
 =?utf-8?B?c1U2N3hwbmk5djZlVXoyR21Hd0NNVzQ3UFdWL2VRai9lV2ZCdDM1MnNjMDJo?=
 =?utf-8?B?WVd3OXVCbXBUZHUxRE9UcEFlMDNGZWZ0Ty9CWmRLN2NzR095VERNOXFYb25M?=
 =?utf-8?B?NHlQQStKZ3ppRFEzSTlzZEZRcjdZaXd3N1Zpbi9jczdmTGdaVVVNTFJzQTlI?=
 =?utf-8?B?ckl6VmNTRlM4TmcxWW5hV2xCcHVEY0tMWkNmd3JOYkJkU05xbTBjb2c0S0sx?=
 =?utf-8?B?TnZoRTAwNTRTVmE2aENNMUlGbGZCL203R0NkbVpNTFNjeTNieEpMNjkxMTFz?=
 =?utf-8?B?VkVuT0dkTTFZMk52MEMxeVJ6TGl0Vys1TFB1bEtSTTdIYkNOcmNSUkROMHRi?=
 =?utf-8?B?ZG9QNlNWZUYxMm9GVEV6cnF5a1J6K3N6djBRNDJxT1NpVm5tMTM1bHRDSkJp?=
 =?utf-8?B?ODAwQi9wdmVBMGIrWDcrS1p2MzVFcjU4dlpZQ3dYVTRkaUVXWmxGdUN0Tjc2?=
 =?utf-8?B?RklBakpXUGxQUWo1T1dHYXo2bitqS1l1WUhxQTZvUmo1WnF1U2ZPRVNwQTI5?=
 =?utf-8?B?dzZ2ZUlKOXFURWs5ZDdUcXREVDdtdG5rSzRwcTBmVnd3WHRhdkpiTHdFWEta?=
 =?utf-8?B?eTYxVVh6RGN6OWxkZkpGWmFabnBEaXhmUmIrM1daNitFdXFLc1gvT2pMUk1v?=
 =?utf-8?B?alA2UXRZeWlKanBWdzdQdEdhZVlUOFpISnlkeGE5ZjVKWmtuT1MyN3ZUNWF2?=
 =?utf-8?B?bEtRUTl4bEtTOVJ5L2k2WnYwUi9Md1ZvL2JoV3cxazdDM01zZFFYK1JUQ2ls?=
 =?utf-8?B?WjluOTR4elVtL2tROVdhcG4zaHNDVTlLY2NtOFRlNjdqSzVORWErZzNINjJF?=
 =?utf-8?B?azVZcWZqSWhGQzFNTVVXMmhZaWF2OU5yVGxCa2NUY1ZzYk4vdEtPT3B6MGEr?=
 =?utf-8?B?KzdRb0RNWm8zU0wxYjdTdlZ6MWYwdWY5YTVtMnMwNGgzb1VwbmxYTkVJTjNp?=
 =?utf-8?B?YmVNR1d2ZnRlOExZWVlMbmZidzhuZ3hDaXd1MXNzY1VXSGNZZDZ2SnBuaGJ6?=
 =?utf-8?B?MjFpSFUwYU1McHNqcnlTRzhSU3JPOVBVaWhlV2xoT0dFQUJZMEkrSGw3WnRh?=
 =?utf-8?B?b1BpdTdpVTFSdmZpdGYwdEdtL2NzZlhGL3BKSFRXREF2UTNZYjVkbTBRUVNw?=
 =?utf-8?B?bWpuemdxamFWTjV6MFNxeXQ5cVhpUVA1MG9TYUtxbHh2N2gzSFhjUHVMMzh1?=
 =?utf-8?B?bEkwRzdlQ0Qxa2ZYb1FYMDNXNWxKUEJkSDFTMFpOeC9WYUdpM052OWQ0clc3?=
 =?utf-8?B?c3huK0VnOFVMbzU5WDVhSmJ1aWlPclJ4Z0t6ME03L3BwTm5rUTJ2eDA5a210?=
 =?utf-8?B?Z2o3VGE5SUVxSzcrREdBKzdpQUw1cVZCbmNhSVcvMWNGU3RobHV1ZUFlL1BF?=
 =?utf-8?B?eUJ0T3NRWS9LUXlNMHFqbFUwc0ZqdEYwNXZLYTRlckQ0bzdGcmlpV0gybW5R?=
 =?utf-8?Q?9auvx4cVGR0M9haNZ86P5Ah5+VZKRW6QqxBnF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <226A581948105141A1254F4E867E6077@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	om6cf4QG2AoSjNBJs/vElB6Pi9e7tiQNdvCWS2b43Q+d2qdzrECqCv6Pbm9M5GCIzePq/zo/YImTATrina/U5QuRVSIyMETS5JrxjwuG5/kOTkE7VEoVh7wVdQEO+IxlLqHi1qxsG1b4TkiAEg+W7gm8bTGsRxB1IqsPkJbPtfsENJ4fwRFg5iMKQTsJZKc8IHXH12RiV1bbdwZ88o9nd2zpSlHTTQGTCYP0ivLeCpiyboS0ueCU1m7KcFwQg94KxWb4FC4EvWTOAaHWNXyFdS3xNts18e+XIVU6Q+gfUoWpzd5dkkXjCOiVo41QojhTUhpfDLw8DXj+smYW3Yfmwg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3411e6-994e-413f-8020-08de902bc35e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 20:17:56.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5kpPmJgTxmg/Inn3QT0r/q9s9hnLD/ubfmL1Y0pNrwvSUVYn+pU5H82/0marCxHBF5xR5fhh0Ra4A7NwAzusQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5642
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd7d79 cx=c_pps
 a=q0do3moUNMjvKVsQ3EtoVg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=PeoQswcvL8bG3uXSXPkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: N0_8p0YzPn-iIvr9DjiPF8q9LsEMhTbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE5MSBTYWx0ZWRfX3AaMzXWe8M/X
 1B5Z04Hfs3+XKE6kRGFrkh9C3FAf16/2dq5cspeJ9WDdAU4Nwqv518uVa1oOV/hDpWulnc/s2fB
 jbhOj4kh9umKSmxphj/J1HYtvspgoZgAF8bIySaodRPn2LDih4vWHf9J5MHR6/QexG8ObO9qX/Q
 pOsttnhAIdT+54l5lRlqMFSZ2sniska1/yUKa66h/MJDNjDaoLxn/+++AFdhTVrl09oXeL4XnQ+
 H/HZ+25gzhaey/AEFqF2EVSxj2o/dOC1xP5V9Zzgzj3uFnV0blZ8Z9JnrEQ4Yo6bub58mXpPhAc
 TQk3k66Un+1ZO3HdTE8iPwRgK51PgGNBE36qc46fNL+mIev1fAFZKX4g1v9PKAvdws7sb4SM7zS
 e7mFG70s+cQwlI2n4UkoJMOdeznX7Oq/SsnAP61TyJ4MBVnumO0S7nSRO1JXaBWmXFcukkI4vdK
 UUIReqlndGbNq6v6S1Q==
X-Proofpoint-GUID: GLRh6-7jOXikRnApRs1rGR7_NJCsjmFg
Subject: RE:[PATCH] libceph: Fix potential out-of-bounds access in
 crush_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010191

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDIyOjE1ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gNC8xLzI2IDk6MDYgUE0sIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiBPbiBX
ZWQsIDIwMjYtMDQtMDEgYXQgMTU6NTEgKzAyMDAsIFJhcGhhZWwgWmltbWVyIHdyb3RlOg0KPiA+
ID4gQSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfT1NEX01BUCBjb250YWluaW5nIGEgY3J1c2gg
bWFwIHdpdGggYXQgbGVhc3QNCj4gPiA+IG9uZSBidWNrZXQgaGFzIHR3byBmaWVsZHMgaG9sZGlu
ZyB0aGUgYnVja2V0IGFsZ29yaXRobS4gSWYgdGhlIHZhbHVlcw0KPiA+ID4gaW4gdGhlc2UgdHdv
IGZpZWxkcyBkaWZmZXIsIGFuIG91dC1vZi1ib3VuZHMgYWNjZXNzIGNhbiBvY2N1ci4gVGhpcyBp
cw0KPiA+ID4gdGhlIGNhc2UgYmVjYXVzZSB0aGUgZmlyc3QgYWxnb3JpdGhtIGZpZWxkIChhbGcp
IGlzIHVzZWQgdG8gYWxsb2NhdGUNCj4gPiA+IHRoZSBjb3JyZWN0IGFtb3VudCBvZiBtZW1vcnkg
Zm9yIGEgYnVja2V0IG9mIHRoaXMgdHlwZSwgd2hpbGUgdGhlIHNlY29uZA0KPiA+ID4gYWxnb3Jp
dGhtIGZpZWxkIGluc2lkZSB0aGUgYnVja2V0IChiLT5hbGcpIGlzIHVzZWQgaW4gdGhlIHN1YnNl
cXVlbnQNCj4gPiA+IHByb2Nlc3NpbmcuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggZml4ZXMg
dGhlIGlzc3VlIGJ5IGFkZGluZyBhIGNoZWNrIHRoYXQgY29tcGFyZXMgYWxnIGFuZA0KPiA+ID4g
Yi0+YWxnIGFuZCBhYm9ydHMgdGhlIHByb2Nlc3NpbmcgaW4gY2FzZSB0aGV5IGRpZmZlci4gRnVy
dGhlcm1vcmUsDQo+ID4gPiBiLT5hbGcgaXMgc2V0IHRvIDAgaW4gdGhpcyBjYXNlLCBiZWNhdXNl
IHRoZSBkZXN0cnVjdGlvbiBvZiB0aGUgY3J1c2gNCj4gPiA+IG1hcCBhbHNvIHVzZXMgdGhpcyBm
aWVsZCB0byBkZXRlcm1pbmUgdGhlIGJ1Y2tldCB0eXBlLCB3aGljaCBjYW4gYWdhaW4NCj4gPiA+
IHJlc3VsdCBpbiBhbiBvdXQtb2YtYm91bmRzIGFjY2VzcyB3aGVuIHRyeWluZyB0byBmcmVlIHRo
ZSBtZW1vcnkgcG9pbnRlZA0KPiA+ID4gdG8gYnkgdGhlIGZpZWxkcyBvZiB0aGUgYnVja2V0Lg0K
PiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1t
ZXJAdHUtaWxtZW5hdS5kZT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBuZXQvY2VwaC9vc2RtYXAuYyB8
IDQgKysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gPiAN
Cj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9vc2RtYXAuYyBiL25ldC9jZXBoL29zZG1hcC5j
DQo+ID4gPiBpbmRleCBjODllNjZkNGZjYjcuLmRhYWU0MjMwYmYzOCAxMDA2NDQNCj4gPiA+IC0t
LSBhL25ldC9jZXBoL29zZG1hcC5jDQo+ID4gPiArKysgYi9uZXQvY2VwaC9vc2RtYXAuYw0KPiA+
ID4gQEAgLTUxNiw2ICs1MTYsMTAgQEAgc3RhdGljIHN0cnVjdCBjcnVzaF9tYXAgKmNydXNoX2Rl
Y29kZSh2b2lkICpwYnl2YWwsIHZvaWQgKmVuZCkNCj4gPiA+ICAgCQliLT5pZCA9IGNlcGhfZGVj
b2RlXzMyKHApOw0KPiA+ID4gICAJCWItPnR5cGUgPSBjZXBoX2RlY29kZV8xNihwKTsNCj4gPiA+
ICAgCQliLT5hbGcgPSBjZXBoX2RlY29kZV84KHApOw0KPiA+ID4gKwkJaWYoYi0+YWxnICE9IGFs
Zykgew0KPiA+IA0KPiA+IFRoZSBMaW51eCBrZXJuZWwgY29kaW5nIHN0eWxlIHJlcXVpcmVzIHRv
IGhhdmUgYSBzcGFjZToNCj4gPiANCj4gPiBpZiAoYi0+YWxnICE9IGFsZykNCj4gPiANCj4gPiBI
YXZlIHlvdSByYW4gY2hlY2twYXRjaC5wbCBbMV0gYmVmb3JlIHNlbmRpbmcgdGhlIHBhdGNoPyBV
c3VhbGx5LCBpdCBjYW4gY2F0Y2gNCj4gPiBzdWNoIGlzc3Vlcy4NCj4gPiANCj4gPiBUaGFua3Ms
DQo+ID4gU2xhdmEuDQo+ID4gDQo+IA0KPiBIaSBTbGF2YSwNCj4gSSBhbHJlYWR5IG5vdGljZWQg
dGhhdCB0aGUgc3BhY2Ugd2Fzbid0IGluY2x1ZGVkIGluIHRoZSBwYXRjaCwgYnV0IA0KPiB1bmZv
cnR1bmF0ZWx5LCBvbmx5IGFmdGVyIHNlbmRpbmcgaXQgb3V0LiBUaGVuIEkgZGlkbid0IHdhbnQg
dG8gc2VuZCB0d28gDQo+IGFsbW9zdCBpZGVudGljYWwgdmVyc2lvbnMgaW4gYSByb3cgd2l0aG91
dCB3YWl0aW5nIGZvciBmZWVkYmFjayB0aGF0IG1heSANCj4gYWxzbyBuZWVkIHRvIGJlIGluY29y
cG9yYXRlZC4gTmV2ZXJ0aGVsZXNzLCB0aGFua3MgZm9yIHBvaW50aW5nIHRoaXMgDQo+IG91dC4g
SSB0cnkgbm90IHRvIGxldCB0aGlzIG1pc3Rha2UgaGFwcGVuIGFnYWluLg0KPiANCj4gSWYgeW91
IGhhdmUgYW55IGFkZGl0aW9uYWwgb2JqZWN0aW9ucyB0byB0aGlzIHBhdGNoLCBwbGVhc2UgbGV0
IG1lIGtub3cuIA0KPiBPdGhlcndpc2UsIEkgd2lsbCBzZW5kIGEgdjIgdG9tb3Jyb3cuDQo+IA0K
DQpUaGUgcGF0Y2ggbG9va3MgZ29vZC4gSXQgbWFrZXMgc2Vuc2UgdG8gbWUuDQoNClRoYW5rcywN
ClNsYXZhLg0K
