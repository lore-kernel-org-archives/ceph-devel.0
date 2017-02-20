From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Mon, 20 Feb 2017 10:20:28 -0800
Message-ID: <4d8aa9d8-2b59-6cf1-86b2-2f0793121efb@redhat.com>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
 <CAC7t81bh9xOh77e73zXpHWhvWhPiMagTiER6LqpqqGfHiMqZrg@mail.gmail.com>
 <c8317af2-a8a2-2f22-7083-46f24057f10a@dachary.org>
 <CAF-wwdEb_afYCQgjH5XpBbvk3J+dzg+CJ-agK6KsFajzu2gA1w@mail.gmail.com>
 <CABZ+qqm5z=dxpvFZchuFGWVfWgnq3CVCCY9srckFg8P7BKhumA@mail.gmail.com>
 <469562479.10114.1487242836607@ox.pcextreme.nl>
 <20170217201313.GA49190@Vaibhavs-MacBook-Air.local>
 <539012eb-30d5-e490-2a64-d0ad485d7878@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbdBTSUc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 20 Feb 2017 13:20:32 -0500
In-Reply-To: <539012eb-30d5-e490-2a64-d0ad485d7878@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, John Spray <jspray@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yweinste@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel@vger.kernel.org, Sage Weil <sweil@redhat.com>

On 02/20/2017 06:57 AM, Nathan Cutler wrote:
> Hi Jason, John, Josh, Yehuda:
>
> The following PRs and issues have been requested as "last-minute" items
> for 10.2.6 - see their current status below. Should any of these be
> considered blockers for 10.2.6? That said, if you're ready to give a
> green light for 10.2.6 now, please don't hesitate to do so.
>
> CORE/COMMON
> - http://tracker.ceph.com/issues/14115 (no backport PR yet, master PR
> still open)

This is just diagnostics still - the underlying issue isn't fixed by
that PR.

> - http://tracker.ceph.com/issues/18582
> (https://github.com/ceph/ceph/pull/13131 - backport PR pending; affects
> upgrade, so will be included in 10.2.6)

Sounds good.

> - http://tracker.ceph.com/issues/18791
> (https://github.com/ceph/ceph/pull/13214 - in testing)
> - http://tracker.ceph.com/issues/18794
> (https://github.com/ceph/ceph/pull/13232 - conflict)
> - http://tracker.ceph.com/issues/18812
> (https://github.com/ceph/ceph/pull/13270 - conflict)

This one is a blocker - it's a severe upgrade issue for hammer clients
under some circumstances.

> - http://tracker.ceph.com/issues/17334
> (https://github.com/ceph/ceph/pull/11410 - merged, will be in 10.2.6)
> - http://tracker.ceph.com/issues/17821
> (https://github.com/ceph/ceph/pull/13496 - in testing)

I think the rest are less critical and can wait for 10.2.7.

Thanks!
Josh
