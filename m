From: Loic Dachary <loic@dachary.org>
Subject: Re: Running src/ceph generates python error
Date: Fri, 19 Feb 2016 11:20:41 +0700
Message-ID: <56C69819.5000809@dachary.org>
References: <56C6403C.7060400@digiware.nl> <56C66791.8040005@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54924 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424151AbcBSEUw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Feb 2016 23:20:52 -0500
In-Reply-To: <56C66791.8040005@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I suspect this is something you changed in your branch. Is there a way =
to compare your branch with the current master ?

Cheers

On 19/02/2016 07:53, Willem Jan Withagen wrote:
> On 18-2-2016 23:05, Willem Jan Withagen wrote:
>> I'm trying to run
>=20
> I was not quite complex in my message:
> Running:  test/erasure-code/test-erasure-code.sh
>=20
> And I can get it actually working when I comment out the line:
> ../qa/workunits/ceph-helpers.sh: line 547
>     # ceph_args+=3D" --plugin-dir=3D.libs"
>=20
> But the error seems to be because of an error in the python script
> called then refuses the about --plugin-dir option
>=20
> --WjW
>=20
>> And it terminates with:
>> =3D=3D=3D=3D=3D=3D
>> .......
>> .......
>> ../qa/workunits/ceph-helpers.sh:555: activate_osd:  mkdir -p
>> testdir/test-erasure-code/0
>> ../qa/workunits/ceph-helpers.sh:556: activate_osd:
>> CEPH_ARGS=3D'--fsid=3Dd9e9b487-d5e0-11e5-be15-1c6f6582ec12
>> --auth-supported=3Dnone -
>> -mon-host=3D127.0.0.1:7101  --osd-backfill-full-ratio=3D.99
>> --osd-failsafe-full-ratio=3D.99 --osd-journal-size=3D100 --osd-scrub=
-load-thre
>> shold=3D2000 --osd-data=3Dtestdir/test-erasure-code/0 --chdir=3D
>> --erasure-code-dir=3D.libs --plugin-dir=3D.libs --osd-class-dir=3D.l=
ibs --run
>> -dir=3Dtestdir/test-erasure-code --debug-osd=3D20
>> --log-file=3Dtestdir/test-erasure-code/$name.log
>> --pid-file=3Dtestdir/test-erasure-code/
>> $name.pid  '
>> ../qa/workunits/ceph-helpers.sh:556: activate_osd:  ceph-disk
>> --statedir=3Dtestdir/test-erasure-code --sysconfdir=3Dtestdir/test-e=
rasu
>> re-code --prepend-to-path=3D activate --mark-init=3Dnone
>> testdir/test-erasure-code/0
>> ceph-disk: Error: ceph osd create failed: Command './ceph' returned
>> non-zero exit status 22: --plugin-dir=3D.libs not valid:  --plug
>> in-dir=3D.libs doesn't represent an int
>> Invalid command:  unused arguments: [u'--plugin-dir=3D.libs']
>> osd create {<uuid>} {<int[0-]>} :  create new osd (with optional UUI=
D
>> and ID)
>> Error EINVAL: invalid command
>>
>> =3D=3D=3D=3D=3D=3D
>>
>> So it seems it does not like all the values that are put in the
>> ENV{CEPH_ARGS}.
>>
>> Is this just my problem?
>> And if so, what am I doing wrong?
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
