From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] EC pool errors with some k/m combinations
Date: Wed, 18 Jun 2014 17:30:20 +0200
Message-ID: <53A1B08C.10800@dachary.org>
References: <alpine.LFD.2.03.1403292258150.8259@tnld.net>	<5337FFD7.4080102@dachary.org>	<alpine.LFD.2.03.1403310103050.11536@tnld.net>	<alpine.LFD.2.03.1404010004450.13251@tnld.net> <CAKD2hyEhMvMQDcSUmyxtBaOOREk9FS51msRwG0kLyu6PQA6RyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wolHbflrcBBe06dQIefSeUAvTkGhrWcab"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:48420 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaFRPal (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jun 2014 11:30:41 -0400
In-Reply-To: <CAKD2hyEhMvMQDcSUmyxtBaOOREk9FS51msRwG0kLyu6PQA6RyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?TGx1w61zIFDDoG1pZXMgaSBKdcOhcmV6?= <llpamies@pamies.cat>, Michael Nelson <mn+ceph-users@tnld.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wolHbflrcBBe06dQIefSeUAvTkGhrWcab
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Llu=C3=ADs,

Here is a minimal test that verifies your patch works (and will prevent r=
egression). It fails without your patch. Feel free to cherry-pick it in y=
our pull request.

erasure-code: verify that rados put enforces alignment

http://tracker.ceph.com/issues/8622 refs: #8622

Signed-off-by: Loic Dachary <loic@dachary.org>
---
 src/test/erasure-code/test-erasure-code.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/test/erasure-code/test-erasure-code.sh b/src/test/erasur=
e-code/test-erasure-code.sh
index b779f68..ba0d43a 100755
--- a/src/test/erasure-code/test-erasure-code.sh
+++ b/src/test/erasure-code/test-erasure-code.sh
@@ -60,6 +60,17 @@ function TEST_rados_put() {
     diff $dir/ORIGINAL $dir/COPY || return 1
=20
     rm $dir/ORIGINAL $dir/COPY
+
+    #=20
+    # Verify that the rados command enforces alignment constraints
+    # imposed by the stripe width
+    # See http://tracker.ceph.com/issues/8622
+    #
+    local stripe_width=3D$(./ceph-conf --show-config-value osd_pool_eras=
ure_code_stripe_width)
+    local block_size=3D$((stripe_width - 1))
+    dd if=3D/dev/zero of=3D$dir/ORIGINAL bs=3D$block_size count=3D2
+    ./rados --block-size=3D$block_size \
+        --pool ecpool put UNALIGNED $dir/ORIGINAL || return 1
 }
=20
 main test-erasure-code

Cheers

On 17/06/2014 20:23, Llu=C3=ADs P=C3=A0mies i Ju=C3=A1rez wrote:
> Michael, Loic,
>=20
> I'm having similar issues with certain (k,m) combinations when storing
> objects larger than 4MB. Since this thread is relatively old I was
> wondering if anyone had fixed it or at least has identified this bug.
> Any news?
>=20
> Lluis
>=20
> On Mon, Mar 31, 2014 at 5:08 PM, Michael Nelson <mn+ceph-users@tnld.net=
> wrote:
>>
>>
>> On Mon, 31 Mar 2014, Michael Nelson wrote:
>>
>>> Hi Loic,
>>>
>>> On Sun, 30 Mar 2014, Loic Dachary wrote:
>>>
>>>> Hi Michael,
>>>>
>>>> I'm trying to reproduce the problem from sources (today's instead of=

>>>> yesterday's but there is no difference that could explain the behavi=
our you
>>>> have):
>>>>
>>>> cd src
>>>> rm -fr /tmp/dev /tmp/out ;  mkdir -p /tmp/dev ; CEPH_DIR=3D/tmp LC_A=
LL=3DC
>>>> MON=3D1 OSD=3D6 bash -x ./vstart.sh -d -n -X -l mon osd
>>>> ceph osd erasure-code-profile set profile33 ruleset-failure-domain=3D=
osd
>>>> k=3D3 m=3D3
>>>> ceph osd crush rule create-erasure ecruleset33 profile33
>>>> ceph osd pool create testec-33 20 20 erasure profile33 ecruleset33
>>>> ./rados --pool testec-33 put SOMETHING  /etc/group
>>>>
>>>> but it succeeds. Could you please script a minimal set of commands I=

>>>> could run to repeat the problem you're seeing ?
>>>
>>>
>>> The file that I put into the pool was 15MB in size and the error occu=
rred
>>> after the first 4MB chunk. That might be the difference.
>>>
>>> I will try to come up with a list of commands in case that doesn't tr=
igger
>>> it for you.
>>
>>
>> Here is a concise version of what I am deploying with (limited to 6 OS=
Ds in
>> this example).
>>
>> ceph-deploy new c1 c2 c3
>> pdsh -wc[1-3] yum -y install ceph
>> ceph-deploy mon create c1 c2 c3
>> sleep 30
>>
>> cd /etc/ceph
>> ceph-deploy gatherkeys c1 c2 c3
>>
>> machines=3D(c1 c2 c3)
>>
>> for machine in ${machines[@]}; do
>>         for n in {1..2}; do
>>                 ssh root@$machine 'rm -rf /data$n/osd$n && mkdir -p
>> /data$n/osd$n'
>>                 ssh root@$machine 'rm -rf /journals/journal-osd$n'
>>                 ceph-deploy osd prepare
>> $machine:/data$n/osd$n:/journals/journal-osd$n
>>                 ceph-deploy osd activate
>> $machine:/data$n/osd$n:/journals/journal-osd$n
>>         done
>> done
>>
>> # Wait for OSDs to settle
>> sleep 60
>>
>>
>> ceph osd erasure-code-profile set profile33 ruleset-failure-domain=3Do=
sd k=3D3
>> m=3D3
>> ceph osd crush rule create-erasure ecruleset33 profile33
>> ceph osd pool create ectest-33 20 20 erasure profile33 ecruleset33
>>
>> root@c1:~/ceph# rados -p ectest-33 put xyz sampledata
>> error putting ectest-33/xyz: Operation not supported
>>
>> root@c1:~/ceph# du -h sampledata
>> 15M     sampledata
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--wolHbflrcBBe06dQIefSeUAvTkGhrWcab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOhsI0ACgkQ8dLMyEl6F22alQCeMg/AnSxdqFO0KrJJ0ZnOJ+np
NIAAoIF+zxB+8IMTH+PMikoRycctY8Lw
=Bt2z
-----END PGP SIGNATURE-----

--wolHbflrcBBe06dQIefSeUAvTkGhrWcab--
