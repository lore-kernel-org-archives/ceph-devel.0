Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795604964;
	b=h4YzFMkGUlS7w2TRhbXfKU5TWs18I9Y1ka++bQj5cVLXUN9tYkLVAgz7FmEIcPhmWLrS
	 kpomD/uzZ5kIntPb8t3GrjgtF3B2oZnV2IE4lqze5h+k+mMPSexa3v+oGIMDora9hxcE5
	 WtdiezhZQCYZJDjSQBU9f9Ia1WKD8LZJl2hsl9Dpahp1jHnCYnSM91/mNpopYvFzrhQgU
	 CwxwfAcn3Q/5r4femoTMIEwvdMec84yMXX1WR/gBbuPRo9rZwH0/qYSRxwro+mZGD/2XG
	 f9W0Tq2sn/2dU3qonZbAnpQJU9YMp42pj+4UThi1P6WbK3Wik4niTPHctRuYrF6Ummg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604964;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WeU8rPX3K+YWaqiUq6LTMg/HTCh8r6lTUaIL2xAshV0=;
	b=NerIdrrSisRQqCG+k7VvySy3xTdQ1idT4gO7TKJvF0zjnKSdhMHkeNR2zeId3QCRu0tz
	 i++GXZxtRYm1/lU+295136l9tvtIGfpt+vXgK4s2I3z1y3Ebb6QzCsGOXxhKVt1L8W8t+
	 4yv/080SxnLYzCevKNKfdnmD6vpPK1d/YHtMDmefv5f6HK0WwB+PJB/hj8PMzeYcFWmBV
	 p9ITEIL/8M/r9XOTRk143K+iRjUHzdAE0E3a67L71B3Mm4BmRrXqwlG5/3j2yeWzTf3V/
	 3qAIvlDFGIsATMduOK8+bCulQ3oXRxOfTignE2+eQ1O+2zUN6uyROpXx15MSKh3/csw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mueller-it.de;
	spf=pass smtp.mailfrom=mueller-it.de;
	dkim=pass header.d=mueller-it.de header.i=@mueller-it.de header.a=rsa-sha256 header.s=selector1 header.b=MMvywlhz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.119
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021119.outbound.protection.outlook.com [52.101.70.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD1606A31E
	for <ceph-devel@vger.kernel.org>; Wed, 25 Nov 2026 11:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3AD1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mueller-it.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mueller-it.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mueller-it.de header.i=@mueller-it.de header.a=rsa-sha256 header.s=selector1 header.b=MMvywlhz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2AueTgK3dYHujGOH0v3EUy2gPaCL/cbo97eckSfKfqmGRt5qLoGcx6iabHgthiGKWG7kukSrVh2qIuwquHay0T4SON4wG7FAH6r4z+2SiqD9p20jI8Gkola95JXOkKBx8b7aleW1BfFvhx38S+2s2fljeFW3Eenq4saI+tOP4N2WGAmIVWOkfu6LMM7HjdJqAGUyqDutB63Oq8vBt4kN9ZU50wclVmCoiKKNAnAxOSVHnG5EsxpmoslAIoJTjJ82FvpLZON4WbCbOgtxkRPGKsJVNbXMSZbGy3Ucxe/YtzseDAj6kM02dh4ydlJvEdxlKVx+0U7aPP4wWyv0S1ZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeU8rPX3K+YWaqiUq6LTMg/HTCh8r6lTUaIL2xAshV0=;
 b=Fol6l2hYF4sfKn5FdK7oTw5GhJ3WCucmQ7GaZqm8/H7ItoUuFn9SwEW9wgq4b2XnmKv+Uf6nb4+ntmfaEEiVHb2f3mAhZkJLruwiidTz2lnxbkBtc+Pasv03R2s1UJRvMOtPLIYiV5zouehAhXD3V6g2LM6wkZ5WRqelmZii2aUASI/0yozLPLabWSVIBJT3GROCEQb5Tkis/BTgDcOJ0r40VZcafaj7cebpNeFt5M3jlcvtsCkIB4djSNywnG9uJ5XIrOA7qmVuxsNsPz/IUi/AWBaSsRBi5U+BgLiO2zq+oouLiCYsDycCqpMl47WygmxFoco3jDDyC+xsJcU94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mueller-it.de; dmarc=pass action=none
 header.from=mueller-it.de; dkim=pass header.d=mueller-it.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mueller-it.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeU8rPX3K+YWaqiUq6LTMg/HTCh8r6lTUaIL2xAshV0=;
 b=MMvywlhzpk5hWdyXI1A91kx33lMZfTzBKzQHOxSNycX1Oxhyt0/el8mR5KChmIOqIZ0m7enveXKTjfH8nApZwmAIOAYzUXP43cuSrPoP5fP2gyt/PC+cOU+509ttW3xoYig+qX4FgO9v2dWHIMip3yi8BEDSP/g1PcRYqp1NcIE=
Received: from AM6PR02MB5224.eurprd02.prod.outlook.com (2603:10a6:20b:84::24)
 by AM0PR02MB5841.eurprd02.prod.outlook.com (2603:10a6:208:181::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 11:09:21 +0000
Received: from AM6PR02MB5224.eurprd02.prod.outlook.com
 ([fe80::c6c1:eb3a:c4ee:a950]) by AM6PR02MB5224.eurprd02.prod.outlook.com
 ([fe80::c6c1:eb3a:c4ee:a950%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 11:09:21 +0000
From: =?iso-8859-1?Q?Niclas_M=FCller?= <n.mueller@mueller-it.de>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
CC: "idryomov@gmail.com" <idryomov@gmail.com>, "amarkuze@redhat.com"
	<amarkuze@redhat.com>, "xiubo.li@clyso.com" <xiubo.li@clyso.com>
Subject: AW: [BUG] libceph: OSD request never re-targeted after PG merge,
 CephFS read hangs forever
Thread-Topic: [BUG] libceph: OSD request never re-targeted after PG merge,
 CephFS read hangs forever
Thread-Index: Ad18zScPSD7HdSGYSr2UOqnrqF1MUQAAC3XQ
Date: Wed, 25 Nov 2026 11:09:21 +0000
Message-ID:
 <AM6PR02MB522498A5600199DDE2296680A5432@AM6PR02MB5224.eurprd02.prod.outlook.com>
References:
 <AM6PR02MB522441DD8CECFA6C3BF2A2F8A5432@AM6PR02MB5224.eurprd02.prod.outlook.com>
In-Reply-To:
 <AM6PR02MB522441DD8CECFA6C3BF2A2F8A5432@AM6PR02MB5224.eurprd02.prod.outlook.com>
Accept-Language: en-DE, en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mueller-it.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR02MB5224:EE_|AM0PR02MB5841:EE_
x-ms-office365-filtering-correlation-id: 019ce1f0-6ebc-4cda-05ea-08df4ae48e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|5023799004|260925022911599003|260925021911599003|260925021311599003|261022075727099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261021135927099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 zhsBKJRcJi7z6xcnu3Q8ibPmTNk9PfTpIMbhSdIoJGL1yHYMstoijZUUN21sNlfnAdSOEtNhCEZyJ0jIltz2Bz6TUY2kFv7wbFjJg0aGLGCRfuJzzwFrMndscK1ttUd/HYSko2ZMMBf1f/dn0LHpgLrkvyB4X367th0zvt5PsxSXQyTq9LsA9s6qE6q86VHK2PLIMjUlLECnlI9jY980/NEDW7li0+/aaKn7A7qx53cz1pNwX93RMmGc7WCb47WgWE2y7UZhJn6Wnc8VH2UCrYivrPyo6knoATol1HcFKqZ7m2UGwgEHewM+Ay3KOI96VUMik/1xVJ5NsF7I2r5J31WJtYtn3YBTHPdh5sWoyGM2aNXC8im/fwNB09CPVRjWiP8VdAEUuzF1SHp6zwKD0q6fZnuj+uHwU70xtVlN/pHrNQwBBaGrokI6Nbxs9RM0XMYiuh7adjr+TyiPt+3lx239xXZkFUCdfR57QUXoYcc9YMYmi2lkeHOVAWL4JY/Ir36UXx82rcXT7HLWX/nQZJb38RsIPVxPSYGvzE9sZQDOBEUBvYmJ/rFT642Lp9T790AGnAHH/sEobfgpAAMuEcjPseShvVpq7W/ullgTaoif1otp3QkcJl7oJ+k2SpyH8ofXsD00sX9RlU8I6oMmoIbWWO/29MUz+ZhlNQdnCQZbWvb1plTesgeL2STq/My2OKG6lQevaY5f73fPx7S8ptwM/qW9POvSP+LWXqNTQn0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR02MB5224.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(5023799004)(260925022911599003)(260925021911599003)(260925021311599003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021135927099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fcgKOl2i0/A7RCZ7T44wyfx6S56apmnBFyIqFBiqJNwr0nIVMenX/OSDPJ?=
 =?iso-8859-1?Q?iD6UUXErnma8s4XNdr7d6XWg8g70IATju8S1dqaVKVP7lAgbLFuv6w+X7d?=
 =?iso-8859-1?Q?bKgx3Y6FON8py2RfyJBajDeXWNYb4oxCs8434QbH4dHWI2RhRiViDc5cH9?=
 =?iso-8859-1?Q?Fds71TKdSkRNUfCUOsGQEmOvrB++TqHizXtfoKofwxwlbw/Xgo9S6pTsS7?=
 =?iso-8859-1?Q?qumtIosM33G0CPSLaFL6GaR5n0+nNpe68q16bHQQKz5jt0jEJ6UqKsrV9W?=
 =?iso-8859-1?Q?b6AdTK/L6/cyb6p7GFpmsVE+cyqfGzM5MnjkbhD3LTBeMEo8fxboWnduK0?=
 =?iso-8859-1?Q?/UdjqQwHOr0nndi3QEJ/B0f0XrOiTSR3VS3zqEO3bY0FZhjvET2/Q0pYpc?=
 =?iso-8859-1?Q?Rgi2xIOlqoE0sOZ3UxEGE/nI+RKZJ0/OzdWtIPsteXEErwIPWiDHW8fvGJ?=
 =?iso-8859-1?Q?TSrd0idhnugqfWomPt60yNLroy4a8MxelEytRub9O4CVFdyyMBwzrbI5Aq?=
 =?iso-8859-1?Q?bNMM+OV32vK6qQp15J2/Sbc7X+pi3/9T/94yo+rz3mcIOYbrk6cqPhFroU?=
 =?iso-8859-1?Q?lNtTJt3ogpRt1kHhDWHxH8otAOn8HQYXhu8HPEzNVe95L8zNBYolUe4Fpu?=
 =?iso-8859-1?Q?6z+repE/75clD1a4Bxlq/HA+tGsQjjWDt8WimidX1eifAcG3/QQ6BEgF5G?=
 =?iso-8859-1?Q?in9Rujt2tpCTRTcnrFr9MwKrsoNqTJ0HafuEImIjj/ZoLm5G6zY046zPOt?=
 =?iso-8859-1?Q?syb5n5DOIBncTFT/rq4U7uzFFlkOFhWv7PHy44BRdY9pj7njCVQirhXXxt?=
 =?iso-8859-1?Q?m3ybzUM/5ebMlik25Dtpoqu4ruvtP6WFmPchqSqHuEAaP6eXbFsWgzJs7K?=
 =?iso-8859-1?Q?N0cjXR0lc8c9zkS85A0/T/+VimCGZeO7JM7JWVLdOM7TjW3SueMD/MrhF7?=
 =?iso-8859-1?Q?clZT5VFt3OtVvGJpUNcYIk+PJkeyZAzkA9ZTO5ETACOAUTJZx1ov7jblHs?=
 =?iso-8859-1?Q?sMWUtWJMsA+PyXw39sUU8syiSa4/l3YzzcmONqEtCOZHKEgn3y7zVzO9Ob?=
 =?iso-8859-1?Q?O7mR+K9Q/OFYBax7D1rcNCD20NtSmDj11siig/DbCOOBsBKFZmxoANScfD?=
 =?iso-8859-1?Q?KQvUy8bW2qTPy227jTg/htUbfEP70MZsnllbjDlZgV1a9pAFfVcdYL8FoD?=
 =?iso-8859-1?Q?hHhBLqIUN9UyUMsOiu9q+CE1ohjjUfGcN18GUy+6up/NxUJKwbeAQE3fhm?=
 =?iso-8859-1?Q?Hqv0vpk38d9Br2XJpKxCd/0NJ3UWGx7wOOO4nxZgn6NM7nTBVBWD+4saql?=
 =?iso-8859-1?Q?MjEfnhn9dWc0oHe1R427hwZ6wWPPVAksOfvIXYK1zVRUNIn+bPdZyWmFWn?=
 =?iso-8859-1?Q?NBLNtrlsBQ8RWOiHk5Ltrq/hLp95Lra7Op8pnln18nh1XBNzbD5GEJ3ZhH?=
 =?iso-8859-1?Q?FSol3YqWby/UZNUFqsxG/UlQFM9uEnEPfbGaypjtFOU9Pfr+8TmeQaqfMo?=
 =?iso-8859-1?Q?EbTEieaSIAz/Py7p63vnNDgJdBHik/BQShOD4YPHMp2Rf5s3jFnDeObooc?=
 =?iso-8859-1?Q?+w88W5jAWzMzOsrejDanQRGd9zDrdwog24EXcdvMiXnT5AGvncrZSqzh1d?=
 =?iso-8859-1?Q?cV7N9+OeDqnXLCMMgWlRvi9LftdQqfP8nQW/3Xty1DSCjCnWPT/tMrHTzh?=
 =?iso-8859-1?Q?Ago+0JST/Me8Kuv27PF0tHaEB+VTny9+XA8wOCFlwU9pHPv+2El+5MjRz1?=
 =?iso-8859-1?Q?0FKl9O/p4pap8UKflDbfExywtYDDmsaNYxtMgtgKk69Pkx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: mueller-it.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR02MB5224.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019ce1f0-6ebc-4cda-05ea-08df4ae48e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 11:09:21.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 39a4a88b-fd54-401b-8f7c-63f815ed5570
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Gq/iUYYOSAh7j7seVgracSEDw2eIm24AMrBOI4Ul35UazC2xcq7JWtsM9eCLEPIVXMPphShg06hdfEN0AyE0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5841

Hi,

we hit a permanent hang of kernel CephFS reads that, as far as we can
tell, is caused by libceph not re-targeting in-flight OSD requests
after a PG merge (pg_num decrease). The cluster itself stayed
HEALTH_OK the whole time. The issue was only visible in debugfs.

Environment
-----------
- Proxmox VE 9.2.24, kernel 7.0.14-26-pve (kernel CephFS mount)
- Ceph 20.2.4 (tentacle), 3 nodes, 27 OSDs
- The same code paths are unchanged in current mainline
=A0 (net/ceph/osd_client.c, net/ceph/osdmap.c).

What happened
-------------
1. A CephFS was created (data pool created with pg_num 128,
=A0=A0 pg_autoscale_mode on). All three nodes mounted it right away
=A0=A0 (osdmap e3222).
2. Nine minutes later the autoscaler had merged the data pool down
=A0=A0 to 32 PGs (pool lfor 0/3669/3667, last_change 3669).
3. The mounts then stayed idle for 18 days. The kernel client only
=A0=A0 requests osdmaps "onetime" (maybe_request_map()), so an idle
=A0=A0 client keeps the old map. One node still shows this today:

=A0=A0=A0=A0 /sys/kernel/debug/ceph/<fsid>.client<id>/osdmap:
=A0=A0=A0=A0=A0=A0 epoch 3222 barrier 3222 flags 0x588000
=A0=A0=A0=A0=A0=A0 pool 5 '<fs>_data' ... pg_num 128 ...
=A0=A0=A0=A0 while the cluster is at e4061 with pg_num 32.

4. The first read after that (QEMU reading an ISO file on the
=A0=A0 CephFS) was mapped with the stale map to a PG that no longer
=A0=A0 exists. After the client received the current map, the request
=A0=A0 was never re-targeted:

=A0=A0=A0=A0 osdc:
=A0=A0=A0=A0 REQUESTS 1 homeless 0
=A0=A0=A0=A0 4=A0 osd4=A0 5.aea7fea1=A0 5.21=A0 [4,14,23]/4=A0 [4,14,23]/4=
=A0 e4061
=A0=A0=A0=A0=A0=A0=A0 100000001fc.00000803=A0 0x40001c=A0 13=A0 read

=A0=A0=A0=A0 # ceph pg map 5.21
=A0=A0=A0=A0 Error ENOENT: pgid '5.21' does not exist
=A0=A0=A0=A0 # ceph pg map 5.1
=A0=A0=A0=A0 osdmap e4061 pg 5.1 (5.1) -> up [4,14,23] acting [4,14,23]

=A0=A0 The client's own map (debugfs) shows pg_num 32 for the pool, but
=A0=A0 the request still carries spgid 5.21. It has been resent 13 times
=A0=A0 to the same OSD. osd.4 reports no ops in flight
=A0=A0 (dump_ops_in_flight num_ops 0) and nothing for this object in
=A0=A0 historic ops. Reading the same object with librados (rados get)
=A0=A0 returns immediately.

=A0=A0 A second node shows the same pattern: 22 requests stuck for
=A0=A0 object 10000000004.000000b6, spgid 5.23 (does not exist),
=A0=A0 [15,19,23]/15, which is also the acting set of the merge target
=A0=A0 5.3.

=A0=A0 The QEMU io_uring workers were in D state in
=A0=A0 folio_wait_bit_common until the VM was killed.

Analysis (current mainline)
---------------------------
- scan_requests() calls calc_target(osdc, &req->r_t, false) for
=A0 regular requests. With any_change =3D=3D false:
=A0 - ceph_is_new_interval() is skipped. It is the only check that
=A0=A0=A0 would notice the pg_num change.
=A0 - ceph_osds_changed(..., false) only checks for a primary change.
- ceph_pg_is_split() returns false when new_pg_num <=3D old_pg_num.
- force_resend only fires when the current map epoch equals
=A0 pi->last_force_request_resend.
- Neither osd_client.c nor osdmap.c contains any merge handling.

So if the merge target PG has the same primary as the merged-away
source PG (which is what we observe in both cases), t->spgid is never
recomputed. The request is resent forever with an spgid the OSDs no
longer have, and the OSD drops it, expecting the client to
re-target. Userspace Objecter handles this via is_new_interval()
(pg_num change), which is why librbd/librados clients on the same
hosts were unaffected.

A possible fix would be to also recompute the target when
pi->pg_num < t->pg_num (merge), analogous to the split check, or to
evaluate ceph_is_new_interval() for regular requests as well.

Reproduction (not tested by us, derived from the above)
-------------------------------------------------------
1. Create a pool with pg_num 128 as CephFS data pool, mount it with
=A0=A0 the kernel client and write a few large files.
2. Leave the mount completely idle and reduce pg_num to 32. Wait
=A0=A0 until the merge is complete.
3. Read the files from the idle mount. Reads of objects in
=A0=A0 merged-away PGs should hang, with entries in osdc as above.
krbd mappings that stay idle during a merge are presumably affected
in the same way.

Workaround
----------
umount -f + remount of the CephFS (fresh client with the current
map), and pg_num_min on pools used by kernel clients to prevent
autoscaler merges.

Happy to provide more data from the affected nodes while they are
still in this state.

Thanks,

Mit freundlichen Gr=FC=DFen
Niclas M=FCller
