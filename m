Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0FD3B7748;
	Fri,  3 Apr 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229068; cv=fail; b=oa66U6E4CdAiV9RHE1jhgboJ2jgN+SepNmEXjG/Qpg73hqLDZ8phm04TCLUTxU+kOoNIqEyDWlakaU8/JX2wC8MAtqdtsl+vMzD7Bwx4344w+yOn33bmk0JYdOj2JRF3eSHsi2KVZlGzQ8PewuWO9bKYXAnMNeP1fZNN02OXfkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229068; c=relaxed/simple;
	bh=asGB7yco2Ow37yUwPzZwf787aG11Gr6Ya2aMAXAfu+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qi7S12Wpb5dgOyuRfy/SXogQyLS+y9+4TsDR+slJr6PtmdDz5O3O+7FBjXb2Oxt3EM17klrWx/izJlqoEbQQBxZW78CbJFpV4j/yKPHrAadhO2ymv5wvK2OZaM/+SBYcjihKOAL8Du7UpQQnVaM6OjNuzEPa07qAlmquBJtOwD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=LyuPf4yj; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="LyuPf4yj"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633EgTB6651777;
	Fri, 3 Apr 2026 15:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=V5huxYTekDMi1z8hCVF9G1ZX4u9vjTcGpIHSHUnq2Dg=; b=
	LyuPf4yj+ytBdAtmxjsSxT55Uuxt95y8exCyEnNncY8GqfPV9b+QjCjCbH/Dq8UU
	rSjLgrLUmrgJRpfI8vpbqCtkcSA8Gj3O+llb2/z2V+hS2i/5qgJauciZbVsHD25N
	OLoertPmmbivExyIPOImvngJTcHH591OrCzY2udAOC3909MxUZubgGRNBa3ox94m
	gzjsgghz7JNlbJU+wSC0OFnqq8jzpbiA7b91KFpGBc0ZTNyy3jnSLycEWpIsiBvl
	wMLJTqQ5mwekW76ozMgU9o41AA8l3GORiaK5w8Ezj7tVSf3o7zTBG+ylBO5+j/Gl
	Rf5LUk/lPtE+izXK3InIQg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4da9u5rac7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 15:05:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaRs0krlsTCuU5Kd+kQJLJJUqNmJD5MDPzX4x9qcHIdAbg3gB22eRKXGuhZFpQGd/hBJiwNBGxzNqtuAexORmAz6CRC2/bSaTQEiddlQQeGoKXDpI+juNalqtjnhCnvC8K/+AhbU7td6vNhES01HpGddEWLoF+Pw7ARTJu/41h7PiE2EIr/J5rS6Fe2BUpgChfitXatRA/YTf3p+3t8Mo9sCIHx5Oxo81xGhOna9BD+JSSPHIrSA8SlP6/k+pAAZ7fR2Ca3NZNMQ0PfS2RHttE4xfjGuWWXbJoehsIhsYc/DRq1lggrC7lcUcqXbp1gArRh3G7WnRF4FGKMNGmp/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5huxYTekDMi1z8hCVF9G1ZX4u9vjTcGpIHSHUnq2Dg=;
 b=oImoqpn6jQ2bx0liJr9w66ecdC3sIgEgxGUEY2Lv9dtuTbZG8H8nTdZyy8/U6eSBH11tOqe+qfvwlP1AstJDhqtlOgRS/wamClAlSJQFjRb4WICuNBqLtKnpndLD6YNr+9Z2SnX5MlBqhb7KLY71E0q7TO95tt/5lwlnQLF8BEZimj1gufK1q4tSpSRW7CJdhAlV0gc5WJAgIvaBm7+uzlLzwQQC0W9SsDfylt7nA8dfSvnR2I/TUP3GVB4sUdjv0Nwk7OizGJuPOKa4hio9STFrfhAeLsZIolf2jZJ2F/o7f5DLtUxbqr5jycnVK5AOmOubdzyVo8lx+9TFW8IlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 3 Apr
 2026 15:05:45 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 15:05:43 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, ionut_n2001@yahoo.com,
        linux-kernel@vger.kernel.org, xiubli@redhat.com
Subject: Re: [PATCH v1 13/13] libceph: force host network namespace for kernel CephFS mounts
Date: Fri,  3 Apr 2026 18:05:21 +0300
Message-ID: <20260403150521.438894-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402170620.575757-1-ionut.nechita@windriver.com>
References: <20260402170620.575757-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0255.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::22) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH0PR11MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 6754642c-eeb0-4840-96f8-08de91927a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|18002099003|38350700014|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hOQPpvSqqxhgG/LMlDd+AnGTMh7omgZbS5plkLj4qsE5OwtoT005I7Crh8Ey/MJjleZBgbmmcB6zWap96GZeZua4o6nm1jgymhbaPAiGaN2z5qN9Ht8cOd+OVgIM/YtbbpUOx98Xncmg4WQDZ8h0YomC9nudkXVkUZ8zgcTdphBIQ8gjf5qasTBIBajxWeaQzLx5A3ecQ3YnBZ252DSSzd9Fs6Ld00oRGQafkV6C+HwBhsOrYXR6y7JG1KIckuiYYREFfNe/UwWFOUbKWMrDEKP6bDlz7pz6RQpFgKrkVy3U4YggGd6SbnAr9y7n5ubo0oB1tPF6gLm9GXVxfKi6Rhe0LmwXmZh2YkjozkR8fpNEDEcBfgIYqwsnRgoULOiD/ttBNZRmlfX5GMQ96fZVeLmH3b9N1eStOG9pDuoiX/7H1OIzfzKac+amS8h2rtUHqdFmmOduumolLv2AONkIwdv5DgV3lb6SJ2bf39/WlzYOTvYuqL9i1DxD/yQy8Z/FT2iEQQ8d33fm9ruqMaTkZCZ+seXezRWNETiXe3QqpLswjo5P8LXdPGOQfc7fiYzpklYQA3c9kbZ+/Hga5C20KPb54sbdWwCVa7/oHJfGLYmzNagNYltCZrIHreRgmjaCoP4phAqrJb/k+VsbbxaXLft2EcfSA+//WQe3BfM5IunwvUbKpMfKSbkYTZ0La1Pyt5XEdAZm6p3MV65Ol6LUBeqdAkFJ6FrMr7Uz2W8sRw2MBdMcH4uQ8/iFzWBJs4AE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(18002099003)(38350700014)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VsoYKaGWe6YzWDPNzOgajAUtXlVvj3umvpPqPRLmN7UEzWpzYqDlpYR2mOoj?=
 =?us-ascii?Q?tyVGrzoRqeFAnZuG8iVUA+RWNg3x+hU7AQNP02gJXTIjhYD68iuz3crKfXrY?=
 =?us-ascii?Q?Mkycix8uHFpT03oYWJylbaCqrUC7oL4KlbhzBgszcQodKa0b5QVMll3wueRD?=
 =?us-ascii?Q?Y0REybJkXdpws6T3hmywfMFvvZj+5k9ZFNc44Z051piJxS30NoCSisCupGJt?=
 =?us-ascii?Q?xUmHVy1591JqytV61Ml/X7M0Y4QGLE7ogA7Zy4Ui3mhUQFVsa+xiYkmrXabs?=
 =?us-ascii?Q?mkEPN8rAJ5ePWGdzSvguQgzLre+CvGQxKQU0D7eBpZbGaxoEGPZY+NnQpJel?=
 =?us-ascii?Q?mGEfcKUOFgtPVMVryRyo8GEOleLGECs9kFERioqG0Z8QMeV9U2ea4Gp0qwo4?=
 =?us-ascii?Q?MW40mp1O8uhpbUW12FMRgntq3Lf85j1KPG9PSHiLPYpcFSisw1V4PwQ1+bBT?=
 =?us-ascii?Q?PKuFmh+VuNKK44vCCuIIb/rr26UvgBNj5mADQPQ1Lg1JeA9vv8kkLP9EugyI?=
 =?us-ascii?Q?uHy48MoylPkAloOYNHwCKBZgGXvCS+XI5R2AmLJ5pY2z+IjJL77BFmDxbR+A?=
 =?us-ascii?Q?mGYFsn5Jrf4UHS8PlIYT6Tom8AlRW4+YlIO+sExG8aiFPoXRSz2NzXHFjNIe?=
 =?us-ascii?Q?jL59qUL0bm3P/9LXXgBJDlVkBzQdEg/lTwMEkfd40QE2aX8dBwXthFFk/oB+?=
 =?us-ascii?Q?jjZ1OQcNz7mTnQsfN+/R/Fh+ZDQqrYS1bCWSs/6LzKzN1IyC4klxX7Fxf3+S?=
 =?us-ascii?Q?1HzHi9+hmzDLnUrZqfBHI8YCpDdLhdG+FNdj31UXaELXdvH5DszKiCNlmtJR?=
 =?us-ascii?Q?VFHNE37ILBObNjg8flZ/+RV9rap3MgIMpqvfoxE6Aa7mPDznJTZTbq1a7Ilg?=
 =?us-ascii?Q?DNOP9w8TggHPr5tebgEU/cDlgS5HZu4pVlOk9pAp+PaZ/CoBWbCpkUqqsc/F?=
 =?us-ascii?Q?cJN/pn45FkZHJtVUHU9FaiMdqd3ZGh++2pEy/wBI2SIFJUExl934niaQEz5C?=
 =?us-ascii?Q?sQIk45qsoEjZGanR6N2f7UxGkZ+IuamXczBxLkQuEwFi4vozOBjOAe8uTp+h?=
 =?us-ascii?Q?tL29Hl9WvY064iNUSdNf/I7JL5s5epxkzelwl+UYtq7peRZd3V0Jnedu+WIw?=
 =?us-ascii?Q?NL/ySuoUkGonfUk8EU+vIU2Ak2kPgbdUNa/O/HkXXEyU+M60k+ppXaoywaDS?=
 =?us-ascii?Q?+tgAtGRIPqY3IeIpHxzK0E/zqvNnGFJAk3wQKE07Saq8lQpDMYDnxd/bT1X/?=
 =?us-ascii?Q?Ub38v1SJXTQ4ctLU0F+SJhaKjKeldmzs83SdPpFdiAR1IDC4MUufC0974ulX?=
 =?us-ascii?Q?2NPW+pcRg+O4rZkq/fOnUNthqBVXEfUvEOohhWO7emnYWSKwwOlrbksXXTul?=
 =?us-ascii?Q?g4BhpzL0RkESYQZb8ZaOSxN2eCrnB+8dLDuFT0ri6poa+CYqoH7LgzhxXJpV?=
 =?us-ascii?Q?IGUkfLFtiJnZvk2v1HE7QItQK3R/X7yf9g3GrAVKxHLauZqX+H3rrMKfIq5E?=
 =?us-ascii?Q?oUBjaodXdMWhIFVnMByPJHYHoyQq075J9BS+Quk9gkPdl5UCu5Igs4vY95tR?=
 =?us-ascii?Q?3oeuZqQS99gdNZhNpQo2P63NRsQZ7H118xLzb9pdlhigXFQnKL5OXA2GapCM?=
 =?us-ascii?Q?q8Dy+j7eCoB8jQxAiQfCQnlz6Dl0m7C4HbueZ6rw6w7HMiaJteDsSjD0nqzt?=
 =?us-ascii?Q?rvf6n5gSB4756oC+5q6opOqM6UwjaUzAogNTQvY3a6qmI9S3gutqEVGntQIr?=
 =?us-ascii?Q?3BawKmaXM1o9tHxMAKnaipBdOa+SRzo=3D?=
X-Exchange-RoutingPolicyChecked:
	CnEmclbM9AS8MeSLhiUjfTjY4wevgXpZXHkd+9tNa+c+sZ9wY9XZa4f7YGo+BhLNfMuLX1aVofCWos90gQHB4RZav/+ZD/RIFKbB5dfGAtq5ZenY570kA7/Nq9wxwf2Di6L28+2jfov+7Z09yIFuZYdvlLR4RkvRN0yTX3sXOPjsqePyVF5npc3QMsrgtLHouHrjazsj7jm1EHSpZKs1KyqgdPmP9H2jWSZgGxwO0dap//k8wZQi+1VMfXuXSuJ7JA96T6ykG5KpuRddzbesxvgmB4R0V01Wh73aWXc6s2CaIGLPkirYFXzO00/yhbf6J+0t6VCRJzj5vbWKIdtA2w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6754642c-eeb0-4840-96f8-08de91927a10
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 15:05:43.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkTlBiruwTTwI0E8bfXh6v7DDIgnjHNSbwvyhscZOK6+lI7wedIuWvfNtvRWD+kzWSp11QmuPgcjquBmGMOu52gSMyUfWvgYQBTFjQrF8KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-Authority-Analysis: v=2.4 cv=duPWylg4 c=1 sm=1 tr=0 ts=69cfd74c cx=c_pps
 a=LBR8CsJoUNkXwF8+XrmcNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=4u6H09k7AAAA:8
 a=FRxtpu_NxJBZ4HbO8DoA:9 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-ORIG-GUID: JzUjUANqvPkQHlvhWH_vSzwNJXVfOHwd
X-Proofpoint-GUID: JzUjUANqvPkQHlvhWH_vSzwNJXVfOHwd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEzNCBTYWx0ZWRfX8EvPbjIhygLy
 WdLDfOp9wb0PMOxQTAKBQe9eRTEj23kkyW9lJNCeFD5762h5kJL/KXhLjQHNJBJutAkk4FKyl0r
 wuxTI738gENP0DN3kUsZLd027Q56jLhTwl457PIl8iXgx5I7gKb2FpBRZgAgnppIkxYpeOy96GH
 l+9B/mQYJ0CmLneJAqbpOHv7+dg9hVV/ufB8VxYFRfD32xv2mxbDFJmPOARj40/APNcl2WWgYLA
 Vp681XI6kByWMVZhA/DMN36E/86OezbUjs7ff77fA3yMYjmzTaJHNolVKq71/1HYnz3hcr5DY+y
 sxsbK+BDvSXBJX/pjfhQ8sZ8H3RF+yshcOQTpTHF+ckyS+iU2GyDrQwgvqJ5v/Mw1KzdnyAm5sz
 0uzoJ2nzejux24KOYyUpA/jM6DpoqVz6OZptMjLRCVSwWckay5yq1MXsYCZXNuTNeTXj/7GAaFA
 KXeE21FMdKkft8kqoPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030134

Hi Ilya,

I've identified the root cause. You were right -- this is an
orchestration issue, not a kernel bug.

The problem is caused by the Rook "holder pod" mechanism in
Rook v1.13.7 (used in our older release). Here is the full picture:

In Rook v1.13.7, when Multus is present or CSI_ENABLE_HOST_NETWORK
is false, Rook deploys a "csi-cephfsplugin-holder" DaemonSet. This
holder pod does NOT have hostNetwork: true -- it runs in a Calico
pod network namespace. Its purpose is to expose its network namespace
via a symlink:

  ln -s /proc/$$/ns/net /var/lib/kubelet/plugins/<driver>/<ns>.net.ns

Ceph-CSI then uses this network namespace when performing kernel
mounts. The holder pod template even has a comment:

  "This pod is not expected to be updated nor restarted unless
   the node reboots."

And uses updateStrategy: OnDelete to prevent rolling updates.

The condition for enabling holder pods (controller.go:206):

  holderEnabled := !csiHostNetworkEnabled || cluster.Spec.Network.IsMultus()

Our cluster uses Calico + Multus, so holderEnabled is always true
regardless of CSI_ENABLE_HOST_NETWORK.

During the upgrade from Rook v1.13.7 to v1.16.6, the new Rook
version sets holderEnabled = false unconditionally and deletes the
holder DaemonSets. When the holder pod is deleted, Calico tears
down the veth interfaces in its network namespace. The kernel ceph
client still holds a reference to that namespace, but it no longer
has any network interfaces or routes, resulting in permanent
EADDRNOTAVAIL (-99).

Evidence from the live reproduction:

  Kernel ceph client status:
    instance: client.74244 (3)[dead:beef::a2bf:c94c:345d:bc6f]:0

  The holder pod on compute-0 had the same address:
    csi-cephfsplugin-holder-rook-ceph-dpnbl  dead:beef::a2bf:c94c:345d:bc6f

  After upgrade, the address ...bc6f is not present in any active
  CNI namespace -- the holder pod was deleted and Calico cleaned up
  the veth.

  dmesg shows the session was initially established successfully
  (at boot time, from the holder pod namespace), then lost when
  the holder pod was destroyed during upgrade:

    [  204.515008] libceph: mon0 session established
    [  959.829581] libceph: mon0 session lost, hunting for new mon
    [  959.829698] libceph: connect error -99  (permanent)

Version details:
  Old release (stx.10): Rook v1.13.7, ceph-csi v3.10.2, Ceph v18.2.2
  New release (stx.11): Rook v1.16.6, ceph-csi v3.13.1, Ceph v18.2.5

The new release (Rook v1.16.6) eliminates holder pods entirely and
performs kernel mounts directly from the csi-cephfsplugin DaemonSet,
which has hostNetwork: true. After the upgrade completes and the
stale mount is cleared (umount -l + kubelet restart), new mounts
work correctly from the host namespace.

So to summarize: this was not a kernel bug. The kernel ceph client
correctly captured the network namespace of the mounting process
(the holder pod), as designed. The problem was that the orchestration
(Rook upgrade) destroyed the holder pod and its network namespace
while the kernel mount was still active.

I'll drop patch 13 from the series as previously agreed. Thank you
for pushing me to investigate this properly.

I've also updated the Ceph tracker:
  https://tracker.ceph.com/issues/74897

Thanks,
Ionut
