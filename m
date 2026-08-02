Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432122DB7B4;
	Sun,  2 Aug 2026 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710658; cv=fail; b=QYvjo/rPR8+E6L2kc1lLlv5CXxkUpGq1BeZr+iOUsfhg8QxbkIZm33ZNdWAgtIHAsxDOYokGCJlqxajIPIsDf+ao95diCTK2BWGxA/fe0LBU1wbW0m29FyguaInXYfo5hI/dRTeNqBmGavHi0Es7F9D9wuvoKDmuPpVuowkrvgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710658; c=relaxed/simple;
	bh=1fX/k3wvc9dccXlfmy3M7AUg3o51uTDJc0KfqMCyt0I=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=tdBtkhH6tw2KZ3343y0GVasRKMJAkrjxMBWeMq6aUmV5DuhDpnhEdA+T4Vy3fvUn+bzETBWux2VrJxJZTk5bhvvQBdV5nlxQO4VnGU3iSeiRkc8Ht3BfRLr2pcxp0uRE1j1RcjavQIqufOKfmWPmhHWAG2Nbldi62ks2e+vqO6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J1dcpUsR; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J1dcpUsR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4oVndwd8SK+8TNbIjdenzqvPnA05NSfuGaL87lS7ZT9Ng8aviF98FmbT4+kcMj/S81aFXKz1Ln+jRS+ZXFOkcKc0ODjzHUVTX0EFIC9mqwU1sH7uAdviTGEhqHeYvAo/Ky29ddAumJA5rVpN1ypYtjqFt9MOhTbpoOjK+cLdjK57iG2RXyRfEPNua9exXVo5zpKThVefIEwEsdboG7vcDS5EQ8X3j0g18bENFrDIdDUy5gc3rH0pYJjb+OGUEykcZJgyEaXByJx4VAcLQklIcQYJm0N0+kD3ZVNk7Y3zmTSPAGjdcXcdIYp3STQmqkFg6Y+5T7Rkkwzf5nlIqnDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXJCsZD/jXbVpBLk7mx0hG2Iz4fY8O9lNJ0vIvXmoP0=;
 b=uekymOafv5UGFr85UkbGwUM524qUkIF9ycnDKvO1en/5yDCcIuf5vRRK8WXq+rsAgcWOp0Qkv0QBw8kbbVPAhvgw3/4ZJWkONzfmpwjVB5ZrdTfM/qgM7qS3vN1YnZv1RRttdo7cKq0dtMDAq5qStdEeVBB0PGEY8JrL0o8NTS3uXY0oD/tMLgeQKqhGONC5G45BPL0ZqjBdM3bLaHg2thXwpvUqKhLEHQdwaQd+cE7lHOdNK7OFDFV+9m0zc3TGKg7ijFLeizt1urWWOO6kW2dZAVHx+ilYTqJdosik5wgKIg2JCBnJAo0+lXyYt7am0AiiROWfjd27M7XeV/bepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXJCsZD/jXbVpBLk7mx0hG2Iz4fY8O9lNJ0vIvXmoP0=;
 b=J1dcpUsRPjoVAcjM72IkBEWfX9Etnlk1sAVkxy3rVXx/cVvJmy4tFVmK7Z3xU6HS1GJZcoxFmH/7xxeVgFH1lYMT4Q8Q1YgzhD4EQ71hvoxFf/RLNfQbYHw8ER8LfIHxc/ff/sAyeOnv2j6SIHGeyy0PtfILumJvT13sTSE1StSBkc/Y2RfGwRa/UY+pGFlxVeQ3iGAUmQl32rPBNm1hz5wCnz81kOg3KwjujUpuCmbJffWO/eTnT6jOFENDv6dYnOMPCmRFaLXn3uHbVRmt6rWBtZ0Y00kKlCP4qYe13EE7MS7HYoXP1PdpGzUeqCbvcrnqzY+4HtZ7Amc4+e/m3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 22:44:11 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 22:44:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 18:44:07 -0400
Message-Id: <DKETLELGS8KI.1B0MCAPS99CXH@nvidia.com>
Cc: "Ilya Dryomov" <idryomov@gmail.com>, "Alex Markuze"
 <amarkuze@redhat.com>, "Viacheslav Dubeyko" <slava@dubeyko.com>, "Jan Kara"
 <jack@suse.cz>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
To: "Matthew Wilcox" <willy@infradead.org>, "Tal Zussman"
 <tz2294@columbia.edu>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 1/4] ceph: add ceph_folio_snap_context()
X-Mailer: aerc 0.21.0
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu> <20260802-remove-wait-on-page-writeback-v1-1-6c35d6b3ad36@columbia.edu> <am-8AaWEHm7I9b7N@casper.infradead.org>
In-Reply-To: <am-8AaWEHm7I9b7N@casper.infradead.org>
X-ClientProxiedBy: CY5PR15CA0162.namprd15.prod.outlook.com
 (2603:10b6:930:67::24) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5271bd-63db-464f-fc06-08def0e79215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5ApD7PVEmuksINXtxVOiII6THSa/pdjWPDb6IPARnuFLoBrmHsR4L+JkJ5NTJhIeypXsYpzO6S4+8rwPv4DbssNUUfQX62GBBqRRvVrNNhM0shmat5xEymBsYgrqiCmpz2S4e2MrMzSQzVRucJolDXB0DqOXK+BC+ZysrOXRRCgNDk1l+UWFiQzt3tY5rLN9aVt5uhWQZBrj/zteRKPQ5zWXySw4S3hMw0TjOUcmEzAGwPxmQhY+EGPYv3rxOfpVfIx6UFn5KcE+fFsrmVrp+6oMD+vJFUsZLEGYXrPBVQqTMvtmtyeRuf46MUzlxzHSCHXqgpwle4bWfElknZJ3AwPd4eGIZWRwkKDbfayxIELnO2K+sTKZ2ITviI/1G05Nb+VppT8EnCPRpKqI0LfB7p9YBxXReL8O+RRy4jfTeraE1bvXJSoFQJP8Z+Fef8m1YFnNR513xhVOSPsN0qx4/rbeGENZjM/Jrca+Ufu7FEnKlcms98lG3HBjl9KzYfHXECSA+JtRBB8tl+zfBelzZZAFSnm8IOfet3TPlIHK69k4wfwliJ8aCxezpnOxzB3MuVAwizAG3gHRjovRQwhlSsykI2wj4gGTSUkxqF6OeyhQXXzgR5M8pnXFVis+lE9jWpIbgALNZOEIIgLj26ZbB5x4QbXAN5r+jtrC0O7/v2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGpKYXdwVEQ5SGV3Tm9DeFZIU09GdFBYc2VHME9oV1lXa0Uvd2o2RUZudXVP?=
 =?utf-8?B?QnZtUXJZNGJJTUNmS3BrS3JQclZNakRnNmljZXZJQ0U5TjJ2RjRZK3NRaHJx?=
 =?utf-8?B?L2tIaXNkMGVEbVIwUDI4VnU4dVdiK0dNbzRrZC9HdlAyeU8vTUgrOXpyMGFz?=
 =?utf-8?B?aUZzMElIamgwL1B6QUc0WG5kNkprY1hTK2taSUhJMzRJclVVZW9lTnhnU09G?=
 =?utf-8?B?Mk13Z1g5Wlk3YzNQNTM0VGVlZ2RlTjFja1RqOVlBS2VZU08zemZaNUpwcVlz?=
 =?utf-8?B?MEUzV1JHT3krMGZZdUZoWmhIKzN1T1lZV1pvNjNTK2ppWGdCOFpvdlYvNFhI?=
 =?utf-8?B?R1luM3UvUWY4bVZTMUh0ZDRmUU5KQmFXM2RZVmx0aXhFQXV3VzBWd1EyVmVT?=
 =?utf-8?B?bGhlSktQNTEzU0c1NTU5VUhjZkhOOHVpMnhNdllnQ2c0NlM1RVFCUlUzTE5j?=
 =?utf-8?B?OW4zb3lSaVBuUWJVdXVJc2dBNFhBYVZwdkhYdVFFcWVnL3NyZFVpR0RxWTNk?=
 =?utf-8?B?NnZFRmNNdWtHcFZNTDMzTDRic1lsMi9BZGNsQXh0T2ZsQStoR1YzcHVDNGkr?=
 =?utf-8?B?WFFSMXMzU2oyblo2OXB2R1ZLaU9nTllnRlNlZ1Nrd0FDQlJGOER4QnRNUkM1?=
 =?utf-8?B?Zzc5eUFQMDd0MlJORGJ3OGNkNGhHalc3WVFJc0FRZTZSWG81UHFFUjlES1Mv?=
 =?utf-8?B?VDFHN1BHNlRDeC90RFZZSkZabW9nOWg2Uzc0TjhMeHMxZUlxVGlFTTA0SzFF?=
 =?utf-8?B?a3VTZDN0WDFMeGttWkhJM284MkRLUndiRzMwS1NUc1lYTVBIZEdlV2lSSGZi?=
 =?utf-8?B?TlE4RStBaXZSaEwzYnJFM3VyS0lzUGx0UndUaUtSckRsRDFBVm1PVFNmNVBT?=
 =?utf-8?B?bWl1Y0xZRUdxVkFDMVgvWEVaT3BoanRsMy9RSzRCMCtCRE8wdWZGSDdFRUt2?=
 =?utf-8?B?d3NCQy9hWExPdWVUTzd6RzRsakNLa1hieGd6ZmNvQ0paZlltRGphQlNDR1Vx?=
 =?utf-8?B?c0k2alQzYS9OQ1pnWG9UdEVtQ0hhR09FczAxWkVQcmdVSXZpSHo3anJDaENF?=
 =?utf-8?B?WVdDVDZuSit2U0lrdkxTblo1M2h0Zy9ScllLdlMxLzBydks0NjN5OU5McW5P?=
 =?utf-8?B?QWMxSi9CekdobUI5VkVpL3JvOVdneGd5cXF5QmE3SUZZeWF0K0pRanFRVjA0?=
 =?utf-8?B?MXYyTDJ2enJDaWNudHplMFZoYW1jc3RXL1hLZ3IvL215bWJYMTNleldhNnVo?=
 =?utf-8?B?MVN2U081cnZOdy9ySDc2RkR2ZllIeTVXSXpKVmNFZEdjTnhnVndOUFVuZTZi?=
 =?utf-8?B?NktyeHpwU05Ycnpuek9ycmp6cHpDWXJDMklLTy91MUhIM3VIaXc1c1NGVFRK?=
 =?utf-8?B?VFZHczhhVStzZkdaeGVwZmJEOGhtcklMNzJES2VIcmNpUmxucEhjZW5RZmVP?=
 =?utf-8?B?cEo1L1VMZHh1Qk9nSHNGclpQY2VTN2s2N3cydnJKeHRIY2pPS0FHY3c3L0c2?=
 =?utf-8?B?VjRZUmFpcHFOTDdHOThHM0JVdW92UHYxVDhOYWtSeUpoTlQvQTBGUmpsOE9s?=
 =?utf-8?B?eEtRRmVrS1dnNTQ4K0dZbmNPOTJHeFpDZnBlMTNRb2cxVERnVHhpbXM5d3pl?=
 =?utf-8?B?Q0xEdisyb3dPU203OGY4bmplRDl3bHRqYzV0T29EVnhKUmZMOEhLcm9ra1dk?=
 =?utf-8?B?Si9tM0M1ZE9LajFIUmdTRU1YYlNTU29XNTlRWWp6SFJpM1pCTFZKc0QwUngz?=
 =?utf-8?B?VlNxSnNYczJ0bU5BYS9ubnhDY3NPcE5XU2VBTldJcjZnOSs1dmVhciszTDNZ?=
 =?utf-8?B?MlVpaCtuL1E1QXB2cjVrWGJuQkxZMDVBa3VBdG9QMmtuRUlnMzdKa0tTejlO?=
 =?utf-8?B?NkIzMHcrZ0FyWTl0dTBlbmJzbDdpMmZEekJ5aVF6dUdCanRHSGNmdmIzNkFa?=
 =?utf-8?B?ek5MKzRkZXlLOFFaVEI5OFpkWnZ3Wk4vc2RZY1Y0Nk1LWGVwNFl2ZjFxcjhW?=
 =?utf-8?B?MzdobXlsYnRIMnFVdGlNNndWdldsNjF2YWpCV2NUZUttanhJYjJ6VXo5dGZy?=
 =?utf-8?B?Z0p5LzJBUldyeVB6ejBhOXRGKy83WUhqWGhiTC85U0RMK0pwdHU2d0hlcVhv?=
 =?utf-8?B?aWlvY3dqZ2Y2MmlaV1NpT3dEUG4vUUdtdmRPdmNRWUtPYlVjbVVaNWY2T2xt?=
 =?utf-8?B?UFMxOWZkZXRPUlowbTUzbjdZYy95cGRVMGh4dDN4elhWSzNqUkZHVEdrcW10?=
 =?utf-8?B?TjcxK1VWZGc0VFEvUW56VmJ4RDZDcWljcExQM2FDMDFCaHRpdWVMRkZ1OElS?=
 =?utf-8?Q?nZ4wdAyyH//3j4T5Fj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5271bd-63db-464f-fc06-08def0e79215
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 22:44:11.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYe4A5qjJ7KVRZJDIAs5AYJeyJAUbd6YcxZhImYE45Q0lsilMRZ6qwQHJARZsHnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037

On Sun Aug 2, 2026 at 5:52 PM EDT, Matthew Wilcox wrote:
> On Sun, Aug 02, 2026 at 12:50:02PM -0400, Tal Zussman wrote:
>> +static inline struct ceph_snap_context *ceph_folio_snap_context(struct =
folio *folio)
>> +{
>> +	if (folio_test_private(folio))
>> +		return (void *)folio->private;
>> +	return NULL;
>> +}
>
> Filesystem folios _ought_to have folio->private as NULL when PG_private
> is unset and PG_private set when folio->private is non-NULL.  Now, ceph
> could be doing something Bad (I believe hugetlbfs does not honour this
> for various reasons), but it looks like it's using
> folio_attach_private() / folio_detach_private() appropriately.
>
> So I think we should just do:
>
> static inline
> struct ceph_snap_context *ceph_folio_snap_context(const struct folio *fol=
io)
> {
> 	return folio->private;
> }

Yes, please. So I do not need to handle another exceptional user when I
am trying to remove PG_private[1].

[1] https://lore.kernel.org/all/20260731-remove-pg_private-v1-0-142c97ba356=
2@nvidia.com/
>
> (folio->private is already void *, so it doesn't need to be cast).
> Splitting the definition where I did puts the unimmportant information
> (static inline) on the previous line, so somebody grepping for
> ceph_folio_snap_context gets the return type, while not breaking 80
> columns.




--=20
Best Regards,
Yan, Zi

