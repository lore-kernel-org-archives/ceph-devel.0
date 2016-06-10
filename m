From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: increase default debug level
Date: Fri, 10 Jun 2016 11:02:50 -0700
Message-ID: <CAJ4mKGZ+-cK_wL3+oufi8+fwBo5VQN9E8i_Ku=85G2Qhq6gPMQ@mail.gmail.com>
References: <CAKPXa=biYbvnupYKdTcQRBfAiK2e8HNBqbrvQ15VtEZg99fWrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36141 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbcFJSCw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 14:02:52 -0400
Received: by mail-vk0-f52.google.com with SMTP id g67so107552765vkb.3
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 11:02:51 -0700 (PDT)
In-Reply-To: <CAKPXa=biYbvnupYKdTcQRBfAiK2e8HNBqbrvQ15VtEZg99fWrg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Friday, June 10, 2016, Vasu Kulkarni <vakulkar@redhat.com> wrote:
>
> I am trying to check if it makes sense to set the default ceph debug
> level for daemons to something higher from the current levels, this
> might cause huge log files but with log rotate and size restrictions
> it can be still be at a manageable levels,  Setting higher debug
> output will save time when there is an hard to recreate issue and the
> logs generated first time would provide more info for root cause.
>
> for example:
>
> debug osd = 20
> debug filestore = 20
> debug ms = 1

Higher log levels dramatically reduce performance and the size of the
log files (even with rotation) can be difficult to handle in
production environments. Those settings are definitely not suitable,
and I think the ones we have right now are appropriate (at least, the
numbers are). We run with other defaults in many of our testing
environments (although not all; we need coverage at the production
speed!).
-Greg
