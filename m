Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450930E835;
	Thu, 12 Mar 2026 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303414; cv=fail; b=lQ3G4uTEq8fjuoFOiinVTu6s4qix3Pnri8GsBJCDmq/DxbZd5ZCFIhHSwPvsWXW3AlViKH9uH+KHst6iv+/5UKEYaqhU6Q+y3+zaELtJufJ/BUtvw4mP4IcTaGxtIRzhX62x/zx81ABfT+v4zK/gsLxIElFBa+6NNvs57HSD5tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303414; c=relaxed/simple;
	bh=NJpI74E13Un6VOb98cIxG/LGoloIq0JWZOzxW8HZFMc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hthor5pOUIQoVTebuta1B5RSYyhm+CpQLuJAy0dauN7cBaJaqXPV/cwgARgS8laA8tj8MD6HFj1jmZKifBUqqwGtKSYEfOniGVmqVGwHL9fXmxLRz6JT2xkjp2fccoFieIhNJ0Fd9X3Jp4KIxpN4QCX2nE+ud8TtWmt6Va4Ssc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=F/hyS1r/; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="F/hyS1r/"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C7Xgad3253345;
	Thu, 12 Mar 2026 08:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=9IcfmoZCN
	Q+ycdeiHA4M5oAvpRoXuhovg17gkZdDkCE=; b=F/hyS1r/wYqJD890LGG+Nd2tt
	4ChdfuBJz4eDFP2LqBLNg0zP38KBUdBSKkQ7zquS/DkQ2ALXqS4QnhwCZANajCYJ
	aJoegUmlrBVKPZ7L67Q5xNz6VLBEapczJSiG+BEZh97KljxuqNfzm1atuvVNya+4
	8sS3fZfVQVBvjuhKSAF7B7VPrOKQ+jz7fvJi8ZegzGZgYBrCH2Xw+e5JU8OjwQlB
	QgXqn4kitTwO2JhJbeYAKLhIID89nggE9VMQYbyGzdDm7iJ3cZ1e8KO+4Ta6pI4j
	70SHXgMp/VT39el6t8GptkbDI5VxSTmrnj1YIaN+WHq5TaAgQbNedkBEY1d4A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78gdvk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:16:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLnyqukrtJGor+Kkk9lNHKiBrLVD9gDZkT8XM48kzB2vLerJGqVsIs6+KkSGc4KmvsELUbgfmEVuXI1RhFl9k3vSGRYR0Oz3KPH/TqwJ5RjdhIGGFv6qhwMUFTlz7RCaL+H7UeBQstRWG7YKQGXs0Asqzuymz0/ZMOZWddXOq49ZO87+vPg4vizQtDiQVhWkI9coloXbz29WX9JwSP4Cb9qlBv40F8st18lMbrKoyNRa4mkASZI6Bzle7ZEVmyPCha5vDejN+lIHXkdoQaFmEzg93wesKW6TyFhpw4AWmJr/SwuEdKP3ornqFFy8F4m7l7YIIul1vFS0T1CkajkiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IcfmoZCNQ+ycdeiHA4M5oAvpRoXuhovg17gkZdDkCE=;
 b=JldDXxlexQNoN7MWDlezZd8Pt7MaGNc1mCiUwzG28/0arzaiq8kxc6xCH+0pRON1a72l+4ayu+NoOC6peexgjpIujqzzee7AqXRzhOeF5JYJQ73sNK6czUFComHX1+Ug64rLRMFJrYqKu4Vl1y1HvUcmjjEIUXeBNC2TxR9l8evYZQdYKYfS0a9BLZMruv6RmOShsSaukjSlrRwUkABaiBqLI16Dw+GT2OpKyre5GpnTgXwYUeEHgRNNOFFhGPk/lNEG6d1w5qsRbBXDVQUbrYJ/LJubogy5tk5Lm9xJyb7mSGCjeoKOokeumvrjbEwL3RQw5OiiMkJn7JZv0djDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:37 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:37 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v1 00/13] ceph/libceph: fix hung tasks and connection recovery during network disruptions
Date: Thu, 12 Mar 2026 10:16:06 +0200
Message-ID: <20260312081619.40854-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: efd8f838-2212-4cad-b864-08de800fae1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vZe/7VkePEqGimHVqLXYJBklgUaOryakdJzfu7KlI2E62m110P6oJaeGwMgKHseQ3s96Iy6OmJTL23WHaKjxBK2BwpgfALxzl1JwTO8jhGCopzaI4Rklroj1FfBdGMOt83c/mMzJQVcQTCI9/9Awv207DgVxzNJMq2mHJbMJCUxScSUtg8QXaJVl7kfx/ogYBkJGfeeAX6e91kuH8P98TJFfEqCdPQGX3MXciJU6WgaE5GwY6UAtgBeMtANXtzeKWKdp13cdHdbPGeMChbMgbBxG1j4KvSDoSt8K6AUB0NYSAIJfu4p+dbDA9fFtQye6PdJukuhGJQJsj7W43PI4UHB1tDuc+I8ayVGjNUtWAWUnr2l8oifbaIanDpCfhbZ2blOPz6vJmPtFhfCgBLc2VJAw6kzZhoY3Rvjmj6csGHykXbETGTYR7V9nOlO+N77Z80kUtUqmbs9z/7Pu50aLArHpMSGH3gcxFMsQR2zJUAZmb0lWmsABHo5j34o6Jh4PBJR4EFiTMIHdacA0eAEjplq1LA6WoeXr7/lphzYxZdMTBz0bORJ0Uqi+4OtDdgp1mHAAK1z+TZLBPEA71kzQYAK5An4ze6/OaspjFA/116Ycom6Ras27JSZzx8QfzRy9WcEdPzyti3mlM6e+U8UHCGhhe3fhreVV0qF1IhZObKWQijyNysscOxfd5R1N2MGxNwz+lhMwQsU1lb2siOtsDde/pnJ+y4o20U0tcIxRiMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kB8hFwYQChEk1Yft7J04zXZciI0zVo20/SKnR1L+bhMC4wLHoWodp6b6cImZ?=
 =?us-ascii?Q?1sCizFBeCEeLDlRSNr3mJyCyl/YrIr0Kp33YeJSlh044wCXpmqL5FADMWYh7?=
 =?us-ascii?Q?YrRQSu20df3i+qvp0jbuCclDh9hsMDo7FoL/ov/+0x9IT1Gbvk6DiTxVCJDb?=
 =?us-ascii?Q?5PbWD8I6N27uCi3zHHliKNr75qVrI2/LeoLn5Jb6UyxSHq4xOuIu2orUfyiQ?=
 =?us-ascii?Q?QZco5l8erSrHve3mhaqiY0FKJUWa6JwEPU/gEbOR+dVcsAXY/SNgRNLFQlZP?=
 =?us-ascii?Q?ortvO1BXKi1eX5nWrx6yIv/ndb9fRtug56d86pApgeFSFpiVbmEBrQPDrZwI?=
 =?us-ascii?Q?PxVct0iPziC+S83C+FVrPxFAJV39HsLVDenhlU8LQl5Curk1C1NSWyO5Hdn0?=
 =?us-ascii?Q?cb4lxZK1b140WMsAckSdeSmN7I6QBfsERRSYyW5OumuRxxrMwdLEjm42prNE?=
 =?us-ascii?Q?CQpwkcQA7TNPLfD2o5N8DzCaCkNQ2AuKdPzoOFwruNsc6J5A2zFxsRMrLosz?=
 =?us-ascii?Q?6APs22ky1WyR4KxQ03Bt/DtT2kbIivRkw4k4/ygEhJro9tHWsNU7OhBuWcWy?=
 =?us-ascii?Q?v69yb2RLZLIQRPg/cZcHyQLZeDa3xxG/QVal2D0LfxX0Bop6qqBloawjxIVU?=
 =?us-ascii?Q?hXIhWUuuKvQPfscofmz2iuv80o5sQePFJUKCF/E1mbDiZkquJUHb4y3X6Bqe?=
 =?us-ascii?Q?h+wJef1jIYJp55I28RZWnO1lF79FBmL0LTUIEqffVArqogec8ERS3EDaCuU+?=
 =?us-ascii?Q?MzqHEpml/fxfhiKQazyFoO9mRGKfLAWVDjTyT0AO0s0YwHqyxNwyXJOEJ2Sx?=
 =?us-ascii?Q?gd5KT8TpLvvdlDpNHu/HBXvQ7JTW9SuGZ2msQj44MoANuqMOTq9i3VhZxECX?=
 =?us-ascii?Q?QTlO3+L9J3+ZDKeeF7VIB4nXkme/bx7NP+P4YvJ5wCI+4+bnu2NurKmBhQIQ?=
 =?us-ascii?Q?o/mrrwc2nSH0d1Rvoc1nTf9lauj8pN7sVDdRoDHSeAJ/O1dlE3cG5CdieP/E?=
 =?us-ascii?Q?8DbkJqJTavhsIPg8ggOKw8z33GEJdMtWYNwxBGslOtvCS/f0YR5v9doXEX2j?=
 =?us-ascii?Q?2gYt8ancxISUk9qI4/bPKfiaNiRpcZ7Or5V9EjUpYvAQ9W7ecR5LmErFBi+F?=
 =?us-ascii?Q?ajBqfh97bTRJHUsEmrJnwTWC16HA8RZRpkWo+9i10s14haELq2gMvKIyOq18?=
 =?us-ascii?Q?lo08/BmwUsTWV08TWR0Ddgw1k+qXbGuleE9mQKvkAmNGwt1jsTpYpCib2Pch?=
 =?us-ascii?Q?/AnmwcEgE/LuPRmZ5A8iUcQH/7adWytfOZ8UZ6oaf/fD/BmAP+X8JZPORiUh?=
 =?us-ascii?Q?Wg3d2Z2NNT3lON4zZaCM4BIlN4ZYsucqPY5WizNQbfRE6jXo2WCMibDCJcwC?=
 =?us-ascii?Q?GojFHELEK1lrQmTOtZo+BiI3B9ijWuBukV8YoZFuiHAsdA9lqYn87hgQee0C?=
 =?us-ascii?Q?UWY0We6cUizUTAYW97L49Sl2gOPo7V5obIPRfaR7hpl/avOWxpG59SlXBFPe?=
 =?us-ascii?Q?xqv/kxDP2U+N/P6JUwHL+Ya5PaPcLYxvNp2dAxstnfI7T9mHoMSrxWX+HK9n?=
 =?us-ascii?Q?NpeypGboSNLGNF8qg2jJLXTlDSs2R7Rue17YAQNFIDHaXGcS12KqOJNsIOR8?=
 =?us-ascii?Q?6zHS4GnSEahpeAzH31pIa5L6nAkuWrpuZbLAcgOnqL7Nz0AH8ouofIgO1KLq?=
 =?us-ascii?Q?4YH+uWkTvuUwPAapWFE/GDXwi+OMkiXJ0hnHxnuFSsYYf+AWk0RGZD+cfWRI?=
 =?us-ascii?Q?qJ0CRQ8l6R+1zAvQ0hM12ZAiTxbhKuhZs+Fa2YUTtGYJvkRpPbU6NVsX3dFW?=
X-MS-Exchange-AntiSpam-MessageData-1: JrWzBkJSxYIjKwUzdtLbwq2ojnBjTI88hiM=
X-Exchange-RoutingPolicyChecked:
	VW1Bkgjqf+nRDaKKyp2Z89kmDSjIL4JgD+LWgkYb3WTZFoakK6u3tIGhBEYFVdTcxwY35sehwHXZl/gzqawKtYqSpzz5ESWFGvqjkQNJi+doFawY3dlkHME0Cd40eY3XU4BGeQcpxffFxUX4dI0otJHVoO2a11qPa0LTKRrJcKycrqBS9aueH/h3sXFvbmdRTZOx/WCW3jxh1/TKxM1qMH0q5zumWFyOgihOqqtVu8lMbMHkhOs8pVJFcDONO8YB21E5B/4WH777BVSPT6jGAuN6tl23ql9+pho1bYA0a2ha732EVTzLliCko/b/RebUjXjA1hyXxjnBsSGt4HHsWg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd8f838-2212-4cad-b864-08de800fae1f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:37.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVos0GBP9k7RZuz+oIMRfbiU8FA3qwzv/GzyXWeEzJ9JSN6hpeZ8EqUSAQli6zrIW6a1PJXyVheTKMDgCG/s51dzd5VMkleHyON2iPU5ncA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b27668 cx=c_pps
 a=INYzEgT09ABq+JfORImVWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=mSSzmg0Td396CfXvaPIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX22ldCtdNra8N
 VB+on3OBQeMU2/qJGofIrjdNaVPqfjSWOlgRR0Mml3F3Az45bKp83pCO/naGIHz+mNnCpgpFdDI
 qaZKJ5bnlpa4cTLF5PD0wDk152872sq0bKPdLzGJ4DhMR56uaiTt3Hcmwc1684DdD+AaMQNWsQ/
 1/7aZ/+MUFwGR5WURDsnR3LiZoyPfi9YI7TG+YSWf1LfGKwvhabUOIYy96lCSpmZL1ojVCWdiZO
 hZQddniSFS+qmNzFfYT6R15CLDLQDZqoYkTxtKr6ojSewo0R9C7FEOIk+LJ306IzXUmkQ6GyQrJ
 jnhYhtYpxdd9ZIbZNmhf96w5ZofnymYuulZy+usOX1YRvP84RCbTXRI7uC/DntxwaaukPCfeRgQ
 iKdEP4cU1CQP6x00SGKFRpqO9v/DMZKSWsCE/qWscXRVc2OVwB/JV9D9iqFkX8xHpM7W3L6zLsX
 4uPzOdCAlOj3FbrF/Vw==
X-Proofpoint-ORIG-GUID: ONdKU5VU1bAnxltgMRpk9pehw9FqPwh6
X-Proofpoint-GUID: ONdKU5VU1bAnxltgMRpk9pehw9FqPwh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120065

During Rook-Ceph rolling upgrades (e.g., Ceph 18.2.2 -> 18.2.5) with
active CephFS workloads (ReadWriteMany PVCs with continuous I/O), the
kernel CephFS client encounters multiple cascading failures that leave
the filesystem completely unresponsive:

1. Persistent EADDRNOTAVAIL (-99) on all connections

   When monitor/MDS/OSD pods restart during the upgrade, they receive
   new IP addresses from the CNI plugin. The kernel client's cached
   source address (learned via process_hello/process_banner from the
   initial connection) may become invalid -- e.g., a Calico-assigned
   pod address that was removed, with a blackhole route installed for
   the old address range. All subsequent kernel_connect() calls fail
   with EADDRNOTAVAIL at ip6_dst_lookup_flow() before even sending a
   TCP SYN.

   The existing exponential backoff (250ms -> 15s) compounds with
   the monitor hunt backoff (3s * hunt_mult, up to 30s), making
   recovery take 30+ minutes even after the network issue resolves.

   Observed: ~470 failed connect attempts over ~36 minutes, with the
   client sitting idle for up to 15s between attempts.

2. Indefinite hangs in sync() path

   ceph_mdsc_sync() and ceph_osdc_sync() use wait_event() and
   wait_for_completion() with no timeout. When MDS/OSD connections
   are down, sync tasks block indefinitely in D state, triggering
   hung_task warnings that escalate: 122s, 245s, 368s, ... 983s+.

   Stack traces show:
     ceph_mdsc_sync -> wait_caps_flush (indefinite wait_event)
     ceph_mdsc_sync -> flush_mdlog_and_wait_mdsc_unsafe_requests
                       (indefinite wait_for_completion)
     ceph_osdc_sync -> wait_for_completion (indefinite)

3. Stale mdsmap causing permanent MDS reconnection failure

   The kernel client caches the mdsmap and subscribes for incremental
   updates (start=current_epoch+1). During the upgrade, if the monitor
   subscription was lost (also affected by EADDRNOTAVAIL), the client
   never receives updated maps. The mdsmap was observed stuck at
   epoch 53 while the cluster had progressed to epoch 90. The client
   retried connections to the old MDS address indefinitely.

   Two scenarios lead to this:
   a) Active connection failures: mds_con_ops had no .fault callback,
      so the MDS client was never notified
   b) Silent connection death: messenger enters STANDBY, session
      transitions to HUNG via TTL, but no mdsmap refresh is triggered

4. I/O operations hung in unkillable D state

   ceph_start_io_write() and related I/O lock functions use
   inode_dio_wait() and wait_on_inode_writeback() which are
   TASK_UNINTERRUPTIBLE. During MDS failover, these block indefinitely
   and cannot be killed, accumulating D-state processes.

   Test results (20 iterations of MDS kill during active I/O):
   12 passed, 8 failed with hung tasks in ceph_start_io_write,
   __ceph_get_caps, ceph_fsync.

5. Wrong network namespace captured at mount time

   ceph_messenger_init() captures current->nsproxy->net_ns. In CSI
   environments, mount() may be invoked from a pod namespace that
   lacks routes to Ceph monitors, causing permanent EADDRNOTAVAIL.

This series addresses all five issues:

Connection layer (patches 1, 11-12):
  - Bypass exponential backoff for EADDRNOTAVAIL, use fixed 100ms retry
  - After 30 consecutive EADDRNOTAVAIL failures, reset the cached source
    address to blank so process_hello() re-learns it from the monitor
  - Force immediate monitor reconnect during persistent EADDRNOTAVAIL,
    reset hunt_mult to prevent accumulated backoff

Sync path timeouts (patches 2-3, 5-7):
  - Add mount_timeout-based timeouts to all indefinite waits in
    the sync path: wait_caps_flush(), ceph_osdc_sync(),
    flush_mdlog_and_wait_mdsc_unsafe_requests(),
    ceph_lock_wait_for_completion(), __ceph_get_caps()
  - Set a default timeout for MDS requests
  - On timeout, pending operations are NOT discarded -- they remain in
    memory and complete when connectivity is restored

Race condition fix (patch 4):
  - Fix race in cleanup_session_requests() where the request list can
    be modified concurrently during MDS reconnection

I/O killability (patches 8-9):
  - Make ceph_start_io_write() and related I/O lock functions killable
    (TASK_KILLABLE instead of TASK_UNINTERRUPTIBLE)

MDS map refresh (patch 10):
  - Add .fault callback to mds_con_ops to detect persistent MDS
    connection failures
  - Force fresh mdsmap subscription (start=0) after 10 consecutive
    failures or when a session becomes HUNG
  - Reset failure counter on successful session message

Network namespace (patch 13):
  - Always use init_net in ceph_messenger_init() instead of the
    caller's namespace
  - This is the final piece that ensures mon, mds, and osd
    connections all use the host network after the upgrade,
    allowing the client to successfully reconnect to all Ceph
    daemons regardless of which namespace triggered the mount

Tested on kernel 6.12.x with Rook-Ceph (Ceph Reef 18.2.5), IPv6-only
cluster, during rolling upgrades with active CephFS workloads. The
patches resolve all five failure modes described above.

Ionut Nechita (13):
  libceph: handle EADDRNOTAVAIL more gracefully
  ceph: add timeout protection to ceph_mdsc_sync() path
  ceph: add timeout protection to ceph_osdc_sync() path
  ceph: fix race condition in cleanup_session_requests()
  ceph: add timeout protection to ceph_lock_wait_for_completion()
  ceph: set default timeout for MDS requests
  ceph: add timeout to caps wait in __ceph_get_caps()
  ceph: make ceph_start_io_write() killable
  ceph: make remaining I/O lock functions killable
  ceph: force mdsmap refresh on persistent MDS connection failures
  libceph: reset source address on persistent EADDRNOTAVAIL
  libceph: force monitor reconnect on persistent EADDRNOTAVAIL
  libceph: force host network namespace for kernel CephFS mounts

 fs/ceph/caps.c                  |  16 +++-
 fs/ceph/file.c                  |  34 ++++++--
 fs/ceph/io.c                    |  37 +++++---
 fs/ceph/io.h                    |   6 +-
 fs/ceph/locks.c                 |  14 ++-
 fs/ceph/mds_client.c            | 148 +++++++++++++++++++++++++++++---
 fs/ceph/mds_client.h            |   4 +-
 fs/ceph/super.c                 |   9 +-
 include/linux/ceph/messenger.h  |  31 +++++++
 include/linux/ceph/osd_client.h |   2 +-
 net/ceph/messenger.c            | 133 +++++++++++++++++++++++++++-
 net/ceph/messenger_v1.c         |   7 ++
 net/ceph/messenger_v2.c         |  12 +++
 net/ceph/mon_client.c           |  39 ++++++++-
 net/ceph/osd_client.c           |  15 +++-
 15 files changed, 457 insertions(+), 50 deletions(-)

base-commit: 8a243ecde1f6447b8e237f2c1c67c0bb67d16d67
--
2.53.0

