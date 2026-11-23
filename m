Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420968;
	b=pd5JO4afc0wt7YPGWXxdzrXo6oJsFqNqgpuSd54wA4ugXtwDeAtwK46Ny5HKdarsPlkX
	 BrR/hj4GYEe+pbauKT+Qtss0FKSNcQCzoSRG9a5fa9n6qDWr6ZobIPWfvYic8r5xWtqvT
	 zWR+VVV4YUk4KVJzKLOLPr3lupw2I5W/sOTeN3UkJWLzlzApe15Aerdb2pwk2DaTNecsB
	 sNL8M7qmAiVa9l4KG+ValmSmz+31OmgFgVMUg7t/b7T8h736tfRpth5mZ2Cnt4A5KYwNM
	 S//ifm3j6mPMDdZnJtUeFoXmrXhlMGXWRWwB03rx+Qwl6C48DFNQ56Ya8X8MTW7gy2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=Zj+vyu2Z5yR2R/rgin0zvN5PvMmbE4wLXF4dM//2RWA=;
	b=Fg+GefhIj7+jzXGTqmyY5AUTDAJ/I234UujqSWhLlJI8XvCWzmtpSOYDh06bWU8aDuO7
	 A/P4UU8wt2Jc86ZIh0XeS9TF52obIIRj9orxF9nlPk3mgfbxHf0cvPF7mh7RDtwOiZya7
	 n1Kz3YKVsZOSavqyQPi5NqtgR2XqbQwuTIY4UQKmGweC/d3Qll6Akt1SLVZw04znE/IAb
	 OrOTm0xl1xvTtN0qbY/rg/Ni7o/ygzF4wINahOEkbobg1UH+Y1rGiMlTKeUl0FvtkOSZ3
	 hYw5SBfQeFMINLL81Jq90Y0HBEKF4lyv6Q7FJ67egsT+vdQSnCEYkGX7dpN4g+UApGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b="Vn4m/f7f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A4606AE79;
	Mon, 23 Nov 2026 08:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 999A4606AE79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=Vn4m/f7f
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN51msH2840662;
	Mon, 23 Nov 2026 00:02:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Zj+vyu2Z5
	yR2R/rgin0zvN5PvMmbE4wLXF4dM//2RWA=; b=Vn4m/f7f+yhaHDvAJzY6KFyxp
	dhJsND/l6MK7BmJqGI+7LfYjkYQqLYZBGlFQP6Fxu2dTQGwOEO8oO58A1zB97w2D
	9ysmCX1EU4tT8XNn2Bi4+Kc4oao/hRlWFBF/ph8mkZn1b6+g0eBqMxcR+9VMs9RK
	8gHxulFinWwuGoHosvQbpN07+jOaa+3b9nzy2O5iXv0Sjfg5KPZ2HR0DSyAqWgqr
	WTMmEx7/jsCqSmw3343tQFKK574XEOk3WGUFKEqGVwT4GdGHzCB0BNMPhMYuN+gG
	iF4Ea16vmZ+h2hy/tzngfJq1Mst1GX86upGgQ9CwZKoiUaVkKAAeQD2gMdxKA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020118.outbound.protection.outlook.com [52.101.56.118])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j3bpjsr4w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 00:02:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XECpycByDyGgXB+hWphrNl3tWQD0qRI4m42nmS30pAj7EE4Xr4T6sYhJqH2MiJ4S16hu1UBLinR2huM/JeWMwzdaMiLZ3T/1orqYxeIeFqpJcFunbJoz7U8NK+17vCbZ4BV31UfY2SQE+sXamgTwUPo4Ldy3cXoHS3Lcb5budFTbtEKvGms3/v7iJIHIG8eu42ORDA0sLcHZtfrwRAXoKoP6xW+ujXOTOL1DheM8kk+ZwHfHXAAZyXarvFqW5qxt4OycMP3UFCmyMQC0KEqJm235r2JjMEm2OilztDHXIPsE1aBr5edbypo0ROyvOsWskN25ptEN58mb5mtwRFhKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj+vyu2Z5yR2R/rgin0zvN5PvMmbE4wLXF4dM//2RWA=;
 b=UYrQC7SSjIlMayDyAY6xHD6sdiTKJlIQgnnhO3Xy+6GkDfJ+NuDO3ffhs8IE1/8S52NOShhSe5U8A+XhubfMo0KlgKYIsbp32TihrTFyezMRC5qiFZ166gHcjjsYuFdWeiGkwln3FaXIQB3ZykrsgfIhGz0lKzdSWycQBmt1i1o8lpNfq0gQaSeruJvGtDkNjvlRa9gD7WXkULHEI2ugFS31K6KWWAh/1/bhGTNdBFs7CXlo+BsyuvWK3xyW1ZAl8EbEWxyvRPkLCfWC55iKpT2CSOF56Gh6OZaG8QINbs1w4bf/jV3SEw0PGsI4YVtAl0X5YVdaYwB1NRVsoJhfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:02:11 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 08:02:11 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Xiubo Li <xiubo.li@clyso.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] ceph/libceph: killable sync waits and faster recovery after network disruption
Date: Mon, 23 Nov 2026 10:01:45 +0200
Message-ID: <20261123080152.163172-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
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
X-MS-Office365-Filtering-Correlation-Id: 7c696da0-c685-4f6d-eef7-08df493813f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|10070799003|23010399003|6133799003|18002099003|11063799006|56012099006|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261021123027099003|261022105027099003|261028144727099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	l6yj/xoq2ND552FVIcQpiegW2Jbg14S9HtPSF1lmbrMXVrXB5FV8EDJye2SUr3hf580xSPEyWjGy7K6bcBV+3zDGI7gb4kmXbnwPseoVCTQkW1Dqih2tUn93Ag8TYVAf140nhrh0Cr445+TsncfOppax+4C/rT0llmm3kG0GEJ41YCbaczXnuRTpu7c5Qe7b9c9/+vsMYafV4EQyOoQw2/X6lixYBIhgwQmzy7xvv/zYAXUm3b22VG/oDWuPgI5E+AHDZdLU/usOQpXYjX48rMmfyvJ1Iy3vslf5N839LOITnfpieDUOl+ah0ScKiU8EfwUZ6LmrST4Xl9IWMKW340C1i7o+V0nQYhZUdwc/K7b3jshL7yiruyCTv4ykmXExv63ovMJ4i3aNr1xJvS/khD57VWDGf52cvyBXQH3xjw8LRB0WNwmzvL15cTwNLVXpxGOpOkxMcVb8SxgnYFQ3Dgpe27kgXtSZKObhX4apFJlxoD44jdcPdPNlEwHVKXSuHBBU4CADui9BK3ni4m8nU2ar+YJUMsdp70JvfS/AoKB5lg7en6PD0shccxsjAZniBL2BdFM4qYXwDibRxgyjR1373wiPCNq21dslK6tqcVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003)(23010399003)(6133799003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261021123027099003)(261022105027099003)(261028144727099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tlbm8hJLulc9i5laaW68OZ506LCuV0hiL1ORu2sjzXY4znL9ajudRGR1spBC?=
 =?us-ascii?Q?ly7cz+NTvy5MdFj+3DGU1Qxg/F7ZSADs1CP6jsrpLgLc41CVFZxuAjjBfxax?=
 =?us-ascii?Q?OVZu35+FvN23LFwHlpa0uCjuRLvL6W0y7NGKp/cLslj62CrhI77tWLNOVF/0?=
 =?us-ascii?Q?BPj+a04V9UtwuXX/YmPj+1CTNZVA+3c4P3iqkWm6uQFZkX2lbv9TDH9jl7u1?=
 =?us-ascii?Q?FOdnnSMfdwc7ZWUuMdocXJSB7+qsZfqqAMV5eU5QAkLDgu/dpKD6dFV2uY+o?=
 =?us-ascii?Q?QIbySxZoMJBVEdo/9W6akObh2XaGvTPuIfPLSGNqAu7Ang5WN88FQVN9Nn3R?=
 =?us-ascii?Q?386dEybvGJD8RdBXs5BYQw7xnDrEVkqnGNsRPKxwRL+CpEL/m9zV6JzcOiBE?=
 =?us-ascii?Q?SPH28pS9pd573gy6Tb4qJ7Asm6aWSNkzdWH3fDmA005HukQl/RUkz64j44h6?=
 =?us-ascii?Q?WeqjG6n9tJDeMQhe975idhQIISYyFtqVlhenZojgABWgrYhKbg2HtdyHKWAF?=
 =?us-ascii?Q?W5ZvlM8kZTfJSTr2O+K8G8ddrw8ynV+HKIv2ty1h2J7uf7pnlfpbDbLCg1r2?=
 =?us-ascii?Q?MWhdm2kzcPCIyxewKlHwh4XM4ZWwvFwljXgCR6jSkqBdrNc5mmM4+KFpuBUd?=
 =?us-ascii?Q?ugh64JrcNehREf+B45UuXIwr3cUeiy0iH+Yo71wxjDsw3G/9q6ovqM+wiJWu?=
 =?us-ascii?Q?62BoGsqHo0db5vmy9U5Uq4sb6Ged8lAaabuiNZgU4dGg/bqzgwTL1JiXF/QE?=
 =?us-ascii?Q?7KzWhPS+O58a9DYoj19nKNMg9bQFyqggWwTkHGkZVDBtE61f/WFj7gPh/MwT?=
 =?us-ascii?Q?3OKrhWh4wf6qalTdxYlCd3j1T86qUn4cIouoEtcBhc650YQVuZsRtDIdgPUl?=
 =?us-ascii?Q?1lKdk3XBEIT0N9tTQbiAURQ00H/N5AIKhROeUt73c6PE2tsT4RxiP3KVX6+c?=
 =?us-ascii?Q?zKi5mCHEoEVi6IknP+u36mqGUT9K5Wia2me9YW/8QylcUfdPAb1PK6tGqvR9?=
 =?us-ascii?Q?aeGDKjyO8MyFsNmCSMMLbU6jWBGfs0njCpqfFzUW/KPB+dNQq5t3UXYbKYpl?=
 =?us-ascii?Q?jCdccmiFbkBDOpCGGgppJn/2TOgLk/IUqmSbP7DVxu6u/+BThd/k7RHC7Bjm?=
 =?us-ascii?Q?+/z+m9ChR+Ktrp6wjaUuJTERVw47wRaLpgNbde61VltBfskhpHwpCM6lJzha?=
 =?us-ascii?Q?agntjoxcvSJAueWxPLB9U5I9q48Jo/APwbQiv7tPtFkDjCsJAGDG6CdQV+fs?=
 =?us-ascii?Q?RzZEwnmAt+UDfK3MSqeFOxoje73zCp+ekPVW6bV6KshZ6+8dAkV+gvuw8JFQ?=
 =?us-ascii?Q?OaPm4oHC2kufkPxCGoHBqzsLAaHWZsbHUPYEW8ITW5OMxcviVCtHwHA+snZs?=
 =?us-ascii?Q?l30KiSBZ/gubaxibvvnULQzlnwn+1zl3cu0P0d2SboHLEyI7qHOzUpqw+PRi?=
 =?us-ascii?Q?S+Zn1G7Xdf7xpzNnzyjQ7SGJrY2ObfnrLa+QcioPAT5u71hFWvfZ5CE1KvY4?=
 =?us-ascii?Q?F8aqnZ8Ehg/hgVKk+6xWG9z1Q6Dp0IqpClilATop3UtQCC2A6nLj9DvFebLI?=
 =?us-ascii?Q?usnxcTkwxTP7ThXphfrEYztAIaApzRiJCs/fPlvFzugdYOGm3Gl2luJe98zW?=
 =?us-ascii?Q?MImCyvNNljDzL7ukoIAEOvy5lyLjyIGaGw4uk2sRgcfsJy+1m8VwMS5kBPxl?=
 =?us-ascii?Q?lzCYB168AVXOay2gl3TQtz6mr3illcd+iDnH/DJ20Ht46wPqEONFUL06rZJT?=
 =?us-ascii?Q?SESm0ADc+RgTsXpdFQcttvevlmcfO/8+k3GchuAziNcufKyhMAV++0hA4YC4?=
X-MS-Exchange-AntiSpam-MessageData-1: AD8ZnYWi0dU+Gi0srmrpbUQKWEeRy4qwf9k=
X-Exchange-RoutingPolicyChecked:
	PvbgwbaqD0uCVdi0fInMETS20KVLzULAyGu5J2VS7b2Mp2C1uZFlILrPUVMErPU/uhi14bi7nJFrp0DZL970+O79k+nbnbD/e6HUhsHUFsdAxTkWZp7QF/2/KSLZOHUIVaJzmaDwjHH527A2LyS5fv7g9Fh5hvb6ekpi39Q/YAE+C/5mds5DmHw6aXjsjnwX7XnvmYmp2iBt7zXr227MsgckFrxSii2f0H+x3TYX/0qCS3qdIDgZI+Zg06EyiUb9BE+E+y2W+qPGE1J+/uBiBB0F+3uD1Fyui8Jr56NzTHxzsF9ZzprjX2htVKtzhqDKBCCsHfe+Cf45OyUGrMFYKA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c696da0-c685-4f6d-eef7-08df493813f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:02:11.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZokNPBm9Pk+rD6nRM9v73tfK60MsCZR8PkmZU3yipOElJTPMWltUNe7Zmm8wRhiN4b7e4Ct5XDM/zCCkEb4mo8nvcQYZyUI9S92n6rehygg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX/LhYbWa7GWrF
 7S+cbCbjVlZ3LzN4Prf8hHkJ2DMa56tjt0swzyriB+xA5suPT947fpyZmqJHUV3vExKFXs6TEpy
 g/zA6QDJuSvMhKtDW1mMBNGHtVUqIprNA2wnR0D/2LSl8S3g4o0lJ1vx6puwuuHtDtxnQQe1+uJ
 fcUz6eY7W9c58YDMSlEgXy84IuZombHPcLydasRgZalB4J0zdhA47AzGofQQx61McKGiOj47QQg
 43TTdFGc1DMBy51D7a2IAdTLZ/xkKUxN3Owb+FvOTlPh1pjNcPa1GYCaSxQwMsW81VEfYmwn52s
 k7p+WKqCTQFk/657g1hf0lhgvYADTCvWcgB/6SK2+ULmCgEOLtfNn/E+InHh5xXFH4gvcpqY5Ys
 7yqXqehQemjLhGjxO+fzD4BMqvd3fKYYw+JYGyqDgQCt4zOBycev+wICjAdHCDHS7FrjeNa1dhn
 brIf/gcx1Wd0KcvUZrA==
X-Proofpoint-GUID: KInEPlHei1MqXhxlvaouM3rFCC6JNzam
X-Authority-Analysis: v=2.4 cv=I8Hw19gg c=1 sm=1 tr=0 ts=6b03f309 cx=c_pps
 a=WTYiPbwPEgbs67/cDcbz6g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=ktL5Xi3Faad82JckwtQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfXzERsIm1igvFy
 3oryKGbaj9Jnx+Tcyf+BS1Kb3odXgf8HYCJVSVJPindivwxkZMvMpoOuKDJeH/iz6QNTPr0VOmq
 /GMOw0fwMoikXb4zGUV2UgJrL4wYDlnQFdL7dxNwl8fwNo2i5FNY
X-Proofpoint-ORIG-GUID: KInEPlHei1MqXhxlvaouM3rFCC6JNzam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230031

When the Ceph daemons become unreachable for a long time (seen during
Rook-Ceph rolling upgrades with active CephFS I/O), the kernel client
leaves sync(2) and syncfs(2) stuck in an unkillable D state, keeps
backing off on a purely local connect() error, and can miss the mdsmap
update that carries the new MDS address.

  1    libceph: fixed 100ms retry instead of exponential backoff when
       connect() fails locally with EADDRNOTAVAIL
  2-3  make the sync(2)/syncfs(2) waits in ceph_mdsc_sync() and
       ceph_osdc_sync() killable
  4    request a full mdsmap when an MDS keeps faulting or a session
       goes HUNG
  5    don't escalate the monitor hunt backoff on EADDRNOTAVAIL

Changes since v2 (thanks, Alex):
- 2/7 and 3/7 no longer bound the waits by mount_timeout, because
  sync(2) ignores the ->sync_fs() return value and would return with
  metadata still unsafe.  The waits are now killable instead: an
  un-killed sync still waits for everything, the task can be killed,
  and the hung task detector no longer fires.  The wait_caps_flush()
  diagnostic loop is kept.
- Dropped "ceph: bound the safe-completion wait in
  ceph_lock_wait_for_completion()".  That wait is already killable
  upstream, and a timeout can return before a lock grant is installed
  locally.
- Dropped "ceph: set default timeout for MDS requests" (Slava's
  Reviewed-by goes with it).  ceph_mdsc_wait_request() has been
  killable since aa91647c898d ("ceph: make mds requests killable, not
  interruptible"), so it doesn't trigger the hung task detector.  A
  default timeout would only turn MDS outages into -ETIMEDOUT for
  applications, and for file locks (the interrupt request as well as
  non-blocking F_SETLK) it can leave a lock granted on the MDS but not
  installed locally.
- Rebased on next-20261120.

Built with W=1 and sparse, and bisected build by build.  Not run
against a live cluster.

I used an LLM to help rebase the series, review the code and draft
the changelogs.  I have reviewed every change and take responsibility
for it.

v2: https://lore.kernel.org/all/20261120073431.53636-1-ionut.nechita@windriver.com/
v1: https://lore.kernel.org/all/20260312081619.40854-1-ionut.nechita@windriver.com/

Ionut Nechita (5):
  libceph: don't back off exponentially on EADDRNOTAVAIL
  ceph: make the ceph_mdsc_sync() waits killable
  ceph: make the ceph_osdc_sync() wait killable
  ceph: request a full mdsmap when an MDS stays unreachable
  libceph: don't escalate monitor hunt backoff on EADDRNOTAVAIL

 fs/ceph/mds_client.c            | 85 +++++++++++++++++++++++++++++----
 fs/ceph/mds_client.h            |  4 +-
 fs/ceph/super.c                 |  9 ++--
 include/linux/ceph/messenger.h  |  7 +++
 include/linux/ceph/osd_client.h |  2 +-
 net/ceph/messenger.c            | 15 ++++--
 net/ceph/mon_client.c           |  8 ++++
 net/ceph/osd_client.c           |  9 +++-
 8 files changed, 119 insertions(+), 20 deletions(-)


base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
-- 
2.56.0

