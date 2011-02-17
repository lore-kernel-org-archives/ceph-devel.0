From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] rgw: Lighttpd compatibity.
Date: Thu, 17 Feb 2011 11:13:29 -0800
Message-ID: <AANLkTi=RR4soH3Be1fz+sYC=iTK=CRSG2KvZCaQBUs6c@mail.gmail.com>
References: <AANLkTikEd8UUyy3ncf2DiDqR1Aa0UNDy3AVVGnVSyCxK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58650 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab1BQTNa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 14:13:30 -0500
Received: by wwa36 with SMTP id 36so2912731wwa.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Feb 2011 11:13:29 -0800 (PST)
In-Reply-To: <AANLkTikEd8UUyy3ncf2DiDqR1Aa0UNDy3AVVGnVSyCxK@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cclien <cclien@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 17, 2011 at 3:20 AM, cclien <cclien@gmail.com> wrote:
> Hi all
>
> I just tried to deploy a rados gateway with Lighttpd.
> But it have some trouble parsing object names.
>
> Here's what I found in debug log on the non-working copy:
> =A0 =A0RADOS S3 Gateway: SCRIPT_NAME=3D/mybucket
> =A0 =A0RADOS S3 Gateway: REQUEST_URI=3D/mybucket/ceph.tgz

That doesn't look right. May be some lighttpd configuration tweaking is=
sue?

>
> I think it will be better to retrive user's request from REQUEST_URI.
>

The problem with REQUEST_URI is that it'll consist the entire line,
including any parameters added. So using it requires some extra work
to check for that (pretty trivial, but you should also take care of
that).

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
