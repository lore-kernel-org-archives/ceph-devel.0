From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Deleting files from radosgw-bucket doesn't free up space in ceph?
Date: Tue, 9 Oct 2012 10:17:05 -0700
Message-ID: <CAC-hyiECcp+MLZh=r5fitnNtEy7zZ=8FMTtiMAq3kaeTROxhwg@mail.gmail.com>
References: <CAMmJxtK7iyONQ1EaKgSkRkTyf0Ou1Ja0HXCGFTa2146maC5d6g@mail.gmail.com>
	<CAC-hyiEP4q_iP_2A+o7G88+pYAhRBNRhaD0Ob_m_e1j1sF1AvA@mail.gmail.com>
	<CAMmJxt+2mtVhmxdS2UsXyosiMMH4UuDFQkJwqCzVJm7CF-pyqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56156 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab2JIRRH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 13:17:07 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2798052bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 10:17:05 -0700 (PDT)
In-Reply-To: <CAMmJxt+2mtVhmxdS2UsXyosiMMH4UuDFQkJwqCzVJm7CF-pyqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>, ceph-devel@vger.kernel.org

On Tue, Oct 9, 2012 at 10:07 AM, John Axel Eriksson <john@insane.se> wrote:
> I'm running 0.48.1. Wow I had no idea that was the case. I guess
> everything that's been deleted up until today can be removed
> using "radosgw-admin temp remove --date=2012-10-09"... am I correct in
> assuming this only removes "garbage" (e.g. deleted objects)
> and not anything else (such as the stored data in a bucket)?
>
It completes the final stage in removing objects (mostly for objects
with more than 512k in data), either when they were deleted explicitly
or overwritten. If you don't have any pending readers on large objects
that were removed then you can put today's date.

Yehuda
