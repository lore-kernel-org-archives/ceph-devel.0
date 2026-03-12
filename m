Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C538A72A;
	Thu, 12 Mar 2026 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303426; cv=fail; b=JrnXk5Q1EkqBs0bZ9fwmN1rNatKMhhdMs55wy7e2ActHeyPbU3f0QBHlBwXmbmbRq3tI5q6K7gQrNSXzWxabXBRcN3GBd6P4ySMpvLBzsx/0TcC/oHlMcsVzaFQgrN3xMj8Njd5gmTXlTe1cLa4zRR8NsDFHrIZIU3R7fAQDyI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303426; c=relaxed/simple;
	bh=787lSHR8EbukgEKrHNqjqkMatgxFgftfqqwDu9n+PXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLiJW1qLVB8WjOaa4SxpAZAs43k7SycEYFPhsfirWCG9Ywckj7PWGQ7wT1mIvhs42knYz2SnhtUlpGOqpTx7YA1nVN3b/RO1yqe87BFd9nSBjcps5GwwZ7qm8HXAQLTENuo9hxbeIoXq/6f+cEHOPVMKcyHdC+czLz7eKp3l2sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=fmsHw1bJ; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="fmsHw1bJ"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C7Xgaf3253345;
	Thu, 12 Mar 2026 08:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=3nk4Fo6pDwtGSRwcunzvqVLCCZcjKEuii/3fjPnCl1s=; b=
	fmsHw1bJAa7wo4QGzUkK8AqXE9BrVGcWDELlisyGcC2/7E4OHfOoI+Kzia53imMe
	tSHSz7YFpeO37EKt4dmt/gG0kRUTBBl9E2tZHQP/SFcpaLVVRSLsrhmOrXEkR1Yf
	WPtiMBHfhrmW/mxJnjnaJVKJ+2j7tgxROukRMDStQm3Tdt8XrzUWtWKSIW6Jup5A
	guNQEyPZCE7kCZH/ZrYjRQ01pqvIRbkuyyGYAlncEuvszgQ/7pjv0F0zubENfJLw
	GcrjbDKlRm4JdMFUwOoGWaHGRIQcaOb1k9PNQJtYEEIs/jBMUFtrwU4zSe/yi2++
	3aDzM/42MCcxirM1YtUHyQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78gdw4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:17:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJT8MPAOabqnjb+cawwswfm7vQnlMeifH7H08MTXXV0dfaW8bcmdVi1GBDW6vNrPfEfv6jE3AgYm43aXHMF8400DY/BHg2tfsAayvChVjg0vbb6m9QJNl9OyCqY2sutja4XR49mvMEVmoT46e9xDge+V7lyJ6BYkrn6kAnWlya6pc52fBwDRYAq8uxvzL/D9ZwfKvRNNGYBaE9O+7jTcyEDAvsJoDlXGhGNOuedxMpwSpaMS0Np0hZL+RfmcxU80cd3zgnL0yUdXcpiY92eljx6Lf4DtRLuqKzmX5qh6dkVw1UIUJJBqLHWoJYQFCBZoF4ZZD1wZrNOUEHpIhYq0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nk4Fo6pDwtGSRwcunzvqVLCCZcjKEuii/3fjPnCl1s=;
 b=coqi7Xp5CHebYt4lkf/TYrIiWSL11bOaUo6aRJtHBEAz59L50fikr9X4VBRw2Gt1Asff+dAac73pQwvTsxm9EFWxpXzsz7kXZO1yLup/uUqZifXBcJPGeo/kTKFRYIhgyKL1JfIyIjaE4ZBrxHvYDOlmDvd3ouXR5R+YOUijvUn4ei7CMt1u7lTiWCJ0WyznIl4XGF647eY5+y9Iw+JFEzmnQ7xY+DQX+kv5cr+BZMpSbkDrVlc/1QeJI9qnGvO0+m44Rkg6mDNPgS+/nORV1JtuRgqDeBSdR2CsIdInavG67dSjsmC2J7088FftXRx6sBUGe7nNm+4PibQj8RimTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:58 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:58 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 10/13] ceph: force mdsmap refresh on persistent MDS connection failures
Date: Thu, 12 Mar 2026 10:16:16 +0200
Message-ID: <20260312081619.40854-11-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8386b13b-1436-4774-db47-08de800fbad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X6x8+CCYAsUafGzmpxNyqQPwdmWx+aKczvklW0xqtKGCK3OyBhrMnL+S++r8TPGbJJ4Wv0uhJAgga6l4J2kLFV/wpCYxUC7+y7Fq559yY6J7hEOOTEOFLilrKNST8ubfgj7kAQuLXZHzWmkxTUqQkLklxEgBghKf0n1/uUK4kBdiCnPrYafvPmnznwE5NkBqg3uq3cnRpGdlZsLdW7Lxz2MN8pYKLpTGBXyqUQhcEyuF+0+PJPgkfdMNPVVM6JIAHl42AXZYSu9OLJG+4+nU547z7safHtTI+kYvi6tsS8dPv8YIbPcMKQPjOI8AAdfiEDnoJOSJn/U1WJG/n9fHNPaUk+DlT4Uk15kgm//c1Y30L2+Zk4Y9pMN7QhFCfhX1H82HDFSf7XyC0R7ExCc8OuRVkHcQG0c8OjTSvNfkehdrOEXD3XDvlMSGv2eLv0Kq1YMyPQG+F4vH1xixwWR3VQAK8DbNN3OiJ+YIAZx0NuCLhzpSmfYHl3p+Bt7OPf4H6/+8BsX+omn9SBlLrRBQdMBavpxo4x9jV6fB7zf5WNMDslODColsnu98h7iylMUObChmCEBSAvrIZrewbqXq8nWi555SwMiRyeRp6+1h39GDhrtgF87/kWSgWyWq58v/DJJkdPgWw+k5GLC/zUeEAbErLQTJrhQz46go3rcWoWucZzcvMi65QzcFlNiGjcDUDienqM/ewTG9Rer0dgntqb8XWNZSvm1TzpHwCfYybBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdSd1GNSWUBcnIXsTWTOlVc33F+ewbVk1G5qOxKgInKdlsiEQzMdon/tIDEn?=
 =?us-ascii?Q?Fogu0KTU6O3G/zg602fsPkRpcYpVksh7ZeFtItKXCQ40JlFYgGDq0DnMSmnI?=
 =?us-ascii?Q?Hxnbz/xG+fnmBU+f1fEwJ85ZlgTlPXvPUVKK5wjk1MDHPZfAm0EjvX2URsJh?=
 =?us-ascii?Q?0VTe9hm4B3/ycsFWlBZyjxjQF9Yr9z1hepg2kkf7L5X7PIxVW8oXw5qUDUGL?=
 =?us-ascii?Q?kJ0sY5/5SXghhmA9EDUK2QLW4XCVpcSqBXG6+qp/Heo+ZMTxQcQkIqAz+b17?=
 =?us-ascii?Q?0cB1kWmG6+c7bofzf6xfolfm0peL66mO0SE1GoQbbxaKju/J608zvVKBLUoP?=
 =?us-ascii?Q?ZBuOqnAmD6KBBKZcBZfdprI5srMiod9L2ohtYmRZxFQXAQVhFo82Z9Pgh+6k?=
 =?us-ascii?Q?htvGZ3ZrLaMP+CcTKRMHzoH+gQPGzzPsUIW7suD7oQPbkhXz0UXzjCg0s2NY?=
 =?us-ascii?Q?Za3VPVfjN3vptdBRfvoeex1vg4SPQSRSbwbo5DY5AxMC5si7LG8GnfJvNWpq?=
 =?us-ascii?Q?q++V3RZH+M5v4XR8I8nCcKxki5aHcrs3FI8e5qeAAbqG2OnM/afFBmZeId6t?=
 =?us-ascii?Q?dsOejO136wyBfp6C0L3y6loV1U87MRJMQ5StWg4jykpY5GSi7I8hkYFJJyLM?=
 =?us-ascii?Q?Qrp7Lo5ZduC31V0n6wF1Ah3GOOjetxf6aOTUTr9vIeLxbjZyy/DcKutOmGw4?=
 =?us-ascii?Q?mPHOk32y2SGZ58kltNAG/iz9gTQLw+yM6DmQ25gpDA6R3Y9o6xNp1IhBvITO?=
 =?us-ascii?Q?orR9m4ju6M68uRMTcoYWfPWTGyO2i24yEA7kS0o05/CCf5Gve2u7ulIhE/tg?=
 =?us-ascii?Q?2CHerL0Vs3AQXf0lnFqA+kR4c2G4/IQW5ohNzZjr/yefa6Q1GVuTL0iCA5rF?=
 =?us-ascii?Q?uzYClwyBZpdeF/OXDFjEUae/KsHYSJotPfrTos7YaQ03cB/gSvP6iLZjRQag?=
 =?us-ascii?Q?2Q2AVBqy82rZ1+GsOyzHDS8OG7daRMsKgC5wBrbDDPB3Q4hh8i82bX6fln20?=
 =?us-ascii?Q?P/7WtXHazgPsrpIoNDnRLdbFSAgZrWTnrr/rL0Sjhc+3kvfrBI35L8FnTybV?=
 =?us-ascii?Q?F2P2ChQwVLwKTouraitzNyxbodKI8C6LSd/FLmJblQ/GpBKANz4rgQ+wZ3aB?=
 =?us-ascii?Q?nrwcTCoMcUgnMphPpZ5htMz1zvH//UxUvXJYyi+H8yT1GJDR9U0m4tgAtInm?=
 =?us-ascii?Q?9z/zHHnA2a5WFXWdUvGlL8Hcf25HgCftdBVXsKSwpyenM2Ay9y17URkac8cy?=
 =?us-ascii?Q?nPEU9xAR/4r0lB+TrR72gnbAhO/HP9NPbBWzPYDhMPdGXZnchi/P6CD4rtnL?=
 =?us-ascii?Q?VXFvl2AXurFODjFBbRhroJSJkFT4ZRBS0Tw2V/TDQQ0MQPrfqp6ZLkFg6zJN?=
 =?us-ascii?Q?aHUr7wZhiYy5dQ0AaSJa91154pZNUqZxQJ2tuH7zY7ckMI5iX3NG5CJH/tXG?=
 =?us-ascii?Q?2X9lH5vrj4bmBz5W9DnboPiHK00JCo1I0IpA1kfgs7q+1MnuleTVndF7tGgF?=
 =?us-ascii?Q?gw0eAD1JDnoPWqSR4dhAsmZ6vglBR/ilmzRS+qAID1O94N0s1DFYN626uCqz?=
 =?us-ascii?Q?B63ghdEcUGZdGtqziJfnMstdOb0sTy+jytkxe4OnOQQnrpdGwz9Oy/L26FXi?=
 =?us-ascii?Q?yyPOd4BUNB13ce6Eh9XfvE+Ki1DiAG0sGEutOR2Pw2uPZca4pO9K/ZXyy18c?=
 =?us-ascii?Q?RUpdOOk/8Zr05MrHn1fUVagQZr+Lbt1kHosDtT24bBtVHEIEAi/r80+1fUWk?=
 =?us-ascii?Q?H3AAgN2Tr1K9b4335smys/9mpa0PEPKtOYlwV0n7QUXXOkhDxxeub9e4VqyY?=
X-MS-Exchange-AntiSpam-MessageData-1: kXSILegXzOfSGE7xTJgbCaMTJRom44O7YnY=
X-Exchange-RoutingPolicyChecked:
	RqVwmleNdkFZH6STJyy9Ov9qRbZhbD9UyePR8iC9KksBfnJeoWqGru7ird5DIKT3m4jfLafdBqpJyuA3SPBNrGpaPmrFqQ4QglvAdQiqJaWtdxx+2BI7zgBcV7l13s1K/qIOUe18xCyfdrHi/Rvixs94ILTgI8g5lvMiOR6UTBiB+dMXwI0KwGYGG9HHzRbtLC1tNLKxQGscgoSMdACCg1t22YyIa4VDcBalEp0JXg6TYva65i8gTt6HxVcbI3lxHla3g/emkZQpLe2mKhUYvG4xUq5Hy1Jh2qkNqGf2uPIzVddVN8xJTs2OTAjI39g3Yn2BplcfjKafMpL3eoN5NQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8386b13b-1436-4774-db47-08de800fbad3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:58.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3i0HtNAfuiysBMCsittUbNwb5xkZoWyryMIGt4QUqz636kjMq+kkgQtzV42dXNpAGUR/n4sVe9ZTWApcstmpUUU9Si9r+CkaFIbVtvxYsak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2767c cx=c_pps
 a=klJJBKWT8dzIbr5yswcz1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=Ed52Kt3qmj_-iDMSIBoA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfXwFM+5YsSEpvb
 Z7irZr6wdvkJicy6Hs3mTylmBPMYEEVsW5HtnEmGSsaAphBsFqdfW1osZSKLnVhgMqTGZGNvH03
 usZVjxA65/U89+RxjVmLuGd46H+la8WRZh66BrGYXv9eAy/Yr4BnmnS9JNcndLen23H3l1Bq3GD
 Msh0YrOL1ye5aAebccd7xpVR2l1a1BxI6yhp0VmP2gST6N6MSB5t8AwToeh/X/IEXU8JyEM5BOy
 VWd2MK53ArAFRryrr9YucpzkSLLb8B3pCRjXIjT72+wixwLZs1ON1zljPlk9AC6SpagIbTkpCBz
 Fk9QLzRXBoX+mTheQc3rJVMPR3twz/IlqKtxigmpUiYv/PnqQBdFQ1zKYBDUoM2kDq6RBD1/2ZR
 IEQEe+lfbLAb06DaajuN7shuZ+yWxategUp4PNXVh5qrG6vXV3R+UQhwOc/9rf4L+kdi0F/vsiS
 n6YoJ3kCyWfoG2/xZdg==
X-Proofpoint-ORIG-GUID: w_xd9cUddHe_Rttcb7P2GCLXs47JUVjk
X-Proofpoint-GUID: w_xd9cUddHe_Rttcb7P2GCLXs47JUVjk
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

During rolling upgrades in containerized environments (e.g.,
rook-ceph in containerized environments), MDS daemons are restarted and
may receive new IP addresses from the CNI plugin. The kernel CephFS
client (libceph) maintains a cached mdsmap with the old MDS address
and attempts to reconnect indefinitely.

The monitor client subscribes to mdsmap updates with
start=current_epoch+1, expecting the monitor to push new maps.
However, if the monitor connection was also disrupted during the
upgrade (e.g., due to EADDRNOTAVAIL from IPv6 DAD), the subscription
may not be properly re-established, leaving the client with a stale
mdsmap.

This results in a deadlock:
- The kernel client retries connecting to the old MDS address forever
- The MDS connection has no .fault callback, so the MDS client is
  never notified of persistent connection failures
- The stale mdsmap is never refreshed because the client believes
  its subscription is active
- New pod mounts via CSI hang in ContainerCreating state
- The rook-ceph upgrade cannot complete

Observed in production (kernel 6.12.0-1-rt-amd64,
Ceph Reef 18.2.2->18.2.5 upgrade):
  - mdsmap stuck at epoch 53 while cluster was at epoch 68
  - MDS session state: hung
  - monc showed: have mdsmap 53 want 54+
  - MDS address changed from dead:beef::...eb75 to dead:beef::...bc76
  - Client kept retrying on old address for 30+ minutes

Fix this by:
1. Adding a .fault callback to the MDS connection operations
   (mds_con_ops) so the MDS client is notified when connections fail
2. Tracking consecutive connection failures per MDS session via a
   new s_con_failures counter
3. When failures exceed MDS_CON_FAIL_REFRESH_MDSMAP (10 consecutive
   failures, ~2.5-15 seconds depending on backoff), forcing a fresh
   mdsmap subscription with start=0 to get the complete current map
4. Resetting the failure counter when a session message is
   successfully received (in handle_session)

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  2 ++
 2 files changed, 75 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ac86225595b5f..0e766880056c0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -66,6 +66,12 @@ static void ceph_cap_release_work(struct work_struct *work);
 static void ceph_cap_reclaim_work(struct work_struct *work);
 
 static const struct ceph_connection_operations mds_con_ops;
+/*
+ * Number of consecutive MDS connection failures before forcing
+ * a fresh mdsmap subscription. This handles stale mdsmap scenarios
+ * during rolling upgrades where MDS addresses change.
+ */
+#define MDS_CON_FAIL_REFRESH_MDSMAP	10
 
 
 /*
@@ -997,6 +1003,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	s->s_mdsc = mdsc;
 	s->s_mds = mds;
 	s->s_state = CEPH_MDS_SESSION_NEW;
+	s->s_con_failures = 0;
 	mutex_init(&s->s_mutex);
 
 	ceph_con_init(&s->s_con, s, &mds_con_ops, &mdsc->fsc->client->msgr);
@@ -4341,6 +4348,9 @@ static void handle_session(struct ceph_mds_session *session,
 	      ceph_session_op_name(op), session,
 	      ceph_session_state_name(session->s_state), seq);
 
+	/* Reset connection failure counter on successful session message */
+	session->s_con_failures = 0;
+
 	if (session->s_state == CEPH_MDS_SESSION_HUNG) {
 		session->s_state = CEPH_MDS_SESSION_OPEN;
 		pr_info_client(cl, "mds%d came back\n", session->s_mds);
@@ -5427,6 +5437,22 @@ bool check_session_state(struct ceph_mds_session *s)
 		if (s->s_ttl && time_after(jiffies, s->s_ttl)) {
 			s->s_state = CEPH_MDS_SESSION_HUNG;
 			pr_info_client(cl, "mds%d hung\n", s->s_mds);
+
+			/*
+			 * Force a fresh mdsmap subscription when a session
+			 * becomes hung. The MDS may have restarted with a
+			 * new address during a rolling upgrade, and the
+			 * connection may have entered STANDBY state (no
+			 * .fault callback) rather than generating connect
+			 * errors. Requesting mdsmap from epoch 0 ensures
+			 * we get the current map with updated addresses.
+			 */
+			pr_warn_client(cl,
+				"mds%d hung, requesting fresh mdsmap\n",
+				s->s_mds);
+			if (ceph_monc_want_map(&s->s_mdsc->fsc->client->monc,
+					       CEPH_SUB_MDSMAP, 0, true))
+				ceph_monc_renew_subs(&s->s_mdsc->fsc->client->monc);
 		}
 		break;
 	case CEPH_MDS_SESSION_CLOSING:
@@ -6528,12 +6554,59 @@ static int mds_check_message_signature(struct ceph_msg *msg)
        return ceph_auth_check_message_signature(auth, msg);
 }
 
+/*
+ * Handle MDS connection fault.
+ *
+ * Track consecutive connection failures and force a fresh mdsmap
+ * subscription when failures exceed the threshold. This handles the
+ * case where the MDS address has changed (e.g., during a rolling
+ * upgrade) but the client has a stale mdsmap and keeps retrying
+ * on the old address.
+ */
+static void mds_fault(struct ceph_connection *con)
+{
+	struct ceph_mds_session *s = con->private;
+	struct ceph_mds_client *mdsc = s->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
+	int failures;
+
+	failures = ++s->s_con_failures;
+
+	if (failures == MDS_CON_FAIL_REFRESH_MDSMAP) {
+		pr_warn_client(cl,
+			"mds%d connection failed %d times, requesting fresh mdsmap\n",
+			s->s_mds, failures);
+
+		/*
+		 * Force a fresh mdsmap subscription by requesting from
+		 * epoch 0. This ensures we get the complete current map
+		 * with up-to-date MDS addresses, rather than waiting for
+		 * an incremental update that may never arrive if our
+		 * subscription was lost during a monitor reconnection.
+		 */
+		if (ceph_monc_want_map(&mdsc->fsc->client->monc,
+				       CEPH_SUB_MDSMAP, 0, true))
+			ceph_monc_renew_subs(&mdsc->fsc->client->monc);
+	} else if (failures > MDS_CON_FAIL_REFRESH_MDSMAP &&
+		   failures % MDS_CON_FAIL_REFRESH_MDSMAP == 0) {
+		/*
+		 * Periodically retry the fresh mdsmap request in case
+		 * the previous one was lost or the monitor was also
+		 * temporarily unavailable.
+		 */
+		if (ceph_monc_want_map(&mdsc->fsc->client->monc,
+				       CEPH_SUB_MDSMAP, 0, true))
+			ceph_monc_renew_subs(&mdsc->fsc->client->monc);
+	}
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
index 695c5a9c94026..44585b1cb4485 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -251,6 +251,8 @@ struct ceph_mds_session {
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
+
+	int		  s_con_failures; /* consecutive connection failures */
 };
 
 /*
-- 
2.53.0

