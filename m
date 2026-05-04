Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334283E6395
	for <ceph-devel@vger.kernel.org>; Mon,  4 May 2026 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919794; cv=fail; b=PuJGMVG7RB4xCTMkCFCORR7i7OOPOEW3g5BonfGH72fxIU+w4I6h/BMME4C3cT9ZDBrLwe9hubaPjgreuBb9d9sEW8b4vGBLTLRmt8ySxfFad0r/4AAGEgnOtOrBij5gHwFxeN2wmj3qnytKeSCdZcNT15vyK+nIRxHNGpAKODQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919794; c=relaxed/simple;
	bh=OLt+pc/BIVqjyVJgwlY2SedBIZCq3Dqh5+88HX5PTNs=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kmG92SJpc/LSvooSy52pMqFSvG+hP0yx0lu8aTxLrPuDGgG2ZlWoe0K+tszP1C/LZxdcebSrXk9Rk4jt6RKngU17CzLcuwIumycqLiTqH+YnWo+KP8NXMiQPQug4wkdwBenA6Lp2iCw3fprkb3+zP/51PNZT9j2HHCgd2T/YOA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TdDkDhOR; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TdDkDhOR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644Dux7v2409162;
	Mon, 4 May 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=OLt+pc/BIVqjyVJgwlY2SedBIZCq3Dqh5+88HX5PTNs=; b=TdDkDhOR
	r1w+HzwBddXrdgKKWJqQ0Yh7mvoDSNUH+50ssrJVzkZPlKCt3Ri9S8b7tUKLh2cj
	8Vv0D/2ylwcDaQ38jUHY+BSCE2y7xOX8bTArjmZlac+F+mxBH2C7mAtbX2jB1cko
	a00MUVqYLOcvGoJbhM03OQYX6WJBE2GYGvEFkJub7xLuwvmIEy4tUosEowPkrky3
	vWQa5RtHbwvk6uMtZTJLGciCHfjpAk4yFnyKcN1x6FR+wlqtyIJ1sCkCQcg6IFmk
	DFzreaqFmnFDpu4RmwrOMPyPfwokbU1QZu8+95nLpSaLJl5bVl59kodyC7xjp9G4
	RgvjyU//RwTEtw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4gdc0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 18:36:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olP0FUSlFqokRHPVVp9zMGmmvDfURy6+T8p49f6mbrvrTRo2Bj14WGTmdcZfCs4vV6WDOrAjKEb1OTpciwHe3zsHNlBNwY+T0dI3kTiDJfL3O0oX1uOeCPJ7xJvLNLntZdzWMY5QDD+tt2BvHgEP/pLKzAnf6HvWEfWe4nyGNQbSuI9oxnTbHbLOTPO3hxip075BTmUYiTdl94ajM3DIfKaNKZlasu+BWpUuWbEzPe6z9HYNmf24RoLLnqcvb+BKBIoPiZITjCMBHA8npCUmHYq4aoI5vwcHVgde7a7Z44M611q8cI5NwHHwxrYlyh8+K4AFtiDfuh5ZH8+QIJRJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLt+pc/BIVqjyVJgwlY2SedBIZCq3Dqh5+88HX5PTNs=;
 b=w9ZFdgRBNC1s4AHtWiRaTZRsD8u1o9x0YfZiIlLvnxvMfdbz47P/jvyAZfNeBHo+ZMkyLIvV8mHISdny6I1x3ZzDEdT/8FAemGlk15czoPHy3Wzvlt7y91GICxLMLQ5yLLwyo11+XyZD00kK9PDsMUTCg1VVloFL5BwF5R/IA/QwR4McPSGbbX06DSDEzyrbVN4FNAEIjqQ63YGSqD5yZESMX3tyQHx3yaH2XE2gL0gU9EWpB6jPm2oELE9qLDW+0zHna/eeoQStuDFnIYQCLOxhxUMMS3DYkA6MaKec86/QqGK8dd+p209DhpGV8EJCsScC7Io29evkA5ZG15k81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB5059.namprd15.prod.outlook.com (2603:10b6:a03:3ce::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:36:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 18:36:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "kevin@atekie.com" <kevin@atekie.com>
Thread-Topic: [EXTERNAL] [RFC] rgw/cloud-tier: add exponential backoff on 503
 SlowDown
Thread-Index: AQHc21ra/mA07/uTo0Gnb75gwHLjN7X+Mx+A
Date: Mon, 4 May 2026 18:36:28 +0000
Message-ID: <cb1fbbbedab660b44b3908ac0ed735f4ca9223ed.camel@ibm.com>
References:
 <CAPyngjxORZAvMcWxgY6mS3qcgyQz766KrhH2zXK6RSH=jhVE_w@mail.gmail.com>
In-Reply-To:
 <CAPyngjxORZAvMcWxgY6mS3qcgyQz766KrhH2zXK6RSH=jhVE_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB5059:EE_
x-ms-office365-filtering-correlation-id: 11a95953-c324-4225-a6a5-08deaa0c0e05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 F98V2ueWyQ182j30xoP6Sh3d0bjGyWoQYZiPltoo3DLkeBz975YDT8yQkWORD9qxlTVZ/oAlxJ54WLSgPNUzqVRMrPjl7qvx11SE2EDlc/I0wMlkBJGZJgyJrd+PLaLsr8bR8AnsopqFdXqhRJJ3lpJ1WSQvVMXlGOwzMeuA5+mavP1jhetPaly4nDBCuA9gOXTaqqLbr9j0AWrTpQg782mxJHlXOsCwbaYbZRQH4c8FQsHIf11uIXa+GEygx0xZxDacbhnclat9scbVZ0fw6Eau3yAePFtuntcAcAZv6XI6+lzPGmTNugzLuiBT0lSN5aFznmTbE/2j62pI5dtIo5Mp10WV/sejlsaxTQyGJRpiaBQn9cFnubUAHmxj2/YTk4c9SLTdIZA5iObw093hVndsO3AoCknuH5OpLbqCLllHITSfGi/tv2MkgW0Wrcay8CSgfyNVnX3S0OGuFER1gOmPFf1x3kv43Fmzr+eQMAaPSBGoagGEjjjXpzj9BmZqOWJtEeA5JjVLhTlr5cLnLTM3NYebL1v2hfUy3xlHj+knJIqR36+VgfvV8zs5jPlbgfk7qnzUUXVvMuvk2WVNx6szcX5ET3aZ1STXFdI/FZRsShYUruq4d5Udwb5z7iCJjyr47k8FgTwj+CPF7cgmf3rEg6ka9UyIOK2G2GfKzEB03go3mpIJ2CL6RK4LDVYHpYwdJHhHfZ4LAMIa99ZOyg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STJrS2JSVG95MXU3c3lqQm8zM1p5QmZrZXlIY29Ta0FUVDVsRHdEVjcyUlJY?=
 =?utf-8?B?dnRYQ01VTXhlK0I0NWxzb2Y4ZnAzN1VnZzE3NFNpR01SaU5WV05XYkx4Y2xV?=
 =?utf-8?B?MTRkbkJ6Yy9qbXJVRnYvUDNJQ2xGbkV4UGRZQjlEN05KM1NrclBjKzRENHl1?=
 =?utf-8?B?RmM2SXdkOE9FSitjenBtTGIyS05TRjlYN2pwWE1GRjZ6b2RzNmowMVFlMVcz?=
 =?utf-8?B?RG15Mi9mNjBFR3orcGR1NE4wSlh4eWFFTHUxSXFqcjJnS0c4aTRKQ2ZnYklY?=
 =?utf-8?B?aUVvN3MyczFBUmJKOTNyV1QzcGVJVk5ZTWV2V2NPVFM4VGRQVmhYVG4wbEZV?=
 =?utf-8?B?TjZ0QlNPZ3VjenYzdWtVKzJycFdDc0FIZnpZVnpHaFVSOHRSU0E4dXBhakJx?=
 =?utf-8?B?YmlRQmNndi9rbnluODY0RFA5YWlqY1dsVVJBS0lhNVcxNXNkdFdqRVRIaU1s?=
 =?utf-8?B?OXU3elZSVE5scXJ6RWdGbVJUNHhBQjh6d3BrQldBVmxUS1llbUlTbVE3WlhJ?=
 =?utf-8?B?dGE0V2E2VWRBaWM4Q0Q4ZEg5T1o5S1hPNWdhYk5IQ3ZNcDVKajFqeWJIRWFr?=
 =?utf-8?B?aHNSamMvcDY5NXdVazJyUnZ6Q1BGTEQvV3BvUzZlMGMrellLbUZ2bGF6eURi?=
 =?utf-8?B?L0tRT3FTMkFlbk5idjBLanVnOUduYUhrZ3JPQm9sMVZtQkZXVzkvSHp6bk0x?=
 =?utf-8?B?NjEwT2c4aDNCLzdMYVBjUGhNbzlkeGMxUkU1UUVWWjdrZThyTFBtMlNWdTVE?=
 =?utf-8?B?NXVBT21DZnBuZlpIOWlhQjZRV202NkJOM0RqdXptd2Z4cEVlVkpiWnUxdVdo?=
 =?utf-8?B?cWRwR05SMW5IdkNUcXRuUlVPN3A1U1hjOHY5TFZQMzArS1NjT1JUMmdTU3pC?=
 =?utf-8?B?Njc4TEF0TlhFM0t2TThrOW8yRnJZQ1BrQTlLSVdubEQ5TWdwVXQ3YTV1cXRr?=
 =?utf-8?B?RmNtMEROVFJRcDlwNW11dkNobDFFenJ2VDhLWjBmLzVtMzUybHdRTzlscDJu?=
 =?utf-8?B?L0VHZ21ZZGM4MG54Z2Z6c0dXNmdRWVEzODhndmdkRE9IbUpIREczdU4rNVBo?=
 =?utf-8?B?L2Y0OEgybmRZZWZ4bHJwZ0Frem5waDFVYzNRaG1TRDYrTGkzUzl6dW8wcnR0?=
 =?utf-8?B?MXlNYUxGbFNZZTlMZUppNUlUekIxK2o0eHU4SzIwRXlIdk91NWRrVkFkb3dL?=
 =?utf-8?B?MGd3R3V3Q0hKbHhabk9wZGY1YzhlUmsrVGtBQnVLUDhVZU0yeXpJeTRWYjJi?=
 =?utf-8?B?T25aeW94UjVFWitIVHFOY2x1LzNBb25TdFBkVi9GakpXNFZicUlveUhqUGNy?=
 =?utf-8?B?bzVwRkFUVHVuOU85ZXoya1gxK0VnSWZ6eHJnaHN4MnV4anlKTDRiMGl6ZnE1?=
 =?utf-8?B?bXBtU215SldSVHNuU0IxZVBibFhOVGJtcFdkSHI1aUtNaE5MVHJlNTZUTmQv?=
 =?utf-8?B?ek1MTkNTb2svdmR1M2FWYnJGQWRYS3AzbStKRkFablFzUHFYQmpIZDBnRGk5?=
 =?utf-8?B?WGNYZllOM1BhR0RvZEpkemxyQmYwWnZXaXFkb3ptQ1BNNmZENUljL2ZLWGNX?=
 =?utf-8?B?QUI5Z3ZJN2RvY3VFa2t5UXFpUDRYaFlyc28yampTQks1a1EyZWYrU0IrTHh3?=
 =?utf-8?B?a0V4TzNPS0MvK0wxQ1ZBU012bzAwMzZIRk9SSjVVSGVyWFMzREZxc0dKMWxv?=
 =?utf-8?B?aWZjTERXekZFSFJLNzZWaEJsWFVucGp1WnZqcXFkdEVITDV1NWtKaE9KRGFT?=
 =?utf-8?B?cXNsdW5wNDBkZk56bFFtMExlZ2V2V3Z2WUQwSEw4eDJDUjBOZmlicnFCRGhr?=
 =?utf-8?B?RElCdWxodG82R2ZwRGtsQmI3WUkreXp2N0JDRVhSczJaZzUySGR3RzZmUVFG?=
 =?utf-8?B?K0ZpeTk0SXh1aWZUaTdBYlNMQkRpbWNQOUdSMzEwQ1BheEI2bnA2TytBdTRK?=
 =?utf-8?B?OXF0QlFsNEQ5Y2l4bUQ2VUo5djZNMUl5ZzEzU1VFT1YwWHFicGtZeVgyaUpj?=
 =?utf-8?B?ZWo3Q1RWczByWk1aT1p3NzRXVCtiZTA1MWMwSTAyNXhHYzJuQlh6L1MyNWtH?=
 =?utf-8?B?Y25yb0VSdWR2aHlSamwvVVZoVk8wd29ISDVkUDV1ZXRWWk1POEtFTmtGcHVu?=
 =?utf-8?B?dkJVSzBiRUZqNUpVS2xsRG9YUC82SVlUN3VpMmFlZU55ekhXOVF1MWpXNExM?=
 =?utf-8?B?R3V0N1NCZXdiQjdFSm16alM5T2ZjZW8yZ0VUL0x0dHRQdEhOUUl5M3Fpd0Nj?=
 =?utf-8?B?TngvaUJuMTF0M1VxeGttMDJiVGtvWnJmbzluVVFOam15dnpTckIwVFlieGVi?=
 =?utf-8?B?eUpZbC80SjBkY3poMld6VVJYb1JUOWVyVkNqRnFHU2lVbVFaUU9RcmhMZEhQ?=
 =?utf-8?Q?jIp0U/50HFkJMT0xhcob1TKNu/cuk2O3aN85j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20D07DC2F486974F82C91DF5C1F635B1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LRZfzg3Q+0ehrw9ktapqqHIgdrKQbZgWOpW9rvpQwdxXie/PHXMeLMHu6nleqE46zlYqxVQMoZyfhlGT9vc+gn+dWoSJngJTjEk5qwLIycSzTgxYs6Vx520KCsLYW8wv+xHhqAviBbb/1IgPILRsjPXnIwBRc8M6GXmDeEbgK21qJr75yWdeAYwoIVqp+QQSd9cGibdqRL1An1SkH6g5KT3dul3UO9Mbl/xqhxQdkCW6/Q+erzOdg70nUmapd61hAZ8d248YVzDwaY2PxyRg4D1kCeNRqGvtaDPUw2UXXDCftWzPQ+uVPM16CcMFmWPi16AkY40nvVqw0CfIeDnouQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a95953-c324-4225-a6a5-08deaa0c0e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 18:36:28.4676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3p/xIA3ZKrzZv4axMUZ/RPUjj2L2H33NyZF/UKz4l0pKs9JG4/JGLelukJyqc1D8Si2j9+uaRcAgsfxl+sx9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3MCBTYWx0ZWRfX9li9mK+f0W+m
 F8mg0bujJuUj0XJuXDriygPJ6OFyOKdPj6Z3YUe7pygowsZ1cDt1FMHEt2qvR+X3lML2mIeJd82
 cLzIbq7txb67rRWrhVe1H3OlzswVhIm1jmIBc5+HQpZ5ZX2VaL3D5SFn1V+pUnwV0YwxJ+9TCZ7
 OULySgNcTqJI1eWIMSgJVou1Vwmif/5vRCKtVHnVN9HzOORaGCeYrTuth/M5aUzRc0aNHuErlEW
 JVoot45XZxrPnpMiJS8b7eWBY9G0T9v8eX6So6ITrp/sMe4QFLnIibqgzR15Yp3f6T9RZXNohRY
 qlzJXG+qV8jru+khq4Rj6I5PA2Yy5gKFi0YPZAjjR9DvRBs57k3UnzdJQSBsarukK8w6w5E6D60
 49H045Satf49qklIdvvnQ2dyNiRCNTqqGRs9M71TsTwQqLBvnfzP7iSz7feZ1Av/S/xAIXsXW37
 yciJRZrMnhoO7eDJE+w==
X-Proofpoint-ORIG-GUID: VD0-Jxk1zoWFCneV44QKIIyOkF2yjO5h
X-Proofpoint-GUID: VD0-Jxk1zoWFCneV44QKIIyOkF2yjO5h
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f8e72f cx=c_pps
 a=NVF+LlzI6OJHpaJcpVMg1w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=4u6H09k7AAAA:8
 a=ccDZndt0TGQrxt4c63YA:9 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
Subject: Re:  [RFC] rgw/cloud-tier: add exponential backoff on 503 SlowDown
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040170

T24gU3VuLCAyMDI2LTA1LTAzIGF0IDE3OjEzIC0wNzAwLCBLZXZpbiBMb3R0IHdyb3RlOg0KPiBI
aSwNCj4gDQo+IEkndmUgb3BlbmVkIGEgZHJhZnQgUFIgZml4aW5nIGEgYnVnIHdoZXJlIFJHVyBj
bG91ZCB0aWVyaW5nIGZhaWxzDQo+IGltbWVkaWF0ZWx5IG9uIEhUVFAgNTAzIFNsb3dEb3duIHJl
c3BvbnNlcyBmcm9tIHJlbW90ZSBTMy1jb21wYXRpYmxlDQo+IGVuZHBvaW50cyByYXRoZXIgdGhh
biBiYWNraW5nIG9mZiBhbmQgcmV0cnlpbmcuDQo+IA0KPiBQUjogaHR0cHM6Ly91cmxkZWZlbnNl
LnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19naXRodWIuY29tX2NlcGhfY2VwaF9w
dWxsXzY4NzI2JmQ9RHdJQmFRJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpj
OE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT16SUVhNGtHSDdxRjRBbGZjQ29JSktE
alNIUU5FaldsNnZqMzZRNklNTy1ObHJMWncwQzNvTVRuS3BteXpYSTBSJnM9VzhRblVkUE5zY19v
XzZXdTEtTVlYcUFMaExtalFmTWpyZE91TWpOMWhyOCZlPSANCj4gVHJhY2tlcjogaHR0cHM6Ly91
cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX190cmFja2VyLmNlcGgu
Y29tX2lzc3Vlc183NjQwNiZkPUR3SUJhUSZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJ
bTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09eklFYTRrR0g3cUY0QWxm
Y0NvSUpLRGpTSFFORWpXbDZ2ajM2UTZJTU8tTmxyTFp3MEMzb01UbktwbXl6WEkwUiZzPVNESHZD
ckRNS0F1Y19pYVF0RGxKX3hpeGU5Wnk4MHN3a0ozY3RsSFZNVDQmZT0gDQo+IA0KPiBIYXBweSB0
byB0YWtlIGZlZWRiYWNrIQ0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCBpdCBpcyBub3QgTGludXgg
a2VybmVsIHJlbGF0ZWQgaXNzdWUuIEFtIEkgcmlnaHQ/DQoNCklmIEkgYW0gd3JvbmcgYW5kIGl0
J3MgTGludXgga2VybmVsIHJlbGF0ZWQgaXNzdWUsIHRoZW4sIHBsZWFzZSwgc2VuZCB0aGUgcGF0
Y2gNCmluIHRoZSBsaXN0IGZvciByZXZpZXcgYW5kIGRpc2N1c3Npb24uIEN1cnJlbnRseSwgdGhl
cmUgaXMgbm90aGluZyB0byBkaXNjdXNzLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==
