From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Debs must not contain /var/run
Date: Fri, 9 Sep 2011 09:20:57 -0700
Message-ID: <CAORUGqDFiiBo-yiGcK3cERRiu2_0kgvEw5yO7Yj=xYYPEWwoHA@mail.gmail.com>
References: <CAORUGqDWnPYmDpXqjpMitdDV7bAKnrHKFFu2zqzD4cT-X90UmQ@mail.gmail.com>
 <Pine.LNX.4.64.1109090912270.29097@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49233 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759317Ab1IIQVS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2011 12:21:18 -0400
Received: by wyh22 with SMTP id 22so1720730wyh.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Sep 2011 09:21:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1109090912270.29097@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 9, 2011 at 09:16, Sage Weil <sage@newdream.net> wrote:
> Reverted! =C2=A0Looks like the ceph init script is already creating t=
he
> pid_file dir.
>
> This came up because we were configuring radosgw's socket to be in
> /var/run/ceph, but it didn't exist. =C2=A0The radosgw package doesn't=
 even have
> an init script at this point, though (since it's not strictly require=
d
> that you run it that way), so whatever. =C2=A0At some point we should=
 decide
> how much to encourage/streamline that mode of running it...

It could have an init script that doesn't actually start a service,
just preps the machine for it.

And then later that init script can also do the standalone fcgid
starting, if it's run in that mode.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
