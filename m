Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160128;
	b=sbpBquG2aVQt+PdVAwxJNz9gd0VPClRzMyUZA2BNDqrnsby4Lknr2UUgp4B6r0EDNUm2
	 krGMr5klQ0Hh+m2kUpQbGxRIme80EtuZHDDsoyLjg44+37J1Jc0x/Gv6TIPy8nLKt6f6C
	 cfE6mBAzSsdXUsUBpklK04auWfs5eo3SZHcdXVCZ4fczkB4ODBbuyTA9QSFfLAybCeRrn
	 njI92tT7zRlFL+ipK2UnSwl2WrDLvt0un5GLqSLRgKzngdS1GLjtttUxi7n3mN5XKPkpG
	 MCypl80QXug+1OMbwLOeinMq38DXzjkGOXQikYTVTYd6n0jFFowvkdxfLvPUA+jkwUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160128;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CUdNWVugs6i6GW4y/MWPiQTCaoDyc8ouI7x/Je6XfVY=;
	b=ay8/pUPszW9DRMJsprin9qSGK78vMOGdC6c2IFQpt+XOIQ+vXtpqsMq1VaRCXine+0Ck
	 ETo7vF5UwGFtAxutZVpksnHWlx0U9R6uo7HpDoGF+f1Q1FteV9Ljp6v0WDBULXFI+VMm+
	 kdj0G8X/3cfHIMG6wzW7gOAmztK8VkOqmR+3zI0cUzVLaXNZwwLqgW+VsHjpKvhvWlnx7
	 NOLJd6a4Mi0QlO031dVugfX3yPE6frc2NRc/ZudXHYsXJNL7dOsntmRmbPBpD0Jd7N1pR
	 CuZtGhNKMyQ1JNlDjLgV64mpFjOxAmSpOqH8O4nECUQ5M5gfwJ8fOK4u3fXQWUPtbsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=Y1GHI8Qj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9E606A326;
	Fri, 20 Nov 2026 07:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A9E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=Y1GHI8Qj
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7LTu1648034;
	Fri, 20 Nov 2026 07:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=CUdNWVugs6i6GW4y/MWPiQTCaoDyc8ouI7x/Je6XfVY=; b=
	Y1GHI8Qj/zbofnxsvTye5sYpUMjqx49iGsWGgAdQoT+rUA29A+EwC6rjaICUZHw/
	4m3P8R69peedU7e+cF8H1X0QCNDNNyenCQuyy1VoXcyzstClSLN+FXHd+6PQXoFP
	dj6Dz3NYI4mZXUz0Epf7zx0q+rNbqn4WamqFQ4sxeMW7PCjP/1Y3MwQe0DVjcm8v
	dAQKREMM7Na6KQLWJfiBWc0bGnu/gQ2HrgUjwQQA9vXcvTivMjkXwpe3TvyScRgC
	o7Aez/No/5EJwZZaigSMM3P/8HGp+wHyqal2RMKo/afTi1cRBgxSi5bstbI+GxId
	AjpUUiaKKL/brzkXKTe50w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021086.outbound.protection.outlook.com [40.107.208.86])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvh8b1u-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:34:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJSzgSXfrkCWQxurHsa+e4LziXN62ObWcKzvXSzUIDUZEaNQi7VQyuyPeMkKoE5VbPvRJnHlmaCM2Q83qxB6QRgykX5v0TyLi1r6FrLUg7tYqKhL5b9Veen9xDscjIMR9+aNOYOSqo5PX/yNmnGiT/ykQXaYqEPtxbJRA6EFOvuVWP1BPk6P23vk+A5OoiixU+z+c/mKYvWWv0h3C/4T7J96kIjh1hknM1e7ALmo/Vu0VTuL5HDpBtdC9OLCNLgVR1EVionikbRpDZGG1pqpJyOAqJqYEbmzVn22zZgljsGrQTy6TB3d/IVvAbUq6sMfu8zEKB0oXs6LuSqViUZaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUdNWVugs6i6GW4y/MWPiQTCaoDyc8ouI7x/Je6XfVY=;
 b=CmdOuQ8qhjk3/iE+B5pdbVxrVg4yrTsLrjzXMoqeK2ibUQcWfNmghR8ljmruEllbMUPNtBo+vc1hB4wmcRTRgYuBCFldSfwZopJl6ZTekBeF5xXhDfUv2xn03lLXFLoJUwdYMQCWDO5UPYqzP6rnvkle25cdDiLIlPc+Lv7P5PvJg/umhjCsADhgjF5s49h13lPf4jid6e37kIS8aPFhWspCfAh72hgbSXhhgDnGlT+FzL7X/zlnaq63Wy+W9hNeIGDPosB58dLk7q6qA4WV31dc85Syp9PZza3ZKyFCLn44ux8mX4bs8ll5zf/KbIReXFwoeT70P6FZfvYLRX1RoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 07:34:55 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:34:55 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] libceph: don't back off exponentially on EADDRNOTAVAIL
Date: Fri, 20 Nov 2026 09:34:17 +0200
Message-ID: <20261120073431.53636-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120073431.53636-1-ionut.nechita@windriver.com>
References: <20261120073431.53636-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI4PEPF00000142.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::89c) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bbe1f0d-930e-4acc-d1ce-08df46d8c5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|52116014|366016|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|261026130827099003|261022105027099003|261026140227099003|261026121527099003|5023799004|261022115727099003|261022075727099003|261026135527099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261021133027099003|261009223027099003|261021130227099003|261021135927099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	k4oB4kAUsUCM0iK3g1KUqBGsW7mUcilAAtUNW0QLGBhC5gqUTVNDGv77x3rBFgCF+BbF61bKV5gF21IbyX8aXhY8G6wskD8tGWiQUbb6R4cX8FslZ6xgZo1TNaTCO1kFnqkbil38Up1RdkZjjFjMWngTcWpow1Ar0HBmhSTei46fHcJVCQsk7ysBjmMsCoVyJ/ltNQ7JkxWTFOj6lRWDjy/4qCcdMuFk2aNMDTYN0w01LqIIBv5pn+tkHlgSGzaDOrBhEbe9SLO2FcqaXBZSn1bFw/TjctEZT5a/dt5n8Uixj7biyp9xirKKddjekOixXFE+kzt/aYt2fZILRBZr8fifKgq01VzK72pWGFkK+B2KAXRPvPKTjcDYMA0W5gw48G4firlv6zKbJZQ2gW+bgSfehWOlYkueIivTxG27BzeWIXVtZhZy7ntH47GOBa2msQU7CuHVNBnsZQFNlyB/SfQGjfvg7eRhNJjcEhsPIgP6N4IMftkweSDKtGzJ6fhj+lE3VvuDYrqSO0jBdzmmDPZfR1M2SgR/it1qFinCTkKvrTevL8DnXAM3Ns6fxEVvnq4zW9c5jLKsSM0nLMxnV8MZfplJ/CbyoeMCNTpYVMUmHLhdSAvFjMzMzTEQQL4U02LLMiW/T/06ttlY/B5RhJOrtGHsc52gCmzHjhHVBEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(52116014)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261026130827099003)(261022105027099003)(261026140227099003)(261026121527099003)(5023799004)(261022115727099003)(261022075727099003)(261026135527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261021133027099003)(261009223027099003)(261021130227099003)(261021135927099003)(261022113327099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1s4Zs/ujrHobIMFqTZuuheWbYo8YsdguovFWPW5MDhCtDmZu+uHzfWrctmy?=
 =?us-ascii?Q?8yahYCuFtwSJn2Qun7t3VXPfA/0L6t7ySdwp7qawFdCRnrYa04PDZw+EJTbG?=
 =?us-ascii?Q?Syr74BAR8U2usmyMteYSVt4RJX6NavgN4wE1hbEVkFGRzV/E7WfIJEqZFk/V?=
 =?us-ascii?Q?06r3qDEFb6fUeQwsoD9S7NkJsqYiYWArg7XHpiT6bSNuIYYE1o+AcYmnAtXk?=
 =?us-ascii?Q?ngk9G0lcMX5IdRnFIaOheVk8U7KrsiCGjAzjGOU0c1890pFiC+CMymYBq3vM?=
 =?us-ascii?Q?0sTarJgxUWWQUUoVuxC+w0woS/ESpQgOsqiZzOrkJi6zYFustPa0ICvVCL+2?=
 =?us-ascii?Q?p2h/wJkVIen+ewaRCx9UJFn1zzCTEQjrJMBmKg9jcr5RxbBs3q++JunayhDE?=
 =?us-ascii?Q?/ROiQQZifi//kdsRapA24fodCCnqUSn/57S4TceB67gtmzppksa2MVvSZ1w7?=
 =?us-ascii?Q?3e76KKC/y6N3iF9m12Wpahc9gHyx+CUV7r20mbTSwB8k3W8RjuzOMYri4uak?=
 =?us-ascii?Q?LJJWpGqxYRcdoubWhpzVxtNzD/ZkV9oV6LezOauSq9FVVw+ozOMlfutYAXz3?=
 =?us-ascii?Q?p9XZMqftt8y7NmjT5fTppV/77oByiQkssNTkqTFMbjwZYF7+luFKUd+9U6Ud?=
 =?us-ascii?Q?W4vi00G4msBbZjLn3b2VAeMe0Bm4aX8Vt0d+kOlSY4kYb4HD/Y5XbvsqP+Le?=
 =?us-ascii?Q?8VZvtFVFP2vPx28lMcjVClzCzlxkFP0OPFgap5Ro+4/3xsdFoy9EQaamJsMZ?=
 =?us-ascii?Q?y51cr7LBBnAYzipjoPDLMUjajWtP01U7VweZvvHvqQh+r8m1ONntcqhfnwJn?=
 =?us-ascii?Q?zX5ho+cJWIZuuPyMT5LGxGOBlMCKcsunvsyHZ5LjiSjAZniitIU+IfZH5P5G?=
 =?us-ascii?Q?NS9FYKaigQOMHIH7zCsH8h6RxYxicnL/elBzEtYgHgYiHyNTrOJNJfymXZON?=
 =?us-ascii?Q?wcWMbdAPrhsghUTXGjsdbd2t+3uSl3n+ohaDOQxSz7fuITVjwserWt7nQMLA?=
 =?us-ascii?Q?KkkZ9hZih7lOcecC3ZrAzr+bUB6MUtvzDcdd1MqcBGzXkSjVNQWugBQ0XZqT?=
 =?us-ascii?Q?zGQjDHnHvQ8tXTG8eVZ0khT+XCOUm6sLWzmMLHT9GnrTQ54h5kn46B9a3T43?=
 =?us-ascii?Q?T1AIcs3UdHPb7bWcznkZZzOfNpgW6qYg9qAAAZF3Bc3oO8QANrZE6MjuAk/a?=
 =?us-ascii?Q?0tgBLaABWSHdKAwqS5tT0yIo4dErtQ2W/5y1cKXPPWNuhxXaMxF+Omuodsu2?=
 =?us-ascii?Q?NzgtsituIRtgyXdpsjQELZq10yauKZ1Oc+Y/BPei81XgL0e8gOX3FZxbIayR?=
 =?us-ascii?Q?GTDroiAdZWnTZjYZMUoM8h6lHllMGfmDX4jbz0yBt2SL3/hdy+iFku5fcGQN?=
 =?us-ascii?Q?5PjK9CPp8fILpSL+2QtWrhprH73w9VGoLPxATm5n1Qwe1hVxASOgo4g47fll?=
 =?us-ascii?Q?rLzhVV5XE9W3W2zIM7X1yH6vcyIeMOEsVMB66jpingLbksICCWck+pSeAauy?=
 =?us-ascii?Q?bdvsnmCnpTizbKzx3TfMiGK5u2jNx6iUzspAeijZB4V71PuSSh5JAe+wdvk6?=
 =?us-ascii?Q?RrX0EJtFoUj3JWWPm+qX/doMq3AQGECBB5wZkVJlTPf2QTO9nhgEs9QFf9FS?=
 =?us-ascii?Q?WF586k4UXVxVKuGmPp//DmGTR1uhFvO8GnEkBLvfMWotzsh1iemf80i3xq13?=
 =?us-ascii?Q?4TzZsXRax7s7vh7XFYYgBrlBC1ynxOGkA8eN8Dg85hdVm7ERYzvwwn7hq6RS?=
 =?us-ascii?Q?xJqBg/rzNSdVODQ5xt/oT1RDdSgWwMv2MwQhU0Un3QwNGdM6NDLkbv4R9Tev?=
X-MS-Exchange-AntiSpam-MessageData-1: FN4ne9XxJfm66xRBA+u5+8fl+v1Nst/Qync=
X-Exchange-RoutingPolicyChecked:
	UtemkQ/jvifPtzQhiMBzWLOTASmDr+zgdbZhd0GHOw/jnh/nX8+te3F54a6PiQEd1k/nzDLNOpbD1AeLUvYtOoJZM3Bn2tLpyI/LkAV3bszz2rHzq4tsbhRq+XeQ+Yoh7swnPsv+Y35uQqYE/UmngSh19T6Zqs91B2YnpalnSg+U5BBN3fBtGmm6ySj03Y3/8l7GGoKaygWjgLSTKfEJbAAS+y32wHMAhTfjFaEO/iCqdqs5xfn2rKCoqWP31qdW5jkuVWspTheuxv2bsg7ISynzqlpDQOKJyVVCqV1KQhyvbFByU24j5MZYQ08el2KEIfbBtmQKT6bocsc9zaGe/A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbe1f0d-930e-4acc-d1ce-08df46d8c5a5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:34:55.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NurnudJZKKGtJBG2BuOG+4siVreDE8kRmz5gp+4Z0i8m4xgf+erHKUt/zbgMnYohIkZlrBYqNwy7Hm7cPOo68wKGsNHaXpCbAKxpCIYg+BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-Proofpoint-GUID: FScGb6sPVUV7Jg_CUPI7RqQLEhHpfi3O
X-Proofpoint-ORIG-GUID: FScGb6sPVUV7Jg_CUPI7RqQLEhHpfi3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX0qOconVs0aqc
 oXIhLkcEhiLQW2W/tMyRGPaMi5d0MSxlj95ITvFDK6F//t/5xdgPg7vfvx+k8kUk1DmG0mUW6Ns
 /4MzgPR7eS0Al0fx3aSBzh46kSulWZM0IrDBUIuVFUnSebiseVqE/xRAiHqNYQtyshxsFtxNHZE
 ugBVGtBPqiMqcwG1rhQnCwUbT1gNfGRpmwJeGW0QZ/BzOxvh/MynFRUhuU7zgVoz4kvEva0BLvP
 x66QZGr1Ez1j68DJ4ue7MpJJwASCRXn5oUxEevvaz+05z6US9Oe8uXx7/kH0g+v5u1HPN4AhNln
 +p1LEXhW/E+x4oQaUB5SQ5z2/Ni08whl5ypX52IWHeMEuEhGGYoPuQvRHIFGqfFvr8NTf/MoxYG
 Ry1+kaLhqnDDneg4I6XmFHzVw8CZtVwBvDup4EYOJ8qQq5GkNIpVdTb28IoB8Zt00r2gseMCJFK
 OPFWgpO1j5Gen07EpSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX+mSEr7XljdlC
 NCpkeA6AvIs1NV6WGPGJ5pv9hIhZdIqmWCxIPKVFnP6yJ/IKoMejEXq0qUD9f9b5lSLlxUxi1bu
 kfd8HixuF1cy2XKxT/ieuP4oma1Iv1Ipo64ZXpwkniDSZ2xLEloy
X-Authority-Analysis: v=2.4 cv=GNCdgeNK c=1 sm=1 tr=0 ts=6afff821 cx=c_pps
 a=ucoVWjnKr/qwcNtWmuDa0g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=06xcUqQ1aE7JeyoqIIgA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

When kernel_connect() fails with EADDRNOTAVAIL, the error is local:
no route or no usable source address for the peer, and nothing was
sent on the wire.  con_fault() nevertheless treats it like any other
failure and doubles con->delay up to MAX_DELAY_INTERVAL (15s), so once
the local condition clears the client may sit idle for up to 15s
before trying again.

Since a failed attempt costs nothing and never reaches the peer,
retry at a fixed 100ms instead.  Track the condition in struct
ceph_connection so that it doesn't depend on which protocol (msgr1 or
msgr2) is in use, and rate-limit the message.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 include/linux/ceph/messenger.h |  7 +++++++
 net/ceph/messenger.c           | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6aa4c6478c9f6..344496967b5c5 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -321,6 +321,12 @@ struct ceph_msg {
 /* ceph connection fault delay defaults, for exponential backoff */
 #define BASE_DELAY_INTERVAL	(HZ / 4)
 #define MAX_DELAY_INTERVAL	(15 * HZ)
+/*
+ * Fixed retry delay used instead of exponential backoff when connect()
+ * fails locally with EADDRNOTAVAIL.  Such an attempt never reaches the
+ * peer, so backing off protects nobody and only delays recovery.
+ */
+#define ADDRNOTAVAIL_DELAY	msecs_to_jiffies(100)
 
 struct ceph_connection_v1_info {
 	struct kvec out_kvec[8],         /* sending header/footer data */
@@ -507,6 +513,7 @@ struct ceph_connection {
 
 	struct delayed_work work;	    /* send|recv work */
 	unsigned long       delay;          /* current delay interval */
+	bool addr_notavail;  /* last connect() failed with EADDRNOTAVAIL */
 
 	union {
 		struct ceph_connection_v1_info v1;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index cc7db8c61db37..3c893bc0f7d8b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -467,8 +467,13 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		     ceph_pr_addr(&con->peer_addr),
 		     sock->sk->sk_state);
 	} else if (ret < 0) {
-		pr_err("connect %s error %d\n",
-		       ceph_pr_addr(&con->peer_addr), ret);
+		if (ret == -EADDRNOTAVAIL)
+			pr_warn_ratelimited("connect %s: address not available, will retry\n",
+					    ceph_pr_addr(&con->peer_addr));
+		else
+			pr_err("connect %s error %d\n",
+			       ceph_pr_addr(&con->peer_addr), ret);
+		con->addr_notavail = ret == -EADDRNOTAVAIL;
 		sock_release(sock);
 		return ret;
 	}
@@ -477,6 +482,7 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		tcp_sock_set_nodelay(sock->sk);
 
 	con->sock = sock;
+	con->addr_notavail = false;
 	return 0;
 }
 
@@ -610,6 +616,7 @@ void ceph_con_open(struct ceph_connection *con,
 
 	memcpy(&con->peer_addr, addr, sizeof(*addr));
 	con->delay = 0;      /* reset backoff memory */
+	con->addr_notavail = false;
 	mutex_unlock(&con->mutex);
 	queue_con(con);
 }
@@ -1644,7 +1651,9 @@ static void con_fault(struct ceph_connection *con)
 	} else {
 		/* retry after a delay. */
 		con->state = CEPH_CON_S_PREOPEN;
-		if (!con->delay) {
+		if (con->addr_notavail) {
+			con->delay = ADDRNOTAVAIL_DELAY;
+		} else if (!con->delay) {
 			con->delay = BASE_DELAY_INTERVAL;
 		} else if (con->delay < MAX_DELAY_INTERVAL) {
 			con->delay *= 2;
-- 
2.56.0

