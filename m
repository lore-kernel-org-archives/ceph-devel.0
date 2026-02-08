Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1DC2512FF;
	Sun,  8 Feb 2026 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770568988; cv=fail; b=g3NNxLPdEDoHwkb5uHplBzaIt0tj1zj2VMyb2l7octI6SCCtjhwJiBbIAPKixgzluErmA3wtYere0DqoNpKCEqh7bRs9zkwdGOma/flhcZchEW8I1uwwfRTxacryT50QIzSfoLZ/AO2vtnvh0w9pvXSSopqM1+haFrGjMlfxAuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770568988; c=relaxed/simple;
	bh=aj40BuPQ0qfG2+z0DUUkMHhtP1G8tRUssSIwGpwJUFc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JeJfjbro0ff9YY+6KjXhVFP0cIQjue2Pa1FTJJZnbuqXtsYknSWpSyE65RrB9b+UMypHEboNAfZkNS/HhffTwAjTwxTbgFTCYPczpgKrXbv9xKk1X6hoFpfmN0KHXeYr+XHG0jooGmjk78eSxWH2p1yY/nij4l6NcQqWz3TLK40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=oQdaCvic; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="oQdaCvic"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618GaW2U1866596;
	Sun, 8 Feb 2026 16:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=JWU1dkqya
	28Oh257TA08HQUPY6eWd1BGqEcMUqiXKno=; b=oQdaCvicWtXUNIE+AqPE9N0gX
	n2HknW6ziXTtVpDWR/uIVmVq6avDC5Haai1yez2JM00kbuLarUmXD8qrLbRQwdHN
	xFk2G5TtEe80NmZze5KloHjuWpmeYnadMU2E29m7PnWeoJmoi57fu+c60KooxWVq
	r+UNvnhpsnMCHQfUY/6qjZYO0roZlo4GpHAnfy0B6V6agCB3YjP2Bn2X2XCzNTpu
	GmHhIXsdsbEAE3MihoeIWGTh+6XkWuE7rzbt8Oo94Ta0vQPz6UGv6oNxTLL9ja5c
	KlBBpsGfWvvhTVaep3e41PWxHOvD3iUmL+QeiPa4+s+65j3T2r5cGXAG5lH3A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5tkwh5xc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Feb 2026 16:42:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlyDbjASk8H7RMpVNXH5kHdQPgE4W2nCY72OnPjAq5wbmy6/8ulq8uDOMkAHbKG0fIg+fRTg1WYjzk02n3LL/tOOWo6n9KK51ueOYborcsjOyqw3GPWPe+ldT5hkBEcRYiW/y8T5CYRMNyBUOwlPUmUIuqX/YerOTjzZYkYZr7ODzlQgHUROiajrpmZ2NJshrSJscOgh3SvgAxbSEU7H/TU+4rlCwsAOvQFxin2jCY3Voi302RKVkDYekPZkeczzCTXUsy22rmL5cQTwC/9FZHQBZ3tM5Xz1glLraIG0kyRRrmix20/q34h7SaL6QmPY789wreEidbHCDRCGeyDmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWU1dkqya28Oh257TA08HQUPY6eWd1BGqEcMUqiXKno=;
 b=RKiBXUrzM1xNGPwPgOfDPi4yZq93SUTKkG9PKTVHLgaf0u8/pr7vGknl0AaMCspIdIzc3bJ8o6xCvZHX0aEf2NEqnw0iA9D7k8PisZn61KjSQuOhYZg7RK5zdZq4TWzL8jKLoavhQhP15pdQkBT1AsSpmnb7hTtZTXpbbrNTSySnyUlXOJauJm1tUAgKwnadVZoopitRYeXaaH95IoXIUa5mPNjdhLbFnZpm/18cIRYjV/PffBw++VE7BdhC2/XFE4rwYUhZy1MgJ5Vwzepm4BD/cjqxI0Jm3jKJzHPRAw/zoXD8nJN7xzIJ+qgG0PLgTj4XQQYIJ289TPLzZ2aSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by PH3PPF6CF64E2E6.namprd11.prod.outlook.com (2603:10b6:518:1::d2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:42:50 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:42:49 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Sage Weil <sage@newdream.net>, superm1@kernel.org, jkosina@suse.com
Subject: [PATCH] libceph: handle EADDRNOTAVAIL more gracefully
Date: Sun,  8 Feb 2026 18:40:34 +0200
Message-ID: <20260208164033.457748-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::18) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|PH3PPF6CF64E2E6:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bf58d4-8716-4250-224a-08de673118a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22xYrBQ6SFXO4kVP2jZ3yNM7ehp/gD7KtelOCWSB4FL41N98hBJsdO7kVqEz?=
 =?us-ascii?Q?j2EVuuul7xjlNXnLD4KCssAd+WTNhpKDwWvE8Y7j1WQOAZmCQ1g5oCMG4ohY?=
 =?us-ascii?Q?ehN5FlwkgB6WVs6d+/CQaWazNnieYjfrTr6r1ab12E7G4emr3gvA2XHXgUG/?=
 =?us-ascii?Q?VTLVbG2ZsSKmgOAl2GDYDuf/bsP14Sx7Aaf3nbMdlJzI0nUkaG4pbFsKDm8V?=
 =?us-ascii?Q?gfVjth0P8JX1enPyggRVLSqRnvI/nKLNgI/Zvi2jukor47LqKQGkThl2wnkh?=
 =?us-ascii?Q?9r18DipXoM9XR5LmHiYclvPfWbEgKxq1RWNq+EvO/1UaFGvjyKLLY6noQHSD?=
 =?us-ascii?Q?a5tNZgVUrBQ5yw3N71hIFS/K0UqqIZDRjbq+8nGNhvtv5HyHBbqwxgLZtJjh?=
 =?us-ascii?Q?JgErW210mAmu6jzHgjT/d07XFdqDnYRUmMAgDLlVNRZWyMrKJMbR1Fe4SCSH?=
 =?us-ascii?Q?7qsZe6DXOJdX3B3n3tZ2cXbneQfw1UNkTO3Di05Ha++rYI2tkQwTUAe6IWdY?=
 =?us-ascii?Q?cOB8lNNhIPbtMWmD85rgU1Q1NIBzu3zhHSuHZXezVG6VyCqGEWLENuF8nk3C?=
 =?us-ascii?Q?4AdkbnysG+YRgpbMASo+n+B6RPPJc2UiqId8DUhvIo1tLKguc62TXMMPYBJK?=
 =?us-ascii?Q?jd+2oFdXHdoNDU52dGQ2uEpq7HSq5AluJMJqZd967mO+ZlH+SFUyUcCx/Qtf?=
 =?us-ascii?Q?azfAnXJqx5goRG7ua41LBabVL+gkPgOLah6UQN4fHs1U8YZW7UsAC8pV2/j1?=
 =?us-ascii?Q?hTqXuj2xvgV1xSpVxjBSWHMFc+kwxX8i14Rw4Zqs7OHZlFj/nyWtttOmCkKk?=
 =?us-ascii?Q?PE+0Zdhz0geOBWOC+RxK1eDwoZBRxigFsPHznW7/m77d4jePgYuh1ebBS19z?=
 =?us-ascii?Q?w93KDRx8+qsuwDwQtwZhknInS4rN8UcMpYicKVNA7dkkXUpmNC01HXpX/zqm?=
 =?us-ascii?Q?AjOUyTp+IsLz6U36l62WjYarz0N9xwDOzk65gfCKWewD/q651t+oD2X+OLWF?=
 =?us-ascii?Q?Jrdcq3M3mwzVIAVoJSHYn0AQV53vq6mUSlAISytV4Xaqj0WYCWXC5SZKKgYL?=
 =?us-ascii?Q?eRMuULjuhGtn1qoWv9kgCMTIlRK/+BAFKPkMU9lJ+p8WHK6giSJoxfmshY4C?=
 =?us-ascii?Q?VwHkudOnp9iTV8lXWUI+/BbjRaxpGRFQemJqHG41/Wd0RRKebxH4eQeHCvrq?=
 =?us-ascii?Q?r6GSAs2vwh4N5jKFDEaIB60uj8gPFqVTo/IeneCvq6qmUPTzICEJzWuHv9VP?=
 =?us-ascii?Q?C2swcoyfxjTrVOhptE/r7jsjJAoKq8RWaWBVPAfjfNpYpECn25hO2YGsRJwQ?=
 =?us-ascii?Q?8PhSw0Po+8wPN1lT9inWZgw+XgFo06lEl2VvkiWNF5YYJHo2rR2GCCx90/D6?=
 =?us-ascii?Q?h5Czy6nvLiBh49BYxGWoX2fy77zgKA13XeYzMkFKMjFT/WgEsDVLa+NNYHFd?=
 =?us-ascii?Q?xr3CDxsjPiU+Rzi9h3cxvDTe7uSypgxA8gr/L3j31Oglw981xz7PMEvt4SGt?=
 =?us-ascii?Q?89oX2d7iS7ACrGBnCQfS5Boo/amki6rfcEUqkdE2bUsAp2be+vM/aO/MmrlX?=
 =?us-ascii?Q?UueCbHwN4F7hSXDoPKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pHMlMwojYYRKpTCK5KYTU0/kxvl2XJQa99ElT7WMypr3ttUnPLsVhsaB2OtG?=
 =?us-ascii?Q?xrYze9P/nfNnyVadbhO26+I0LyyvWi04QjSk3bN25cVRiJeuMwKo9Krha7VV?=
 =?us-ascii?Q?fu6ghb6RWV6HJrgkvh7jUY0jnWJpg21B2QoAyBTMs+YWmnSRQkDPCKzfKepf?=
 =?us-ascii?Q?EhiQgEUrCE2EJj/Els8EcpwKjfwsRB1YwDNB81DucFEQGQcGqL7/LFZFO8WV?=
 =?us-ascii?Q?/N7OwaRlTYYLbGv7u70NfNyXJPNPqfgPer63u5isSiIFDwws20m17jdoMXW/?=
 =?us-ascii?Q?/w/Q0LVVIvc5Yb03wDPce3zB6cSbnR5XnaqWuju2nA025/2/S7Z/rBmMXJv8?=
 =?us-ascii?Q?9p+gFqBJWpQjbCOglBQ7k85A3Or3lDriW/zkCssdtGxMW5c/KfTQWHlKpS1w?=
 =?us-ascii?Q?O+5AtdyLXek5LUxzu88svTpANCZ/gUfWg2vu3ud0yTcKH/sXSFods8kLESHe?=
 =?us-ascii?Q?OmrFD9bWXkKfwqbmAUBUsofL/z+p6THeZUDaqTyoHuWzi+qbGApXX7ND7ch6?=
 =?us-ascii?Q?hHu2EJQwbGmhiVqI5cNVODojpQSMtQ3Hw+MZX7/rNZLi63GyQMg/sXSvJWWl?=
 =?us-ascii?Q?Gxz54U9rqkE2xwpaD4vYUOz9uMGrbSI0eboYMshePeYAQZ1Sdcb/2r94fjgX?=
 =?us-ascii?Q?5LUNDlFtLgKyNiqRVBNbRzrctuElIXLbze+C70wzCtIggxZs6k2wGl8TnyE/?=
 =?us-ascii?Q?vCubpYdJubRkNHJc0CrBb/P9GT8XPpMTM/ElW4NhUwsMpgWjuOkA6PqoXR9u?=
 =?us-ascii?Q?aEUALxtVpfNX+d5TJYaEO4OaNYENAkb+3DzWf1I3S9ucEjlnd/QF8tq2Ep/1?=
 =?us-ascii?Q?7DUE+vON2ZU3h0etnbrL7S1QYsb3cMTUL0zjmXiL8zYOD4vwq0aTPY1X8Ynh?=
 =?us-ascii?Q?qDuVsaIOD6rP5DsbzGwdxYy02Q3d4X2UKoAqwDqQVmtclTLJ8VF3ZeO6CSlq?=
 =?us-ascii?Q?oA14jPAyWIvnQ16pXIAPs4nhPUnxUj0xsuZGk8cMCaE5iIc/pBU+kxjGJawk?=
 =?us-ascii?Q?+6XBS7zF3I7w8S9NJLefHdV4B/bQjrPdGve6EyBeacMhS2r92BmntNvwAB2K?=
 =?us-ascii?Q?FpglK5dOQY1V9U2o6mfknMeLKPnt9AkAUtxbOwQNAlYIgERB0A6WiD90wW9C?=
 =?us-ascii?Q?oZ08WjGsCC6Nu2U7CRX3R8mC4mMVslE8aGF0CUvOdCIWWA2bA2S6ZMSUmQ1E?=
 =?us-ascii?Q?fh3Oeefp0S7DHLnLuHb+GwS2zjI050B0TpBkdUa1d2CxD2/zb8IUH1sKXu3A?=
 =?us-ascii?Q?tsdzPY0VSrHTYIe2zY6fhRZEOHESL9OVYT9ssf30IurLfd9bMrUcswsF7bvw?=
 =?us-ascii?Q?AFF2AbTdOLX7/EkR+FPazZTb7G9NKrvsquqZ6F33HiEQmvaaJd6S7HGr2iDP?=
 =?us-ascii?Q?rJYDT36BNKKFn3rE6X+6u37iM321usyskRnDXHE3hwf4Yl6iG/f+ApvSmNcG?=
 =?us-ascii?Q?PLRIgNhmG6Tlghwj6U8MullrQEdCNGC5Y5wuhnsI2OsiGQnEml55CGt4xuCB?=
 =?us-ascii?Q?lF6A68hyu1H4AF3sy2cIZrxfgyO98okb2Y6QNFV5mjaXcCwKzaVCdxI/3ZW4?=
 =?us-ascii?Q?LBL89li0pPCeK8Ea9t47JhDtV9g3SjdW3PzBl41tBxgts17BIhklb8PjV8Tw?=
 =?us-ascii?Q?mAz75sH9i//CaebNbsoKFlv+ipY3tPVmnOR8UsGwEUjBAsBCrEr3rPRyFejz?=
 =?us-ascii?Q?PW/Jn3Lmn+i8B3GAQjlzGjc//4m1dPBeFxrS8UKkjaQxnwHJYhgk9wNNT4J7?=
 =?us-ascii?Q?uZwsFK5XuP+sJfLuPtXLGNLi0W7EcwZGzuFxNoccS2hOaPIk1llTvN8Kq9j1?=
X-MS-Exchange-AntiSpam-MessageData-1: pd1rQMmt8SdKW50IT5g4AEJpgvb8/aoILOo=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bf58d4-8716-4250-224a-08de673118a3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:42:49.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmCG5fJKwWd3C82DOWEroO61eGnvcww7Fcgxff/uy4zZIMSDzvifqTVaf7Kjx5aqyPuUfmk/6amTkbHLftQ4qg5Zp/7KfApYfQIS9WSII5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6CF64E2E6
X-Authority-Analysis: v=2.4 cv=bvBBxUai c=1 sm=1 tr=0 ts=6988bd0d cx=c_pps
 a=GhmtI3pHzNGJg3++3mR9yA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=o2_YrF9zlmXqNPr8Jd0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: z6JzI7-7Eph0pYyXR-okr8XEz98F76jY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE0NCBTYWx0ZWRfX+4WbxCksaVpj
 myKCP5lygmYNHVQ1M6jyG+6H/8oXAlxLq+FvU6S4bGdQWgHUNxm+w6GT3jVgf8McIaEtS/05n5A
 xYvU5h20sPd1RAfe7C9sYZGWIe2m44BuTxtahsuXEGzlcqa4zI2pB7O8DKVL4LdDQ1mpkTm3BAy
 t5H62zZGNYsti3QeRzKvxnM8pBD0NBx8DG6XQOhhuNNK0GXu6uoDUR8YkOjEZy16LDkTvbOho5+
 WfssySOg9S6s5YyWH9n+EvMcvXRk843DIWbIatNxo50khLfr9zMwK1+dHl5qpNgvUigNqGxuZgz
 iulJXthwteTge4JD8ibFA9E6q1MkghIKe2geZA/trYuxAJ81atxc8KocXHmZ9aht1vCs6ukUkr4
 KqqJrYVFYA3w8R3N5hauptSi9GH9/du4AbwyI09giNnWdF4216Lm5H30yMd5H0PDQ7oNWiXg9K8
 bfZ/RXHKnZtlyqncbqw==
X-Proofpoint-ORIG-GUID: z6JzI7-7Eph0pYyXR-okr8XEz98F76jY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602080144

From: Ionut Nechita <ionut.nechita@windriver.com>

When connecting to Ceph monitors/OSDs, kernel_connect() may return
-EADDRNOTAVAIL if the source address is temporarily unavailable.
This commonly occurs during:
- IPv6 Duplicate Address Detection (DAD), which takes 1-2 seconds
- IPv4/IPv6 interface state changes (link up/down events)
- Address removal or reconfiguration on the interface
- Network namespace transitions in containerized environments
- CNI reconfigurations in Kubernetes

Currently, libceph treats EADDRNOTAVAIL like any other connection error
and enters exponential backoff
(250ms, 500ms, 1s, 2s, 4s, ...), causing delays of 15+ seconds
before successful reconnection even after the address becomes
available.

This is particularly problematic in Kubernetes environments running Ceph
on real-time kernels, where:
- Storage pods undergo frequent rolling updates
- Network policies and CNI configurations change dynamically
- Low I/O latency is critical for RT workloads
- sync() calls can block for 120+ seconds waiting for reconnection

This patch improves the situation by:
1. Detecting EADDRNOTAVAIL on both IPv4 and IPv6 connections
2. Using a shorter retry interval (100ms) instead of exponential backoff
3. Logging a more informative rate-limited warning message
4. Supporting both msgr1 and msgr2 protocol versions
5. Clearing the flag on successful connection and when reopening

The fast retry approach is appropriate because:
- EADDRNOTAVAIL is typically transient (address becomes valid in 1-2s)
- Each retry attempt is inexpensive (kernel_connect fails immediately)
- Quick recovery is critical for maintaining storage availability
- The connection succeeds as soon as the address becomes valid

Real-world impact: In production logs showing 'task sync blocked for
more than 122 seconds' with error -99 (EADDRNOTAVAIL), this patch
reduces reconnection time from 120+ seconds to 2-3 seconds.

Fixes: 60bf8bf8815e6 ("libceph: fix msgr backoff")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 include/linux/ceph/messenger.h | 11 +++++++
 net/ceph/messenger.c           | 55 ++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6aa4c6478c9f6..ec08d02a9d4bd 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -321,6 +321,13 @@ struct ceph_msg {
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
@@ -361,6 +368,8 @@ struct ceph_connection_v1_info {
 	u32 connect_seq;      /* identify the most recent connection
 				 attempt for this session */
 	u32 peer_global_seq;  /* peer's global seq for this connection */
+
+	bool addr_notavail;  /* address not available (transient) */
 };
 
 #define CEPH_CRC_LEN			4
@@ -432,6 +441,8 @@ struct ceph_connection_v2_info {
 
 	int con_mode;  /* CEPH_CON_MODE_* */
 
+	bool addr_notavail;  /* address not available (transient) */
+
 	void *conn_bufs[16];
 	int conn_buf_cnt;
 	int data_len_remain;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 70b25f4ecba67..d86efcfb7b87f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -467,8 +467,22 @@ int ceph_tcp_connect(struct ceph_connection *con)
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
@@ -477,6 +491,13 @@ int ceph_tcp_connect(struct ceph_connection *con)
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
 
@@ -610,6 +631,13 @@ void ceph_con_open(struct ceph_connection *con,
 
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
@@ -1614,6 +1642,8 @@ static void ceph_con_workfn(struct work_struct *work)
  */
 static void con_fault(struct ceph_connection *con)
 {
+	bool addr_issue = false;
+
 	dout("fault %p state %d to peer %s\n",
 	     con, con->state, ceph_pr_addr(&con->peer_addr));
 
@@ -1621,6 +1651,19 @@ static void con_fault(struct ceph_connection *con)
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
 
@@ -1645,7 +1688,13 @@ static void con_fault(struct ceph_connection *con)
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
2.52.0

