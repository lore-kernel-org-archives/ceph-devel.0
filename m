Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C2346770;
	Thu, 12 Mar 2026 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303424; cv=fail; b=JLTA3QkQVkysg8jQwqOlj+LE32t0khmcqfCl1EWj51WynP5Hh16nZ5EZKjUx9mH5+cEOK76mIes4GMYZ4AamjPgPmQozKPe9LOMX6eHIFUph3KIj72wRmNvxqrIopReUyHaqlBHPO76APzuHrjbenR/4wbz2TRoAJ4Lx1awDJJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303424; c=relaxed/simple;
	bh=rFsmNvSJepdAmEmfmFopqj+r7oiSC5NTsBCAxypVvfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twUtvehnmCkD3jZr2GHUwz3loTUgIfUQ3JGVNsmA0GuW6zCzcyQC/CcVDxGBLQ/eHtZ2SttOvZa8zpa4MKDm+dWqvQp7RSATfEaBgoN/eDatj/ksuodGUsGmsGoxoyU6yqb1Bjm6xFiUxoqm17g6rNIjOS9xKpNR7GZGkF5tUZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QO2RHI6x; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QO2RHI6x"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C7BIaj1885429;
	Thu, 12 Mar 2026 01:16:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=oYVxFUcXefKmgBTmYlSmQ21mLolaWy343RxHk4KhCRE=; b=
	QO2RHI6x/kO1i4N3aRuBDEplafuds/QDoYpfroqp0PpXvvyYKTt1ljXwhtUO0A9m
	4sYrS802UU5+lb0++CzqwRdiizE1opbDQtj58ZSquxIKJeY503bZmklblQNL456Z
	pdDkhn8zKqUlr3CGvhSKSdIjNJMsYyqEAumHS7PbRKZNsSKZh4gk4G26SAcGd5s6
	T1BMR4T9ZA9Ye2NWin4RVPN2u5xlJlOWmDjgfdTbxuj02ZvORKZli/ofEcy60krC
	k11yjhuzmYoWFUTrtG1M7p+jHz+C+P6RTAdIyg1g2uirk2ILw5+hGZNhMOMpY6r2
	R4YRCFH80IC65pAS3rdR+w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6pren3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 01:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEq0ZLCwIoT4b6waePoqaL1wDO+e+UBmVRVYlciuWXcbAD8X/HkzFFoOJ1dE1dBUeuFieMb8eJIY2r2+2Pl0rcuRpYP5TeVGtKjExPfI/Jo6iTdRGDpR+GNkYTEpqlucVaDu1iBMBPuxXgTQNtKPfigbFbgCyCDhpi8tgzg6Pv7vtJJOY5vqZ7bxh6p8N4cS465owfQMY1DZbfusvV0zwuGVW4yf4p2cmdh9JJUu6WDLKoR2zMQxdM8s9fX0Qly38R7Eg80pF1MKdXUlGrhBuhQGpEDINSKFGvY+ezZxYE4Iikbod7NbJBSolfaj6SAt0uVGFDH09Lg4Gk25xRAcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYVxFUcXefKmgBTmYlSmQ21mLolaWy343RxHk4KhCRE=;
 b=VJMPJYnEfISwAnJeWw6AsH6bKHcw/yxjzkvqkgsRk9mIiOn2YvBSLTfuPYjUpsoJ5MvRTsxZxAufipWAqzuo4qXYFytdfm2z4XEQGYati2bspHQFiZd02TIJiyayQvbCC+F9Fc1SBVaA/DcfKpqkW5qOPZE/QMPE0CvCSRW8W2+S7GCJpBeIfbnf6wpcJ+f/in8XtstcgpQj9bUK2ZoY+/oaDtbhGhXazyXtvI6Yuijep2Xpag1gd7Fyy/yOXLoPUE99vxOnAUZkfWD4DkRo0tzIQtrF4iQjwjc0kaZmgtSS/iyjvl+OKLA9evyNa4IuXh+zGhtlQYZ+OEBLIYrtiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:49 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:49 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 06/13] ceph: set default timeout for MDS requests
Date: Thu, 12 Mar 2026 10:16:12 +0200
Message-ID: <20260312081619.40854-7-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9985a488-4a1b-4bf1-ab14-08de800fb5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	F7jzpvohPmZZg77g2t4dk3oQXpen9etbzP/Du4Vh53W8sE9/vJwT0Xqd2HJA9D0C/81j8uy1pD1eXsln2zba+PoDuV9EYorijyVZ+L8ZijP2qV3PZJyQrdEblWrFnA6USN0FAhogjeWzdHF2hj3NK0SVIV9kTwS2kgf2xZeL6RYKr1CeWoFEEZW/f+Rx0WCGzgikJMz4nztMfwdLGt5uxxKtuJz2Va+n1qntPhdwTPJYTyHHjmDtKz5x37TiyRZrQhj//j5OrxVn+Z1Q1uaJ6uKSVOyuHRkriKz5wdR9T3GafxZegwEz3dy3yTyNiHUulavpTQ3LYFW/7sSX19fAYFBbkQ9dkIieRZ6TZM3yFK7XuG5eTJdWSE8/rH3lJhZdBmFoZwSbr75OuyYiVIVBvx5A1GmzgqxJWdq6Mv8u5f6pVn2+hGLVai6d28DSl1Y19FeuW53JQXGxoAe9CfceDX+2+B3DXPEZENrLDzRl95V/YpTLVK0UR1SdcPSqFQsx7tYVDbmHJ5ACyd25AeE1+9Dbx9oJkW0dVe5UPTqCyN+xTEspJQVKX0g1suVqJknHdWvcTNab8aFWAeMjWs9NwJN33/059m5TTP+w/XMKrhsUQ0MrBq5klCcI3AyrnZPH6cQKn4mq8UVb2SDrqAn/cXAw8SljI35JDSq5PM89wAedgprZHg0mTyFFEjyrkdIqgkjDuSlSBM9sX3Fz9E8i/twvLoh15E4AqCAHb+fwaCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLxRZh0qP/bkkza/53zNUykO/JRMvvlcCqN88+xsjM5oUANWJp+NsOjPe22V?=
 =?us-ascii?Q?LeIFgROSBbDXM86RRcH6wqlmw08Sqd2Y84nszYkBmcDIH/PskvVhZA+gY8E8?=
 =?us-ascii?Q?g2VNAhspVOJnUsT3W37xGUC6eYnxIoh/mpDhY/nJ1g6wupiO277ej90U61kH?=
 =?us-ascii?Q?N5+IGIU5YoZ+FIx4bIYrz6CzUnchKd5ZR/vPBTeoZZSB2dCHQ+yNJfgWEY5Q?=
 =?us-ascii?Q?JJOtqHdpqk10Zbb6DkBBChNR6sk0ID6jcOxdfEsU/qIIVX+238PchBHnHW0T?=
 =?us-ascii?Q?+KLnwGW+Uq6PjJafnh/B2HN40e22vXCq1KOd9J7G+1b7+NFrTurGjPS2Yyiy?=
 =?us-ascii?Q?psoCjaMqccGKLAKPRaJYPwIZInUeg9F9sj1BZcuxGRtS5gt8lGbWPKh0Ptwe?=
 =?us-ascii?Q?7rr1Mz/tyvDo5iNQJajehMMktRSQJ5iyDCTs6siUuw9NzTDb7goKeEO9IJfc?=
 =?us-ascii?Q?WBXtqnLTZRGSo24FiJcnlvzuduUg4va+ai1H0Opc0EdkWGtIv8TbsGDe1csk?=
 =?us-ascii?Q?j6/ZOMN3tAuXuMZwha5LS+7oMroXTrSR9KXC0Ebd1dKiGJkJ5ynJqjJJrm63?=
 =?us-ascii?Q?Ubizh6dnJEX1fMfaI7p0jKlsUviFj1KJTQmgQ6pk96ql2bRYwDxMCrPO0rkU?=
 =?us-ascii?Q?751ojM+eh7edmP7XOjXtb3s/P8KBDEQ8KS++yAbFU7wb0wUQ2Po6Qtygs+oJ?=
 =?us-ascii?Q?LrElV57IzI/8CC/qsCsJBQlKYbsQ/hJppLvjHMXEyZ+Tc1FKPJ7dncoL62Vo?=
 =?us-ascii?Q?4yDJuU7eqQUZiyU0ReptvDWR6rdlWcKhqoVy/bLoPpNlK951qsEcNjKBmkUs?=
 =?us-ascii?Q?caT69rqwNa1FS5Ebzq/1weVhutF2wcjXiTOAVL/7CQ4rlrg+cLMh++peX6xp?=
 =?us-ascii?Q?7f2vQlCCgzN3+OAcQY7MWbCTHEmiaNwKHot6fP8xL81Rt4B7yFhDkuUcDyYZ?=
 =?us-ascii?Q?uKgT6O4Dwzfu3gedi/MnzN9SalgiaNj+jdRQPWHmLnZKH6KVZHacOoh4GvNl?=
 =?us-ascii?Q?C9jJ0kmfXEXxM1rK6AXT9g+4FfoCEclcv4fP1FjQOEaw3uDk/Q3LraDfAVQG?=
 =?us-ascii?Q?h90yV7dB60EoWiAnT8qDEWqsVeh3zzzia3cTC7OGJLRkgOkSK8kwnmsYHxEV?=
 =?us-ascii?Q?gP6gHuCqOkRD6wHxRtTAMXcpKoAXIp819wfl4lj1qbgSlC2JNcZNZR8WX3c+?=
 =?us-ascii?Q?1tkO9XWN/DYGQJXu+itzNqPBA6oZ8wdwMKV1Wlq+rfmSAbnvjfmJ11gPU6Gf?=
 =?us-ascii?Q?Ye+Kfia2X5EAvXYgXOi4kGGL9dH4nZk6sZy8+PEGRpwGoB9hjziNpRjsBHq7?=
 =?us-ascii?Q?82M813iFZGKP47KLTUo5/8AXCnA/2r5xJ9r5eEN/YOpl3HhfgEtnNQci76nf?=
 =?us-ascii?Q?1+u9HP3gzA0Pp8JWWp0yrQhLyizhboM0PFYEx+oMBxUvQdHlpFUhnKLjwmFF?=
 =?us-ascii?Q?YL7rkAUPeJw68FxwLqzBN/t5RQkOHTifUHVHx6m9PNJ2RwLC9Vfv8urYEHS4?=
 =?us-ascii?Q?lQi24g//wirn8rENWjKfewFOgl/axhr+Mx9IYMnknGm3JgYAd/Kt2IrbaSnF?=
 =?us-ascii?Q?AQZuECjzZt/bZdtoy1ZIB3U/79hY0KeIOPWM0dEPebbOzOwJP4PsfEw1zc62?=
 =?us-ascii?Q?iqLiYiQ6979vRNgXJMDf9mbWRAwPEd1PKkpQ2HQe/dmRh4NdVJehRxvThCFx?=
 =?us-ascii?Q?4Wx+sF8QPBxtuA+P8voMws/+kD3KuRBsEMtONxVMEyoy217Qkr/RiTZFpgS9?=
 =?us-ascii?Q?lZkS52rSv0p3GRJILuhEzbYohKMq5KwCmSvhhjrxptBk8eDSjAFORuAE4syH?=
X-MS-Exchange-AntiSpam-MessageData-1: yAPfz6ymvtefle16dDEekPcfXFEpxG2v/tw=
X-Exchange-RoutingPolicyChecked:
	r+Fw0ruQGv+Iuo3ckujVGhipM1ZpF+k4C1rnqrUvBFRDppIJlyVQ20UQ71ah/ZMeddQHsSYxtxLqI7Q5M7iC0vyMeZFXz+a9yy7wqyVsoXlHRJ2pa+gitwf3i3MmTTmM6glI6yb9sLo9isErG0YDkcQwLoG9sMe9PwUfCSoj/h424YVSqAHPzw+dpSPFMLQ1aOsye7EBpcm7uRsLlQ70x74vaTHUJtqD5LIVEU93piVhOYC9XO/TYz+QpejpEnS8XrU4akInFYwjA1zDXzdv0DFOdZ3jiyE+pj2+87PKqdskpsnlYH+9I1XXbMnFEaUYJ1f11y00TSww0iyYVj7+oQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9985a488-4a1b-4bf1-ab14-08de800fb5dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:49.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0rtaOENJBXbPfo2RhnihwjnkixconHRLXqNUc/0OkVFuatqMOhu0KNiu0mdAzX6cChpjOAsj0uTD/iD8jDMbjSKGEHWt9pG07QiWgbBItE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ePAeTXp1 c=1 sm=1 tr=0 ts=69b27673 cx=c_pps
 a=CnS1ju6qDdjTg6bRefQovg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=mwtzV0mbf7fsuNmZlS8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: aIO_lnsUfqQYeLjXM62fq8Lne82kwGpd
X-Proofpoint-GUID: aIO_lnsUfqQYeLjXM62fq8Lne82kwGpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX46Ldy8z1qjqt
 4vtIey+H/B14aYZ9Xx2jkUTdMeI3dAlFjSX7KUQuxnLWWLqFfLwRsm/9B5kjZAsHIhPP7Fovpf8
 hVKwPigQjccLK+0gKSVfBDTVXidnztM+SI5WdMKt/AnTCQpFTK8JqtY9WZPVbslyLifLQjv0a0P
 3UqGA0Y1JT2e7bsQNh2AVg9QAo7kchjEvrrDyp5FgZgXmRVHMnkK90SyxrnBat4tSaD7IEB4RkG
 JUh+3Ut6+Kh9I7r5jL0J4IJdr/QYkvcj3PKTyPWj00wWU78rWIb/B+v5Vsluk6mDK1sOWJYxtXJ
 +ShDi6WZukxjsWqpipKnDIWuAkXvFTBZXBcDYJMRxDvBmyDzRtRofousNW9sCGqgk3OIw6cCFLa
 gNfglmfk7u8Y0oNmAX3WhRIaTn4Vy4H4kMHPvKslnJT7Q0zDVMTECPckzbWmnuwQR4kpnTkxaSr
 K1tECZqlqX5EccdIG7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

MDS requests created via ceph_mdsc_create_request() have r_timeout
initialized to 0 (from kmem_cache_zalloc). When r_timeout is 0,
ceph_timeout_jiffies() returns MAX_SCHEDULE_TIMEOUT, causing
ceph_mdsc_wait_request() to wait indefinitely.

This causes hung task warnings when MDS becomes unavailable during
operations like setattr or truncate:

  INFO: task dd:12345 blocked for more than 122 seconds.
  Call Trace:
    ceph_mdsc_wait_request+0x...
    ceph_mdsc_do_request+0x...
    __ceph_setattr+0x...

Only the mount path in super.c explicitly sets r_timeout to
mount_timeout. All other MDS requests (setattr, lookup, mkdir,
etc.) use the default 0 value, making them wait forever.

Fix this by initializing r_timeout to mount_timeout in
ceph_mdsc_create_request(). This ensures all MDS requests have
a reasonable timeout and will fail with -ETIMEDOUT rather than
hanging indefinitely.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 45abddd7f317e..ac86225595b5f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2613,6 +2613,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	mutex_init(&req->r_fill_mutex);
 	req->r_mdsc = mdsc;
 	req->r_started = jiffies;
+	req->r_timeout = mdsc->fsc->client->options->mount_timeout;
 	req->r_start_latency = ktime_get();
 	req->r_resend_mds = -1;
 	INIT_LIST_HEAD(&req->r_unsafe_dir_item);
-- 
2.53.0

