Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420967;
	b=Its9LyeA0dZUnxvXfuayqXGZI/d4af6Ue+AVJVXOoOgginL07todEPcsdKU9zSw9x6x6
	 F9BmzSmDVjI+fgXVRKXe+OwZ0O9jFJyk9vpneNmdpL6l2/yV2qF+GMSmksBXNnMT0fdiy
	 hzQU/r3P9pjXgoz2nHbRunjtzWQ+s6qv9XR+L9YWHJCtfDgQGldPbW3ByFHSJghrx8O6z
	 74jxYlrcOuwiA456m602UHOAtiOuBcWRdsh6cKGTYPy8sGZJL1uEWJSCrhm6Mjx6vcSPz
	 O1iRnedU8Q/62BgT8Ou+fRlPwp+P4WIA7yC1q1q9afT20v8Y+rRaf1SrwautuRhhMSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420967;
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
	bh=/JjTlzR8I557LEQ8CbJUA7yfqjZ9iet28lWE1UWNG40=;
	b=Gd8tO6DKCarGvaz7wbfX9HecIDZT5lV/VH3Vc3qUrCNldpMYAt2ug6YEI7qiVyaUZXKk
	 L40tnOZf6ybTzyoW/AoB9y1gT1zgjhwGOIRqYy51gZNoAi8yGDVbqpnclMucajKyC1ItE
	 XvKmhn2Y7mEG4wmqSTQ/nSF+Y/siLcnGwWnL/Dpz8LnPspH6WAgEIMSgSVHCc0mxTJi8J
	 OO5YXczPJNRYya1ezRdgU6jOm1L6AwqkI64SdqqMRTcZBd2Pdtl7Qg5eW7h4j5hiZ8B4p
	 ngBTs+weK9ssKmsJG8URwQSVZlYBLeDmLDNHEgf/Eotrvrtb6zDA+SDqfvFG7idJT6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=gAwaZQxt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87F606A681;
	Mon, 23 Nov 2026 08:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C87F606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=gAwaZQxt
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN6kQad3025693;
	Mon, 23 Nov 2026 00:02:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/JjTlzR8I557LEQ8CbJUA7yfqjZ9iet28lWE1UWNG40=; b=
	gAwaZQxt7EcqRzvITDg7gHKrlUcFSnUKuMc0pASkxKHIwPm+SG/kQNY4XawlaBbH
	Y21iT1fX7ig74J4WDz4LdT8Van65+szXvj4D/B4rseAeozOQPMz9gKdlA+E2x1GM
	3ri31Bcc6cyPl7ds+Qy0toQE8jp1lj31QCrxDcJ9BsCUoxjkwGQIQl0WF88UHdR7
	l1g9sVXObM29fvUSxYrFwt6ZoJQL6WzNpBDpvY+FR56H2iS1Fu3KocIcxoe/cujJ
	mDgUNm2EGuNNt8LtNcDbGEJ2AV+/FZd2+S5eJERuSzrFnZWyPqV5H0MKNaY6JFUa
	cP3+6NiZMCqTUO9LS3hKFg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020099.outbound.protection.outlook.com [52.101.56.99])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j3bpjsr51-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 00:02:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8f4YRPbA2vvI34dyNcSiD8ZtmH/DS6d6F3BQLgZf7S53B+5zqkN89MsdgcuzdGltZ9MajW2znlPpgItrB292NBQ/ebYoqjOA2DQNVKns2pLu7+A9R7jPpcbqwNCLeM/GUPiKT1HSQZUxlQUVzTUqUC+TAiCBabMZJYjPkTT/YkWcwe3Zlmxo+sbBdxkYAmGMd0xqBicye/6hAGuFZBscI0qYKkXsE3z7NSjxZh676rdeNs3Gs3KFzUNbK+TppZFZQCrvfGjKd2bIXcXhloqcuLL/z5HcdBNzFLweTfB/nndeeGKReYlPAydK5e8oSRgCQ7emqpvPOw4JTJtSLMjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JjTlzR8I557LEQ8CbJUA7yfqjZ9iet28lWE1UWNG40=;
 b=pJDFvy9kHS8cjMWGopbwcA/xUKCA6v/QnwOJ6yiC0gCkCnxspKYDaGBtuli8CXkUb1A2i7SWOdPHrwVPhvHKJtqW4vfu63YTAfWwdXDoITnsl1MFMQ3dOfQwZHAfOzMqkLmmSKxnjLDAVV5v1txUAEkSqtUCQEAVjQoaHuHxNymRV6UbJs7m+DRJ7UAPRG8cAiSPz8eUcCOAYdBqzchT1iHSMnw77gstaXJ+WVAGd5PEZY5UyNYpJt/YdlqIUfODCLnxBPHnjttF2AJXnsr+57/Xiy8Uygxmo+TndyxPHgVKl5h1Dwk61BteDOeJ91lyMezI0TXXuT1DvOoW9C3qAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:02:21 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 08:02:21 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Xiubo Li <xiubo.li@clyso.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] ceph: request a full mdsmap when an MDS stays unreachable
Date: Mon, 23 Nov 2026 10:01:49 +0200
Message-ID: <20261123080152.163172-5-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2677e46e-d290-4bd7-4573-08df49381a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|10070799003|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261021123027099003|261022105027099003|261028144727099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3hS1HhQeNXB13RwE19LsOHsbJaM9pUprmmLBzMjancaLO8ud4FItIT/Fk906XCoWfFF4GIbhPGzmYamHj/B/JRF/OOwXJtITh+X0ItyHQdq0zOKdnIikotkATVTvYxVrhA5gKjDoTlOWsBq7nfkqD1156GqnIGSpTohaIvMHnUsChJqA6qlzA9zFoM+vuU992AENfcZTqun9uBIPh/NH6/IPCvgxxsPWbZTt8zrLuMxGfl6Q3EOy/vSDc6RxUVm0bVDO3ayrwR7zKvcGAU+hOHXIYSZyrgXVywRBmsTFGMyskgNjfhDf+pSjwHDtHG22Ozh3wecjZaGRyzO0hS2Wpmh1ePPmhPFL4esXP0izHx74QqocR8F5QPDzcA0jVc0o6e9xYpLQx1kflSzt15FNXBxavhnw7qrT1TC/LasSCObaa7o+jLcnZULa4xuqiHMRsi5/j9ZedDl463+XO/dtAPd0U07bk7xIFIKzBS3W63piOOXM5JY6FSGV0lGBt1DXGge2Et2c1uqWNPg1/pl/ifbn/Q7ftSfOHjZTgtuq8UmT7iGMADAVygJi7BFwVK1XxXPRN9218mnQa9OGsVYDC30U0QhkVSndLdIYxfAfW+DWpCwrS4HTuMA6qQlxnvcW7E4QIJRAwRbt349gvzkZjmauj3a7Mk6BU8pSVusiapA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261021123027099003)(261022105027099003)(261028144727099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oyMl/g+FxRVpPqAMIyaFCvSrNeKjGnK1bKTV+nFxIDxaFUVWbqPqI8Qbp7fY?=
 =?us-ascii?Q?51CFQF9xeTiA4Zvkkd6F4Zh8Ic9Z3nrkrKlpM+fRufkz69fzfeATMYv+w0S4?=
 =?us-ascii?Q?h6UxHNbVwi4ctK7l9sUGw7tuz/qZeZuLeHg96FIojIhza4qSHXWhOx3m2jgz?=
 =?us-ascii?Q?aIKWwbwUuBabQ9vNKW6mvNMtaC8tqTB0cECZ8rWoBMEAofsI0aZaTDcNb65Q?=
 =?us-ascii?Q?gskI89O39zlsJ6m0nae/x6XzR+yfBGliF1GsEFilTAUh9UxCTSi2u2OiVH98?=
 =?us-ascii?Q?oxursjdVU9RxAPflmtkn5bQTp93B5MTOyZNrtWRgqWQMzEiBrUeo2Rw+FnGa?=
 =?us-ascii?Q?yJ7KtI49PhF0cxo92e4VdyiXtjaTLJPEu6fn/mM/Dm3MGTGbrersPgkti0Jf?=
 =?us-ascii?Q?mVV7fUzRMmK8aoqbg1jRtiIGK5ZGxC0nMfq3AOir6DnDYIy1m0k9z2sfVIEt?=
 =?us-ascii?Q?xms4+4/rUWAtQH3sHg8/bINORibbi72nG4GpD1dlD6tVPlP6cIplgAjP61fO?=
 =?us-ascii?Q?ZvztiaEh0U3lewGcHJUHrDfFEFRoRHPV0AcUXPaj2zwVZS21G4XmI0ztot5n?=
 =?us-ascii?Q?TlXFzEzFI+r13c+2i861J/RooxcRI3PnW7JvvDMMd5HdO9ut+GhNT0ztxSBq?=
 =?us-ascii?Q?c8thCCmjISz28RASSgHiiBv0eLbI+j91yo541A/4oJn9iLbn1MuAMoNalZql?=
 =?us-ascii?Q?r24xZJx8NWKB41jKHauHvTvL3UPmwf13+Gst1lhvunl8INjvyRCD7lwh2zZB?=
 =?us-ascii?Q?yh6i4S8vNo5mqV5SR8c7CDx0oHy5SAx57RjAJSpD1gq0PQ+630vG67kVmdEI?=
 =?us-ascii?Q?QtLmKhjKHA8k3alGw6Qpm/cDhLzRVyDTHfNZvf/n35fYtQ9pB9RJn1PGQDfx?=
 =?us-ascii?Q?wviiPsTfTyWF+ktyheg8baIDtEYdgTf3zL8tngxO1gECrlO3F0SsE+cm/O3j?=
 =?us-ascii?Q?sBuimtWVQIVS/N9ijbOJW9OCpU/odXRBTfKSNzLME77UcS2mIRATW/zGJOx6?=
 =?us-ascii?Q?x40JzMCPnTSWK06KdKKnSLpH8/SJoNvF8Wmm68PIIrvf7Ln8P5v32IxQFOD1?=
 =?us-ascii?Q?zkgnlWMcTYWPLXlUCkYrqcFvA8SixshpmvMc33rpZ+H3Ire/DtiQUefgRtnV?=
 =?us-ascii?Q?fmxlF9FxPhXlwwpUE639QjA28M7t0iuP7QYtYNQtTnF1jzdoNfJcNmGDheC3?=
 =?us-ascii?Q?IFG0CEIAJeanBoJMYeUy5qju759Q9Os42YstCGFxrL+k8ieyDgypL14T4rg/?=
 =?us-ascii?Q?DfhtMphiTVJZJeW3NM5l+2+gIplZEuadhTl2Vlo17oUws/zbnyRtGcy93bM/?=
 =?us-ascii?Q?mU4lhByJTgk8KGNIB/tjhdudfJxEWlXTojJJUE+AQMlg+lNPdx7rx0/wg8Lw?=
 =?us-ascii?Q?h85HnLtGfTuR2LsgS2mwPSCvlpX+eiz4/1PsifcsV10iE+syKL0Al9Nz1Pu1?=
 =?us-ascii?Q?FaawjXzGUdE0WF1f2nLVLDSUJaGZA5QWS30gkdez73LS67Vae1Hjp718+8Jv?=
 =?us-ascii?Q?QOZf6FFPZ4v0Cf5rNgr9vdF/Es3Y1/y6w9D5i9j+57ei3hyA4sV0cbAoI3nA?=
 =?us-ascii?Q?NYomDnEDBU2PYFQND68czoRNlLmrR5GVdO8QcnwvI+nnWEaWpoLMnJRtqPgd?=
 =?us-ascii?Q?hOkNc8mSTscHlDoMRdf6Z/UIcXstotBJUengc0d/zqlFH2lHODJVejQk3Oqa?=
 =?us-ascii?Q?Tx+e1i3yDBXm76QPM0Ff09SE4z8y/eX9NtFzb3rkhtuW3eXGCpld9tWS3QjN?=
 =?us-ascii?Q?6pN4wKsRjyJyYU7fgNZ4B+XKfjVw9cHARlSyW+KcctjikDUACmaVWlpvkEr3?=
X-MS-Exchange-AntiSpam-MessageData-1: FG9YBP8hz0cWvbO8wXjRV3KISD9p1/Vzge8=
X-Exchange-RoutingPolicyChecked:
	FZxCrtfDe0UGpJmlh6v6UA/kZ6tSplqAw3t5jJwTcx84I8xWcSIh0pKDsteYiOyGOILkcfbqZW0doMA6EAqpwJC1yFwj+Dv9Rv+XpJ4GAG1/p3SGtv+xSxN+NcqmZmLUaJdycOG1KflpzCd/Um++UPZsCTJtqOI2kkXoS6cd5StqU6cVqkDzoC+i6+3rCIYg72KtDzJgtIzi8HBiinv54hyYrh5YLBEfgrU2VeqFU4H4285MLfE5uIdseKhBV0ApbG1xTxCbWGIwDb3sCEFpp4bnJWXn9CIILSnr8vdUBa7eNecMGSEqu8/+w6qFssjBOQVMUZTpzigTjlivTek7wQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2677e46e-d290-4bd7-4573-08df49381a13
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:02:21.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HN3roR2oh2SV8xpzlOxB2GxvAePuGzv2cXuEsSzVdaREoyeIG82xVmLCG3/u+4ft8h7H2ORogo4eydRhn5RQq9604EOBIFbrnbMlyg+TQzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfXxtGyFCNuVvju
 UYzQsJ1J17+6093G8pXGXkadbc8Ij2uJvw/jpC+l+7rfGB+4gCp5sR9O4vjIDpd3cr5x38y9QLO
 KdfxG/AHagy45Q8Y9huZKqMjwP3UDCk6n8zaBf2HspYV6+0QxpWCzyC/nvM5xhKBBDXl37gvwIn
 Rkj95qvsWbz+UBve3xqoMSPkUXQbHerqpdB9093DmhPkc6xNepmncQhmtIvXrnDp4NL+H7HrMjO
 /AYjylJK9b0y395qxHMbuYiAK00JV+YgGEvjwL+MHroM9EJVBdp+F610f7Dc33YCgx/6CP6hpO1
 azb9ESsG4/waqmIdltnP1cAc4HR6yt6oDIZybrDS/LrreqtMb7eHOka1Q9Kv3+qYcPCvsOT1jbZ
 UIlipXC2oMn8FTC3h7lcLl7Md8qewMDeHFoRtbtTnzZ//Ckhcxlc1E3CFBoMpMTDjYMlkbSRv36
 DQQU4AOaiKU7z1wmN+Q==
X-Proofpoint-GUID: 5D3HPHb37lrCaweexKUewLD8qCd5YouT
X-Authority-Analysis: v=2.4 cv=I8Hw19gg c=1 sm=1 tr=0 ts=6b03f311 cx=c_pps
 a=gw0jr/XWmcdhwQv4PjOuaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=sEnkRl3NJ9bUhnf8avIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX1lgnFvnkmHAs
 0NMst0YiB5/UEZY0367Gvye7quLCCiVhHRjsgrpoIQK3CnbxtzKYrTQF6Of1PWWceT621mWiVY2
 76HR7hGzHwVfU1xETaDu2Qmu2ZFwNxbnhdw9EthTVyMAdEH02kOk
X-Proofpoint-ORIG-GUID: 5D3HPHb37lrCaweexKUewLD8qCd5YouT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230031

The client subscribes to incremental mdsmap updates starting at
current_epoch + 1.  If an MDS restarts at a different address while
the monitor session is also down (e.g. during a rolling upgrade in a
containerized deployment), the client can miss that update and keep
reconnecting to the stale address indefinitely.  This was observed
with the mdsmap stuck at epoch 53 while the cluster was at epoch 68,
the session HUNG and monc reporting "have mdsmap 53 want 54+".

Nothing currently reacts to this: mds_con_ops has no .fault callback,
and a session going HUNG doesn't touch the subscription either.

Add a .fault callback that asks for a full mdsmap (start epoch 0) on
every MDS_CON_FAIL_REFRESH_MDSMAP consecutive faults, resetting the
count on any session message, and do the same when a session is
marked HUNG, which covers a connection that went to STANDBY and thus
never faults.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f64a9c97cb882..0338c7feec108 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -72,6 +72,13 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work);
 
 static const struct ceph_connection_operations mds_con_ops;
 
+/*
+ * Consecutive MDS connection faults after which we ask the monitor for
+ * a full mdsmap.  With the messenger backoff (250ms doubling up to 15s)
+ * ten faults take about a minute, comparable to mount_timeout.
+ */
+#define MDS_CON_FAIL_REFRESH_MDSMAP	10
+
 static void ceph_metric_bind_session(struct ceph_mds_client *mdsc,
 				     struct ceph_mds_session *session)
 {
@@ -4632,6 +4639,9 @@ static void handle_session(struct ceph_mds_session *session,
 	      ceph_session_op_name(op), session,
 	      ceph_session_state_name(session->s_state), seq);
 
+	/* the connection works, see mds_fault() */
+	session->s_con_failures = 0;
+
 	if (session->s_state == CEPH_MDS_SESSION_HUNG) {
 		session->s_state = CEPH_MDS_SESSION_OPEN;
 		pr_info_client(cl, "mds%d came back\n", session->s_mds);
@@ -6266,6 +6276,18 @@ static void maybe_recover_session(struct ceph_mds_client *mdsc)
 	ceph_force_reconnect(fsc->sb);
 }
 
+/*
+ * Subscribe to the mdsmap from epoch 0 so that the monitor sends the
+ * current full map rather than waiting for an incremental update.
+ */
+static void request_full_mdsmap(struct ceph_mds_client *mdsc)
+{
+	struct ceph_mon_client *monc = &mdsc->fsc->client->monc;
+
+	if (ceph_monc_want_map(monc, CEPH_SUB_MDSMAP, 0, true))
+		ceph_monc_renew_subs(monc);
+}
+
 bool check_session_state(struct ceph_mds_session *s)
 {
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
@@ -6275,6 +6297,12 @@ bool check_session_state(struct ceph_mds_session *s)
 		if (s->s_ttl && time_after(jiffies, s->s_ttl)) {
 			s->s_state = CEPH_MDS_SESSION_HUNG;
 			pr_info_client(cl, "mds%d hung\n", s->s_mds);
+			/*
+			 * The MDS may have come back at a different
+			 * address while the connection sat in STANDBY,
+			 * which doesn't fault.
+			 */
+			request_full_mdsmap(s->s_mdsc);
 		}
 		break;
 	case CEPH_MDS_SESSION_CLOSING:
@@ -7499,12 +7527,32 @@ static int mds_check_message_signature(struct ceph_msg *msg)
        return ceph_auth_check_message_signature(auth, msg);
 }
 
+/*
+ * If the MDS keeps failing to connect, our mdsmap may be stale (e.g. the
+ * MDS restarted at a different address and the incremental update was
+ * missed while the monitor session was down).  Periodically ask for a
+ * full map.
+ */
+static void mds_fault(struct ceph_connection *con)
+{
+	struct ceph_mds_session *s = con->private;
+
+	if (++s->s_con_failures < MDS_CON_FAIL_REFRESH_MDSMAP)
+		return;
+
+	s->s_con_failures = 0;
+	doutc(s->s_mdsc->fsc->client,
+	      "mds%d keeps faulting, requesting full mdsmap\n", s->s_mds);
+	request_full_mdsmap(s->s_mdsc);
+}
+
 static const struct ceph_connection_operations mds_con_ops = {
 	.get = mds_get_con,
 	.put = mds_put_con,
 	.alloc_msg = mds_alloc_msg,
 	.dispatch = mds_dispatch,
 	.peer_reset = mds_peer_reset,
+	.fault = mds_fault,
 	.get_authorizer = mds_get_authorizer,
 	.add_authorizer_challenge = mds_add_authorizer_challenge,
 	.verify_authorizer_reply = mds_verify_authorizer_reply,
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 31abbb3b3bdb3..46e13446afcc7 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -301,6 +301,8 @@ struct ceph_mds_session {
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
 	atomic_t	  s_num_deleg_inos;
+
+	u8		  s_con_failures; /* consecutive connection faults */
 };
 
 /*
-- 
2.56.0

