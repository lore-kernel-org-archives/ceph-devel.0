Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFEB37DEB4;
	Thu, 12 Mar 2026 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303421; cv=fail; b=BiwGLcbZooExOJHn2nkS7VKfKSWhgFL089sGvdlTY5inTjt6AmAFwYVtRtHzbNP6iZZUFtu0cCaaKkAQTB89s2pWEQgfZccG+F18MwffFvDNge8a4XGj0jSmsHdPp3cG0gD30/Y0qbZMX0dugwbt6Lw/oN1aFFsdCPS92AXULsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303421; c=relaxed/simple;
	bh=eQCemDr35acPZMFawejDy/2FbxtDOlYvRvsc2oyeH8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kix4Bq7RyhgjcyukeG44EYekv8r/SURgg+Eyoau3ugXOmvJzHlhR/2E4GM2bYMPaLeCZFu50LThcM1NvifDpZNhnCBAOOrF4P4i1TAfGPUZVxyaX2xUPrM9GGIkWDztWEMUiVn2omYZzQPWPDSbPvYe7NWNWqBLv2O7xTlyYDGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jrwot+nl; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="jrwot+nl"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C6Q1eM1808083;
	Thu, 12 Mar 2026 01:16:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wF8ljwMZFmxKlHdpC/KkmWq08ByR84HvtocIKKvYLBg=; b=
	jrwot+nlhQr0KcKx5kfnP9EeCB+waMagS6VlK2LDJiK5dlFNRg54qMVT8IQm264B
	EEo/DrNk3fzgtliraqeQ9YZHwckJtaISARu6NInu7nWxjj0+Kf9FPlcsh3HHdeRj
	glJX8UC3656O5IC82eNsGvcqel0VHwFGGpcndijnvLa6FZIFRWWIlJMjWsIhPe1I
	SVLuVIkcX/vN0/VJm3VjerpbiMrrIAaMsrdpP9aPFBTZgbckXzliK7WVX7UK9Mhf
	QDpP2z2DvRT0ybZTswTxABOJ9A27Z7r+rPSmAtygpsUN8lXd6B5F5IxnX2hSzj4F
	YqSGQYIfBIZqefgQeWgyQA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6pren0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 01:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/vBC/CdIcOP8qApd//yInCTJE52ruMX11lF1VsipQX0M1XeINTgfIKyNVQbJY+MrvtcRn6xh6gJzZPF7dZlVsI2Rx+e3os+68kRHEyodSh3+uSivK/fWinJEnDqsTy4jz7a2dbpa4CmboZHJZiPlWJjG7itH0bPti5OfyAe7DQz08PD+YTICnZrmkKfwzdccH2ezEGvhL2WECIYVwPwrKQSin8DK1JTLpYF+yeBnJm8fbgauo47h4AYnpI8+B3I/mHJPlOIWKf3RN/ZhPyLmQ0MkuAzki1Gta1cYe8ZqN+PJBScLkc/vfEOq730cYxb6TX0tANgaS+HRYpf1JmM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF8ljwMZFmxKlHdpC/KkmWq08ByR84HvtocIKKvYLBg=;
 b=BgkcbCXNkvlEIaHO7DmaPAeZ9vD6Ab5Vedkov4rmqyIioVMrHEoChq/w0e6Y1vMw0Ro0kAYI2UODH6l9vHHi9FSupCWEUSecJIZZg4uydb+XgNih+1hOntLzJN1M8UsWpOWw4MbdhLSu4dWADWXxkZEUozIuY4x9V5oAW4opV6Edwpfee0oPf6ZTDn3H/3ZUCdYDKTp2ESbtjt8WCOEJ5QmAyjOU7qhvt+GRN++Z3sm04bJm0OxPNLdHj8lwi9o7zlyM10oq7MuQuqEAKiRhv0QZai31YjbznfWmpLh5xopX7jeD2Z7BIBzBmI5LV1bsTBM6Q3PodLKr39xx9ANd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:48 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:47 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 05/13] ceph: add timeout protection to ceph_lock_wait_for_completion()
Date: Thu, 12 Mar 2026 10:16:11 +0200
Message-ID: <20260312081619.40854-6-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 43ff4c34-2c6b-4319-3cc8-08de800fb4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KYHR39wVTevpUh2xUdM9s4rf54vlodwUDcGQ4sxmHEW3y4lXBBAOpY5ov7hxGUUMtKoECZuv4gdMpf4jD/ZlG1KrHDpJFDQ54tzsrRwyaTiZlPZYv6ycu5h046ZpmfReAwzAHYKlskQfD8LfrskAooWzU1VNJPENrEeR6aidd2YWjy2SznENnqiZMSpeFwr61uO21b+NAwmbUzXD3O/OtSFh20zPENV615fUhE9biGQohjoisEqPKkKfNa1reLjh1usKbv3iUrnyfRB4uwF0SI9Y1efJccy3m5SJ4QcWyeBUoCXBkKXsuwDcelUV3tIMGOKb6BdiVOfYUFfctF8IkdaG4fcYJkRr45Y53nvkDfyYCdZOu+Xu/TKVZ5hmcTcw3XMv67n6ibvr4HEtdQ+JWjpy56wsjtilP85xqB711JaOlTQfX4qAb0+3jCwcCRJ7XdWbjNsKLU9W5oUURVMjwkizCqhWxWil19mGtLw6b/sShscKwy4IPmB/22adnrZV2ZnZHxyeJd0eDpPyFWeyofmPmLDqKRnISKIV6lfXIMhRBOLRmZzjcD2smK5Az9NAlKaYKI9rHb7FLvSrjVJ7Q8cLihwg3QYAa+/WMhX7r+Ikfx5eEvmPPsCQnFqqY8AZlkxNcNN+95zOfN7HG74fh9XaJ0OBXre9QAQKZ/IuZB+gpNHlAoMmnGfkYzrRJdqd7PmULGpUdvccGOhDTkGgjbBqORA+9nsG2lJ+5Gkc2Ys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zoa7Bw4rhYVputxssm8Fs16Y0bkeLJDqnvh4x5i9Mfy837xqG0rwjsuyM1uI?=
 =?us-ascii?Q?HTWXVE2fYpfxCrRwi7z2QfCuiUrcdQzKPGaAjI2cZ+opAGynprMFb76cyeig?=
 =?us-ascii?Q?pTb50jUWRQgUdRrZdTGsGl+SglPADfN0K11Z3CFKlZBC7uNohRE01MIUynBj?=
 =?us-ascii?Q?NUF3wEs6qgwIin0x4ZrZvpCDpFZ/ZcTYDlX+R89yF5v8bSCa8Scc0PI2s5/c?=
 =?us-ascii?Q?OcHJxt0A1Gq24L+/dK5aYrecA4bYlRLuoXwcDjdioSY2lDU6bneJPSMW/l1H?=
 =?us-ascii?Q?AeD8jHLs7TZBmy+vIyWZoo48zwhepgH+VfkCWt7VcosJ5WA9OmsOUAFUPGny?=
 =?us-ascii?Q?ydtZeIpiIqH+IRX24DGkZKHef+8CyKVFO+nJaiLWjLeQIdRf2bjUi9QijlmO?=
 =?us-ascii?Q?j2n4MEca8vtkJePDtL8A1WW6IRc+8BRnSMY68NkVQriul6Y3a9QLmMixggDq?=
 =?us-ascii?Q?ep4MnvqUzGbwwhRO3fo1H9WYs0ZOhMEmwEgyeNk6d9tECkEn1xe2M6Hb7R/2?=
 =?us-ascii?Q?sXXgvbMUTmkTv7mc1kB/UiBaAddYExBAqerzTkSMWV8YLp4XhTNIEXFpIjxz?=
 =?us-ascii?Q?POIWsK+pc/BfDjP6bIngsMzrE6gOa/dnbX4c4zpJde5BM13lPy5WWfYXktVX?=
 =?us-ascii?Q?rB35XO30L0+dkvFju8FweQPLY77VbPwM3IJTQsAoWbOGDPgBYR+0j0kGuw1C?=
 =?us-ascii?Q?WKhuczIDJXFl77hxA6gFvi3Kw2X8BJcFVZnJO2TlN3IF8V9zINxs5LGDG2go?=
 =?us-ascii?Q?QiVeKUbWLq9sPyOJvnq2sWcXjmJASJZWFdKWuURLDyUlmsmH3wA12jWSSKuA?=
 =?us-ascii?Q?cAt6aBCBZWar7G/wJcYoxKZq/028OF1KSKlTpz2860Iq9J0afGuAZXazcpEU?=
 =?us-ascii?Q?ZBpNqH6s8GSu6EbzxgcGnWbtnm8EXWMK3E/ebzK3z++Uz/8s64ujLjg3IxTN?=
 =?us-ascii?Q?89EjMGzZRAe48SUZ2xb8Tk50eGojTsP1F5KvdsXXfL13lXjD+ZbiSFRKg67r?=
 =?us-ascii?Q?HfRnIFZaVhW6DbeAOjaSG1CAyoEofUQdaMDcWdA2ijViwqV3OTpQnchY07j8?=
 =?us-ascii?Q?WQKhT99t87l8l2oerE9uchML1XqC9Zjc2tuAnZiMwyL6RZIs7T3KUrjMC+Un?=
 =?us-ascii?Q?kGyH+FjDK05StAfb5PElZllmV0zTuiQUdtBBAXevmykCpJ0T2bQaCdy8eYfb?=
 =?us-ascii?Q?rr2ubzYWCYRFaVx2UVcSgpOvUoAPXJtmgp1tL6uVad1weV86PxIgEtwRfR9B?=
 =?us-ascii?Q?AHqo1lqx4C0QVWU1msGey2K/HqU8BsLFHdiwFAs3M3RIx+sXbz5keb5qoYCP?=
 =?us-ascii?Q?tbCvIfl+Sn2FSqDyd2XqB2w5ODG4Mfp3tqsv9GMI5JTW6LY49nta6D924eKV?=
 =?us-ascii?Q?Wb2fxyRMw0T28Dwp4nT2ebHPUrApMjvRKVAT7CaUcRwohd1m17xvsXOvSSGr?=
 =?us-ascii?Q?Bw8dvcmMo4HMu6cX4P2I+6Y8FSLEmzApikgdjriRrXQCvlLVcm+MAx9S7oZu?=
 =?us-ascii?Q?ReLtmRL/+uhcFYFtZuiKQbYjeL3JkzWormS+CmMA1fHVXcdGiP/TEEGYxSVa?=
 =?us-ascii?Q?ETm/VDVJJJZSEFppmwaWD9vghtM46cmYMzmQVKbn0UeTA8aanWbelGovGzz9?=
 =?us-ascii?Q?nDdIZNYtaWY1uUver682gJY7q3yyompBRFedgScoPSPvHOsbq1rYMhOAzA5F?=
 =?us-ascii?Q?R+lejEYRI2h/a2TBUJ5lYK40voa+X87lBeuowO5d+cUgZy+2m3OVpi/UO9xu?=
 =?us-ascii?Q?yVtixNsOwCgukwn8Q2CCHOSlSAAF3iv/b+DKzZ3n2vD125ObSIsvXpgHBw4R?=
X-MS-Exchange-AntiSpam-MessageData-1: ttxJ6ga2R3HrdYuWCx0zgUx5pyFtopA9ro8=
X-Exchange-RoutingPolicyChecked:
	D0mVRAx9EHLV5n5/ZPyOjZHnE7ZaaIV0ab8Lw0a4sMslhkbstAHiRyklJxOaeZEKGbxUzHbymtrflPbv3ifWh3eBBbynS3mjboDlj5VJ4p4br/GpYeAePWp0GRe3JtC3iv4DtEvqjIGceZBrS7k2s67taeeKILukvPZ46QLXJ9zq6+vYkgigMMfnoI6+pXTPbo8eSAS/dl9Ma21VzRFVoC3wwcLPzWnXZW00P/9wd3S+xQwE0ZWTqHGsV9V72AUOVWmtelMt2mQ7DAHVe/z2987mwH6gUVOZGgyNSQ5SIczFRca5S4zywl0BjMQ06HY75cjbnOAe63gE/wVjJIitIA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ff4c34-2c6b-4319-3cc8-08de800fb4a5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:47.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igsfIkLRU9YOJwF1wGelUHjEcIYWowGo9u6lKAvjJbgHCnRxYaKZ+R2dsbKHf4Hma5RMAdsiFf53W1vV8IvZIDQmNgpbTS+9m1d6L+B5mh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ePAeTXp1 c=1 sm=1 tr=0 ts=69b27671 cx=c_pps
 a=GX94MXth5n4ySrE0IhOemQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=C2ouNZtNROy2VeIb3P8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: prubFGDrzduFmfBtjzvsGg_6ZseAg3Hy
X-Proofpoint-GUID: prubFGDrzduFmfBtjzvsGg_6ZseAg3Hy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX/segWeMg3Mgt
 W9/zECTyjf1DtHN0dw3m2eHyDvu6AM+ifwhpTF966aAbVsSxHpjPLLahqCF8DeyBcU4r4aX/BX5
 ZByHtSx7/iDOakdk0CqMX7fn7lWCmyLH/L9SHWQqBisNPTSO16wgKWQMVs8AH467rB6NQA3R8lw
 Zt3aH/LPB81YZCQK6f/qTkLJOj2rhvH/RIfggdnCITEtlphNrgUUrv5yCG8AdaZg/qqsDBCFR0Q
 RrX5R8KLosgvPxh2jHdAINli6FI+78rJ8YEdtIaAVbNuMqZ8thSUB1Dc8OCXeQPUHp3y4wUQS1P
 WyzsFsVwfj+/uaf3isTyIHqnXc/4LkB92UHeUxZnj3moG6VWqjijTKXmmjEVAnBoLcgwUcwdYOs
 WHQPh9SaVxWtsR1ZVr3n3wOBUMIAvS35xalM+sBsYVDkAIW/8RQITlkE8mkQPjEu82r8o2LEmbx
 lVdoOfDqrntIYWOEZUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

When a file lock operation is interrupted and an unlock request is
sent to cancel it, ceph_lock_wait_for_completion() waits indefinitely
for r_safe_completion using wait_for_completion_killable().
If the MDS becomes unreachable after the unlock request is sent,
this wait will block indefinitely, causing hung task warnings:
  INFO: task flock:12345 blocked for more than 122 seconds.
  Call Trace:
    wait_for_completion_killable+0x...
    ceph_lock_wait_for_completion+0x...
    ceph_flock+0x...
This is similar to the issue fixed in ceph_mdsc_sync() where
indefinite waits on r_safe_completion can hang when MDS is
unavailable.
Fix this by using wait_for_completion_killable_timeout() with
mount_timeout instead of the indefinite wait. On timeout, return
-ETIMEDOUT to the caller. The lock state remains consistent because:
1. If the unlock succeeded on MDS, the lock is released
2. If the unlock didn't reach MDS, the original lock request
   was already aborted (CEPH_MDS_R_ABORTED set), so MDS will
   clean it up on reconnect
This follows the same timeout pattern used throughout the ceph
client for MDS operations.
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/locks.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ebf4ac0055ddc..55dd99460b81a 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -160,6 +160,8 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
                                          struct ceph_mds_request *req)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_options *opts = mdsc->fsc->client->options;
+	unsigned long timeout = ceph_timeout_jiffies(opts->mount_timeout);
 	struct ceph_mds_request *intr_req;
 	struct inode *inode = req->r_inode;
 	int err, lock_type;
@@ -221,7 +223,17 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 	if (err && err != -ERESTARTSYS)
 		return err;
 
-	wait_for_completion_killable(&req->r_safe_completion);
+	err = wait_for_completion_killable_timeout(&req->r_safe_completion,
+						   timeout);
+	if (err == -ERESTARTSYS) {
+		/* Interrupted again, just return the error */
+		return err;
+	}
+	if (err == 0) {
+		pr_warn_client(cl, "lock request tid %llu safe completion timed out\n",
+			       req->r_tid);
+		return -ETIMEDOUT;
+	}
 	return 0;
 }
 
-- 
2.53.0

