Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46953D3CEE;
	Thu,  2 Apr 2026 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149623; cv=fail; b=gSIkfEaouX8cimGgglHB8yp9YQL4bFej9uPnR4EwYV+NIrGc3OTsjIh1Pz5BYGNB7t2dNsmSIAcCqd6MjAfE0Yq0Uhn+Y4CgyS1AZEz5y9XTNLKWdjBEpYrA7QcB/ts54NqERPM8t2MmnXnVlb5UY0rfB/XB5nZnfjzNS15MGvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149623; c=relaxed/simple;
	bh=lJJ+RKWXJs7vEsjtrT3mZO8bEA0mdYN+v18HyXjt4ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uX0kM8rt07ZPJOIj9vTUpY7AQvpvw9sxfnuBkedX60OFhT0yUcqKt7OgSRrawFjJxgEfxJ5s3L2f1cu1uyen/dIqySnYUQqj4Zuh2UeTqZFiGfi4wUwoVVGVtC0nS+pG9zLF/teMBspsi5Wx17bac1rxmVYoYVLjC48aBjH4E+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=iwxtyRjV; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="iwxtyRjV"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6322nsnG786371;
	Thu, 2 Apr 2026 17:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=aiAuJ9wZEZIHYAfBJq+EUiBh7FmUai6ze711+ejIuXE=; b=
	iwxtyRjV+GlxafYT7Dz877KKqD7xVVFZUz4xqyF5Umi6R4wxTZEc8El5Z5h40wRT
	Be1F/TOR0DB/M8foM8/p3fQwv0zQM9mcEOC8f+z2NhzhJi+2vbTN5AoY4QMLOYBz
	c5uNgm/dSL2II4Bht3fRmuqXQij63+J0fKfFD81SgyvQctJ4ip/h7lf2W9iQjGbQ
	oB1ab0z3NAgTFzsQpW5NhJrKP5LZejwS3uTrpd1A2sIV6goGqjOUPOMWkyPP5jeN
	8BV5r3mCA8bFefLCG9151+wx5fZxJCOYrULTJg1A35JA542m72ilN9fStXO5cDUF
	sKMLXlV0zCDvRGyuOS8c3A==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4g9bt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 17:06:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXC0d78P4z2T/1wg6ll/Ij5tkrCzWGrUHwmdUVAxT7bAzVv77fqNMCNqdzDLRGrFiy2FG4n/MDElDt/MHkhaJ6ufqwkVcwEARRs1Hjsts/py64X73b9CW/dI8IL8HMEdSA9Yd/ryDjGNX7fEkX576NV2/DsU7WLYTCo0/ScOee41c6yFBgAt/tGDV3GUSaNUuKSWf9sKQS2lAWSiXMprgRdeMxosBbwYCG+0X6yFMXgIbUnFPhluD+xUcBbND9YB6LyOAbsfjH9DDePUMFgTkQth8c6h1Jk6MunJKcAMLqKiKsRxLMDQb+ca2+xGZJpVMlGJyXiDO1NFfZSa7z3b2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiAuJ9wZEZIHYAfBJq+EUiBh7FmUai6ze711+ejIuXE=;
 b=FCnCvk6/Bn8tLK98X0I9Q2ZPr+/4lEVGjrtytUup1lLXykdFYxRyx9Kp+cUYJszBMNb0p9BeG8nzbv1KHO4cvceh4ZzCYaCCg9PWquvLcAxlq9LY+EIeLeSJgHTi34fgZK/OJSVABMQNaKuzTg6AawfYOgMP63rceGXRIiSmpVFxVJmjJlC5EaxcYofg9kiMrNs2ZLEI4Q8+lxMTeMKLYLiIEeX6KICzpwJAOmG1SE6oYWD+6YymBcwr51jAG4EzKPiFA3wyAJ02CUMtYFMRDnf5i8b3yPrFvI5ho96xZCBtgr2Spx5cYElReA+gAii+SiDyo+tSAHPcBuR/QAv5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 17:06:41 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 17:06:41 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, ionut_n2001@yahoo.com,
        linux-kernel@vger.kernel.org, xiubli@redhat.com
Subject: Re: [PATCH v1 13/13] libceph: force host network namespace for kernel CephFS mounts
Date: Thu,  2 Apr 2026 20:06:20 +0300
Message-ID: <20260402170620.575757-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316212041.67098-1-ionut.nechita@windriver.com>
References: <20260316212041.67098-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4bb64b-b90e-4668-1667-08de90da35bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v46EdAc2QU0TOJ1i/8JrzWDTyE1r8BmywDITGlrP+i8AuNw4hAcNYyfe0DRUGIBWBn3SV1mC6xA3ggeIbNn/3q65ZIfJS2+t1Egxoi5F2A1gyqSNoKsFRLJm7s10VD+bMlKjzc2bQSakP87fwXitrg011WUWMsh5iSrxPByPggXVVThN1kCtXXhOdyimnSFi8Caf1jPA2I0RoIBMgu3Ap+nsW3TgioDHLVIm0sgSB9U4miVcAM826IJHfFsqPW+oCWwrKQKzqU0zqxqQYVFcWkSCTGftZMtyv9GU8m5bzwgUdfKNpYlPncvXMWf0TdTcU02nUfKP82Xrq/Kscft38E6aoWrXN8bVHhKKsBzpyXavSQI3mptvjkFdhyhthLnUJ21q3rwDjN9OWYt5z5fsc/9oHz8WCu97jUsK0Txt2wpgIDAEmczeGrYBZcQgviw6xJ0GHyCnoT9w4MT5Sy/sBkiv40ktG2hiCk9DOURgNOjlNrpB0hSHspb0ROfHjw3RX93jWCpLAAinqvIxZGiEQ7vK1O/CVRuIkrIT/51rb7beWxHhy45C5ori94L5ugnNG0hAIc1ahcJCHJ0HV4uQtcqoZ+2Y3LmE75wB8mIyMfkmHTP9HlqPZ2SZJvpBNpvk6Bu8QZ5f2mzrYHgtsYh+GaETCS0EdBiFyxl6X6uns3lzKUrBQKiYRn+t/qAYTNBT35TxBa1XaJTnMmAuv/ItWY5rUvv7vSmugtZMY9wg5l75OQmUiRSld3bI5w55KbN0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QrXVnmn306zDQlNhIFMW94rBjeY/TAiaLGVURvPvAIrfXvFR/+QIjouj5t4f?=
 =?us-ascii?Q?6wlLWWjjNIUYfpif61hT584SO7GJlqNRHhLuuSJ0TX/mkEwkBo2ktB4R59DG?=
 =?us-ascii?Q?9tgeGjo9/NfoIV/yfdJsi57L/YdAgNtLh7Z0fDnWV/nVPzH1OHU5NA3XRGMa?=
 =?us-ascii?Q?7aQRyO6qab7vIUaHoMsfrTXWBVWeV/hGTGTm+IQcz2ju/v1Hk8GVPR8wuSjc?=
 =?us-ascii?Q?MLc932u570tgOxjg9y/MqdUGNlKav2fWfh5++KPe4r3vvl9QNebY7uCVuNvj?=
 =?us-ascii?Q?dLoGsFpsEOoQygQD3WO1p299HX1UHQd/WB5pzUzZj3zGlXIgG2zw4E0Ln7Re?=
 =?us-ascii?Q?fa+L+txwXHnpZ/UYclqADpTPEAPkGhBieMQaH5i+ZK7Tausweaiu62PjHG1z?=
 =?us-ascii?Q?U5mUFpi9JbjHuLtbKN/K88GWqxQBCJr3hF1Qa3sV6TJdz05INsm0z5u3nEkF?=
 =?us-ascii?Q?dHenLEc54dVXRSOYGBnWMtCe5fyntvViNX+CzFz6/a0vLdTO+Hnanhis13d0?=
 =?us-ascii?Q?OJufD4vNNcjGxXhKDFOCWte6i0H7tHwtP7DFaMALufpAfysAxOELnK3o6oo+?=
 =?us-ascii?Q?YisJOvmugAYavBaH3wwmyzoak6LTlNE3sidlnnCzT3IJ7qKYqPsKwpH8gVS1?=
 =?us-ascii?Q?0PIvJ8fX/GHZ3lb5CHNurrE6yN683CCO/7csZtjFqwqaPbMQDna7+RAedm/l?=
 =?us-ascii?Q?uT2vdlqFWWAFlvOmcG7fAi42f8/93kfHjITM1IZ52LJ0nmGt9gionwRCNvjT?=
 =?us-ascii?Q?DQ5XAg/RLOC3n6c/LElSTDEhZp80HOY/sEczwwO2f+2X7z4q5pCmI9hWdjik?=
 =?us-ascii?Q?90HLndhRg09emxYQZOD56KDNM4BK0cxwzaeKaAafd+qL7IjSi0HyEuO6fk/4?=
 =?us-ascii?Q?uaVmEaXyWa/jX9B5BNbq0eT1P2NWY/e9PrmQuPHkkGe5H2f1xxHFsiqRf9B4?=
 =?us-ascii?Q?OEdvRKWrc81TNA83/H5+S/v1MwTVQf114SzL6BwO2c65NQQAvnqowhkRlRVm?=
 =?us-ascii?Q?PRPZ/f7LNskd3EXPo0r4sLtVn0DUqD7DK+CDCjupohbg7KxZ9X8U3v0i0lwp?=
 =?us-ascii?Q?kDN0+RqzkqyHAy99sBR0puFxKVBN4vReP/7b6KMuTASP4wcVI0OoGmOcboW+?=
 =?us-ascii?Q?rNEIDlvi1pXutjqDXoQjvOxLW6stUB+vpMvfOUrrMWSoN12NqFy3dSzbkLfO?=
 =?us-ascii?Q?SO1Iw+arDEUiS+yXhpn7G1JGmYKdtkqwSV34cWaz5TrREV5DeSgFbXrBMlXG?=
 =?us-ascii?Q?ppemUK6IM8GQiGUHnT8TkEBfdF8vKsOXxpHTCA8g8Jlo53bio3VLkYdFqetK?=
 =?us-ascii?Q?TzdushqObmLCJFcqoGtHDwiACEyUbjo6vCOkkGXv+CbOXsGHBamUvVkbtOCP?=
 =?us-ascii?Q?0sgJkjsaBHG7GIytF+gCjEUxaq/mGiG5teFLdPmYcGJJPh4t/QREeUstNjMB?=
 =?us-ascii?Q?opTDQq5ZcwUS8kPyVSXBHUpIMwM7It4aQwPllVDWQKsm3CuHSUFgzEUzqNNG?=
 =?us-ascii?Q?AXYwiNzHySd7xXOpCsvblmkeORmHp7gwEdLSDyJZewaAeRawzj1tCEa1tTkg?=
 =?us-ascii?Q?fIhS4iG6uu9tE97/WyMnS3z6xxP+FaESbQPJhllM0ixNjxH147X8wpv+Hhgx?=
 =?us-ascii?Q?r0716HJmRZ3eltRzoIXNdcVLnqtlUIczW5YFhBvaHg88WPyDDOh9EPt5X9iz?=
 =?us-ascii?Q?/x3Nll0NdBJkN1Ndrj57N0KeCre+t0TvWD4CIJSW2Q/EdEDW1X4i9mtWVfop?=
 =?us-ascii?Q?lLA2A53FV66kUhGSJSD3VEjxzv4KKso=3D?=
X-Exchange-RoutingPolicyChecked:
	QXh+Tk0WIVBzXmRl/bVxzwk2q50I5noio7vMlZiJYU78QKW/UBbTan5JgVqLJCMTMjar4fT/0gbvpwikgJL9qknc1WPmtELhHex/9WltiCNuWDWGhRnkHTJffZA5l9HuPSJCpnx5Vw/i1HDhOQYvMS0szgtLe2DekJWeHRzDItzUyaW8+4utI2t4othJeABZLG52fc5ANxfAX2KYphOVyudFCoPeW/5wXpFxDcwlY4H7B0i8VE+wPB7UMqfW38CB7iFeCIQZIKAErRi/UKaHVGGMUZTmXcgQlmTXgPp5EBjGC7hBL/BJsEeLrUPGnynwf3+GEa8yFcXffpZbVkdh/A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4bb64b-b90e-4668-1667-08de90da35bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:06:41.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCG44Is0Vymo8NvCh7hT/GJQj6hj/0EAY41OX00F+/KHTYGuwJNFQhA2k1os2TpayIt6gfU7Eu9m7NBY37d9RIUVsSp5ha/RBm+8WcV5vZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cea224 cx=c_pps
 a=CrKnoqqb99nOpAJSR4mnrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=4u6H09k7AAAA:8
 a=mXWxCJuavaFtOZvtEhoA:9 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE1MyBTYWx0ZWRfX5YQXo815Gi5U
 0scfYMSjYIfgb7xY2SaJl+r/ktOZEa5JpA6I6bm3FUpdo7vWUTqWL4a6DpcsioP24hqYNdmqcPa
 ifSuwSFgjNnUwHqESWWaSCxjtSSRbLoo+iTLpz/w3RoZSxWbscguZfqfSXT8hIs2DJu1bCpxyYn
 V/Qf6Y6qLongR6h03a3X7G9ju0v4wySAVtD3Sqcnh8vTRG0efWZxHRSZFQDNSquFve3jGbOqjeI
 jgoqPt1Q/4P2AiT5f1wVi2cOkXuX7AZL+NniLtJErY7M8H01vmaTvelYlWH9YfCuLz+C+EojpxY
 OPB6fvlX75x9+ox3LdH1D8BgrSIQsSRH1ofQEUXXqLtaRA6C+PmHiLVK20oYs6vx1KUestns8LW
 wUaBHkzPAikbiwBllny9eVwLsiET77BENSaoXVj4eY1+xip8qvKjfXaf+ndMU/8VuSRppqlj1vH
 HMIOPgGlpxqwLFg578A==
X-Proofpoint-GUID: QOkGRZenEMwdgFo-gKhaIIcaZBmUhs4c
X-Proofpoint-ORIG-GUID: QOkGRZenEMwdgFo-gKhaIIcaZBmUhs4c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020153

Hi Ilya,

Following up with the additional data I promised. I reproduced the
issue on a fresh cluster and have concrete evidence of the namespace
problem.

Environment (4-node cluster, 2 controllers + 2 workers):

  $ kubectl get nodes
  NAME           STATUS   ROLES           KERNEL-VERSION
  compute-0      Ready    <none>          6.12.0-1-rt-amd64
  compute-1      Ready    <none>          6.12.0-1-rt-amd64
  controller-0   Ready    control-plane   6.12.0-1-amd64
  controller-1   Ready    control-plane   6.12.0-1-amd64

  - OS: Debian GNU/Linux 11 (bullseye)
  - Container runtime: containerd 1.7.27
  - Kubernetes: v1.29.2
  - Rook: v1.16.6
  - ceph-csi: v3.13.1
  - Ceph: 18.2.5 (Reef)
  - Network: Calico + Multus, IPv6-only
  - Pod CIDR: dead:beef::/64 (Calico, vxlanMode: Never)
  - Service CIDR: fd04::/112
  - CSI_FORCE_CEPHFS_KERNEL_CLIENT: true
  - CSI_ENABLE_HOST_NETWORK: true

The scenario is a Rook-Ceph rolling upgrade (Ceph 18.2.2 -> 18.2.5).
During the upgrade, Rook recreates the CSI DaemonSet pods and various
Ceph daemon pods (MON, MDS, OSD). Kubelet then needs to remount
CephFS volumes for workload pods on the node.

After the upgrade, the kernel ceph client is stuck with permanent
EADDRNOTAVAIL (-99) on all monitor connections:

  libceph: connect (1)[fd04::652b]:6789 error -99
  libceph: mon0 (1)[fd04::652b]:6789 connect error

The monitors are Kubernetes ClusterIP services:

  rook-ceph-mon-a  ClusterIP  fd04::652b  6789/TCP,3300/TCP
  rook-ceph-mon-b  ClusterIP  fd04::c0e7  6789/TCP,3300/TCP
  rook-ceph-mon-c  ClusterIP  fd04::1981  6789/TCP,3300/TCP

Here is the key evidence. The kernel ceph client debugfs status shows:

  $ cat /sys/kernel/debug/ceph/*/status
  instance: client.374328 (3)[dead:beef::a2bf:c94c:345d:bc66]:0

The source address dead:beef::a2bf:c94c:345d:bc66 is from the Calico
pod CIDR (dead:beef::/64). This address does NOT belong to any
currently running pod on the node. I enumerated all active CNI
namespaces:

  $ for ns in $(ip netns list | awk '{print $1}'); do
      ip netns exec $ns ip -6 addr show | grep dead:beef
    done

  ...bc6d  kube-sriov-cni-ds
  ...bc70  stx-centos
  ...bc73  rook-ceph-mon-a
  ...bc74  rook-ceph-crashcollector
  ...bc75  rook-ceph-exporter
  ...bc76  rook-ceph-mgr-c
  ...bc78  rook-ceph-osd-0

Address ...bc66 is not present in any existing namespace. The pod
that owned it was destroyed during the upgrade, and Calico removed
its veth interfaces during CNI cleanup.

Meanwhile, the CSI plugin pod is correctly in the host namespace:

  $ kubectl exec csi-cephfsplugin-gdrqr -c csi-cephfsplugin \
      -- readlink /proc/1/ns/net
  net:[4026531840]

  $ readlink /proc/1/ns/net   # on host
  net:[4026531840]

And from host userspace, connecting to the same ClusterIP monitors
works fine (goes through kube-proxy iptables DNAT):

  $ python3 -c "import socket; s=socket.socket(socket.AF_INET6, \
      socket.SOCK_STREAM); s.connect(('fd04::652b', 6789)); print('OK')"
  OK

But ping6 from host fails (ICMP not NAT'd by kube-proxy):

  $ ping6 -c1 fd04::652b
  From fdff:719a:bf60:4008::46e icmp_seq=1 Destination unreachable: No route

So the situation is:
  1. The kernel ceph client captured a pod network namespace at mount
     time (source address from dead:beef::/64 proves this)
  2. That pod was later destroyed during the upgrade
  3. Calico tore down the veth interfaces in that namespace
  4. The namespace persists (ref-counted by ceph) but has no
     interfaces or routes -- it is a zombie namespace
  5. All kernel ceph connect() calls fail with EADDRNOTAVAIL
  6. No recovery is possible without force-unmount + remount

As you noted, this is the "orchestration tearing down the relevant
virtual network devices prematurely" scenario. The namespace is kept
alive by the ceph reference, but it becomes non-functional.

I'm still investigating exactly how mount.ceph ends up in a pod
namespace despite the CSI plugin having hostNetwork: true. I have a
monitoring script set up to capture the namespace of mount.ceph
processes during the next upgrade attempt. I suspect it happens
during the brief window when the old CSI pod is terminated and the
new one is not yet ready, but kubelet still attempts to mount
volumes. I'll follow up with that data.

I've also filed this on the Ceph tracker:
  https://tracker.ceph.com/issues/74897

Thanks,
Ionut
