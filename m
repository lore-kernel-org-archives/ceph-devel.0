From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Mon, 27 Aug 2012 09:49:10 -0700
Message-ID: <CAC-hyiHm+-aU9pfXE_eb2Gpji2vC3U15YfBwyLMF4XsZRMWkBQ@mail.gmail.com>
References: <loom.20120827T091156-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59895 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2H0QtL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 12:49:11 -0400
Received: by bkwj10 with SMTP id j10so1323409bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 09:49:10 -0700 (PDT)
In-Reply-To: <loom.20120827T091156-421@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 27, 2012 at 12:17 AM, ramu <ramu.freesystems@gmail.com> wrote:
>
> Hi all,
>
>   I configured radosgw and installed s3.And also created user using this
> command,"sudo radosgw-admin user create --uid=ramu --display-name=sree --
> email=ram@test.com",it was created user fine,after when am creating s3
> bucket
> using"s3 create -u alpha" it is showing error,
>
> ERROR: ConnectionFailed
>

Have you configured apache correctly, and is it running?

Yehuda
