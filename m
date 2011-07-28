From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Filesystems for ceph
Date: Wed, 27 Jul 2011 17:04:11 -0700
Message-ID: <CAF3hT9C4EEyr+=Sq5_SS46_Cni39FOGN_nEvBztuZye3_N7Liw@mail.gmail.com>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f43.google.com ([74.125.83.43]:46314 "EHLO
	mail-gw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab1G1AJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 20:09:57 -0400
Received: by gwm11 with SMTP id 11so1874108gwm.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 17:09:56 -0700 (PDT)
In-Reply-To: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

Our largest installation hasn't seen any problems with btrfs on
2.6.38.6, although it may not be as busy as the clusters you're
running on.

I would recommend trying to use a newish stable release though, since
the major releases I think are still introducing new features into
btrfs, and code churn always creates bugs.
-Greg

On Wed, Jul 27, 2011 at 10:52 AM, Christian Brunner <chb@muc.de> wrote:
> We are having quite some problems with the underlying filesystem for
> the cosd's and I would like to hear about other experiences. Here is
> what we have gone through so far:
>
> btrfs with 2.6.38:
>
> - good performance
> - frequently hitting of various BUG_ON conditions
>
> btrfs with 2.6.39:
>
> - big performance problems after a few days uptime
> - occasionally hitting BUG_ON conditions
>
> btrfs with 3.0:
>
> - big performance problems after a few days uptime
> - occasionally hitting a deadlock in the btrfs filesystem (cosd is in=
 D-state)
>
> ext4 with a RHEL6.0 kernel (don't remember exactly):
>
> - almost immediate blowup of the kernel (OOPS)
>
> From what I read in Fyodors emails ext4 in 2.6.39 isn't much better.
>
> So, what filesystem would you recommend?
>
> Thanks,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
