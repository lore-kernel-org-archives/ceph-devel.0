From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: [May be a bug?]Cannot umount cephfs after all mons is stopped
Date: Fri, 29 Nov 2013 07:58:59 -0800
Message-ID: <CA+Hcz58a4fMg89608Wh6EOoLsDkpaJRXBd80WLvjhrXUWzNokQ@mail.gmail.com>
References: <CAM9_UU9HeugRieJTbLQguCofhzVXNPvsys4nUbTqC79coG4BRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:37701 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab3K2P7A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Nov 2013 10:59:00 -0500
Received: by mail-qe0-f46.google.com with SMTP id a11so10387889qen.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Nov 2013 07:59:00 -0800 (PST)
In-Reply-To: <CAM9_UU9HeugRieJTbLQguCofhzVXNPvsys4nUbTqC79coG4BRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ketor D <d.ketor@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Did you try `umount -f`? I wouldn't say that is 'clean', but might
avoid a reboot. It would seem there isn't much else that can be done
if there is dirty data and no cluster to flush it to.

This also looks relevant:

   http://tracker.ceph.com/issues/206

On Thu, Nov 28, 2013 at 9:51 PM, Ketor D <d.ketor@gmail.com> wrote:
> Hi Sage:
>        We are testing cephfs mouting by kernel 3.12. And we meet a
> situation that we cannot umount cephfs and also cannot reboot the
> client machine. Only hard reset can restart the client machine.
>         Here is the flow:
>         1) Create a ceph cluster with 3 mons, 2 mds (active-standby), 2 osds.
>         2) Mount the cephfs with linux kernel 3.12.
>         3) Using service ceph stop mon.x to stop all mons.
>         4) Then we cannot umount the cephfs. The command lsof and
> fuser cannot return,and even if we use "umount -l [mount_point]",  we
> only see the mount_point disappeared from /etc/mtab, but we still
> cannot soft reboot the client machine.
>
>         If we get in this situation, we can only hard reset the client
> machine to avoid this.
>         So the problem is if there is some method can gracefully
> umount the cephfs and dont make the client machine cant rebooted?
>
>          Regards!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
