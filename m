From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: QE validation hammer v0.94.7 finished (needs approval)
Date: Fri, 6 May 2016 13:05:51 -0400
Message-ID: <CA+aFP1CnRdowDJfBUMrVGknTy2MwEOsSnB6OaV6cUOP8Wcpm_g@mail.gmail.com>
References: <CAMMFjmFE6NTPA-DkTRubYPeyy+Qk0gHU_da3g97+zK9=Xm+DJA@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35686 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbcEFRFx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 13:05:53 -0400
Received: by mail-pa0-f45.google.com with SMTP id iv1so49269626pac.2
        for <ceph-devel@vger.kernel.org>; Fri, 06 May 2016 10:05:52 -0700 (PDT)
In-Reply-To: <CAMMFjmFE6NTPA-DkTRubYPeyy+Qk0gHU_da3g97+zK9=Xm+DJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Gregory Farnum <gfarnum@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Gregory Meno <gmeno@redhat.com>

On Fri, May 6, 2016 at 12:26 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> krbd:
> see failed runs, Jason/Josh pls review and approve or suggest next steps.

This should not block the release.

xfs test cases 020, 206, and 229 also failed in v0.94.6
(http://tracker.ceph.com/issues/14717).  The new failure is xfs/050
which appears to be a quota test case.   Specifically it fails trying
to use project quotas, so this is a v4.6 kernel/xfs issue not a krbd
issue (last release was tested against kernel v4.5).

-- 
Jason
