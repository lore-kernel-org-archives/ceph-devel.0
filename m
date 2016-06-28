From: John Spray <jspray@redhat.com>
Subject: Re: About thread_local and TmapMigratePP.DataScan case
Date: Tue, 28 Jun 2016 10:45:19 +0100
Message-ID: <CALe9h7eHLJc-3HSt1yUxZQxgUzJXq_w2Oi=FyhmUYqetxRMqiA@mail.gmail.com>
References: <CACJqLybSUa6WtfcvXa5W4AAXJUgEBDPX2Mo+nd3SDeLkHVgDwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35752 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbcF1Jpj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 05:45:39 -0400
Received: by mail-qk0-f174.google.com with SMTP id a125so18803605qkc.2
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 02:45:39 -0700 (PDT)
In-Reply-To: <CACJqLybSUa6WtfcvXa5W4AAXJUgEBDPX2Mo+nd3SDeLkHVgDwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 27, 2016 at 7:04 PM, Haomai Wang <haomai@xsky.com> wrote:
> Hi all,
>
> anyone who knows what's the special thing with TmapMigratePP.DataScan
> case. When I introduce thread_local variable in
> PR(https://github.com/ceph/ceph/pull/9783/files#diff-254a8401d238ec25c714a5596f85b5ebL64),
> it always failed because the thread local variable is assigned to zero
> when execute this test!

I don't know off the top of my head, but that particular piece of
functionality (tmap migrate in DataScan) is intended to be removed for
Kraken, so if your code won't need backporting to Jewel then we can
just remove the test.

John

(This is the code that we put in Jewel to enable people to migrate
their TMAP directory fragments to OMAP fully before we remove TMAP
support in Kraken)

> For example, when tid == 512596224 local_center should be 5fed4e48,
> but after begin this test case, this thread_local variable is assigned
> to zero!:
> tid=-512596224 local_center=5fed4e48 this=5fed4e48
> [New Thread 0x7fffdef21700 (LWP 11835)]
> tid=-512596224 local_center=5fed4e48 this=5fed4e48
> [New Thread 0x7fffde720700 (LWP 11836)]
> [New Thread 0x7fffddf1f700 (LWP 11837)]
> [New Thread 0x7fffdd71e700 (LWP 11838)]
> [New Thread 0x7fffdcf1d700 (LWP 11839)]
> [New Thread 0x7fffdc71c700 (LWP 11840)]
> [New Thread 0x7fffdbf1b700 (LWP 11841)]
> tid=-134366272 local_center=0 this=5fed4e48
> tid=-134366272 local_center=0 this=5fed4e48
> tid=-134366272 local_center=0 this=5fed4e48
> tid=-512596224 local_center=0 this=5fed4e48
>
>
> QA job:http://qa-proxy.ceph.com/teuthology/haomai-2016-06-27_03:55:04-rados-wip-haomai-testing---basic-smithi/279412/teuthology.log
>
> This can be repeated locally and I want to know what's the difference
> this case introduced
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
