From: David McBride <dwm37@cam.ac.uk>
Subject: Ceph daemon memory utilization: 'heap release' drops use by 50%
Date: Mon, 14 Apr 2014 13:28:55 +0100
Message-ID: <534BD487.5090507@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:36909 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbaDNMtQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Apr 2014 08:49:16 -0400
Received: from randall.csi.cam.ac.uk ([131.111.56.82]:35735)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (PLAIN:dwm37) (TLSv1:DHE-RSA-AES128-SHA:128)
	id 1WZg0N-0002yY-YD (Exim 4.82_3-c0e5623) for ceph-devel@vger.kernel.org
	(return-path <dwm37@cam.ac.uk>); Mon, 14 Apr 2014 13:28:55 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>

Hello,

I'm currently experimenting with a Ceph deployment, and am noting that
some of my machines are having processes killed by the OOM killer,
despite provisioning 32GB for a 12 OSD machine.

(This tended to correlate with reshaping the cluster, which is not
surprising given that OSD memory utilization is documented to spike whe=
n
recovery operations are in progress.)

While the recently-added zRAM kernel facility appears to be helping
somewhat in stretching the available resources, I've been reviewing the
heap utilization statistics displayed via `ceph tell osd.$i heap stats`=
=2E

On a representative process, I see:

> osd.0tcmalloc heap stats:--------------------------------------------=
----
> MALLOC:      593850280 (  566.3 MiB) Bytes in use by application
> MALLOC: +   1621073920 ( 1546.0 MiB) Bytes in page heap freelist
> MALLOC: +    117159712 (  111.7 MiB) Bytes in central cache freelist
> MALLOC: +      2987008 (    2.8 MiB) Bytes in transfer cache freelist
> MALLOC: +     84780344 (   80.9 MiB) Bytes in thread cache freelists
> MALLOC: +     13119640 (   12.5 MiB) Bytes in malloc metadata
> MALLOC:   ------------
> MALLOC: =3D   2432970904 ( 2320.3 MiB) Actual memory used (physical +=
 swap)
> MALLOC: +     44449792 (   42.4 MiB) Bytes released to OS (aka unmapp=
ed)
> MALLOC:   ------------
> MALLOC: =3D   2477420696 ( 2362.7 MiB) Virtual address space used
> MALLOC:
> MALLOC:          60887              Spans in use
> MALLOC:            775              Thread heaps in use
> MALLOC:           8192              Tcmalloc page size
> ------------------------------------------------

I noticed there's a huge amount of memory =E2=80=94 1.5GB =E2=80=94 on =
the main
freelist.  As an experiment, I ran `ceph tell osd.$i heap release`, and
the amount of memory in use dropped substantially:

> osd.0tcmalloc heap stats:--------------------------------------------=
----
> MALLOC:      581434648 (  554.5 MiB) Bytes in use by application
> MALLOC: +     11509760 (   11.0 MiB) Bytes in page heap freelist
> MALLOC: +    105904144 (  101.0 MiB) Bytes in central cache freelist
> MALLOC: +      2070848 (    2.0 MiB) Bytes in transfer cache freelist
> MALLOC: +     97882520 (   93.3 MiB) Bytes in thread cache freelists
> MALLOC: +     13119640 (   12.5 MiB) Bytes in malloc metadata
> MALLOC:   ------------
> MALLOC: =3D    811921560 (  774.3 MiB) Actual memory used (physical +=
 swap)
> MALLOC: +   1665499136 ( 1588.3 MiB) Bytes released to OS (aka unmapp=
ed)
> MALLOC:   ------------
> MALLOC: =3D   2477420696 ( 2362.7 MiB) Virtual address space used
> MALLOC:
> MALLOC:          60733              Spans in use
> MALLOC:            803              Thread heaps in use
> MALLOC:           8192              Tcmalloc page size
> ------------------------------------------------

This was consistent across all 12 OSDs; running this command on all the
OSDs on a machine dropped memory utilization by ~15GB, or ~50% of the
amount of RAM in my machine.

Is this expected behaviour?  Would it be prudent to treat this as the
amount of memory the Ceph OSDs genuinely requires at peak demand?
(If so, that indicates that I need to be looking to increase the spec o=
f
my storage nodes...)

I see similar results on my MON nodes.  Before a release:

> mon.ceph-sm000tcmalloc heap stats:-----------------------------------=
-------------
> MALLOC:      599497240 (  571.7 MiB) Bytes in use by application
> MALLOC: +    806297600 (  768.9 MiB) Bytes in page heap freelist
> MALLOC: +     32448368 (   30.9 MiB) Bytes in central cache freelist
> MALLOC: +      1684080 (    1.6 MiB) Bytes in transfer cache freelist
> MALLOC: +     23270408 (   22.2 MiB) Bytes in thread cache freelists
> MALLOC: +      5091480 (    4.9 MiB) Bytes in malloc metadata
> MALLOC:   ------------
> MALLOC: =3D   1468289176 ( 1400.3 MiB) Actual memory used (physical +=
 swap)
> MALLOC: +     30859264 (   29.4 MiB) Bytes released to OS (aka unmapp=
ed)
> MALLOC:   ------------
> MALLOC: =3D   1499148440 ( 1429.7 MiB) Virtual address space used
> MALLOC:
> MALLOC:          18309              Spans in use
> MALLOC:            122              Thread heaps in use
> MALLOC:           8192              Tcmalloc page size
> ------------------------------------------------

After:

> mon.ceph-sm000tcmalloc heap stats:-----------------------------------=
-------------
> MALLOC:      600108520 (  572.3 MiB) Bytes in use by application
> MALLOC: +     17342464 (   16.5 MiB) Bytes in page heap freelist
> MALLOC: +     32392208 (   30.9 MiB) Bytes in central cache freelist
> MALLOC: +       964240 (    0.9 MiB) Bytes in transfer cache freelist
> MALLOC: +     23402360 (   22.3 MiB) Bytes in thread cache freelists
> MALLOC: +      5091480 (    4.9 MiB) Bytes in malloc metadata
> MALLOC:   ------------
> MALLOC: =3D    679301272 (  647.8 MiB) Actual memory used (physical +=
 swap)
> MALLOC: +    819847168 (  781.9 MiB) Bytes released to OS (aka unmapp=
ed)
> MALLOC:   ------------
> MALLOC: =3D   1499148440 ( 1429.7 MiB) Virtual address space used
> MALLOC:
> MALLOC:          16396              Spans in use
> MALLOC:            122              Thread heaps in use
> MALLOC:           8192              Tcmalloc page size
> ------------------------------------------------

The tcmalloc documentation suggests that memory should be gradually
being returned to the operating system:

http://gperftools.googlecode.com/svn/trunk/doc/tcmalloc.html#runtime

Given these OSDs were largely idle over the weekend prior to running
this experiment, it seems clear that this process is not operating as
designed.

I've looked through the environment of my running processes and the Cep=
h
source, and can see no reference to TCMALLOC_RELEASE_RATE or
SetMemoryReleaseRate().

I'm currently running an experiment whereby I define
"env TCMALLOC_RELEASE_RATE=3D10" in
/etc/init/ceph-{osd,mon}.conf.override; I'll see if this has any impact
on memory usage over time.

(I suspect that my current Ceph cluster placement-group count is
excessive; with 144 OSDs, I'm running with about a dozen pools, each of
which with ~8000 PGs.  It's not clear how the guidelines for PG-sizing
should be adjusted for multiple-pool configurations; at some point I'll
see what effect wiping my cluster and using a much smaller per-pool PG
count has.)

Cheers,
David
--=20
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Information Services
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
