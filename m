From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Jenkins is having iassues???
Date: Thu, 28 Apr 2016 10:32:39 -0400
Message-ID: <CAC-Np1y1fO5Gg1vnSZF53XW3+YKs53Z1NC=y=jBUA3Gd08Vw_Q@mail.gmail.com>
References: <df4addf5-7731-073a-1107-ae756cf06e24@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38100 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcD1Ocl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2016 10:32:41 -0400
Received: by mail-wm0-f50.google.com with SMTP id g17so44824446wme.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 07:32:40 -0700 (PDT)
In-Reply-To: <df4addf5-7731-073a-1107-ae756cf06e24@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Apr 27, 2016 at 8:38 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi
>
> Not sure why this change:
> https://github.com/ceph/ceph/pull/8763
>
> Would fail so badly...
> https://jenkins.ceph.com/job/ceph-pull-requests/4781/console
>
> Perhaps Jenkins was pulled from underneath it?

This doesn't look like it is Jenkins fault. It does have a bunch of
PASSing tests.

Maybe someone else can chime in.
>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
