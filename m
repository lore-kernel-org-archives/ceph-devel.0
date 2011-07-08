From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: btrfs devs
Date: Fri, 8 Jul 2011 10:58:38 -0700
Message-ID: <CAORUGqANLLzppGTJ+1aWgA0S78UxRzHq+ee1_3MQWJDX=cYu2Q@mail.gmail.com>
References: <CAG_bnfx-mR0-2KtMGgYcfW9hA5TKn+TFqKmOPRSYfOwSn2=vcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44999 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1GHR67 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2011 13:58:59 -0400
Received: by eyx24 with SMTP id 24so745068eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2011 10:58:58 -0700 (PDT)
In-Reply-To: <CAG_bnfx-mR0-2KtMGgYcfW9hA5TKn+TFqKmOPRSYfOwSn2=vcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vineet Jain <vinjvinj@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 8, 2011 at 07:09, Vineet Jain <vinjvinj@gmail.com> wrote:
> you define a btrfs device as:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs devs =3D /dev/sdx
>
> Is there any way to change the device to use UUID instead since sdx
> can change between boots or when you replace hard drives.

Any path to a block device is good enough. udev gives you symlinks
based on the UUID of the partition.

ubuntu@sepia70:~$ ls -l /dev/disk/by-uuid/cef77500-29cf-472f-b068-2344f=
1cc59e4
lrwxrwxrwx 1 root root 10 2011-05-17 13:48
/dev/disk/by-uuid/cef77500-29cf-472f-b068-2344f1cc59e4 -> ../../sda5
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
