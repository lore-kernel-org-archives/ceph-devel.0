From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Seg Fault on rgw 0.61.1 with cluster in 0.61
Date: Fri, 10 May 2013 09:02:05 -0700
Message-ID: <CABBk=J_QaRUFmq_gPHeywkkRSJaaAzMz0eM8jZ15+FQKuQo5Bw@mail.gmail.com>
References: <367CC0B0FC02EE47BF7482398BD623C55E230EFF@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:63402 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab3EJQCH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 May 2013 12:02:07 -0400
Received: by mail-ve0-f176.google.com with SMTP id db10so2369654veb.7
        for <ceph-devel@vger.kernel.org>; Fri, 10 May 2013 09:02:05 -0700 (PDT)
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C55E230EFF@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann ROBIN <yann.robin@youscribe.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 10, 2013 at 1:51 AM, Yann ROBIN <yann.robin@youscribe.com> wrote:
> Hi,
>
> I've tried to update the rgw to 0.61.1 and now I have a segfault while connecting to the 0.61 cluster.
> The rgw with version 0.61 run fine.
>
> *** Caught signal (Segmentation fault) **
>  in thread 7fc1fec79780
>  ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>  1: /usr/bin/radosgw() [0x4f19da]
>  2: (()+0xfcb0) [0x7fc1fcf0dcb0]
>  3: (ceph::crypto::init(CephContext*)+0xf) [0x7fc1fdfeb2ef]
>  4: (common_init_finish(CephContext*)+0x23) [0x7fc1fdfc33f3]
>  5: (librados::RadosClient::connect()+0x1d) [0x7fc1fde1d48d]
>  6: (RGWRados::initialize()+0x53) [0x5b5c03]
>  7: (RGWStoreManager::init_storage_provider(CephContext*, bool)+0x2c9) [0x5b9b39]
>  8: (main()+0x2d7) [0x4b4ed7]
>  9: (__libc_start_main()+0xed) [0x7fc1fb90176d]
>  10: /usr/bin/radosgw() [0x4b6db1]
> 2013-05-10 10:36:39.749439 7fc1fec79780 -1 *** Caught signal (Segmentation fault) **
>  in thread 7fc1fec79780
>

Sounds to me like package versioning mismastch. Could it be that one
of the ceph packages was on a different version (e.g., librados).

Yehuda
