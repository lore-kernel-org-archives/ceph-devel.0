Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56B3191BB;
	Tue,  7 Apr 2026 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590940; cv=fail; b=ab8CDiwEZ/aEwSNXFJTDV20kTIdmEqGXVHa6H7fbIbDcSdEFL8HkryTn+aHyhvVEyI++uWHnSxabbv00WjcILwQOM2Z8fq5wzKJfEKnjs843z8tNnSFBqlSg0L/5xGsACx/6UeIieHhlutk+mZVf1BSTnkDqwQP5LlOZvuiH1Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590940; c=relaxed/simple;
	bh=b2PXPgf7jlcfz0OqoszDTCza+3s+nAk679waykJml0o=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=EHjEQMrGz8VAgg7iUK7WB+knxxRWvkSlB4QuezktPIjINKL1tEKdG6Lz2RsUmkuF0j64KtV2zkHe0Log9bGF3bidwmXMCb2c6qHNLg1mZ/FZsVJfjOEO4iOPyJV2xlIkk5J/8F8vLbPLrPHY1Pi4xjxU2PXDqDc0Mlf4pdpUmB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qi4pw/AV; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qi4pw/AV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EB9Hj2211010;
	Tue, 7 Apr 2026 19:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=b2PXPgf7jlcfz0OqoszDTCza+3s+nAk679waykJml0o=; b=Qi4pw/AV
	P4QuihzaDlhwRQX93JnzDZRl+DL3TQEV+klShaOFls90zaq4JuyUoEX31T4pP1C7
	LettAumIVe0qUKlklCtBqF0vpE3o4+3lye3QHoo2LEB5RysfXHRz5V9lX0LXqpL9
	w0po/lkYEAJgEvmAKefcyMkIEpQN9eo0o8vjEuA3rxaMjzEHHPvzctL8xO7yVOFe
	69uyOHNjrkEjHJdfRBvNwbJ33dvIar2MGeO/C6oKEzKMbNutg709Y1+Dh1xb0ctK
	mBNlILMIeqajCc0CVdBb3e2m7GdIcDE30OrdxiLMtZdpGokRtL9SONecNvoDPY9y
	wOOaeBZ37MZeaA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hcekr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 19:42:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB9ggOQ7+sEupT1ScPw3I9dIF3gxU2UIwUHeETX1lhuDiruillonY35JP03UAPf786G/EBaL76yvLNXl2vY3yfPQbYmub7fO3YREmkm9X8k2GA7XeGSPNqg7g0rrH8WBIbgWagoCNw4hepv79x6r3LRBQ+iFxA8iWkZnlT4A/+Ef6BsOoOcmmDj9QhzFK9on6NM7qZgpuW8OjRKa9bWrYP7Sesp3ARIG+FDFc3tyTae389sK8tx3eyivqYIQ7iHl38NBVFfdRBZN7gTJBFEw568O29ytn60+3ShpNCjLtK6wzfMns5LsuoYS89hIWVR+ysowWY95hWWSNtt725zYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2PXPgf7jlcfz0OqoszDTCza+3s+nAk679waykJml0o=;
 b=E/RRYodinshBY2snLt2l3w+sf6HJkfT9ilk3x3gz+VmMLvi27K/7Oe3dP4c3B8hGj8aAAeaQ9sHx0UNP4TMj/9BvfC/U2CJa99FOTIA0Y6kxL/ncmfJz41WobMDrHCX8qGGB4u9P5Gm5HOnMMtVVcZhCobeF70F3uUY1ibj+O3BdH5Ajqg0DvM8Q/J7JGfEMLyFWzer/QhMOR/meS+o21DKyQ0tgkxQG7Gz7V+ClCOAAKJerbj6GhuApUqdnGDLEQxNYPkU7fC3b1X3mSW0RRzMja4RlhuQ7cHbAvyJRJ5XR4UDKCbg4RnKv9snrHozEhhNQRGQw4hAjFAzUBk1qyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PR15MB5313.namprd15.prod.outlook.com (2603:10b6:208:384::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Tue, 7 Apr
 2026 19:42:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Tue, 7 Apr 2026
 19:42:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] ceph: bound encrypted snapshot suffix
 formatting
Thread-Index: AQHcxjQAtx72U4uddUe7Bm/0BaD+y7XUANaA
Date: Tue, 7 Apr 2026 19:42:09 +0000
Message-ID: <3d6bf2442f2df5748c6d030e202c50a1eb42469a.camel@ibm.com>
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
	 <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
In-Reply-To: <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PR15MB5313:EE_
x-ms-office365-filtering-correlation-id: d259b811-39b0-42c4-b9db-08de94ddc22e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 kVoJAYC6X1sSri5i/ERcfanp7LWDvujlJurTjCRBDJDUEf1jrA52Atd5WxMjdURQJbCCRap0zekHoOhS2jP7wNOBPdaEoYKSZ2hWZ60ffNi80+QAPFRPzHKfcMp7IkRRFiaZLBVXUHzeRv0O0+95tJzvaUMtbxq5qgw1/RJA2a5QhCwpDa1PEcf9KAuHZKVqg7F5sUOb4cpm7kGwiKS7evbb9uPDsdsy+/XmgQla5e8YOmQdKUaLirfXHiUF/7qelo5JrLbw/BVBB8k7dWlSckL0UUcBsPuuPzZLAznIhfJ4bAwhzP4zbdfFFy71ICoUDFFEptC8VorXFfpvjJqAEBMwz5EAJQxEdgWKWFEGjbQOegX5jypuieEHACsg9x0IltX1FIOJfv6YpOb97jJXW+BolYmfzBHG6quOKrSYRcf5tMDp4+63u8dEZpO62lRbzZIR6k1BadzAJ7BARpA+ly3bB2loBKnI9PvbZR1UjdKjnwIEskcV9NZeKx+fDRY1k4eE0MGHDJv8hhkokNH8ByD2VmpS760Wbooq/h+M7q7sWy4fU056vomIXQ30uQIAJ5SF+3bjWZjneeXYhADD7SYqB6MivG26QDjWkJ3XYC65ktBn7aJvJmF5iiVwkaOajG6qO6tAYM+0LIrPz1fZXmfCCuYO2BO+FbsLGN02/937LyJH98WAMWzzuPy7JGCI7AwuPOWPD77v6AwhzsM00o6lQnDOAcbQFeHyVmM9YUimohwdY58ojGfl9WQLmKh8Da/lPYMeQKRiW7f718XhSQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVNrQThBWEdVb3M0ZHpEd0h4MW1DbFJsVFJMMEFCS2VzeHRRa1B5SmFablpl?=
 =?utf-8?B?bEhRNXN3blo0ZHQyNnJ0dSs4ZHRYTVZMZkVMSnl0SnRsQmRicFllSHAyOFNS?=
 =?utf-8?B?L1V4MWQvamNkcU5URkswWUhFNnE3MzRHeVR6eGh6OUZiTkI0REk4WlhSdTRS?=
 =?utf-8?B?V1prSVoyVFgremlCZ0t1b0hkWDdxYTB4aXdsUUo2MDJrMktyOWZIR25ySXlE?=
 =?utf-8?B?QWEyTC9KeU9naHV5MjloUzFRMVRxbmo0dGZVTitFZnc1NTNxWmVvZDhXbldX?=
 =?utf-8?B?VEVSeGM5N3B5Z283SzhBRFFoUVRlVzdvODRMSlhPQlEvbWJSdjhndEFGczVj?=
 =?utf-8?B?dWFvdWc4TXQ0Zkk0dG5wN1FKdGl3ZWxUWGpENkdnbGlqZ3c0dFFlbDVEbTRN?=
 =?utf-8?B?TU5tSzVTR0owYkFpSXpTeHhHZGFqYU5GTEdjYTNRbmFoTVFjRjNEZ0VKTC9N?=
 =?utf-8?B?K3NmdHF1elExUzcwbDFKcFNXWlIveElWZTYvYW16ZW94NVpmd0dVNFdla05E?=
 =?utf-8?B?WS8wTVd5QUpSUnN4R0FRbWpkQjg0Sy92TGxQeGlFaDNUMlFvemsya3RzMGxr?=
 =?utf-8?B?YnhkRkNSUzhRL1JFc1RrZVBTQnV5Y3paR1NHd1IrVHIzT2hIMDF5UktnTFFF?=
 =?utf-8?B?YUdrV2d1QlpIdEUrc3pCZlpzMnFhZDhqRXpSdmU5M1NJWkpQcWJRUTdKK1VF?=
 =?utf-8?B?Smt5WlZaeVhsS2E1aWNmaW5VK2gvRnBjVWRsSjRPbC8vUkc4TDc0MnBpczQy?=
 =?utf-8?B?U3ZQVUJ5YzlkaGt5M09MUXFQbk5Qd21ldHVUUnF5amNueHEyTzI2cjBaYytL?=
 =?utf-8?B?M0VnRjgxN0lTSkFMMVdRM3ZyM2tUMkxBalBGYStYTTJnbHVHV1I0YzhDTXhY?=
 =?utf-8?B?bWVWcFZWQldmSUphaGtJNjlRcktHS293TTJvcDJvVVQzRFp2MnpyQWtQbU9H?=
 =?utf-8?B?NjFhT0xMQ2dLMkRlTEFHbWRMYnFodnJ4R3paZDQwb3czT3VrZFlPY0FXcExS?=
 =?utf-8?B?MmNoeEFqek5zQUxUZVRwK3F1R1lWeVdSOFZ1aXRKaFB0ckI4cmFHU1VGYVJO?=
 =?utf-8?B?SjA2eXNHb3JIaVl3QmQrVnZYM2kwQmtuQ0c3RXFhbkpMdTh5clVONlZ1Wkkz?=
 =?utf-8?B?L0doYnhtejhvckJVWHhkWVpKcStVWXgyK29MWnduaVlwNHEvNnVNUUkzeThp?=
 =?utf-8?B?MUJMNmdQcWNBd1QwbnpFdENDYk1RdjFnaGthK1hlMlhtSmErelZJRjk2U0hG?=
 =?utf-8?B?cHVuelJvUVZKNFpFWjRhbE9XeG5vd2ZHY0pKbGQ3U2hOM1M2a2dpUkhMMFUw?=
 =?utf-8?B?NFJPYjNjcC9JQng1RXk1Y3FheXhPK3ZsRzZBUkZ2YXp5ZTdGamJUdEdsanRl?=
 =?utf-8?B?WnZERFM3a1JETG44Q2NwZUhuNUlSUlVubnJOK2NvalJGbGZkS3paM1lBdjRa?=
 =?utf-8?B?SmRtN0hreXU0TjRIakNrZDBuQnBiM3VwalIwSUlmWm5XQjJoUWpRRy9UM203?=
 =?utf-8?B?Ym9Yb1JJOVliTDFWckd6K0FYdVgzbWxaUE9Ha0hLbkphOTJ5WmpKbSt3b2t3?=
 =?utf-8?B?VHdCanQxQ2NUMWloMDNrOVAyNXcyd1RTRjhkclRMeXoxem5NSmVTTUdidk1r?=
 =?utf-8?B?SnR6YUFRczdRVDZDbjAySzFXL2VGcXF3VTZOcVJGbkpsMjU5OEMyOVNOK0tO?=
 =?utf-8?B?RnRGUDlkU1Rlako4TC8weGtZMWRoQTRpVS8yRkFEQXdLUUl5UE1zY0d6NTJC?=
 =?utf-8?B?YXgvS0VDWUpBYjhlZmJNWW44MnVXakxmZUlVZGRZczdZaTh2YkhaUy9EbHNF?=
 =?utf-8?B?NUVhZ0NHbTRSYS9FNWVmSVhDWXh2NXR1TnVXUGdMbWpyMWVPMEhOSURINUdM?=
 =?utf-8?B?dzZTVHNCc2oxZ0E5cjBwQWh0VDA3VHgxRGg3cnVTbHZGNDRaQ3BmSGU0V093?=
 =?utf-8?B?cEswbUppNDBBeWwxVkYzR25NRFYvT1VSVFdPSU15eHVUWFp1YTc3U3ArbkE5?=
 =?utf-8?B?S2F0eS92a255RnBYUjNZeHo1TjBPUDUraC8rOFNyQjhIZmc3cGRLM3lZTkNB?=
 =?utf-8?B?ZlAvT25XazExWkVCYnJDYmxZcVJQVlo0UEthWkNzYmVFaHNDMVdtS2lGR0k5?=
 =?utf-8?B?U3FmQnVXRk1oTUdZdlFmU1UvenF4bml6L0RoRkNMQm1OK0ZHaHNZUEthVmRH?=
 =?utf-8?B?U1FtNnVhK0F0ZE10ZnV4RCt4a3crcXZnRnh3ZFRPNHNudnJqSHAxQTFTMlV0?=
 =?utf-8?B?SzhldGZ3VkNmMUdSc3Q0ZWxURUltZllUdG1obUxRMnZGTXYzUVZWaHNod0tH?=
 =?utf-8?B?SDNPTFowMmZPbzR1bFJ4cDcrTCtkK0duOTJMa3g1Uzk1eVNtcnVsNkI1RnZi?=
 =?utf-8?Q?LL+ELWpz/6D16CD6K6PPvpQiuHNRfo94G2Xwf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <346ED98569F3BD41B0B27D9CA3D0073B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ssC7bqdlOOgcOUAqbHSehkPiNpwxUE9d08E70dCKstwc8cTHzCKIahfi+2D212QXjj5UbopsSmeZkjUan/j/VAF8eQbzURGlACY+9yt2shV792kXdAb+XVaAAmFKFe1RUi733Jnx8IKzaRo3vFLz9VZTY+pn6YoCN4M510A+dC/DGFPuz0C0PoL6GnuUINukYO1pnyCC0Yg1bCPe/jMqWUeRZJaEAXkakFZ7jQFV4M9fF+gesX0xqVHEVpodh2v5dPeH0Dgiy8p6DFJ5TrThG1FkkfzOm4jK4F6b3YT8QRuvhHdMTm1fMZwbUf+2UhAa5/oEVHkaPrVDAdnSLQzI0Q==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d259b811-39b0-42c4-b9db-08de94ddc22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 19:42:09.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Tpt8k/4FNFVW7z2wRbM9QLIluMm2aMGMP/JcI4ihqgOYrj8DNYlTYu0XI2PlB7xBudV6x8N7M32k42xD/XWDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5313
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE3NSBTYWx0ZWRfX5XukYysq0O4C
 Lw16xOMEor3PPbZhry6fnwcRe9g+0MBeiBtF1QkFBd/UdH1Tv9OyGwLSUidbLBufOPslot0iooe
 2zZcd1GoTQ8KMgvrxURo4GuuE8vvWRBqFE6xml2yU0RNZofg9zX4WPp91AePB5iQD5d6FlMrlI9
 Uef4VP6RRCubMYmOUdB/o4kXDG7Elu04KNEUjjuQ+ACCokkecC1VMlrsljjaojXfSaxjEZ+2Jgn
 sS1VhAjYXiS3lqygJPYtQc1Y160ALXmO7aOowuFzp+oVQeXD9nPD5dkUkmQRzbzFOqWWuvR4Oti
 F8TaU7Ft0eDCPf5QAavMQ6rPeVeqNKgLiw10M/18DgLAROLDi/EsDKUMcICEk3s4odAiU5RmOlz
 DcdN3p3JAWftvz4I5s8W29SMdEDiYYjsGQ/S8+5xrtcbdaEWIJaYriWzNuHB7r08qhjm6RdU9Oj
 WBhtZRkniAqHxTuuw8A==
X-Proofpoint-GUID: PCS4nMZv6AiKYpk1Vvl0vETKJ4bfvWvb
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d55e15 cx=c_pps
 a=pAJzO7k5KbwWJfk/IQaIJw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=72ys2Kx2maC_J2r80kAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KaiaWrjLrlT4pqEMU6z1oN8qSbJmeGv2
Subject: Re:  [PATCH v2] ceph: bound encrypted snapshot suffix formatting
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070175

T24gVHVlLCAyMDI2LTA0LTA3IGF0IDA5OjU3ICswODAwLCBQZW5ncGVuZyBIb3Ugd3JvdGU6DQo+
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
eTogUGVuZ3BlbmcgSG91IDxwZW5ncGVuZ0Bpc2Nhcy5hYy5jbj4NCj4gLS0tDQo+IENoYW5nZXMg
c2luY2UgdjE6DQo+IC0gcmVwbGFjZSB0aGUgcmF3IHN1ZmZpeC1zaXplIGNvbnN0YW50cyB3aXRo
IGEgbmFtZWQgbWF4aW11bQ0KPiAtIGRyb3AgdGhlIGltcG9zc2libGUgbmVnYXRpdmUgc25wcmlu
dGYoKSBjaGVjaw0KPiAtIGtlZXAgdGhlIE5BTUVfTUFYIGJvdW5kIGNoZWNrIGxvY2FsIHRvIHRo
ZSBmb3JtYXR0ZWQgc3VmZml4IGxlbmd0aA0KPiANCj4gZnMvY2VwaC9jcnlwdG8uYyB8IDE3ICsr
KysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2NyeXB0by5jIGIvZnMvY2Vw
aC9jcnlwdG8uYw0KPiBpbmRleCBmM2RlNDNjY2I0NzAuLjc3MTI1NTc2NjBjMyAxMDA2NDQNCj4g
LS0tIGEvZnMvY2VwaC9jcnlwdG8uYw0KPiArKysgYi9mcy9jZXBoL2NyeXB0by5jDQo+IEBAIC0x
NSw2ICsxNSw4IEBADQo+ICAjaW5jbHVkZSAibWRzX2NsaWVudC5oIg0KPiAgI2luY2x1ZGUgImNy
eXB0by5oIg0KPiAgDQo+ICsjZGVmaW5lIENFUEhfRU5DUllQVEVEX1NOQVBfSU5PX1NVRkZJWF9N
QVgJc2l6ZW9mKCJfMTg0NDY3NDQwNzM3MDk1NTE2MTUiKQ0KDQpUaGVzZSBkZWZpbmUgaXMgbXVj
aCBiZXR0ZXIuIEJ1dCBJIGFtIHN0aWxsIHRoaW5raW5nIGNvdWxkIHdlIGhhdmUgYSBtb3JlDQpl
bGVnYW50IHNvbHV0aW9uIGhlcmU/IDopIERvIHlvdSBoYXZlIGFueSBpZGVhcz8gTWF5YmUsIGRv
IHdlIG5lZWQgdG8gaW50cm9kdWNlDQpzb21lIG1hY3JvIERFQ0lNQUxfRElHSVRTX01BWCgpPyBB
dCBtaW5pbXVtLCB3ZSBuZWVkIHRvIGhhdmUgYSBjb21tZW50IGhlcmUuDQoNCj4gKw0KPiAgc3Rh
dGljIGludCBjZXBoX2NyeXB0X2dldF9jb250ZXh0KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHZvaWQg
KmN0eCwgc2l6ZV90IGxlbikNCj4gIHsNCj4gIAlzdHJ1Y3QgY2VwaF9pbm9kZV9pbmZvICpjaSA9
IGNlcGhfaW5vZGUoaW5vZGUpOw0KPiBAQCAtMjcxLDggKzI3MywxOSBAQCBpbnQgY2VwaF9lbmNv
ZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LCBjaGFyICpidWYsIGludCBl
bGVuKQ0KPiAgDQo+ICAJLyogVG8gdW5kZXJzdGFuZCB0aGUgMjQwIGxpbWl0LCBzZWUgQ0VQSF9O
T0hBU0hfTkFNRV9NQVggY29tbWVudHMgKi8NCj4gIAlXQVJOX09OKGVsZW4gPiAyNDApOw0KPiAt
CWlmIChkaXIgIT0gcGFyZW50KSAvLyBsZWFkaW5nIF8gaXMgYWxyZWFkeSB0aGVyZTsgYXBwZW5k
IF88aW51bT4NCj4gLQkJZWxlbiArPSAxICsgc3ByaW50ZihwICsgZWxlbiwgIl8lbGQiLCBkaXIt
PmlfaW5vKTsNCj4gKwlpZiAoZGlyICE9IHBhcmVudCkgew0KPiArCQkvKiBsZWFkaW5nICdfJyBp
cyBhbHJlYWR5IHRoZXJlOyBhcHBlbmQgXzxpbnVtPiAqLw0KPiArCQljaGFyIHN1ZmZpeFtDRVBI
X0VOQ1JZUFRFRF9TTkFQX0lOT19TVUZGSVhfTUFYXTsNCj4gKw0KPiArCQlyZXQgPSBzbnByaW50
ZihzdWZmaXgsIHNpemVvZihzdWZmaXgpLCAiXyVsdSIsIGRpci0+aV9pbm8pOw0KPiArCQlpZiAo
cmV0ID49IHNpemVvZihzdWZmaXgpIHx8IHJldCA+PSBOQU1FX01BWCAtIGVsZW4pIHsNCg0KSXQg
bG9va3MgbGlrZSB0aGF0IHJldCA+PSBzaXplb2Yoc3VmZml4KSBpcyBkZWFkIGNvZGUuIFRoZSBz
aXplb2Yoc3VmZml4KSA9IDIyLg0KVGhlIG1heGltdW0gcG9zc2libGUgc3VmZml4IGlzIF8xODQ0
Njc0NDA3MzcwOTU1MTYxNSA9IDIxIGNoYXJzIOKGkiBzbnByaW50Zg0KcmV0dXJucyAyMSwgbmV2
ZXIg4omlIDIyLg0KDQo+ICsJCQllbGVuID0gLUVOQU1FVE9PTE9ORzsNCj4gKwkJCWdvdG8gb3V0
Ow0KPiArCQl9DQo+ICsNCj4gKwkJbWVtY3B5KHAgKyBlbGVuLCBzdWZmaXgsIHJldCk7DQo+ICsJ
CWVsZW4gKz0gcmV0ICsgMTsNCg0KSSBiZWxpZXZlIHdlIG5lZWQgdG8gaGF2ZSBhIGNvbW1lbnQg
aGVyZS4gVGhlICsxIGlzIG5vdCBmb3IgdGhlIE5VTCDigJQgaXQNCmFjY291bnRzIGZvciB0aGUg
bGVhZGluZyBfIGF0IGJ1ZlswXS4gV2l0aG91dCBhIGNvbW1lbnQgaXQgY291bGQgYmUgY29uZnVz
aW5nLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiArCX0NCj4gIA0KPiAgb3V0Og0KPiAgCWtmcmVl
KGNyeXB0YnVmKTsNCg==
