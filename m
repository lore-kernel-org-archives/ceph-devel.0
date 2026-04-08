Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D53D4134;
	Wed,  8 Apr 2026 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673265; cv=fail; b=Z5Dq7tvCcNoejyjkXbKrfj6yAHzWhbgbzaffx3x74aatl2Jl4tdvo2A1ZYbxoOuiSfVmSMpyOx4zGvpVUFXs6zKP7QaCP6YtvVciyMYiqPM/Z6tBntS7xODh0lIPBIOl/a/QTgav731hFFV9VHagZMvwvoyW0rEcwrcB5lBFYZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673265; c=relaxed/simple;
	bh=nw5Mlxfzxh5WrraKzliFrEmAMyy7wfeVXcV2a/b04kA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cL1XDmubeomHnsP+9KANLxmmdyfLgsWL8hcHQ2NjZxcNZbTTrB2N6eksUHu4IXRnjk+60YLw240b4XnN7b72ILExhgkxl30ESIGIlcBzaVWha+/3+Dm8ex+bZDAIcgBm+ZGBMJPPizF5LXFizbb0scH8J+3WT3nP2FTMO4+phqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ONFeGA87; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ONFeGA87"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638Hi5fu2297936;
	Wed, 8 Apr 2026 18:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=nw5Mlxfzxh5WrraKzliFrEmAMyy7wfeVXcV2a/b04kA=; b=ONFeGA87
	2zTEQyTMl61RQm4h+yMiSoWEcHawiLTVzs0iLcWGSBB1yTEqP0vmv2Lw4/D+i1P+
	xxC6OLPtEI3/PPvqPDBxYzWzynuspaqZSzQSU1fXxwESyTr97saqp2O8n0ZXjAZk
	QPQfi2Y2WAzZAf3qg9k0FkBvPMjCHcSCocRDx/JnzgFHSq71YESkUQzpkcJ+qSKc
	DiQcZsV4leXxYVWkUFwALytvQvXeUA/cT4Jee2FP7H8oW5+gxtRLuGfGXAbMdnWo
	mwua46MdQWLCZGb4kYLUEaexGOnuJicWc++lsAIJkXjC0kQ4N9THHKfxCN7AQtzT
	lKrXHcXphaFrNA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g0txx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 18:34:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXm+49EY19Iosay0hhK1Iuv0vdxr+ECyMiKBN5CFOAYGVFzENJcolFn3ft3abKbCVdff/aCIH+wx/fJNhXpIBdfSWyGry52eMigzl2N6IxO7392c2cSubn+WOM68IQPSmoN85Ww1I5UE5UzOxSrmMGmbcex07ZeWlujnKJmXt1IfGnhFaake69YBYJevuRixsM6nBHX6w7hc5U0I5/L+jqN6/hS9FTR+MiCvvA6TS52DtIfrST4MfBlFWty32g8GCvkd9vCbQQ06tiO/wusa5jrE3kUvGLDBfAzBBhaUZyWIQgr+xNguNrThalJmsVMp+ipqpoNdg1OE8AHiGw4VCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw5Mlxfzxh5WrraKzliFrEmAMyy7wfeVXcV2a/b04kA=;
 b=HVP6+HgakpshyXh/y42kZt1mcJgFhxhPOwpffJWuQ2JWwXhrJ4Dia/OGdEEZeT1W3PQ6BWPrkdYVoOzRb8CPNBkH5AooX+c0MzCQadMT87ZK047ma056uuXHGUm3QsqSYro3uKozboYhm8D4o/oFsWkztNbeQQKWLalXPVSNcow921Axt785Dn3BzuekQVqOhV8YFYx0Z43b63h0Vcbt+oL707ljGd6sWORgZf41kuv1SGHS1FIXcZqtSlpAWv6UGOpbG75H63rCKCAPFgcj4fYOvEJrGUU/BUly3VtaXsHsBD4QBsLznPRt33tNOLh6409BRrS0Y55t/ylNpi6vAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5845.namprd15.prod.outlook.com (2603:10b6:930:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 18:34:05 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Wed, 8 Apr 2026
 18:34:05 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3] ceph: bound encrypted snapshot suffix
 formatting
Thread-Index: AQHcxvLq8jlmg+UXn0Wlm39+gwjMeLXVfqaA
Date: Wed, 8 Apr 2026 18:34:05 +0000
Message-ID: <4e656f4ae5667fb29154595639a377dccbb351d3.camel@ibm.com>
References: <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
	 <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
In-Reply-To: <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5845:EE_
x-ms-office365-filtering-correlation-id: ef32f51c-5a76-412f-17c7-08de959d6a01
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 0+FWW0XWbpFK0j1FloArRMUBU19pxKtj5ylaMHtSt+pn22XCHhOFkgUTVa4LkT1vGlXVdxI+IVOpFHPGlmSBojDHxf1lv2CJ84X+/udQ/ztfaQEami/i+Epv6ohxTQPJMeo/pdap+2lMkH66E8jsif7IBTRtBUl3KSoW+uBjskjAJZ3dxm7qFYCuaJcXxEpe7duqv4UeodmaWxZZcySfD5HTu4hCnleHy0coN6kA7floqhuAr1IIFk/Dve1kWaxylMPWkocYKKQSSEWCaWyZvbyae7Fs8uS77U6OYC/okuPBsOt85F0jmR0sSMcFhFTVIPOWD9oGBZ3p7bjzoYhNi851JnBbz8DUWrcfinOPjyjKS1SD6miw0ViGXm7l4cjnF4S2xN4uhcm8CvYmSlZ7MiMvCC87d73ZNUEW5rz9F7rETLFj9wSseBCtmmvoSNaf19+okVyPmCVCehvBiVNCiZaeelonJsugLfgA9vipPUZyVcoYe7vSfYVn4j+vkCJvemOtS8KmQTIK9Y7wlmyvBHDLlq3vKGtnHHsMsvd1KAwkC3t0riFQi3AtVkQTvnGJkG3cWAKj1vN6LFCh+RP82KewEVKmMDJNO4gQNArIbOd5hfHCtmRjmnNJ8H4xaW0liUKO3RH6IlrOKM6tWK7H6AHesCoxqGfZJSQi6n3aLlKIQP2HLrNNZ0z7ZqKLwY2H/Sd3GzwWBC5Gpmo54zz/i2MtMEenMfatbsy1B/otMVDG5wPWgbWepfqILWAWwfDZ1pLhNPRQHvkQvXcqMT8VojTA4Ra9BnJcM6BD2PRVXt0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGpPVG1QS0JJNGxubEpqMGJCK3dvVkhBenRLZS9DZUpnc04zanlGM2dMbERR?=
 =?utf-8?B?cjEyZkdYandpSlUvRVNkWHlSZTEyU01RNU5kQ2wwc0hMN2NvS1FwZXJGV0I4?=
 =?utf-8?B?U2VyeFdvb0s4Q054TW5IUGZ0Ti94QXF2V3lHQzBPU2g5T3BFWm02VXEvUTkz?=
 =?utf-8?B?ZHBEM1R1cXpiQjJJRlVXK0ZCalBjRjA5MWxVekMySVRpRXVsUkUwUElmM3ox?=
 =?utf-8?B?WHRqSGVFblZSUzJQSzhWTWlwWU5nalNRZ0g0dTdNL0cvSU02MnB5enZzbjVN?=
 =?utf-8?B?cHlWelZWNlAzS2theXZ5MUtsYXh6OEFPZ1hEWWErbVI4ZklzVlF5NndZWnVD?=
 =?utf-8?B?SDRGcDVWWTZ5eHZyNGI2VDEvSFN6LzVTNTFvS3pnZ2s4VEVzOFFTSWFkdmlK?=
 =?utf-8?B?T1dERTZ5MmFTTXlzeWFobzVGVlM1bHR1VjFkdlpYSzB6NE82NHNtM2tBWVlt?=
 =?utf-8?B?YjczYmVaZWt4Qlg5S2pPdzFCbGJYVjZnRVBwTzRuWDNDSG5xMEg2bzh0ZzZs?=
 =?utf-8?B?RGgvNWZOeUpMWVMzWnJzOUxnMHBmRmthSDVmM0J0VmovUGFCUmxjakpzS21C?=
 =?utf-8?B?dTI2Tm02T3VhV1R2TnFMY3U5Yk1MMGowUDRzcHBoOWRyM3hzTTEwY0pMcTZq?=
 =?utf-8?B?ZURYK0Y3S1lSblNTMHI4UTJBVllQb3llemd4ODFBb3M3dVZadklFSjkwUkc2?=
 =?utf-8?B?MnVIRE1PRmJ2MVNnMy9HRm82ZXpUbW1ucXl5VEt1RytYNWd1emsvUy9IYnRP?=
 =?utf-8?B?YXhkaUlhTFY5N2F2V1RsKy9DTGFJTW82T2o1bFFPaDExbUFvUUl4TFBYU25u?=
 =?utf-8?B?dDhjN05QdnY2M0p4bzF6WnZJYnRrU2xSL25HK3FIdzFjNW5nN1BieERVc0I4?=
 =?utf-8?B?M1Zxc2tOS1dRTWd0T0dvck9tMUtFNVphWFdkL0VJKzlvY0k0UlMwdndjZFFz?=
 =?utf-8?B?SXhoTUZqb1FScjd2VU1IdnZodTVUWWVOVnlOaDhnVVhSMWZJWjhJQzdySUtt?=
 =?utf-8?B?VHl5OGpCbkF0K3VhdlFxM0ZoVlA3UVdPakVpbzdyczRkbFJoSVNHcDloSDVS?=
 =?utf-8?B?TkJ6bGxSbzdaUXFRUUczVjVrd29vRktxQWxDdTAwRUU2NXdTeDlmRTRRWDdm?=
 =?utf-8?B?ZFdnRjNraGt0WHRsWk9JaHhJanVOUlZkSlVrTFBTalcyWjZlZzN0cmQ1MU92?=
 =?utf-8?B?ckU0ZkRkQnR4KzlZUlpMUHM4SFFzbzNBcXRJbllEZDNuNmhwbGl4TkFQbTBq?=
 =?utf-8?B?TDEwTDF4ZGhoUmsxRmhmVDVGUVdKMkRBZ0lvTlBqUk5zdDNWQ1dhQloyV05L?=
 =?utf-8?B?aVBaVHJkcXVWb3JlS0kwVHpPelZ6SCs1anRmMjNDR3VVdkkxUDU3cEp0Zkd2?=
 =?utf-8?B?bitoUXBQOWpCUmJ6Q1ZhOWkxWHJFVmFHSmxxbjExLzFjRXhleUZQWXJ0UUxV?=
 =?utf-8?B?SkNPMW1pL2VhRXFFOWx2dmIrMkh6Um84Y0pWdUpxSGJVUWszUGZ6VzUyd0Yz?=
 =?utf-8?B?UmdTR1hFclErTzRtOWdhYVkyWDJ2aVFoUlY3K3k3UVkxQUwrWWppNVhQcWN1?=
 =?utf-8?B?MS9tZ0tRNk9GSG1Eelh3bnJGWGZQTmgxRW1NZGtOSzh4NWFHeXNqNkU0eWFN?=
 =?utf-8?B?Rm5taHc3TjZSQURCSE0vRmswRnNhMUNvMmVuaWtJMk5hQmZxWmxWcEVaNThH?=
 =?utf-8?B?NHlWcVRJYXRlczFVcE5HVzRQd0Z6STdZMnljc3dNOG5BTDJ5VEdhTFd2K3po?=
 =?utf-8?B?OTRJRmNJUGlSZS9TUXlyZmNzMnhrdkxXUlExenN2cWZJVCs4bDBsblNlOVdh?=
 =?utf-8?B?ZVQ2dDRzd0MrYitWUWMrR2tDV3ljb1dNdmxzcFYzQWN6ajZNN1ZPWmNkdzUv?=
 =?utf-8?B?dHhIdkNYZUswQjUwOGJCK3psVHhtSTBaOFkzNlQ1STJKdTZDSGYyUXM3eEVG?=
 =?utf-8?B?QkpmTndMWk9sMDhQejdwWFhFNkxBRWFSVzZYdzdGZVZhNlFUbXU0R2NvbnRU?=
 =?utf-8?B?YmlURkROZUIvR1FJSElpOUcxa2RzbGNiREs3SlNmZFpGYmlOOHZoYm1WL254?=
 =?utf-8?B?R3FEanNSdGNpS1FCSVdXMHh0U0ErajNCTG9MYnJRYjhyWEhuZ1VBNWxHbGRZ?=
 =?utf-8?B?OU5HM2dFWTNMdk1kTDBpYXBWY1hDOFFjeUV4d0s5RTE5L0FMcytxMlJ6Y1p3?=
 =?utf-8?B?b1lDdTJkZkwveTUyR0dYdi9wY3ZMdUdWU09Vc2JVSWVhS2ZqbnJFdXBuL21q?=
 =?utf-8?B?cDFKSFRZYXd0Vm1zS0JBalJBb1N3UUpqRG94WFhYekJPbVJhRVlHV1dyejAv?=
 =?utf-8?B?R1FOMERrbTdpcWRaMFZXZFk4KytaU2JMR1kyWlhIckpYTFlpb3Mxb1ZlbTJO?=
 =?utf-8?Q?GcDjmwWfAR400xMlFgXq6Mw3R+mnXNMONXT4H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEAA296712ED4C4B823F7815C7B878DD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dsQ7nVrTZDQBwqEL0drS9tqJ/MS53pOFufmVJmR3VM8jvWF77ywxupdZX2ZNX/+EFJdIsHjFr1zOszbmsXm+lH/VmMPiJFNuFeDrzLR5/PcE1T/b/8Y5zRb8XPQUMGBk4YJUHU6Bn0PJ3jBIv/S9fvzei01EBNLYhDExFyFQwd40hctpaADkkfFlhORi5/GVMLuK3nOJ0K13qISNpewRw0Gz0yAqhqUjpAMqcuGuH+9BggjzD0V2QRD8a2F2R927/nTQnqdlxw5/boRGgOj4jaiGmL4/ehNj3YLNBpAPguft9IdwcsKZKZ0n/Dv3uvgJyrWQYB1y+shTuaLuzJiKHg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef32f51c-5a76-412f-17c7-08de959d6a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 18:34:05.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qejjoCI47YWSW9GhnVBpiWqsx1tkKPdGbN9nSxg69xCnpi4pEWFDebDzVSEa2fCpW7vaxG++5j4tFb7WJrTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5845
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d69fa1 cx=c_pps
 a=sUcN70kXflTsQYyr7PD0vQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=XCOGtoKd92LK4pynIC4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qIibMbQ5FcBSouCZxGLc-hwhl-Dw9ziQ
X-Proofpoint-GUID: nbYl0aVn3UMZRKnghF09TB0Mezr4TNtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE3MCBTYWx0ZWRfXyPYpWbElwL4B
 IJdVp6YP0LB/0gCcun6avof8Hlfajc3Z+oVtZv3eBArhP2KlOO7pJy53INLe0omiaiu0NW2C7A9
 UyPaSOFBAoJgzvfYMI1hAMkJRyIX6I9V9TwomYhbG9wuMwiehTi/MjHte4HVtwoarfEeR3wvyHQ
 BzSXpcmJZtZLabPunA3cjckjAj9PKt0yHjEjJR3CENZR2f4Y+2rmneyHINFw6owR0enyNX7IqEs
 dFeChEA0W1bfZqguFxE5IX4nly2ViMYWBUgbLvNX0hYb6Snw6hl98XeTs0q2PEoFo37LyYmLmVJ
 r56UOSo+IUvsoDagDyKlDvLVDoP/FOXsVNFPk0gQ3v1NQiliKabWXRY/x8uoozY5ECc5Ef4b2t9
 XXCzMiDp7s1+GbiKbJ4dbPZPalG33AwAJOCKCi5kPRwcCped0ToIItLC3iAaQWR+0c7zWpam+uC
 C20VL2Kb7tUXjLQ0BVw==
Subject: Re:  [PATCH v3] ceph: bound encrypted snapshot suffix formatting
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080170

T24gV2VkLCAyMDI2LTA0LTA4IGF0IDA4OjU3ICswODAwLCBQZW5ncGVuZyBIb3Ugd3JvdGU6DQo+
IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZSgpIGJhc2U2NC1lbmNvZGVzIHRoZSBlbmNyeXB0
ZWQgc25hcHNob3QNCj4gbmFtZSBpbnRvIHRoZSBjYWxsZXIgYnVmZmVyIGFuZCB0aGVuLCBmb3Ig
bG9uZyBzbmFwc2hvdCBuYW1lcywgYXBwZW5kcw0KPiBfPGlubz4gd2l0aCBzcHJpbnRmKHAgKyBl
bGVuLCAuLi4pLg0KPiANCj4gU29tZSBjYWxsZXJzIG9ubHkgcHJvdmlkZSBOQU1FX01BWCBieXRl
cy4gRm9yIGxvbmcgc25hcHNob3QgbmFtZXMsIGENCj4gbGFyZ2UgaW5vZGUgc3VmZml4IGNhbiBw
dXNoIHRoZSBmaW5hbCBlbmNvZGVkIG5hbWUgcGFzdCBOQU1FX01BWCBldmVuDQo+IHRob3VnaCB0
aGUgZW5jcnlwdGVkIHByZWZpeCBzdGF5ZWQgd2l0aGluIHRoZSBkb2N1bWVudGVkIDI0MC1ieXRl
DQo+IGJ1ZGdldC4NCj4gDQo+IEZvcm1hdCB0aGUgc3VmZml4IGludG8gYSBzbWFsbCBsb2NhbCBi
dWZmZXIgZmlyc3QgYW5kIHJlamVjdCBuYW1lcw0KPiB3aG9zZSBzdWZmaXggd291bGQgZXhjZWVk
IHRoZSBjYWxsZXIncyBOQU1FX01BWCBvdXRwdXQgYnVmZmVyLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUGVuZ3BlbmcgSG91IDxwZW5ncGVuZ0Bpc2Nhcy5hYy5jbj4NCj4gDQo+IC0tLQ0KPiBDaGFu
Z2VzIHNpbmNlIHYyOg0KPiAtIGRvY3VtZW50IHRoZSBzdWZmaXggYnVmZmVyIHNpemUgd2l0aCBh
IGNvbW1lbnQNCj4gLSBkcm9wIHRoZSBkZWFkIHJldCA+PSBzaXplb2Yoc3VmZml4KSBjaGVjaw0K
PiAtIHRyYWNrIHRoZSBza2lwcGVkIGxlYWRpbmcgJ18nIGV4cGxpY2l0bHkgdmlhIHByZWZpeF9s
ZW4NCj4gLS0tDQo+ICBmcy9jZXBoL2NyeXB0by5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysr
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2NyeXB0by5jIGIvZnMvY2VwaC9jcnlwdG8uYw0K
PiBpbmRleCBmM2RlNDNjY2I0NzAuLjc5ODkwNTZhNDYzYyAxMDA2NDQNCj4gLS0tIGEvZnMvY2Vw
aC9jcnlwdG8uYw0KPiArKysgYi9mcy9jZXBoL2NyeXB0by5jDQo+IEBAIC0xNSw2ICsxNSwxMiBA
QA0KPiAgI2luY2x1ZGUgIm1kc19jbGllbnQuaCINCj4gICNpbmNsdWRlICJjcnlwdG8uaCINCj4g
IA0KPiArLyoNCj4gKyAqIFJlc2VydmUgcm9vbSBmb3IgJ18nICsgZGVjaW1hbCA2NC1iaXQgaW5v
ZGUgbnVtYmVyICsgdHJhaWxpbmcgTlVMLg0KPiArICogY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2Ru
YW1lKCkgY29waWVzIG9ubHkgdGhlIHZpc2libGUgc3VmZml4IGJ5dGVzLg0KPiArICovDQo+ICsj
ZGVmaW5lIENFUEhfRU5DUllQVEVEX1NOQVBfSU5PX1NVRkZJWF9NQVgJc2l6ZW9mKCJfMTg0NDY3
NDQwNzM3MDk1NTE2MTUiKQ0KPiArDQo+ICBzdGF0aWMgaW50IGNlcGhfY3J5cHRfZ2V0X2NvbnRl
eHQoc3RydWN0IGlub2RlICppbm9kZSwgdm9pZCAqY3R4LCBzaXplX3QgbGVuKQ0KPiAgew0KPiAg
CXN0cnVjdCBjZXBoX2lub2RlX2luZm8gKmNpID0gY2VwaF9pbm9kZShpbm9kZSk7DQo+IEBAIC0y
MDksNiArMjE1LDcgQEAgaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZShzdHJ1Y3QgaW5v
ZGUgKnBhcmVudCwgY2hhciAqYnVmLCBpbnQgZWxlbikNCj4gIAlzdHJ1Y3QgaW5vZGUgKmRpciA9
IHBhcmVudDsNCj4gIAljaGFyICpwID0gYnVmOw0KPiAgCXUzMiBsZW47DQo+ICsJaW50IHByZWZp
eF9sZW4gPSAwOw0KPiAgCWludCBuYW1lX2xlbiA9IGVsZW47DQo+ICAJaW50IHJldDsNCj4gIAl1
OCAqY3J5cHRidWYgPSBOVUxMOw0KPiBAQCAtMjE5LDYgKzIyNiw3IEBAIGludCBjZXBoX2VuY29k
ZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0IGlub2RlICpwYXJlbnQsIGNoYXIgKmJ1ZiwgaW50IGVs
ZW4pDQo+ICAJCWlmIChJU19FUlIoZGlyKSkNCj4gIAkJCXJldHVybiBQVFJfRVJSKGRpcik7DQo+
ICAJCXArKzsgLyogc2tpcCBpbml0aWFsICdfJyAqLw0KPiArCQlwcmVmaXhfbGVuID0gMTsNCj4g
IAl9DQo+ICANCj4gIAlpZiAoIWZzY3J5cHRfaGFzX2VuY3J5cHRpb25fa2V5KGRpcikpDQo+IEBA
IC0yNzEsOCArMjc5LDIwIEBAIGludCBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0
IGlub2RlICpwYXJlbnQsIGNoYXIgKmJ1ZiwgaW50IGVsZW4pDQo+ICANCj4gIAkvKiBUbyB1bmRl
cnN0YW5kIHRoZSAyNDAgbGltaXQsIHNlZSBDRVBIX05PSEFTSF9OQU1FX01BWCBjb21tZW50cyAq
Lw0KPiAgCVdBUk5fT04oZWxlbiA+IDI0MCk7DQo+IC0JaWYgKGRpciAhPSBwYXJlbnQpIC8vIGxl
YWRpbmcgXyBpcyBhbHJlYWR5IHRoZXJlOyBhcHBlbmQgXzxpbnVtPg0KPiAtCQllbGVuICs9IDEg
KyBzcHJpbnRmKHAgKyBlbGVuLCAiXyVsZCIsIGRpci0+aV9pbm8pOw0KPiArCWlmIChkaXIgIT0g
cGFyZW50KSB7DQo+ICsJCS8qIGxlYWRpbmcgJ18nIGlzIGFscmVhZHkgdGhlcmU7IGFwcGVuZCBf
PGludW0+ICovDQo+ICsJCWNoYXIgc3VmZml4W0NFUEhfRU5DUllQVEVEX1NOQVBfSU5PX1NVRkZJ
WF9NQVhdOw0KPiArDQo+ICsJCXJldCA9IHNucHJpbnRmKHN1ZmZpeCwgc2l6ZW9mKHN1ZmZpeCks
ICJfJWx1IiwgZGlyLT5pX2lubyk7DQo+ICsJCWlmIChyZXQgPiBOQU1FX01BWCAtIHByZWZpeF9s
ZW4gLSBlbGVuKSB7DQoNClRoZSBwYXRjaCBsb29rcyBtdWNoIGNsZWFuZXIgbm93LiBCdXQgSSBh
bSBzdGlsbCBzbGlnaHRseSB3b3JyaWVkIGFib3V0IHRoaXMNCmNhbGN1bGF0aW9uLiBZZXMsIHdl
IGhhdmUgV0FSTl9PTihlbGVuID4gMjQwKSBidXQgaXQgZG9lc24ndCBzdG9wIHRoZSBleGVjdXRp
b24NCmZsb3cuIEFuZCwgZmluYWxseSwgTkFNRV9NQVggLSBwcmVmaXhfbGVuIC0gZWxlbiBjb3Vs
ZCBoYXZlIG92ZXJmbG93IGFuZCBpdA0KY291bGQgYmVoYXZlIGluY29ycmVjdGx5LiBNYXliZSwg
d2UgbmVlZCB0byBhZGQgdGhlIGNoZWNrIGlmIChlbGVuID4gMjQwKSBoZXJlPw0KV2hhdCBkbyB5
b3UgdGhpbms/DQoNClRoYW5rcywNClNsYXZhLg0KDQo+ICsJCQllbGVuID0gLUVOQU1FVE9PTE9O
RzsNCj4gKwkJCWdvdG8gb3V0Ow0KPiArCQl9DQo+ICsNCj4gKwkJbWVtY3B5KHAgKyBlbGVuLCBz
dWZmaXgsIHJldCk7DQo+ICsJCS8qIEluY2x1ZGUgdGhlIGxlYWRpbmcgJ18nIHNraXBwZWQgYnkg
cC4gKi8NCj4gKwkJZWxlbiArPSByZXQgKyBwcmVmaXhfbGVuOw0KPiArCX0NCj4gIA0KPiAgb3V0
Og0KPiAgCWtmcmVlKGNyeXB0YnVmKTsNCg==
