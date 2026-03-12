Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F51283FC8;
	Thu, 12 Mar 2026 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303414; cv=fail; b=bL+f+N1zKmllw2OOeXCcN0B0pSsNKiuC1mSaK8lHv6cCyc6b/sxYE7c43P4sAisapQwftp1sFuerPk1wismKw+ILFmJ4GgIjpVWVL9dXi11hGS4Gqz+/6Y+/FUPFtlDRFopLIZyL9WE7v0cXPuYE2Wx5qi9mvyJXy2J49mw4yyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303414; c=relaxed/simple;
	bh=IzKUfgvjYpai3ijpdj9FtWWzwMFeI6Wg8sduiIZYXHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDM/uJhZyEAWRQzNiNnDVPhugHpbhqp0yQS3JqpFqotcemt6al1DYPDtm6OM0jfXLUWByXWs7OF/YRVp3pgtOiO5rAm6hm9f+UC58CYPvXOL6+nIgJiG74J3wcuztq6nSWMgqAiesPCwNMkbGkGY/z2MPIknHAStAuHM9eHKuak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=tC20hKbI; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="tC20hKbI"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C5sMis3084412;
	Thu, 12 Mar 2026 08:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QZiCRB5VY08wdymg15E36OteejdJ2gAIoiEzqamLAJM=; b=
	tC20hKbInN4KXLqWa0L3U43U+RafBovWFSW3Sik9kKZZ6TmqTfuEPXWW8JmX3baW
	4F3xKwu6HFp1mIYLcoA+qvypOD43WFxG+X0PWEpDTPNUu+w6KiyniMOKYMIKqRSy
	uHazhKCmrZ7/IeN6p4SMk11rHU8Lz2buUGkNs8wLEIM3fI0aPBOWE2/WyUJqQOoj
	zqOqHgU7E3kvuDauz0zPeymJdxR04OcC2Hd/MiBrZCpOE7MV+woNkTZ70jdYpnFM
	e/+GxBwYqGgMh/7eNDizDURn+s64jYHCzYoNHsd88HzfZ9RNjMTRgCaLX2pUgsSv
	4dSlBrnWurtBbQNgwG/vTg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78gdvq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:16:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyKbyETiL6QzsfpC+Mh7yMJJtpZmV+1ChQfSBRGlsNbmeCvd57jb0p1wHKRfwBac4c76Iue4lAV15QFXl/k33VQ/eZygPw7+SUtudn3VnW1+5qo+4djtCYzbKdN6V741J8nq4dGGZ5G/jpFGKK+MrycPGB1bLY6fAUUA/j6YU3HDjK+9cz33l/lYaVEroXNDJVQ3fJvoWL9/gJX+A1jHO8kW8acuffIwjufNCmHYCIqrxObEHc2xennOtmxlp4TLYHK6jmMEaiEDSmXA4bVgYUlf6qiJkRNtqDPmYljMTNIXeB/eMfLArvRtKs+8Gz6o2IeyIn3SIUUmEvny3uIOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZiCRB5VY08wdymg15E36OteejdJ2gAIoiEzqamLAJM=;
 b=Tb8oGdR2dSnyyS8gmx7Si2MmFrBx2taNdmdCeqXqGjYo2qKHgjLDL0bzn8dJXD8mEclOM+n0aCj2G5Q89xF8D+pV7qchFwGkgKtwuDRkeI7NGt9dzExe/KkUw1G4ZAqkmbEinMmGo43hkJ14R6nQ8ZXadDmD/GM0dTotfM/jHGBBJgG0oJILRiUFbdD5i6GzGOFu/GfIBNtn1+S35yOyqIEF7YK5b2XPNKwvLmzKEiZUBvL4ZNw9q//7MjpJzR97c2eeobNsXlMjRwNtHvA8Xm6RowJRQMznqKLrpY1pwJIHO2wOh8XuedL3JjW8bFDapgA8Xp62B8qCbYFlPjhVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:41 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:41 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 02/13] ceph: add timeout protection to ceph_mdsc_sync() path
Date: Thu, 12 Mar 2026 10:16:08 +0200
Message-ID: <20260312081619.40854-3-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5adb8af-664e-4fd4-3d29-08de800fb0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9czNZPYvIjTs2UaETJ9/JTNGxD2w9vMkgvPqbzVWdvsJ8hedEkHZf2z1/30/Qn/F3lJh+uqzBGMnrYPRwAz+sLobvy7YCv26jWAbjEHr7Hl+h5yKSl3Exkcqf4inyn2ZpG9OzFtNYJ0/YBEh9WdDtxzz66DFlHC5oRvsZ+NFgIpS2YousGGId6JfAB5LZEfCUTmApgtCwFBJkFLRA2QvGadYpqVdAYH9TzqytIKbNOHfsuSp5lQXeHAGUlCSHuE5YxfOZNIllxP0a25E7bdlmHQeWUfgAgHvICUjlUZgy+OE1sUW/8WY18B0NyV0e23O69a9qTS+PXYUDYe6GJjBeYywHD0zM7An40mfX9qRXv1j/ZApFYeGqhLLVdCPxSFcxfz3M7wev9v1yxrY7kxx1AMLCe+Z5G45arXGZg84y6aiyUMFwSSohE8vxMLxIxQOLFsR9lkx49m+V/gKo4+HysDaNDNHNLEYrSUnQFGgl1whA+kOZGLfpTca4DQ+GH9joNvMfF/ujM2j1fA9KK9uW+Fvce6bAz5EDiDxrCnFameLrFLfXv8S10eX2NIqIhBhCF/XKWWU0CO1e93Zp7Nz+Z/FBjPjMUlFSdusnr01hKmDs+DEM11D34Wj7YDAx82ytQynuClrTSvc1cJPwvqQzkyvH8GJNikZmQdZ53zNcKZEwNEKdP3Ep085ZuG0yoVY1H3EJh/e490EKGyIMLfESNZWbkSrxKg34Keh0IoYtR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7FVmT0/5Cgx96ZHqbLhRfUr6YU5C1zAdcVRVb2TgOlWfSA+OhcI5WFDCEuE?=
 =?us-ascii?Q?+Inn6NlUhEJfbsljUTj0PesiDnjk/ZmjwX1e7T4osQBEksl1/LdzL+rShs/O?=
 =?us-ascii?Q?FIwzYlZNXAQJ3Fo/aINJRNoRpb212pH+Ao1eEfsbrOaupaJpGj+FLy9YBlbf?=
 =?us-ascii?Q?lbFfhM0tT2jBrRC2CMBTYOeTTvuwOo33dHPYpRC6TICUMecfsbJjrA6dthCk?=
 =?us-ascii?Q?wbORI4xIJiFO7OJvyYKPgXF50KQy64wT+oLreTWEHU+Mp5Yj75Nr2KqTDOoF?=
 =?us-ascii?Q?je3ecokadHldh6rSC6JD++Po8KboW36i9gTLzG2uQY034AZPnDnlcRe1UJGU?=
 =?us-ascii?Q?eCsmBQZxMtZf1qY74RX5z9EsBUYDghpzgt1nfvoNbj6kJBNzjmld+rpwaDoQ?=
 =?us-ascii?Q?5ODyHQRNjmR3NCBSBxZFuCiKk7v6RpGEz+YU0B1tHPeCzw5gnjK1/GvDCskV?=
 =?us-ascii?Q?bL/6kj13vWRN3CW/V0vcemAIS41P5vPyiL436tJdleirqzqHww6Z2tB3eGBL?=
 =?us-ascii?Q?DSlXVzBWkp6QK9aVPF9ewTBqYU7dxAheW672C6r1o/NRHG98iSdGprlvDlGw?=
 =?us-ascii?Q?gEhO1Se2gFBhIFZLW3+j2fYh0Y1PBcy9KZNf2EIrVJw3J9jXlXgYKYWcRzQU?=
 =?us-ascii?Q?+TpKqvtTafIVR4Qxqxb5/TBRrJyxk1DSoFlCHsSFNEiSD64epUyr9sILs33S?=
 =?us-ascii?Q?IYEn5Rc5BbossjygD3HTu0c3e/1Xho6NC1uhJZm5ekT7Kq/MgoF6C5Vk7hdU?=
 =?us-ascii?Q?UaNB5XwrO5+1ldxnO+ew7wGeZI8E5Bg2vMabn++oaMmgo10PNoAmmiD9O+cN?=
 =?us-ascii?Q?I4LD9wSdJgvHF0G7ZhFZn3CO9oOCI7mC5sMaHAPJzk8YRqaq/NSQwuAhJ/9T?=
 =?us-ascii?Q?vgIOY/ofTnwL3tihyedrCv42Re2LJqVo1PjGWMQV9uQs07Dxv3h/4nB3msIB?=
 =?us-ascii?Q?mfnI7+hSX5VXY4pWkM6cp3ZYBXqYT7MQ1u5Qtp1QQqQe43ZSIJAd4O8Ou2pz?=
 =?us-ascii?Q?dGNH0JBhjTCG63IZPd/kinZmiNQSYhLOUpQJNQgWHVOdDLmYb2vDd4ZQFLkk?=
 =?us-ascii?Q?xs1wX3GgyVmidJbyy+EGumGgP1vUKQOgI66zDDaL3gwVuoW0FO9A68/Mhdxy?=
 =?us-ascii?Q?Ehcp2sSEJ1Zt0Bf91CV+lDTdJX2o/AVV1X8I1RjS2p1qTvbDyNAsv0qwCWdL?=
 =?us-ascii?Q?MaCe9X25eTyuv/YeVBFVWSmnItMEigsFCuwLQ7moFt67BvR1wgMTLT+74kcR?=
 =?us-ascii?Q?mtWV/6DjOEkbSgkxbryBb3fJKiJTOE55s2E4gZ/v6VvV0n20kTTzAazBYgML?=
 =?us-ascii?Q?x19njZNWAr5ujIxAWzfVK9zf1mAaUUQ4uwOn5KmhROZWfY7swmwKZz3re9uZ?=
 =?us-ascii?Q?l+blCKf81u1jJaqy24BPXBSxV/mla2vI+R+TU+kbKEkbe4GyU1SEUx+8SCKM?=
 =?us-ascii?Q?JH9eAFQDQkta5Ifkl3wdsthVIDszpY1Jaqengh0aLDWEGFEjP7LMIc38In1h?=
 =?us-ascii?Q?ua7p2GmuuCCPEt1GHs9aQQfQtCgxgX2U5ZrrmNcTADSR/u+tFf7cKhBlmNdV?=
 =?us-ascii?Q?HE+QhXMLqey3I9XjpDweEOQu+wsZZdD0m3qMpIKBs5DJ/enoUPoiTijQ+Lt1?=
 =?us-ascii?Q?BQcIFKeuglgglIdbGWXO8tRccY4XKyfvwMv1Vwdu5c+14HOn9+L/coFgslzl?=
 =?us-ascii?Q?2QtiP/33gXvA8B19sFCAP+uCfg7EflNtueLKALSHODGGVS6jxYCR5lWUvVt6?=
 =?us-ascii?Q?S4e2WLiq3uT9cMwYLWHr3b9LeH3gEJUghbV80ph67n8yiOFGiRRG8PvxHjps?=
X-MS-Exchange-AntiSpam-MessageData-1: zzmXMijIUZqQLklSkGFg/PPCCgRBCW8njzg=
X-Exchange-RoutingPolicyChecked:
	P46FQ2wAtRtvrzrmObutXlew1AvCrRnJ2/5nACnZTL5SxmwVWHzfpxO6VmcUU83tS2cTELm8mL38g1FKSSC4XGZZc6THh1wPI+jmzTDc2UCu9qDK92ppXavjrA9axiwP6WniTXg3pf5o2UyMIrhzuEToe8IVSJQXJmzQeR7/FoH6/Sz30YJTv8kDMfonHb6nJtToHv453CKuCJDdGGrsiLvOq9sVugzlJXIWY1fCmvQ9axFv2uFwXu9le9diBs5Wtw2J+9xNd02ykdsr9Yt12YcUUyMuzxhNjx3PCIQaljSq/+qmItBJ0kxkUA5nLjLu3XASKautcZAOgOct+t63Zw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5adb8af-664e-4fd4-3d29-08de800fb0dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:41.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uikq3rNKnx8xpU5jNm0ToP9FJrf21rVcvYTmpmcp7fOSMiHOyuOCx5xO/S8BUAgGQ5kFqyTcHS4/Vbqgn1KJVjwoH60CXzNkn5Az3joG1h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2766b cx=c_pps
 a=PUtblwwgLuFy1ufMWAoo+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=SaH7p1EYcUSNWIx4HiAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX/OccGkXC7rgl
 y1egFhefj6qV06SJOepelVwfdN3OSZgP8qpldMGkWu4g/IqCK4dZxAKZVqMRs8K/P/PgvU76PnE
 BHYvTLWc0/NE1rI0A+5DnVBVNJzJ6vxVOog9+PJpB0ri6nq9Ab4HMGPe6logSVfcF+to0nCL1g0
 LqR9JFEWkdfapu7WXUJsmxE3Cx8GpcC47KE7L3DbfBlHN7dxqmQxYLRJ2+9TIGgprj0se11iV8F
 ehVjduptYhjTwUmfRfT8z559XVCoTxIusldOEqC+2WHWIPW1H7WAjPiEoFsJsPCfQqPo0gW4axR
 6Bz5RjaRUSAeIbhDASBa3nsoAROugDyGIJ0vuWCH/3yfdEHJNEkNVl+km2ZknPDsWzn+d1Rnuqr
 qzFRsc5QpMQPhCec7uD9PoJY//EdqsPl6+cwB2qiBulcwWNdgE7LiPc7WSUu0ZMEeBLHNkkbggt
 Vv7zpeG15XZ6tWLstvA==
X-Proofpoint-ORIG-GUID: Zha4t5rdWtfhnFsLaNSfq4-vlG0F9B-J
X-Proofpoint-GUID: Zha4t5rdWtfhnFsLaNSfq4-vlG0F9B-J
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

When Ceph MDS becomes unreachable (e.g., due to IPv6 EADDRNOTAVAIL
during DAD or network transitions), the sync syscall can block
indefinitely in ceph_mdsc_sync(). The hung_task detector fires
repeatedly (122s, 245s, 368s... up to 983+ seconds) with traces like:
  INFO: task sync:12345 blocked for more than 122 seconds.
  Call Trace:
    ceph_mdsc_sync+0x4d6/0x5a0 [ceph]
    ceph_sync_fs+0x31/0x130 [ceph]
    iterate_supers+0x97/0x100
    ksys_sync+0x32/0xb0
Three functions in the MDS sync path use indefinite waits:
1. wait_caps_flush() uses wait_event() with no timeout
2. flush_mdlog_and_wait_mdsc_unsafe_requests() uses
   wait_for_completion() with no timeout
3. ceph_mdsc_sync() returns void, cannot propagate errors
This is particularly problematic in containerized environments with
PREEMPT_RT kernels where Ceph storage pods undergo rolling updates
and IPv6 network reconfigurations cause temporary MDS unavailability.
Fix this by adding mount_timeout-based timeouts (default 60s) to the
blocking waits, following the existing pattern used by wait_requests()
and ceph_mdsc_close_sessions() in the same file:
- wait_caps_flush(): use wait_event_timeout() with mount_timeout
- flush_mdlog_and_wait_mdsc_unsafe_requests(): use
  wait_for_completion_timeout() with mount_timeout
- ceph_mdsc_sync(): change return type to int, propagate -ETIMEDOUT
- ceph_sync_fs(): propagate error from ceph_mdsc_sync() to VFS
On timeout, dirty caps and pending requests are NOT discarded - they
remain in memory and are re-synced when MDS reconnects. The timeout
simply unblocks the calling task. If mount_timeout is set to 0,
ceph_timeout_jiffies() returns MAX_SCHEDULE_TIMEOUT, preserving the
original infinite-wait behavior.
Real-world impact: In production logs showing 'task sync blocked for
more than 983 seconds', this patch limits the block to mount_timeout
(60s default), returning -ETIMEDOUT to the VFS layer instead of
hanging indefinitely.
Fixes: 1b2ba3c5616e ("ceph: flush the mdlog for filesystem sync")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 50 ++++++++++++++++++++++++++++++++++----------
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.c      |  5 +++--
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index df89d45f33a1f..37899464101f7 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2296,17 +2296,26 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
  *
  * returns true if we've flushed through want_flush_tid
  */
-static void wait_caps_flush(struct ceph_mds_client *mdsc,
-			    u64 want_flush_tid)
+static int wait_caps_flush(struct ceph_mds_client *mdsc,
+			   u64 want_flush_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_options *opts = mdsc->fsc->client->options;
+	long ret;
 
 	doutc(cl, "want %llu\n", want_flush_tid);
 
-	wait_event(mdsc->cap_flushing_wq,
-		   check_caps_flush(mdsc, want_flush_tid));
+	ret = wait_event_timeout(mdsc->cap_flushing_wq,
+				 check_caps_flush(mdsc, want_flush_tid),
+				 ceph_timeout_jiffies(opts->mount_timeout));
+	if (!ret) {
+		pr_warn_client(cl, "cap flush timeout waiting for tid %llu\n",
+			       want_flush_tid);
+		return -ETIMEDOUT;
+	}
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
+	return 0;
 }
 
 /*
@@ -5838,13 +5847,15 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 /*
  * flush the mdlog and wait for all write mds requests to flush.
  */
-static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
-						 u64 want_tid)
+static int flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
+						      u64 want_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_options *opts = mdsc->fsc->client->options;
 	struct ceph_mds_request *req = NULL, *nextreq;
 	struct ceph_mds_session *last_session = NULL;
 	struct rb_node *n;
+	unsigned long left;
 
 	mutex_lock(&mdsc->mutex);
 	doutc(cl, "want %lld\n", want_tid);
@@ -5883,7 +5894,19 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 			}
 			doutc(cl, "wait on %llu (want %llu)\n",
 			      req->r_tid, want_tid);
-			wait_for_completion(&req->r_safe_completion);
+			left = wait_for_completion_timeout(
+					&req->r_safe_completion,
+					ceph_timeout_jiffies(opts->mount_timeout));
+			if (!left) {
+				pr_warn_client(cl,
+					       "flush mdlog request tid %llu timed out\n",
+					       req->r_tid);
+				ceph_mdsc_put_request(req);
+				if (nextreq)
+					ceph_mdsc_put_request(nextreq);
+				ceph_put_mds_session(last_session);
+				return -ETIMEDOUT;
+			}
 
 			mutex_lock(&mdsc->mutex);
 			ceph_mdsc_put_request(req);
@@ -5901,15 +5924,17 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 	mutex_unlock(&mdsc->mutex);
 	ceph_put_mds_session(last_session);
 	doutc(cl, "done\n");
+	return 0;
 }
 
-void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
+int ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	u64 want_tid, want_flush;
+	int ret;
 
 	if (READ_ONCE(mdsc->fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN)
-		return;
+		return -EIO;
 
 	doutc(cl, "sync\n");
 	mutex_lock(&mdsc->mutex);
@@ -5930,8 +5955,11 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 
 	doutc(cl, "sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
 
-	flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid);
-	wait_caps_flush(mdsc, want_flush);
+	ret = flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid);
+	if (ret)
+		return ret;
+
+	return wait_caps_flush(mdsc, want_flush);
 }
 
 /*
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0a602080d8ef6..695c5a9c94026 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -564,7 +564,7 @@ extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
 extern void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc);
 extern void ceph_mdsc_destroy(struct ceph_fs_client *fsc);
 
-extern void ceph_mdsc_sync(struct ceph_mds_client *mdsc);
+extern int ceph_mdsc_sync(struct ceph_mds_client *mdsc);
 
 extern void ceph_invalidate_dir_request(struct ceph_mds_request *req);
 extern int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b61074b377ac5..b52960402d68e 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -122,6 +122,7 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_client *cl = fsc->client;
+	int ret;
 
 	if (!wait) {
 		doutc(cl, "(non-blocking)\n");
@@ -133,9 +134,9 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 
 	doutc(cl, "(blocking)\n");
 	ceph_osdc_sync(&fsc->client->osdc);
-	ceph_mdsc_sync(fsc->mdsc);
+	ret = ceph_mdsc_sync(fsc->mdsc);
 	doutc(cl, "(blocking) done\n");
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.53.0

