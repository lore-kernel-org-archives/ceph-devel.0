Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FC3033DA
	for <ceph-devel@vger.kernel.org>; Thu,  5 Mar 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739228; cv=fail; b=kr5M6gr94AFRmYxhHO9Rhv3cNHB/wJvKJNZ/IOyp6GpsBAdExzSWTMjFf1voKw0z70eNyA9zJ30fBaS5Ht5LvNRgvcU2pzGd5PbnrYnwvl0Bu0onQqIfxB8nTXzzLFgQK7jt/R9wokdV+FYjhYRFyPZPhgjPnBHckfkhqami9D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739228; c=relaxed/simple;
	bh=LWd786O+OOtFkiNAYnuMuAzlIoI3r2hoRbGsccXKIy0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=oyo7VSH1Whao4gP9X1UqJb12+ZCJYZRcFNWVUrP1BdLj1tfZI12f8evwQbXZLBE9VnpI2QLJIddJjEccIj3NyQOMSLs5bz/GAfl5ih+WkoryAU5mOm8pwRqxRZOo/KgtsnI+SAnV3N/Bwe6IUAXyicekEcXSVB2Rn0KGhAdD/UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JS62ueP8; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JS62ueP8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625Hjg5s2488101;
	Thu, 5 Mar 2026 19:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=LWd786O+OOtFkiNAYnuMuAzlIoI3r2hoRbGsccXKIy0=; b=JS62ueP8
	dBZGu+9j+jOvYJbUKqENlEXyCFySWqvBFI4jJdwPM7VWrGGTTApIHaCaPzYzuaJZ
	pWYXs9REWiZEtAUobYojvZ0higxpHT0nnQUV4MP1hXllrXelYAOg5ySfLUaKDPgz
	KLpiVkfJ6mbICFOF9YcDQr0m7JaPq5wHoT3S0HrI/oMdB3wD7qNhOlskzwWy7pe1
	fGv2dZFSoNYp3n9iNffD/Cqqb1QGyO0ILExgJSTqrMRB1sn0yEPbtVFD29nicptL
	4Kgs187CZARPhMgAL2Sn6dRyYSWmzHVWWP7eRadEwBtsjxfk0OZYVjK66wjQLpFW
	jkRvCsOJjHBLew==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjdf2t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 19:33:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA6uMEvPRSJejJy8vF9zvvcpd7kqO8W+M9olyZCVVmZwt/A67OweOprPceAR453acPQNydn2EHZN1wo0fcxtkDLg6q8vf+QxDJsDnxrp2mLAbtsipLNDav8JmSBxlAr637DZZQc7dCz4jiNuta8dd7H6Yl9G0fvBLwnDeK9nnI8lXLGT6YSXGyYMrzzx+vhP8Q0FPqO5LPfsc3PP6WAKCLYAcSCnSpCUjRCWBuiKOlpaI74IvhyQ02WeiuNPatAqz/6/3bCT/pRhR2Qwgz2qrIAm+MT4GGGnk+nfGMea7sijxxIkoDFYbVL5ZVRoU+KeqdJoVIV5MHSQF4RTidhI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWd786O+OOtFkiNAYnuMuAzlIoI3r2hoRbGsccXKIy0=;
 b=POYwdQhqb8tSeQ0oKv0JLJk3a62iZZaW3uQzDfGjedshkYVbJ+o09CIYq4GgQMroghr4eg8HDjwXYupN6DP2vrxhHUeyZb1fvp7W43uY4E9Oi5Aku+t4BH99p5ACbxD4cO1PeTouReYjSGKq8PVp7cyU2bj9YQABTZDZ87+PsCjZjkLgScE3mCe2s+AH6nbbfZ4BrWEK3lqZM5bhuRkk+ea4teX9rqKT7nC3JwxJ7b0uGszpnVYkQpoV6+7v05+UhVEzBMi57YSPCE/5jMK3989QRwnre3o9+/nAdB2eHh5V5wnD9lJrkCZtKzOl4btthP0TBuZpuE0eJ16sGeIiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV3PR15MB6556.namprd15.prod.outlook.com (2603:10b6:408:273::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 19:33:30 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 19:33:30 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] libceph: Fix potential out-of-bounds access
 in ceph_handle_auth_reply()
Thread-Index: AQHcrL73Q6J51nTeHUSIQeDvPDULqrWgVGWA
Date: Thu, 5 Mar 2026 19:33:29 +0000
Message-ID: <9a967105c12095a4e5f32d1c49550c2424580483.camel@ibm.com>
References: <20260305164049.2844606-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260305164049.2844606-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV3PR15MB6556:EE_
x-ms-office365-filtering-correlation-id: 4a4bf3eb-707d-41cb-8b49-08de7aee14a4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 VxYI0bSbogwTgTmKnFLhAt3ZemduhbgRM2VU6dAMWtQlhysAgUPzgTG9QFCe+gMpN5vmXxGo4kc7WVCRC+v0iKie3rpwIjp2NNPHM65lV4oj3dIoxcDMTnamWBGgHCyq/DL5Mgz+WCtemWsK8UFSBndqIdOH6KIOy3IQ/y4huGFy3lOnJAov7XBvzLt78ssJNBA4+/QhAekJ13T1H9BL/3QK3FBdiY/H+ZfrOzujQANs3bYtaE4Z2O2wYF/vWK2fNKbUS2IKffJZoEJ0FzFMkmUhe3FF0QzAWxDVvDh2Xa63Z7LUxzDlKxSrv5vSxF5v9M30BJDD10Wbh620waUDU6D5zTKDYJkogHnYeIzEb5GqlUdAhkBSoMPDb10MZWLu1xsAro1Bxgdgc8yvMcjin3+UbwJ0Y6514zRvr3gy5Qs9HycwALDXXezMfy6fCM+r7msb1tnLHRT4e6ulOVrCOAYpKwFlpqXAN/E9qXqfTnQwpucqo6XFEMrQKJswu2okRDqhqb/hHWpFinB5J9k6G0Q8FdruSUUE3H6rFIRnioEuq887bSOrmdLBy+DBLi4FX71KJtBdLRvzx5DAhHZQJc6YqC6Oz9Zvu+PtBrJouN85Td01HCl8LJ5N2wt4CjMymWD0KrrsdDgp7+dnsYSJ3/VKMOBi/Ksx0YhHApgSgkLx2S4udUNfsZl5qcppk1PgfHcnjH3TMGiqSci4+nOyo0flvoLh/v8PafUz8ygI0m8ovHkD3jWbn1Tih4mLzWyNS0jRhxqYZZYJzLS/oi8R8zZrI15jDgKwaB03ovww4rQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1RZaSttZTR5VUxNSTFiRFcyK3JsU1pyNmUreS83VER0WDFVYVZXYllzbzVt?=
 =?utf-8?B?MzhNejBocnZjTjR3R1R0RHdhOUkzWG9QSUgvcHFBcWpjZ0JUeDRWMUtzSHBx?=
 =?utf-8?B?Q1JTVzVHdXFNNTdLeFR5dUJQaGt1M0ZaYk5HL01MbUg1OHRpVzhyeDNxYVlK?=
 =?utf-8?B?bzkyUDVkYnRiM2pVemtpYVJIL213VW9WTkI0bTA4SjUxR0VUeTFGRDB3MGxy?=
 =?utf-8?B?OXIyRFJZRXFGdmdmNENkWkxzT3lkYmkrQ3lNRG1jNXVIdnF3LzhMRzRsMWlm?=
 =?utf-8?B?dE5DblFmTkpNaGIwTUJ0MWRNbkJPZFhFMnp1Z3FMM1pXQW85dnhRbGIzcU1u?=
 =?utf-8?B?TEVmaVVYbitVMWo0aXhPR1BVUnRyT2Rrd29tUG9SZ3drLzJBUlcrOXJYZHZz?=
 =?utf-8?B?dkwwLzQ0MUZXTksvNGVNcDVjNmZGUzRlTmN6MlNXYlNJcmwrUHN6Y0ZqMWND?=
 =?utf-8?B?MzMrVkh6V0gvR0tXczJuY3p3K2h2Y2ZqZXhZL3BIamxEaEtMVk94VlN5SWZo?=
 =?utf-8?B?UW5mVEl3R3hPT0Z3U291a09VK1UzMk5McXF3YzFpZWtSdEcvQmxqY3dwRVBZ?=
 =?utf-8?B?OHdHNUI3VEVwNGZqeDUvcGY5UGtUSjZVNmMyM2VVQjVZODZvZWNFSDZEZE9B?=
 =?utf-8?B?Qm10UFlhdFpjY214Z0IrOXc2cEFwZjhNdzJyTmJHNzlNaHp4RnFxRWp4Ukpo?=
 =?utf-8?B?ZnNSZzkyeXA0WnQ1NzRocjRmN3NlWWQxcDZtak9CbkZqRzVWVTRJUThocHht?=
 =?utf-8?B?SDVNblVxQjhJZnBUb2RjYWlHNEkxaFBueUhLU0Erd2hlL3NOYklMbHZZQTJE?=
 =?utf-8?B?M0dFK0UrNER0VEdrN0thM3djR2FwNVB2emdDZWhOdXAvd2tXbTlvL2xkRHpr?=
 =?utf-8?B?ekptS2lFNGE1VGcvVkZ5azlkSDhzaTVyNXFCek1pZ2dpTlpyU0dHZFZWTWNG?=
 =?utf-8?B?ckpGUy9IOXlLalJkeUxORGs2TmZGYWUyanNNejVLelRBL0dNTWJnaDN4Tzht?=
 =?utf-8?B?U0FtbDltem1nQlJIcENoUDc3Z0NXM1dRa0JiWjMwd2dFcjRZdlZ2dXRkcTgz?=
 =?utf-8?B?dUI0b3pQYWxmbXFMR1BhY3I4Q2tWdEhuSElsbVhoaFM0cTc0ZGRUV0dvZHJ5?=
 =?utf-8?B?RGVKcC84SkFsNitXQzJYbk9iWXhPYmNWUnBQNVYydUtJcDdUN0dMaW5qZ2Zt?=
 =?utf-8?B?SW02OFo5UmRQMFlTNVp5T2Y5OXliYVR6eDVEbnAxQjVENXk4V2hLZHRUNjdy?=
 =?utf-8?B?Qld2T2lTQXN3UkgybVNaRGlTK09CZjB2WFJhQVJua3hnOW5WT2NPQWdLOVBu?=
 =?utf-8?B?VHVUTjdmVlB3SjNIYmhRTkJyRVQyZC9nQ1dFd1FCZVJCa0JMZnljUXI1NjZn?=
 =?utf-8?B?dEp3UW4wQUdsRzVMUXFkRGhvTkVtTEtGLzV6SlRIV1dZVDZHNnhva1pCZHc5?=
 =?utf-8?B?cUdqUkdkMnR6L084MHJXWVBpSXRKQmF2WEREQ1NycFBnb0lRMnN5Q0NzeDJF?=
 =?utf-8?B?Z1kxNXYzOW9TSXJqSk1veGo2cHZkZ0hXQUFRZHBOVE5JWkNzLzEyaVJEUEhl?=
 =?utf-8?B?dGkvV1psdXVIL0Vld0JzaDg0ZzJQTkg4TGsrRkNhTTBLRUU0ZnFaNlA0NW5S?=
 =?utf-8?B?RkY1b0k3UDZBV0grN1JTY0xhdUR6dWIrRUZ5a2NnY21pOHZzR2VRVW1BOWpy?=
 =?utf-8?B?T2huY3hyZGlaZGhwUE9VUjNLQWpEamNRZWtOUEhFdmhVc3NNdmtaM1pUaDZH?=
 =?utf-8?B?b1M4SmFaVGt2bFJrZ3hyRmtsVE9JckdSa3A3RHlqUi9BQTdGUzdETU1iR3gw?=
 =?utf-8?B?Y055V0JjTjFHcGxaZll1UkxSODY3TlY2eWZzbzQ5c3QvdHBIZzkyT1RyZmxa?=
 =?utf-8?B?d3lLSmhwUmNFR0xWY0pxQ0xWbm9kUlROMWwwRFVibVBOUmZoS3FTQTdCZmZN?=
 =?utf-8?B?dVBXY0JuVUhIci9sKzV5NUdLY2R5SVQxRlpicFNZdENVTUJ0SWd5QW4zL2Nu?=
 =?utf-8?B?ZHJiK0xiMFQ1czF5b2ZhMTBnQkh4Wk9hckZCQys4MENqREc0bDJXQW9HcEd6?=
 =?utf-8?B?bWhnU0w3ZHFqSW94YUNkSWFiZXUvY1gwSXo1dVZPeW0wTS9xOWNOemFvdi9l?=
 =?utf-8?B?K05yMTB6V1JldWdZWUNwb1NnZU12RC9UU01yMXY0QXJRVWg5eENUT2h6ajEr?=
 =?utf-8?B?RHhwRGFJVFhVd1FrWjBYM21VMTVROVJkeGMvS0xldlRQUjJ4alMyd2hKamlr?=
 =?utf-8?B?aTVBckRjcWRhNm85WVFsMkZXM3F6THFpOG9Pa3NacFFHQjVXeGcvSEoyQ0c1?=
 =?utf-8?B?emNqODlRMFI0RHlsWlU2c2hTaEYwYzFpdVFBZnVIVCszYTA2ODJqZk03YTFn?=
 =?utf-8?Q?c7lzChduMSVKHZizuZi/nD3aakXi5MPsd6xBp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79A0D3BB2DD4DE4A8E6D8CBF4B82D467@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NAYBLf+FOIWGuaQPZRhfkERIXwmNd5EVouNtbk9LSmQkHWKKAzt+6r92WHDCyfvlGEVq6GzqToGKiUxgzXnflyEjqCwee6B74P8u+LixR1XPtMeL3EUnk8PC+GUi/Glq0XwhjBRvZPD4ASwbqTp96MtgBdWmgMTpHFRKWfwxRbAt5yITUfOb0l9ENpG3z7MDlZOtzDQ2MV+09o1fiJzxg3rKeYDqXnz9Wj//TptrpcEnpraOFG/GJXpngsNYTFs2kq+Jj5UZWswgruHWRAFSVYCTFeuEUd4Af8CMdSvUl9m2tL8hUBHFflKrEw2VzH0dWOJ95PNGuSsrL+8VyfC0qw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4bf3eb-707d-41cb-8b49-08de7aee14a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 19:33:29.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xs59fCnChaOrBjqquy/4WQbm9Ca5Ow7uo1+ByvDw0nxofPBjiTjvelcNLv21HFvik8np2aWmVVTSOy9x0ejiyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6556
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a9da8d cx=c_pps
 a=KMYGTuEAqwcz7NPofZ4ZnA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=oj_ai0Arznwl-w16wuYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE1OSBTYWx0ZWRfX07UflZ9ZaS5T
 tC6LFbIbzkRjOQuxenSmtZgzHHsolNIF6L5ZSb+sqf10My4oPrzagYC3byjg+3DYzhC7Ty+h5FM
 B3cqs0EoAZpRczLMZXnGZPcgUCInAi7VJ7TDAsylPeXjWBmhVcBDb+GlxS9rHpW3ZjLI3vFxnnT
 HuZGWPpFTmlOX8V2dMlUKDKKEJn010C58D6Vu88tg0A1oCLyj4Fm7LYHE1yLos9lmBmsfk93Ttw
 aQcfWceJaM5bLGgTP78ngojujwSqmBTSjzjsrN0Yh546gf/zGWemntOES9iLuAK7tOOMJfeweYE
 J2A7pLyGX2LEXvaNJCq8Nqhj/PRgiAqrXN6kD3T3MjFOgCtI4BizGjZ4nfcb/5B4ONlssomvE9p
 rq0iecs0eF32DPP/Ku6d1bu5ZU23XN8QE61ZGua5VbPwQeRHLsgo+B5NV4bi/FJLmODPZsx7OeE
 rU/MS9v7+bbkLXLaBew==
X-Proofpoint-GUID: mbHRf7P9QPlbvEPCtAKQPn0JPxJF2UHa
X-Proofpoint-ORIG-GUID: 4yq896lAvVlx4Jjk-OHO5AXrHnnhqA3i
Subject: Re:  [PATCH] libceph: Fix potential out-of-bounds access in
 ceph_handle_auth_reply()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050159

T24gVGh1LCAyMDI2LTAzLTA1IGF0IDE3OjQwICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gVGhpcyBwYXRjaCBmaXhlcyBhbiBvdXQtb2YtYm91bmRzIGFjY2VzcyBpbiBjZXBoX2hhbmRs
ZV9hdXRoX3JlcGx5KCkNCj4gdGhhdCBjYW4gYmUgdHJpZ2dlcmVkIGJ5IGEgbWVzc2FnZSBvZiB0
eXBlIENFUEhfTVNHX0FVVEhfUkVQTFkuIEluDQo+IGNlcGhfaGFuZGxlX2F1dGhfcmVwbHkoKSwg
dGhlIHZhbHVlIG9mIHRoZSBwYXlsb2FkX2xlbiBmaWVsZCBvZiBzdWNoIGENCj4gbWVzc2FnZSBp
cyBzdG9yZWQgaW4gYSB2YXJpYWJsZSBvZiB0eXBlIGludC4gQSB2YWx1ZSBncmVhdGVyIHRoYW4N
Cj4gSU5UX01BWCBsZWFkcyB0byBhbiBpbnRlZ2VyIG92ZXJmbG93IGFuZCBpcyBpbnRlcnByZXRl
ZCBhcyBhIG5lZ2F0aXZlDQo+IHZhbHVlLiBUaGlzIGxlYWRzIHRvIGRlY3JlbWVudGluZyB0aGUg
cG9pbnRlciBhZGRyZXNzIGJ5IHRoaXMgdmFsdWUgYW5kDQo+IHN1YnNlcXVlbnRseSBhY2Nlc3Np
bmcgaXQgYmVjYXVzZSBjZXBoX2RlY29kZV9uZWVkKCkgb25seSBjaGVja3MgdGhhdA0KPiB0aGUg
bWVtb3J5IGFjY2VzcyBkb2VzIG5vdCBleGNlZWQgdGhlIGVuZCBhZGRyZXNzIG9mIHRoZSBhbGxv
Y2F0aW9uLg0KPiANCg0KRG8geW91IG1lYW4gdGhhdCBwYXlsb2FkX2xlbiBjb3VsZCBiZSBiaWdn
ZXIgdGhhbiBJTlRfTUFYPyBJcyBpdCBwb3NzaWJsZQ0Kc2NlbmFyaW8gdG8gaGF2ZSBzbyBiaWcg
cGF5bG9hZCBzaXplIGluIG9uZSBtZXNzYWdlPw0KDQpNYXliZSwgdGhlIHByb2JsZW0gaXMgbW9y
ZSBzZXJpb3VzIHRoYW4gc2ltcGxlIGNoYW5naW5nIG9mIGludCBvbiB1MzI/IEl0IHNvdW5kcw0K
bGlrZSB3ZSBhcmUgaGlkaW5nIGEgcmVhbCBpc3N1ZSBieSB0aGlzIGZpeC4NCg0KVGhhbmtzLA0K
U2xhdmEuDQoNCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgY2hhbmdpbmcgdGhlIGRh
dGEgdHlwZSBvZiBwYXlsb2FkX2xlbiB0bw0KPiB1MzIuIEFkZGl0aW9uYWxseSwgdGhlIGRhdGEg
dHlwZSBvZiByZXN1bHRfbXNnX2xlbiBpcyBjaGFuZ2VkIHRvIHUzMiwNCj4gYXMgaXQgaXMgYWxz
byBhIHZhcmlhYmxlIGhvbGRpbmcgYSBub24tbmVnYXRpdmUgbGVuZ3RoLg0KPiANCj4gQlVHOiBL
QVNBTjogc2xhYi1vdXQtb2YtYm91bmRzIGluIGNlcGhfaGFuZGxlX2F1dGhfcmVwbHkrMHg2NDIv
MHg3YTAgW2xpYmNlcGhdDQo+IFJlYWQgb2Ygc2l6ZSA0IGF0IGFkZHIgZmZmZjg4ODExNDA0ZGYx
NCBieSB0YXNrIGt3b3JrZXIvMjA6MS8yNjINCj4gDQo+IENQVTogMjAgVUlEOiAwIFBJRDogMjYy
IENvbW06IGt3b3JrZXIvMjA6MSBOb3QgdGFpbnRlZCA2LjE5LjIgIzUgUFJFRU1QVCh2b2x1bnRh
cnkpDQo+IEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5
OTYpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIgMDQvMDEvMjAxNA0KPiBXb3JrcXVldWU6
IGNlcGgtbXNnciBjZXBoX2Nvbl93b3JrZm4gW2xpYmNlcGhdDQo+IENhbGwgVHJhY2U6DQo+ICA8
VEFTSz4NCj4gIGR1bXBfc3RhY2tfbHZsKzB4NzYvMHhhMA0KPiAgcHJpbnRfcmVwb3J0KzB4ZDEv
MHg2MjANCj4gID8gX19wZnhfX3Jhd19zcGluX2xvY2tfaXJxc2F2ZSsweDEwLzB4MTANCj4gID8g
a2FzYW5fY29tcGxldGVfbW9kZV9yZXBvcnRfaW5mbysweDcyLzB4MjEwDQo+ICBrYXNhbl9yZXBv
cnQrMHhlNy8weDEzMA0KPiAgPyBjZXBoX2hhbmRsZV9hdXRoX3JlcGx5KzB4NjQyLzB4N2EwIFts
aWJjZXBoXQ0KPiAgPyBjZXBoX2hhbmRsZV9hdXRoX3JlcGx5KzB4NjQyLzB4N2EwIFtsaWJjZXBo
XQ0KPiAgX19hc2FuX3JlcG9ydF9sb2FkX25fbm9hYm9ydCsweGYvMHgyMA0KPiAgY2VwaF9oYW5k
bGVfYXV0aF9yZXBseSsweDY0Mi8weDdhMCBbbGliY2VwaF0NCj4gIG1vbl9kaXNwYXRjaCsweDk3
My8weDIzZDAgW2xpYmNlcGhdDQo+ICA/IGFwcGFybW9yX3NvY2tldF9yZWN2bXNnKzB4NmIvMHhh
MA0KPiAgPyBfX3BmeF9tb25fZGlzcGF0Y2grMHgxMC8weDEwIFtsaWJjZXBoXQ0KPiAgPyBfX2th
c2FuX2NoZWNrX3dyaXRlKzB4MTQvMHgzMA0KPiAgPyBtdXRleF91bmxvY2srMHg3Zi8weGQwDQo+
ICA/IF9fcGZ4X211dGV4X3VubG9jaysweDEwLzB4MTANCj4gID8gX19wZnhfZG9fcmVjdm1zZysw
eDEwLzB4MTAgW2xpYmNlcGhdDQo+ICBjZXBoX2Nvbl9wcm9jZXNzX21lc3NhZ2UrMHgxZjEvMHg2
NTAgW2xpYmNlcGhdDQo+ICBwcm9jZXNzX21lc3NhZ2UrMHgxZS8weDQ1MCBbbGliY2VwaF0NCj4g
IGNlcGhfY29uX3YyX3RyeV9yZWFkKzB4MmU0OC8weDZjODAgW2xpYmNlcGhdDQo+ICA/IF9fcGZ4
X2NlcGhfY29uX3YyX3RyeV9yZWFkKzB4MTAvMHgxMCBbbGliY2VwaF0NCj4gID8gc2F2ZV9mcHJl
Z3NfdG9fZnBzdGF0ZSsweGIwLzB4MjMwDQo+ICA/IHJhd19zcGluX3JxX3VubG9jaysweDE3LzB4
YTANCj4gID8gZmluaXNoX3Rhc2tfc3dpdGNoLmlzcmEuMCsweDEzYi8weDc2MA0KPiAgPyBfX3N3
aXRjaF90bysweDM4NS8weGRhMA0KPiAgPyBfX2thc2FuX2NoZWNrX3dyaXRlKzB4MTQvMHgzMA0K
PiAgPyBtdXRleF9sb2NrKzB4OGQvMHhlMA0KPiAgPyBfX3BmeF9tdXRleF9sb2NrKzB4MTAvMHgx
MA0KPiAgY2VwaF9jb25fd29ya2ZuKzB4MjQ4LzB4MTBjMCBbbGliY2VwaF0NCj4gIHByb2Nlc3Nf
b25lX3dvcmsrMHg2MjkvMHhmODANCj4gID8gX19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MzAN
Cj4gIHdvcmtlcl90aHJlYWQrMHg4N2YvMHgxNTcwDQo+ICA/IF9fcGZ4X19yYXdfc3Bpbl9sb2Nr
X2lycXNhdmUrMHgxMC8weDEwDQo+ICA/IF9fcGZ4X3RyeV90b193YWtlX3VwKzB4MTAvMHgxMA0K
PiAgPyBrYXNhbl9wcmludF9hZGRyZXNzX3N0YWNrX2ZyYW1lKzB4MWY3LzB4MjgwDQo+ICA/IF9f
cGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQo+ICBrdGhyZWFkKzB4Mzk2LzB4ODMwDQo+ICA/
IF9fcGZ4X19yYXdfc3Bpbl9sb2NrX2lycSsweDEwLzB4MTANCj4gID8gX19wZnhfa3RocmVhZCsw
eDEwLzB4MTANCj4gID8gX19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MzANCj4gID8gcmVjYWxj
X3NpZ3BlbmRpbmcrMHgxODAvMHgyMTANCj4gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4g
IHJldF9mcm9tX2ZvcmsrMHgzZjcvMHg2MTANCj4gID8gX19wZnhfcmV0X2Zyb21fZm9yaysweDEw
LzB4MTANCj4gID8gX19zd2l0Y2hfdG8rMHgzODUvMHhkYTANCj4gID8gX19wZnhfa3RocmVhZCsw
eDEwLzB4MTANCj4gIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPiAgPC9UQVNLPg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhhZWwuemltbWVyQHR1LWlsbWVu
YXUuZGU+DQo+IC0tLQ0KPiAgbmV0L2NlcGgvYXV0aC5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L25ldC9jZXBoL2F1dGguYyBiL25ldC9jZXBoL2F1dGguYw0KPiBpbmRleCBkMzhjOWVhZGJlMmYu
LjUyNDUwZmRlMzEzOSAxMDA2NDQNCj4gLS0tIGEvbmV0L2NlcGgvYXV0aC5jDQo+ICsrKyBiL25l
dC9jZXBoL2F1dGguYw0KPiBAQCAtMjA1LDkgKzIwNSw5IEBAIGludCBjZXBoX2hhbmRsZV9hdXRo
X3JlcGx5KHN0cnVjdCBjZXBoX2F1dGhfY2xpZW50ICphYywNCj4gIAlzMzIgcmVzdWx0Ow0KPiAg
CXU2NCBnbG9iYWxfaWQ7DQo+ICAJdm9pZCAqcGF5bG9hZCwgKnBheWxvYWRfZW5kOw0KPiAtCWlu
dCBwYXlsb2FkX2xlbjsNCj4gKwl1MzIgcGF5bG9hZF9sZW47DQo+ICAJY2hhciAqcmVzdWx0X21z
ZzsNCj4gLQlpbnQgcmVzdWx0X21zZ19sZW47DQo+ICsJdTMyIHJlc3VsdF9tc2dfbGVuOw0KPiAg
CWludCByZXQgPSAtRUlOVkFMOw0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmYWMtPm11dGV4KTsNCg==
