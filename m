From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: keyvaluestore speed up?
Date: Thu, 19 Mar 2015 21:23:13 +0800
Message-ID: <CACJqLyZ9L4cmyhjZdNOpmAdjaVhd6tmh9dgyPw3MwaQXyizGig@mail.gmail.com>
References: <CANE=7sUygGz67i-H+5v+ZmuwR4W9RuGzsWX6yhvJ=O9LKsyCSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34701 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbCSNXO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 09:23:14 -0400
Received: by pacwe9 with SMTP id we9so75738762pac.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 06:23:14 -0700 (PDT)
In-Reply-To: <CANE=7sUygGz67i-H+5v+ZmuwR4W9RuGzsWX6yhvJ=O9LKsyCSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinze Chi <xmdxcxz@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 19, 2015 at 5:22 PM, Xinze Chi <xmdxcxz@gmail.com> wrote:
> hi, all:
>
>     Currently at keyvaluestore, osd send sync
> request(submit_transaction_sync) to filestore when it finishes a
> transaction. But sata disk is not suitable for doing sync request. ssd
> disk is more suitable.

I think here you mean disk not filestore.

>
>     So I think whether we could separate leveldb *.log file with *.sst
> file and move *.log to ssd
> disk, which is similar with journal file in ceph.
>
>     But now, the original leveldb do not support to separate log file
> and sst file.
>
>     Wait for your comment.
>
>     Thanks.



-- 
Best Regards,

Wheat
