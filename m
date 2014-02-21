From: Ken Dreyer <ken.dreyer@inktank.com>
Subject: Re: Fixes for missing and replicated files in ceph.spec.in
Date: Fri, 21 Feb 2014 16:04:45 -0700
Message-ID: <CAOpHjdAvLm=+fv4FODtt75usc=+A9fWv9eXfsEE72cph7qYFgg@mail.gmail.com>
References: <CABAwU-ZCSVbkLUOvZBd8=+uHD1L6tVS5iAkpDNUS0_myP5Xndw@mail.gmail.com>
 <CAOpHjdDFygeaDfzOrB5HDOLc1tp-yvmBsnuvhYKKCDYcSWU0ww@mail.gmail.com> <alpine.DEB.2.00.1402211247430.17314@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:40245 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbaBUXFG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 18:05:06 -0500
Received: by mail-ve0-f171.google.com with SMTP id pa12so3890996veb.16
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 15:05:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402211247430.17314@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: huang jun <hjwsm1989@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 21, 2014 at 1:48 PM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 21 Feb 2014, Ken Dreyer wrote:
>> On Fri, Feb 21, 2014 at 4:27 AM, huang jun <hjwsm1989@gmail.com> wrote:
>> > @@ -690,6 +689,7 @@ fi
>> >  %{_bindir}/ceph_test_rados_list_parallel
>> >  %{_bindir}/ceph_test_rados_open_pools_parallel
>> >  %{_bindir}/ceph_test_rados_watch_notify
>> > +%{_bindir}/ceph_test_rgw_manifest
>> >  %{_bindir}/ceph_test_signal_handlers
>> >  %{_bindir}/ceph_test_snap_mapper
>>
>>
>> It seems like we have to deal with this sort of thing over and over.
>> Anyone have objections to simply using a wildcard to capture all the
>> test files? Something like %{_bindir}/ceph_test_* ?
>
> Sounds good to me.  This is only stuff that 'make install' is putting in
> place right?

Yep, that's right, the wildcard will just match what 'make install' has done.

Pull request is at https://github.com/ceph/ceph/pull/1287 . Huang, if
you have time, it would be great to get your review before we merge.

- Ken
