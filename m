Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0B28D8DA;
	Thu, 12 Mar 2026 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303415; cv=fail; b=txb/FT92uMft3DJWWNN/XNRJtcGkz1tM0Ms720hgiFh4c+Ze5fi7Phx49uGKi1R10JBwElWH0cRCIhnZJg0jDKUb4PBX1KCXHFmfSuFM4n2fvPYsyQv33m3G1H3VbXEjGr/5i0duzxRJRrjghfVO3rbWE2NqHc7hGaKSGZqUEtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303415; c=relaxed/simple;
	bh=XkXNfXuGmMA99Wwbc/D8Jb+OOilyET0IIy8toHBxi0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u10cbfqSK2qeDo/l5obAu/RJ+zdn9AH4bBVY3WQUUpUhZULCsN1vNG1ThCNHoQ+4DTULa8LDE3McRqS5+BO9Hc0gb9Iwm9OucU/B1QX+bhGW1k8AqnT64OKCxDtD27LILBJXHuHm5kKcyvIphluZiZBZnndvg4mBN27foUrpgX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RvEBJw+K; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RvEBJw+K"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C5U2Hb3044191;
	Thu, 12 Mar 2026 08:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=gDIXXldpa7CZA/XfUCr79rBAbFjiAFc2QyJksVT6aaY=; b=
	RvEBJw+K39qoo2p8JxoWCyKsxCSJhHJglg0UFkvA1oxHShiTfTJ07i4y+uG7rF/R
	5j8seVnx/AQ1ERnmDqwWXiM+bHKnk5eWsRpjT0/gHZNsnyjFgSLrAdsBm5ccq1/E
	Z7Z4sRh9iEEF6E+TNecIxcqtuuNC3/otaslxSO8SjxDWBMjVqzSA/48N5guFC5Oq
	oe2p7vQFA/iFLtZvoWTX6I24d4s7SSaM+u9EzelfnqObgL/YQAQ+DoCQTOHIbvCL
	DIaOSFSop1IQgMPQTgOtdPeFaXnFy+74r9fnvDbhllqIhNw/xMYf5SIaxPtplNH1
	TH3ZtQX/pf8To24LF+0oMw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78gdvp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:16:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEcb+Rj0Vf0/PhOHCOmSb7eATalWkFA+3BdzJ8dd3iimHVfSLaeX/Fj0JaVUYIqYx7v5XPOLvn1bXCOLGjUF9aGIBi/NTeY/PRx+Od8LduETFND+WWy4Jys+MSkJ88VMe9uXWyHLS0dFdsA4ooEHcVc1TJjI59y4R8llbPxCkx0zXur8ELbcvE/a019zwJij2JbmIp00Tt2M4sNc3kbEV8fQEJ9HkfwPzrJzMyggTQgiogaa+EugP0uOAstugws021yqxV6lkWZ0B5bUSBrsbp5cLoW5KlBQZv+bZt6+Vwv1tJ1t29bR52Duu4sh97xaQbn/VKg/mzw530vDbklIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDIXXldpa7CZA/XfUCr79rBAbFjiAFc2QyJksVT6aaY=;
 b=T6h4BqVwkBpMEvigHBBlr9fOE9DgNmeAmBNpheLuVQ9cDBtawHG21ULP5hfE2sQMjVHpI6EGVBCiVFoyoN/5cj3II3LLNsxZ6RzDAk0dvq7SyKq8rj21s6D1RvY8Kk1Imbssdr6B34N+eRpINeQqAVRXBb1+2ioEgwq637Zu+vx7kYJlu0mbpW39M/kpR12bmJ9dXqZCrNugHniyVNOAW9zWTtbPryqDFaEe2nl6CNt2GW/14twB4EweEwvUsJVMCMNBf7zFDeG1sb8/Y5jVUj/6lOJ9omorSxgf8DOT2ivHZ3bAf4Xwapf3wXHWT1WdB4JKKFqC5bAZyj0qD5gNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:39 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:39 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 01/13] libceph: handle EADDRNOTAVAIL more gracefully
Date: Thu, 12 Mar 2026 10:16:07 +0200
Message-ID: <20260312081619.40854-2-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: e013758a-6c43-4b3f-c57e-08de800fafa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OhkvKu9yJaRq5YBfpOZFplWfuBqc9OaIuAKFKUced4M8RGa5rj5vFPqRL2PJ13fbsIgAhl64XU8uMlGRXehTFf5UvTqNQEtjF1b/5bDnhHNWwpnZ3KbVJslyIcDKRpQCgUtmt3jpxJBtMq3DN5wOfaShLRCLMPiEHjTJnsiJQkNvj5v3ZhQ6LyI4hEsX4dATGamlhH2oxYQnwykDlrOsJ1wDd+r2zWr2PxT6/Ox7x57y4vHweHbxfdNTcDTlKiJW6rERoQ4Y08ClDx/maAzFs+3FUXUJpWn1yMvTyvjXZLJamKPBWvzt+m1qVtZ38CzsPCGUey3W8MhM+iP7w7WxH8w0MacU88TOsS5rYXro4BJtc605MjgfSwat2L4cEChBnMA6/EDnJST79Ey7ecjHuvxsK80/hNA8lEbDPpoH53jFpgNVF/PNoWuJtrEquoKeAsPB8SsNqEcve+wWgE8qRyRe8Byr7qCJfS7Ih5ONvT54ZUcDm38fwqzKPhqw4alhYlp9bs4r9wt3eczrp/+LHoMvPKj+JBKpJ9r1Jm2pbiO9bJS7Mo0XxHd5qGKaqo6T+Zpcfjlcc57HupbT0xja2lidrz4tTkyTMrYuxJOvcc5Iw79QycWzSuEsDCMFqPeVASl9bc54EWVVHl1o9xC2By2YQKcnIqYWiEImMsbz3pL3LhCOLeBMBDo1aBGr5xuCNbV3nucLrDmeFpk5bQRMsg52Z1TIpvD7piKse6mZVsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?342UXeiucB6UHFx+7exqthxzcY8emBJglb1UBndlOe5UDtJgnt3VOoB2W2FI?=
 =?us-ascii?Q?wKoAB0XTg6IZF3meoPCyNXoWawKY5wFnWu51BaxtheG1RVWjM8aR4+z3Lnoo?=
 =?us-ascii?Q?qO6EnEmrf+1apwZJpolLVmGAhv9Vn3R7z0kX6b5nQJ5pgxXcaT1X6aIxDq8j?=
 =?us-ascii?Q?en9T3a9PT8CTHeX1KSWXdXT1q7IvhBKb6HOJWE5gsMJMxKp3B4i9ufSs2rL7?=
 =?us-ascii?Q?LbRfmnWRz2ywOqwI6wg0K8BQh5hYAKLZCqYG//hFuPR92s5pf5FraQRwW6BA?=
 =?us-ascii?Q?aR30CpIUpeJ219bdtxlS+QIAHXJ9aDl2xJOfKdCTulD8lvtLStlNOZqMsjQW?=
 =?us-ascii?Q?645nhHB2XqbeOi9HY70rKUGcJqpG95aABLM8x/Hl3/R54nIz5IKpmXg81F3i?=
 =?us-ascii?Q?DuiHPtu5k860pWrKa/9l6AaRopBNws0Pydos2/yicB9KGIE6wdmsMrilg/v2?=
 =?us-ascii?Q?PgQdJER2k5K6qyKZd1UU0Go5YJ5jE8OIqvi8EWyEIfUku+IXmkHV7Pt1mMhR?=
 =?us-ascii?Q?yQxW67qKgOsyp1JPjE8/KXYYK4sW3+5STXGYxD+RfsEJ7+fvC4Vzhxty4Yqk?=
 =?us-ascii?Q?TmFI2nqek9YxzkI0LVkt3Rqv1H0lKO3z5vvyzdxYyl97t2Yq2rarII3JgjQY?=
 =?us-ascii?Q?0G9r/5iBVjc+cQtUqpoWW/jXUY4Srkx1xuK54pnaYVit2vlCK8+jSIatTaTG?=
 =?us-ascii?Q?Uqg17aaalxBDWywl84Z7hMZuoMrHmZzzxxMnPn5JDpOJM7y9DtltTttlmnCf?=
 =?us-ascii?Q?o98WNqmKrQX94dgtoA7Dpygx4A00/fec14BBE8kBgcCW1pOQP7QhV2vrayfi?=
 =?us-ascii?Q?mkzfI6Ncyoa/mHKXimkv6npJLq75uzeKS95YaO5Ipxo9aY84eYe7tvW0tvjW?=
 =?us-ascii?Q?yf12w0COEz5pYQt89QI2EJ8Pupf+jqoTBW0rgZEdqYP6U5X3SBQtSRFH3rBO?=
 =?us-ascii?Q?WTB4T0VsmpR09xdFG/f/T9760Ff1qkBRMu5F7dfl8bK0FtbLqIxsfcTR6zXf?=
 =?us-ascii?Q?tn7YwJMtuMqYq+mPHVqcGxE184YEdwWpwCBL5xHerslxyafXNmF6UmAfiGPn?=
 =?us-ascii?Q?1vx2OJU6hzlRAxGiCusotiApN3RjhTBl3empgO3YWc33wFZqRBttuuZ0JIb4?=
 =?us-ascii?Q?rGZPAfoBXOdj3xao33XNcpF9bZu1RVjh+1YjCcqmkCn6HAbCwx1qiDGrU1ON?=
 =?us-ascii?Q?67mHJu/RUBe7pvESVz1DdhWvr3nzbkfihnO72Q10SFLXjVROYKWNBU33wuIH?=
 =?us-ascii?Q?ImmtqcjYP3bUaFIGXoqxb8oIm9RzPn4GK7WnjLZrCEfqeTFJe9yPbcS582SS?=
 =?us-ascii?Q?wY9SbZ6jRHdsQQyQkrnUgjlpOiJ2fMBzFY7jmCZCIonfif94bo3cfQ1N1CV2?=
 =?us-ascii?Q?4i+69gE23kZpEPk5MgAzGXuXfjKjajYk+v8Q/jFQv0PQwWyZIJNPifgvMDmf?=
 =?us-ascii?Q?Ia2lc3k6oTSTq4hVmDYvWXWZbhKGYwO+0aAPOqq2m8MI3hVDmrHuCiwNe9DT?=
 =?us-ascii?Q?Yx01TxgxkwyeAzBWhL9qPRk+HTJj6BFWyTJiGMJe2VxO/eMxBubleGKeIsx7?=
 =?us-ascii?Q?nirZPELO2lFkrpLYbLsmdAFXencJz2InaciV64nXM3yJEP6nxoBgXr24KwcX?=
 =?us-ascii?Q?GVq6zEhIenIIjC6iEyEorRx0M2+dsgtWxkdPFiTR4XR7DSDXb6augCgaPpRx?=
 =?us-ascii?Q?POlVuISX/q2AheUCxGUXFZRzxj/89myzy3mekeMVspG+nNXVudeD2/I9OCv7?=
 =?us-ascii?Q?IcrIb7+wAv9b1LagMpgB8XtPlvti+G1qAj6DVM9iDqD2IB5a+v7RLdVFaaVq?=
X-MS-Exchange-AntiSpam-MessageData-1: vZ1mHHV0M+W2WkW43+MZf+bIsJgktR7BhOc=
X-Exchange-RoutingPolicyChecked:
	Tasmnnrx+FyBSDDQJ6dyQhJyCDt4T+PqIgXnEC+swTKMVp1YwWJ1g1T3yd4eJ3HFtzMjA+3dqyECSCRptRLTGPHZQLP0/Cb+TRJsllpiSINd79tXfD8Z38p3wW0lTlJDZf8F9mJE5WICyVmffU6WX4OKM3Vgv39c25PzrxWeIjLkKKj8flRKnZLRiTYA49UNLi15uMeyasOkD9nRji0d4Ej3ZXt5KySbMzG3lmdAG+BR9d/fH5lvtB3FyOeIvreiNlsfZNF1x4us8CppmcDlWvWS5OZpFz/eanu4RwnFNO8aqB/m4Xj7lVnNFOwjxH+qlg85YeLPtcH8iwuaOzXQwQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e013758a-6c43-4b3f-c57e-08de800fafa6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:39.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjqUXMF96jw+aQkNBQv8BHOPzUnWl7+cPcPF4Y2fGz80cvKQrvEUznwiUZP5amD3TQWRGTv/kXBdfjlhyBEFpPYcRfV8bgjlRiGkBd+TFSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b27669 cx=c_pps
 a=+v7uXpzEFv5PX1YPhMLqHw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=1uu5jfe8Kc4fJiQIugQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfXxCbkOdm7929W
 setgyheODKnXIGvwsMf9LGbl2Vmfef4L3/8lWTD1M7HggerBulnSpOa/auq2t/hqMpd4v01C3DB
 lizxjuP5kinVgD+lR7JjJcEH3sTHtPC3ZE93vCu2fiDQLUsf9BghqJHm+N6AL5bUSoVlDY5iver
 P+VFDGjROmqIPKe1PyUf5WcNkppnAI618DDT/VYSOjB2eim1MKxv1VqQBVQ6sHuNM5M3hJwutmo
 9cOnp2/MFiStTXuAnN4fNbbfvsRz/NpuBr1Pa+6OzH+XA7RDPoVpRF4BpjwzX/Yad8Yho7Y4NTZ
 5+l0fWLuactA/MKR+5d8tIuBV16eUNHr9nbINn1XkqhjT8Knx57NyngIRXDjj4JgXIGeZxXXRN9
 jcEVIGldpSrHIuHUBi4QNk0y6EIaRh/0zCelUVDn3amf6Td/aBg6SBI/KEklOXHPSEyOY83rSYh
 hmddVm6AFYYbwcnkDmg==
X-Proofpoint-ORIG-GUID: 9V3lhcuEWMP4fO-2QzddipKnFQYWGDqD
X-Proofpoint-GUID: 9V3lhcuEWMP4fO-2QzddipKnFQYWGDqD
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

When connecting to Ceph monitors/OSDs, kernel_connect() may return
-EADDRNOTAVAIL if the source address is unavailable. This occurs
during:
- IPv6 Duplicate Address Detection (DAD)
- IPv4/IPv6 interface state changes (link up/down events)
- Address removal or reconfiguration on the interface
- Network namespace transitions in containerized environments
- CNI reconfigurations during containerized rolling upgrades
Currently, libceph treats EADDRNOTAVAIL like any other connection error
and enters exponential backoff (BASE_DELAY_INTERVAL 250ms doubling up
to MAX_DELAY_INTERVAL 15s). Additionally, the monitor client has its
own hunt-level backoff (CEPH_MONC_HUNT_INTERVAL 3s * hunt_mult, where
hunt_mult doubles up to 10x = 30s max). These two backoff mechanisms
compound: at steady state each monitor gets ~30 seconds of attempts
with connection-level delays up to 15s, and the round-trip through
all monitors takes ~60 seconds.
In production testing (6.12.0-1-rt-amd64, Dell PowerEdge
R720, IPv6-only Ceph cluster with 2 monitors), the EADDRNOTAVAIL
condition persisted for ~36 minutes during a rolling upgrade:
  13:20:52 - mon0 session lost, hunting begins, first error -99
  13:57:03 - mon0 session finally re-established
  ~470 failed connect attempts across both monitors
  sync task blocked for 983+ seconds, triggering hung task warnings:
    "INFO: task sync:514917 blocked for more than 122 seconds"
    ...repeated at 245s, 368s, 491s, 614s, 737s, 860s, 983s
The duration of EADDRNOTAVAIL varies by environment: it can be brief
(simple DAD, 1-2s) or prolonged (complex network reconfiguration
during rolling upgrades, minutes). In both cases, the key issue is
that exponential backoff up to 15s wastes time once the address
becomes available -- the client may sit idle for up to 15 seconds
before attempting to reconnect.
This patch bypasses the exponential backoff for EADDRNOTAVAIL by
using a fixed short retry interval (ADDRNOTAVAIL_DELAY, HZ/10 =
100ms). This ensures reconnection happens within 100ms of the address
becoming available, rather than waiting up to 15 seconds.
Implementation:
- Detect EADDRNOTAVAIL in ceph_tcp_connect() for both IPv4 and IPv6
- Signal the condition to con_fault() via an addr_notavail flag
  (per-protocol: v1 and v2)
- In con_fault(), use ADDRNOTAVAIL_DELAY instead of exponential
  backoff when the flag is set
- Clear the flag on successful connection and when reopening
- Use pr_warn_ratelimited() instead of pr_err() for this case
The fast retry is appropriate because each attempt is inexpensive
(kernel_connect() fails immediately when the address is unavailable)
and quick recovery is critical for storage availability.
Fixes: 60bf8bf8815e ("libceph: fix msgr backoff")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 include/linux/ceph/messenger.h | 11 +++++++
 net/ceph/messenger.c           | 55 ++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1717cc57cdacd..730a754353aed 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -320,6 +320,13 @@ struct ceph_msg {
 /* ceph connection fault delay defaults, for exponential backoff */
 #define BASE_DELAY_INTERVAL	(HZ / 4)
 #define MAX_DELAY_INTERVAL	(15 * HZ)
+/*
+ * Shorter retry delay for EADDRNOTAVAIL. This error typically indicates
+ * a transient condition (IPv6 DAD in progress, address reconfiguration,
+ * temporary route issue) that resolves in 1-2 seconds. Fast retries
+ * allow quick recovery without exponential backoff delays.
+ */
+#define ADDRNOTAVAIL_DELAY	(HZ / 10)
 
 struct ceph_connection_v1_info {
 	struct kvec out_kvec[8],         /* sending header/footer data */
@@ -360,6 +367,8 @@ struct ceph_connection_v1_info {
 	u32 connect_seq;      /* identify the most recent connection
 				 attempt for this session */
 	u32 peer_global_seq;  /* peer's global seq for this connection */
+
+	bool addr_notavail;  /* address not available (transient) */
 };
 
 #define CEPH_CRC_LEN			4
@@ -430,6 +439,8 @@ struct ceph_connection_v2_info {
 
 	int con_mode;  /* CEPH_CON_MODE_* */
 
+	bool addr_notavail;  /* address not available (transient) */
+
 	void *conn_bufs[16];
 	int conn_buf_cnt;
 	int data_len_remain;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9f6d860411cbd..c40c7c332e7f4 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -466,8 +466,22 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		     ceph_pr_addr(&con->peer_addr),
 		     sock->sk->sk_state);
 	} else if (ret < 0) {
-		pr_err("connect %s error %d\n",
-		       ceph_pr_addr(&con->peer_addr), ret);
+		if (ret == -EADDRNOTAVAIL) {
+			/*
+			 * Address not yet available - could be IPv6 DAD in
+			 * progress, address reconfiguration, or temporary
+			 * route issue. Use shorter delay.
+			 */
+			pr_warn_ratelimited("connect %s: address not available (DAD/route issue?), will retry\n",
+					    ceph_pr_addr(&con->peer_addr));
+			if (ceph_msgr2(from_msgr(con->msgr)))
+				con->v2.addr_notavail = true;
+			else
+				con->v1.addr_notavail = true;
+		} else {
+			pr_err("connect %s error %d\n",
+			       ceph_pr_addr(&con->peer_addr), ret);
+		}
 		sock_release(sock);
 		return ret;
 	}
@@ -476,6 +490,13 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		tcp_sock_set_nodelay(sock->sk);
 
 	con->sock = sock;
+
+	/* Clear addr_notavail flag on successful connection */
+	if (ceph_msgr2(from_msgr(con->msgr)))
+		con->v2.addr_notavail = false;
+	else
+		con->v1.addr_notavail = false;
+
 	return 0;
 }
 
@@ -609,6 +630,13 @@ void ceph_con_open(struct ceph_connection *con,
 
 	memcpy(&con->peer_addr, addr, sizeof(*addr));
 	con->delay = 0;      /* reset backoff memory */
+
+	/* Clear addr_notavail flag when opening/reopening connection */
+	if (ceph_msgr2(from_msgr(con->msgr)))
+		con->v2.addr_notavail = false;
+	else
+		con->v1.addr_notavail = false;
+
 	mutex_unlock(&con->mutex);
 	queue_con(con);
 }
@@ -1613,6 +1641,8 @@ static void ceph_con_workfn(struct work_struct *work)
  */
 static void con_fault(struct ceph_connection *con)
 {
+	bool addr_issue = false;
+
 	dout("fault %p state %d to peer %s\n",
 	     con, con->state, ceph_pr_addr(&con->peer_addr));
 
@@ -1620,6 +1650,19 @@ static void con_fault(struct ceph_connection *con)
 		ceph_pr_addr(&con->peer_addr), con->error_msg);
 	con->error_msg = NULL;
 
+	/* Check and reset addr_notavail flag if set */
+	if (ceph_msgr2(from_msgr(con->msgr))) {
+		if (con->v2.addr_notavail) {
+			addr_issue = true;
+			con->v2.addr_notavail = false;
+		}
+	} else {
+		if (con->v1.addr_notavail) {
+			addr_issue = true;
+			con->v1.addr_notavail = false;
+		}
+	}
+
 	WARN_ON(con->state == CEPH_CON_S_STANDBY ||
 		con->state == CEPH_CON_S_CLOSED);
 
@@ -1644,7 +1687,13 @@ static void con_fault(struct ceph_connection *con)
 	} else {
 		/* retry after a delay. */
 		con->state = CEPH_CON_S_PREOPEN;
-		if (!con->delay) {
+		if (addr_issue) {
+			/*
+			 * Address not available - use shorter delay as this
+			 * is often a transient condition.
+			 */
+			con->delay = ADDRNOTAVAIL_DELAY;
+		} else if (!con->delay) {
 			con->delay = BASE_DELAY_INTERVAL;
 		} else if (con->delay < MAX_DELAY_INTERVAL) {
 			con->delay *= 2;
-- 
2.53.0

