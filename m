From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: Questions about OSD recovery
Date: Fri, 10 Feb 2012 16:26:22 +0800
Message-ID: <CANExM-NOQQqshVeXnNkwSgkBCg5p3C15zA5K_1ejdy_uPucdVw@mail.gmail.com>
References: <CANExM-NCijMZX89Bp6wOGkLmkqKeqiqhnMJ8VKKN_QSQXnm7LA@mail.gmail.com>
	<4F333A0C.7080902@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43638 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2BJI0Y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 03:26:24 -0500
Received: by werb13 with SMTP id b13so1822460wer.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2012 00:26:23 -0800 (PST)
In-Reply-To: <4F333A0C.7080902@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

=E5=9C=A8 2012=E5=B9=B42=E6=9C=889=E6=97=A5=E4=B8=8A=E5=8D=8811:14=EF=BC=
=8CJosh Durgin <josh.durgin@dreamhost.com> =E5=AF=AB=E9=81=93=EF=BC=9A
> Detecting missing objects on startup is possible by looking at
> the pg log and comparing it to the objects on disk, but this can
> be a pretty expensive operation. The osd might also be out of

Yeah. It can be pretty expensive, but we only do it once on startup.
Also, since the osd has not yet joined the cluster, it shouldn't
affect the cluster
performance.

> date, so it's log might be useless (for example it could have
> divergent history that was not acked). It can't know how many
> current objects that should be there aren't until it goes through
> peering (to get an up to date and authoritative log) and
> recovery (to get missing data the logs say should be there). This
> is why scrub skips pgs that aren't active+clean. More details of
> peering can be found at http://ceph.newdream.net/docs/latest/dev/peer=
ing/.

Since peering only compare logs, I was thinking at least the osd should
check the existence of the objects the log claims to have. Then, we
would have the chance to recover the object before the pg goes active.

Also, I like the idea of storing crc/hash alongside the object as Tv sa=
id.
With that, we can even prevent the client from reading the corrupt data
by checking the crc/hash on each read. (Though, the read performance
will surely degrade.)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
