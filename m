From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Status of luminous v12.2.1 QE validation
Date: Tue, 19 Sep 2017 22:19:59 +0200
Message-ID: <fdf4aac4-d207-9a1f-bf3b-0e1579277759@suse.cz>
References: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751408AbdISUUB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 19 Sep 2017 16:20:01 -0400
In-Reply-To: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>, "Durgin, Josh" <jdurgin@redhat.com>, Zheng Yan <zyan@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ilya Dryomov <idryomov@redhat.com>

Hi Yuri:

> RHEL 7.4 related PRs need to backported:
> https://github.com/ceph/ceph/pull/17776

Luminous backport PR is open: https://github.com/ceph/ceph/pull/17779

> https://github.com/ceph/ceph/pull/17796

The PR you mentioned (17796) is the luminous backport PR for 
https://github.com/ceph/ceph/pull/17795 (the latter will presumably be 
merged into master in short order).

> https://github.com/ceph/ceph/pull/17777

Luminous backport PR is open: https://github.com/ceph/ceph/pull/17816

Hope this helps.

Nathan
