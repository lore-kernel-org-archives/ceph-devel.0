From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: filename too long (pjd-fstest on centos5 with ceph 0.20.2)
Date: Mon, 31 May 2010 03:42:33 -0700
Message-ID: <AANLkTinYa6a6yqnbjBH99seMT4NJgXpQig38mV4rmEkM@mail.gmail.com>
References: <hu03dh$vgc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60895 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0EaKmf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 May 2010 06:42:35 -0400
Received: by vws9 with SMTP id 9so554916vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 May 2010 03:42:34 -0700 (PDT)
In-Reply-To: <hu03dh$vgc$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Thomas:
The "file name too long" errors are actually supposed to occur in a
number of places in pjd-fstest -- it's part of the correctness
testing!

That said, I don't think the kernel client shouldn't be failing any of
the tests, so we'll look at this in the next day or two using the
failed test numbers you gave us. Thanks for the bug report!
-Greg

On Mon, May 31, 2010 at 3:35 AM, Thomas Mueller <thomas@chaschperli.ch>=
 wrote:
> hi
>
> i'm doing some testing. i've ran pjd-fstest. on ceph (kclient)
> mountpoints there are many "file name too long" messages.
>
> example error message:
> mkdir: `_xxxxxx-veryveryveryverylongpath/x': File name too long
>
>
> fstest results:
>
> Failed Test =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Stat Wstat Total Fail=
 =A0Failed =A0List of Failed
> ---------------------------------------------------------------------=
----------
> /tmp/fstest/tests/mkdir/00.t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A036 =A0 =A0=
5 =A013.89% =A030-34
> /tmp/fstest/tests/mkfifo/00.t =A0 =A0 =A0 =A0 =A0 =A0 =A0 36 =A0 =A05=
 =A013.89% =A030-34
> /tmp/fstest/tests/open/00.t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 47 =A0 =A0=
5 =A010.64% =A030-34
> Failed 3/184 test scripts, 98.37% okay. 15/1957 subtests failed, 99.2=
3%
> okay.
>
>
> if I run fstest on the local filesystem it completes without errors -=
 so
> the "filename too long" seems to be a ceph specific error.
>
> - Thomas
>
> Env:
> - 4x osd, 1x mds, 1x mon, 1x kclient
> - ceph 0.20.2, ceph kclient 2.6.34, Cento5, pjd-fstest-20080816
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
