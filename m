From: Samuel Just <sjust@redhat.com>
Subject: Re: Why should we need trim_pushed_data() in handle_pull_response()
Date: Wed, 24 Feb 2016 10:09:31 -0800
Message-ID: <CAN=+7FVUOGftcqEFoLBeeONVg8ZhDhRm=iaNZADNpvgQ-CGYDA@mail.gmail.com>
References: <CALZt5jxbXJ9hit8_cvw7Fmo-VSZ5OJSyVWCyz8YrXjfgy3YDMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36321 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758552AbcBXSJc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 13:09:32 -0500
Received: by mail-yw0-f170.google.com with SMTP id e63so21889266ywc.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 10:09:31 -0800 (PST)
In-Reply-To: <CALZt5jxbXJ9hit8_cvw7Fmo-VSZ5OJSyVWCyz8YrXjfgy3YDMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

iirc, it's because the data we need to pull can change between when
the pull is sent and when the push arrives.
-Sam

On Tue, Feb 23, 2016 at 8:00 PM, Ning Yao <zay11022@gmail.com> wrote:
> Hi, Sam
>   why we need trim_pushed_data() in handle_pull_response(). I think
> data_included is always a subset of recovery_info.copy_subset since
> the logic in build_push_op tells us that, isn't it?
>
>
> Regards
> Ning Yao
