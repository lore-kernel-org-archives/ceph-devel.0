Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D291A682F;
	Thu,  9 Apr 2026 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775758162; cv=fail; b=WX8oaQLDmMWg3ifzXL6U/PmiIT/C062vMN3NZBx6Xd36cLR54AUsSzW21kP6Z2zGp048La/8Es+97ehhJcNLEqKVlosb5ChnzUz1iGrhCUyHEETtUTOSOYGLT6LJBfgUjd6lTjeoy+LvtfM8AyTHA014o6RPa++PZQb6VD/XHtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775758162; c=relaxed/simple;
	bh=uAvlLGHiqWvRUZ2fD1Y7yvqgjN2Ep2/Ebmc6hPwaZK4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KxPtnMU3guZAsgpDCYum4U4K7nAgWJPG4mHTV5SQxl6MpMhV2Hnx80CDr6DW6SECggUZINqfpFtpx20+OWiRR5bzla9sP5l6+rEeSpK7OioQzsCGVhJJMZt1tXOeF82jWCxO3L93ngyYpt5irGwi15bFaWXTmDf7paOI33HOH7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cVa2XdOd; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cVa2XdOd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639DNxJO286019;
	Thu, 9 Apr 2026 18:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=uAvlLGHiqWvRUZ2fD1Y7yvqgjN2Ep2/Ebmc6hPwaZK4=; b=cVa2XdOd
	18VJUma88UwMnlZcQBPz04hU01IPMwPXiW1oEu86NtZ8wLXraW+zo1HxdXwMSbWp
	IiIXaKgAHhfCSDWnSEM9jdz/4x4ujrU8FteAHhl5igLhHoXS2TEQQveH6wkzIw4J
	IcIBKPJctk9cC/rVvhGC1/PRifx2mGibWM9z3HfH0/N000VJSijqLrgaIDXi5npH
	ofeGC7znNSFh7QyN4IC41ZON8bJM55wxtTvPLLnFHW/wPxy00OmU8sQNMeP0qUhY
	AuQnqnhMUB7T+0jU8XxN/Xjv70Smqc0QBvfKZB4Z4JpnXSBzXYqK0d2mUt0SmNpZ
	9beZwsRFa9EFCg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g5jga-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 18:09:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3Bc2A8FoIv7EMTW9/r8C5/VwIrfNRv0MsOlwF8saZsgu39SEzTdYMO3T/e6PQ+DlsHgK40eCVwQwFjn3BQg2Zhxpp/8Ohg/D9RW78cYs57Mb0BQbDDloHUfKOokK+0mHZZ5d330ZkjCKejGWRoEzQkpvB2M163NZMFrqB/SnfIoaWThwSZL3CdxXC0Hx9VZ+mMKVPTAxMc+h4d30W8HEhyY3i1MNXRw9rBwz9sA1f8dVa5hQ6n8ftsT0YjEiLQHmteHXw8AEc+lTUfXuh82XfIj1zUndgQbp+h3v3rzAVDIlxM11VoXkeoJ880NzJOv392EC+lTZGMovgcu7QRQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAvlLGHiqWvRUZ2fD1Y7yvqgjN2Ep2/Ebmc6hPwaZK4=;
 b=BVAXn6h4wTUnQnELaqh06ZMy3qRtbNhywVa3iSEI6TkCmwHfQUZMBvqxZ5J3kXwGw1nm7OTYswg8UugJd0CPZiZuXqpU0FvuDEham8ICYClpgxKZRIHuuZDY3OYqnKLBhjfgj7G0q0pPOhVEgCQHf3a9Vx6CeYww0FiPyYPh0DKLqEwfwbBUk+shlBcsPpUrEfSPZFBw8LiO1shu+ompsO7jB307jwjXoyvV9wNQSU7Gb/0oHFzagrUsht8JJcmC8Om0hgI6npOqaaOXR68zNDebvZOFvG+k/WiW6UyWQEzrLZv69AmYhQQ6Kbaw+ev3Fkjzq83Lq7atl/zyzH4JrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by IA0PPF5C998E712.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 18:09:10 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 18:09:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v4] ceph: bound encrypted snapshot suffix
 formatting
Thread-Index: AQHcx8qSpGHjBdMvZUaZ8UvEPs1qbLXXCFaA
Date: Thu, 9 Apr 2026 18:09:10 +0000
Message-ID: <f957bdf6488b391b4329ff3cc892bfdc93c014fb.camel@ibm.com>
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
		 <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
		 <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
	 <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
In-Reply-To: <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|IA0PPF5C998E712:EE_
x-ms-office365-filtering-correlation-id: 2adb6527-8bae-4a8b-873f-08de9663198f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info:
 U/obaAe8bVQ7qSE6ZTwEnbLBpQtWf2fBDB2RsPV6FPvRgdZCz5WeLOnJP0lQ3Lmq9G84FdYmZ8fl0/IDFSbgAvsa7qxdoqZZxN6LmbJ3hB90Pv/qq7Qu7Jor4Nrkyq8lELz43067yH+OzsYWy+y/xVGPkDNOvcpy3S9n/KIwy3CtuJXvJvFGSOy9sZcGov/9At6JU0ztWliiLPxxWZf4Ov5E16lFQgqnRUrAhKQ9EwjYNXANLZztuURpzg6US4Ope4zNQ5ugV7C0dstb9+apcm+P1u/KoZLj9xG+AbSMP9RoRIQoe2J7HrBEplF1MdorUP5QHyBn5GJuV7KHIO/OJpJCc5KIbRcs0/nfTyoHUavODGgKBanmYbRklukaVFI5cbH2Y2uyC8aMH2DuD9w0ZARx5WgoL7yol3eW8pnFNjKFINOCbS6Bk8PZElZ8eqOlZRF4RAooL8qUZJcCDSc+O1Xf3gylIMmSBFlcxXxfywo/rfm6kTfz1seGGAttFBFhsoJ4UPTaaA2EqwQWnTmGIVUa8WeUGzHNEY4ju3zRY/T1BdFmcScLz9A5nIrbQ1XahggSOPUPMb+J5+J7q0IXosegcn8g40r6duW3tAjYiFjrpuCeEv4xVO+Eszh/w0aysrxVr+SH9eRgZ/PmvS5jXt/YcNPl21N7eShG75P/jo2A/EvxttpC8rQF41bAPOjmEcNeZ5PSQX9V93STY8crVXnVRx87+nRPOF3R5qswDvkhxs/MLUNqAVmd9dqflLt5c0n/VrDA5Uzpktk+lVh3QXkZwOO4pjyPXMHhsbz90UA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXpZMm5KSENBMWxKNnJZV3o4cExYL3NuZXdEZmxRcGppZHc0NkRBV3diNWNi?=
 =?utf-8?B?SVpwVUh4K2srcE54Ti9SWExwdWZMVlE3cVdzWEhpa2VlT2Q1RWwrM2JLVE1N?=
 =?utf-8?B?WWRvWFZUSVpvZzVmTEJCNG1JMGNGOWhwenBzRHpUVHJlSy9oTm9uclducXVJ?=
 =?utf-8?B?OUttajczWWxaVHNrRVNuMzZJeFVPM09QYjRGVGVnc0lJRklxcVJVRFhQNjhW?=
 =?utf-8?B?VEhxZThNNTBsZTNmUE5CMXhyM2ZENjN6cHBOU21FWDJjTXE5clpDWTZROHpo?=
 =?utf-8?B?Smg4K25GY0dsVWxTbFhFbEd4d3hjcy9GOThHK2Vkd3hzUlFaUEUwNnkvNW1W?=
 =?utf-8?B?WmVnellaYWhKN1pLS3JTY2cwTlNjdGJYc3Z2UVZRa3pWaHNaS0lNZ2FQT0tn?=
 =?utf-8?B?alhNL0JwczkweitjMG1vMUYxOGNFbjJHVFlHbnhNRUlaekxmK2NvbVd3SENV?=
 =?utf-8?B?Mjl4U002bVBaMEJTVzVIcDJ3bWVWQ2tEck14bUd4aXJKUjdFNGZSTEVFa20v?=
 =?utf-8?B?cWR6enB3dUI3eVV1RFVGOE1DYjVoemkrSFB6UXJnK0JBeTgyRnF4ek1qMjBC?=
 =?utf-8?B?aVFHS3FpdlZBK29DMHhEZFl4YUtkZGR6aENJb1hQVlNBV2Z2SEUycVRMM0pi?=
 =?utf-8?B?SVhjYWVQODlPVlArdkZwbFJmckJjS0NrSGUwdWp4VWd3a2VycE00S2xmc0N1?=
 =?utf-8?B?dzNWOUcrQUMxSFFTc0JhdUc2a0FySkM5ZjRmazh2TkZBUDB6QTBKR0VzdXZ2?=
 =?utf-8?B?S0xlQkhuZ1lWejE1a1EvMndQenZwVldIZnQxUFhCZVNTandZMHo5L0NVRVU5?=
 =?utf-8?B?MUNXNVpXK0poelVjNG9nUnZxTnJ6c2FWK3hNeVU1dm5wZTQ1QTJGU1VWVW9h?=
 =?utf-8?B?ei94dmdMOHNsSFpacmRKb3pDMGx3bFYwNW5QQjFtUVloUE5tWnkybStZdzVV?=
 =?utf-8?B?blFvcExWTExETDVlRS9iTmdOMXVxblNwMk5oMWhaS3B0YytHRzlWMGdMcGdG?=
 =?utf-8?B?Ly95THd0M2g3Mmo1cE1PKy9Cc0F3Rmx5Q3hlZ2FHckVmNWpRS0NaekpVNm0x?=
 =?utf-8?B?eENJajArYktnZi9QdWdVRWNWN3dpeVBoampSVFhDTkxWckF2NzdNR295b0FZ?=
 =?utf-8?B?SytPN1dZbVRwcXZ5ejRqcDdGeG5NSlF1cEw3bTZRaUtzdmNTWWlFd3pVdFBs?=
 =?utf-8?B?Ympxc3VtZ1hXL2x5eXlqRzhvVDdlQmFZNmgzYzAxM2lQWDROQ3QyK04xSit0?=
 =?utf-8?B?bTVYY3JjbE9ZQUNqVTlZeUtnNTdDZWczbDc2b3Fhb2hyWFovenY5U1NYYWMy?=
 =?utf-8?B?NlVtdlozTWlLNW1Ebk1reW9pR0tZT1lvQkhQeXI3T0VQVHBYNVBTbFVrbDNt?=
 =?utf-8?B?bWJoT2VOSWE2S0d5a0tTS09iNVN2eGRLQWRSSWx4SUNJaGhjUGJsaEZkVk9t?=
 =?utf-8?B?SDZKdHY5OXM4Sk82c1RJdFgxZ2M0bm5oblFHQkQyU25xdkpaVEx5bGVtbHRD?=
 =?utf-8?B?eVJwd3JFUXNqdkdrSVdsd05PUGlmYnN4QVBtR092Z2kyRVhLZjNkZGxJYXZB?=
 =?utf-8?B?bllSUGRNeTlnL01NL3BjTDFGUVFXYW9JNzFLVHNwR2pHdlFScUVYVGNMVS8r?=
 =?utf-8?B?eFZuc3BHcUV6SGpjdkI2QVNyZHlwWVJtYSt2Nnpmdk93WEoxekhMYkJRLzVX?=
 =?utf-8?B?aUc2M0pyU3hSY0V1czZCQyt5VUE1L0hoeXprRDBqS1ZSSVMrMERaYnVDb2Vp?=
 =?utf-8?B?VWZkK2gyZHBYOXlGdVhldE51SWdpeW5iRDg2N0VYS2lCamlzU3QxS2hhdmhH?=
 =?utf-8?B?VlRNWjh0WDBybFZ5YXJSZkw3TkM5aUp3WWdGOTVQbStRamNlc2VkODlNWlJE?=
 =?utf-8?B?SnhoWi9lQkVaTEFiQmJRWHAra2djOUY5blR3SmR3UnZoUEswRE5SVzB1ZlVF?=
 =?utf-8?B?TnZPNS8yUDE1L2kyZjdBN1NFWnpRaStKZXFKaGJyOWlLSmtDR3FmK1JscHFG?=
 =?utf-8?B?TkpsRzJ6QXVFbU9MU2lCTWNCVzlLVDljNlRDZEViM1hUSW0yTUxXSGlqLzN5?=
 =?utf-8?B?UGlzVmFTNDFSVExFalBaVWlnUVF6Nmh1YmcyVmZNZFlkUVlDVW5mRzZDd1Z1?=
 =?utf-8?B?UEZOVHEvcFZDVWtrN29JUXBPMW9xZUZ2bWtUYVM1WFNkOFNCSWNhWVc5eFMx?=
 =?utf-8?B?YXpJY2dvZUVBRmVrMnA1Rnp6c3dGbktLZlkyMkZKUTZnRXJHakFkOWw4cG9C?=
 =?utf-8?B?bWJIMFlISEhYeHdKbG9RUnZkOHhWNVdqS3ZWV3BObjVPRVFNMGt2b1ZzajRn?=
 =?utf-8?B?Q0RqUFhtQXprbTNSS1R1SGg1WXVaUmJSdTlVOG8wSERvTS8rREhkS3ZKdUpo?=
 =?utf-8?Q?x825bt5ci9C+C9fDm/AILnp1xI0sdXJjVl+mU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFBCC419BB75F840ABCFD2A83D6504BC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fDmakLZc2hklZdCkOb5GvF96QDKiLAVB15p3Fh7nyjnO2n0xwsIBDCls9VleF2ih5tVzNwdLsRKrskIRYXFDkNybMTncbYsjjYWZqUz98B0aGAaV9Bp75gecuKYm3LjzguVlW0PU0SyZp5UsRsIuksqSriagcutAhpX7alj6O5ig8VaTec4iTeF5cIUknTKSiF36u66V8msE67hP/+cwCWgOL00L4y25uMZGmUsUA8ssJ0Ku8m7Mc4qcuXf0WpH0F8XkGBn+egz7LaHW0hYphgXmZcPdkExpDKZHILrorTPIWu0YFBP8tMBdB6lwXITExpS22LhW5qnl4/DOaDX21A==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adb6527-8bae-4a8b-873f-08de9663198f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 18:09:10.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRA1m+WkGbTyr2H4yGp21cnQyLs4Nl3nuJFa2aQEKiJuOQoe79E/9UfwD6fyaVtQ05Fvgjp0CKS4Mu6d9eERTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF5C998E712
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d7eb4a cx=c_pps
 a=zHP1L1ZDY46t+2XtVYLmoA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=XCOGtoKd92LK4pynIC4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FfS_1JaSS25KXG9Tr6gSe2yjnr0X3zw6
X-Proofpoint-GUID: iLZBU45GDGT2o7yQ-E-oNTzFSqF70yqP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE2MyBTYWx0ZWRfX+K5q1wfGx8Iu
 34fZ9Czyc/RuZ4VAZSrtxOjZIBD3wL5T8UxVKCzJYN3Z2SxRI4ZRQp5D3ZJEKg6o5OsgKehsv3g
 SxinTfVG6HrpHgl7ZAs5lx7FM5v6DgzCsz+tSc+TF63a8sLf2bMF8rWeNmeslfiQluCxzhHpWFf
 1t4pfQ2WEqodfR9CI0G2hFtjnXgAPbicUEZXbbpOV859BzURlKzJG+2Z1/9vyV1OJyEU6Of61F0
 +KGTDsZEnn/w0DfdXz+73dussL2TtkcyRrjhcziVCmekQeNB3gWTIb/YbXoOPvBK8cot0Tt8c9x
 diT/Bnh2JyCDJUfJeD4Nm5e9gHX7/KiWBSIW/3Y+BMfKnfJH39TZfur1ft0QE8o17bNUMaq2w47
 r8IDRImqK2LuQfP8iYNEkCCDYN/PQWreHYBehBLvq92dgQl254E1qBcgHS5bIgLdQUmlFiS82fJ
 66HIc/gJ/FPKEPJds3Q==
Subject: Re:  [PATCH v4] ceph: bound encrypted snapshot suffix formatting
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090163

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDEwOjM5ICswODAwLCBQZW5ncGVuZyBIb3Ugd3JvdGU6DQo+
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
c2luY2UgdjM6DQo+IC0gcmVqZWN0IGBlbGVuID4gMjQwYCBleHBsaWNpdGx5IGluc3RlYWQgb2Yg
cmVseWluZyBvbmx5IG9uIHRoZSBlYXJsaWVyDQo+ICAgYFdBUk5fT04oKWANCj4gLSByZXdyaXRl
IHRoZSBOQU1FX01BWCBib3VuZCBjaGVjayBpbiB0ZXJtcyBvZiB0aGUgZmluYWwgdG90YWwgbGVu
Z3RoDQo+ICAgaW5zdGVhZCBvZiBgTkFNRV9NQVggLSBwcmVmaXhfbGVuIC0gZWxlbmANCj4gDQo+
ICBmcy9jZXBoL2NyeXB0by5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9jcnlwdG8uYyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gaW5k
ZXggZjNkZTQzY2NiNDcwLi40MmUzZmZmMzQ2OTcgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvY3J5
cHRvLmMNCj4gKysrIGIvZnMvY2VwaC9jcnlwdG8uYw0KPiBAQCAtMTUsNiArMTUsMTIgQEANCj4g
ICNpbmNsdWRlICJtZHNfY2xpZW50LmgiDQo+ICAjaW5jbHVkZSAiY3J5cHRvLmgiDQo+ICANCj4g
Ky8qDQo+ICsgKiBSZXNlcnZlIHJvb20gZm9yICdfJyArIGRlY2ltYWwgNjQtYml0IGlub2RlIG51
bWJlciArIHRyYWlsaW5nIE5VTC4NCj4gKyAqIGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZSgp
IGNvcGllcyBvbmx5IHRoZSB2aXNpYmxlIHN1ZmZpeCBieXRlcy4NCj4gKyAqLw0KPiArI2RlZmlu
ZSBDRVBIX0VOQ1JZUFRFRF9TTkFQX0lOT19TVUZGSVhfTUFYCXNpemVvZigiXzE4NDQ2NzQ0MDcz
NzA5NTUxNjE1IikNCj4gKw0KPiAgc3RhdGljIGludCBjZXBoX2NyeXB0X2dldF9jb250ZXh0KHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHZvaWQgKmN0eCwgc2l6ZV90IGxlbikNCj4gIHsNCj4gIAlzdHJ1
Y3QgY2VwaF9pbm9kZV9pbmZvICpjaSA9IGNlcGhfaW5vZGUoaW5vZGUpOw0KPiBAQCAtMjA5LDYg
KzIxNSw3IEBAIGludCBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0IGlub2RlICpw
YXJlbnQsIGNoYXIgKmJ1ZiwgaW50IGVsZW4pDQo+ICAJc3RydWN0IGlub2RlICpkaXIgPSBwYXJl
bnQ7DQo+ICAJY2hhciAqcCA9IGJ1ZjsNCj4gIAl1MzIgbGVuOw0KPiArCWludCBwcmVmaXhfbGVu
ID0gMDsNCj4gIAlpbnQgbmFtZV9sZW4gPSBlbGVuOw0KPiAgCWludCByZXQ7DQo+ICAJdTggKmNy
eXB0YnVmID0gTlVMTDsNCj4gQEAgLTIxOSw2ICsyMjYsNyBAQCBpbnQgY2VwaF9lbmNvZGVfZW5j
cnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LCBjaGFyICpidWYsIGludCBlbGVuKQ0K
PiAgCQlpZiAoSVNfRVJSKGRpcikpDQo+ICAJCQlyZXR1cm4gUFRSX0VSUihkaXIpOw0KPiAgCQlw
Kys7IC8qIHNraXAgaW5pdGlhbCAnXycgKi8NCj4gKwkJcHJlZml4X2xlbiA9IDE7DQo+ICAJfQ0K
PiAgDQo+ICAJaWYgKCFmc2NyeXB0X2hhc19lbmNyeXB0aW9uX2tleShkaXIpKQ0KPiBAQCAtMjcx
LDggKzI3OSwyNyBAQCBpbnQgY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9k
ZSAqcGFyZW50LCBjaGFyICpidWYsIGludCBlbGVuKQ0KPiAgDQo+ICAJLyogVG8gdW5kZXJzdGFu
ZCB0aGUgMjQwIGxpbWl0LCBzZWUgQ0VQSF9OT0hBU0hfTkFNRV9NQVggY29tbWVudHMgKi8NCj4g
IAlXQVJOX09OKGVsZW4gPiAyNDApOw0KPiAtCWlmIChkaXIgIT0gcGFyZW50KSAvLyBsZWFkaW5n
IF8gaXMgYWxyZWFkeSB0aGVyZTsgYXBwZW5kIF88aW51bT4NCj4gLQkJZWxlbiArPSAxICsgc3By
aW50ZihwICsgZWxlbiwgIl8lbGQiLCBkaXItPmlfaW5vKTsNCj4gKwlpZiAoZWxlbiA+IDI0MCkg
ew0KPiArCQllbGVuID0gLUVOQU1FVE9PTE9ORzsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiAr
DQo+ICsJaWYgKGRpciAhPSBwYXJlbnQpIHsNCj4gKwkJaW50IHRvdGFsX2xlbjsNCj4gKwkJLyog
bGVhZGluZyAnXycgaXMgYWxyZWFkeSB0aGVyZTsgYXBwZW5kIF88aW51bT4gKi8NCj4gKwkJY2hh
ciBzdWZmaXhbQ0VQSF9FTkNSWVBURURfU05BUF9JTk9fU1VGRklYX01BWF07DQo+ICsNCj4gKwkJ
cmV0ID0gc25wcmludGYoc3VmZml4LCBzaXplb2Yoc3VmZml4KSwgIl8lbHUiLCBkaXItPmlfaW5v
KTsNCj4gKwkJdG90YWxfbGVuID0gcHJlZml4X2xlbiArIGVsZW4gKyByZXQ7DQo+ICsJCWlmICh0
b3RhbF9sZW4gPiBOQU1FX01BWCkgew0KPiArCQkJZWxlbiA9IC1FTkFNRVRPT0xPTkc7DQo+ICsJ
CQlnb3RvIG91dDsNCj4gKwkJfQ0KPiArDQo+ICsJCW1lbWNweShwICsgZWxlbiwgc3VmZml4LCBy
ZXQpOw0KPiArCQkvKiBJbmNsdWRlIHRoZSBsZWFkaW5nICdfJyBza2lwcGVkIGJ5IHAuICovDQo+
ICsJCWVsZW4gPSB0b3RhbF9sZW47DQo+ICsJfQ0KPiAgDQo+ICBvdXQ6DQo+ICAJa2ZyZWUoY3J5
cHRidWYpOw0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtv
IDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNCkxldCBtZSBydW4geGZzdGVzdHMgZm9yIHRoZSBw
YXRjaCB0byBkb3VibGUgY2hlY2sgdGhhdCBldmVyeXRoaW5nIGlzIE9LLiBJJ2xsDQpzaGFyZSB0
aGUgcmVzdWx0IEFTQVAuDQoNClRoYW5rcywNClNsYXZhLg0K
