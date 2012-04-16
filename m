From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: librados aio completion
Date: Sun, 15 Apr 2012 22:25:09 -0700
Message-ID: <CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63676 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab2DPFZL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 01:25:11 -0400
Received: by bkcik5 with SMTP id ik5so3326337bkc.19
        for <ceph-devel@vger.kernel.org>; Sun, 15 Apr 2012 22:25:09 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Sun, Apr 15, 2012 at 9:44 PM, Sage Weil <sage@newdream.net> wrote:
> We just switched the completion callbacks so that they are called
> asynchronously from another thread. =A0This makes the locking less we=
ird for
> certain callers and lets you call back into librados in your callback
> safely.
>
> This breaks one of the functional tests, which sets a bool in the
> callback, does wait_for_complete() on the aio handle, and then assert=
s
> that the bool is set. =A0There's now a race between the caller's thre=
ad and
> the completion thread.
>
> Do we just call this a broken test, or do we want some way of blockin=
g on
> the aio handle until the completion has been called?

I'd expect wait_for_complete() to wait until the completion completed.
We can add some other wait_for_foo() for the current case.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
