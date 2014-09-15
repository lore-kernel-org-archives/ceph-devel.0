From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Tools and archive to check for non regression of erasure coded
 content
Date: Mon, 15 Sep 2014 07:27:16 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7C82EB@CERNXCHG44.cern.ch>
References: <54142F89.4060804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:39787 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbaIOH1U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 03:27:20 -0400
In-Reply-To: <54142F89.4060804@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,
I saw (if i am not mistaken) that you actually test only encoding ... s=
o your idea is to guarantee that the encoding results in the same outpu=
t and the encoding/decoding functionality is validated by the unit test=
s in each new version?=20

In principle this restricts the encoding to never change the alignment =
in the future, which might be not optimal. We might get larger register=
s in the future on new CPUs and the alignment might change or they migh=
t deal perfectly with 1-byte alignments. I suggest  to make sure that t=
he new version can decode the old format, but it does not need to imply=
 that it encodes it in exactly the same way ... this is slighly more co=
mplicated however I would feel more comfortable if you would do the bru=
te-force decoding check in this infrastructure for all plug-ins and lea=
ve the flexibility to change the encoding format in the future.

Cheers Andreas.

________________________________________
=46rom: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.=
org] on behalf of Loic Dachary [loic@dachary.org]
Sent: 13 September 2014 13:50
To: Ceph Development
Subject: Tools and archive to check for non regression of erasure coded=
 content

Hi Ceph,

An erasure coded object stored in Firefly when it was first introduced =
must be decoded by all versions after Firefly. The encoding is done by =
erasure code plugins[1] and they evolve over time[2]. There needs to be=
 a tool to check that all content encoded by a given version of the plu=
gin can also be encoded by all subsequent versions of the same plugin.

The general idea is to archive objects created with a given Ceph versio=
n and check them will all subsequent versions, via a teuthology workuni=
t run on all supported distributions and architectures.

The ceph_erasure_code_non_regression command[3] creates an object and s=
tore it on disk or read an object from disk and checks that it can be r=
ead. It is used to create objects for all relevant variations of parame=
ters of a given erasure code plugin. For instance:

ceph_erasure_code_non_regression --stripe-width 4651 --parameter packet=
size=3D32 --plugin jerasure --parameter technique=3Dblaum_roth --parame=
ter k=3D6 --parameter m=3D2 --create --base ../../ceph-erasure-code-cor=
pus/v0.85-764-gf3a1532
ceph_erasure_code_non_regression --stripe-width 4651 --parameter packet=
size=3D32 --plugin jerasure --parameter technique=3Dliber8tion --parame=
ter k=3D6 --parameter m=3D2 --create --base ../../ceph-erasure-code-cor=
pus/v0.85-764-gf3a1532
etc.

The script[4] and the objects are archived in a repository [5] that can=
 be checked by later Ceph versions. The same script is used for checkin=
g and creating the objects so that there is no risk of confusion. These=
 scripts are stored per version because a given script is developed for=
 a given version of the plugins.

The encode-decode-non-regression.sh[6] workunit uses these scripts when=
 run from teuthology[7] and will run all of them, up to and including t=
he currently running ceph version. This ultimately ensures that all arc=
hived objects can be read on all supported distributions and architectu=
res.

See also http://tracker.ceph.com/issues/9420 which is the ticket associ=
ated to this work.

Although this all sound sensible to me right now, I would be very inter=
ested to hear about ideas to make this easier or better :-)

Cheers

[1] firefly erasure code plugins https://github.com/ceph/ceph/tree/fire=
fly/src/erasure-code
[2] giant erasure code plugins https://github.com/ceph/ceph/tree/v0.85/=
src/erasure-code
[3] ceph_erasure_code_non_regression https://github.com/dachary/ceph/co=
mmit/497a82b2b3113dae724a43d8d4c7e430acf44120
[4] non-regression.sh https://github.com/dachary/ceph-erasure-code-corp=
us/blob/master/v0.80.5-226-g71d2562/non-regression.sh
[5] ceph-erasure-code-corpus https://github.com/dachary/ceph-erasure-co=
de-corpus
[6] encode-decode-non-regression.sh https://github.com/dachary/ceph/com=
mit/4f7a9f83fb1f037662861e8782c9b90566dcaa31
[7] non regression workload https://github.com/ceph/ceph-qa-suite/pull/=
136
--
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
