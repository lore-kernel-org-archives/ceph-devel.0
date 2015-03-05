From: Ketor D <d.ketor@gmail.com>
Subject: Re: The project of ceph client file system porting from Linux to AIX
Date: Thu, 5 Mar 2015 15:11:31 +0800
Message-ID: <CAM9_UU-ayOpVsKCnzaBRGoc2NOj=URStHqW33zzw5CqShq4mpg@mail.gmail.com>
References: <CA+U0gVhWKjxMUBAw91B1vkYrF9s=pna1eZ3HfV+vBJ5aMhKWQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35237 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbbCEHME (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 02:12:04 -0500
Received: by obbgq1 with SMTP id gq1so12135185obb.2
        for <ceph-devel@vger.kernel.org>; Wed, 04 Mar 2015 23:12:04 -0800 (PST)
In-Reply-To: <CA+U0gVhWKjxMUBAw91B1vkYrF9s=pna1eZ3HfV+vBJ5aMhKWQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Chen <kernel.org.gnu@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>

Hi Dennis,
      I am interested in your project.
      I wrote a Win32 cephfs client https://github.com/ceph/ceph-dokan.
      But ceph-dokan runs in user-mode. I see you port code from
kernel cephfs, are you planning to write a kernel mode AIX-cephfs?

Thanks!


2015-03-04 17:59 GMT+08:00 Dennis Chen <kernel.org.gnu@gmail.com>:
> Hello,
>
> The ceph cluster now can only be used by Linux system AFAICT, so I
> planed to port the ceph client file system from Linux to AIX as a
> tiered storage solution in that platform. Below is the source code
> repository I've done, which is still in progress. 3 important modules:
>
> 1. aixker: maintain a uniform kernel API beteween the Linux and AIX
> 2. net: as a data transfering layer between the client and cluster
> 3. fs: as an adaptor to make the AIX can recognize the Linux file system.
>
> https://github.com/Dennis-Chen1977/aix-cephfs
>
> Welcome any comments or anything...
>
> --
> Den
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
