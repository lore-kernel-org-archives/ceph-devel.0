Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4BE348453;
	Thu, 12 Mar 2026 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303415; cv=fail; b=VtUO5rYtMPZ5jh3IECSOie32EKe/LeQ/Oq42fPdqOyVEzQZljwaM/W+936vH1bmtFao6XRBBbx7+Un3adl1i+OeBgoOivK2w8rd6gu0IBxVtrDeAEoajdRSLfXE6GdewTd2p4wk/+w8wHzYU/tg8XoVzWpCcXcqySs29k878RR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303415; c=relaxed/simple;
	bh=QCKiZ3LfOyaKGUvD4a+q3JsMb1l7a5lSfWCWVjInFiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHjVhE7Zt/L7ic0nD7Y0/7cuCiZ5a/ASxYxomWBGbcE97JLA3WREB/0MUwbVJoB31wuFnHZCS3aaR53M2ekUKlPcdzEqV6VEvwWIcyaZympLJDZrB4AQMwhdIJ7WHXSkk58aOjBCZmnlrc4KEIJo0E2hBeC5l5Bf3xHKHbQ4Bkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Rk/h4dPE; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Rk/h4dPE"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C5sMit3084412;
	Thu, 12 Mar 2026 08:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=z9dQDUJiT4y7wI0xDonTMLRFIm9J1K3RM7Akq06UgcU=; b=
	Rk/h4dPEAqfNmiI3eFDY0HDPXh8HHLe29p8Mz6dB/rVOpslo9VDJDNcosgjDD+ZI
	8BGMSsdh88rQLqJdlrZNPf9GC8DmS8o6a1TlzhalieTk439Uc4gMuXYLoxZPJAyG
	7iIfXMuHpgb+pgnKljjTLw+mM1M//hU0AazTzgBKF2f+3jgZIy/D5N2ybq731FCJ
	1yYNdC4R2Abv4e4BLZoN7GhpLHOXyDVWMA2uSZQNcoLs7Q+xCYUzOyp5yjQfwvvZ
	WkdNMjX2OQLxmNkTMPehl9QJ/THNLsJhQJdmIETAm42UyGGEo5ZqizAm8MDXnt78
	SFqKkxFKI54RhnhVtP+Pbg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78gdvs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:16:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y71TCIry5vr/QtFNHpKcSFa4+7yaYpPKg6r9S1zytsrEZwYOKtv60dFdWcnbl/sRooc8YLF74VziCYd1Mt3xBEAimP9roMtCgrDdswhcpaBr2yNSi7ahoFK9r/hcltkWH0HDnQ+MA6GM8x18/6/n6TgIvT5gSZAfRKprKJf/DlhcteAH6BVMTVHe5UznnNSJoeci4I1TKLH2Yts1L1lvvXv+bVbU7whP7IGsfTJVmfHW9zJo+bwhWc2MxqWH3h1+ceDg2LYh6Jtdo+b6D/O54Z9Lc6phyHh1o7qWHQzckAwa4nbqmCOXDR7BUa/OF9SsWy9FiLGvJ5n7YIfpDZ8wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9dQDUJiT4y7wI0xDonTMLRFIm9J1K3RM7Akq06UgcU=;
 b=MVBBa8be1aCm/jcLXFx8oHFy2UKlD1sk8lAiDTHg1dB1HhNv1vpbU2wnW0R2Lblun0n7wN7XV0+Y4MYv4fhtKjM1ilnW9AflbxukygVZWOPaDiwcQj/7jZaMCK92qBc+Ree/b4v+kPl/Dw7VB7uo4Rfj0XTNvvvkXPj8jwUYhcvBclkywKTO+qIJGMtU0/RVMkbb0ccsdO/LwAS3tBg57wd2QcMsfUWQowo+wvPhv40oTkChODTau+yGlr6YYRcfbcQYW0x1SJkZZhHAIx0IXjwhubpwB0QD/pfxrERuKYh0tjzbgXMnZ/4VsO7QCPciKvTvBg6BZMScGbJdWxgyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:43 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:43 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 03/13] ceph: add timeout protection to ceph_osdc_sync() path
Date: Thu, 12 Mar 2026 10:16:09 +0200
Message-ID: <20260312081619.40854-4-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20b43a32-fbcd-45a7-eda5-08de800fb224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OpBg9kmFfEbSSjrArJuoqXObkbi0R5Ob77ZfgAVQHIQBf3qb3VNOIhxDK9Q6DAbz0NSn3jBVNWt6mdMQGgATde5LXGLLIwT5cvPSrCDA+9d6FviLQk1QMruDP3MVA4hE5L8aXmo8V00WxjlZJ/pX9c9TsLyjs+9C/6+wlZO6/cGiCNZ8GGczIAXuIWWLq8hOWPufQcW3bu+F6rCAUbG7zziCeZvncDcabO+l4lVBlbi9B0kh1WxqfF4CbA761zTr1xJDp5Bysxd2MinescvJ0EIyzpWdsfICnHwEw3ObtIxCnPVPKQyCIvfw4OyZDHq+tXURJtakfBsIIL+WlCofs69EJA17m2S+h5Mbzrf8/ObYeoC743zA6XYaF5HyTL53fBTgOtIaF31gNuoJTS+769beGCYOAU8gbuDVogfnf501w3S99ooJ/6VRoi5PgcU5ZlsSSC4d+OX0FX68KVuGldzUrE+gGZDZ5BjVmJCK0vxSh/9FvIZCESsPUv1Dc1BT4QY93ZeLiWC9jFvKPxucuq/jjJwFnPpoIHxzk3bfoQ58HtP2Eaf2X+AF8OjbhtzV0g+pIYhQii2ZW5DOiAHEEQVquHoUr2rvjTGHL9cnTmE28lFCqlo5U+wq4J7TvWCO6RH/IwdEaLpz8hgqzw736In3PvDz0VWFteDK6lJIcBO+p9/44K94xy5fHHo3xPZPBSTIWkP2eSY17XlOECGMfe5/VLmOWR2awELSNFld+HQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9h+BjoGh06X4nNa+Q3IfekoG15b6glJGMUH+BHSB8JVdczc6t8Jh8OnZNocZ?=
 =?us-ascii?Q?gefl2ySmt8lsVw/dadekbOnd8dCzozBqclumieiaw76Q9xa8o/40bGagrUH2?=
 =?us-ascii?Q?+x/BfTjuvBj7k6SXzAmSUMw2u7xFWMo6eRD/ZkvwDSRBV74zIthWWjXICmZW?=
 =?us-ascii?Q?rVwXlfOlmXKdyuds9fOa8D6+l1FsSQGfvA+QGNXnN53CdwEh05/J9x0k++15?=
 =?us-ascii?Q?HHx3Kc+Grk5ieI5tnoheqiiSN3V/Yf3ro0NyXRVdpIOeeow3bIRkVRNeUkZc?=
 =?us-ascii?Q?xllULde284otmZlFxChLk20SO170f0oYbKBn40TJSdlsYoWlMDRunqnDnWyy?=
 =?us-ascii?Q?W1xG1qP61llVqHtYTrqYWZNrkQ7ZgBp0plymu3IJU0qdK01ZDzd/g6pEKKBI?=
 =?us-ascii?Q?enWDL5xk913GO6G7/hzCOukdhftao5YRAIRA3pcBoOasam+7BfWpyD0fSpfP?=
 =?us-ascii?Q?HNyF3cOr2ZdE9yhU2OOgSfX/nIrr8JOkhguLMgzIXx3fyVK49u4IO9rV3u8a?=
 =?us-ascii?Q?c0Ndk1OLRI0CR54tdherDRSBxxLb/MVhe2+pb537OLTaQrpw4UQLSkwWNOT6?=
 =?us-ascii?Q?PzxDv66zqNwA1QaGNWKoKpJWmc396AFwPAcDRnEloX6xTTV54yB9aKZ6YWik?=
 =?us-ascii?Q?W0fT1sxxydx1vIdYLMGL0ezIu1GbAYVTQ759V5rke65m/EwoJaLE5x56nnHz?=
 =?us-ascii?Q?CDYN1n1E4GOoHZ9TWvGUPfQ4Vlfa+443nSQ60XKitzR1FBqhrzia//IA2+yX?=
 =?us-ascii?Q?2nT+P4OBxkCPWL92O3aaAbL/+bNKFvkvDaO+mQhg3SOd2c7f+wcXI7Mj3Uu0?=
 =?us-ascii?Q?hU8E9wVUdfxbVqcs1D0CJrA/1GzjgImv7QsV/l0VX11HlndNg/0t5FBkqmQY?=
 =?us-ascii?Q?9DY1ERaQq1J01y5Xh3LR9auNhz3s1uMmhrAvBFlit7D30X9+myAQYNdambpd?=
 =?us-ascii?Q?lxoYMM8umI0Ho+Ka2OWkl6O6bkZjbSoOLZVG40ehbK8N8vEdWjAYjqf5bwgI?=
 =?us-ascii?Q?6kifpPMtbU4etXFckCjDG+NGSF4Z/jirlgAKeAkIjoRRrET72nlO5EegdguQ?=
 =?us-ascii?Q?hazbyvxory+wXSC15hg5cF3IFflww/ADUZcB2lCNCE01wQeDWJRPqVpgJuE7?=
 =?us-ascii?Q?jEBCE59M2lWouIc7rowfTXzL/hV2AoK58Jgb6Z09fe7fMLqNLTa5XLbfQZdb?=
 =?us-ascii?Q?7EPjjJLB38Cn/KEpv2MEcaDjSrQtVuDINnrDdwWUxAjYdM8JaFRBcQxY4Rz1?=
 =?us-ascii?Q?QZzbHIqGGAZGpZhLEg2fcJligc/7BfAOGLLRbc0tNxF7nwjp76OYzbuhMpKo?=
 =?us-ascii?Q?pUmHh6pEs04QdZ/yVwzVh93+XhzdylcjJ+c1bI7lsSFhcrLlYGLSZ2APGnHS?=
 =?us-ascii?Q?uFjziMOOBH1JECzfJGVLsgRJc6uV2QT/I6kleUtgdZFibmcm15uQrxGw3wt2?=
 =?us-ascii?Q?I+AM9Mg/P5FIbTTl82qYZRcXC9DhtXfh4OPE5RV6C2NfGGDq1zlXoZgumBBI?=
 =?us-ascii?Q?L54Qw4SOPVxE3hOyX2LkKpTiZfMULV1sZhzTiI5vK2Hgm2ioWMgjLnH6LAaN?=
 =?us-ascii?Q?392of3EFZrzQT+pJYUb0ilapQLSGz8+sHuhnjpmvhMLH5CTq6ySVQnyTeL3R?=
 =?us-ascii?Q?OQU/ITUPUvU+/eVwGm+bUn28zRIcSs/MgJz7llrwIUZGtdIpvQQpPgnawc6k?=
 =?us-ascii?Q?/Yp/Z4yOkami+kYx394AOML+1YnG75czLyxjzJIoVuSzM2etBofjhGI4AmUV?=
 =?us-ascii?Q?ylv5NIZ6T4QT6DyAYLQWRVlbGmqQZXhovyvvMa4ge05UhRhJ8JXLdB+XqAMP?=
X-MS-Exchange-AntiSpam-MessageData-1: lU+UAZzLxDYsMXkOz22qPqG6FUNHKhZMnr0=
X-Exchange-RoutingPolicyChecked:
	gh4xwhBCNWecYAR7K+jb/iirMOQ/Nb+iJCDdU53IOv9WMqCRekGDzd4T0w8mw/9gW7gAoy6RIdF4TGc0FACYIhwnRb7EgH0BB+e2IZ/B94y00mhSqBiN9BaowpfcBFVEm3jWKKtHKzVLwCpL/vdMfee4Z4xapaFUv9+yFWO0t5nBCRPMibwoiq9oL0CNdwZUv0/ZpCWZNcr0lFt0i3qKPmQZakG5ls4HnO0GIplCRlc/011OQ0APVNt5eMPkoBqrkaiuAkY6XRiboIgFC0dYjGGV97SIbqafM+QF7o7b2veiem+dQH5TPl2a2lCZmL+9qhcNGhg2Vw1Kd5M9TEaezg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b43a32-fbcd-45a7-eda5-08de800fb224
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:43.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7re9zCJ5NQkOqYKvw5EZ53uW35rUUInxbXaCFCFYGI1b5mlTY2wsYgNLQiPj68cZ8jHAeWz4pM9TNt6VXk/Ex2a5P7LSEN6x+3X/KrleY7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2766d cx=c_pps
 a=uej8S9duoQdrJ4czObxKNw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=AFEWvRXOxcBv0v_5dq0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX8orGTgEDCUhI
 CyV8PjKi9bnr0wFHtfw99TRqujRiohk/S5xFTjvwALSzvp7jjzUtGLDnVcyiPYvdJV5Ujqn7TvS
 Nysu6Xf7CBAfOzuvNa9Y7CKBZXIhHtO8meern0ecRJBczMWcILvVcmnlI+dek42MYmOQGmYVtn4
 MgUPdBi1tEplAw5VShvM9z8uBlnw9PLVdjz8kFVX8k1aZP7tEt1mw9FKeb0CkvW1QJ7nRd7VKmw
 hsV7x4tZ3pYHzuU5bws/NlSTrpvg9+28LjQWZgQpcNrtjNrohAMILPGUojJ3Uuh6lttpo1Y1Mi5
 lF9uzBk3++uggdJcFSjjx1+Y+RrxCF01oHFbw4crjWkDla+RajPAHgUjxB9KXERDdnKEQypU+V3
 e/zWqP9T39OwjRiDEvttOOZhsvJBK8ACZg30gSV79fP5QGK4cBydF+ce++eKuFrdvfIrlAY699y
 WwexIbOewhW1gBSOuRQ==
X-Proofpoint-ORIG-GUID: X3I8YB898OVuRX85js8GuNI0E8Aq4MIp
X-Proofpoint-GUID: X3I8YB898OVuRX85js8GuNI0E8Aq4MIp
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

When a Ceph OSD becomes unreachable (e.g., due to IPv6 EADDRNOTAVAIL
during DAD or network transitions), the sync syscall can block
indefinitely in ceph_osdc_sync(). This function iterates over all
in-flight write requests and calls wait_for_completion() with no
timeout on each one. The hung_task detector fires repeatedly with
stack traces showing:
  ceph_osdc_sync [libceph]
  ceph_sync_fs [ceph]
  iterate_supers
  ksys_sync
Since ceph_osdc_sync() is called before ceph_mdsc_sync() in
ceph_sync_fs(), an OSD hang prevents the MDS timeout protection
from commit e789e5252fda ("ceph: add timeout protection to
ceph_mdsc_sync() path") from ever being reached.
This is particularly problematic in containerized environments with
PREEMPT_RT kernels where Ceph storage pods undergo rolling updates
and IPv6 network reconfigurations cause temporary OSD unavailability.
Fix this by adding mount_timeout-based timeout to the blocking wait,
following the existing pattern used by wait_request_timeout() in the
same file:
- ceph_osdc_sync(): use wait_for_completion_timeout() with
  mount_timeout instead of indefinite wait_for_completion()
- Change return type from void to int, return -ETIMEDOUT on timeout
- ceph_sync_fs(): propagate OSD sync error, short-circuit before
  MDS sync on failure
On timeout, pending OSD requests are NOT cancelled - they remain
in-flight and complete when the OSD reconnects. The timeout simply
unblocks the calling task. If mount_timeout is set to 0,
ceph_timeout_jiffies() returns MAX_SCHEDULE_TIMEOUT, preserving the
original infinite-wait behavior.
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/super.c                 |  4 +++-
 include/linux/ceph/osd_client.h |  2 +-
 net/ceph/osd_client.c           | 15 +++++++++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b52960402d68e..6f4ee457c1b52 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -133,7 +133,9 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 	}
 
 	doutc(cl, "(blocking)\n");
-	ceph_osdc_sync(&fsc->client->osdc);
+	ret = ceph_osdc_sync(&fsc->client->osdc);
+	if (ret)
+		return ret;
 	ret = ceph_mdsc_sync(fsc->mdsc);
 	doutc(cl, "(blocking) done\n");
 	return ret;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index d7941478158cd..871827e2dd983 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -587,7 +587,7 @@ void ceph_osdc_start_request(struct ceph_osd_client *osdc,
 extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
 extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 				  struct ceph_osd_request *req);
-extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
+extern int ceph_osdc_sync(struct ceph_osd_client *osdc);
 
 extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
 void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index abac770bc0b4c..7d5e4a078fb10 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4734,10 +4734,13 @@ EXPORT_SYMBOL(ceph_osdc_wait_request);
 /*
  * sync - wait for all in-flight requests to flush.  avoid starvation.
  */
-void ceph_osdc_sync(struct ceph_osd_client *osdc)
+int ceph_osdc_sync(struct ceph_osd_client *osdc)
 {
+	struct ceph_options *opts = osdc->client->options;
+	unsigned long timeout = ceph_timeout_jiffies(opts->mount_timeout);
 	struct rb_node *n, *p;
 	u64 last_tid = atomic64_read(&osdc->last_tid);
+	unsigned long left;
 
 again:
 	down_read(&osdc->lock);
@@ -4760,7 +4763,14 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 			up_read(&osdc->lock);
 			dout("%s waiting on req %p tid %llu last_tid %llu\n",
 			     __func__, req, req->r_tid, last_tid);
-			wait_for_completion(&req->r_completion);
+			left = wait_for_completion_timeout(&req->r_completion,
+							   timeout);
+			if (!left) {
+				pr_warn("ceph: osd sync request tid %llu timed out\n",
+					req->r_tid);
+				ceph_osdc_put_request(req);
+				return -ETIMEDOUT;
+			}
 			ceph_osdc_put_request(req);
 			goto again;
 		}
@@ -4770,6 +4780,7 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 
 	up_read(&osdc->lock);
 	dout("%s done last_tid %llu\n", __func__, last_tid);
+	return 0;
 }
 EXPORT_SYMBOL(ceph_osdc_sync);
 
-- 
2.53.0

