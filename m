From: John Axel Eriksson <john@insane.se>
Subject: Re: Deleting files from radosgw-bucket doesn't free up space in ceph?
Date: Tue, 9 Oct 2012 21:00:20 +0200
Message-ID: <CAMmJxtJVmYjX0cVOXZcORmigTj70VAHJosVZNp3MnodsfR9hTA@mail.gmail.com>
References: <CAMmJxtK7iyONQ1EaKgSkRkTyf0Ou1Ja0HXCGFTa2146maC5d6g@mail.gmail.com>
	<CAC-hyiEP4q_iP_2A+o7G88+pYAhRBNRhaD0Ob_m_e1j1sF1AvA@mail.gmail.com>
	<CAMmJxt+2mtVhmxdS2UsXyosiMMH4UuDFQkJwqCzVJm7CF-pyqQ@mail.gmail.com>
	<CAC-hyiECcp+MLZh=r5fitnNtEy7zZ=8FMTtiMAq3kaeTROxhwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45565 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595Ab2JITAV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 15:00:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5540411pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 12:00:21 -0700 (PDT)
In-Reply-To: <CAC-hyiECcp+MLZh=r5fitnNtEy7zZ=8FMTtiMAq3kaeTROxhwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks, seems to have done the trick. I simply didn't realize it was
necessary and since we've done quite a bit of deleting these past
two days I naturally looked at the numbers and they didn't add up.

On Tue, Oct 9, 2012 at 7:17 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Tue, Oct 9, 2012 at 10:07 AM, John Axel Eriksson <john@insane.se> wrote:
>> I'm running 0.48.1. Wow I had no idea that was the case. I guess
>> everything that's been deleted up until today can be removed
>> using "radosgw-admin temp remove --date=2012-10-09"... am I correct in
>> assuming this only removes "garbage" (e.g. deleted objects)
>> and not anything else (such as the stored data in a bucket)?
>>
> It completes the final stage in removing objects (mostly for objects
> with more than 512k in data), either when they were deleted explicitly
> or overwritten. If you don't have any pending readers on large objects
> that were removed then you can put today's date.
>
> Yehuda
