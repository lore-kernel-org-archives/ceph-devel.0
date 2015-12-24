From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw: sticky user quota data on bucket removal
Date: Wed, 23 Dec 2015 17:02:00 -0800
Message-ID: <CADRKj5RiOVVNv+3f1WV+seHsswJzo++vxG9Km2vmFgd960=Viw@mail.gmail.com>
References: <622F4407872BA447A16110F65453358C04D1467F323A@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35151 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbLXBCB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Dec 2015 20:02:01 -0500
Received: by mail-ob0-f174.google.com with SMTP id 18so176916004obc.2
        for <ceph-devel@vger.kernel.org>; Wed, 23 Dec 2015 17:02:00 -0800 (PST)
In-Reply-To: <622F4407872BA447A16110F65453358C04D1467F323A@FMSAMAIL.fmsa.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 23, 2015 at 3:53 PM, Paul Von-Stamwitz
<PVonStamwitz@us.fujitsu.com> wrote:
> Hi,
>
> We're testing user quotas on Hammer with civetweb and we're running into an issue with user stats.
>
> If the user/admin removes a bucket using -force/-purge-objects options with s3cmd/radosgw-admin respectively, the user stats will continue to reflect the deleted objects for quota purposes, and there seems to be no way to reset them. It appears that user stats need to be sync'ed prior to bucket removal. Setting " rgw user quota bucket sync interval = 0" appears to solve the problem.
>
> What is the downside to setting the interval to 0?

We'll update the buckets that are getting modified continuously,
instead of once every interval.

>
> I think the right solution is to have an implied sync-stats during bucket removal. Other suggestions?
>

No, syncing the bucket stats on removal sounds right.

Yehuda

> All the best,
> Paul
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
