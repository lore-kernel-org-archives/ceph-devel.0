From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: filename too long (pjd-fstest on centos5 with ceph 0.20.2)
Date: Tue, 1 Jun 2010 12:47:56 -0700
Message-ID: <AANLkTikg4MlmakIHB7WsP12lFF_YVWOj-jNL4az4efS9@mail.gmail.com>
References: <hu03dh$vgc$1@dough.gmane.org>
	<AANLkTinYa6a6yqnbjBH99seMT4NJgXpQig38mV4rmEkM@mail.gmail.com>
	<hu06m8$vgc$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64975 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab0FATr6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jun 2010 15:47:58 -0400
Received: by gye5 with SMTP id 5so1476103gye.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Jun 2010 12:47:57 -0700 (PDT)
In-Reply-To: <hu06m8$vgc$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Thomas:
We've checked into this a bit here, and we aren't seeing any failures
from pjd ourselves. The tests you reference as failing are all
mtime/atime/ctime checks, so our best guess is that your client and
server don't have synchronized clocks, which could cause this
behavior.

As for the "mkdir: `_xxxxxx-veryveryveryverylongpath/x': File name too
long" issue, we think that may be a result of the shell complaining --
Ceph itself doesn't have any filename size limits so we just set the
max length to be the max path length. We're looking into it
separately, but that definitely isn't causing any pjd failures as pjd
expects those filenames to not be accepted. :)

On Mon, May 31, 2010 at 4:31 AM, Thomas Mueller <thomas@chaschperli.ch>=
 wrote:
> Am Mon, 31 May 2010 03:42:33 -0700 schrieb Gregory Farnum:
>
>> Thomas:
>> The "file name too long" errors are actually supposed to occur in a
>> number of places in pjd-fstest -- it's part of the correctness testi=
ng!
>
> I can't see these error messages if I run the test on the local fs.
>
> - Thomas
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
