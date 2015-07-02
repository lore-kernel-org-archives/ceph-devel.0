From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Probable memory leak in Hammer write path ?
Date: Thu, 2 Jul 2015 08:36:22 +0200 (CEST)
Message-ID: <354713508.5068184.1435818982240.JavaMail.zimbra@oxygem.tv>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB0142@SACMBXIP01.sdcorp.global.sandisk.com> <CAC6JEv9sfdLtMKjpSJzRxgOjLOMH-kvj0MtA1i4jnCne4FtStA@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB08F9@SACMBXIP01.sdcorp.global.sandisk.com> <CAC6JEv9WmQ5=5Z=bZmMEjMF5o34WkUeabjEzsZujKVS4TNxQ5w@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB4992@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:42963 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbGBGgY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jul 2015 02:36:24 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB4992@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>So, this could be another step ahead of removing tcmalloc as Ceph's d=
efault allocator and moving to jemalloc.

+1 for this.

I begin to be worried by all theses tcmalloc problems.


----- Mail original -----
De: "Somnath Roy" <Somnath.Roy@sandisk.com>
=C3=80: "Gregory Farnum" <greg@gregs42.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Jeudi 2 Juillet 2015 05:38:24
Objet: RE: Probable memory leak in Hammer write path ?

Hi,=20
I think I am eventually able to figure out what is happening.. First, h=
ere is the step to reproduce it in any kernel (not specific to 3.16/3.1=
8 as I said earlier)=20

1. In a SSD create a big journal partition say > 20 GB or so.=20

2. Make all the filestore/journal parameter default other than the foll=
owing. Set these value in your conf file. This is just to make sure jou=
rnal writes are not throttled and going far ahead than backend writes.=20

filestore_queue_max_ops =3D 5000000=20
filestore_queue_max_bytes =3D 1000000000000=20
filestore_queue_committing_max_ops =3D 5000000=20
filestore_queue_committing_max_bytes =3D 1000000000000=20

3. Run any release say Firefly/Giant/Hammer and create a single OSD clu=
ster giving rest of the SSD as data partition.=20

4. Run say fio_rbd random write workload as 16K, QD 64 , num_jobs=3D8=20

5. run 'dstat -m' and see how used memory is rising !=20

Now, this behavior I found with glibcmalloc/tcmalloc/jemalloc and that =
I communicated earlier. But, I didn't wait enough earlier to see if mem=
ory is coming down when IO stopped :-)=20
I saw in case of tcmalloc it is not coming down , *but* in case of jema=
lloc it is *coming down* the following way to the old place. I didn't g=
o back to glibcmalloc again, but, it should be releasing also..=20

1. If I stop IO, journal write stops, but backend flash is catching up =
and the memory is coming down accordingly. This is expected because all=
 the transactions are piling up in workQ while journal is way ahead, bu=
t, the moment it is processed the transactions are deleted and memory u=
sage coming down.=20

2. After journal is full, it started throttling and the overall IO rate=
 is coming down. The backend flash now has the opportunity to catch up =
and thus releasing the memory.=20

None of the above is happening in case of tcmalloc. There it is not rel=
easing the memory at all..Digging down some of the doc I found out this=
 can happen and there is a flag to control the release rate..But, no lu=
ck after changing that as well..Didn't invest much time on that though.=
=20
What I saw next time when I ran IO, in case of tcmalloc the memory is n=
ot rising at the beginning, probably, it is reusing those memory and st=
arted rising again after some time...But, I doubt this behavior is good=
=2E.=20

So, this could be another step ahead of removing tcmalloc as Ceph's def=
ault allocator and moving to jemalloc.=20

Thanks Greg for asking me to relook at tcmalloc otherwise I was kind of=
 out of option :-)..=20

Regards=20
Somnath=20

-----Original Message-----=20
=46rom: Somnath Roy=20
Sent: Wednesday, July 01, 2015 4:58 PM=20
To: 'Gregory Farnum'=20
Cc: ceph-devel@vger.kernel.org=20
Subject: RE: Probable memory leak in Hammer write path ?=20

Thanks Greg!=20
Yeah, I will double check..But, I built the code without tcmalloc (with=
 glibc) and it was also showing the similar behavior.=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: Gregory Farnum [mailto:greg@gregs42.com]=20
Sent: Wednesday, July 01, 2015 9:07 AM=20
To: Somnath Roy=20
Cc: ceph-devel@vger.kernel.org=20
Subject: Re: Probable memory leak in Hammer write path ?=20

On Mon, Jun 29, 2015 at 4:39 PM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:=20
> Greg,=20
> Updating to the new kernel updating the gcc version too. Recent kerne=
l is changing tcmalloc version too, but, 3.16 has old tcmalloc but stil=
l exhibiting the issue.=20
> Yes, the behavior is very confusing and compiler is main variable I c=
ould think of from application perspective.=20
> If you have a 3.16/3.19 kernel, you could reproduce this following th=
ese steps.=20
>=20
> 1. Build ceph-hammer code base=20
>=20
> 2. Run with single OSD.=20
>=20
> 3. Create an image and run a fio-bed workload from client (say 16K bs=
,=20
> 8 num_jobs)=20
>=20
> 4. run 'dstat -m' and observe the memory usage.=20
>=20
> What I am thinking of doing is to install ceph from ceph.com and see =
the behavior.=20

In addition to that, I'd look for if there are any known bugs in the tc=
malloc version you're using on the leaky systems, and check the tcmallo=
c stats to see if they have a bunch of free memory which hasn't been re=
leased to the OS yet.=20
-Greg=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=
=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=BD=
f=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=BF=
=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=
=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!=EF=BF=BDi=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
