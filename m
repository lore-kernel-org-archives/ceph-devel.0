From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Client hanging on mkdirs with logs
Date: Fri, 26 Oct 2012 13:54:37 -0700
Message-ID: <CAPrxi5-EfYBNkmdNH3+5fiDqjpgpBkhczrcEDUksgpPTi8Xzvw@mail.gmail.com>
References: <CAPrxi58_00WVutZV-zO5sa3Rx+QahVO90oVeUEc+neOmvxcf3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44249 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185Ab2JZUyi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 16:54:38 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3570075vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 13:54:37 -0700 (PDT)
In-Reply-To: <CAPrxi58_00WVutZV-zO5sa3Rx+QahVO90oVeUEc+neOmvxcf3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

A missing unmount fixed the problem! Phew!

Thanks

On Fri, Oct 26, 2012 at 10:14 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Sage,
>
> In the client log below on line 852 we start a mkdirs call, and it
> doesn't finish for 60 seconds.
>
> Here are logs:
>
>   https://dl.dropbox.com/u/7899675/client.log
>   https://dl.dropbox.com/u/7899675/mds.a.log
>   https://dl.dropbox.com/u/7899675/mon.a.log
>   https://dl.dropbox.com/u/7899675/osd.0.log
>
> - Noah
