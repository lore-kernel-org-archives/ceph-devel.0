From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: "Unix Domain socket path too long" failures in Jenkins make check
Date: Sat, 1 Jul 2017 15:17:31 +0200
Message-ID: <5079a3cd-8b60-949f-a413-e159902aa275@digiware.nl>
References: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25785 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbdGANRc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 1 Jul 2017 09:17:32 -0400
In-Reply-To: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

HI nathan,

I know Loic has done work to shorten the path on all of the tests by 
renaming /testdir/ to /td/ and perhaps even some more because of this.
Things like:
./src/test/vstart_wrapper.sh:22:export 
CEPH_DIR="${TMPDIR:-$PWD}/td/t-$CEPH_PORT"

But I do not know if this was sufficient, and if this is the only place.
But it is a good start to find the comit that did the fix.

--WjW


Op 30-6-2017 om 23:08 schreef Nathan Cutler:
> Hi Ceph!
>
> Now that 10.2.8 is finally in QE, I had planned to turn my attention 
> to kraken 11.2.1. The first task is to get the backport PRs through 
> "make check". This is proving more difficult than usual because most 
> of the time the make check test fails due to the "Unix Domain socket 
> path too long" error. This happens in jewel PRs, too, but the 
> incidence in kraken PRs seems much higher.
>
> Does the CI team have statistics on how many make check jobs are 
> failing due to this bug?
>
> Also, is my understanding correct that there is no way to get Jenkins 
> to shorten the path?
>
> Thanks,
> Nathan
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

