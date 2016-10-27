From: Kostis Fardelas <dante1234@gmail.com>
Subject: Re: ceph -s report all mons down
Date: Thu, 27 Oct 2016 08:23:11 +0300
Message-ID: <CAN3wisUHiVixEuzJx1qHFJzV525XSv0=GvQ-VBe83R6+YT6huQ@mail.gmail.com>
References: <CAKE=UQLCJoJXzhVdtp24wQzb2AKDzMywUqG_R-cvC+0WNOi1xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36209 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbcJ0FXR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 01:23:17 -0400
Received: by mail-qk0-f170.google.com with SMTP id o68so30823259qkf.3
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 22:23:12 -0700 (PDT)
In-Reply-To: <CAKE=UQLCJoJXzhVdtp24wQzb2AKDzMywUqG_R-cvC+0WNOi1xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rui Xie <jerry.xr86@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

What do you mean 'it is not really down"? Does the process run? If
yes, then had the process been bound to its port (netstat check) ? If
yes, then my next guess is a firewall issue that prevents monitors for
reaching each other. If no, then check the logs for the cause. One
possible case is that you run out of file descriptors.

On 27 October 2016 at 04:56, Rui Xie <jerry.xr86@gmail.com> wrote:
> Hi:
>       Sometimes when i use ceph -s to query cluster status, it shows
> all mons down (Hammer), but in fact monitor is not really down. from
> the code it seems ceph -s not wait elect finish, so maybe quorum is
> empty at that time?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
