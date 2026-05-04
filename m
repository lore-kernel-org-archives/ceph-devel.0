Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424D3A1CF3;
	Mon,  4 May 2026 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924063; cv=fail; b=HP+pQJRR5HoruxZbbsedKKsEexQ+teaFTOQ1sL/muRmcHNcArgwVYIdmLZp3afQuW+sl1BfObpD+TJOniCIpvpFw7O2n0MDb0+FDRI0/9kf4HALxLKgMbsTL9+2K2oLnj92px1HTd+oIhcFZsvgiPiS4Chp8XKE6JQoutu+POS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924063; c=relaxed/simple;
	bh=DS+3pj3+vzsdyMMo8wzgsuvwZGbPoy01w2AHVQk9xlo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Q3TixhF191B/4Kp46GrJHKXxrSVSAT910M4wAnoD++A8GiK8o0jmtVg+GdV5TBvSUKKbqARo/nSW8WlaJPIzg2jgVhpg6l7cytMBRc2NvO5aEnJvQ/9ZB3yDBEIaGFHVjjzwfmRo5KZZF0VzF7BXo2P6x1W3v1XsbiDe4xQLBAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kb0y/Emf; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kb0y/Emf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644AJRV31472091;
	Mon, 4 May 2026 19:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=DS+3pj3+vzsdyMMo8wzgsuvwZGbPoy01w2AHVQk9xlo=; b=Kb0y/Emf
	eTpXOOJ8QrS7ACN12L6DlNF74LUmGCula5OX35wXqlMT6YywKe9p2wHm5U+ZzteD
	mtcLLUD62WjL0xzfsp2pxyDs5EF4/YxnqjDdNILW+RWR0YCdLgHLIVokhtCy/QiA
	sFy3NbmKmESSRzsHvQ2tYqBMCNUuCkt8dvO3GinncprbyWlcylhmkRiUAr9hT+B0
	Q2WFoCpLE68BgTCEDWUr3xZneheLaiwcuE5ZvSaKmAysB7XtKjUikupR4scURuzp
	JpQIOIZ26p7+ltnLzzdUavjRK1tGz624Q7PBXRI5gMBWawDtpPAy24I1PaLGTCx/
	hqlYdVqTzlny2g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v78pmv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 19:46:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJgN0jj037vaz0Pc+bd8XCR1hz9anEhBxNthOV6MlEMKHhl6zfg+dbqZp92C7Rg/GeEurW3E35YpP2/WorVwJ4WUbw0MqnNbHLRUYyT5JJdYDheuYby8wFtszmmhkla3fq25xYbLNMI7oiD1+eLVgfoPnMAOQax23mE4GAd1puRD9bqM+IR9gG3WKlfo6lLtjAKaJ+IUvCGgzAP7/AkWhHwYPoyyVLrZyhRCder5YItEtJJQaOH+FN2p98r1YNdx5+BHpx5w7xzgX42HzP++mFHMfswN+ot5zHm2Jpq/xo4j+WUhuOHyA81BIaHGlLg1T+KFHt5qmHhNWKlSBanErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS+3pj3+vzsdyMMo8wzgsuvwZGbPoy01w2AHVQk9xlo=;
 b=YG7Tu8H0fAHlEOn9RBMsHwC2Sja/OGg1nJm3iOvKUEMMK4OEuxYGFNQRC5DGKGT4SJdJZTJeEx1fihhmm9pmASXhtEN6MOYR43eYLz+e90/HJEJB0RMmRLYN5ZTJkD9sjxxnlIFYTGwiCIqmpOtOt+a3R6srlHTS8bspicXkpsj9dv437rNmqhOf1xU4BGDSWtneq+S87chVLnC1rONW/CN75TX5zJlvl2fTOR9t9u1fdVUPMsoCRWQgLu+VwrbR69in9Zk+qbIFkdw1TmN/8d6UvGXaENVMbcPvceqJ9h/kHelAM4efBqKHU1b7bgYmQJJ9zbhzLxy6aohCRsdxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MN0PR15MB5372.namprd15.prod.outlook.com (2603:10b6:208:377::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:46:54 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:46:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "mishra.dhiraj95@gmail.com" <mishra.dhiraj95@gmail.com>
CC: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "w@1wt.eu"
	<w@1wt.eu>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v4] libceph, ceph: reject oversized mon and
 MDS data segments
Thread-Index: AQHc26bDdInxBEUpdEyF8kfydhMgkLX+RjWA
Date: Mon, 4 May 2026 19:46:53 +0000
Message-ID: <51c2d30565ec36691c47d0ae7e42065ece813ddf.camel@ibm.com>
References: <3fb2610b-5240-41ff-a5d9-699a445dffd3@tu-ilmenau.de>
	 <20260504091635.17215-1-mishra.dhiraj95@gmail.com>
In-Reply-To: <20260504091635.17215-1-mishra.dhiraj95@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MN0PR15MB5372:EE_
x-ms-office365-filtering-correlation-id: 16774251-2b1a-40f9-901a-08deaa15e4b1
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 DQLno+fRM75VQ4VNsCIrp5AH6sTWKNJ3Iqqcr3mXJkS7IjTSVCD4HGEGJo/j71scjb1fhbZWFlDtXXOLQBqi45TU2rbnTBuzi6R4Vmwx/FhbjyTZ1bkHMW6Cp2FcHbeTdvGl0u8uXkMkA2/aqoegUh7jy1IE0gBZxl4DjGFjbI+O1qF9bZ8EJdpuS5zcVyPm2EC5NdQGEjrrGOKdknXnQNhCtSBuUXHCpng6Rb7Pm7ottMsGyDO2MHNf09DQJoPIK/k2b1NIvNWNGeHUY3fKm7m5xec/bxAP4jnYW5+fS0oQI2rJVUz9niJXhgCfwp37JwEugc16QVeVa3mlSL6OYJvv7QHSSCSp7XXDYM6inNX9GBmh0TSN1++LDgs/gMvczZtpn5KfBGZTkc7vePtLmhljjtlaW7UjIMXUp7Nj0PQm0MUFBdHGOoW21BYqENmh3KNWuApIRSNKR9irFRK/g0kEP1U0Bf1rHmmNqpNFfsWF8a51scEJi8/+VwmOpi2GKNvER8zB8KT1VuHBJuRKxaKlr+/K1nOIRJJN1vmYD2xY4xNae5mHA4C84E1aJTknUlDCET82B6wzu1UQXIkhYUd+83VMbOpv3NSVTWbced2LYpphwYqtlUEC2WGEnEnfRWJKJBEJ2hS9IRoUPVqavNlcIQ8zfN0Kf9obsvSZQb3KhvPMFH5xPU9i+T7TVzmPkCwrB0Rm2zCw/fre6yB77/WYuLW3xVx7v7zyiT1a9CK9AOcVdhWqr6v2H4LGo/GV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1ZYVXBUSGFJVjc0Ri90bFFzcWY0OUNlNGNxQnMycTJFU2o5bWpKcFRyS3hr?=
 =?utf-8?B?bDk2dTNqV1UvVEVDVjR1UDFESkt5QW05SkZoUWpFQWhUOVQ5QTlDQk5QVDIv?=
 =?utf-8?B?d3ZFejdMQkt6elM0eGVrMlFJZlpCSk9GdXY0Ni9pRTVFK2F0WC9YNGpjN3VR?=
 =?utf-8?B?ZHNMV0dFOUo0T1NOM05YY3NBazJ5MnZSU2NlWTNLQ2lFNURoZUJuQlR0N1dv?=
 =?utf-8?B?dE1CZGpiU3haeWp5d0JNZnd3QVdFck44aWxZYlNrSFc3MkVjRFN0Y0RIUzBR?=
 =?utf-8?B?VnpqVFp4elRvSlJsMWVGejFrUzRIKzRBZmFiMEZRM2k4b3VURWJwVW1OclhZ?=
 =?utf-8?B?OXlvbHZwSHdqSjkydWhYcnBnd1NMaUFCbFY0MXd0Z1B6bU41eXdKQWxCNURD?=
 =?utf-8?B?aWRXNEN1dmJoUng5dGljbXRJRXQvMVduTFJTeE9nNm9pMXUrUnFYQ1dxMm1h?=
 =?utf-8?B?ZHUrWDE1VS9CbDhlOElyL1I4OUNQUURhcXg1MGdKdGRmeVBFckc4TmthcVM5?=
 =?utf-8?B?Znl0V3RuTG9DcGM5ZXREOFFwR0lzcmdOaW1wdHVkWVhsNndIQVVTakttZndx?=
 =?utf-8?B?dGc0WXNtRVplemVTTitaWlNSVzBLNytURGRpQ0JTbVVEdVVCWllNTXZCT2lj?=
 =?utf-8?B?V2F2VXJIVThSOW8zNjkvQnc1eE5mMmtyS2pNNXRvRjNPOVArL0pxMThmRURO?=
 =?utf-8?B?QzZqOG1Mem1SdXNlNHhhdWM0UjArUFR4UG9WNGYvVG4reHo4YnlJQ0UwZCtK?=
 =?utf-8?B?WmZGYTc5aDFLSUppU0NGejdXRHByM3F0WUgxUi9PY2FJSXVqcXdqbXJWc1Q0?=
 =?utf-8?B?aDhNYnlWS0E5U1hubHRyMGZUVUlWMDZjWkd3WGM4NzRsbmVvV3ArcE53blVW?=
 =?utf-8?B?QXZDeWh3RDZuKzVyNElPNm1paWEwUkVXUlBCbjRva3VVSFVsSHRtQVdMNU1p?=
 =?utf-8?B?UjJTakMrZlpTTSt2UGJLN2ZGN2xWUVhrd2Faa0pINEt5Q2lZbGQwcGovdFMr?=
 =?utf-8?B?MnVrRS83Z1FOMWtUZWlIRHRqM1pHL1o0TDM2b1l1eG5XR0R6RHBZUmxQenRu?=
 =?utf-8?B?MFJNelJnT0dCbnF4bk1VWDVBWkVnYWd6OEx4aVhYM3pGZUJoNzJPZFhKWlI4?=
 =?utf-8?B?ZE5wR1BDQ2JldHhvbEtubGlPUXpPOUhRcHNYampjN2ZjT1FieElIRTJXdEZW?=
 =?utf-8?B?Z3diVWdtNHllbjRXb2RSc2Z3Z01haEJVdEc1U3VwdGU5YmthZm5GMHlMdmx2?=
 =?utf-8?B?eU0xaFlKUWN0eTVDMDZHMFhITXRKajR0V3E4ekdYa21IK2xyOFpPbndHWEJU?=
 =?utf-8?B?VnI1UkVoM2F0RlBiVGZiMkJIakdnRTZWQ1YwVHNLYXVMRUtnaVA3UHJ5ZUZo?=
 =?utf-8?B?cHdJQzVKSDJtb3dnSXRJNFhQREZLaDM1N0M5RllUUVRsdm5QT1dJVGtyc1ZH?=
 =?utf-8?B?cXlIOWdGUlJlcDN2SDBRbDVQVUVhb242VW93R2xOMTI5R1R2amVnK3hDME1E?=
 =?utf-8?B?NzQ4MlpzSEV6aGNXUUJ0ZGZLUmdPcWsyTnBpZnF2ZjlZV0FqZWplS1B2Z0VZ?=
 =?utf-8?B?Z3YvcWFpa0p1Z3RpM2k4UklPM3lDSGQ3Z1E3ZTZYd0dKekpFbGw2RVpWZ1J4?=
 =?utf-8?B?U2JGZFN4ODlhSDBITmR1WDNEbVovV0N1SlIxWk1USGkxb3VNcUVUcjAxMmYv?=
 =?utf-8?B?TTJ6elNJbk5HMkJRa21yRjFMWDdwd3MyM0R1TmVYRWZtRTdmQUNkMGxybFRa?=
 =?utf-8?B?MTJMNDViRlNaTkJhcW5WWDEwMGtJd0dnMXVqY1k2OFErTU1GL2xhSncvT2Ro?=
 =?utf-8?B?YWltS0duUjZZLzlQeHRGYUo5RmJQMDh5NlYxbldobTJnLy9STlN3dVkydWgy?=
 =?utf-8?B?cU4ySU5qL3dKbDJzUmFkcGpsQ05JU1BhWkl4bkJOckdwTUtxQkJlRG5JZVRX?=
 =?utf-8?B?dDNnbHRiR1J3Rmxxb3JlTm95cmpBVjk2K1NHcGt6ZnI1eXhxeWpJbmVEQW5G?=
 =?utf-8?B?MWhWc0J0c0FZMml3UDNyakdwZ2Y0L0wzME1MVTlhN1JaeWwrbnFXOVpraTN5?=
 =?utf-8?B?TU5KcHFQUHZFVml0OCtqMmgwZVEwRFJ4RTFtbGlCQ2NrQkcrTEZaZjNITUhv?=
 =?utf-8?B?Rlozd0ZYOThqK0dERGp4QXIyY1hrSHh1TUo5Y2cxdnozdEJVYm1JTTJ0NGNW?=
 =?utf-8?B?Z0xYSkg4ZWRJdWlEZHkyRkRTTW1HaDdkVVMwckVPR2p4dVFyQ1JrTko4bG11?=
 =?utf-8?B?WnVZMGl2amFZRkRCbEw3VFJQNXBhekxPWGs2cnVVdzBvZ2R1djdSWStoU1NG?=
 =?utf-8?B?RlFmYjdNWGUzOTlXeWdwb3lvejNzdTlJWkR1V3FJRGFEalRJdzZ5RVM3bFkz?=
 =?utf-8?Q?ei+p27nBFfsR9GXFb8gdMlXvvX5RXDqaUzqMG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35933288BC7F684589AF921D0390142C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IPlx+HXJ9CZ6WpMCW051VxACo/T2HQQ5ctflpozjuaKFvZCqI35jZBIabj7S5cZioZ41rlIVwDntcChucOC8jRyJiuNbvE0XcMFkJLA0El5X/HdZvNhN0RzoD4d4JyCQs22OeHgCd60NMk+zrSGx19aAYeF2WRxaZY55BB/2NWM//+BlT/OY/yUb0iyY1HUYF/Wp2W6s2V8yGj2BHUPNJ+epxqvp+ruxl02NWo/xLnNEDXOESII/4VqLGu01B0SBL/eP+RZlc/aOvL+81bRpfRV29sQDbDlVzjUACusL8uOxlpy8DrDFADm54gsnWEl0QLiQhsugKVXi61PlAmDxTQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16774251-2b1a-40f9-901a-08deaa15e4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 19:46:54.0041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O30PJIT+CUYoegjMkBXUA2aF1V/SFAEqTQXfNO5yo3PSkyMZ1Y+An2Ek5UUGVs+nBsOrKHhNLYz1LsvHj27Q2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR15MB5372
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE4MCBTYWx0ZWRfX29k2SgfREUIG
 Zpn9p/hjI8Jxl/wopa1xAeKKcDlk1gl3LjM9LT9WbLAYNDnfsS6JFBm1I0U/UxrTTGB+4F7D64v
 Oid0qjGJS4jB5Y0qIlbTuMcylSIUU49Y7VghWbabwlRh6tUW0PHrnqUd1MGVNjbSnOzRHvoA+y/
 YLQKz5fAQOm0Lt0W+UeHfy5/MseCE9go2LMvS5ZhpqUcdlirzzgDAtW4ZJEoAiAtT/Q0D1ghEX3
 irdF/9IGPjmDDg3uzWXTHMb8BAi2so0GuU9Fo51FN6SbUckEtex1dC0OFOAiCT1krrZs2hwqqDG
 XPnbcXhdHLZMs+a1jiVYiQhptOA7I2guHG9yPUz8dAa0HC9stHdURn22joxrMy4TP6LwPOBQXbA
 p+/SBPIj30c7pZG4Q/76r8sCIHKIlKtaB8ICBwlPP/qENOtn6gfoFqfqO2XlZGLe6RziCHJhzUU
 9xzszSSv+AelcGdcktQ==
X-Proofpoint-GUID: _xQqdN0uw90gYlwle7xkXkYLnEy_C2A9
X-Proofpoint-ORIG-GUID: PSJbL4LGayYlDjn6-XGvZ6GV7q93L8zc
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f8f7b4 cx=c_pps
 a=zLftBE+EtYxwi/BgDV84wA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=UZA924jZWw9ya7iwS0sA:9
 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH v4] libceph, ceph: reject oversized mon and MDS data
 segments
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040180

T24gTW9uLCAyMDI2LTA1LTA0IGF0IDEzOjE2ICswNDAwLCBEaGlyYWogTWlzaHJhIHdyb3RlOg0K
PiBNb25pdG9yIGFuZCBNRFMgbWVzc2FnZXMgY2FuIGJlIGFsbG9jYXRlZCB3aXRoIG9ubHkgZnJv
bnQtYnVmZmVyIHN0b3JhZ2UNCj4gYW5kIG5vIGRhdGEgaXRlbXMuICBUaGUgbWVzc2VuZ2VyIHJl
Y2VpdmUgcGF0aCBjb3BpZXMgdGhlIHdpcmUgaGVhZGVyDQo+IGludG8gdGhlIHNlbGVjdGVkIGNl
cGhfbXNnIGFuZCBsYXRlciB1c2VzIGhkci5kYXRhX2xlbiB0byBkZWNpZGUgd2hldGhlcg0KPiB0
byBpbml0aWFsaXplIGEgZGF0YSBjdXJzb3IuDQo+IA0KPiBJZiBhIG1hbGljaW91cyBvciBjb21w
cm9taXNlZCBwZWVyIGFkdmVydGlzZXMgYSBub24temVybyBkYXRhIHNlZ21lbnQgZm9yDQo+IG9u
ZSBvZiB0aGVzZSBmcm9udC1vbmx5IG1lc3NhZ2VzLCB0aGUgcmVjZWl2ZSBwYXRoIGNhbiBjYWxs
DQo+IGNlcGhfbXNnX2RhdGFfY3Vyc29yX2luaXQoKSB3aXRoIGxlbmd0aCBncmVhdGVyIHRoYW4g
bXNnLT5kYXRhX2xlbmd0aCBhbmQNCj4gaGl0IGl0cyBCVUdfT04oKSBjaGVja3MsIGNyYXNoaW5n
IHRoZSBjbGllbnQga2VybmVsLg0KPiANCj4gSSB2ZXJpZmllZCB0aGUgbW9uaXRvciBpc3N1ZSBh
Z2FpbnN0IHY3LjEtcmMxLTEyMy1nZTc1YTQzYzdjZWM0LiAgVGhlDQo+IG1zZ3IyIHRyaWdnZXIg
cGF0aCBpcyBwcmVzZW50IHNpbmNlIGNvbW1pdCBjZDFhNjc3Y2FkOTkgKCJsaWJjZXBoLA0KPiBj
ZXBoOiBpbXBsZW1lbnQgbXNncjIuMSBwcm90b2NvbCAoY3JjIGFuZCBzZWN1cmUgbW9kZXMpIiks
IHdoaWNoIGlzDQo+IGNvbnRhaW5lZCBpbiB2NS4xMS1yYzEgYW5kIGxhdGVyLiAgVGhlIGFsbG9j
YXRvciBwYXR0ZXJucyBhcmUgb2xkZXIsIGJ1dA0KPiBJIGhhdmUgbm90IHRlc3RlZCBvbGRlciBt
c2dyMS1vbmx5IGtlcm5lbHMuDQo+IA0KPiBBIGNvbmNyZXRlIG1vbml0b3IgdHJpZ2dlciBpcyBh
IG1vbml0b3IgY29ubmVjdGlvbiBvdmVyIG1zZ3IyIGFmdGVyDQo+IENFUEhfQ09OX1NfT1BFTiB3
aGVyZSBhIEZSQU1FX1RBR19NRVNTQUdFIGNvbnRhaW5zIGEgbW9uaXRvciByZXBseSB0eXBlDQo+
IGhhbmRsZWQgYnkgbW9uX2FsbG9jX21zZygpLCBhIHZhbGlkIGZyb250X2xlbiBmb3IgdGhhdCBt
ZXNzYWdlIHR5cGUgYW5kDQo+IGRhdGFfbGVuID0gMS4gIENFUEhfTVNHX01PTl9NQVAgaXMgb25l
IHN1Y2ggZXhhbXBsZTogdGhlIG1lc3NhZ2UgaXMNCj4gYWxsb2NhdGVkIHdpdGggY2VwaF9tc2df
bmV3KCksIGxlYXZpbmcgbXNnLT5kYXRhX2xlbmd0aCBhbmQNCj4gbXNnLT5udW1fZGF0YV9pdGVt
cyBhcyB6ZXJvLg0KPiANCj4gVGhlIE1EUyBhbGxvY2F0aW9uIHBhdGggaGFzIHRoZSBzYW1lIGlz
c3VlOiBtZHNfYWxsb2NfbXNnKCkgYWxsb2NhdGVzIHRoZQ0KPiBpbmNvbWluZyBtZXNzYWdlIHdp
dGggY2VwaF9tc2dfbmV3KHR5cGUsIGZyb250X2xlbiwgR0ZQX05PRlMsIGZhbHNlKSwNCj4gbGVh
dmluZyBtc2ctPmRhdGFfbGVuZ3RoIGFzIHplcm8gZm9yIGEgZnJvbnQtb25seSBtZXNzYWdlIHNl
bGVjdGVkIGZyb20NCj4gYW4gYXR0YWNrZXItY29udHJvbGxlZCB3aXJlIGhlYWRlci4NCj4gDQo+
IFJlamVjdCBtb25pdG9yIGFuZCBNRFMgbWVzc2FnZXMgd2hvc2Ugd2lyZSBkYXRhIHNlZ21lbnQg
aXMgbGFyZ2VyIHRoYW4NCj4gdGhlIGRhdGEgYmFja2luZyBhbGxvY2F0ZWQgZm9yIHRoZSBzZWxl
Y3RlZCBjZXBoX21zZywgbWlycm9yaW5nIHRoZQ0KPiBleGlzdGluZyBPU0QgcmVwbHkgaGFyZGVu
aW5nLg0KPiANCj4gRml4ZXM6IDUzZGVkNDk1YzZhYyAoImxpYmNlcGg6IGRlZmluZSBtZHNfYWxs
b2NfbXNnKCkgbWV0aG9kIikNCj4gRml4ZXM6IGNkMWE2NzdjYWQ5OSAoImxpYmNlcGgsIGNlcGg6
IGltcGxlbWVudCBtc2dyMi4xIHByb3RvY29sIChjcmMgYW5kIHNlY3VyZSBtb2RlcykiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBEaGlyYWogTWlzaHJhIDxtaXNocmEuZGhpcmFqOTVAZ21haWwuY29tPg0K
PiAtLS0NCj4gdjQ6DQo+ICAgLSBBZGQgdGhlIHNhbWUgb3ZlcnNpemVkIGRhdGFfbGVuIGd1YXJk
IHRvIHRoZSBNRFMgYWxsb2NhdGlvbiBwYXRoLg0KPiANCj4gdjM6DQo+ICAgLSBSZW1vdmUgdGhl
IGltcG9zc2libGUgIXJlcS0+cmVwbHkgY2hlY2sgZm9yIGdlbmVyaWMgcmVxdWVzdHMuDQo+ICAg
LSBVc2UgcHJfd2Fybl9yYXRlbGltaXRlZCgpIGZvciBtYWxpY2lvdXMtbW9uaXRvciBsb2cgc3Bh
bSByZXNpc3RhbmNlLg0KPiAgIC0gQXZvaWQgYWRkaW5nIF9fZnVuY19fIHRvIHRoZSBuZXcgbW9u
X2NsaWVudCB3YXJuaW5ncy4NCj4gICAtIEFkZCBhIGJsYW5rIGxpbmUgYmV0d2VlbiB0aGUgZnJv
bnRfbGVuIGFuZCBkYXRhX2xlbiBjaGVja3MuDQo+IA0KPiB2MjoNCj4gICAtIFJlc2VuZCBhcyBh
biBpbmxpbmUgcGxhaW4tdGV4dCBwYXRjaC4NCj4gICAtIEFkZCBmdWxsIGVtYWlsIGFkZHJlc3Mg
dG8gdGhlIEZyb20gYW5kIFNpZ25lZC1vZmYtYnkgaWRlbnRpdGllcy4NCj4gICAtIEFkZCBjZXBo
LWRldmVsIGFuZCBMS01MIHRvIHRoZSByZWNpcGllbnQgbGlzdCB3aGVuIHNlbmRpbmcuDQo+IA0K
PiAgZnMvY2VwaC9tZHNfY2xpZW50LmMgIHwgMTMgKysrKysrKysrKysrKw0KPiAgbmV0L2NlcGgv
bW9uX2NsaWVudC5jIHwgMTcgKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MzAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzX2NsaWVudC5j
IGIvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4gaW5kZXggZWQxN2UwMDIzNzA1Li4zYjkyZDM3OTgz
ZDEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQo+ICsrKyBiL2ZzL2NlcGgv
bWRzX2NsaWVudC5jDQo+IEBAIC02NTQzLDkgKzY1NDMsMTIgQEAgc3RhdGljIGludCBtZHNfaGFu
ZGxlX2F1dGhfYmFkX21ldGhvZChzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sDQo+ICBzdGF0
aWMgc3RydWN0IGNlcGhfbXNnICptZHNfYWxsb2NfbXNnKHN0cnVjdCBjZXBoX2Nvbm5lY3Rpb24g
KmNvbiwNCj4gIAkJCQlzdHJ1Y3QgY2VwaF9tc2dfaGVhZGVyICpoZHIsIGludCAqc2tpcCkNCj4g
IHsNCj4gKwlzdHJ1Y3QgY2VwaF9tZHNfc2Vzc2lvbiAqcyA9IGNvbi0+cHJpdmF0ZTsNCj4gKwlz
dHJ1Y3QgY2VwaF9jbGllbnQgKmNsID0gcy0+c19tZHNjLT5mc2MtPmNsaWVudDsNCj4gIAlzdHJ1
Y3QgY2VwaF9tc2cgKm1zZzsNCj4gIAlpbnQgdHlwZSA9IChpbnQpIGxlMTZfdG9fY3B1KGhkci0+
dHlwZSk7DQo+ICAJaW50IGZyb250X2xlbiA9IChpbnQpIGxlMzJfdG9fY3B1KGhkci0+ZnJvbnRf
bGVuKTsNCj4gKwl1MzIgZGF0YV9sZW4gPSBsZTMyX3RvX2NwdShoZHItPmRhdGFfbGVuKTsNCj4g
IA0KPiAgCWlmIChjb24tPmluX21zZykNCj4gIAkJcmV0dXJuIGNvbi0+aW5fbXNnOw0KPiBAQCAt
NjU1OCw2ICs2NTYxLDE2IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tc2cgKm1kc19hbGxvY19tc2co
c3RydWN0IGNlcGhfY29ubmVjdGlvbiAqY29uLA0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIAl9DQo+
ICANCj4gKwlpZiAoZGF0YV9sZW4gPiBtc2ctPmRhdGFfbGVuZ3RoKSB7DQo+ICsJCXByX3dhcm5f
cmF0ZWxpbWl0ZWRfY2xpZW50KGNsLA0KPiArCQkJCQkgICAibWRzJWQgbWVzc2FnZSBkYXRhICV1
ID4gcHJlYWxsb2MgJXp1LCBza2lwcGluZ1xuIiwNCj4gKwkJCQkJICAgcy0+c19tZHMsIGRhdGFf
bGVuLA0KPiArCQkJCQkgICBtc2ctPmRhdGFfbGVuZ3RoKTsNCj4gKwkJY2VwaF9tc2dfcHV0KG1z
Zyk7DQo+ICsJCSpza2lwID0gMTsNCj4gKwkJcmV0dXJuIE5VTEw7DQo+ICsJfQ0KPiArDQo+ICAJ
cmV0dXJuIG1zZzsNCj4gIH0NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvbW9uX2NsaWVu
dC5jIGIvbmV0L2NlcGgvbW9uX2NsaWVudC5jDQo+IGluZGV4IGQyY2RjOGVlMzE1NS4uOWYxYzdj
YTQyZjM2IDEwMDY0NA0KPiAtLS0gYS9uZXQvY2VwaC9tb25fY2xpZW50LmMNCj4gKysrIGIvbmV0
L2NlcGgvbW9uX2NsaWVudC5jDQo+IEBAIC03MTIsNiArNzEyLDcgQEAgc3RhdGljIHN0cnVjdCBj
ZXBoX21zZyAqZ2V0X2dlbmVyaWNfcmVwbHkoc3RydWN0IGNlcGhfY29ubmVjdGlvbiAqY29uLA0K
PiAgCXN0cnVjdCBjZXBoX21vbl9jbGllbnQgKm1vbmMgPSBjb24tPnByaXZhdGU7DQo+ICAJc3Ry
dWN0IGNlcGhfbW9uX2dlbmVyaWNfcmVxdWVzdCAqcmVxOw0KPiAgCXU2NCB0aWQgPSBsZTY0X3Rv
X2NwdShoZHItPnRpZCk7DQo+ICsJdTMyIGRhdGFfbGVuID0gbGUzMl90b19jcHUoaGRyLT5kYXRh
X2xlbik7DQo+ICAJc3RydWN0IGNlcGhfbXNnICptOw0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmbW9u
Yy0+bXV0ZXgpOw0KPiBAQCAtNzIwLDYgKzcyMSwxMSBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbXNn
ICpnZXRfZ2VuZXJpY19yZXBseShzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sDQo+ICAJCWRv
dXQoImdldF9nZW5lcmljX3JlcGx5ICVsbGQgZG5lXG4iLCB0aWQpOw0KPiAgCQkqc2tpcCA9IDE7
DQo+ICAJCW0gPSBOVUxMOw0KPiArCX0gZWxzZSBpZiAoZGF0YV9sZW4gPiByZXEtPnJlcGx5LT5k
YXRhX2xlbmd0aCkgew0KPiArCQlwcl93YXJuX3JhdGVsaW1pdGVkKCJtb24gZ2VuZXJpYyByZXBs
eSB0aWQgJWxsdSBkYXRhICV1ID4gcHJlYWxsb2NhdGVkICV6dSwgc2tpcHBpbmdcbiIsDQo+ICsJ
CQkJICAgIHRpZCwgZGF0YV9sZW4sIHJlcS0+cmVwbHktPmRhdGFfbGVuZ3RoKTsNCj4gKwkJKnNr
aXAgPSAxOw0KPiArCQltID0gTlVMTDsNCj4gIAl9IGVsc2Ugew0KPiAgCQlkb3V0KCJnZXRfZ2Vu
ZXJpY19yZXBseSAlbGxkIGdvdCAlcFxuIiwgdGlkLCByZXEtPnJlcGx5KTsNCj4gIAkJKnNraXAg
PSAwOw0KPiBAQCAtMTQ5OSw2ICsxNTA1LDcgQEAgc3RhdGljIHN0cnVjdCBjZXBoX21zZyAqbW9u
X2FsbG9jX21zZyhzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sDQo+ICAJc3RydWN0IGNlcGhf
bW9uX2NsaWVudCAqbW9uYyA9IGNvbi0+cHJpdmF0ZTsNCj4gIAlpbnQgdHlwZSA9IGxlMTZfdG9f
Y3B1KGhkci0+dHlwZSk7DQo+ICAJaW50IGZyb250X2xlbiA9IGxlMzJfdG9fY3B1KGhkci0+ZnJv
bnRfbGVuKTsNCj4gKwl1MzIgZGF0YV9sZW4gPSBsZTMyX3RvX2NwdShoZHItPmRhdGFfbGVuKTsN
Cj4gIAlzdHJ1Y3QgY2VwaF9tc2cgKm0gPSBOVUxMOw0KPiAgDQo+ICAJKnNraXAgPSAwOw0KPiBA
QCAtMTU0NSw1ICsxNTUyLDE1IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tc2cgKm1vbl9hbGxvY19t
c2coc3RydWN0IGNlcGhfY29ubmVjdGlvbiAqY29uLA0KPiAgCQltID0gY2VwaF9tc2dfbmV3KHR5
cGUsIGZyb250X2xlbiwgR0ZQX05PRlMsIGZhbHNlKTsNCj4gIAl9DQo+ICANCj4gKwlpZiAobSAm
JiBkYXRhX2xlbiA+IG0tPmRhdGFfbGVuZ3RoKSB7DQo+ICsJCXByX3dhcm5fcmF0ZWxpbWl0ZWQo
Im1vbiBtZXNzYWdlIGRhdGEgJXUgPiBwcmVhbGxvYyAlenUgKCV1IyVsbHUpLCBza2lwcGluZ1xu
IiwNCj4gKwkJCQkgICAgZGF0YV9sZW4sIG0tPmRhdGFfbGVuZ3RoLA0KPiArCQkJCSAgICAodW5z
aWduZWQgaW50KWNvbi0+cGVlcl9uYW1lLnR5cGUsDQo+ICsJCQkJICAgIGxlNjRfdG9fY3B1KGNv
bi0+cGVlcl9uYW1lLm51bSkpOw0KPiArCQljZXBoX21zZ19wdXQobSk7DQo+ICsJCW0gPSBOVUxM
Ow0KPiArCQkqc2tpcCA9IDE7DQo+ICsJfQ0KPiArDQoNCkkgc3RpbGwgZG9uJ3Qgc2VlIHRoZSBh
bnN3ZXIgb24gbXkgcXVlc3Rpb24uIFdlIGhhdmU6DQoNCgljYXNlIENFUEhfTVNHX1NUQVRGU19S
RVBMWToNCgljYXNlIENFUEhfTVNHX01PTl9DT01NQU5EX0FDSzoNCgkJcmV0dXJuIGdldF9nZW5l
cmljX3JlcGx5KGNvbiwgaGRyLCBza2lwKTsNCg0KSSBoYWQgaW1wcmVzc2lvbiB0aGF0IHRoaXMg
Y29kZSB3YXMgcmVsYXRlZCB0byBnZXRfZ2VuZXJpY19yZXBseSgpIGNhc2UuIEJ1dCBpdA0KbG9v
a3MgbGlrZSB0aGF0IEkgYW0gbm90IGNvcnJlY3QgaGVyZS4NCg0KSWYgaXQgaXMgbm90IHJlbGF0
ZWQgdG8gdGhpcywgdGhlbiB3ZSBuZWVkIHRvIHJld29yayB0aGlzIGNvZGUgdG8gaW50ZWdyYXRl
DQpzdWdnZXN0ZWQgbmV3IGZ1bmN0aW9uYWxpdHkgaW50byB0aGUgd2hvbGUgbG9naWM6DQoNCglp
ZiAoIW0pIHsNCgkJcHJfaW5mbygiYWxsb2NfbXNnIHVua25vd24gdHlwZSAlZFxuIiwgdHlwZSk7
DQoJCSpza2lwID0gMTsNCgl9IGVsc2UgaWYgKGZyb250X2xlbiA+IG0tPmZyb250X2FsbG9jX2xl
bikgew0KCQlwcl93YXJuKCJtb25fYWxsb2NfbXNnIGZyb250ICVkID4gcHJlYWxsb2MgJWQgKCV1
IyVsbHUpXG4iLA0KCQkJZnJvbnRfbGVuLCBtLT5mcm9udF9hbGxvY19sZW4sDQoJCQkodW5zaWdu
ZWQgaW50KWNvbi0+cGVlcl9uYW1lLnR5cGUsDQoJCQlsZTY0X3RvX2NwdShjb24tPnBlZXJfbmFt
ZS5udW0pKTsNCgkJY2VwaF9tc2dfcHV0KG0pOw0KCQltID0gY2VwaF9tc2dfbmV3KHR5cGUsIGZy
b250X2xlbiwgR0ZQX05PRlMsIGZhbHNlKTsNCgl9DQoNClRoYW5rcywNClNsYXZhLg0KDQoNCj4g
IAlyZXR1cm4gbTsNCj4gIH0NCg==
