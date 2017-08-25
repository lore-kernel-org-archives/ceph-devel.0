From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: docs build check - necessary for Jewel?
Date: Fri, 25 Aug 2017 04:38:06 +0200
Message-ID: <89631ff5-f6ed-e5f8-591e-7f3d1eea6e5c@suse.cz>
References: <8fb1422b-b2b0-88d2-f6ff-849219d1ec46@suse.cz>
 <CAC-Np1yKuyBjuNXuLaUANnOJw=svvx1R5pvT5q8hyGi1OpBoiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754447AbdHYCiI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 24 Aug 2017 22:38:08 -0400
In-Reply-To: <CAC-Np1yKuyBjuNXuLaUANnOJw=svvx1R5pvT5q8hyGi1OpBoiQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Anything before the recent changes to master (and now Luminous)
> shouldn't create false positives, and can still
> allow errors and warnings like before.

Infrastructure issues can still cause the tests to fail.

If you can't currently disable them by target or by milestone, take that 
as a feature request?

Thanks,
Nathan
