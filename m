From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Mon, 20 Feb 2017 15:57:45 +0100
Message-ID: <539012eb-30d5-e490-2a64-d0ad485d7878@suse.cz>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
 <CAC7t81bh9xOh77e73zXpHWhvWhPiMagTiER6LqpqqGfHiMqZrg@mail.gmail.com>
 <c8317af2-a8a2-2f22-7083-46f24057f10a@dachary.org>
 <CAF-wwdEb_afYCQgjH5XpBbvk3J+dzg+CJ-agK6KsFajzu2gA1w@mail.gmail.com>
 <CABZ+qqm5z=dxpvFZchuFGWVfWgnq3CVCCY9srckFg8P7BKhumA@mail.gmail.com>
 <469562479.10114.1487242836607@ox.pcextreme.nl>
 <20170217201313.GA49190@Vaibhavs-MacBook-Air.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59995 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753249AbdBTPdu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 20 Feb 2017 10:33:50 -0500
In-Reply-To: <20170217201313.GA49190@Vaibhavs-MacBook-Air.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Durgin, Josh" <jdurgin@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, John Spray <jspray@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yweinste@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel@vger.kernel.org, Sage Weil <sweil@redhat.com>

Hi Jason, John, Josh, Yehuda:

The following PRs and issues have been requested as "last-minute" items 
for 10.2.6 - see their current status below. Should any of these be 
considered blockers for 10.2.6? That said, if you're ready to give a 
green light for 10.2.6 now, please don't hesitate to do so.

RGW
- http://tracker.ceph.com/issues/18258 (no backport PR yet)
- http://tracker.ceph.com/issues/18331 
(https://github.com/ceph/ceph/pull/13358 - merged, will be in 10.2.6)
- http://tracker.ceph.com/issues/18563 
(https://github.com/ceph/ceph/pull/13004 - waiting for Yehuda's approval)
- http://tracker.ceph.com/issues/17756 - bucket resharding feature 
(https://github.com/ceph/ceph/pull/13341 - waiting for Yehuda's approval)

CORE/COMMON
- http://tracker.ceph.com/issues/14115 (no backport PR yet, master PR 
still open)
- http://tracker.ceph.com/issues/18582 
(https://github.com/ceph/ceph/pull/13131 - backport PR pending; affects 
upgrade, so will be included in 10.2.6)
- http://tracker.ceph.com/issues/18791 
(https://github.com/ceph/ceph/pull/13214 - in testing)
- http://tracker.ceph.com/issues/18794 
(https://github.com/ceph/ceph/pull/13232 - conflict)
- http://tracker.ceph.com/issues/18812 
(https://github.com/ceph/ceph/pull/13270 - conflict)
- http://tracker.ceph.com/issues/17334 
(https://github.com/ceph/ceph/pull/11410 - merged, will be in 10.2.6)
- http://tracker.ceph.com/issues/17821 
(https://github.com/ceph/ceph/pull/13496 - in testing)

CEPHFS
- http://tracker.ceph.com/issues/18708 
(https://github.com/ceph/ceph/pull/13459 - in testing)
