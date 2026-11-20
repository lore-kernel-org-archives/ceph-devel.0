Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160132;
	b=23s97G/8jzRQkQk0Ac9O7cwNQ6UpsDpDMeQkwLPFKfdK6voWDxiOhLFxRhYKLrQaITlW
	 /CP61P8LDmAm4KhdwJzhAqtODdQMALP63Tncxeaji6XYnfnls0ZJliBe3H/0opRIaeWwb
	 czu97nUjpqgPs+ZrEkVda8tV2Oi7DhNxGIT0DqpE6IowU5H+HRsDeW6HSRdXTgT6kOaMM
	 AJcxkmmba8nrGo2xjN2EamvVmfIZf9J3tvWI94JSH/xhIGLOmKljV8DBTqCjQM6FLR3/V
	 s4xJ6KtnkVW+x7rHlXtbGPii8v1iClAhOw2gknMFf6XhsVfZcFN5VzDrDKvnFT8Klew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160132;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=g5ePqUW5jhsGNNHtBv7PBGffzo65nNI2LxVOFcMYxY4=;
	b=dfGJRSdL16PrHXH0gMoYMWm53af+9P0RtavvCwl1mMCZM0XDwsoobPksCuBTgS76Lla/
	 jYtodW9GfoOVkPTArjzUMDhhcb5qn0SHOQnaESyDSthUMRNkesohw7RzOjZWgVe9dWtCi
	 0VEj5eHRYMbOlV4DdH7Dvq3Gd1WyU/WzNOfIxk0tCB29JaOtzoHH4e/I3IKaBn3fdA1ks
	 +68p9/gsFG/mWb5viwjRIGqzfpoU8XQP2h8/RC0jfKx1FmjlaU+mkUeQIgEsK+1GmQeNs
	 BJAeV32/s9IHNqXe2ZSvNQwW6UOwkGcMuNxDfU2wKjOBypgoKRcDLHzrqnXODwccG3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=fQDNXPPw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB352606A338;
	Fri, 20 Nov 2026 07:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB352606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=fQDNXPPw
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3Tk6H3550304;
	Fri, 20 Nov 2026 07:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=g5ePqUW5jhsGNNHtBv7PBGffzo65nNI2LxVOFcMYxY4=; b=
	fQDNXPPwaWM/DyXAEB0q3iSv3eP+oD/bUhCgNpIGUQ2We2+wb5ARSA1O2/NJpe1F
	VYvZjmvw8sZ2OLI3PG53GG5h0UTxTjaRSCErPCpO5/u5ih1ymg6SgYhXdmkaG1M8
	6AxqSvUekMTku0WGLBFZ2B1qVIAt8AbAEethyDEaMynSWXJkW81PFyz4esK6HnJA
	lqzi5VYeZ/f+r7kxvRw46N60ZV/YWm7Rz0zW06D7M/Jt1+jVwcucS3j5x+2WteF5
	ui9piVmZW8ZreEnYYII3Yc5cNR3HMs7jD3naGgyGbjb/XUOUogx3JB0U3RJklcC3
	LvZKo0p0pPDYj70NeqMx1w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021143.outbound.protection.outlook.com [40.107.208.143])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvkg737-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:35:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPSTE4D7tznv6EPG+i2FeUnmiwW77ZYQgYWOAE9Z6/PPrGm99Y7IX2HcpkDWNRQ2TULkRi4SbGKLVRd+Njq41WHhbLOiK8YbsMW0+TguqZoRJegoOdTwbTHVhdM+w9XzdGtCrmYSTQ1v1rF+XUlBD9/mru6pIYsaASON52EyCOQyfcHpeN+HPh+OdhYCo1c69KPnLs92deJmjelBWR1OVVZuHRDxJNXtnfwQ5BuDd9kT7LRY+OTGt9YK0ykQWmCLzXciSwFzO1CMToTfJ2vMd2wz4+Laa3tWvDAPs8HAC2iXJoIxN8lb2Singgqp02DutEq4WtdNn8gHwEwOGUsw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5ePqUW5jhsGNNHtBv7PBGffzo65nNI2LxVOFcMYxY4=;
 b=sV+gvCu/kzDWBh+17xFIMqiZrxGhNWpj9xuBiuYuPxYtxh/nUcnJsgl9jZpJrWFZRx4SpbGjjMnxqtWaHc86jqNeiC1MYSSAf8/2U2zlBKHOJHn1y+SijlruB4n+CeYthbmJU5KeWwTa27JXskb1sHToHKCzAYQG9CRrmCi2zFau3ORi885GJqdZXEETM+IrC/+fGPXhWQXjdEQiS0R9snqS70VNJjSTHWu3YE8AEK7+fBO/DOH9tZ7kJjshCUm9zVc9BK/qD+ybTqIWw2aMdPivyxG5PCCucrCuEajy8z5RkzNuamb3VNl/aubF/wysd8B2CoA1SOWI+gEqpZpzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 07:34:57 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:34:57 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] ceph: bound the ceph_mdsc_sync() wait by mount_timeout
Date: Fri, 20 Nov 2026 09:34:18 +0200
Message-ID: <20261120073431.53636-3-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37b6029e-9699-4a53-8ad1-08df46d8c6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|52116014|366016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|261022105027099003|261026140227099003|261026121527099003|5023799004|261022075727099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OnqhMiV2MJUc+F/0lFfC21Xtdb9nIRFM2xv+BYQmGOYoQrgoyjzBouhMPlnhIdyE0ac/Gu3MIFQkiT/AuULbyDycxowCNY0ZWcM3YXuPJHx2/buB0eOk6428VshP4t9AfwxUsEFErJGBE+rpySULT4OBWAyGa7RKqPojVC5OUpYAFnL3VNJwgOpp6ne6odX20opSVGcC17o/JLvLwoiqZaUT8J9nObUkYgArj6saXdsUy/EqcgSvgl9qkc4zLCQg1IdHMRTthFKCH3z09qTcgJzb/Ro51cgfI5n6Ct6QFiEtU9EVHAVhYpwFVThU4vYox1W5P71sYvTnbU+TG/6I0xaMtFrY3a/+aVigcIr/N+TTlYqZU1yKYLZMkt6fFMYUkr2qVjjNqtZzqVEpOlB4RVQ67p3J0GMgy8Illb0u72C2MPM7TNirLYFJjQ0gbWdqgj2frnxrltavXDEUfa1QHtZ+vbqv6ARw7YEbl3vzb0g/FB7qVYC1TKhHfw6Vd1ITEF0ncHZeKte/2eV9oxZC7+mOpBPAHfQynbZBoHq30R/t0MyW27W9deMqWkJ2WHrbfhmCyPkl6DMgR75bFYT1mFApfEmi/ksw1KJesoaCLeNcCctK37XmuaKqG26FJnPjDwtIQoWGddCmT9Q8iTGjKsVWqJ8DNXILPiO+MhEnXbs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(52116014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(5023799004)(261022075727099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m0PPSJUTUFbMeoZLK+/7cJJkZuXEURHzxd6gs32rgebHRJXr06WGKw9TF/BK?=
 =?us-ascii?Q?xkwbN9aUCBpAIZHFSmlTICE7B3Sd21a15G/+zXUULlh0EERDVWiDLdPeAFqW?=
 =?us-ascii?Q?67yZgV2HNQL54AOBqockYSsrVfqS2U07uIoZNRdCLQi1D6r2d+MoyZL0QvPi?=
 =?us-ascii?Q?v68TjfYRzSIX4X3INwKk1QL+0oCEfJY41YjkExxrh8mG7lBLK7+Z5BMKtSPM?=
 =?us-ascii?Q?apY+AwTx4dU3zuJeTb3v1MSCFiAZMdKDSxsO4vEtLumlpcoPcAERg98rTvsB?=
 =?us-ascii?Q?HEEOrKNoibv3g1hBSW2uHK4jVGbY8pZlyhcizWOvn3dRkRm0/E4f+DBbMHpE?=
 =?us-ascii?Q?MobId3tJOzYDyG4B15NTjN8dh0fiS4r+0NrDTW2SvcgaerbC7PFGM7YNMzVy?=
 =?us-ascii?Q?IbLdiPxs5DC4IsB3VGY4DdI1fzpMOs/6Eh01n/XioGjjrZW2w+fSYseaCX4t?=
 =?us-ascii?Q?1nn/ddwnkfcdXeLGZjBFJnvaypJXwLnnvG8LxxgCc9xG8JsR94AcUgogjSVw?=
 =?us-ascii?Q?3r1QDrqD7HSC6+XrqCDbZkGn7doygipfhj3D9oDT1r0SIpgH6AEZCO9ux5qK?=
 =?us-ascii?Q?oLVw3xgg7IODly7Wo/gnRff8590Thp6c14qeT+rbOyvDmjmbt33fKb5Lw0WG?=
 =?us-ascii?Q?ZkoR9nZodR0h6DGgkVkVVY77X7THrtNLkN7HEqJdP0XyZQXdy3qFIlpfilrx?=
 =?us-ascii?Q?sgLsldQ+W0LmgF4iH3Qd2xfF27By6UAIbnVFKT6n55RTc/dyJjTz3j4PBSQP?=
 =?us-ascii?Q?fFQ+kApnPgxHQEuynEZU9/y2LXIdwgPj1Avbcgfr7VFGXcwVknDYZkzQlTb0?=
 =?us-ascii?Q?niG40rAQF6B9X5tVfI6QW2k1Gn3i7DXef/ARGmnTR23qCTsn2gJ4qX956V82?=
 =?us-ascii?Q?dRd1XCUVSoswJzSsmGG/V1xP1g6nlXQeObyz8mdyqtxABL+rcLNlIbtVostL?=
 =?us-ascii?Q?M2i1JiGC8u4YwYFgWHrmnb97VkskcVAqsuH5ifHp3S4K88hLIf/qdwpBDCFa?=
 =?us-ascii?Q?GTtTDLiApaajpPd+PvmW3BrO0aI3oSatdMbYIRkTtSiRREo+T3Hf8eFiNvlx?=
 =?us-ascii?Q?HXEIDAuQqE5gcc0h5MLLjWKS9jjLqm9uOOMRal/vYjtFlklhazP2U2h1V1Tv?=
 =?us-ascii?Q?bJGYr++HB41WA4vSKT4VlDKVJUpu+uqf93WIpQ4LujvZGbWofDUpz8OxiWrU?=
 =?us-ascii?Q?J5QdZqrtaL8urbsZTO1Ck42hmG0K08zkFjnG+SkC1xJjOLm2DPbJbagqvPH+?=
 =?us-ascii?Q?ZESZXxYFi1DDOXdD2zHrqmL/EzUE91j0OZA2OiJX5MiSunqj+eeiDQ+Tm053?=
 =?us-ascii?Q?TvsoP6rbHnq1eXBrwx1SJO0Z0UfsTyyjgZ4Ooztx2MoSGUx6VPfJ+Zs60cIU?=
 =?us-ascii?Q?wpYVRMv/fgGNq9u8EWX89k+s161GnoU1kQuIuN9GnZSzNU2c6ZVSYgkXl3Xa?=
 =?us-ascii?Q?VaopKBEpaTd937/YIq94huKWRmxNr3fZ5b0puZvFDsIIB2RtPI1uk+T/s2XF?=
 =?us-ascii?Q?9GVSg6Gir6y/uHEnnoc4183HznaYeMhB4thVKQWMLtPBHAupU5EUKjC7g683?=
 =?us-ascii?Q?kQer2YlPIdv+f4KJK0bV5E32pYQdk9tB0htDtqbiqxIoV43J6NXKxcEfWJmB?=
 =?us-ascii?Q?oXg2vWgMEEHEFFjQJZ1HHGoUb6ybuoQbNFyxFYqqMfIGMaoD1d+nlA4qDVtS?=
 =?us-ascii?Q?sckrwP/w2Iee9m+OZQLOf/N0PrqdF287RbkDLG1w0ZL5UEcti1VeNnIWfJvT?=
 =?us-ascii?Q?iq7yXbxrRdsMa3YQyEKzvLxVYdqg12yZDZERrzfYNxXH47Ls+tWsxCSBJWHM?=
X-MS-Exchange-AntiSpam-MessageData-1: ccuGWea1wHYkHsTMAbYrnVSwJJvS4dUfvvA=
X-Exchange-RoutingPolicyChecked:
	xlhWHzyy9t03gbeHH7e47oAAg+TPBumSXc4V1SgAghJftlnpjiuHDYSpdx5fOJIsVBBfbMlOk5Ox07HR06NRjROOjTZ3+cJj/pN2rr8I1KWXMKMMuTunk6m1/Ckc7zQGK3149dnSt091ZPI0NTYlOCXl7vDR+Nxg9sJ6/paWf65y5LaudhC4hAFgKjyBpSmKWpiur6E/Tvw38ZEgNE0YTQ/VKt8RB1cLISNXsJ2qQ9QP4Phgd7BKkyuDao7IvnkJ+pvtImEg/wJlq8IfFgaKfQ5lHCm2Go4lgsO5Mbjmla0PJSJ2FicZ0lD+CJVrhR3SCMBSIQJ7JdzUrssxwTfTng==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b6029e-9699-4a53-8ad1-08df46d8c6db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:34:57.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXJ68wp8AdxaNqLyNQq++SILK0Uc36P8hIvElUMdr6+cvKFfMr9ZbnxXNkcTwEdxb7lA2jHT9GuOk2scspKRnEYn7GHsOG4heQimNaC/sik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXxcgtNtkyXZWC
 lfo2HzNdvQ8oCLvTGf8FhjgTukz/U4P2cvLdrEpjqTqxapJJZeM3pVXnkT7kjOMLH6zhpVbYvZx
 ILPLbb9dCon4e/rfW8fhPVlO+w1lVjrhdEm+ImlpX4OM7AS/pGcD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX9vvkMoPbIm6W
 6t5R28SpEsle2C/Tri7/qLSCkjok7vs1ooPmxT9JRZ9J9Bf7O5oUInYXgG8h/br7rUDusWMR5ew
 lkOFJuq6rsJxxSGYnc2MLA4k7ImB6DE5jk8ybSa/hmcZnRmTZZ/sVT9ZABy1c21pX4kj+NPqhvr
 6fBCh6X0Wl4+dww1pZZuTynZmAn7PRveb1sOWQxT7BQnOTkj5mwB9P2ekY5DXb7fkxPMjZIwKgF
 hX26HmjIq5dnZO9PUN7g8V2j8cdhZ9OxO7Q81hGgfnClnNKGN9JefgkQE8Pj/lhrVXAujqc6BXi
 /wIxfSAgnu2dJGnpDXOATeRpwMwxxfZwNFfgyFeZtPdr2CT+gGYUk18E252hcUTK/YgFu1L4nUA
 Ory3/9HNo+54x8e43Udk3IExBurYdS3W253J8qYX8vEgtKFGqC98NEsN5g9cZLTgOZT8cGiL7j7
 D4rWa4Ig+nOutnVQInw==
X-Authority-Analysis: v=2.4 cv=OdYNnRTY c=1 sm=1 tr=0 ts=6afff82d cx=c_pps
 a=QMhPzt4RVFymwNJSNtbcTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=JNaU-UHPnqVTaEsBh4oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: sUO40_hJbBg06e6cDDp4WS3uNBZKcIO9
X-Proofpoint-GUID: sUO40_hJbBg06e6cDDp4WS3uNBZKcIO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200029

When the MDS is unreachable, sync(2) and syncfs(2) block forever in
ceph_mdsc_sync(): flush_mdlog_and_wait_mdsc_unsafe_requests() waits
for r_safe_completion and wait_caps_flush() waits for the cap flushes
without any bound.  The diagnostic loop added to wait_caps_flush()
makes the stall visible, but the task still can't make progress and
keeps tripping the hung task detector:

  INFO: task sync:514917 blocked for more than 983 seconds.
  Call Trace:
   ceph_mdsc_sync+0x4d6/0x5a0 [ceph]
   ceph_sync_fs+0x31/0x130 [ceph]
   iterate_supers+0x97/0x100
   ksys_sync+0x32/0xb0

Bound both waits by a single mount_timeout deadline, like
wait_requests() and ceph_mdsc_close_sessions() already do, and
return -ETIMEDOUT from ceph_sync_fs().  Nothing is discarded: unsafe
requests and dirty caps stay queued and are flushed once the MDS is
reachable again.  mount_timeout=0 keeps the current wait-forever
behaviour.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 84 +++++++++++++++++++++++++++++++++-----------
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.c      |  5 +--
 3 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3791fc627714c..d02fe1e34527b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2520,11 +2520,24 @@ static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
 }
 
 /*
- * Wait for all cap flushes through @want_flush_tid to complete.
- * Periodically dumps pending cap flush state for diagnostics.
+ * Time left until the sync deadline, or MAX_SCHEDULE_TIMEOUT if
+ * mount_timeout=0 (wait forever).
  */
-static void wait_caps_flush(struct ceph_mds_client *mdsc,
-			    u64 want_flush_tid)
+static unsigned long sync_time_left(struct ceph_mds_client *mdsc,
+				    unsigned long deadline)
+{
+	if (!mdsc->fsc->client->options->mount_timeout)
+		return MAX_SCHEDULE_TIMEOUT;
+	return time_before(jiffies, deadline) ? deadline - jiffies : 0;
+}
+
+/*
+ * Wait for all cap flushes through @want_flush_tid to complete or for
+ * @deadline to pass.  Periodically dumps pending cap flush state for
+ * diagnostics.
+ */
+static int wait_caps_flush(struct ceph_mds_client *mdsc,
+			   u64 want_flush_tid, unsigned long deadline)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	int i = 0;
@@ -2532,22 +2545,31 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 
 	doutc(cl, "want %llu\n", want_flush_tid);
 
-	do {
+	while (true) {
 		/* 60 * HZ fits in a long on all supported architectures. */
 		ret = wait_event_timeout(mdsc->cap_flushing_wq,
 			   check_caps_flush(mdsc, want_flush_tid),
-			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
-		if (ret == 0) {
-			if (i < CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
-				dump_cap_flushes(mdsc, want_flush_tid);
-			else if (i == CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
-				pr_info_client(cl,
-					       "still waiting for cap flushes; suppressing further dumps\n");
-			i++;
+			   min_t(unsigned long, sync_time_left(mdsc, deadline),
+				 CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ));
+		if (ret)
+			break;
+
+		if (i < CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
+			dump_cap_flushes(mdsc, want_flush_tid);
+		else if (i == CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
+			pr_info_client(cl,
+				       "still waiting for cap flushes; suppressing further dumps\n");
+		i++;
+
+		if (!sync_time_left(mdsc, deadline)) {
+			doutc(cl, "timed out waiting for flush tid %llu\n",
+			      want_flush_tid);
+			return -ETIMEDOUT;
 		}
-	} while (ret == 0);
+	}
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
+	return 0;
 }
 
 /*
@@ -6737,13 +6759,15 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 /*
  * flush the mdlog and wait for all write mds requests to flush.
  */
-static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
-						 u64 want_tid)
+static int flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
+						      u64 want_tid,
+						      unsigned long deadline)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req = NULL, *nextreq;
 	struct ceph_mds_session *last_session = NULL;
 	struct rb_node *n;
+	unsigned long left;
 
 	mutex_lock(&mdsc->mutex);
 	doutc(cl, "want %lld\n", want_tid);
@@ -6782,7 +6806,18 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 			}
 			doutc(cl, "wait on %llu (want %llu)\n",
 			      req->r_tid, want_tid);
-			wait_for_completion(&req->r_safe_completion);
+			left = sync_time_left(mdsc, deadline);
+			left = wait_for_completion_timeout(&req->r_safe_completion,
+							   left);
+			if (!left) {
+				doutc(cl, "timed out waiting for tid %llu\n",
+				      req->r_tid);
+				ceph_mdsc_put_request(req);
+				if (nextreq)
+					ceph_mdsc_put_request(nextreq);
+				ceph_put_mds_session(last_session);
+				return -ETIMEDOUT;
+			}
 
 			mutex_lock(&mdsc->mutex);
 			ceph_mdsc_put_request(req);
@@ -6800,15 +6835,18 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 	mutex_unlock(&mdsc->mutex);
 	ceph_put_mds_session(last_session);
 	doutc(cl, "done\n");
+	return 0;
 }
 
-void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
+int ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	unsigned long deadline = jiffies + cl->options->mount_timeout;
 	u64 want_tid, want_flush;
+	int ret;
 
 	if (READ_ONCE(mdsc->fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN)
-		return;
+		return 0;
 
 	doutc(cl, "sync\n");
 	mutex_lock(&mdsc->mutex);
@@ -6829,8 +6867,12 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 
 	doutc(cl, "sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
 
-	flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid);
-	wait_caps_flush(mdsc, want_flush);
+	ret = flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid,
+							deadline);
+	if (ret)
+		return ret;
+
+	return wait_caps_flush(mdsc, want_flush, deadline);
 }
 
 /*
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 4749438d94e1f..31abbb3b3bdb3 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -635,7 +635,7 @@ extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
 extern void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc);
 extern void ceph_mdsc_destroy(struct ceph_fs_client *fsc);
 
-extern void ceph_mdsc_sync(struct ceph_mds_client *mdsc);
+extern int ceph_mdsc_sync(struct ceph_mds_client *mdsc);
 
 extern void ceph_invalidate_dir_request(struct ceph_mds_request *req);
 extern int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7b5ef76e430d7..7936b76aa3cc0 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -126,6 +126,7 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_client *cl = fsc->client;
+	int ret;
 
 	if (!wait) {
 		doutc(cl, "(non-blocking)\n");
@@ -137,9 +138,9 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 
 	doutc(cl, "(blocking)\n");
 	ceph_osdc_sync(&fsc->client->osdc);
-	ceph_mdsc_sync(fsc->mdsc);
+	ret = ceph_mdsc_sync(fsc->mdsc);
 	doutc(cl, "(blocking) done\n");
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.56.0

