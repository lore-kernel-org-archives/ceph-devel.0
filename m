From: Samuel Just <sam.just@inktank.com>
Subject: Re: OpTracker optimization
Date: Wed, 10 Sep 2014 11:16:51 -0700
Message-ID: <CA+4uBUbSrYhy8=ZPKZ7dOTh0sNNCs5mC3ttgBH+qoWO+58UdvA@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783A845@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:32940 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaIJSQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 14:16:52 -0400
Received: by mail-qa0-f43.google.com with SMTP id cm18so18057215qab.30
        for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 11:16:52 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783A845@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Added a comment about the approach.
-Sam

On Tue, Sep 9, 2014 at 1:33 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi Sam/Sage,
>
> As we discussed earlier, enabling the present OpTracker code degrading
> performance severely. For example, in my setup a single OSD node with 10
> clients is reaching ~103K read iops with io served from memory while
> optracking is disabled but enabling optracker it is reduced to ~39K iops.
> Probably, running OSD without enabling OpTracker is not an option for many
> of Ceph users.
>
> Now, by sharding the Optracker:: ops_in_flight_lock (thus xlist
> ops_in_flight) and removing some other bottlenecks I am able to match the
> performance of OpTracking enabled OSD with OpTracking disabled, but with the
> expense of ~1 extra cpu core.
>
> In this process I have also fixed the following tracker.
>
>
>
> http://tracker.ceph.com/issues/9384
>
>
>
> and probably http://tracker.ceph.com/issues/8885 too.
>
>
>
> I have created following pull request for the same. Please review it.
>
>
>
> https://github.com/ceph/ceph/pull/2440
>
>
>
> Thanks & Regards
>
> Somnath
>
>
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is
> intended only for the use of the designated recipient(s) named above. If the
> reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please notify
> the sender by telephone or e-mail (as shown above) immediately and destroy
> any and all copies of this message in your possession (whether hard copies
> or electronically stored copies).
>
