From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: mds crash on snaptest-2
Date: Mon, 19 Jul 2010 14:16:14 -0700
Message-ID: <AANLkTinxy56sN1K39-1z0AtcYWBI0ndPZQnlZzgaG0xx@mail.gmail.com>
References: <i21p5k$fma$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60123 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965514Ab0GSVQR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jul 2010 17:16:17 -0400
Received: by gwj18 with SMTP id 18so2199896gwj.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jul 2010 14:16:16 -0700 (PDT)
In-Reply-To: <i21p5k$fma$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Can you turn on debugging and verify for me that it's crashing on
"assert(p->second.first <=3D snapid && snapid <=3D p->first);
" CInode::encode_inodestat:1617?
I've hit this assert trying to reproduce your issue using cfuse and I
think this is it, but I'm hitting some ext3 bugs in my kernel on a
fairly regular basis while trying to reproduce, so a fix will need to
wait until I've upgraded (tomorrow). :)
Thanks!
-Greg

On Mon, Jul 19, 2010 at 7:57 AM, Thomas Mueller <thomas@chaschperli.ch>=
 wrote:
> hi
>
> the ceph.git/unstable cmds gets killed by my snaptest-2 (http://
> github.com/vinzent/ceph-testsuite/blob/master/tests/snaptest-2) with =
ceph-
> client-standalone/unstable-backport on kernel 2.6.34.1. I can reprodu=
ce
> the behaviour.
>
> it somewhere happens on the "Delete the snapshots..." phase.
>
>
> kernel log:
> [ 2024.315441] ceph: client4102 fsid ab2d5e45-9f53-7764-c958-c099f5be=
6e33
> [ 2024.316111] ceph: mon0 127.0.0.1:6789 session established
> [ 3753.964099] ceph: =A0tid 11109 timed out on osd0, will reset osd
> [ 4054.056374] ceph: =A0tid 15029 timed out on osd0, will reset osd
> [ 4098.646013] ceph: mds0 127.0.0.1:6802 socket closed
> [ 4099.804937] ceph: mds0 127.0.0.1:6802 connection failed
> [ 4100.804629] ceph: mds0 127.0.0.1:6802 connection failed
> [ 4101.804638] ceph: mds0 127.0.0.1:6802 connection failed
> [ 4103.804636] ceph: mds0 127.0.0.1:6802 connection failed
> [ 4107.804381] ceph: mds0 127.0.0.1:6802 connection failed
> [ 4115.804644] ceph: mds0 127.0.0.1:6802 connection failed
> [ 4131.804387] ceph: mds0 127.0.0.1:6802 connection failed
> [ 4144.804343] ceph: mds0 caps stale
> [ 4159.806936] ceph: mds0 caps stale
> [ 4163.804149] ceph: mds0 127.0.0.1:6802 connection failed
>
> there is no cmds segfault message, but cmds process has gone.
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
