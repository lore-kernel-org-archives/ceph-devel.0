Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7C358D3D;
	Thu, 12 Mar 2026 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303429; cv=fail; b=qqKJrGNdmVOJgJray5MtZQqv3KyEciTya0ztXUNrNDV9Sa7waB78AnTvPFxEiTJ5bACuFbcv5cI2+aqES90ad4+02nf5toaI8iWU57L4rcoe37wh5EKJ5QJRoG0pOREcLBbndXj/BUfg3Ra8zlQu5BMZqfM0r2QFAsrmuZbvpfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303429; c=relaxed/simple;
	bh=/X/rJ426oDns/1aY2eCPS7Znev/S+pGXnn6ekwEwACk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sl7o6epXiSrAM0KNnXuIUohO6lZ08f/jg/GagPTcnOyIdU0+nFRT0h9hm1LzJeajiomDTw7vq+bZDAa1TTkNYvkPuch3duuRKMTF4jCn7p7MwJ7lrvIAExh6ap68w9B7/PSuiUx+kBpGI53wp4zo4bey2MBI7QPYJc39H/VF25U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Gg3qiAXe; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Gg3qiAXe"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C58umW1757210;
	Thu, 12 Mar 2026 01:17:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=gWJLPplyKhQueZ/hNkK1BR3VQIvJxWNDSgrFyNlUUcY=; b=
	Gg3qiAXenH0/A8WQ3t11L/P6x9gat4YFBWbh4iIw9wbnhQpul6jC2NQyI0zplJDL
	OQz5g6/8ORBczp7BlnphMLAJqllKXpVJJ4AxHFiDshUDQ3VCPCqoQZtzcxkf2ioH
	GXhk8AMPuoI5Gj+us6DPKkwV/+BB01W4GqMfLS5Q9jkImIKYK50waZbNRXGX03/T
	XmZozGGW9hTELbSY+lqajEfvMCCngfr2zvpwBKxZbvLX4t9sLoh7CQlzm5evV+To
	vu47V/1booVNwk/XRuJpfKVk2p+EBLzndHktHnBvURBnhk/b6fweLsa99zGOkKzt
	mxdBks7JFlBOpzm+sweiXA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6t8enf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 01:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8CQ5HNiZhB642ZSteWPAdBXs+X2i/eUm9uULaQi9lO8k/vlEsrS42VB454S8XUhJ+qqlCxCzCwPEEYuH/6Nij00Hg4smlajE/tIZ4+Qu+DZ98MvJAIMY/BbRhnLiQJmSRwnTMe8XERKbWSiBX4nJSu+adlaBL3DofaWGiexLe4tsYqZNpEhmToBXzbT9lz5EFIUiQlYjP6oHKNVk3giZlM7McAlqeujj6EpT+IJdoopIx7MahYYf/t7FGekES/+6imBAOc8SEa0aqqz/Aq5eSZYYLL1iFdWi0BYFYqotjfUQA19ug4n9hJRt15U6feqxAgmjmzEFqqMfFmT6eEjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWJLPplyKhQueZ/hNkK1BR3VQIvJxWNDSgrFyNlUUcY=;
 b=GxMyuLJ1wzeNel0jD6F3olxXnsWAEeD1Np/SbOqLAvhINZTIs3R8oxxQfhec4E7UhBv7o/lIsg0et3D8hx3eP/BbE+Osm0FNa7uKCh6St2IYWhANGpz91IojQedlnD2yeUwtXTs2uUqsJwRskTT/xo4JJ1cQw6Z1RSaOvR2wTpoD9peF2Z0qNuPbSb/J7m9wVx/iQgLUUc00hlRF5zbFKiQlAiK9t0n/pF94gd9lUTPwQBKxt/NYt1GDqNaj2A+/oDP2/n65sDAmosdFHmC3hftQOOaZWPQnoqdFV8uUWn11X5F+OwnwELjV9TYyZrjon8c7T9qiKbONFoHvxGCuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 08:17:02 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:17:02 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 12/13] libceph: force monitor reconnect on persistent EADDRNOTAVAIL
Date: Thu, 12 Mar 2026 10:16:18 +0200
Message-ID: <20260312081619.40854-13-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DM4PR11MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: c915df10-9cfd-40b6-f282-08de800fbd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|10070799003|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Cwx5U0zrv5vsbYM7y1TpVyd94S3gm/uywYKXYwMg/QjUdGofiJNvr24/6E6ZZQEwNINc0y5wvhQHXl6RoT7PFlX0xuNdBFeL/dqCNJQ3gW59zMwFzVmaa8vO7S9EjsHjw0xT6+NxvQpMMBNe7xk5lf2AdslD2xoBnLajHZQvHt0WWWizrmAkl2wnkgVfSt1d6Rju5UhQ/SS3OV/CXBa+Wii+YgvVv4TzH6cKDSaGS1ToAI7rmBA9jszyFL2Y+ncf0QqRN1irUZ72IMyBTB3Vb8rFSnqrCSnY1yvjrtCQKSK5ELP8tHd5QhTeb4t07f2u3UArWG0moEliWd3fvh85yEWXMebmgS1eWr+5A4/grSGfOTRtx0EcRkMSBLDZ2Mkv1xWunfAYLcYvd17SbjVVi7MnRJYRpD9mt4onWhNGGoc0TDBT/SZZ90HOmXDWpc83c01srBplcZ14LKzMmxyiVeOKgkhEzUTayOJ3UpwjmdxR1YgVPAVoTfq42+XIP6l2WUGG92WqU3aFdqeeoL8EFDZmLeN+FZAVJ2zTkMR2aTh2K7AZlEKQJlO3SAPlk1NWPh1AjtaszSRwqy6RpCuokE0+Nc/0D0RS0B5qrxMGXb79Ql/0v0ViFoNC9X0n283ECQMmq/ykZeJpZ8NHKnhlMh/zYX4WDBNdz2ESch8PDU9MdyL1hz5DPGRe0ZbTbwooi8iwRZ8cLbOCcHGCKkhzpKOvjO9KtY16lpnIjM5VL58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(10070799003)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5hkf4mZEgm5nuYft+nWbPrMmzMCRKn3rK3WlfRvMEpsMx3rSJOEVga1O6Hk?=
 =?us-ascii?Q?s0qly/Sr/wj2wc1xp7qonzGFhO5WLE/r0rVcX+44cv+RRz3boFoI0nHMTiRv?=
 =?us-ascii?Q?9vCFBn4oRot1kckx76NVHBNR2ad6B5HuOYcf4Cmp2xD33l8xpR1g633vsZ9j?=
 =?us-ascii?Q?vUkM3N70FHO3iejXvrGFLvPaLBOwglt348IitdkkV5sLDWaD/aVAvYu+6M/g?=
 =?us-ascii?Q?F+03NyA8Uy5fFBQSZwBJcFamih4Gemy8sNvfwyJifF9W5pC6/fcaHhwlraXw?=
 =?us-ascii?Q?5rCM+GdKvhiDZGIAqRG2Ba8WY77Vdq8zFVblI9vL79JrRRcLd3wE/KiG5QHm?=
 =?us-ascii?Q?VbNhV8CGAWjZXwl4iBQIIP48CpFSAdNoeGmw6pT+9vk2icHr7xUv2wrvyn3x?=
 =?us-ascii?Q?RKjHqt2UkScwPDZBGEJzag4+CQAv7OXnX77ywtBLC2uQO030HDfyuWGQuOyc?=
 =?us-ascii?Q?z5fjDDBrpXJj3FXVaJJ3SxGOf+fNhzU2FhJkb9txl1hp93gHLzudYT2wQEiH?=
 =?us-ascii?Q?4qMlTUClM5LI5iaGugW8f9vd5KI0L9ZSxSNngSmpFQ4yLqtDFUVEXpuhkEgp?=
 =?us-ascii?Q?NjPnAK4s54cnYnb2+vMb03YqZPrW3AHhQy9dTRBT8XuR5DP5LB3ZLnQNAe4D?=
 =?us-ascii?Q?DlREi03pV5oNV6y+IzH5GnlogAFbA9aHe23iHd/vIn7ly2YUJVauxstQC4Lf?=
 =?us-ascii?Q?bxdNgqhEB/vAsF89A8TUULeB5Q81R/lKByLTF/pl8rVPB7LDrF/Ha79OatA/?=
 =?us-ascii?Q?ERQC8Bz7FgNP5U1VqiAZRk1+7kZn4HE+ThfsfLhnyJqwT1VQ6qhb4TKB+qtq?=
 =?us-ascii?Q?Da6PJKQOJHkhTHkOL2HWjKmS84qf7Ayq9RXkoaRbEk0SPrWOAYdHuJ3DiFk/?=
 =?us-ascii?Q?eHKMS29YS4ZP25+axbH3dOou0Fh+L5Nc0okYZeLQea8pEF3hLjH4UM8ZLptd?=
 =?us-ascii?Q?SAri8Dx3OK+6wzTA7cQBslSl0SgLDeR0r53uoJCALZe7JuZrcM63lUH2NktH?=
 =?us-ascii?Q?k6FGbEddW+c2w0H8qxKNPo+lzaJXwyNQBR9fQ4y0hn8iRx7gftAupq4jjHRj?=
 =?us-ascii?Q?yWnm7zNTdksHvtECk8STMMwM6nkfCVC0ddjRVGHlg1mlE7PZ96/Hqr3VYNjH?=
 =?us-ascii?Q?oT4exlZKFK22JTagP7NtMO17jJ5qD41CZ0ftsQM4oKJkbbE+SSIN4+C9q725?=
 =?us-ascii?Q?0ATbnfCO2pU1ouY9tz8Nqa4agxdDbyvlHZhNjz3wrmqk22k7eV3UiZ48gPE9?=
 =?us-ascii?Q?0w0+6Lhn7gHT6s1XbmjYFFAIisDYdy6rEVVtxnqGpE65TIcdrOUzhnu+EHIE?=
 =?us-ascii?Q?1XE1SqzKQb74MRBVsmxJzNXJsOXbZWq4UzPhrFBeW8iNz/KO30IGW8SVDDDd?=
 =?us-ascii?Q?Bo6R+V8I6v228M4l8DKfmye+MZxvDf2Zynp8aHwZ/wh2808gS+HPOv3iLsVv?=
 =?us-ascii?Q?z+cD+ToGkuUpxcQDFX0n32RwGU7+KQCy9HquFFo/CTKbU966bvEl8fj0a6WX?=
 =?us-ascii?Q?kJ06IvUbRck6DmvnUN18c934Emc3rT6vvHelJh+XyC2/4fYFswUzuF2iJU7K?=
 =?us-ascii?Q?cM3DiJchUZfoRGLMVfB7EOdFKvCwsrPSrxHVv5ZY9A7mXI9u9tNS72ScT4zf?=
 =?us-ascii?Q?yuT4+KjsRFN5PkXJqPC72KamLgADqP1IzPMPblTtdO/dLDW2Uiiss3cqrvfY?=
 =?us-ascii?Q?lSilHJBqp4i6HOHRCP4C3cCgcbqDhc3nQGcNEfxm5Juuj70RQFyXghamjZMU?=
 =?us-ascii?Q?jqQrPBxOXpR9s5JwIgK4SGRkYb2pEpviOE97kMCOiuJYMo65HyndAspixE3S?=
X-MS-Exchange-AntiSpam-MessageData-1: sUdeFQxh/t8nNwyO1Tl7/3kuJB9x6QrCXFI=
X-Exchange-RoutingPolicyChecked:
	riYZQlcduz9CA1ObTkvEGJao4QhCNJMKcnQ60pynU4OX7KjIzmyG0sP8OPFH9QnrTfrkzlQys2VfS0MA4xbpIIhLjK5zoStok+BzQOkvYCzp8VvQadtDwCEKEJHPsFjGpoDSDCN9blb1prTefvDjXju6PCHZSGT+bJz5z1hUhQei6Lfpry3JGd4OgHZDWqlpiw6r+dmWuIWin3KryNbYWEIEVmWPUfY3Rh6l3rukjSYJW+jeeTYeryhiqphzBBXKK0iT5GxxwwL6iNBjKUFn1AKQoQUdnjQED+e1uuJ81zsxfbGznk1VdFhgxnhXQwS6R+J3JOdjHn1Im0trNuUZMQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c915df10-9cfd-40b6-f282-08de800fbd5f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:17:02.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaMufS6Emv5e4tEk7DjmMm+6kd6YH4xc5MYNG61AdDbWFrUEiod2k8m18A5DB9D+4jpmiy9mdOByCfpo407zCsNCuXFUBhSLc8G2eeHkKmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-Proofpoint-GUID: qzwuNZeljt7xilzdM3ORxsCWsbHQK459
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=69b27680 cx=c_pps
 a=KNS8ES/6Vao0xGfhhZwSfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=bG8hRs5GvZOM3gRM8dcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: qzwuNZeljt7xilzdM3ORxsCWsbHQK459
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX60pURCQ5AiNN
 7S4syLIGtVArNvaxmF/dCNOjCyyzwzRKOkWJ7izu/IghVrXZ7UNCOS+vHQ6KSesmJrODiEs1ZGm
 mi+bTFobPq2weuQRL8zCev9rKsiEmhrJGPpu7ULnRW9wc1loB9NVDtyWAY0hiUDyILiuZJO3Vcd
 UocbEHtgGRYf6uZiypW4et+TYoJ0U+xYqreDAxs7VBcUVsaOt/L3d/I6AHQW69vAY4Cv8der6Dt
 oGkrP8GKj/7a3TWxQcW3SKcc8CdHS1zIB8sPZnbuKkXyYZaB8Gm9fuHO7A2wSuRPj8ALuhayLAD
 3IWDZwQaOozQ0CpIyAJBm5Cl+BvYtBS+k556nEeVLvbr/OVg+SYJ86vAvJKwFYy3T8kCGHt365w
 kLExp28I1K15z4dHrH/uc1jaG+rD9LsJE6oDxQop8xWM2q0mf7LTS+NVOS/eb42tXD2J7FQtVlR
 XkF+nTLMfe1ei52nf5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

When the kernel CephFS client experiences persistent EADDRNOTAVAIL
errors (e.g., because the original source address was a transient
CNI pod address that no longer exists), the monitor client may get
stuck retrying the same monitor indefinitely while in hunting mode.
The mon_fault() handler currently ignores faults when already
hunting, assuming delayed_work() will handle the retry. However,
delayed_work() simply calls reopen_session() which may pick the
same monitor again, creating an infinite loop of failed connection
attempts to the same target.

Additionally, when EADDRNOTAVAIL is persistent across all monitors,
the hunt_mult backoff grows exponentially, causing increasingly
long delays between reconnection attempts. Once the network issue
resolves (e.g., route cache expires, new address becomes available),
the client may take minutes to recover due to the accumulated
backoff.

Fix this by modifying mon_fault() to force a reopen_session() even
when already hunting, if the messenger's addr_notavail_count
indicates persistent address failures. This ensures the client
tries a different monitor on each fault rather than waiting for
the delayed_work timer. Also reset hunt_mult to 1 when forcing
a reconnect due to EADDRNOTAVAIL, so that once the network issue
resolves, the client recovers quickly without accumulated backoff
delays.

Also add a safety check in delayed_work(): if addr_notavail_count
exceeds the reset threshold and we're hunting, reset hunt_mult to
prevent accumulated backoff from delaying recovery.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 net/ceph/mon_client.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ab66b599ac479..6e3d314fbf2b2 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1084,6 +1084,7 @@ static void delayed_work(struct work_struct *work)
 {
 	struct ceph_mon_client *monc =
 		container_of(work, struct ceph_mon_client, delayed_work.work);
+	int notavail_count;
 
 	mutex_lock(&monc->mutex);
 	dout("%s mon%d\n", __func__, monc->cur_mon);
@@ -1094,6 +1095,22 @@ static void delayed_work(struct work_struct *work)
 	if (monc->hunting) {
 		dout("%s continuing hunt\n", __func__);
 		reopen_session(monc);
+
+		/*
+		 * If we're hunting and EADDRNOTAVAIL has been persistent,
+		 * reset the backoff multiplier so we recover quickly once
+		 * the network issue resolves. Without this, hunt_mult can
+		 * grow large during extended EADDRNOTAVAIL periods, causing
+		 * the client to take minutes to reconnect even after the
+		 * underlying issue is fixed.
+		 */
+		notavail_count =
+			atomic_read(&monc->client->msgr.addr_notavail_count);
+		if (notavail_count >= ADDRNOTAVAIL_RESET_THRESHOLD) {
+			dout("%s addr_notavail_count %d, resetting hunt_mult\n",
+			     __func__, notavail_count);
+			monc->hunt_mult = 1;
+		}
 	} else {
 		int is_auth = ceph_auth_is_authenticated(monc->auth);
 
@@ -1554,6 +1571,7 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 static void mon_fault(struct ceph_connection *con)
 {
 	struct ceph_mon_client *monc = con->private;
+	int notavail_count;
 
 	mutex_lock(&monc->mutex);
 	dout("%s mon%d\n", __func__, monc->cur_mon);
@@ -1563,7 +1581,26 @@ static void mon_fault(struct ceph_connection *con)
 			reopen_session(monc);
 			__schedule_delayed(monc);
 		} else {
-			dout("%s already hunting\n", __func__);
+			/*
+			 * Already hunting. Normally we just wait for
+			 * delayed_work() to retry. But if EADDRNOTAVAIL
+			 * is persistent, force an immediate reconnect to
+			 * a different monitor. This avoids getting stuck
+			 * retrying the same monitor that keeps failing.
+			 * Also reset hunt_mult so we don't accumulate
+			 * excessive backoff during the outage.
+			 */
+			notavail_count =
+				atomic_read(&con->msgr->addr_notavail_count);
+			if (notavail_count > 0) {
+				dout("%s addr_notavail %d, forcing reopen\n",
+				     __func__, notavail_count);
+				monc->hunt_mult = 1;
+				reopen_session(monc);
+				__schedule_delayed(monc);
+			} else {
+				dout("%s already hunting\n", __func__);
+			}
 		}
 	}
 	mutex_unlock(&monc->mutex);
-- 
2.53.0

