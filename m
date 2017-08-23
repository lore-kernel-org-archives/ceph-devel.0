From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: Are we ready for Luminous?
Date: Wed, 23 Aug 2017 16:00:56 +0200
Message-ID: <87pobmqt7r.fsf@suse.com>
References: <87shgir0cl.fsf@suse.com> <CAJE9aOMhuzp-VNX4t7DByqUz78HOLvxgR-p8waX_EdRsgtqBKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:59056 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754001AbdHWOA7 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 23 Aug 2017 10:00:59 -0400
In-Reply-To: <CAJE9aOMhuzp-VNX4t7DByqUz78HOLvxgR-p8waX_EdRsgtqBKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Matt Benjamin <mbenjami@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Jason Dillaman <jdillama@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

kefu chai <tchaikov@gmail.com> writes:

> On Wed, Aug 23, 2017 at 7:26 PM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>>
>> Other than the existing PRs in https://github.com/ceph/ceph/milestone/10,
>> do we have anything else that really needs to go in for Luminous? Any
>> other blockers?
>
> and all tracker tickets whose "backport" has "luminous", and pending
> on packport [0]. and all needs-backport PRs which are not yet
> backported [1].
>
> ---
> [0] http://tracker.ceph.com/projects/rados/issues?utf8=✓&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%21&v%5Bstatus_id%5D%5B%5D=3&f%5B%5D=cf_2&op%5Bcf_2%5D=%7E&v%5Bcf_2%5D%5B%5D=luminous&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=

Staged a backport for the ones which are already in the Pending Backport
stage (The ones in pending review state are still awaiting comments etc
in a few)
> [1] https://github.com/ceph/ceph/pulls?utf8=✓&q=is%3Apr%20label%3Aneeds-backport%20.
> quite a few of PRs in this list have been backported.

Just started creating issues for these so that they are easier to track

-- 
Abhishek
