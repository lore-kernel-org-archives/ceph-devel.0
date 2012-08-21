From: Tommi Virtanen <tv@inktank.com>
Subject: Re: S3 comapatible with java-rados.
Date: Tue, 21 Aug 2012 09:00:15 -0700
Message-ID: <CADvuQRHwk2chtG5CZs_3JywY4P0KacZUYShjhPb5sFr+scwGyw@mail.gmail.com>
References: <loom.20120820T091919-196@post.gmane.org> <loom.20120821T072518-665@post.gmane.org>
 <loom.20120821T082125-510@post.gmane.org> <loom.20120821T110501-143@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42431 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab2HUQAg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 12:00:36 -0400
Received: by vcbfk26 with SMTP id fk26so6277232vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 09:00:36 -0700 (PDT)
In-Reply-To: <loom.20120821T110501-143@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Aug 21, 2012 at 2:06 AM, ramu <ramu.freesystems@gmail.com> wrote:
>     And also create bucket using this command"s3 -u create test"
> But it is showing error,
...
> root@vu-AP480-S:/home/vu# s3 -u create alpha
> s3: command not found

So you don't have the s3 command installed, then. See
https://github.com/wido/libs3

Please don't share your secret keys on public mailing lists.
