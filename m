From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph was didn't stop.
Date: Thu, 28 Jun 2012 09:55:24 -0700
Message-ID: <CADvuQRHr+HEzMoQ3xwrqPW5OZrjUOLwwzkk0AZJg0XTOUYyC8w@mail.gmail.com>
References: <loom.20120627T061404-977@post.gmane.org> <4FEBA33F.8020700@inktank.com>
 <loom.20120628T065725-838@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52558 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988Ab2F1Qzo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 12:55:44 -0400
Received: by pbbrp8 with SMTP id rp8so3260949pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 09:55:44 -0700 (PDT)
In-Reply-To: <loom.20120628T065725-838@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jun 27, 2012 at 10:05 PM, ramu <ramu.freesystems@gmail.com> wro=
te:
> + ssh gamma cd /etc/ceph ; ulimit -c unlimited ; while [ 1 ]; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -e /var/run/ceph/osd.1.pid ] || break
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pid=3D`cat /var/run/ceph/osd.1.pid`
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while [ -e /proc/$pid ] && grep -q ceph-os=
d /proc/$pid/cmdline ; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd=3D"kill =C2=A0$pid"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo -n $cmd...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cmd
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue
> =C2=A0 =C2=A0 =C2=A0 =C2=A0done
> =C2=A0 =C2=A0 =C2=A0 =C2=A0break
> =C2=A0 =C2=A0done

Well, if that didn't do it (and I don't see the "echo -n $cmd..."
output anywhere, so if was most likely false), then it's highly likely
the PID file has gone missing or is corrupt. This is a classic failure
mode of sysvinit style self-daemonizing and PID file handling. Kill
the process manually for now, and let us know of this keeps happening;
right now "somebody rm -rf /var/run/ceph" is as good a guess as any.

This is one of the reasons why I advocate upstart/runit/etc, and why
the "new style" of deployment uses upstart.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
