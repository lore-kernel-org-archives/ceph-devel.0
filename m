From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: ./run-make-check.sh
Date: Thu, 19 Nov 2015 21:30:56 -0500 (EST)
Message-ID: <1898715288.16215515.1447986656826.JavaMail.zimbra@redhat.com>
References: <955833108.16153353.1447976340808.JavaMail.zimbra@redhat.com> <1842494150.16154755.1447976394788.JavaMail.zimbra@redhat.com> <CAEf3A-zgvAXT3EUX_+U+ZN_QspFrFQhjMJHgtArnCqh5WDkXzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:42434 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934659AbbKTCa6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 21:30:58 -0500
In-Reply-To: <CAEf3A-zgvAXT3EUX_+U+ZN_QspFrFQhjMJHgtArnCqh5WDkXzQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tobe <tobeg3oogle@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I always run with root -;

Thanks!
Shinobu

----- Original Message -----
From: "tobe" <tobeg3oogle@gmail.com>
To: "Shinobu Kinjo" <skinjo@redhat.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Friday, November 20, 2015 11:24:57 AM
Subject: Re: [CEPH-DEVEL] ./run-make-check.sh

It seems to be the permission problem and you got "Permission denied".

Can you try again as the root user or sudo?

On Fri, Nov 20, 2015 at 7:39 AM, Shinobu Kinjo <skinjo@redhat.com> wrote:

> Hello,
>
> I saw this message during executing run-make-check.sh on fc23:
>
> 2015-11-20 01:05:37.529021 7f8742e3d7c0 -1  ** ERROR: error creating empty
> object store in testdir/osd-reactivate/0: (13) Permission denied
>
> Can we ignore at the moment?
>
> If I've missed anything, let me know.
>
> Thanks!!
> Shinobu
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
