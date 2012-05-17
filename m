From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: global_init_daemonize: BUG: there are 1 child threads already
 started that will now die!
Date: Thu, 17 May 2012 08:28:26 -0700
Message-ID: <4FB5191A.9080102@inktank.com>
References: <12500703.xTHoDB74aK@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51771 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966647Ab2EQP23 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 11:28:29 -0400
Received: by dady13 with SMTP id y13so2556411dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 08:28:29 -0700 (PDT)
In-Reply-To: <12500703.xTHoDB74aK@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

On 05/17/2012 04:53 AM, Sz=E9kelyi Szabolcs wrote:
> Hello,
>
> I get the $subject message when starting Ceph with the init script. I=
 have to
> try it 15-20 times until the start suceeds. I've seen this message em=
itted by
> the monitor and MDS daemons, but never by OSDs. Is this really a bug =
as the
> message says? I have two theoretically identical clusters, and only o=
ne of
> them produces this error, so something might be wrong on my side, but=
 what?
>
> Thanks,

This was a kludgy check that was accidentally getting triggered after=20
some logging code changes. It was removed by:

commit 2629474f521f5cf67ccb8d09c289e1424c9e07ec
Author: Sage Weil <sage.weil@dreamhost.com>
Date:   Thu May 3 18:50:42 2012 -0700

global_init: do not count threads before daemonize()

We were verifying that there was only 1 thread (the presumably main()) =
when
we call daemonize.  However, with the new logging code, we stop a threa=
d
right before the check, and /proc apparently updates asynchronously suc=
h
that our attempt to count running threads gives us a bad answer.

Just remove this kludgey check; we'll have to catch this class of bugs
the hard way.

Signed-off-by: Sage Weil <sage.weil@dreamhost.com>
Reviewed-by: Greg Farnum <greg@inktank.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
