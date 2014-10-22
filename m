From: David Zafman <david.zafman@inktank.com>
Subject: Re: Can pid be reused ?
Date: Wed, 22 Oct 2014 15:21:34 -0700
Message-ID: <0B26F614-B9E5-4E30-9471-A7F46656AA24@inktank.com>
References: <54471CA6.5040807@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34147 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbaJVWVk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Oct 2014 18:21:40 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so4369703pde.12
        for <ceph-devel@vger.kernel.org>; Wed, 22 Oct 2014 15:21:39 -0700 (PDT)
In-Reply-To: <54471CA6.5040807@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


I just realized what it is.  The way killall is used when stopping a vs=
tart cluster, is to kill all processes by name!  You can't stop vstarte=
d tests running in parallel.

David Zafman
Senior Developer
http://www.inktank.com




> On Oct 21, 2014, at 7:55 PM, Loic Dachary <loic@dachary.org> wrote:
>=20
> Hi,
>=20
> Something strange happens on fedora20 with linux 3.11.10-301.fc20.x86=
_64. Running make -j8 check on https://github.com/ceph/ceph/pull/2750 a=
 process gets killed from time to time. For instance it shows as
>=20
> TEST_erasure_crush_stripe_width: 124: stripe_width=3D4096
> TEST_erasure_crush_stripe_width: 125: ./ceph osd pool create pool_era=
sure 12 12 erasure
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> ./test/mon/osd-pool-create.sh: line 120: 27557 Killed                =
  ./ceph osd pool create pool_erasure 12 12 erasure
> TEST_erasure_crush_stripe_width: 126: ./ceph --format json osd dump
> TEST_erasure_crush_stripe_width: 126: tee osd-pool-create/osd.json
>=20
> in the test logs. Note the 27557 Killed . I originally thought it was=
 because some ulimit was crossed and set them to very generous / unlimi=
ted hard / soft thresholds.
>=20
> core file size          (blocks, -c) 0                               =
                                                     =20
> data seg size           (kbytes, -d) unlimited                       =
                                                     =20
> scheduling priority             (-e) 0                               =
                                                     =20
> file size               (blocks, -f) unlimited                       =
                                                     =20
> pending signals                 (-i) 515069                          =
                                                     =20
> max locked memory       (kbytes, -l) unlimited                       =
                                                     =20
> max memory size         (kbytes, -m) unlimited                       =
                                                     =20
> open files                      (-n) 400000                          =
                                                     =20
> pipe size            (512 bytes, -p) 8                               =
                                                     =20
> POSIX message queues     (bytes, -q) 819200                          =
                                                     =20
> real-time priority              (-r) 0                               =
                                                     =20
> stack size              (kbytes, -s) unlimited                       =
                                                     =20
> cpu time               (seconds, -t) unlimited                       =
                                                     =20
> max user processes              (-u) unlimited                       =
                                                     =20
> virtual memory          (kbytes, -v) unlimited                       =
                                                     =20
> file locks                      (-x) unlimited   =20
>=20
> Benoit Canet suggested that I installed systemtap ( https://www.sourc=
eware.org/systemtap/wiki/SystemtapOnFedora ) and ran https://sourceware=
=2Eorg/systemtap/examples/process/sigkill.stp to watch what was sending=
 the kill signal. It showed the following:
>=20
> ...
> SIGKILL was sent to ceph-osd (pid:27557) by vstart_wrapper. uid:1001
> SIGKILL was sent to python (pid:27557) by vstart_wrapper. uid:1001
> ....
>=20
> which suggests that pid 27557 used by ceph-osd was reused for the pyt=
hon script that was killed above. Because the script that kills daemons=
 is very agressive and kill -9 the pid to check if it really is dead
>=20
> https://github.com/ceph/ceph/blob/giant/src/test/mon/mon-test-helpers=
=2Esh#L64
>=20
> it explains the problem.
>=20
> However, as Dan Mick suggests, reusing pid quickly could break a numb=
er of things and it is a surprising behavior. Maybe something else is g=
oing on. A loop creating processes sees their pid increasing and not be=
ing reused.
>=20
> Any idea about what is going on would be much appreciated :-)
>=20
> Cheers
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
