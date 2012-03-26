From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 12:49:16 -0700
Message-ID: <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37729 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2CZTth convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 15:49:37 -0400
Received: by pbcun15 with SMTP id un15so6348980pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 12:49:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 26, 2012 at 12:36, Sage Weil <sage@newdream.net> wrote:
> Currently when you shutdown/kill a ceph-osd it is no different from i=
t
> crashing: you have to wait N seconds for its peers to conclude the pr=
ocess
> is down before the OSD is deemed 'failed' and the osd map is updated.
>
> This would be pretty easy to improve on:
>
> =C2=A0- on a clean shutdown (e.g., due to SIGTERM), we could execv a =
call to
> =C2=A0 the ceph tool to tell the monitors the osd stopped (maybe with=
 a
> =C2=A0 'reason' and nice log message).
>
> =C2=A0- on an unclean shutdown (e.g., failed assert, segfault) we can
> =C2=A0 do the same, with an appropriate message in the system log

A clean shutdown can send the "This location is now defunct" message
itself, execve seems to be extra just complications for it.

=46or daemon crashes, perhaps the next run, after upstart/etc restarts
the daemon, can somehow convince others proactively that the new
osd.42 is better than the old osd.42. That sounds like a good feature
to have..
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
