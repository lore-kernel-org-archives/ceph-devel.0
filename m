From: Samuel Just <sam.just@inktank.com>
Subject: Re: [ceph-users] ceph -w warning "I don't have pgid 0.2c8"?
Date: Thu, 18 Jul 2013 11:16:15 -0700
Message-ID: <CA+4uBUZgjxObUp9a9=+meY=td4DY7x=KfUzCP81sFxS3fv4cwg@mail.gmail.com>
References: <51E64EE7.3090902@vccloud.vn>
	<CA+4uBUbASJWUME+zOZRh=NrZLEGdJcmwXMoMWvvmgGRzG04C0w@mail.gmail.com>
	<51E75166.9000308@vccloud.vn>
	<51E75958.10806@vccloud.vn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:33592 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619Ab3GRSQQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jul 2013 14:16:16 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so2749319veb.20
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jul 2013 11:16:15 -0700 (PDT)
In-Reply-To: <51E75958.10806@vccloud.vn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ta Ba Tuan <tuantb@vccloud.vn>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

What is the output of ceph pg dump | grep 'stale\|creating' ?

On Wed, Jul 17, 2013 at 7:56 PM, Ta Ba Tuan <tuantb@vccloud.vn> wrote:
> zombie pgs might occured when i remove some data pools.
> but, with pgs in stale state, i can't delete it?
>
> I found this guide, but I don't understand it.
> http://ceph.com/docs/next/dev/osd_internals/pg_removal/
>
> Thanks!
> --tuantaba
>
>
> On 07/18/2013 09:22 AM, Ta Ba Tuan wrote:
>
> I'm using Ceph-0.61.4,
> I removed each osds (2TB) on data hosts and re-create with disks (4TB).
> When converting finish, Ceph warns that have 4 pgs in stale state and
> warning: i don't have pgid <pgid>
> after, I created 4 pgs by command: ceph pg force_create_pg <pgid>
>
> Now (after the long time), Ceph still warning: "pgmap v57451: 22944 pgs: 4
> creating, 22940 active+clean;"
>
> I don't know how to remove those pgs?.
>  Please guiding this error help me!
>
> Thank you!
> --tuantaba
> TA BA TUAN
>
>
> On 07/18/2013 01:16 AM, Samuel Just wrote:
>
> What version are you running?  How did you move the osds from 2TB to 4TB?
> -Sam
>
> On Wed, Jul 17, 2013 at 12:59 AM, Ta Ba Tuan <tuantb@vccloud.vn> wrote:
>
> Hi everyone,
>
> I converted every osds from 2TB to 4TB, and when moving complete, show log
> Ceph realtime"ceph -w":
> displays error: "I don't have pgid 0.2c8"
>
> after then, I run:  "ceph pg force_create_pg 0.2c8"
> Ceph warning: pgmap v55175: 22944 pgs: 1 creating, 22940 active+clean, 3
> stale+active+degraded
>
> then, I can't read/write data to mounted CephFS on Client-side ==> notify on
> client side: "Operation not permitted"
>
> now, "ceph -w" still notify "22944 pgs: 1 creating, 22940 active+clean, 3
> stale+active+degraded"
> and I don't understand something occuring?
> Please, help me!!!
>
> Thanks to everyone.
>
> --tuantaba
>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
