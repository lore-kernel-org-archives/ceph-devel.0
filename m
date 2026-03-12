Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081437F74F;
	Thu, 12 Mar 2026 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303423; cv=fail; b=ixDAueM1n9Jti7jwOn3s6fyfjD0mNaBnqoucweE0MBXyeuW60/LLpktnNDlFdLqXOF/qc7lBg53Tfc9eu9W6XdvQ3Im9F18BCVTj8Wcg8oIInC/Mn1So5CK/0ilhH55+IA2i2xDvN/wrBsNNkYV5Xpwbe51qorBJJXsGAyttDYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303423; c=relaxed/simple;
	bh=4JI9qtEv8FUYfrOxbMoNw7CZcsTx92o7v2gytvnrVOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iAbllQOEzR38YkNimMOTJslQVbOhyUqItzjW/bJDWqGp9hTJpBvXrsbt2P4VzxmjxirHu6f1KuJs1gqSxnag/Y3+cF5Qnqdt/87hNutlRYySCm5UZSoF3RmKUCLkUGSuGyFH29/+9QM7tKuvox4B8i6620bo2JL4L3RtiQUdlBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ql+edXe+; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ql+edXe+"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C70YDG3197163;
	Thu, 12 Mar 2026 08:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=zhVlJAbfwhE+qpn75gL9J9InjOvGatlFGIigfFFysas=; b=
	ql+edXe+Wgf9D7qWgRieyPlwoP1orDqzfPFKpgSpM7goJKfDUO/PZwAeWF2iVZnj
	0hz3dTnx/lppsyKGW7vWI6UBlbfAyXFVe/f09W6xHJAKHPCM41/BoSLaXaI+4rho
	nXmnyK/pBZKfCQh/yfU1pIOJl/W9Vxjnf6f8s8YLGir9rKAPpkKxPMD0wsH5H8z1
	fyi/qQg6kBCTC5dXQTIjFSRZGLssoj2LkT7lolRf2ydY3ng1/am6bj1PFu2DHBjA
	iQLnWGQk6IHxrJxcA7WvWLR+Dr7JKVck6icMGFImP7KG7oqom230mlHC49a1dVYv
	wTe5+CM9QErN4tGo7Kw4+w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78gdw2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:16:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWCgp2kOWZrzKOYBA1DEpunbNF0r7CwCuTkf/sKD1GwdS1Ew2O2RTkiUWmOR9JuupAnLlxFN8FtJqGe4y4bHqjVnI5lcWJDgpdGnMOjdaKF9t9p96/+i/FhxN7S5N2OFHrFlglZ7fgSN8ZiJsuz7jE2irdRaX4AwYKkZlQSOFfa9Krb8dBSzYlEh5LwjJkuf7XtLOFjzDu8k1JEb6WBpruyVjgMxYuJ4yJwg+cHP2xBB9obUXkgB7iRvjRHAX+s7dsgk8Wm5Al2zwWo24nARtgkaxnkwxNWxDQbdzBf+9kyA60thRe/dfFysteD6Eqa1/9xYu3X0P3A6/d3D1W2Xbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhVlJAbfwhE+qpn75gL9J9InjOvGatlFGIigfFFysas=;
 b=ZT2uvTx4BpdTqnjJeG7Ojh66Z2ouRE313Ay1irDLPzw2ySGqtCHjt3BSCDLlqvx9C9E57kjdmYaKlWccwCCDkDi6HQJOglhSJfux4pt6A0Wqqbnei5I4ZtRdBXLvpilijoDdksHCVie0i4jemFU6uPvzNr7ku5gU6X6t3U59FgyZleK8gP/9g/ip0LtHwMxGJi7OZh5Tomcs/DHiR7e0jbX8nsxnmJREkf0/N3pnfNmdkkj1Pko/SFrwhtyBIYXGsLT2iGkazOcNQ8CYGFSIoCq1zK7zHdUcpAL8gfCcEGKlNN9TRfFvkmTLqcVYz2B+WtAJ4IsRZ6qyqqXZNkIHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:54 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:54 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 08/13] ceph: make ceph_start_io_write() killable
Date: Thu, 12 Mar 2026 10:16:14 +0200
Message-ID: <20260312081619.40854-9-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312081619.40854-1-ionut.nechita@windriver.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c34a40e-73e7-46b8-95fc-08de800fb852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jgAvy3h4lolqf7pJ5c+MyO/6Ld7h5FcFCQr/mYIM9nQsEEdP09hK3PliqEDEsNUL5jtdyVSwzf1WrcCJhz24Ce9+TttvwVeHoaGlpM+oVq+wourneIiML3Yr+0jlKwuCZJJeW9sDLNRQBy1SrubEeZ55XeObfCAdimYUN6UPSI3qvpGa2tuChUbGJ48pm/nJ01x+4sPoNQNv8DkZ8vNuKTAGXAXARZd2GA8zOh+gA8A5tmyn9Ak/Snlc6MxspZYNT4ZzXCso33Yb5EaQS8irg8PzYw1uYiUxoDlsNHKqusDt2XmM3ABYrzpzIqs669BHr0Ukh2qsAqy7GalRsLLFtz6wsvZDcIWPeI6Tbp65U2Rn9dNe/MHjaqud3cObNXFt41fZ/a+YEQ4OCTNiyuCmcX5j7pSB2aa2wz8GU/6ilatpp38Ymk1QiHIsGdo/RsmqiJKc6+suvdASgSbw94MKh7EqxKIu0e7xF0c5lX0kclRPV9D6HVxVBs46H6VqWeBpzviXqn4n6Og8OU20YAb8xjhd1xx5sdR/3Ci5KU9RiUUIA+PqyaA0QiSW7o/jV3Im0G0u0jeL+7z4P9/yPUD0PBDrUAh0+O7FD9JC8MJyzQAKJxGH7r1GvoWVFr7MWGQoMjsEqzZiG0YLimd0EbrIubdV5tNe0NZMZeXrG+mdRbZ8dIPZrHMKsJaQs6gZsF7TmOP1OxmBXSmu9o0OmLQJWxJZDwbqXWRjPrL5DXPNpKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DpqRSa6QMltuQIIK7J+bQSIo9eKr+Ger5ItNF8HwkyRXpDWAF/XSCMyztlz?=
 =?us-ascii?Q?M3jHj0VshHiiTQLemWJYLx8B27Hc8V0O9GDtB37nTv0tBnK/6/evDOX+W2fN?=
 =?us-ascii?Q?Ox/7bfFhLqmLmT1Oa7SAXmTHETvViHFmXp3bXPm7GTjMBlWR84hctBucNJD5?=
 =?us-ascii?Q?R8DS2Fg3hoBDGN3MLXC1bSx5eOrEO0nSP160puwkDHu6lMK7q5oLsH48YwmO?=
 =?us-ascii?Q?0dNUqMZCdxZ5niAAbv1gsLVD0VfO1Yq3iI5CA9ovFY4fxUmAMlBCt++v2fzF?=
 =?us-ascii?Q?rtFB7ndzo2CKx+5Tr6x/g2Mv5+pIJ1wcbAlQNjIS2/1WR/4JC2bsDf1s2iHN?=
 =?us-ascii?Q?PMljamRT5p053iiOHyTUhzQzzvCrhbRu/XLUoThuoLAoIymdwuwUI1GSuMJV?=
 =?us-ascii?Q?bujgIH/DQ8/0+5x85N2etEw/9ofYfx0KwIfteAoPtC8PHkU4xE+XFKRMqUR5?=
 =?us-ascii?Q?60wkU8uc/FkWwqfSz+BkbR1zeWZ6oAhsvFY0lN0mGY9BwEzXC+uP95bhsASM?=
 =?us-ascii?Q?FKTDTxTB17hme3KvKeZRJocT1LqloYfGyPxtkT/ZF8CWf+3IEuiqSO08aVZF?=
 =?us-ascii?Q?MZS1Vkpskq/zXUkRc0fLvmz3AKu5L/sFtDw0L35bKF1vhp2wztUJKa3+qKBX?=
 =?us-ascii?Q?v8vMtE/kmf+vwAATd7NqJKvpgMBXRYrbj4gGSGxhkPn3oyWsDnbf14F5cRkF?=
 =?us-ascii?Q?wR5lm5My1Bi6kcFixqcP/tNA30K1ZSk3VnYw5EKiDSileuX0XrOXioiw8q6Q?=
 =?us-ascii?Q?Uf/xDVaBVgOQO3F44jigksr7poaNL3v2Ok/W6PXScGSGW99xo2U9gic3Xpoh?=
 =?us-ascii?Q?n8UOSrkteC1I89h31B4C7gotLYIjR+4JpZSwWk2a7yD5lRdhdKsql+RmifIg?=
 =?us-ascii?Q?fNoNpS2jJqzH/MZWamH3QtABEilzgRWQha65Lfe3Wy5N7tflgAxXt/u6aGz7?=
 =?us-ascii?Q?WTDGWFRrKjOxzvfeNVq1A9nWBk/0St5askoPsGxW3o7Zi2x+kD97G22tfF95?=
 =?us-ascii?Q?+R9Zz1qGFXuHMCTAdsbJ9/V7OmyDNF4Y7YBjjuPP19cH2LpY4lSqMPGd+oJO?=
 =?us-ascii?Q?oHob3FzZxD4+2d00vzoxq0z6/neJajbnYSAf8U4cswsDK4Y+lmljHjBNkr5j?=
 =?us-ascii?Q?5AlEMQtLJLCxwEueqcfEeqq+GNUxfQ+4Ty/++ewkJ7C4tBVOZwyzoMr5255j?=
 =?us-ascii?Q?vw8Fdr+4XnxJ3nIIsdnoClNspM4EG4Q+USYmS8jsq2R6fxE2UyC3Rre2ykvY?=
 =?us-ascii?Q?jpTbrViJTIqakrDyBMF4UE8LbkM+Y71cveRadUEPQtmcaAT+Uym8W7+nEn9h?=
 =?us-ascii?Q?69fzozID+kCG/oQ0JRtv8xJVh4EEV/EHpTxImTF9em7PKQIP3Vwdv4HTqKZL?=
 =?us-ascii?Q?naz/DQ2JrMr2SL8VxXecRqAdjLtXr/y/fM0pt/OfijbReO48Yccqm1UU3joc?=
 =?us-ascii?Q?jqzTtIzeqxF8waQ4fxVDXe/z6tm9gf31Ov1KK0sqodTinsVMm2/+lCtfBxeq?=
 =?us-ascii?Q?tyjkObkqP2GyYxp8IN2PmF6ydTZB7eqnj+PN6mhSY4GdGE6RVKtb9Qy/H7Ea?=
 =?us-ascii?Q?nBrSOOTe4tph1TL3HdPduSIu1+XgfyDvcub47DsYC5CuXfWs9Jeg8gGjpMO9?=
 =?us-ascii?Q?DTZPQ11ciJR5I2VzabCW7ndh2EQnloy2bu6qafR8H/4rxZpMYBCzDCNRIQSp?=
 =?us-ascii?Q?JPQhDWSGCzXEXFT01qZvrMyVtGPaoqqz6FGxaDHw4CdqnXX6FXeYma93sYik?=
 =?us-ascii?Q?8CkkyJwhI3G6Kcl943sK3yN+oYKoqWEYIkZmBPPsa7uP3ExxXwersOSg6abL?=
X-MS-Exchange-AntiSpam-MessageData-1: /BADkpRI40s+KEt7dU9ESlg9a/+FyVZN9GA=
X-Exchange-RoutingPolicyChecked:
	P2YSuD9Pjhz++GM4TuWaGwIzLVHJuBNwHz8lAt2vvkW7dpImZLcNHq9yQ1ASwg7rC397DJw43pvFCIiG12EbIUnwSgmtTVUTlGtiIHtLK2l73qm9fO7e/+GeifZzxgwaT0Llg+ARFRFPtJXdZaeZyuHgMgBJI3AphS2fKSOBqvNRMfmlZ4dLKnPADSqFkQmJ+8lfRolTmmCyUjtLLmNIKm1NvCShRLsAtphBH0XRcByXShtZjwuGZTS7UX+Z2/lITEMh7T/+0SLLDEPZTVtFQ42MBIaoc/BsUesWhr0AsT7X9h/91W3gup98eYYdEfwuIyr0uyjBYWJexLzYKHhrrQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c34a40e-73e7-46b8-95fc-08de800fb852
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:54.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmcVpw3d5hfPlTW8hLpp66x+obn2NPFlgMDzWA58PZuSZQNo6Fg7Agu3+lf6+76sVb44qTZr6h76U56N9FUkQuPXb6p+JSgDm3RftBP+N7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b27677 cx=c_pps
 a=ZfP+Ya0swgQO+W9lSFUZ5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=XuYGRnHiGaKy14c8jA4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX0dQ6uzVGMJNF
 QcD9St3ow+EM0ev+47RV2uEeCxPy9SxDoevAtuGquHexcUQvF+nhBSVxpQYX6nC29IBaYL4yrJZ
 VWpVpq3rzE7qmgzMnk7xgfJuRev6eryQrsD5HJO3PrRHaNabcDaY81AfdLOR0p0363lZ7uTUlzy
 WB+OWGeZNaubZn0h4tdVzAeT+W76Tbu0PNxqgOaBdWXBu7s8qINZ0Mi3LW8KQnRxulEk9ViYk7v
 wrbjyO9kskmnsqPGy93J7RCvtvzNt0eIlG9wdPQt9N8XkzHDwjaxwHUEJCl96B0qnsH1Sqt2JXQ
 96gMrl4ZsM85jHPf8qoTkhTMuIT260jiCC97bEQIIsGMuRdMjSvrhi6doAu8cgaOXS1TVW1Aqiy
 swidq9Pxq7JfmvPkFHutuzWYjjxckEl0MhcCSpulExKhuEs9PT/ZRi/sByLCZ8kROjYPqJx5arp
 Hc8UwrHlwcDyoE0/s9w==
X-Proofpoint-ORIG-GUID: YCUPr6x3p8Vbcw3LfIJPt3mhzUzm1iEX
X-Proofpoint-GUID: YCUPr6x3p8Vbcw3LfIJPt3mhzUzm1iEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

When multiple processes write to the same file and one of them is
blocked waiting for MDS/OSD response (e.g., during MDS failover),
other processes block indefinitely on down_write(&inode->i_rwsem)
in ceph_start_io_write().

This causes hung task warnings:

  INFO: task dd:12345 blocked for more than 122 seconds.
  Call Trace:
    ceph_start_io_write+0x...
    ceph_write_iter+0x...

The i_rwsem is held by a process doing fsync/writeback that is
waiting for MDS or OSD response. Other writers queue up on the
rwsem and block indefinitely.

Fix this by using down_write_killable() instead of down_write().
This allows blocked processes to be killed with SIGKILL, preventing
indefinite hangs. The function now returns an error code that
callers must check.

Update ceph_write_iter() to handle the new error return from
ceph_start_io_write().

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/file.c | 9 +++++++--
 fs/ceph/io.c   | 9 +++++++--
 fs/ceph/io.h   | 2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 6587c2d5af1e0..01e4f31b1f2f3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2359,8 +2359,13 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 retry_snap:
 	if (direct_lock)
 		ceph_start_io_direct(inode);
-	else
-		ceph_start_io_write(inode);
+	else {
+		err = ceph_start_io_write(inode);
+		if (err) {
+			ceph_free_cap_flush(prealloc_cf);
+			return err;
+		}
+	}
 
 	if (iocb->ki_flags & IOCB_APPEND) {
 		err = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
diff --git a/fs/ceph/io.c b/fs/ceph/io.c
index c456509b31c3f..f9ac89ec1d6a1 100644
--- a/fs/ceph/io.c
+++ b/fs/ceph/io.c
@@ -83,11 +83,16 @@ ceph_end_io_read(struct inode *inode)
  * Declare that a buffered write operation is about to start, and ensure
  * that we block all direct I/O.
  */
-void
+int
 ceph_start_io_write(struct inode *inode)
 {
-	down_write(&inode->i_rwsem);
+	int ret;
+
+	ret = down_write_killable(&inode->i_rwsem);
+	if (ret)
+		return ret;
 	ceph_block_o_direct(ceph_inode(inode), inode);
+	return 0;
 }
 
 /**
diff --git a/fs/ceph/io.h b/fs/ceph/io.h
index fa594cd77348a..94ce176df9997 100644
--- a/fs/ceph/io.h
+++ b/fs/ceph/io.h
@@ -4,7 +4,7 @@
 
 void ceph_start_io_read(struct inode *inode);
 void ceph_end_io_read(struct inode *inode);
-void ceph_start_io_write(struct inode *inode);
+int ceph_start_io_write(struct inode *inode);
 void ceph_end_io_write(struct inode *inode);
 void ceph_start_io_direct(struct inode *inode);
 void ceph_end_io_direct(struct inode *inode);
-- 
2.53.0

