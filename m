Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBA2FFFA4;
	Thu, 28 May 2026 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993917; cv=fail; b=RGwd0SEAKw0U/PtCmc1yDfNJM7j4FanIZQoh6I3n6SEClAIn7WK2eUl9fQav44Y0JauFwWI+3P4I1zTOYKsiVNOfM77Oy9/RD2ZxmW+dOt9A7cBLFNw6zQnOvSyqNL8hW7offr10/iYQquguQXHRvQaO8YBrm+8BjCeJb4jD5cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993917; c=relaxed/simple;
	bh=ew3LO9RIIUFPfz5KTYRx3iqtPXSRrW2eFkUmUlm/mCw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=l7vvdx+EfLUIty4HHw6gs/KepmVmpycKgI4LJY0hXAa3qDFRrjCzN22cjNjwgNXzRic0v8lmIKXhEQJdEdgcEWXcleWJbthDdD7GaoIfHYNaNg+eZQykXUDwUxpJyyX8CBvG5YncIf7SfoSQOsFnHRdSLSmgkN/D7fxRShR5zNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s/mDZ7yq; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s/mDZ7yq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SBxakM035143;
	Thu, 28 May 2026 18:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ew3LO9RIIUFPfz5KTYRx3iqtPXSRrW2eFkUmUlm/mCw=; b=s/mDZ7yq
	yslFY2ZkMcptPwj4ZgmmqxmcoMp2QJ3V41pH8nAZFjFlr6oj4Kah7agxBgN8xskL
	/R2j5jgHtqNPWRaFlTQm78E+56HXSuZzcrq9pF62APbQ/LWBGQxPD9iO+krbKrsG
	yqgh1Mw+6NF3qZAQAHQpaxh3BB8y+Y0VTAIAbHm4QAUy+cZfZl2Ihm/6TLEMvt+p
	0AYE6DskvzAP0oAQgM967GJ7d9iAqqcsosyuUFpGfDyqC1mPCWft6yWSK9Or+dlS
	MbXJrasgHNCiVYo/zaswBWE89ccBkx2Vp6969RX/amFIhKvWEbwgOqZ2p8zvBtf4
	HFc24CLYc+ky6g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bce8a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 18:44:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwcTdaMmmX9s6uP1X0RQZ14Can6wx3578P2gh10lYgj3rTZrP14iTO3yPXcJp8h9gY00VjlD5HRxZ6zQaHLg1QzgeDq3b2ze4I1AnBfNxnXJVT7/TZIJhBGCGzjq47sWj1UI1atf2uMMAy0Mkm033WhfVywGOFyh5Jnj7qaykwb1naFTQiLMvup6DF5gdkuWRT/lbUWwPDbR+69T+KzMz408h6CBtkudyDBiTzwLlSa7Cd5PQ74xH1oBtDZN9/ZaFzA4wg7QILdKe0/sIU1xK9RI4E2fbVhk2wv6dTpwMD6yYUN7zqTwafX5PLAJI06+BzyPUEfEKXcshUVV8N8nmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew3LO9RIIUFPfz5KTYRx3iqtPXSRrW2eFkUmUlm/mCw=;
 b=GPswNJFXfUPEPwkAtZhn4ixbbXVDN/1BMj1qfhazvqsuMkjtqNFG55zCM3Lxj2Og2EX3h355LwE3TKQRujLFbR7RDL5smrxhSJK0EpwOIK2xkB9ZNsKLmdp7Iy5kzJxA1QojS61rFrP3H6xDjL/DpE3uaQEcvzoNSbrDlOKqC81NoolKnGZoZeds+piKFstMQsMU5W2xlkMyDwe5oYH47byTBCl9VQDP9uQKxCxGZlGM+iL7HD0EshGZ692FzT12KwjK2mUTXbP7sItRapqvcpaZIb6Eh0SmCe4g6idGbzPGMMbi9/RdCzVOibW9UMNeHJnZrnLkF6FXS1Nr5cLz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB3955.namprd15.prod.outlook.com (2603:10b6:208:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 28 May
 2026 18:44:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:44:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "vulab@iscas.ac.cn" <vulab@iscas.ac.cn>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex Markuze
	<amarkuze@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: fix writeback_count leak in
 write_folio_nounlock()
Thread-Index: AQHc7lXXxD65xi37AEugEYGcXXwjBbYjx0mA
Date: Thu, 28 May 2026 18:44:14 +0000
Message-ID: <549d1a995cdba258425126d2826dcd2601e9463f.camel@ibm.com>
References: <20260528035458.1146314-1-vulab@iscas.ac.cn>
In-Reply-To: <20260528035458.1146314-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB3955:EE_
x-ms-office365-filtering-correlation-id: 173fc64f-1fef-412f-3bcb-08debce91d98
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021|56012099006|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 MJ7D59lRkRe9r9lyKJ+bLEEJPZUYsMcsiDGGIqFCXLG5ytjtGuMrtei6/B2DzizTh0DCI+Ov370CHyqUBtskxkd5FqF0GfCyW+eifvoLriG+irGvQPw+fs+TZPS90e+GaSupfjwS4+fikwkCljNdKcXnKfmYDV6BxgB51INu24NtbyCTFj5KlG+CkiMwiv+h1pO1A8GEWiTa2ymvnhYAAfhRVXK+n7Zp3LFZ2bvU17LTwNni2rmtgImnkh57qREpZ2aTv5ldnYxacbgFy87K3FS0c7IkMlfZCvrdb9mYO36km2t4SjwoUXWcoPhniP9vDWiezRiu2iZigDes2agjILMPvfOXXp6Dp+YgOVB1K+2bM9KoKw+6TZRg2p0q7T+6IYhmcTnhROwY7IrgjF+Gx/xhyEPzyRdU8vqIolLuC6GQOddGkysW8VQF+qOmGsaol87z7Pe8+IqUE97i9Bn2HdG6Tg5ZwDgQxTyINUgIT11IABduNAseWBGjjs+cyyi5qb6mu1Q37PSpMlV1FIOSGTFrXkYhKnA6thx91slFQjkRV+EUhrhZHzQrOm0UBxEGXb9lxJHaOpIa1TrDDbB+KJFit9VC+Cn8DzdYynj0pnvxM7I21KB1vk5FG8I9U34ns4B8RJHbk6ZSv2vcoUIs1VQS4s9tQXCCHES8/zggO+3+EV9v0r7Y4L46mVXNb3F23f2njvGPWPiI3y3d5owWTYZ5JjvhPEX4HqOo6Cdk7R2rywN+pM2+WvCs/PHkFxg9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUFpY3dCc3RabHIzM2hjYytwZlFDamFlTnFqbXhtOXlOaHExRnBzSFE1RDBq?=
 =?utf-8?B?dWIzTEgrSnlqbDNiQzA3MFBaNUs0QWh4a1JQWERxUXFEYzhkdzV5ZWZSNlAr?=
 =?utf-8?B?aVhNams2QjFYSkhkTkNqS2ZLZldCdVhabUM3TlNJWXhJYVJIV25Qd3Awbzdw?=
 =?utf-8?B?dkZNQ2luQzBCZENBT0JwRVR4YktCZWsyZUgvcEE4VS9EUVR3bWVPcVRzTktq?=
 =?utf-8?B?dGVIRGVtTWUxTUxCTnd0M3dQRlUwOVNCbGlWUGNnbFVoTndyb2lTQWtKQ2hR?=
 =?utf-8?B?NTlmWTdPaDFNLzd4M0FxQW0rdDNRK2E5T3QvTm96TFhDZmhROVpua3ZTUDdF?=
 =?utf-8?B?UjRVU2dsYUExdldPUUsvT1dpeTNWTXpjUkdHMWhWOEFvemZyZ2pxaVJ2YXBV?=
 =?utf-8?B?czBBMm0xOVBMSEw0ZnhXQkNMUHpRQ0pXRnp1Y2xORjB1VXBLV3F3N2N1ck9w?=
 =?utf-8?B?N29ldFpkMUtpWW4wMCsxSWs2cmNZSFRIN3FZNVFkL3pDMS8xc3NmSE55anpw?=
 =?utf-8?B?c29ySERBVW5SSlZzRGl1d2RVaVQ2bTFUZmxjdHhXTnVqWUhQOHFENXY5NitF?=
 =?utf-8?B?UnV4UU1jZjNVMEpaMkw4bHZTTUVKc0Q3MUMrOEFrTXFqa0NvVkUvRXl5Qm80?=
 =?utf-8?B?SnU1enV5Z0szeFBwQ0tGb3ZleU1VNm91dzBRM0lOQ1JrWmRaT1hxUm5PSlJu?=
 =?utf-8?B?Q25Va1FGVlpDc0hsNDltWHhNVjUwcVRJTGNJTXdZZlFQMmRzVjRqQzJiR3BI?=
 =?utf-8?B?NDM1SHNCZ0pFaE1kc1JpOW1kaVBvbUt4bHdOTkZFUjNhY0ZMbnlQTWZ0NXZY?=
 =?utf-8?B?dEh4RG1sNW1QaVdYWlZUdWJTWUlveTZqOUEveVpxL0RDZHpOUjcrZjlMSFZn?=
 =?utf-8?B?eFJCWUtOaWFkaS9YZnA0a0hkM0VxQ0VzRzYyeTRoVlNwczhRWFVCc3FIZ2xZ?=
 =?utf-8?B?anJuUlZ0MVd6OWF4dk12ZnlkWW9Vb1RpdTBnelluSFpaYUhBLzd4UFlnc2Qv?=
 =?utf-8?B?Rmt4MWtCWGJ1MldtN1VDLyt2Q1M5LzVwSWVqZGpQV3dISyswZG1hMWZWdkV2?=
 =?utf-8?B?cnpFRk5OMEdpSC9JZmVZOHh5dXlsZ0RrY1RLWlYreFZ6cmFmRE5BcFBGOUps?=
 =?utf-8?B?Z2JRU2FkM2FjTHNmVnJxQXlEV1BaY2FUSDUxRmRvMmZhSnFzSkhrc3U5bC9k?=
 =?utf-8?B?d2Z4eG1jejJia1kyMGsrRkN5bE5vaTRJM29LWnpLTVorVXBQQ1BVcVI4T0Rr?=
 =?utf-8?B?bmpXZHBEamxmb1RKRkF5S3dFR2VMWWRLREhTUlFMOXRkWmVnWjdISVJ5ZGFy?=
 =?utf-8?B?V3lNeThFSjRMbWNIZVZuaEN2UVVnOS9KS2FQeFBCTzBXZnp2Sm1tbUErK2VN?=
 =?utf-8?B?SDV4V2wyZm0zNFo0YmZ5dC9oQ3c4VEVQMzJtdk8vOWdFMFZJWTFJaWh3czNQ?=
 =?utf-8?B?L2VmNGRwSkJiZE5PT2hMOUpKeDhLcnc3S0g1WXByZEJpeGRDcm9DRURNRGEy?=
 =?utf-8?B?WXVCOE8xRkVYdTIrY3J5R0lXQnlHS0hWdjlicUhkMlhvVzhHL2dwUEtUb3RV?=
 =?utf-8?B?dlp4N3ZZK25ZSW1SVXN0TmdTam9FbFZlbEtDMFJsd2w5VWhKM29LQVArMTBr?=
 =?utf-8?B?MzdJWWR2NDFaQklCem9ya0o3YjdabFdFb2NoMmdGZlBSMUVVTlRmM3NBUklz?=
 =?utf-8?B?VG5HWW1IVDlMbGFRSzdhMlNWSG9ycEJkb21PQStHWjduTUx2eXhWanRPb2Fj?=
 =?utf-8?B?Nk5MdU92QnhHbDRXOEVkb3NiaUc5SnRZM2sxeDEwRHNuT2FlSzhub2lqajlK?=
 =?utf-8?B?cjB1YjlSZFdzeDhRdVo5dGZxOFVsV3NDUmxSbjNNelhFYXdFamxhR0lWQVQ5?=
 =?utf-8?B?Y01UZUZYSmZEbkEreko2UnJtSDR0L014ZVJuV2ZraC9RYnJSeEJyTlptU2N6?=
 =?utf-8?B?cGgyaEcvd1RTV3Y2b2duTEdWRVo5SlpIdTd2aE5XY0xSZnUxQlFWUm5DOTJT?=
 =?utf-8?B?eUxuU1BqOUlUTll3ZSt1YjhEdlp1MFR0NStrelFHUXYyREpDZUJzbVV1VUFl?=
 =?utf-8?B?OStCRmZ4OEZINkMzS3NSQ1BuRVZVTExwMHByeEhuRVMvQWU0cHk2Wmd4QlBj?=
 =?utf-8?B?ci9XRHYyendLV3BQN3IwaUFqTmg0dEJXaUdiaWZGR25TamtCZGZ6U2dSV1lN?=
 =?utf-8?B?TlJUZk5hRGtXbmpHOEtyYnM1MlNrd3Z4SWcvVFRZSFpSTHU4QWVBdkgrc3Ax?=
 =?utf-8?B?NW1MejYrd3QyOWYwUkcwSytoeGNlNExxQms2R1ZRemVHQXU1WlBsMUFFdXgx?=
 =?utf-8?B?VGlUbEFEUy9GUnZ1SENKaDdHQXRFdUtpRkpVcFZmeER1SWVlOGlHMEV0ZmFV?=
 =?utf-8?Q?awappEiRMkhjGQxDzeHjEkODeO4iGJ2irxKAW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <229701B437635A488F145DF5635F5977@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	subGjFcyfpTITAUOcyL7+Cho9k6YFNxljQjDmI566sIEL0BHaiExjoC/0kBFsDJFf0DOpl0/nR1Pz0nVslREtHyNhi7FW80EsIzDS43jsrV+bCR8yAbUmJ8CbMgvXHTDSmmm+PpPB6T+iDp6Vv51X1s8jupjfjL7wipo24JGPD6dLWQKt7KFEUBp7pLfkxF6sF1VfIgE3UKp0/IdfgrxjX+PmBwrA0aDv3xEsypY/NHXb2t5Ey7FlXq8q16qYCht521eT2smsc9/uAplJUv8ZKFVWMS4RoJBVrqsIIWsxEywZy/NKgDX3MQWphSb1KJQgsS0ph6ktHO0PKz+AiST+A==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173fc64f-1fef-412f-3bcb-08debce91d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 18:44:14.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWYl3KI+ymdHxNljz1jpTSVLXntfYT3zzLp/fgFBhY9BVwX/Cw/Tw+H5G5xtKBPnhwA7LisRQ43qEr7F0qMcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3955
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4OCBTYWx0ZWRfX22KVj8iZ0Cza
 B5xwVb6r1ojAMmXgLr3zu2vTPMYmWPKHG5618F4Oxk0cm2ny2VXCBoxGLdkKglcHeLjEN7886iR
 nQ3yUHKVqBcjDJ4BlXU1ysdE1x7uoeAGP9HfGbxQiUovUi0MdZkyboMUH/Q9+agir5xaLv43Eug
 6kXl4mSeH1IKTrs9XpvJ4JzFy3C454s+pJDPNUtI+HorHJvmgHIzGZ+5Yw8onCuvYQVFz9RKzUb
 aBrkWvwaewfkN/qxmR/Ifk8OFmOArvR2TXo3tyTjdh9vqrfA3PpcO4x5S5Sgk+Wdo1kQMg1kSVa
 cWExCJR2+Ldsg/vmB02gpUdHiEDgu2xi8A9vFuw0UMz57+mGoG01FNrdx/BNjCIlOScGeLQFfGj
 EobYGv+MWqXJmJyqJm3zLn2a6jRxMtc8NGkJ9XkuyPiN/a+bzkSBZ9aa3SjF3J5YIq+eZOUyBxJ
 I3pTqB8Im2OcG6Cg5RQ==
X-Proofpoint-ORIG-GUID: sRH6Syca0CoYFGnCf-WuRFTPTNWpqA5S
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a188d01 cx=c_pps
 a=E1AkXC+xFF28g4y6WI75Xg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8v9YfVCGButt467MqUwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BetybAXhf3c4ICgZvEu_pp70wVrB-Kqz
Subject: Re:  [PATCH] ceph: fix writeback_count leak in write_folio_nounlock()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280188

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDAzOjU0ICswMDAwLCBXZW50YW8gTGlhbmcgd3JvdGU6DQo+
IHdyaXRlX2ZvbGlvX25vdW5sb2NrKCkgaW5jcmVtZW50cyBmc2MtPndyaXRlYmFja19jb3VudCB0
byB0cmFjaw0KPiBpbi1mbGlnaHQgd3JpdGViYWNrIG9wZXJhdGlvbnMuIE9uIHNldmVyYWwgZXJy
b3IgcGF0aHMgd2hlcmUgdGhlDQo+IGZ1bmN0aW9uIHJldHVybnMgZWFybHkgKGZvbGlvIGxvb2t1
cCBmYWlsdXJlLCBzbmFwc2hvdCBjb250ZXh0DQo+IGFsbG9jYXRpb24gZmFpbHVyZSwgYW5kIHdy
aXRlcGFnZXMgc3VibWlzc2lvbiBmYWlsdXJlKSwgdGhlIGZ1bmN0aW9uDQo+IHJldHVybnMgd2l0
aG91dCBjYWxsaW5nIGF0b21pY19sb25nX2RlYygpIHRvIGRlY3JlbWVudCB0aGUgY291bnRlci4N
Cj4gDQo+IEVhY2ggbGVha2VkIGluY3JlbWVudCBrZWVwcyB0aGUgY291bnRlciBhYm92ZSB6ZXJv
LCB3aGljaCBjYW4gcHJldmVudA0KPiB0aGUgZmlsZXN5c3RlbSBmcm9tIGNsZWFubHkgdW5tb3Vu
dGluZyBvciBzdXNwZW5kaW5nIHdyaXRlcy4NCj4gDQo+IEFkZCBhdG9taWNfbG9uZ19kZWMoKSBj
YWxscyBvbiBhbGwgZXJyb3IgcGF0aHMgdGhhdCBjdXJyZW50bHkgcmV0dXJuDQo+IHdpdGhvdXQg
ZGVjcmVtZW50aW5nIHRoZSBjb3VudGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VudGFvIExp
YW5nIDx2dWxhYkBpc2Nhcy5hYy5jbj4NCj4gLS0tDQo+ICBmcy9jZXBoL2FkZHIuYyB8IDMgKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZnMvY2VwaC9hZGRyLmMgYi9mcy9jZXBoL2FkZHIuYw0KPiBpbmRleCAwYTg2ZjY3MmNjMDkuLmE2
MDYzNzg2NDljMyAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9hZGRyLmMNCj4gKysrIGIvZnMvY2Vw
aC9hZGRyLmMNCj4gQEAgLTc5MCw2ICs3OTAsNyBAQCBzdGF0aWMgaW50IHdyaXRlX2ZvbGlvX25v
dW5sb2NrKHN0cnVjdCBmb2xpbyAqZm9saW8sDQo+ICAJCQkJICAgIGNlcGhfd2JjLnRydW5jYXRl
X3NpemUsIHRydWUpOw0KPiAgCWlmIChJU19FUlIocmVxKSkgew0KPiAgCQlmb2xpb19yZWRpcnR5
X2Zvcl93cml0ZXBhZ2Uod2JjLCBmb2xpbyk7DQo+ICsJCWF0b21pY19sb25nX2RlYygmZnNjLT53
cml0ZWJhY2tfY291bnQpOw0KDQpHb29kIGNhdGNoLiBCdXQgSSBiZWxpZXZlIHRoYXQgd2UgbmVl
ZCB0byB1c2UgdGhpcyBwYXR0ZXJuIGluIGFsbCB0aHJlZSBjYXNlczoNCg0KICBpZiAoYXRvbWlj
X2xvbmdfZGVjX3JldHVybigmZnNjLT53cml0ZWJhY2tfY291bnQpIDwNCiAgICAgIENPTkdFU1RJ
T05fT0ZGX1RIUkVTSChmc2MtPm1vdW50X29wdGlvbnMtPmNvbmdlc3Rpb25fa2IpKQ0KICAgICAg
ZnNjLT53cml0ZV9jb25nZXN0ZWQgPSBmYWxzZTsNCg0KPiAgCQlyZXR1cm4gUFRSX0VSUihyZXEp
Ow0KPiAgCX0NCj4gIA0KPiBAQCAtODA5LDYgKzgxMCw3IEBAIHN0YXRpYyBpbnQgd3JpdGVfZm9s
aW9fbm91bmxvY2soc3RydWN0IGZvbGlvICpmb2xpbywNCj4gIAkJCWZvbGlvX3JlZGlydHlfZm9y
X3dyaXRlcGFnZSh3YmMsIGZvbGlvKTsNCj4gIAkJCWZvbGlvX2VuZF93cml0ZWJhY2soZm9saW8p
Ow0KPiAgCQkJY2VwaF9vc2RjX3B1dF9yZXF1ZXN0KHJlcSk7DQo+ICsJCQlhdG9taWNfbG9uZ19k
ZWMoJmZzYy0+d3JpdGViYWNrX2NvdW50KTsNCg0KRGl0dG8uDQoNCj4gIAkJCXJldHVybiBQVFJf
RVJSKGJvdW5jZV9wYWdlKTsNCj4gIAkJfQ0KPiAgCX0NCj4gQEAgLTg0Nyw2ICs4NDksNyBAQCBz
dGF0aWMgaW50IHdyaXRlX2ZvbGlvX25vdW5sb2NrKHN0cnVjdCBmb2xpbyAqZm9saW8sDQo+ICAJ
CQkgICAgICBjZXBoX3Zpbm9wKGlub2RlKSwgZm9saW8pOw0KPiAgCQkJZm9saW9fcmVkaXJ0eV9m
b3Jfd3JpdGVwYWdlKHdiYywgZm9saW8pOw0KPiAgCQkJZm9saW9fZW5kX3dyaXRlYmFjayhmb2xp
byk7DQo+ICsJCQlhdG9taWNfbG9uZ19kZWNfcmV0dXJuKCZmc2MtPndyaXRlYmFja19jb3VudCk7
DQoNCkRpdHRvLiBFc3BlY2lhbGx5LCBpdCBpcyBub3QgY2xlYXIgd2h5IGF0b21pY19sb25nX2Rl
Y19yZXR1cm4oKSB3YXMgdXNlZCBpbnN0ZWFkDQpvZiBhdG9taWNfbG9uZ19kZWMoKSBpZiB3ZSBk
b24ndCBmb2xsb3cgdGhlIGFib3ZlLW1lbnRpb25lZCBwYXR0ZXJuLg0KDQpUaGFua3MsDQpTbGF2
YS4NCg0KPiAgCQkJcmV0dXJuIGVycjsNCj4gIAkJfQ0KPiAgCQlpZiAoZXJyID09IC1FQkxPQ0tM
SVNURUQpDQo=
