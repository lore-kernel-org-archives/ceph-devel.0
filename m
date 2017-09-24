From: Abhishek <abhishek@suse.com>
Subject: Re: Status of luminous v12.2.1 QE validation
Date: Sun, 24 Sep 2017 16:03:12 +0200
Message-ID: <4d92b984acbdf857f8179bd1509d31fd@suse.com>
References: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com>
 <CA+2bHPZf2akxs+WtTmzpSyA0=T8rZcKsHXqUnwPMb9Los0XQYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752206AbdIXODO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 24 Sep 2017 10:03:14 -0400
In-Reply-To: <CA+2bHPZf2akxs+WtTmzpSyA0=T8rZcKsHXqUnwPMb9Los0XQYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Yuri Weinstein <yweinste@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>, "Durgin, Josh" <jdurgin@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Zheng Yan <zyan@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ilya Dryomov <idryomov@redhat.com>

On 2017-09-19 23:11, Patrick Donnelly wrote:
> On Tue, Sep 19, 2017 at 1:10 PM, Yuri Weinstein <yweinste@redhat.com> 
> wrote:
>> kcephfs - needs analysis - Patrick, Zheng FYI
> 
> http://tracker.ceph.com/issues/21463
> http://tracker.ceph.com/issues/21462
> http://tracker.ceph.com/issues/21466
> http://tracker.ceph.com/issues/21467
> http://tracker.ceph.com/issues/21468
> 
> Last 3 look like blockers. Zheng will have more input.

Here are the results of a rerun with -k testing,
http://pulpito.ceph.com/abhi-2017-09-22_19:35:04-kcephfs-luminous-testing-basic-smithi/
& details http://tracker.ceph.com/issues/21296#note-20
There are a few failures which look environmental but a few look like 
they are related to the changeset (the ones with cache)

Best,
Abhishek
