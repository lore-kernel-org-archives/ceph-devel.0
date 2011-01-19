From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: cephfs set_layout on filesystem root?
Date: Wed, 19 Jan 2011 09:00:56 -0800
Message-ID: <AANLkTi=LNa0AyiT4UfyrJLQrUCrPDACBocsiQV=yw7GQ@mail.gmail.com>
References: <1295455606.6777.23.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61394 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab1ASRA6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 12:00:58 -0500
Received: by eye27 with SMTP id 27so553411eye.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 09:00:57 -0800 (PST)
In-Reply-To: <1295455606.6777.23.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 19, 2011 at 8:46 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi,
>
> I've been experimenting with using cephfs to set
> the object/stripe size on a Ceph filesystem root,
> and it seems to not persist across a filesystem
> restart. =A0Is that expected behavior?
> ...
> Am I missing something?
Hmmm, not that I see. It should definitely be a persistent setting.

<debug_mode>
Have you tried this on non-root directories, and were results the same
or different?
</debug_mode>
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
