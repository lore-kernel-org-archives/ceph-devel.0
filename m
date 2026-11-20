Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160132;
	b=2lPNK8URY5ifLwNpZXf1+rlP5lRmyeqap2hC5PnyUUgMmkDXhbzC++a+uvFSSvGa0Rvj
	 a7RTv6rm+6YgKQKqaSNN/vaMUfILg1TTHduc2jlsHh/5XsHPH6y0ju8mihhAYjyjyyjXS
	 kE7kLlJDIeptGVBnIUjQoTBUs0eWB0iob5AEzewqaQ3I0VnO/42jzZa5BdB/2XJCa79Yf
	 1iuF5AZ1mIS9QyQqeOt7qdwJ3QgdGVYIYPLEHHZCsaQCMYhlPICNrE0eDfTFCHYal+GdT
	 XctYnS30UlAPUAyWUYnzsp9yk4+mPtxHPqizyK4+W6HJt6QOjhVo8ugmblsbRUojgKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160132;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ACeDnDdjwXd1r18WG1/QJqcY11R38eG6s0W4HmxwZZo=;
	b=k0HAuu37Xv8MWHb9cnnYAIT58I9OIBwmW9Z/Ceh9QGeGdwKASWi/CJwgBpocF3SexNdP
	 5QzMXyVedDFDNzGglr6OzDoSGMQ1MZ8XD8lmUgyxuTZDnSCvuOgWD3aMd5tq/Vl+kD2uW
	 pddy1yN2gBivKMr/nbEGQu5RLUycHlQg6/qK9bROpFAFc4xEIEP6dcUk56iyF340oyStv
	 eLLoEhTh5DC8qPDZqkiJ8UFwMttRi86pFQiOPD8yRX2W5KsNaRpbCY6arYpY+z4326xFn
	 s1lpROTsjZkvdwglGYzK4/kuP2rNc5xr34mc09yhJyxO1gnkOffNmffhigYdapiwc+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=lczvsVRh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7836606A335;
	Fri, 20 Nov 2026 07:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7836606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=lczvsVRh
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7LTu0648034;
	Fri, 20 Nov 2026 07:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ACeDnDdjw
	Xd1r18WG1/QJqcY11R38eG6s0W4HmxwZZo=; b=lczvsVRhziVvhYgHVqTUg6JTY
	M+JOn+ZT4dtuuVv5QKpVme56e2K1PZOmJBlXkpEoMTQW3mS67krLAfXLgZWCLkGb
	FV/Xz5YJqlTRgIEL24xj0IBlixDD2aztDlmomo3g1VaON3d5A941bRVIlda531+8
	xD347deDbhQibiCuM/L1l5dojfrtlCDkhEwfPqnRIOmW5t/fufuGCzwJ1Ygn0538
	8woxcQu63vWxXfqu5zmpZggdVapCGnsgqGuScomYfiBSOslSdzCq14fO3M4MnBtY
	YaleS6paaf+hbzpY1DfD76oG7IcjgiXeoYVj4bjQHzNYulV6R8vMNmmmzb9Tw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021086.outbound.protection.outlook.com [40.107.208.86])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvh8b1u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:34:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpxw771B/VRuSGUJRL7JYkVWV+tjLJiXlINRhNz+e+FVibnRF//vmcBEvWai5RvUnfXzUcD53nRRi3U6pxqt1+WhUpAh41eyNoGvom2nJjE4BzeixtVDhTkX9vsCOnUgPRbJaGIX6u9sWUYAMR8UwN8IrBvyY9qTN7sQQfsZgu9MxKPIdEzue+hyHaeIuSVTQ8c4IcdKXaqbh4wsJ7s2fxt0wMQm21x/3oJ3rvLn9xNpMX6CiPsSrOq1OJNCfuOx6qqf4rPQEBOOtLkeDICDLCu2ksxE3IwNeTSF9ZN63B0f1n213wEJryt9pfPmTeNB5a9eJbsWhtWUXWEM1nAvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACeDnDdjwXd1r18WG1/QJqcY11R38eG6s0W4HmxwZZo=;
 b=Xctz3jiQGIW36odhxntKmsiaYNTsy1Dsl98elgGIK24m23R3SCN4n/uuGRmWf3k37bTKKbKomsyzRuYiZfs39N6JJeh8mKexOXxrs54wMjPJ9l6UVzkBBKaR3yUqueTQKJrl0k4wcz5QTg/Fu3iSxPB5F05sMMoWwGdqYTVtTDU9TXcwjkP82I1D/hjbyt7AIhPCRccAFQ6ZApc3zDzyfTuYEj+uhowktDCpmIMBgvZlJo81I9fWY9didK5AzxqTJNkZJTRQnevOOC6INYNd44uYFA/dtOYI2ZDaDbCxiWZphdo53WJpRhzZmda+2ps12jxGSmd/QeQEBRH7Prsobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 07:34:53 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:34:53 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] ceph/libceph: bound sync waits and speed up recovery after network disruption
Date: Fri, 20 Nov 2026 09:34:16 +0200
Message-ID: <20261120073431.53636-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI4PEPF00000142.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::89c) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: b5933276-b7a8-4f10-ddf7-08df46d8c44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|52116014|366016|1800799024|6133799003|18002099003|11063799006|56012099006|261022105027099003|261026140227099003|261026121527099003|5023799004|261022075727099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261009223027099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	tMmzlG0Oh+6CoJak9n4XyM2zwuENNxGKR7pG8ueQj+pI0H+oj3m9dIm3Rc6dF6W6AGIvycaTHFmmkic2uVZniuxvcYDszExvahLCR6E5Sy/DVGNA+33Mbhma3RlFgPiwCTtkPwnmO2thdSKqt1bTS6qaiMrqc1i7nQpo0aCik87iGeT6Xf+eOWPgCGAhqK2V+PJdMGeKz8ochFyJXh5xGeZ4LeVwGERcknurxeh5BBKPkC+qM9KHZCZgrvphCdm/gv9fKOAznOBwB/9LDgFcUxsn382Ed1yg0wxJeSrCgSGdZRqMvgT+DA7ZMcllM8+ih9jwW8FaGc4XOX47uB6xfk1z580vTjpP0GQHC1dhDEfi9p68BMDm63ZIuhB6HJNeie/K9ETcV9lDkRzjmtZ7NrznX2pomPxub7zUYRh6Du1s8xrlJZ+wfpBAIuFiIFQW15gjbdEXEnfIzCWjTVi+3hRcZDSVgw1RChzNlQBnxf6nvSSHwghUTTIQ4tU7eViyLFjucVdAF7SEBWILGBNquWS1SUmTDNCXMcFB/tEJM9ST4gHry+KaBvUjpzDExiqyh3FNMifywkTzKADshv47LyhgJhxz7yk/zMrw17KKw95gFU1KIk92UMnhW6Wwdo2c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(52116014)(366016)(1800799024)(6133799003)(18002099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(5023799004)(261022075727099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022113327099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KBpO0fk8ZT9X+gYm/MTEyD0wchAYQsVB37lcidEGUG70/1BZ4GiAmoQInlLN?=
 =?us-ascii?Q?qhM0muba0kK6ClYov2ie+ai0/wwPVkpRmMP6TKJ5MQAFUZWUmkgowUSjGRn9?=
 =?us-ascii?Q?mb+LZEhu2qIm0IYtlFeUS/pQtJCl9JjTr/RfUnWzmayi9idgIcAVDwRNrXGw?=
 =?us-ascii?Q?FI8c++sJnYiIWXUUPYXixK6X5T9rfPtRGWOkUGaqPZHaoMrx09/hPZ61doyH?=
 =?us-ascii?Q?CyUuZfBO5UglgfmUJnv3cHBdUPoQ55dmDbI+bECMWtX/SFR8cN3UTcb8ijR1?=
 =?us-ascii?Q?JGPXat1XTq7SmfFACR55Qq/DDSfhwrMDLoaiBAJMDC7qSRcyNma4C0L0fkNx?=
 =?us-ascii?Q?9cykdseQEP1LybdpmHMwBDHVUc3Pm43Zq+JZ1k2ZwHue5M6jmCpWANRNjq5A?=
 =?us-ascii?Q?B7BUoZCjNLL4Y+THQ0DOc1OCSt8wfnTx1iMOoXEFBhG9BerlM/fTZCUrqWAg?=
 =?us-ascii?Q?BNg7G3avO6mf2Q3Cua6kCNyFJLlovDc3hX9JKz9d+T4YVQgIWp+TPqeeX6xO?=
 =?us-ascii?Q?c418eDLEKSSqJRYHA98Me/3J+D0JFeJlEmi2IV1mRaxQYTn7SXcYWrSBOI/I?=
 =?us-ascii?Q?84GZk+mR1fLGzQJUse4UaZ8iUmZMiM5Se0XCjjwN0wgNCXNXjYf5oonimi+P?=
 =?us-ascii?Q?atSHlKy3OvhGzMmd9YdXjj8+50jFDQnXoTO6sUHcZA6n6oWGxcH6JWkvjV3B?=
 =?us-ascii?Q?VbXhQAdINfvLkKScmwC3b0WkZHyXznjP8Ky5cJH0f4JtR47ABrrc2z5jck6f?=
 =?us-ascii?Q?ZYymXdEmJ5OIKRs17mmfJL+m1IoIEVEs+K7IfdrlJrYZ9riBkgCvTiAHJrFj?=
 =?us-ascii?Q?B0+ARbUTaleQQ0vJAaSVwJfqqwKCAFsIsa8Um68f+DL9lUnbMdYpznQgaBbi?=
 =?us-ascii?Q?netB/+Xgu089oL7/qRdoIsgJGOkLHCUfaqyoef7JRlKS339m4y8sBUTeWsLc?=
 =?us-ascii?Q?UCogs8aGQuVyQLMcl1PRKFVAItD0iBVICLKOgqjwDfxA1jbkbidZeF2CK+4z?=
 =?us-ascii?Q?EFsDVYN8z7+1X47U+maIh+JkuaK0JMZK9saHn+KYHy9ikJcZyaTVwteCFnGq?=
 =?us-ascii?Q?kkxGmM1cE3u2a32wJdNU92YH4GyOdcHsAGa2Vkh9AatI3YZn3tQxRBYuHMqG?=
 =?us-ascii?Q?dckGI7OaD8PRglk5OnElh8tDLih6AajNpXQhM5ZhX9+b5CVSnbRfb2yG+eIG?=
 =?us-ascii?Q?D33wSks7KnE9NS+u0h56dSdRcDyDIS9FshL3UHPoPOm9GgR4b9tPAaEydG42?=
 =?us-ascii?Q?5RdpDAH0lBhkm8RANDhcy+ruB9cE2bStO2olKn1GDIqUcl1sZvMur5B4/xs3?=
 =?us-ascii?Q?+/eQ4iNIH/nWscm/VtFdJrC8DL2tt1K25PKqqvQ8XCyTKJvhIM+F4zOfs1EN?=
 =?us-ascii?Q?br9OOmdhJsdqskyRDDQe5ALJuiOXudb2ix1UCnOKy1WTV2jMA3A8ufJ1MXuG?=
 =?us-ascii?Q?cupptRoRgbTgByUtGLs9n2BugQUK/tDqEMTu7nHC0fk7H6KSYw9buNF1Tsn5?=
 =?us-ascii?Q?ae3ky8C8IpBMtSMml0ulrRpDloI46SwgzgWXKadS7r2wYMxjpVJZX7uYBlY+?=
 =?us-ascii?Q?3TR+1rchWRMD7sFZRF5OZM+Ux1fR06ebYn3fXXaP9ykg4zyChsLtHSM5W0FW?=
 =?us-ascii?Q?vzdJLGN9w8CK3I+1p4xRqka1vax25V+PIU35SoPYe3oplScjv4E6YnrNO/5X?=
 =?us-ascii?Q?NKxMmA7mRnuBpWBQFFEJ+TVAJNbJrFZC5oABRUuKi1iLf4oNd21B9kzR9Cyi?=
 =?us-ascii?Q?qbWCQv8SY4urg0Iue5L+qD/nUn4JD/yboW+B4tVUBHoxhUpyYQj0x0y13k20?=
X-MS-Exchange-AntiSpam-MessageData-1: qIApSkjFkTiYTyOiIwLOESJ77Kg7WN0WYG4=
X-Exchange-RoutingPolicyChecked:
	RNSiHbFF4JbdvmxGU2Bb4gjdCXUfzkb1h49bHFrK/LdJWghJyr5h/Pg1SQMCEcfhVCGWv9QUDv5ml675UQHAKYOmYJgih/b7cvDbLpjxA0a1Ns+ZXvZ+28W5HWBxfrevMOqgdE50QB3msPr+QbqjGU6imrSh8ttV+HgLMF9SIRf28PyH+yXRaNxZsv5X3fIz2kQLpYsEkw9qyNXnmZp/zQyLWkjgOwW+ZtdSo5rBoiZYM73GXUmqsfg/OyuBPYd0FIHz66zTCAU6g4wDy1C4KTiLYs2BQNSB6igi/tFQoxv/G3zTv7GyZzzzV4zaCNpwhyAki9q1qmVyQlE/VsFW6w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5933276-b7a8-4f10-ddf7-08df46d8c44b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:34:53.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lf/HPUQp3CZVW0qJAENYF4ZHo8auVosy7DFyW9BW0aTu/wFBSJth2CDjtqOb8CtTSGNtdAVThpKLOhE1iy8/7IihD39CUoTC0MYAD4yaKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-Proofpoint-GUID: 6TaAzoBp6scm6rEE56gpom2dctq9zGWx
X-Proofpoint-ORIG-GUID: 6TaAzoBp6scm6rEE56gpom2dctq9zGWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX2u+tWLo4EKBE
 +MUBcgFM2iyrWBwg6Z1CML4r9O7aE6t5uFQRxRFt97q5YSJGJJULOSlhA9R2EoIJ08QMMK7mGja
 A/SxKTgn9sOzd/c1OX8mtPdZQDEkkJkrnzc0p1rUYO5BHDBbumcscAkOP3b3y9HStCAFTyl2n7o
 vA+7HuipEHHQ5KyD7cQNyN3DHhRkGJBjCijNSeewMo1NZd9pYanKmdScb/RE+qnS4Kh9UmUDHMo
 jrvap6u88tHdoUa7kD18kWxqsBCUA6/Bec0ZQCawu/Bxr8QFoWvEOGM7ElDUAIgv7jj5ducnLCS
 0Ieh4isF+8VV3bz4PbiR8ws6ThOFjKyUrurhDzYR2Q0AcbJcfJkWg6ugJF/AIDZRwaoF7hDbGoG
 zzYIeWHAewqyUb5qdjg/liCcNbWMhE4hYcLmUXYBbmHeXlr+rmMVoEnmms9pwkY7JPzXh1ZgtgW
 5ihzLidRrr01FuOXoeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX734buGNVDOHo
 1eL8ifhju8eqV2z9hcC/fviYJph/Pnsjfnd2zBIKvnGbKNwAX5nMxuFHwEWvg4sFMZf66vBHwaX
 33R2KhoV+XAvW0O2MyKSt/WFKbo3Hw2iqTtv5Gn3OjJTzcgsVJJF
X-Authority-Analysis: v=2.4 cv=GNCdgeNK c=1 sm=1 tr=0 ts=6afff820 cx=c_pps
 a=ucoVWjnKr/qwcNtWmuDa0g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=a444azelSWi8MX9Gnk8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

When the Ceph daemons become unreachable for a long time (seen during
Rook-Ceph rolling upgrades with active CephFS I/O), the kernel client
leaves sync(2), syncfs(2) and flock() stuck in D state indefinitely,
keeps backing off on a purely local connect() error, and can miss the
mdsmap update that carries the new MDS address.

This v2 is rebased on next-20261119 and reworked after the v1 review
and further investigation.  The patches:

  1    libceph: fixed 100ms retry instead of exponential backoff when
       connect() fails locally with EADDRNOTAVAIL
  2-4  bound the sync(2)/syncfs(2) and lock-interrupt waits by
       mount_timeout; mount_timeout=0 keeps the current wait-forever
       behaviour, and nothing queued is dropped
  5    default r_timeout of MDS requests to mount_timeout (unchanged
       from v1)
  6    request a full mdsmap when an MDS keeps faulting or a session
       goes HUNG
  7    don't escalate the monitor hunt backoff on EADDRNOTAVAIL

Patch 2 is built on top of the wait_caps_flush() diagnostic loop from
ebbbab66bd74 ("ceph: add diagnostic timeout loop to wait_caps_flush()")
and keeps it.  I know that patch deliberately left the wait unbounded
and that b52861897be8 ("ceph: add client reset state machine and
session teardown") added a manual escape hatch.  Patches 2-5 are meant
for the case where nobody is around to trigger that reset, with
mount_timeout as the admin-controlled bound already used for umount.
If you'd rather keep sync unbounded, patches 2-5 can be dropped without
affecting the rest.

Changes since v1:
- Dropped "ceph: make ceph_start_io_write() killable" and "ceph: make
  remaining I/O lock functions killable": already upstream as
  fa073039466f ("ceph: make ceph_start_io_*() killable").
- Dropped "ceph: add timeout to caps wait in __ceph_get_caps()": covered
  by 50958bb928ba ("ceph: fix hanging __ceph_get_caps() with stale
  mds_wanted").
- Dropped "libceph: force host network namespace for kernel CephFS
  mounts", as discussed with Ilya.  The root cause was the Rook CSI holder
  pod's network namespace being torn down during the Rook upgrade.
- Dropped "libceph: reset source address on persistent EADDRNOTAVAIL".
  ceph_tcp_connect() never binds to msgr->inst.addr, so blanking that
  address cannot influence source address selection; the patch had
  no effect on the error it was meant to fix.
- Dropped "ceph: fix race condition in cleanup_session_requests()".
  Slava, sorry, I have to withdraw this one despite your Reviewed-by:
  unregistering requests that have no unsafe reply yet removes them
  from request_tree, so kick_requests() can no longer resend them after
  an MDS failover (mds_peer_reset(), check_new_map()), and the caller
  in ceph_mdsc_wait_request() is never completed.  The sync hang it
  targeted is now bounded by patch 2.
- Patch 1 (Slava): the flag now lives in struct ceph_connection
  instead of the v1/v2 union members, so the ceph_msgr2() checks and
  the local variable are gone.  The delay is msecs_to_jiffies(100)
  rather than HZ/10.  The point is that it no longer grows, which
  BASE_DELAY_INTERVAL would also give.  I'm happy to switch to that if
  you prefer one constant fewer.  Dropped the Fixes: tag, since this is
  a behaviour change rather than a regression fix.
- Patches 2-3 (Slava): ceph_mdsc_sync() returns 0 again on shutdown
  instead of -EIO.  The MDS waits share a single mount_timeout deadline
  instead of one per request, and so do the OSD waits.  Timeout
  messages are now dout()s.  On mount_timeout values: it is already range
  checked at parse time and is the admin's bound for the existing
  umount and wait_requests() waits.  0 still means forever, so I
  didn't add another clamp.
- Patch 4 (Slava): dout() instead of pr_warn(), if/else-if style, and
  the result of wait_for_completion_killable_timeout() is kept in a
  long (v1 truncated it to int).
- Patch 6 (Slava): s_con_failures is a u8 that wraps back to 0 at the
  threshold, with no local variable or modulo arithmetic.  The new
  messages are dout()s, the existing "mds%d hung" pr_info() is kept,
  and the threshold of 10 is explained (about a minute of messenger
  backoff).
- Patch 7 rewritten: v1 called reopen_session() from mon_fault() while
  hunting.  ceph_con_open() resets con->delay and queues immediately,
  so with an instant EADDRNOTAVAIL that spun the monitor connection
  with no delay at all.  It now only keeps hunt_mult from growing.
- Fixed a wrong Fixes: tag (the cleanup_session_requests() patch
  pointed at a non-existent commit) and dropped a reference to a local
  commit id.

Answering Ilya's questions on the earlier standalone EADDRNOTAVAIL
patch: the cluster has 2 monitors and, as you said, the client talks to
one at a time.  The 36 minutes were mostly the external condition
itself (the dead holder-pod namespace); patches 1 and 7 only remove
the extra wait once that condition clears.  Sebastian asked whether
this is PREEMPT_RT specific.  It isn't: none of these paths depend on
PREEMPT_RT.

Built with W=1 and sparse, and bisected build by build, on
next-20261119.  The v1 testing was done on 6.12.y; v2 has only been
build-tested, not run against a live cluster.

I used an LLM to help rebase the series, review the code and draft
the changelogs.  I have reviewed every change and take responsibility
for it.

v1: https://lore.kernel.org/all/20260312081619.40854-1-ionut.nechita@windriver.com/

Ionut Nechita (7):
  libceph: don't back off exponentially on EADDRNOTAVAIL
  ceph: bound the ceph_mdsc_sync() wait by mount_timeout
  ceph: bound the ceph_osdc_sync() wait by mount_timeout
  ceph: bound the safe-completion wait in
    ceph_lock_wait_for_completion()
  ceph: set default timeout for MDS requests
  ceph: request a full mdsmap when an MDS stays unreachable
  libceph: don't escalate monitor hunt backoff on EADDRNOTAVAIL

 fs/ceph/locks.c                 |  15 +++-
 fs/ceph/mds_client.c            | 133 +++++++++++++++++++++++++++-----
 fs/ceph/mds_client.h            |   4 +-
 fs/ceph/super.c                 |   9 ++-
 include/linux/ceph/messenger.h  |   7 ++
 include/linux/ceph/osd_client.h |   2 +-
 net/ceph/messenger.c            |  15 +++-
 net/ceph/mon_client.c           |   8 ++
 net/ceph/osd_client.c           |  24 +++++-
 9 files changed, 182 insertions(+), 35 deletions(-)


base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
-- 
2.56.0

