Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18384028DE
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991169; cv=fail; b=bg9VBofDogwDttmCI/NK5bEBJCbxdR9dacYApS/0WYVkdOqRDgr3VFryGK+asBzLamvhGiMn0Gj7k3pEd0DREWbHZRsUSswSrxmdAsuuLX69WPxKPogOckUihKxZpLziwCuBMj4bBG0/T2YlbcK+V62O5HD5HP6zvfGrsdyQSFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991169; c=relaxed/simple;
	bh=YhgE4m1Lo8NjA9WtQ1K3CHxg2g6+wzRFtNHzEtXGZFs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=W0B3BZ3OM+AnD3kQL9JV2801frK9Tw47imDnwxtR7T1ywsC5TA/O0VGEh/SRalkSIdP1G6hAnFIh0/ded/7SmxGMlmU7ZUyKkV7aBXHmfAofvSY95EuZ++fDw3eXbPYgEP9Y7H4tEUdMii1NapXH+vGn3HyAuFfVFFYCqNHuebY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fzTc0Giq; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fzTc0Giq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SD3ssE2692478;
	Thu, 28 May 2026 17:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=YhgE4m1Lo8NjA9WtQ1K3CHxg2g6+wzRFtNHzEtXGZFs=; b=fzTc0Giq
	J4V2u5JTmSXIBIsJGfPatt3RDcUSoDUJWMbKj1liPNJqLCUtKHjv2JV/lX5QVUi7
	P/YJK3goOFapkVlNLKkWZlBY9OwooDJR2A11sr+bYGb9vCywaJxdgpqc6sRsaVSP
	H8yS2xG4KVVEIQ76PAB19DcUY47l5D+RsX/GKlVphJ2oZQiZK18NVbMbxAfPfVmN
	JbtMcavrYbePxC/XqS04N32RSwKOjQ1DOMivsdPjmEqRLaRcTzQonXd2FISyrNJ0
	Ej1dozf0Wv035k+Io00cpfAAg34vmrLhzKnF7WHb/ku31NGb/ETBMeyvmcG2LNJe
	F6a/py69PY/aSA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884cear-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 17:59:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yngNb8oExacPsxhySelc/t+kYx+djPNnch5CS6wPNVct2pX9ss7BlxZdCpnEtnYoxvjS5BGS94xFIo+bZczbKe9N6twvtNLWIxrZ4zPyZ+qVjliuBnSERN8WSvoudxJtWL9Qj3Ja48QAiGr6du+Tp5Xf47RPZSh0sYbJZN41e0FIMzFpzNSFrEgn0EzohHJO/NykgDi8RT4C96N2YJ1jspUmabAK+vLR20+54kKnmi1VsaKk1oLSybunLgm6gt5rn5DSnvMmJZr8Udw+Y3w7lPExBwQAvU7iZHc79Ano00KCbJQ8zCdCHTyjCxVFcec4HK+3ra8BIB8nliU5tj5QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhgE4m1Lo8NjA9WtQ1K3CHxg2g6+wzRFtNHzEtXGZFs=;
 b=NRhMa8q2552I5GzxpvAK3yq/JZjJF73YtvX0sRpTcV5uwIYBOmAZHKXUC7wvLXE85a/DzPAATt47CN12qrjY9kI/icxfV9bdgJoAT7TUdHqOarY3uWoP9ZCS3HKelRnFSookF21p3V62VHzIc6YlPHFiGsTV2RfG9lcvDL9TRnf8lJNrQFts/oIRs2vc7hevevp/jSQRU/7ZBxJPsBwNm0MVCDAfLQvbm+jYu5kY90WVNHQKMw0ihNpYhZm9/yY2K8gPKDIJIXOkU+3aVm3p/nR7ynrQJIHViDmKNIT9cZ/MGyRk682Fh17rYc4tvBRCxPB+6yTMqG9zyXSnWCyyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV9PR15MB6927.namprd15.prod.outlook.com (2603:10b6:408:374::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 17:59:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 17:59:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] libceph: Handle rbtree insertion error in
 handle_backoff_block()
Thread-Index: AQHc7r5IUwRZsAJTXU6LnScZngAQ6rYjuekA
Date: Thu, 28 May 2026 17:59:17 +0000
Message-ID: <6d8f6ef1d6fc71d07327aa32ff6057be4567984b.camel@ibm.com>
References: <20260528155407.3682573-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260528155407.3682573-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV9PR15MB6927:EE_
x-ms-office365-filtering-correlation-id: 07765e50-0a15-41b2-cede-08debce2d6ac
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|38070700021|5023799004|6133799003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 3VBnAXTtcbhJ6HojkqDVvNlqMLu2eG6NEh9CxK1Xp0VOltzC5/UPUqfykdkgiD0znB1wZ/GwUy9WoRmENbW2OiI1l6aZAbaVI2qKSHi79j5wh8oA/F2tSxBL+5vPb3JtrU83rMe1buXhMs2kL0XVmtfXvS33+dS7L1bwM8n9o+kKVb44slLVt0+dHmqaHOuPSRPZbYMYJ/FNPGF7FT1FGSatc2YSqsQWe7YWyElYWmcyrRfgMdVtHHIBnNMO8Wof7vD9run783LEZSzHZuIrm6TOe8uzYZ6eoke+ykSAeBaen0YumAQUf85d3OHeYR9FvCVFoJf+ZD7w/nx0bqGKSElAyuRANyfimiXgf/hnvYuig07u9xb/0h61JSrQvjp/qoFi3RD7ZpzOTyBzjdVUnZNOkXnXvGBCzxZB1qn1yZHRzgHYRe8wH2NBlv5/a/324px9xCy8Owjl5uwGmxFtflekeL6LtkqmMo8H1kRX6PLM6divyzgSdgSfjyyTLxL5ZpB/OaB/whqrGw9vYDb4x5r+YdOM5c8i/i0kuh1GA3e7YSMnc0AxuOSiJnV8pUJpOxriZN5TZu4gIreILC3q43cWAODZU2XUy9LGIgAhl6ycgVgJT8KzrReMDgF1R2kuqJWh2ZcGn+8ETP4PsR3/8xHsqL56jG4gIO0bHIyH9wRhmG3Qz+37KlpjTidVpmv7zNf20S90WJKtfSbt7fWjTuFTQqkxlBh1Hgc6xVvjZNQHf3/hKuRtF+yYEs+guGyl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(38070700021)(5023799004)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGxPRktIRTd1cG5HMkt1Q2M2bTVjTmNxQlZIeGV0d0lack9WT1FPS09aTFlh?=
 =?utf-8?B?STFqSm9vWlJtTkNCM2U0Y0g2UzVMVFRaNWpzeXZoS3dRNlExZE9wNXhSeFZX?=
 =?utf-8?B?U3VMdnJEMXU5L1M4d2lGUXRYb09aKzdOL3Z0ZTJlOFVvUTU0U1ZNOFJNT25o?=
 =?utf-8?B?cElUVlppanFVeGUwS0ZhZ3hoN0ptY0ZhbGpPMzQ3NG9jaER4TEM4V3ZLNTdM?=
 =?utf-8?B?ZEhwdjdPbDlwSkQrYkU1T3FMbjIzZ0FtUTEyRWFiK0lYOTdlTVlZRzhaNkhW?=
 =?utf-8?B?MmozNFg3Um9CRDl1amM1OGUvd3dIbktXQ3UrZm1RSU1aR1VwbGJZZGRRUHFz?=
 =?utf-8?B?NEZZQTFPYVJOMGJuVGhYYmdlWjRYMVdUTE5QcHlteUtJQXliMVF1RE53em5j?=
 =?utf-8?B?Zll1RnZndmh0VUQ5b3dnMnZ0ZldFRzdlTzgyMjR4djZlNm05R0lIb00zQlE4?=
 =?utf-8?B?dXhFMWVFN3I0RThDRlJqY1NVU1N5djB5SGJKUk5SazBmbnlSQTdVRzZhUG1H?=
 =?utf-8?B?NXJkUkoxa2JpYmV3TFhiTTlGcEg3eVJrTlhscWxJbEx4amt2UTRHUWFjS0t3?=
 =?utf-8?B?ZFZMTnowOCsxRXRROFg5dDZjK1Y3WVRxUGpTUTlqeGtXTzF2YjB4N3VLMjA0?=
 =?utf-8?B?NGN0aC8rcEhRdHU1cnh4a2dYQWJ6a3hOdnRBMXRITnpZVUpuNkV3Q01PaEJ2?=
 =?utf-8?B?RG8xcG9xY09FY1BCMzkvQUowY0xzbTJhNzJvRGh6aUNYM3AvbDg4VDdiMkRt?=
 =?utf-8?B?dHBFeXY3NXZrYjU2bmJlR2E4eFVGU01XYzJtWHJLYnRvZUNGZGFSQTNwYkMr?=
 =?utf-8?B?VkFiRVpnSWYxNUk2TmloNUNrZmJGK1QwUHE4WmJSRFBOeTZIUXhxYlQ4RWhM?=
 =?utf-8?B?Zk5SY2k5K0h3U3hmS3MxcVlEWm1CVEk5TGM4MU9MaGwxaFBtM3JJR0lMeDNZ?=
 =?utf-8?B?b2Y1MXY5cFFMT3VEWVlsbTBlcGlnMkpTcU5vME5raStiL0I0TGpPWHcvY0Jn?=
 =?utf-8?B?V3BZTU41bWFRbVdHNE1mdWtBK3duZWtRaHpSOVNHeGlDYlpUQzBuZ1dLWCty?=
 =?utf-8?B?NDRxOHJYWHp1aXpQNVRxSkYxejFUNi9tdVBlVkhaam00TUdReTNGL3NMQXpz?=
 =?utf-8?B?Z2VMZUgydnVpNEtkYTNGZFYybWR6MmlZQ1h1Rk51dXowczhFOVBwY2VyaHVp?=
 =?utf-8?B?dHhDOXhHOTFxOTBTTC9CQUxPU0d6RmJ4TDVBYjdjOFZSdXFEN2ZOZkhZS2tL?=
 =?utf-8?B?aUxKMzBWRGpYZHhJaitkdCtaTTkrYVA5TjkzRnpueG9EYlpycGFDQlJ3eVF2?=
 =?utf-8?B?cHhsdEU2Z29Ba2Z1L2hrOURwaUN5OW5XYnBnOHloTUhWVDhYcmlieTFUZmdG?=
 =?utf-8?B?REl6SkxlODdPNG5JV2VkUElBTThUdzhwMCs1Y2NMTGpSWTRjbHBYRVVGTVhS?=
 =?utf-8?B?RHB2QVZTaVg1dDkvd2FmQWpVeUJueGVyR01ZK3p0aTFRTEd6TlQxY0FKclRq?=
 =?utf-8?B?cmZwa3FHS2dxazI4V3E1UXdET0dXVldoSzVBUlZ1M3F3TGtNdGQwWE9GOFY2?=
 =?utf-8?B?Z0szT3VxYUZBMjhDRVphVkJUcm0zRW1JY01Rd00zdGFiWk9VTlpTemJyV3U5?=
 =?utf-8?B?UG1EWXVmZ0NRZ1E4b0V1eFN2ek83cXppb0UyazlVL2ZyWmtuQU9pcCtYMjRz?=
 =?utf-8?B?TkxUZk1SQmkrczladXlBSm11RC9TTXpxTyswL2dEbUhsYXRHWjlYQ1p4WVox?=
 =?utf-8?B?eFRvNlRqendMQUtnczJydDd5alVlV1RGbFlrVXBzOGhuejg3dEFXOG1UT0I5?=
 =?utf-8?B?RTR3emFVRTlwd1c3cXI0SFVJeXl1NEZrL2VKYld0QUorVURGSmJ5Z3JpWDRM?=
 =?utf-8?B?dGhDLytzSTRSZmVMR1pxVllRRzh4Y2tMVDRmSEdDWkd5Q0dNUjBDK0FDN2NZ?=
 =?utf-8?B?SjVhZFgxWjYxdkdOREJ2SkZHYnhOblNvZVRPejBjWkF1Uk1Ya1VMNVNUY3Nq?=
 =?utf-8?B?WGtnbGNSY0JSUGlKU0kzRWc0K1BWSmpYdUJJak95SzZTWFVyRmxXZXNONE1L?=
 =?utf-8?B?UEVYL0RQSEppd091Z295UWtCTGFFSUFvVnFQUkJQcmNoNSttMGt1eFpKOHhU?=
 =?utf-8?B?SFZJTElmQ2ppaVhPTUVybVB4bUY3YVpWQmRjVCtnRmJIb29HOGtXWmVzZ3RC?=
 =?utf-8?B?SFpwK2Fiam9MbmljN2RhYTdqREM1SWhQS2pJQ0RoRFUyN0NYU1FoWXBkOSs4?=
 =?utf-8?B?azFKUVlOQ29yano4cDduK1RWL1paWlZZajRpYndsZUtTdldOdzVjODN2VHpz?=
 =?utf-8?B?aFpLdDU1RWdsdC9xWWgwNWFWTVNWWHlXSG1Ra216Mm5tbkhKQlpaSThEM0kz?=
 =?utf-8?Q?IfyNMc0A7GLKzL0hOFFEndJWM1KLC5Ne5PJnr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <052DCC6F3B4EF04CA1122E38E4F835A3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mWe8RTQ/xqr67BW1AYS6muPIs2lySf32Y8XRpz8O1VJqyMuawrLYkQ5x8RMjQjelGlJ1rqhhL32RIOWm+4Kcdp+Qnn34zlcwfDqZWOH6aDvfSBkKamIBQqnnJ3WZJ0LhQQEf0/UAD+N1KC1c4xCcYuemtaf9ZriJBYXQWSMzokkUsF5NERoQXtOoHRnUuPQTzkK43GVwbAU2/OsYiQx0lc/GW4Wf5pHpAn4M/2bLvG6QzMHdnjE12XAJhn4UDJB+Cd6XGia17/MLKgToyetcxQntqoLSgTKmSWpMTF+9AooHVny8t5YBklAIryeRHmabM8zvkTIwJwnMKW9lKiB8Fw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07765e50-0a15-41b2-cede-08debce2d6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 17:59:17.4422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PoZygASN1EaC9RqeZsAS79ZQrz7zVArJR30FXf6PaaTP/HdBVluUIUxHXINlqaaa1F7H99p8rzxho1nigPJ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR15MB6927
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a188278 cx=c_pps
 a=Cwg/eoBiIzPoLCvUJpemAw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=88z6IalOqtcW6Jo3i1UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Wd7x5z6Twlk1z1Y_ocfbVl1zT02kSfcJ
X-Proofpoint-GUID: NKcpFrtN9JBYSNVG5fEkc_nyVQBSlbfQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE3OCBTYWx0ZWRfX1L4wgq7YPbKG
 eRrCChmFSO33Htg7ehT0XmTwbERiN2Jhs+fwY9CJX28QJQn5hpRtI0KRnP2N9ntE1hQ2whrDfQ8
 haDmdZ6fEmu+C5hZez0zlchDASFYRSLennNYHoGwSV0dc8oNEwQmVP1aF0pnI+Ecf+a40kacBpT
 S6giuiTP9SoNqLSVn5ZBS8M3LHVjH3jO8BzZOSR70Mz3GBv5Q0vj4KFaRdMQBmwDPjNtSdYXE6C
 QnZsvDalf4kZMfPfogIAZ+eOqN0GqbU2mFuYY7lI/FSXsKInrMtf1CrmyG0mALtEzdwMuq4fndj
 vjZsoUJ2Ll75vDKXWTq330V2oq6uLL7T2ocLkbGXnBMAOIbzYS4E5aB9TZQBNcI2ta9bGmu5isN
 iRTz88fZy/yNRCpL10bPQdkyY+yJLNcAasJcV86XvXiep+NkrzmLenc/c+BSAl/NZSzkXQiXWpP
 U60PGnjy3A/n9vU+r6g==
Subject: Re:  [PATCH] libceph: Handle rbtree insertion error in
 handle_backoff_block()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280178

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDE3OjU0ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gQSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfT1NEX0JBQ0tPRkYgaXMgdXNlZCB0byBibG9j
ay91bmJsb2NrIHJlcXVlc3RzDQo+IHRvIHNwZWNpZmljIFBHcyBvciBvYmplY3RzLiBJZiB0aGlz
IG1lc3NhZ2UgaGFzIG9wIGNvZGUNCj4gQ0VQSF9PU0RfQkFDS09GRl9PUF9CTE9DSywgaGFuZGxl
X2JhY2tvZmZfYmxvY2soKSBpcyBjYWxsZWQgdG8gYmxvY2sNCj4gcmVxdWVzdHMuIEluIHRoaXMg
ZnVuY3Rpb24sIGEgYmFja29mZiBzdHJ1Y3QgaXMgY3JlYXRlZCBhbmQgaW5zZXJ0ZWQNCj4gaW50
byB0d28gcmJ0cmVlcyBmb3IgdHJhY2tpbmcgdGhlbS4gQm90aCBpbnNlcnRpb25zIHVzZSB0aGUg
YXNzZXJ0aW5nDQo+IHJidHJlZSBpbnNlcnRpb24gZnVuY3Rpb24gYnkgY2FsbGluZyBpbnNlcnRf
YmFja29mZigpLCByZXNwZWN0aXZlbHkNCj4gaW5zZXJ0X2JhY2tvZmZfYnlfaWQoKS4gSWYgYSBt
ZXNzYWdlIGNvbnRhaW5zIGEgYmFja29mZiB3aXRoIHRoZSBzYW1lDQo+IGJlZ2luIGNlcGhfaG9i
amVjdF9pZCBvciB0aGUgc2FtZSBpZCBhcyBhIHByZXZpb3VzIG9uZSwgdGhlIGFzc2VydGlvbiBp
bg0KPiBpbnNlcnRfYmFja29mZigpL2luc2VydF9iYWNrb2ZmX2J5X2lkKCkgdHJpZ2dlcnMgYSBr
ZXJuZWwgQlVHIHdoZW4NCj4gdHJ5aW5nIHRvIGluc2VydCB0aGUgYmFja29mZi4NCj4gDQo+IFRo
aXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlIGJ5IHN3aXRjaGluZyBib3RoIGNhbGxzIHRvIHRoZSBu
b24tYXNzZXJ0aW5nDQo+IHJidHJlZSBmdW5jdGlvbiBhbmQgaWdub3JpbmcgdGhlIG1lc3NhZ2Ug
aWYgb25lIG9mIHRoZSBpbnNlcnRpb25zIGZhaWxzLg0KPiANCj4gRml4ZXM6IGEwMmE5NDZkZmU5
NiAoImxpYmNlcGg6IHJlc3BlY3QgUkFET1NfQkFDS09GRiBiYWNrb2ZmcyIpDQo+IFNpZ25lZC1v
ZmYtYnk6IFJhcGhhZWwgWmltbWVyIDxyYXBoYWVsLnppbW1lckB0dS1pbG1lbmF1LmRlPg0KPiAt
LS0NCj4gIG5ldC9jZXBoL29zZF9jbGllbnQuYyB8IDE0ICsrKysrKysrKysrKy0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9uZXQvY2VwaC9vc2RfY2xpZW50LmMgYi9uZXQvY2VwaC9vc2RfY2xpZW50LmMNCj4g
aW5kZXggMmZmMDAwNzBjMTgxLi5hZjBmZDllMDhjZDYgMTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBo
L29zZF9jbGllbnQuYw0KPiArKysgYi9uZXQvY2VwaC9vc2RfY2xpZW50LmMNCj4gQEAgLTQ0Mjcs
OCArNDQyNywxOCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfYmFja29mZl9ibG9jayhzdHJ1Y3QgY2Vw
aF9vc2QgKm9zZCwgc3RydWN0IE1PU0RCYWNrb2ZmICptKQ0KPiAgCWJhY2tvZmYtPmVuZCA9IG0t
PmVuZDsNCj4gIAltLT5lbmQgPSBOVUxMOyAgIC8qIGRpdHRvICovDQo+ICANCj4gLQlpbnNlcnRf
YmFja29mZigmc3BnLT5iYWNrb2ZmcywgYmFja29mZik7DQo+IC0JaW5zZXJ0X2JhY2tvZmZfYnlf
aWQoJm9zZC0+b19iYWNrb2Zmc19ieV9pZCwgYmFja29mZik7DQo+ICsJaWYgKF9faW5zZXJ0X2Jh
Y2tvZmYoJnNwZy0+YmFja29mZnMsIGJhY2tvZmYpKSB7DQo+ICsJCXByX2VycigiJXMgZmFpbGVk
IHRvIGluc2VydCBiYWNrb2ZmXG4iLCBfX2Z1bmNfXyk7DQo+ICsJCWZyZWVfYmFja29mZihiYWNr
b2ZmKTsNCg0KV2UgYWxyZWFkeSBhbGxvY2F0ZWQgc3BnIGFuZCBpbnNlcnRlZCBpdCBpbnRvIHRo
ZSBvc2QtPm9fYmFja29mZl9tYXBwaW5ncy4gSWYgd2UNCmZhaWxlZCBoZXJlLCB0aGVuIG5vdy1l
bXB0eSBzcGcgc3RheXMgaW4gb19iYWNrb2ZmX21hcHBpbmdzLiBUaGUgZml4IHNob3VsZA0KdHJh
Y2sgd2hldGhlciBzcGcgd2FzIG5ld2x5IGNyZWF0ZWQgYW5kIHJlbW92ZSBpdCBvbiBmYWlsdXJl
Lg0KDQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoX19pbnNlcnRfYmFja29mZl9i
eV9pZCgmb3NkLT5vX2JhY2tvZmZzX2J5X2lkLCBiYWNrb2ZmKSkgew0KPiArCQlwcl9lcnIoIiVz
IGZhaWxlZCB0byBpbnNlcnQgYmFja29mZiBieSBpZFxuIiwgX19mdW5jX18pOw0KDQpJIHdvcnJ5
IGFib3V0IHVzaW5nIHByX2VycigpIGV2ZXJ5d2hlcmUgaW4gdGhpcyBtZXRob2QuIFRoZQ0KaGFu
ZGxlX2JhY2tvZmZfYmxvY2soKSBpcyBpbnZva2VkIGZvciBldmVyeSBpbmNvbWluZyBPU0QgQkxP
Q0sgbWVzc2FnZSBhbmQgaXQNCmNhbiBiZSBjYWxsZWQgYXQgaGlnaCBmcmVxdWVuY3kuIEEgbWlz
YmVoYXZpbmcgb3IgbWFsaWNpb3VzIE9TRCBjYW4gcmVwZWF0ZWRseQ0Kc2VuZCBkdXBsaWNhdGUg
YmFja29mZiBJRHMsIGRyaXZpbmcgcmVwZWF0ZWQgcHJfZXJyKCkgY2FsbHMuIFRoZSBwcl9lcnIo
KSBpcyBub3QNCnJhdGUtbGltaXRlZCwgc28gdGhpcyBjYW4gZmxvb2QgdGhlIGtlcm5lbCBsb2cu
DQoNClRoYW5rcywNClNsYXZhLg0KDQo+ICsJCWVyYXNlX2JhY2tvZmYoJnNwZy0+YmFja29mZnMs
IGJhY2tvZmYpOw0KPiArCQlmcmVlX2JhY2tvZmYoYmFja29mZik7DQo+ICsJCXJldHVybjsNCj4g
Kwl9DQo+ICANCj4gIAkvKg0KPiAgCSAqIEFjayB3aXRoIG9yaWdpbmFsIGJhY2tvZmYncyBlcG9j
aCBzbyB0aGF0IHRoZSBPU0QgY2FuDQo=
