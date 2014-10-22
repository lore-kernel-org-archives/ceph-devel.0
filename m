From: Loic Dachary <loic@dachary.org>
Subject: Re: Can pid be reused ?
Date: Wed, 22 Oct 2014 15:46:20 -0700
Message-ID: <544833BC.4050409@dachary.org>
References: <54471CA6.5040807@dachary.org> <0B26F614-B9E5-4E30-9471-A7F46656AA24@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Onu4saTjpRvo8dvI2uUlI0qx0ONlGvhAP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51091 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932483AbaJVWq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Oct 2014 18:46:29 -0400
In-Reply-To: <0B26F614-B9E5-4E30-9471-A7F46656AA24@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Onu4saTjpRvo8dvI2uUlI0qx0ONlGvhAP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi David,

On 22/10/2014 15:21, David Zafman wrote:>=20
> I just realized what it is.  The way killall is used when stopping a vs=
tart cluster, is to kill all processes by name!  You can't stop vstarted =
tests running in parallel.

I discovered this indeed. But then instead of using ./stop.sh I use

https://github.com/dachary/ceph/blob/6e6ddfbdc0a178a6318a86fd9984265bbe40=
ca3d/src/test/mon/mon-test-helpers.sh#L62

in the context of=20

https://github.com/dachary/ceph/blob/6e6ddfbdc0a178a6318a86fd9984265bbe40=
ca3d/src/test/vstart_wrapper.sh#L28

which makes it kill only the processes with a pid file in the relevant di=
rectory. The problem bellow showed because it was doing an aggressive kil=
l -9 to check if the process still exists.

https://github.com/dachary/ceph/commit/6e6ddfbdc0a178a6318a86fd9984265bbe=
40ca3d

Now that it's replaced with a kill -0 all is well.=20

For the record the problem can be reliably reproduced by running make -j8=
 check from https://github.com/dachary/ceph/commit/c02bb8a5afef8669005c78=
b2b4f2f762cda4ee73 and waiting less than one hour and probably more than =
30 minutes on a 24 core, 64GB RAM, 250GB SSD disk.

Cheers


>=20
> David Zafman
> Senior Developer
> http://www.inktank.com
>=20
>=20
>=20
>=20
>> On Oct 21, 2014, at 7:55 PM, Loic Dachary <loic@dachary.org> wrote:
>>
>> Hi,
>>
>> Something strange happens on fedora20 with linux 3.11.10-301.fc20.x86_=
64. Running make -j8 check on https://github.com/ceph/ceph/pull/2750 a pr=
ocess gets killed from time to time. For instance it shows as
>>
>> TEST_erasure_crush_stripe_width: 124: stripe_width=3D4096
>> TEST_erasure_crush_stripe_width: 125: ./ceph osd pool create pool_eras=
ure 12 12 erasure
>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>> ./test/mon/osd-pool-create.sh: line 120: 27557 Killed                 =
 ./ceph osd pool create pool_erasure 12 12 erasure
>> TEST_erasure_crush_stripe_width: 126: ./ceph --format json osd dump
>> TEST_erasure_crush_stripe_width: 126: tee osd-pool-create/osd.json
>>
>> in the test logs. Note the 27557 Killed . I originally thought it was =
because some ulimit was crossed and set them to very generous / unlimited=
 hard / soft thresholds.
>>
>> core file size          (blocks, -c) 0                                =
                                                    =20
>> data seg size           (kbytes, -d) unlimited                        =
                                                    =20
>> scheduling priority             (-e) 0                                =
                                                    =20
>> file size               (blocks, -f) unlimited                        =
                                                    =20
>> pending signals                 (-i) 515069                           =
                                                    =20
>> max locked memory       (kbytes, -l) unlimited                        =
                                                    =20
>> max memory size         (kbytes, -m) unlimited                        =
                                                    =20
>> open files                      (-n) 400000                           =
                                                    =20
>> pipe size            (512 bytes, -p) 8                                =
                                                    =20
>> POSIX message queues     (bytes, -q) 819200                           =
                                                    =20
>> real-time priority              (-r) 0                                =
                                                    =20
>> stack size              (kbytes, -s) unlimited                        =
                                                    =20
>> cpu time               (seconds, -t) unlimited                        =
                                                    =20
>> max user processes              (-u) unlimited                        =
                                                    =20
>> virtual memory          (kbytes, -v) unlimited                        =
                                                    =20
>> file locks                      (-x) unlimited   =20
>>
>> Benoit Canet suggested that I installed systemtap ( https://www.source=
ware.org/systemtap/wiki/SystemtapOnFedora ) and ran https://sourceware.or=
g/systemtap/examples/process/sigkill.stp to watch what was sending the ki=
ll signal. It showed the following:
>>
>> ...
>> SIGKILL was sent to ceph-osd (pid:27557) by vstart_wrapper. uid:1001
>> SIGKILL was sent to python (pid:27557) by vstart_wrapper. uid:1001
>> ....
>>
>> which suggests that pid 27557 used by ceph-osd was reused for the pyth=
on script that was killed above. Because the script that kills daemons is=
 very agressive and kill -9 the pid to check if it really is dead
>>
>> https://github.com/ceph/ceph/blob/giant/src/test/mon/mon-test-helpers.=
sh#L64
>>
>> it explains the problem.
>>
>> However, as Dan Mick suggests, reusing pid quickly could break a numbe=
r of things and it is a surprising behavior. Maybe something else is goin=
g on. A loop creating processes sees their pid increasing and not being r=
eused.
>>
>> Any idea about what is going on would be much appreciated :-)
>>
>> Cheers
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Onu4saTjpRvo8dvI2uUlI0qx0ONlGvhAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRIM7wACgkQ8dLMyEl6F23daACeMYiIm8adQIysgEtMeKfVCzgs
s3IAoLdTpZJXViC+fro/aEKN+IUmK4P7
=NbzT
-----END PGP SIGNATURE-----

--Onu4saTjpRvo8dvI2uUlI0qx0ONlGvhAP--
