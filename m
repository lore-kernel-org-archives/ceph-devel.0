Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160132;
	b=nnCcjOjJAe9kFks0cEF8Wx6TxjgkY9heXT8hyV0QfFc6sivmQrwdEvkQAoq+UoxKNVW4
	 8lKX5NfQNSLiSDMoN6gVr+5HfgJ9lv6m+KR2rWG/b3WL/EPXBXTpcNE4FaJitTIMQQJJ+
	 c5xPRiIuLCrkKD6YusKCusAKyurXHnayMpBDGl9zFvGcU3roH6F7xW4Yz5N3wlZhrwKkf
	 YBI9e3JH/cvl96lKx+IFSVbJiprw8g1ozCMX/gxTyxyPd2ru/IsNYTj4ZYPMM85YFX/8K
	 2oHYYHDnKF2v297vlf7VtIxlz31h63jiBtk5zpkpgXpjGVdPLCq8MVsBqyD5TY2YHOA==
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5lK6B0XsyKNhMWAufpuoXeRSWrFLPFkgn1ShuVei69Y=;
	b=XC1yqEkmdeBFmj9k/cyrWHfhsrEuAIl+clQ20uAaW95Oo3OCh4p7bjfJRcU670XTJtBA
	 kZZcoxRO+TQDpqCYA5tLwbs8f7XB3IMwOG/YGUNscuzmEKm4NFfs4FU6jHp1OixLraC8K
	 jIOMJ+mcXO1RPqTSCaaeb4L+WwlkMZCqMeC9uiw4R1MW7dRV+rL+OiDHNehN89nwXRQr5
	 b2Tns9zWDn8jJMklfqRdyBg2PK1Dl2paHSCifT+6sD7SfEVPNOrMee3fYxeTTfdJTBc+8
	 lAyv+pu4NQcmT/IgT58ZlbT+ugyD2RyWkr9L/p1e6hnm8urPuROYRqvoBiVATFBECfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b="n53E6kM/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEE606A330;
	Fri, 20 Nov 2026 07:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86DEE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=n53E6kM/
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3TRQf245230;
	Fri, 20 Nov 2026 07:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=5lK6B0XsyKNhMWAufpuoXeRSWrFLPFkgn1ShuVei69Y=; b=
	n53E6kM/VOvy9NJ7U/qUav8LmW9nJriwDyS08u2z9GvDcj9mCuqIWnBlf6OSOZYM
	NurEFYTF8NSUuFsf+dd/rjkUpJMmg8bJvnBbfrftMAy4f/LdRlM7LIAk/WKnI8N/
	bIDzt4N99NBPDdgphD8eK3WAMlrRH0Lsh9he4PgA8JBirQP3pXznx1HANnxdswut
	LtiBD2NlexrT4ltsw6ne8HSuoaQ8/3xdbUvtkh9gQViFSE3NFIkVSTbTfcidsc58
	CFurvwXAUrP0ispIDwR5+H40Xa0MZkH0sgjfPH3An9aSRa6AT19WI125A5qui2VO
	RZ+8kN1Vke/dq8ogmTbHig==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022131.outbound.protection.outlook.com [52.101.53.131])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvh8b27-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:35:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jkgz1wqKKdNm4ha3BXsQsDk3amjxqa7FcoDzz0TrYlXxcUm1Sbj2ebmUD6c/ROVtoIDDdAjq+quFAWNcln483LyY1LYmghZ6MaazpmlWuXfL3517+USOE73CmrbYeCRJSV4KQBaul3Wr1RLFSLvaAkcMVM9/nuZKAdiMJiNBmFvv/FRdnqeFzyk4b6XHmG16bcPosqXJqj/YqFSpHL/Dasl8/ISkeM/PevjFzaSLRIcnorLAwScabhkUHU6nGsn7d2BcTPkR/8nSz9tnswxKnH7vxT1horPAF5XAkHval6XiEBzzIgACqQ4jhpuPUPnfHMtxHY6mdEvWCo0yPNI5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lK6B0XsyKNhMWAufpuoXeRSWrFLPFkgn1ShuVei69Y=;
 b=Gsvglg+0OtbuRASecvL+x1GLGDKEif+aq3MLkutFTYC5xo2Fgv66t3xN3Khkq3RbJNDn3PdbYCIgU2bsO3mIQWp31rGp4aS3LWZBD3abd9faGzlvuiL3LQZn9t4ONZkEvAMxVbthkUCCuXDSeR27AnaZYkRLmgpIYIaAcnf0kAQrnPp0b1yhJjXm9kKE83KawAPrDZsSChXlfFqYOBncAU6NX8hepw2q8t4oDCKI2gUvMVxbt5QsktjCfW02loyu8nGsQrhEKdkTwdRQMjXzbMKrpnYAKAZxDEicvTLwey1OyCkXB+e+zwE6ZAJ12Wt49vOI9byg9GHTTP9HMoOarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DSWPR11MB9821.namprd11.prod.outlook.com (2603:10b6:8:4e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:35:04 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:35:04 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>,
        linux-kernel@vger.kernel.org,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v2 5/7] ceph: set default timeout for MDS requests
Date: Fri, 20 Nov 2026 09:34:21 +0200
Message-ID: <20261120073431.53636-6-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DSWPR11MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c710b0-3e69-407a-9017-08df46d8cad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|52116014|366016|1800799024|261022105027099003|10067099003|261022075727099003|11063799006|56012099006|261009223027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g7cwvHogJAD4EJA8VoYAIDunv5JBSq3R2k0XfgBxQ0MNtZgq6KXTVveSGrca06hbBcsIwu972WXHIUXk62fTHEwb4l1qCsJl6sYXMeL+AmcIiN6agrjTQqjohvnK+grW2bp9duKa/K1hulYEU+XsaDdG6ormPVRBd6ONwCkq37wYvSvDXbXDf3IOnOrN4PBSPQBR02MpYS9m+0JEp9glCAj6UADFBOaYkhwXcZL8MISVDk85jvMPA6BMRe/VTnTGHbqrIIQsaztpEWYH5iyugNtHwc+Nv2fOK08DYze7j4CUyDGK7DL5wPY7tNpAqWt40FQPQ+KyFYfFr9viHpwlKxU5idpYs+urW2yAvXFZRfHMJXUO3juGHUPaJXEAyVIjzOAtqra+2FmPzNgrkxUKQWc9Gm9r2oAaDa5hIA06julneFILaNOGkoKXtDW7xf932kmqm1OmB09ZuK8HJuV2IiEVmTkZ+UzSR9NOjeAV2JROcB4Adya5b45cY/1ieDHF09yGsYlw0bJFIqqEOmSLgUf0AdZ0/X2D1kbpCgwF64cklbXS6FtCqOWAkYgadaiZwiqqTcw1LzuKEwzboO2rj03NhFC/PieOL01xyuapWCPt+ZSlfUVOIBdvluXCW5fhAkWMkdzItNCyN+ZFXDqkJtiF6u2aNq0aM7JyLjAWXWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(52116014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZT3VnUiTD9iD9oPXZtUXsnwIEMmIxG66XuFcv9vV8/bwPYipZC1SMB3LlyKc?=
 =?us-ascii?Q?VklBuOPtEFSiP6mrmWe7lpJmZJBkxegJCmXmyT2lznustCICLfrfOqBlPByx?=
 =?us-ascii?Q?FxcvesCFfkJO9VQ1YOvKju9mfMvNzcS/bpAtg6iktVp36w0ilI6Tr2EVabOh?=
 =?us-ascii?Q?XKTJsdu49CA3++tC18VffkzC965s0o/tNUWKkwYnMJt2TDCNOprnbty1ozaJ?=
 =?us-ascii?Q?mCSQjt7L1YsHyzQ2e5vNps/SVpDKpOU83S3Ru3+HnDqq2E7lIRvx898Rxl8p?=
 =?us-ascii?Q?G/jx68gvLaD12nSAevETtxyB4awow3qofzy2eOg8OhCNRayrFmY9Qm7NLXGs?=
 =?us-ascii?Q?m28ucHKp1Y+queYaV9JaKBLcRSAMfvX2z+CZrS8YIv7pPKctqrFYsuwI+26J?=
 =?us-ascii?Q?VT2Z1eLu4PDNznF8/z68asDiutCTCvP3xSeLLXesCzmI/oDlKZ8QHoQZiiH6?=
 =?us-ascii?Q?1KpDFXilV1XjM5J7O3N+qvDC8q9CXWcwTHiL9pXSNz/E5bkb5IzJ3o7Bn+99?=
 =?us-ascii?Q?M/qByD2nbUHGyCkDm3HVPEm/XTqVAKZotn9aiQIfc4RjjcRyEkbHwIv8dPRu?=
 =?us-ascii?Q?Vdn4wOaxxRs3VnZqHMcOm0GgNpPKIvPAXWfHEwkdtYZQ0TcfyYoUOnP1dXt7?=
 =?us-ascii?Q?30MOZbB7ApmDDg8NPcPt86jmWXehFEIFqF5aV2eqqtVQKKWAuIrpeYiNPeuJ?=
 =?us-ascii?Q?w08i6mdJwMdT1JQucuucMgDqWYFfGWDArlC+vo2NjVDadNJBmYZ7QKOFBt9N?=
 =?us-ascii?Q?SiALaX3k6aTvhuoOzjgFk16iIUU0yxeP32EC+dNEvVWrmOyg8O75yIIrZogI?=
 =?us-ascii?Q?ZALnbwWgBsEE9GEeb8tPG3o8QasoLJC7//7yt2+mLc1airLHPq+RydUR7J2E?=
 =?us-ascii?Q?yK8lkcXGLiShIgc3SSq2Si3rtnX18VJXTmsq1vFw6+Qjjucz9c0bEZdkkK5e?=
 =?us-ascii?Q?bvX3cL4L7v+FEPDQs3ajApzy+XlY2SA9+NwHFVhXNBFOv683WLvdzYjuCrAi?=
 =?us-ascii?Q?F9j19SymTfty++qYv4C4dOEJhQvDdT8ODcT51SmZRpPz4ZNewfyI7F95rV+B?=
 =?us-ascii?Q?rUtG/o+MSG6V6paYAYyjNmK5WJjTy2kyBI+pkixR90GTnQZcAS4idvtxgZKX?=
 =?us-ascii?Q?BcByuSRoVGwR2sp9Hiazo0IEU/53iIM5+E9lJYxBNbTa1JznGQwraDBk8MxA?=
 =?us-ascii?Q?+4HychNtUHR65x0BQW8w2T3QI+TUX8vUZLNfSa8iX0UI6i02unHCvJQf4Mh1?=
 =?us-ascii?Q?QRg6/qnyyq5jqK9nXEL4fDmeSxm4cy/igzsIeBJ8tSJpJ7QwUdi89BMAA24E?=
 =?us-ascii?Q?osAvVul4GhysXu/hRf/Tbr05bUIRg9BnG80OnCB1wbMgZxn939l80/ATIGoD?=
 =?us-ascii?Q?ncqndXK1FxnJwfBU9nwKZgReQcTfZu31KrGUvyKwtn5FhQIpsYqAXzYpJQh+?=
 =?us-ascii?Q?FhnHgCG4wrJGrrEbAgUaq8a9bzwHVWKaHQudH03ywMzBpX+yEbTW0i0ZZeT4?=
 =?us-ascii?Q?Nh6oQwgVBjBIfmz0bevYnPGwf/9VBJVwMVwLGQE8NOgdRJxwA5tkwSSjX4+T?=
 =?us-ascii?Q?TxjhYB1SwlsnmH8tnYVs3p/+/R9A6htL9wzvPEQsI3zFrMSQKC0lBNauTdCM?=
 =?us-ascii?Q?dlut5E3frOim4sb8cnipcam+KtcfP3uHBaPnmNp1Oft1dvCHahH9bD+XPwCM?=
 =?us-ascii?Q?j33rN1pmVKrt82PsptFmcjK9rsB3FtlFb6D8Gtxz06NPlQHy4apPZM0ttGfD?=
 =?us-ascii?Q?K01aS6l+SwoTVGCwwwDN2A0qUoQOblhQ3PCC4R7lKyvsnlJF2SQENCwhW3u4?=
X-MS-Exchange-AntiSpam-MessageData-1: qbGv68yB/fH1Pl6Trezr1uggPpfCJdajd+I=
X-Exchange-RoutingPolicyChecked:
	bz6tg/LKCMXTzOrIvFebfqdZkSlDNVo+I78S+KDuFbh2bp+LsIvagI/oNqsPUTdWY6nx47Vtbr/smAwwxD9AnMa4e64bR8uzpcJ6JrXOGVQBWjS/oWtms81EXG0z7744nuld4je+w7+XEj28tzdw2Yw1Alldh8xoyIDKH5Xtw30ta0AFRaI/eei3gapzwtMIq0zMbVsP3JEtqoGhu0BCDGkmz/ba4A6OI076DUxU95yMUH+JMg70oCJicu9iTBaEcGYuCX3FGKtwSibkrzpTAM2K0KUnoZfUd+sB/M3IlSV2lmFuE1mSb2BI+V7h2mbmTIk6lW1R5hn50qeh9CYlrQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c710b0-3e69-407a-9017-08df46d8cad3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:35:04.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/2yTBnlmIX9JFOJF7SzTPTYuqMJqbg3/Qc4XDgT3Uo74L3pmH3ryK79wn5fGNmIDcaBcw058i7Ifjvqvr3zb6MeRs/YmBkgqkUrfSTTLpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9821
X-Proofpoint-GUID: yQ6q2t8zOAJ7es0F87LVSCT-z91FPuj7
X-Proofpoint-ORIG-GUID: yQ6q2t8zOAJ7es0F87LVSCT-z91FPuj7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX9Br+ea0bmv8w
 t5ykfBEiAWNnRETskvpruSOFgQR1XxMfQs/q1UqqsseKcxqb5VYWtx+ThAoMY6oHFd2XQZIChsN
 ig7k3qe9uLpjwjY8uj20uGarQQHIHCsq+7bqbJx6cuAfPUth/hSqn6AtllmRQK8jdQeKTLtmCGf
 9YbeNbouPlvRJ3L5NYWoJ1Uh1+t9MO7jXo6FFWLR5QnjhjcN+rq3J3/xdr7saBBpDJfKVWORxgw
 /f+Uf4OPWN3XrWDLUNvpLZ+FSy9iRM1RBAz/to+lYO2lFcVjEHsAC4jqJjNlWB2N/T0zECgn+sV
 xj+YnOUpSsidHUyzWNbzHxJN5w8hYyAxjpCrSGBMeX2J1hw+rxHODV6faMAHeWrRGyhDd51u7Oi
 g+IJjn1vzLFv3qxav2BPdLB37WVyGsm7hVZ81YkBqupjXDtD2ZvA9CyXam9bebMAqk3itkDNw8P
 +XOwdTAkXtnuJQltJEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXxM+5m3dDmEXZ
 3nfpWq6JJn7XnswKfI/Dl2RDoolF/r8BZW5pcu5aeeeJABvBrIE4mum5x3qRzQCZS3fo/I7dpf5
 Y4ypF+M3FK48AzKd6BrOtSDuws2BDrnB8bTT+tpgDp3+gowZiI5j
X-Authority-Analysis: v=2.4 cv=GNCdgeNK c=1 sm=1 tr=0 ts=6afff829 cx=c_pps
 a=6tOaaN1fXmJE/LdyR88bKQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=VnNF1IyMAAAA:8 a=1mtySyPCZUFLoRT_7_oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

MDS requests created via ceph_mdsc_create_request() have r_timeout
initialized to 0 (from kmem_cache_zalloc). When r_timeout is 0,
ceph_timeout_jiffies() returns MAX_SCHEDULE_TIMEOUT, causing
ceph_mdsc_wait_request() to wait indefinitely.

This causes hung task warnings when MDS becomes unavailable during
operations like setattr or truncate:

  INFO: task dd:12345 blocked for more than 122 seconds.
  Call Trace:
    ceph_mdsc_wait_request+0x...
    ceph_mdsc_do_request+0x...
    __ceph_setattr+0x...

Only the mount path in super.c explicitly sets r_timeout to
mount_timeout. All other MDS requests (setattr, lookup, mkdir,
etc.) use the default 0 value, making them wait forever.

Fix this by initializing r_timeout to mount_timeout in
ceph_mdsc_create_request(). This ensures all MDS requests have
a reasonable timeout and will fail with -ETIMEDOUT rather than
hanging indefinitely.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/mds_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d02fe1e34527b..4460f614050e4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2852,6 +2852,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	mutex_init(&req->r_fill_mutex);
 	req->r_mdsc = mdsc;
 	req->r_started = jiffies;
+	req->r_timeout = mdsc->fsc->client->options->mount_timeout;
 	req->r_start_latency = ktime_get();
 	req->r_resend_mds = -1;
 	INIT_LIST_HEAD(&req->r_unsafe_dir_item);
-- 
2.56.0

