Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420968;
	b=YssoLb4v1NtRWRObBsA/Y4jDqEWWDyU9v+BfO4Il9+pyAJcRCwQhGMMs8BOHNAggQIpa
	 zTtDZaIqcuRxwQEU/tkN+z3vars7okE0khpmEH72JlpS9xqqY1VsdRVQ+5FdSygqYE+PU
	 DmzsiZwu1LJZ+Zh2H3XCmFWHGXHF7fSjQccwAuYM0/sAMTy/cQ4+lMLHtck3tPivR4DZE
	 8Vymbj2igvr8SeIrXaFbGm/m3VRSKJZmmmLLrm9zShzdJH5TfXIIUWmVJ5WCu0IZUk2wz
	 oAH6OlZ3a/TLJf2Ys4a4/PqxNl2B+EYuY9OsjAcVFpUFXBAa+eU0D+oWJS2H6qlmF2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420968;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CUsurH4wZ4w9tJjTKSfMdaoT6XQ09SgGwmWcyNx8WAE=;
	b=hPkQ1eBjJ1vnrIVT9RhxVwSZ6DAUJugEEY62WETRaxOPcgTXixr32kHLWkv9fplmGRYB
	 nKKAZN+9xHqcok+payL6Gu4wPWBNjH2R67BWOPiQp11UUihyDbQEhEz8vBR5DHIF0k92u
	 Vgy5/y8Mzg1FhGRMnByWLcnIcDq5eSxKYoWGbf0jG4aFQPy98mjfZgKDMqK9S/Nv1A1NL
	 GTteMXhe9Kr1pvlFNzpNKVFtacLq69ie9CpOhrK6v/em9KfbtxJe3wixT/BsoIvliaaAd
	 xWxydkPHvGjZHD3xM932L7YKQPlPS2rTfSmnxCnhdd3/n3CnP4puX5kSWRv48GFyU5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=n72cG9Qi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9160A6F5B;
	Mon, 23 Nov 2026 08:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D9160A6F5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=n72cG9Qi
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN51msK2840662;
	Mon, 23 Nov 2026 00:02:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=CUsurH4wZ4w9tJjTKSfMdaoT6XQ09SgGwmWcyNx8WAE=; b=
	n72cG9QiPitUyidrTQ8FZ07ugu527M7JooAh5c9ZhGQzfGjZAEAn3V1hyQUQyM1u
	1g4fXzjG6u0Kt0VbA6hhrLUPwSdQn46nWJBf1xx9Apo6asG2fCs8LJDk3+SDZ86j
	xjexSANmZfPDZV3OLrWGxDLXKvt3Yla01Wb2GXtmdRsruYDexseTHAsQ6l7TSQRt
	xYRvcHInYtSjEo20iLPml4P9j5uumTHMMhwVCXl/sF9RviS7dlPkF68Kcozmu3I3
	fAR8Yg5OOivgNxwLdshu/SejaVh10brzQDQoYb5CkLTryY0nLeNxS6s39ymglJBN
	05A32nHji7H6SuK318uyKw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020131.outbound.protection.outlook.com [52.101.56.131])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j3bpjsr50-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 00:02:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Op2MmVaLWpbIMpT8GRMx3hxzoEEsJD/PIFzXCajR6xg0Ay0bzGtRhvzHZ61OasKD4pSaHf15gV0vk0e9U9AXHsfvRxJKVAS7JJ4F9gDrwWiT+3BFY/EWEcoAp3k6yg2UsdHV+V3ld1VELf9nm9ot5L2kz/2TGvctI6rDajjxNPlboUuGBGLcDxsP+H4ZFChNtkTKc1oVeGGb4VYYE8p7PoFwCEsNEqKI7BojgFaKvPdLPxh5x00rkHgSegwAHUGwrJRpLDB2O1SEJnm9bqFle2vx03zbcVx1iUBJK6aQ9gVpGUj+m46HvUft7w50LO8f0rvFdx3fP8QXFPRu8ss4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUsurH4wZ4w9tJjTKSfMdaoT6XQ09SgGwmWcyNx8WAE=;
 b=CGCxss/05c84rYTR04TyrHULCJVGCEgV8w/kHB8+sdXLgwUpsMgFRDbINN1oYurWPSzWFU0GGjuUyGK+/lj+d7sT2KaFIcVh0qhhX05HlfbckIuRjjNHCgfb6/uQKH2AaktQWd8K6HjfIUskLu46075wze4RzlIbpzHbtzLqBb4OMUCQGhCZ7F+2DGqdqk210UK3wJa/Tt72bd4dxdBJGACIbyk6mp7FC2Ill3QZZCJqUaBb/BE4C3uslBLd09RUXEBf76ox8GJpg1BU/xMMv1iNvZWvZwRYyrU7w9KPT+n268omjD2L0dhgm+Ipa0EXzsrPKGjuqxsPfyHdaXA5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:02:19 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 08:02:19 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Xiubo Li <xiubo.li@clyso.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] ceph: make the ceph_osdc_sync() wait killable
Date: Mon, 23 Nov 2026 10:01:48 +0200
Message-ID: <20261123080152.163172-4-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123080152.163172-1-ionut.nechita@windriver.com>
References: <20261123080152.163172-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0051.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 249c39cb-82c0-43a6-a59e-08df493818a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|10070799003|23010399003|22082099003|18002099003|11063799006|56012099006|261026121527099003|261026140227099003|261102130727099003|261102123227099003|261021123027099003|261022105027099003|261028144727099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Oj64yPtQfLM+ZeQ/VO1ay0dmu+MX8WbggSiVW+HRxuTyReCyktBKPF/fO3VXt0OtuWohyT3p87cCZDLHoi0MkFUj6GVqp5Xz7sGAZm0eTEbMt/QCMeIPwJGK2cRyIdLqRBFEoO9DgTTW93BNjM9d0tAHDwUg8Yr5GYkG4Bj/nkdJCqIeXNWFAf/n3UcEp3/ztehtfoB65lnX3BFGpN9dAjozn2qUjwL5bb+KLXfmr3YeOICDEZ1V6ikVfMpYfi8sswLQh0OwG9cuH7iGE3zCauTnw7XeGjaduEUfD4Yl6lWOIyEE7BanYmzvPNC6JlpactVo9cG9oI9UzqmkHPdYf2j6PQwceqoS8A2sxBlelCxzaXpSlc3GWh8TnXQE5im4p/4yM//9xxJgOnm4wUgOzB+pKXj6fNFHiCwcqXYFf3aBuyvqhAaT0b6riVqWA/bMPIq1+nqguaEAlcCOfMyylWgm5o+vCSo6wR7SCd5biSACmSa3oPBtKpNBXFVNZN/fOsT6KLGDEbQX+f00xKqL36ZE8mjlgZbiaInCcI4B46fz80NBQ4wc6HylQ/zHXf70I1FeTxsUyLDbQXe90QhYr+wVHmTCUVhu+OaJFa90WxuTLMMcX0ItoVyBQ++QgHmYb3n6rfvcLcPC9CM4OHe96A3sQr0qgBw2rSq4Ye17kZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102130727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261028144727099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VjfWgZiiHC6PVfe9GXXfYlbpn4F2/p3oY0KY5y6w2w/TeuzKfBYwPHg/Zt5f?=
 =?us-ascii?Q?Hr1JFkwOEAT54pJ7RS1PMa2hDAU6GsWFCcLJC/L3Z1vSIqxcIWMmN6lylabO?=
 =?us-ascii?Q?dZwIsCmkR6hLiNRqg2BcDprwP4rtIziT01OH0Bs6Rpr5HISKbSPL7hUmU9aJ?=
 =?us-ascii?Q?zyuJsp8OZizvdmNTpBaoqpzulHmNAJvCMVTZq5T8PhtgifIDs3MSLzLS31vv?=
 =?us-ascii?Q?wM1fs3fnF70H+oee74d2Zs9pfIGhR5aCLtsUWOdEsnwgyOPccGtS74HYY57R?=
 =?us-ascii?Q?if51viPZoHUhtPNkfapNUA/gZJS+SeSfbVhw2QRHYrc+5c1UevvDrjix8WX9?=
 =?us-ascii?Q?NCdOwASAZXHhftQp1HsL7ZFHVHWiY/je5jCEwOHDXxbkJrD8M0hp0TcPb02H?=
 =?us-ascii?Q?IIu3eiq+OVF60BVMGaA9q7ve5pxjUvCpSKORbqBhF/N5lXQXdBcHV0vZ/eh7?=
 =?us-ascii?Q?ZDb8rYc3AuxP8xqBvrDgTRPy6oLedIGCFxZxlUU7KDkLmkIEiY4r8fJCCB25?=
 =?us-ascii?Q?cAkh/cgjBfPCbwQLJtYn8cBXvomK92dKEbhcAyCP9i00IbN+6s+ftTU2r8yi?=
 =?us-ascii?Q?o/+WGXntFyjVwln6wPRgIDFTJROF/27JciqIWlcEYqTfXI3/72r/nIuSb/EO?=
 =?us-ascii?Q?igHCpE7gFm0olpSbxZGAaHx2ObQRftg4CZsizQiWL/eHvb6Vl+vyE4unzFfz?=
 =?us-ascii?Q?oXwQAFAirt4gZiODLKfktB6DBzoJjjuBQY+/o53TP6IHWGGPHbWsD1iuBCqx?=
 =?us-ascii?Q?nyZU3ufhmAXnMkoq8kRkj/dyQjrQBqwqIextbjQ7czTFDfrLBieeFXIISmE+?=
 =?us-ascii?Q?ePJmxXAKVjJ6ZH3Av9rk73CKBQe+5J18a/RVU5ZO8AvvvIUz3vYDQtz7pu/0?=
 =?us-ascii?Q?CzygSW+8kEsEALKXun2bHyUKp+5oqbGqCE7iSUC2z+j1ELVW5cGxRl8SsgWc?=
 =?us-ascii?Q?zyEgPyatOcmoo3bZNDsMNMx0HvlT+mZexMzY3FUKkSdYkT+3jLKJOvJXyQ5U?=
 =?us-ascii?Q?reFFTyIZ0+dlIjut467JPIobaMr2LBEYLiiY+iosgG9uARE66Bs7UpMgtQ6r?=
 =?us-ascii?Q?kn09ekwdzpBscWFkULIyJRoBe8TmbtBD5oaum2PrO7w4ZWjlqI3id7dHyBwR?=
 =?us-ascii?Q?/onZkxW7jd7kFTVZpjEi9KSnBPrl8neIrNdunhugHUxMpkKDlXuIXrtVbCNy?=
 =?us-ascii?Q?sDqhqa2vypbyxM9rWlPnMvQ8rfApzu3ZFfBORG5aiGUZrRkimFXI/l1nF/sR?=
 =?us-ascii?Q?p0aHhZvhUtCqfrv+ixKTYxYK7BAnwv0M/h27nJZrRO9KxIJuthpdFcNgU06q?=
 =?us-ascii?Q?sb15/RxnOOc6SRZub6Xp3ltFAygibWdGzUWrZ6HaDSWt9wYWU3jJ4pYyMog1?=
 =?us-ascii?Q?lLGLpo7R5NM6GC6Xky2zU5NeHB4BG3dsV1y3SxoDBlLMvD/McIp7X7DqM/mn?=
 =?us-ascii?Q?c4n2e/7jGD8Tgmlw4PNelCqSWF9Sv4vMRXqcvIfw5xayxasbs1yVwyKeytW/?=
 =?us-ascii?Q?XKckqf0ePgi5bsHpvZ6A0/TxSPT5oHdujUP9sjud6agdPzzF2hV7Tek16uWR?=
 =?us-ascii?Q?+xslU+FT4vzRGwgQOpfXLZF/TmWkPbEkl+obPn7xxzO+7LY6oLY1mSsrOXty?=
 =?us-ascii?Q?3uevCePWQ0vSiBq8ZIy+fiJNr/wHI4lLBC4HT6R50Xa+xHJDmRI3DIC1rWb1?=
 =?us-ascii?Q?D7xuF8b/ITE6hTAS9GcMQJq3KpE6Z1uWxITP6U7xQzlpi+/T1NekczgnGAZE?=
 =?us-ascii?Q?6xLYpK1q1AptclTlZB9gSgp5WAXUZ5ulcEyEaUEAhgNqKPcPayuIzGZH3Hiq?=
X-MS-Exchange-AntiSpam-MessageData-1: LHoqPeUJX4uUJSB4CVzbd3vb9aoC1ERwo1g=
X-Exchange-RoutingPolicyChecked:
	okvWGRoqUsRkFOhDaCROy9W6T6ALebV/iULxVY6BFPA8u2wZMBj2V3weamGlenV7Z4Vo0x9jlUFr8++9oHEdBmhhnkB2ZwddbtR2E0wkfhbq13EQeCvmcD1C3ZdJD/w6pDlIg8jC41ILaJaRLNUTJdWzWAaZs5x0xzmQbnK+8lEpWIMOHEUl1TThO1ovcRWLQoL5g37NNRN+7UCh9OqCdn3uJ1HEQ/wFfoLW0bwCR/WjW/Obd2l46D5K2YEkf+Yci8HIqCK+Ih7UyS/X+GW8MqOmHKncPqdtre7HxSgLyG2EFxkj9MNrN1ByNwPBJPvPbRRXcDmFjKAUIv8mZqAkYg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249c39cb-82c0-43a6-a59e-08df493818a0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:02:19.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI010CZpc/bCwzZ+jaw4Qteie5pVgN0IkfIfyCVw5/1j8eEbHMXoA+hRUQFjwbgQEIfpxTnsWKD7iUfsLaYCIBCD5+dfXx72sAeMc8MjN4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX+EDvyVCyuPLz
 aD5EPmYyTxnNrKqbldZeUb7RMAvH/9voy8Iy7jnETvpM+XYTNMWbHS2kPyuk+69Lz7pX2SDIZ/h
 LqAjDr8oY2c1T8ayiJZDTeid6AtXFYwu3Ry1Q2JG9DGf8jqjwcQu3PYSUSCW/L+IW1XXpb/G0W0
 Mxvtbuf8+7AGPg5Y78O5Ht/+hS+luCH6u9L9e6eF+AMUTtTOff9tCbekqPpH7uXpHhIpbhZfpbg
 JZb5fUdfe/J46LWW44zn5ji83v5clitsBSY1HjcNwAYA8/yUbZVipT7JAer0tcjLzN3cxevolqq
 cOzL1XAIliSO1FBvpl5fqzLXXSlrzQ96h7OQ2/hBkHhJnUZyOCaQZggnHCZ2xM3SPEiYUOeDaF+
 Lfi+W3ErSa5sSnN1YAxaq29V9slq2IvKK1BUGi6F/VpM6lgxXx7bRQUMsBd8bofxfeanQRqvO/R
 K/rnDqPKP+tIZNfLzug==
X-Proofpoint-GUID: VKbv7CJNe0k3CBVaiDXmVHo2s8WaoRZc
X-Authority-Analysis: v=2.4 cv=I8Hw19gg c=1 sm=1 tr=0 ts=6b03f30d cx=c_pps
 a=xmbubLo1gGd65bmaoQID5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=gbAXccEdxVPRkmidfN8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfXzjeywbp5gtGF
 iZdvMRYGAmISrBjvi5oDeENKL+yyOySYHOv0EQkz54/JKydogR9dc9TStxnZwoSmlFohuKZ5Fqm
 RPNitL0pbF0kyuXR8XgFFSmzNpN4tvDrEbqNRlFh9/UI2JssnqvT
X-Proofpoint-ORIG-GUID: VKbv7CJNe0k3CBVaiDXmVHo2s8WaoRZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230031

ceph_sync_fs() calls ceph_osdc_sync() before ceph_mdsc_sync(), and
ceph_osdc_sync() waits for every in-flight write with a plain
wait_for_completion().  With an OSD unreachable, sync(2) hangs there
in TASK_UNINTERRUPTIBLE:

  ceph_osdc_sync [libceph]
  ceph_sync_fs [ceph]
  iterate_supers
  ksys_sync

Make the wait killable like the MDS side and propagate the error.
The requests are not cancelled, and a sync that isn't killed still
waits for all of them.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/super.c                 | 4 +++-
 include/linux/ceph/osd_client.h | 2 +-
 net/ceph/osd_client.c           | 9 +++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7936b76aa3cc0..166f6eb21f0af 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -137,7 +137,9 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 	}
 
 	doutc(cl, "(blocking)\n");
-	ceph_osdc_sync(&fsc->client->osdc);
+	ret = ceph_osdc_sync(&fsc->client->osdc);
+	if (ret)
+		return ret;
 	ret = ceph_mdsc_sync(fsc->mdsc);
 	doutc(cl, "(blocking) done\n");
 	return ret;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 7349ca09a227a..674dd9221d657 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -579,7 +579,7 @@ void ceph_osdc_start_request(struct ceph_osd_client *osdc,
 extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
 extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 				  struct ceph_osd_request *req);
-extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
+extern int ceph_osdc_sync(struct ceph_osd_client *osdc);
 
 extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
 void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 4479ec7a932b3..ff82aa16b5f52 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4715,11 +4715,13 @@ EXPORT_SYMBOL(ceph_osdc_wait_request);
 
 /*
  * sync - wait for all in-flight requests to flush.  avoid starvation.
+ * Returns 0, or -ERESTARTSYS if a fatal signal is pending.
  */
-void ceph_osdc_sync(struct ceph_osd_client *osdc)
+int ceph_osdc_sync(struct ceph_osd_client *osdc)
 {
 	struct rb_node *n, *p;
 	u64 last_tid = atomic64_read(&osdc->last_tid);
+	int ret;
 
 again:
 	down_read(&osdc->lock);
@@ -4742,8 +4744,10 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 			up_read(&osdc->lock);
 			dout("%s waiting on req %p tid %llu last_tid %llu\n",
 			     __func__, req, req->r_tid, last_tid);
-			wait_for_completion(&req->r_completion);
+			ret = wait_for_completion_killable(&req->r_completion);
 			ceph_osdc_put_request(req);
+			if (ret)
+				return ret;
 			goto again;
 		}
 
@@ -4752,6 +4756,7 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 
 	up_read(&osdc->lock);
 	dout("%s done last_tid %llu\n", __func__, last_tid);
+	return 0;
 }
 EXPORT_SYMBOL(ceph_osdc_sync);
 
-- 
2.56.0

