Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E929E114;
	Wed, 18 Feb 2026 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444237; cv=fail; b=T8ksBRwY4PDxtohrOFmODLwY/ej47WMmd1nopR11gZiuKnYztCSRrd7KMIJjeBFWgSabs75XjuV0HDjGqJH9PGbPpTN/ROeOGRFcUCwMQam4we0KLFiNiQWnY6KAgvc9XwyHWZCnDBv+PUktcMhZxRPNczcLeDl2DIUo6wEo+O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444237; c=relaxed/simple;
	bh=Xw6C0pSCAk0efZILLregiylFmYbHc31oPyiaQAKB3V4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ljG+fvAe1Z7GgvXHUmpygxgnY79qUjkFi3lfjRdnGw7xH20X74p6vHSe3Wv/1+oZhOhHnhM7qN7C3g0lX0rJca44FKdByRdl9snxTIgrqfwLPPmQJRzUfI6VqyquUWcM4h3B5mSzPVHvXl0J4VEUYtZ4S4Hi0grE3w4XrKEMez4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gidADHRM; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gidADHRM"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IAsIF33159250;
	Wed, 18 Feb 2026 19:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=CDHVe4TV7
	iY//tiB2+t2PdPgxIJrgN1iCY5OSc7bQs4=; b=gidADHRMDoHLoZtS5iw149V+z
	RXkfGEqCI2oj/EWlNcIgaHNdrkBi7rQnWPICK/3ZzXrygfIMjfBb6i3Q4oO2rc8C
	WXWzd+SC17q0YYqwr64CLoFrLAyu0fHJEx1Kqm3lTpUN2E1PcQmk9eA3BVjXpy4e
	cKMXl+JDdu00DO71UAN9+Wwp0bykrUqnoQmqAW35FqBABqoHoGuiHfgdVQl8T621
	jJEm6xxsmQpAWlQr0CcmhgCdb5QN64hjdzkv2bLeefcBfvqwNSB4OhNjOCEZq5at
	qP/l+/swFG5P+VsFLpGjD/XhEIiK5+DCv9a12SQgOZGt//ZYJ/+GHQ6BrKa9A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ccbasjtrq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 19:50:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeQsfX+yZKkkpGcM/AaKjU2ol9HpNvlABRhcJ5NVJxlklXR9Swu0XTolrhBEiRgh7sR22xUpHe99P7lgFsWfp91188YkG5LCorrvmmgySZe5xDBCggU5mFG8aGQb7ge7E765Gu2LscqrOxAaCE+oKG/O8E5gysCj0jkfdRXUzN/1dsAsLfnM+CW2v9bma9DQ7zUGNCNyoyNEelIOad+F0ut8BaKthuGKBwGCFcInWwlc5LpPUE9Wq4yhF64SkLeLKDgy3iQv/NqFvu3kIMrNqU6yJy9/ggQfrWF7twDxMBxik774iMRjFrPtuhc1xvXZCQ3O6pJOXVhqzsnIRB+R8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDHVe4TV7iY//tiB2+t2PdPgxIJrgN1iCY5OSc7bQs4=;
 b=BULbQWGwYYy7qFg5dpVlnvCDmdayoDuTkUw/XAz+jtoanrK8J7jNit7vwo46Htvz2p/rlP4kkxpWbvGOa288nrCKP9dsTrIDxapeJO+1eRyeX/7WhcpznQ2B2l4wegBbqdPm1pvp/Js6Pm1hFpy2c5+U4F9oovvXfCfxjsLvxnQIIMrnOzZUnekyOXYvIGSZGc3uXSVsmsbSG+21Mx1RwBBMvS/hMD6Won/iB8W3IaH8sshVg4b0g1ray5ug8ixbPw+crD11jOfHa8ZqrVh0iyCt5Hs5LkiooBFF0VIWN/hkJb6Ct5a4vkDQ/hiPMzrxyK+KMFg8lt3jxRrFwtlV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 18 Feb
 2026 19:50:24 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 19:50:23 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH] ceph: add timeout protection to ceph_osdc_sync() path
Date: Wed, 18 Feb 2026 21:49:46 +0200
Message-ID: <20260218194945.47707-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: a24bfe2b-7037-43b0-5d87-08de6f26f491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GUt9CdVNDVIROIUYmlz45yCHeP5M5Z4JMXrR5N1aLLwOwoX4tkcfr8Gf+529?=
 =?us-ascii?Q?EeovAFdFk/mDD+iMqsWcXbpGg9lWVlcMuxiz3inZ60DghR4VhRqMQNkWY4KR?=
 =?us-ascii?Q?67M4EuXkvD6kGI37W1Q/D+9hUI79p7DI21Zy2k+QH1HHV136wRtW2rw4hWrm?=
 =?us-ascii?Q?2JCU9B8gnAwPM4iojCD+POjwcACf36ToN3s8j6XV1sXM7PCOhyPRo5/xJMGY?=
 =?us-ascii?Q?6WAfiIcn+GbWsBAHO80XZfCEsuTLv9asbZwWtL7L5u/gUWsgqnaCZZsRv/ZP?=
 =?us-ascii?Q?YPkEE0t4hgIqqEdat7k2ZP6v8P/wP1QBCYyLxbFnTrXp86jT2xOPABbvDf5x?=
 =?us-ascii?Q?oQW4ryjYIrXJqHhb4yNn44aDQ0kfdyySmh6b1rgGK87NERV+aKNbjXsOtaFJ?=
 =?us-ascii?Q?u5A2lDjJ2U0BDdfe8MN24n1EQQj532ywdBfX719FwANB+A0GYEXBu5MydKDJ?=
 =?us-ascii?Q?AY5rXOto1WeiRg5N8vwSqh4h28bCZSf2oDQAPwJUc4IC2UWV6nTkkF1N2qM/?=
 =?us-ascii?Q?UXMSbEgwT8/n3DKMycXqMKrR8+oaCoid7l/jPSEayv2NyeIuK5MliRCkqJrh?=
 =?us-ascii?Q?RGdsJ0bvRGiuQ7YbvmDylyI9nkTlfqMjP61C+iUM2LS0KoQ+nORwaGfsiP4h?=
 =?us-ascii?Q?7N00ZA7Pt4BQFGhQ06ikFuAGqdc9t3m0nQ0wbzTBTovAZk6JTYUa9SRwCra+?=
 =?us-ascii?Q?SrZL4JxCJUYViZbd7CC1KLjmNSLpZRNt6ECVNDrDqrOm43PXFzz+H04pNGze?=
 =?us-ascii?Q?8UPNMBYyApOKYk2GNjZVcUm+AR7aG60JQcvDh1LtkP+FkD1rAn2oe/r/uF0g?=
 =?us-ascii?Q?LVWtD6idkQx4ODvQ57h0f45ZdFqFlUnjvcHLlyPbuxgKQXp7Pmiu/+xAogQT?=
 =?us-ascii?Q?o7S63u/0SY9BygwMbWR4vIhHVRCfh8Op0a6/YjKcCN6ckHQKjrumxfQ0WJZq?=
 =?us-ascii?Q?xk1zjpb/fwdNWeSJO1+sjbZEz7x2Jdi/IEbkbwWIoXl/SineHdcnA4GRjsjA?=
 =?us-ascii?Q?bz/jOAmJP79l1JggAQ3JcDmWVfogmdyqFQ3r+1c288geh7A3dFgWVSt6cKt1?=
 =?us-ascii?Q?15IoTT4KEtoKGu4KVyfEXzySRehQAfI+sKFBTklWudOjRnlczw6thMQy7AyY?=
 =?us-ascii?Q?fg4bhGEPaawXE8pElX8Unw6rdxSy0Z6N32gKDCd3mOXC3YlLHZ1yLRu3QpQc?=
 =?us-ascii?Q?kznbJDoZt5nctpabm0NHIKBIeQJHCHUu4GKe+O8ycJqyCPD98LgbZ5ngmO17?=
 =?us-ascii?Q?ChQSa8dHpVlOxziZPi4OSFibRXq+ERBDc6hCRhrbkFUeOwtDjvNibyJOxqAa?=
 =?us-ascii?Q?plTxI52kDoQXXAhJyDcTHXYbQs2mxF1CpCrCKYjjzqM8Eoi3bqgegZ8qXqN3?=
 =?us-ascii?Q?CsAMHc8NLC0B7kiZ/sB4CBAj+mbJQxT1jcLoVUTIu/EKDny7gW437zoGQ5tj?=
 =?us-ascii?Q?g84rEXwcxF6krw8kVXAgwSRpFaDdCifJ+64vz0CMtcQIpkRHyt8n97NUAvZ6?=
 =?us-ascii?Q?bfcsBfBNzi2SMlFuL2s9/qG5QQHcr/fkD8axBc+afMQcIpYFXaymIDz2pOxQ?=
 =?us-ascii?Q?8JWbB50K70jceUFoFsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QAT/bVRdAfl6qsB+BZ2BeY/x1geYeNOTM0qdMPAMkR9iyQX5Ub0VTmobS9b3?=
 =?us-ascii?Q?Mham90QOaDMT+pO9QcKxVAq6RCakUffV5A1mUKmN6mQh2s96/Fb7+zrhSLpN?=
 =?us-ascii?Q?Ux7CSkSeCX3MjBbwUnuYLoBVN06PqSAaAbAC19FPSMmi7qYUFzNo94bUBsvO?=
 =?us-ascii?Q?dsrILE2dn45HNmwfXkolnsxZ39D++VCQGoVD59HlHJq25hGNrL6FEOwa/9tU?=
 =?us-ascii?Q?9S4B8Y/HG42SLuprVCAgmS6CKBUDsaJO6DD7UWmwlNrDSUTD+s3ntct47Jad?=
 =?us-ascii?Q?PeK4j94OGpVE5Aqrmv856X5+5eBIOkM8qADjhplzcQAkpfqgFb5zduxN0hKM?=
 =?us-ascii?Q?2D2t0VNeABXkfud5Xe6dnqKbQJalGfwX6eIyNoELRG/mt550JsJU/w68uxqb?=
 =?us-ascii?Q?KyAMl3JozEyA10/u6mS8MBgyt5fNGCJ3R0I0om1CcRs4QzKfegtg8GalOWAT?=
 =?us-ascii?Q?JGwWVhiWOMwiomRKe88B6Mpawj2emwKZBetPOVfssT3q7SGtkQwFfKRyb48a?=
 =?us-ascii?Q?r7zrrxiu1p1sfIuGCNyM4kFLCMi9Adc9R1LFL26CC+cx9MMXsSTHgWZeyncA?=
 =?us-ascii?Q?uS/lZlnlcVuebYWUrIwy2QMmvuufH5s/5CBBTEgAKcAn8M4XM6m88DtvxWq/?=
 =?us-ascii?Q?OkDIUomaQIO9zybwxdfXNA/7g2gJGY/zlu6F9qeLuUREafwRGD/8b6B8EaXy?=
 =?us-ascii?Q?klPcQ+vI8J3J98xRuDf+dSqkUPukAekA2pUq1bDL25gLVI2yXwgKjNgb4G/p?=
 =?us-ascii?Q?zcAKgHdKtltOKPWFgvdE49SrMMmV00cicgHdR4Z+IlYIyrh2h4QvJcsZyxM+?=
 =?us-ascii?Q?2JNe8ZYg6Z+ktjaSEA82+lbaMDnRAtzFOlZJ/1VDwsLXSYg4D8uS3MCepZYK?=
 =?us-ascii?Q?IwFr5W7UcQ6SQCtMLJoC6qUDSXtdnB3blXp/5TxhFoBWBbF5+hxClHREIJNi?=
 =?us-ascii?Q?pOCHMiVsLTjZaSx4u1kQICSnyVstjtKmcIdIqLmZiZXfKjxjjeOs65GygAoi?=
 =?us-ascii?Q?j0JHKZ2vvMFm8OB6c9FQ654pV+uk1kbokoxXUepoenrDYKDY3nSPKaje/LPg?=
 =?us-ascii?Q?Ih1za0AV5LXt2bZaP/3ncis6888XMdbAJ/prvV/TAsg3+yuXAqazL0mI0pVB?=
 =?us-ascii?Q?rJrSs2ql1HDUrY5hy9bEzx9M/nNVdu4VS3q+8QwiEPMN8ibUPABWyacDRnog?=
 =?us-ascii?Q?Li7qclTqokLaiBLvJH4qRAHRV4xS4tUV/7g2qJFsigDFXjCpzNq0u66HDWQl?=
 =?us-ascii?Q?7RW6GlbBJdWyuIxcehbVGJ0lD4QReqwxkzFieW1uMX5Wp/lWTwjHetnjmZGj?=
 =?us-ascii?Q?sp65BgQ2D+G6tonGOphnBhx4/taXPQUpa2Uo2y/Pf8S4dOgJB0anXnlewFAp?=
 =?us-ascii?Q?UsGf+QCxCRFHO71ObKJl+bQqvdsUnKZ3n0e0XrgID7Ul/rU2VwHRYHcGUeSR?=
 =?us-ascii?Q?PvOBc8mY5HjXWJn7ED6+bj5u1MAY80aUtKHvQjg7PV36FdVWVv/nHnmh2zqb?=
 =?us-ascii?Q?wq3T5xissTEBPjwM++kvqcx9RjzmjE3QQeN73MvDDYw54208vDKkJ7oxN+9g?=
 =?us-ascii?Q?CX2PmJgA4bRIK+Tf2lc818LMvXEPVSP6ZksUH3wYM9p2e4P9zi9lLWVxkEhL?=
 =?us-ascii?Q?xe1aJTVR2bBNd6ZiF2eVzlsIJE8eGuNHwfGRTiS9xTfW2f3ncfZLyD8lbv7w?=
 =?us-ascii?Q?/Y3gtUD1hCcJ2BPvbsTDAeYLkJKimz9lssSqX5z5G+obnJWMrHTfJ2xDtemX?=
 =?us-ascii?Q?aNmR+PVIerd+OG8w0fyi/U9FDIysQJITL1O7DfnZ6vbPj7JjCyDcp33Dun2r?=
X-MS-Exchange-AntiSpam-MessageData-1: hiJWYUJ9AL5b/v4R3jFylzlJfbdFiFxRRfY=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24bfe2b-7037-43b0-5d87-08de6f26f491
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 19:50:23.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8bR/xTawd4t4C38rdUuDhTFLp5ALvinjA6kX586vInq0nLJn8mAlO0RanhTkgv1r3mSYS+KO4TTna9VKNDHXfRyK0fbwzX/PjlmkttlQJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
X-Authority-Analysis: v=2.4 cv=Y4n1cxeN c=1 sm=1 tr=0 ts=69961803 cx=c_pps
 a=Cwg/eoBiIzPoLCvUJpemAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=AFEWvRXOxcBv0v_5dq0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: rhESzCdszghm_R1cfpful7IVn-V8jlD4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE2OSBTYWx0ZWRfX1Eh2dtxrVs+x
 gW2pHQrIN0BSvtIXSXG6D/tePFalM9Qom/V5yZJhV/eRFo90kGZh79MOZF2N+q+dTSpUOBH1GJF
 vB0f43a2gN75Tcp72ZfpA3aEK4dkU9ksZzBuhk4Zcc37kfQbQmMXTX9zTgM8+FFL9ZksIjqnjTA
 sR8nQzqbUUdtrS/uqQQXmCS3+Yk5QrJ5Z2nLS53IW8LggBhPRwsUbBW3IEs7BLM68YB0ULcckzn
 K9toJICZn0aJdao8QNJ8B1rk3tQund3B1zhR24g/XmXz0KZmBltfMfSGYNfCAAOjGLJggF/u2kE
 HY5n+0VmZ06VpZEUEV412T/U/P5O9WETTFbTFXJMGPZ1pKQqgUqW4DStPp7DXgpYv7byiN0tl00
 2OHonqXYD+no2dn90SXBlUueTeF7n8Msc/ZhDKmxaE6awYTsQWJUDABqbY1BXisdUPoLZNJWyDF
 6D+IieuRgTm2Pfigb5Q==
X-Proofpoint-GUID: rhESzCdszghm_R1cfpful7IVn-V8jlD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602180169

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

This is particularly problematic in Kubernetes environments with
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
index 00d415af9680..f5ff8f505f85 100644
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
index d7941478158c..871827e2dd98 100644
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
index 2f1c461e0ffc..67f99579ad0c 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4744,10 +4744,13 @@ EXPORT_SYMBOL(ceph_osdc_wait_request);
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
@@ -4770,7 +4773,14 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
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
@@ -4780,6 +4790,7 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 
 	up_read(&osdc->lock);
 	dout("%s done last_tid %llu\n", __func__, last_tid);
+	return 0;
 }
 EXPORT_SYMBOL(ceph_osdc_sync);
 
-- 
2.53.0

