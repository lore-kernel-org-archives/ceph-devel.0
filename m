From: Samuel Just <sjust@redhat.com>
Subject: Re: RAID Controller containing cache with battery
Date: Tue, 21 Jun 2016 10:08:03 -0700
Message-ID: <CAN=+7FW_D0YsrsU+toe+K+3S_LwUf65+Gi+VknvXex0QFe6kqQ@mail.gmail.com>
References: <CALZt5jxQotzw=KuXWUvF8EV+C63DGOgojJLgpZntg5rgE8vJSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34996 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbcFUROQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 13:14:16 -0400
Received: by mail-qk0-f180.google.com with SMTP id c73so30141910qkg.2
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2016 10:13:30 -0700 (PDT)
In-Reply-To: <CALZt5jxQotzw=KuXWUvF8EV+C63DGOgojJLgpZntg5rgE8vJSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

For anyone else who sees this thread: Do. Not. Enable. nobarrier.
Barriers are important.  If the device is able to use a non-volatile
cache to speed up a sync, it should be able to do so anyway.
-Sam

On Tue, Jun 21, 2016 at 8:46 AM, Ning Yao <zay11022@gmail.com> wrote:
> Hi, all
>
> As some RAID Controllers provides non-violate cache with battery to
> protect data during power loss. For SATA disk, we want enable
> nobarrier options to boost IO performance. But no barrier option
> require us to use a real File on filesystem instead of a raw device,
> which may cause more inode content updating and degrade performance. I
> wonder, is that meaningful to add an option such like
> enable_journal_nobarrier to tell whether open raw device with O_DSYNC
> or not (default set to false), to guide the journal write without
> barrier if we are definitely sure that our cache on SSD or RAID
> Controller is non-violate?
>
> Regards
> Ning Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
