From: Ning Yao <zay11022@gmail.com>
Subject: Re: keyvaluestore speed up?
Date: Tue, 24 Mar 2015 14:53:10 +0800
Message-ID: <CALZt5jz=Sc1x3a4B5-aA6PdTeb7jtgTm6hJ=xR0H1jY7Tj1R4A@mail.gmail.com>
References: <CANE=7sUygGz67i-H+5v+ZmuwR4W9RuGzsWX6yhvJ=O9LKsyCSA@mail.gmail.com>
	<75674D092A819E4189E91166C74CB90D0150C211@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34409 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbCXGxM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 02:53:12 -0400
Received: by wibg7 with SMTP id g7so47404978wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2015 23:53:11 -0700 (PDT)
In-Reply-To: <75674D092A819E4189E91166C74CB90D0150C211@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: Xinze Chi <xmdxcxz@gmail.com>, Sage Weil <sweil@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>, Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2015-03-20 10:22 GMT+08:00 Shu, Xinxin <xinxin.shu@intel.com>:
> I think rocksdb can support this configuration.
>
I do not find this option in rocksdb. If you know, can you provide
this option to redirect the WAL file?

Regards
Ning Yao


> Cheers,
> xinxin
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Xinze Chi
> Sent: Thursday, March 19, 2015 5:23 PM
> To: Sage Weil; sjust@redhat.com; Haomai Wang; ceph-devel@vger.kernel.org
> Subject: keyvaluestore speed up?
>
> hi, all:
>
>     Currently at keyvaluestore, osd send sync
> request(submit_transaction_sync) to filestore when it finishes a transaction. But sata disk is not suitable for doing sync request. ssd disk is more suitable.
>
>     So I think whether we could separate leveldb *.log file with *.sst file and move *.log to ssd disk, which is similar with journal file in ceph.
>
>     But now, the original leveldb do not support to separate log file and sst file.
>
>     Wait for your comment.
>
>     Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
