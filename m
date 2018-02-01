From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Drop upgrade/jewel-x/point-to-point-x in luminous and master
Date: Thu, 1 Feb 2018 07:43:12 -0800
Message-ID: <CAMMFjmE-S6fHQdTcgvgQgTR3+K-249HZ=haehjy8Pxi-9kc_CA@mail.gmail.com>
References: <910ece94-b940-23ed-e2ba-a1204796dfa9@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:46501 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeBAPnO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Feb 2018 10:43:14 -0500
Received: by mail-pg0-f48.google.com with SMTP id s9so12556453pgq.13
        for <ceph-devel@vger.kernel.org>; Thu, 01 Feb 2018 07:43:14 -0800 (PST)
In-Reply-To: <910ece94-b940-23ed-e2ba-a1204796dfa9@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

IIRC it was to test minor to minor point releases upgrades.

On Thu, Feb 1, 2018 at 3:39 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi ceph devs and testers:
>
> AIUI the purpose of the point-to-point-x upgrade subsuites is to test
> upgrades from one point release to another. That would seem to imply that
> these tests would be expected to produce meaningful results only when
> testing upgrades within a major release. Correct?
>
> If so, then we could drop the entire upgrade/jewel-x/point-to-point-x
> subsuite in the luminous and master branches?
>
> Thanks,
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
