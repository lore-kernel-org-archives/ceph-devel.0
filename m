From: Casey Bodley <cbodley@redhat.com>
Subject: Re: OpenStack Swift functional tests on RGW
Date: Tue, 28 Mar 2017 10:48:44 -0400
Message-ID: <0a2aa303-6e29-4fad-3379-9fdfef2f5c55@redhat.com>
References: <9b700b96-668b-5086-ce2f-b75aa0b400d5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34729 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdC1OtG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Mar 2017 10:49:06 -0400
Received: by mail-qt0-f173.google.com with SMTP id n21so65958158qta.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Mar 2017 07:49:05 -0700 (PDT)
In-Reply-To: <9b700b96-668b-5086-ce2f-b75aa0b400d5@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rajath Shashidhara <rajath.shashidhara@gmail.com>, ceph-devel@vger.kernel.org


On 03/28/2017 09:51 AM, Rajath Shashidhara wrote:
> Hi,
>
> I am getting started with contributing to Ceph. I sent my first pull
> request a couple of weeks ago - https://github.com/ceph/ceph/pull/13908
> . In testing the feature, I realized that the ceph/swift repository is
> outdated. I tweaked some relevant functional tests on the
> openstack/swift repository to run on RadosGW.
>
> I was thinking that may be I can port all the functional tests from
> openstack/swift to work on RGW. This way we can test how well RGW
> complies with the Swift REST API. I'd like to know if that would be a
> useful contribution to ceph. Also, since ceph/stack has diverged from
> openstack/swift (20 commits ahead and 4919 commits behind upstream -
> openstack/swift as of today), what approach should I take to push these
> tests ?
>
> Thanks,
>
> Rajath Shashidhara
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Hi Rajath,

Thanks for looking into this - I think it would be extremely valuable to 
bring our swift tests up to date. Looking at our fork, it appears that 
most of our changes fall into two categories: updating 
dependencies/bootstrapping, and adding 'fails_on_rgw' tags to tests that 
we know won't pass.

I'm hoping that the latest openstack/swift repo has the correct 
dependencies, so we may not need to carry all of those patches forward.

Rebasing the commits that add our tags sounds tedious, but should be 
pretty straightforward. For new upstream tests that don't pass against 
rgw, maybe add a separate tag like 'new_fails_on_rgw' so that we can go 
through and evaluate each of those once you finish.

Thanks,
Casey
