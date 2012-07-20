From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph write performance
Date: Fri, 20 Jul 2012 09:37:00 -0700
Message-ID: <CAPYLRzg1U3HWEUgAwLoySzGrgxiqMEowXHEfsG4LKLLKsGi3TA@mail.gmail.com>
References: <500931CF.9040407@selectel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53261 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab2GTQhC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 12:37:02 -0400
Received: by bkwj10 with SMTP id j10so3583891bkw.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 09:37:00 -0700 (PDT)
In-Reply-To: <500931CF.9040407@selectel.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: George Shuklin <shuklin@selectel.ru>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 20, 2012 at 3:24 AM, George Shuklin <shuklin@selectel.ru> w=
rote:
> Good day.
>
> I've start to play with Ceph... And I found some kinda strange perfor=
mance
> issues. I'm not sure if this is due ceph limitation or my bad setup.
>
> Setup:
>
> osd - xfs on ramdisk (only one osd)
> mds - raid0 on 10 disks
> mon - second raid0 on 10 disks

I'm not going to butt in on the performance discussion, but just FYI,
the MDS does not use any local storage =97=A0it puts everything on the
OSDs. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
