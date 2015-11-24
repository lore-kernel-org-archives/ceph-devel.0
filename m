From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: [newstore (again)] how disable double write WAL
Date: Tue, 24 Nov 2015 12:42:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-594944368-1448397726=:25734"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42945 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbbKXUmT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Nov 2015 15:42:19 -0500
In-Reply-To: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
Content-ID: <alpine.DEB.2.00.1511241242100.25734@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?S=E9bastien_VALSEMEY?= <sebastien.valsemey@aevoo.fr>
Cc: Vish Maram-SSI <vishwanath.m@ssi.samsung.com>, Ceph Development <ceph-devel@vger.kernel.org>, David CASIER <david.casier@aevoo.fr>, =?ISO-8859-15?Q?Beno=EEt_LORIOT?= <benoit.loriot@aevoo.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-594944368-1448397726=:25734
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.DEB.2.00.1511241242101.25734@cobra.newdream.net>
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Nov 2015, S=E9bastien VALSEMEY wrote:
> Hello Vish,
>=20
> Please apologize for the delay in my answer.
> Following the conversation you had with my colleague David, here are=20
> some more details about our work :
>=20
> We are working on Filestore / Newstore optimizations by studying how we=
=20
> could set ourselves free from using the journal.
>=20
> It is very important to work with SSD, but it is also mandatory to=20
> combine it with regular magnetic platter disks. This is why we are=20
> combining metadata storing on flash with data storing on disk.

This is pretty common, and something we will support natively with=20
newstore.
=20
> Our main goal is to have the control on performance. Which is quite=20
> difficult with NewStore, and needs fundamental hacks with FileStore.

Can you clarify what you mean by "quite difficult with NewStore"?

FWIW, the latest bleeding edge code is currently at=20
github.com/liewegas/wip-bluestore.

sage


> Is Samsung working on ARM boards with embedded flash and a SATA port, i=
n=20
> order to allow us to work on a hybrid approach? What is your line of=20
> work with Ceph?
>=20
> How can we work together ?
>=20
> Regards,
> S=E9bastien
>=20
> > D=E9but du message r=E9exp=E9di=E9 :
> >=20
> > De: David Casier <david.casier@aevoo.fr>
> > Date: 12 octobre 2015 20:52:26 UTC+2
> > =C0: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger=
.kernel.org>
> > Cc: S=E9bastien VALSEMEY <sebastien.valsemey@aevoo.fr>, benoit.loriot=
@aevoo.fr, Denis Saget <geodni@gmail.com>, "luc.petetin" <luc.petetin@aev=
oo.fr>
> > Objet: R=E9p : Fwd: [newstore (again)] how disable double write WAL
> >=20
> > Ok,
> > Great.
> >=20
> > With these  settings :
> > //
> > newstore_max_dir_size =3D 4096
> > newstore_sync_io =3D true
> > newstore_sync_transaction =3D true
> > newstore_sync_submit_transaction =3D true
> > newstore_sync_wal_apply =3D true
> > newstore_overlay_max =3D 0
> > //
> >=20
> > And direct IO in the benchmark tool (fio)
> >=20
> > I see that the HDD is 100% charged and there are notransfer of /db to=
 /fragments after stopping benchmark : Great !
> >=20
> > But when i launch a bench with random blocs of 256k, i see random blo=
cs between 32k and 256k on HDD. Any idea ?
> >=20
> > Debits to the HDD are about 8MBps when they could be higher with larg=
er blocs (~30MBps)
> > And 70 MBps without fsync (hard drive cache disabled).
> >=20
> > Other questions :
> > newstore_sync_io -> true =3D fsync immediatly, false =3D fsync later =
(Thread fsync_wq) ?
> > newstore_sync_transaction -> true =3D sync in DB ?
> > newstore_sync_submit_transaction -> if false then kv_queue (only if n=
ewstore_sync_transaction=3Dfalse) ?
> > newstore_sync_wal_apply =3D true -> if false then WAL later (thread w=
al_wq) ?
> >=20
> > Is it true ?
> >=20
> > Way for cache with battery (sync DB and no sync data) ?
> >=20
> > Thanks for everything !
> >=20
> > On 10/12/2015 03:01 PM, Sage Weil wrote:
> >> On Mon, 12 Oct 2015, David Casier wrote:
> >>> Hello everybody,
> >>> fragment is stored in rocksdb before being written to "/fragments" =
?
> >>> I separed "/db" and "/fragments" but during the bench, everything i=
s writing
> >>> to "/db"
> >>> I changed options "newstore_sync_*" without success.
> >>>=20
> >>> Is there any way to write all metadata in "/db" and all data in "/f=
ragments" ?
> >> You can set newstore_overlay_max =3D 0 to avoid most data landing in=
 db/.
> >> But if you are overwriting an existing object, doing write-ahead log=
ging
> >> is usually unavoidable because we need to make the update atomic (an=
d the
> >> underlying posix fs doesn't provide that).  The wip-newstore-frags b=
ranch
> >> mitigates this somewhat for larger writes by limiting fragment size,=
 but
> >> for small IOs this is pretty much always going to be the case.  For =
small
> >> IOs, though, putting things in db/ is generally better since we can
> >> combine many small ios into a single (rocksdb) journal/wal write.  A=
nd
> >> often leave them there (via the 'overlay' behavior).
> >>=20
> >> sage
> >>=20
> >=20
> >=20
> > --=20
> > ________________________________________________________
> >=20
> > Cordialement,
> >=20
> > *David CASIER
> > DCConsulting SARL
> >=20
> >=20
> > 4 Trait d'Union
> > 77127 LIEUSAINT
> >=20
> > **Ligne directe: _01 75 98 53 85_
> > Email: _david.casier@aevoo.fr_
> > * ________________________________________________________
> > D=E9but du message r=E9exp=E9di=E9 :
> >=20
> > De: David Casier <david.casier@aevoo.fr>
> > Date: 2 novembre 2015 20:02:37 UTC+1
> > =C0: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.com>
> > Cc: benoit LORIOT <benoit.loriot@aevoo.fr>, S=E9bastien VALSEMEY <seb=
astien.valsemey@aevoo.fr>
> > Objet: R=E9p : Fwd: [newstore (again)] how disable double write WAL
> >=20
> > Hi Vish,
> > In FileStore, data and metadata are stored in files, with xargs FS an=
d omap.
> > NewStore works with RocksDB.
> > There are a lot of configuration in RocksDB but all options not imple=
mented.
> >=20
> > The best way, for me, is not to use the logs, with secure cache (for =
example SSD 845DC).
> > I don't think that is necessary to report I/O with a good metadata op=
timisation.
> >=20
> > The problem with RocksDB is that not possible to control I/O blocs si=
ze.
> >=20
> > We will resume work on NewStore soon.=20
> >=20
> > On 10/29/2015 05:30 PM, Vish (Vishwanath) Maram-SSI wrote:
> >> Thanks David for the reply.
> >> =20
> >> Yeah We just wanted to know how different is it from Filestore and h=
ow do we contribute for this? My motive is to first understand the design=
 of Newstore and get the Performance loopholes so that we can try looking=
 into it.
> >> =20
> >> It would be helpful if you can share what is your idea from your sid=
e to use Newstore and configuration? What plans you are having for contri=
butions to help us understand and see if we can work together.
> >> =20
> >> Thanks,
> >> -Vish
> >> =A0 <>
> >> From: David Casier [mailto:david.casier@aevoo.fr <mailto:david.casie=
r@aevoo.fr>]=20
> >> Sent: Thursday, October 29, 2015 4:41 AM
> >> To: Vish (Vishwanath) Maram-SSI
> >> Cc: benoit LORIOT; S=E9bastien VALSEMEY
> >> Subject: Re: Fwd: [newstore (again)] how disable double write WAL
> >> =20
> >> Hi Vish,
> >> It's OK.
> >>=20
> >> We have a lot of different configuration with newstore tests.
> >>=20
> >> What is your goal with ?
> >>=20
> >> On 10/28/2015 11:02 PM, Vish (Vishwanath) Maram-SSI wrote:
> >> Hi David,
> >> =20
> >> Sorry for sending you the mail directly.
> >> =20
> >> This is Vishwanath Maram from Samsung and started to play around wit=
h Newstore and observing some issues with running FIO.
> >> =20
> >> Can you please share your Ceph Configuration file which you have use=
d to run the IO's using FIO?
> >> =20
> >> Thanks,
> >> -Vish
> >> =20
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-owner@vger=
.kernel.org> [mailto:ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-=
owner@vger.kernel.org>] On Behalf Of David Casier
> >> Sent: Monday, October 12, 2015 11:52 AM
> >> To: Sage Weil; Ceph Development
> >> Cc: S=E9bastien VALSEMEY; benoit.loriot@aevoo.fr <mailto:benoit.lori=
ot@aevoo.fr>; Denis Saget; luc.petetin
> >> Subject: Re: Fwd: [newstore (again)] how disable double write WAL
> >> =20
> >> Ok,
> >> Great.
> >> =20
> >> With these  settings :
> >> //
> >> newstore_max_dir_size =3D 4096
> >> newstore_sync_io =3D true
> >> newstore_sync_transaction =3D true
> >> newstore_sync_submit_transaction =3D true
> >> newstore_sync_wal_apply =3D true
> >> newstore_overlay_max =3D 0
> >> //
> >> =20
> >> And direct IO in the benchmark tool (fio)
> >> =20
> >> I see that the HDD is 100% charged and there are notransfer of /db t=
o=20
> >> /fragments after stopping benchmark : Great !
> >> =20
> >> But when i launch a bench with random blocs of 256k, i see random bl=
ocs=20
> >> between 32k and 256k on HDD. Any idea ?
> >> =20
> >> Debits to the HDD are about 8MBps when they could be higher with lar=
ger=20
> >> blocs (~30MBps)
> >> And 70 MBps without fsync (hard drive cache disabled).
> >> =20
> >> Other questions :
> >> newstore_sync_io -> true =3D fsync immediatly, false =3D fsync later=
 (Thread=20
> >> fsync_wq) ?
> >> newstore_sync_transaction -> true =3D sync in DB ?
> >> newstore_sync_submit_transaction -> if false then kv_queue (only if=20
> >> newstore_sync_transaction=3Dfalse) ?
> >> newstore_sync_wal_apply =3D true -> if false then WAL later (thread =
wal_wq) ?
> >> =20
> >> Is it true ?
> >> =20
> >> Way for cache with battery (sync DB and no sync data) ?
> >> =20
> >> Thanks for everything !
> >> =20
> >> On 10/12/2015 03:01 PM, Sage Weil wrote:
> >> On Mon, 12 Oct 2015, David Casier wrote:
> >> Hello everybody,
> >> fragment is stored in rocksdb before being written to "/fragments" ?
> >> I separed "/db" and "/fragments" but during the bench, everything is=
 writing
> >> to "/db"
> >> I changed options "newstore_sync_*" without success.
> >> =20
> >> Is there any way to write all metadata in "/db" and all data in "/fr=
agments" ?
> >> You can set newstore_overlay_max =3D 0 to avoid most data landing in=
 db/.
> >> But if you are overwriting an existing object, doing write-ahead log=
ging
> >> is usually unavoidable because we need to make the update atomic (an=
d the
> >> underlying posix fs doesn't provide that).  The wip-newstore-frags b=
ranch
> >> mitigates this somewhat for larger writes by limiting fragment size,=
 but
> >> for small IOs this is pretty much always going to be the case.  For =
small
> >> IOs, though, putting things in db/ is generally better since we can
> >> combine many small ios into a single (rocksdb) journal/wal write.  A=
nd
> >> often leave them there (via the 'overlay' behavior).
> >> =20
> >> sage
> >> =20
> >> =20
> >> =20
> >> =20
> >>=20
> >> --=20
> >> ________________________________________________________=20
> >>=20
> >> Cordialement,
> >>=20
> >> David CASIER
> >>=20
> >>=20
> >> 4 Trait d'Union
> >> 77127 LIEUSAINT
> >>=20
> >> Ligne directe: 01 75 98 53 85
> >> Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> >> ________________________________________________________
> >=20
> >=20
> > --=20
> > ________________________________________________________=20
> >=20
> > Cordialement,
> >=20
> > David CASIER
> >=20
> > =20
> > 4 Trait d'Union
> > 77127 LIEUSAINT
> >=20
> > Ligne directe: 01 75 98 53 85
> > Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > ________________________________________________________
> > D=E9but du message r=E9exp=E9di=E9 :
> >=20
> > De: Sage Weil <sage@newdream.net>
> > Date: 12 octobre 2015 21:33:52 UTC+2
> > =C0: David Casier <david.casier@aevoo.fr>
> > Cc: Ceph Development <ceph-devel@vger.kernel.org>, S=E9bastien VALSEM=
EY <sebastien.valsemey@aevoo.fr>, benoit.loriot@aevoo.fr, Denis Saget <ge=
odni@gmail.com>, "luc.petetin" <luc.petetin@aevoo.fr>
> > Objet: R=E9p : Fwd: [newstore (again)] how disable double write WAL
> >=20
> > Hi David-
> >=20
> > On Mon, 12 Oct 2015, David Casier wrote:
> >> Ok,
> >> Great.
> >>=20
> >> With these  settings :
> >> //
> >> newstore_max_dir_size =3D 4096
> >> newstore_sync_io =3D true
> >> newstore_sync_transaction =3D true
> >> newstore_sync_submit_transaction =3D true
> >=20
> > Is this a hard disk?  Those settings probably don't make sense since =
it=20
> > does every IO synchronously, blocking the submitting IO path...
> >=20
> >> newstore_sync_wal_apply =3D true
> >> newstore_overlay_max =3D 0
> >> //
> >>=20
> >> And direct IO in the benchmark tool (fio)
> >>=20
> >> I see that the HDD is 100% charged and there are notransfer of /db t=
o
> >> /fragments after stopping benchmark : Great !
> >>=20
> >> But when i launch a bench with random blocs of 256k, i see random bl=
ocs
> >> between 32k and 256k on HDD. Any idea ?
> >=20
> > Random IOs have to be write ahead logged in rocksdb, which has its ow=
n IO=20
> > pattern.  Since you made everything sync above I think it'll depend o=
n=20
> > how many osd threads get batched together at a time.. maybe.  Those=20
> > settings aren't something I've really tested, and probably only make=20
> > sense with very fast NVMe devices.
> >=20
> >> Debits to the HDD are about 8MBps when they could be higher with lar=
ger blocs> (~30MBps)
> >> And 70 MBps without fsync (hard drive cache disabled).
> >>=20
> >> Other questions :
> >> newstore_sync_io -> true =3D fsync immediatly, false =3D fsync later=
 (Thread
> >> fsync_wq) ?
> >=20
> > yes
> >=20
> >> newstore_sync_transaction -> true =3D sync in DB ?
> >=20
> > synchronously do the rocksdb commit too
> >=20
> >> newstore_sync_submit_transaction -> if false then kv_queue (only if
> >> newstore_sync_transaction=3Dfalse) ?
> >=20
> > yeah.. there is an annoying rocksdb behavior that makes an async=20
> > transaction submit block if a sync one is in progress, so this queues=
 them=20
> > up and explicitly batches them.
> >=20
> >> newstore_sync_wal_apply =3D true -> if false then WAL later (thread =
wal_wq) ?
> >=20
> > the txn commit completion threads can do the wal work synchronously..=
 this=20
> > is only a good idea if it's doing aio (which it generally is).
> >=20
> >> Is it true ?
> >>=20
> >> Way for cache with battery (sync DB and no sync data) ?
> >=20
> > ?
> > s
> >=20
> >>=20
> >> Thanks for everything !
> >>=20
> >> On 10/12/2015 03:01 PM, Sage Weil wrote:
> >>> On Mon, 12 Oct 2015, David Casier wrote:
> >>>> Hello everybody,
> >>>> fragment is stored in rocksdb before being written to "/fragments"=
 ?
> >>>> I separed "/db" and "/fragments" but during the bench, everything =
is
> >>>> writing
> >>>> to "/db"
> >>>> I changed options "newstore_sync_*" without success.
> >>>>=20
> >>>> Is there any way to write all metadata in "/db" and all data in
> >>>> "/fragments" ?
> >>> You can set newstore_overlay_max =3D 0 to avoid most data landing i=
n db/.
> >>> But if you are overwriting an existing object, doing write-ahead lo=
gging
> >>> is usually unavoidable because we need to make the update atomic (a=
nd the
> >>> underlying posix fs doesn't provide that).  The wip-newstore-frags =
branch
> >>> mitigates this somewhat for larger writes by limiting fragment size=
, but
> >>> for small IOs this is pretty much always going to be the case.  For=
 small
> >>> IOs, though, putting things in db/ is generally better since we can
> >>> combine many small ios into a single (rocksdb) journal/wal write.  =
And
> >>> often leave them there (via the 'overlay' behavior).
> >>>=20
> >>> sage
> >>>=20
> >>=20
> >>=20
> >> --=20
> >> ________________________________________________________
> >>=20
> >> Cordialement,
> >>=20
> >> *David CASIER
> >> DCConsulting SARL
> >>=20
> >>=20
> >> 4 Trait d'Union
> >> 77127 LIEUSAINT
> >>=20
> >> **Ligne directe: _01 75 98 53 85_
> >> Email: _david.casier@aevoo.fr_
> >> * ________________________________________________________
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>=20
> >>=20
> > D=E9but du message r=E9exp=E9di=E9 :
> >=20
> > De: David Casier <david.casier@aevoo.fr>
> > Date: 29 octobre 2015 12:41:22 UTC+1
> > =C0: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.com>
> > Cc: benoit LORIOT <benoit.loriot@aevoo.fr>, S=E9bastien VALSEMEY <seb=
astien.valsemey@aevoo.fr>
> > Objet: R=E9p : Fwd: [newstore (again)] how disable double write WAL
> >=20
> > Hi Vish,
> > It's OK.
> >=20
> > We have a lot of different configuration with newstore tests.
> >=20
> > What is your goal with ?
> >=20
> > On 10/28/2015 11:02 PM, Vish (Vishwanath) Maram-SSI wrote:
> >> Hi David,
> >>=20
> >> Sorry for sending you the mail directly.
> >>=20
> >> This is Vishwanath Maram from Samsung and started to play around wit=
h Newstore and observing some issues with running FIO.
> >>=20
> >> Can you please share your Ceph Configuration file which you have use=
d to run the IO's using FIO?
> >>=20
> >> Thanks,
> >> -Vish
> >>=20
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-owner@vger=
.kernel.org> [mailto:ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-=
owner@vger.kernel.org>] On Behalf Of David Casier
> >> Sent: Monday, October 12, 2015 11:52 AM
> >> To: Sage Weil; Ceph Development
> >> Cc: S=E9bastien VALSEMEY; benoit.loriot@aevoo.fr <mailto:benoit.lori=
ot@aevoo.fr>; Denis Saget; luc.petetin
> >> Subject: Re: Fwd: [newstore (again)] how disable double write WAL
> >>=20
> >> Ok,
> >> Great.
> >>=20
> >> With these  settings :
> >> //
> >> newstore_max_dir_size =3D 4096
> >> newstore_sync_io =3D true
> >> newstore_sync_transaction =3D true
> >> newstore_sync_submit_transaction =3D true
> >> newstore_sync_wal_apply =3D true
> >> newstore_overlay_max =3D 0
> >> //
> >>=20
> >> And direct IO in the benchmark tool (fio)
> >>=20
> >> I see that the HDD is 100% charged and there are notransfer of /db t=
o=20
> >> /fragments after stopping benchmark : Great !
> >>=20
> >> But when i launch a bench with random blocs of 256k, i see random bl=
ocs=20
> >> between 32k and 256k on HDD. Any idea ?
> >>=20
> >> Debits to the HDD are about 8MBps when they could be higher with lar=
ger=20
> >> blocs (~30MBps)
> >> And 70 MBps without fsync (hard drive cache disabled).
> >>=20
> >> Other questions :
> >> newstore_sync_io -> true =3D fsync immediatly, false =3D fsync later=
 (Thread=20
> >> fsync_wq) ?
> >> newstore_sync_transaction -> true =3D sync in DB ?
> >> newstore_sync_submit_transaction -> if false then kv_queue (only if=20
> >> newstore_sync_transaction=3Dfalse) ?
> >> newstore_sync_wal_apply =3D true -> if false then WAL later (thread =
wal_wq) ?
> >>=20
> >> Is it true ?
> >>=20
> >> Way for cache with battery (sync DB and no sync data) ?
> >>=20
> >> Thanks for everything !
> >>=20
> >> On 10/12/2015 03:01 PM, Sage Weil wrote:
> >>> On Mon, 12 Oct 2015, David Casier wrote:
> >>>> Hello everybody,
> >>>> fragment is stored in rocksdb before being written to "/fragments"=
 ?
> >>>> I separed "/db" and "/fragments" but during the bench, everything =
is writing
> >>>> to "/db"
> >>>> I changed options "newstore_sync_*" without success.
> >>>>=20
> >>>> Is there any way to write all metadata in "/db" and all data in "/=
fragments" ?
> >>> You can set newstore_overlay_max =3D 0 to avoid most data landing i=
n db/.
> >>> But if you are overwriting an existing object, doing write-ahead lo=
gging
> >>> is usually unavoidable because we need to make the update atomic (a=
nd the
> >>> underlying posix fs doesn't provide that).  The wip-newstore-frags =
branch
> >>> mitigates this somewhat for larger writes by limiting fragment size=
, but
> >>> for small IOs this is pretty much always going to be the case.  For=
 small
> >>> IOs, though, putting things in db/ is generally better since we can
> >>> combine many small ios into a single (rocksdb) journal/wal write.  =
And
> >>> often leave them there (via the 'overlay' behavior).
> >>>=20
> >>> sage
> >>>=20
> >>=20
> >=20
> >=20
> > --=20
> > ________________________________________________________=20
> >=20
> > Cordialement,
> >=20
> > David CASIER
> >=20
> > =20
> > 4 Trait d'Union
> > 77127 LIEUSAINT
> >=20
> > Ligne directe: 01 75 98 53 85
> > Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > ________________________________________________________
> > D=E9but du message r=E9exp=E9di=E9 :
> >=20
> > De: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.com>
> > Date: 29 octobre 2015 17:30:56 UTC+1
> > =C0: David Casier <david.casier@aevoo.fr>
> > Cc: benoit LORIOT <benoit.loriot@aevoo.fr>, S=E9bastien VALSEMEY <seb=
astien.valsemey@aevoo.fr>
> > Objet: RE: Fwd: [newstore (again)] how disable double write WAL
> >=20
> > Thanks David for the reply.
> > =20
> > Yeah We just wanted to know how different is it from Filestore and ho=
w do we contribute for this? My motive is to first understand the design =
of Newstore and get the Performance loopholes so that we can try looking =
into it.
> > =20
> > It would be helpful if you can share what is your idea from your side=
 to use Newstore and configuration? What plans you are having for contrib=
utions to help us understand and see if we can work together.
> > =20
> > Thanks,
> > -Vish
> > =A0 <>
> > From: David Casier [mailto:david.casier@aevoo.fr]=20
> > Sent: Thursday, October 29, 2015 4:41 AM
> > To: Vish (Vishwanath) Maram-SSI
> > Cc: benoit LORIOT; S=E9bastien VALSEMEY
> > Subject: Re: Fwd: [newstore (again)] how disable double write WAL
> > =20
> > Hi Vish,
> > It's OK.
> >=20
> > We have a lot of different configuration with newstore tests.
> >=20
> > What is your goal with ?
> >=20
> > On 10/28/2015 11:02 PM, Vish (Vishwanath) Maram-SSI wrote:
> > Hi David,
> > =20
> > Sorry for sending you the mail directly.
> > =20
> > This is Vishwanath Maram from Samsung and started to play around with=
 Newstore and observing some issues with running FIO.
> > =20
> > Can you please share your Ceph Configuration file which you have used=
 to run the IO's using FIO?
> > =20
> > Thanks,
> > -Vish
> > =20
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-owner@vger.=
kernel.org> [mailto:ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-o=
wner@vger.kernel.org>] On Behalf Of David Casier
> > Sent: Monday, October 12, 2015 11:52 AM
> > To: Sage Weil; Ceph Development
> > Cc: S=E9bastien VALSEMEY; benoit.loriot@aevoo.fr <mailto:benoit.lorio=
t@aevoo.fr>; Denis Saget; luc.petetin
> > Subject: Re: Fwd: [newstore (again)] how disable double write WAL
> > =20
> > Ok,
> > Great.
> > =20
> > With these  settings :
> > //
> > newstore_max_dir_size =3D 4096
> > newstore_sync_io =3D true
> > newstore_sync_transaction =3D true
> > newstore_sync_submit_transaction =3D true
> > newstore_sync_wal_apply =3D true
> > newstore_overlay_max =3D 0
> > //
> > =20
> > And direct IO in the benchmark tool (fio)
> > =20
> > I see that the HDD is 100% charged and there are notransfer of /db to=
=20
> > /fragments after stopping benchmark : Great !
> > =20
> > But when i launch a bench with random blocs of 256k, i see random blo=
cs=20
> > between 32k and 256k on HDD. Any idea ?
> > =20
> > Debits to the HDD are about 8MBps when they could be higher with larg=
er=20
> > blocs (~30MBps)
> > And 70 MBps without fsync (hard drive cache disabled).
> > =20
> > Other questions :
> > newstore_sync_io -> true =3D fsync immediatly, false =3D fsync later =
(Thread=20
> > fsync_wq) ?
> > newstore_sync_transaction -> true =3D sync in DB ?
> > newstore_sync_submit_transaction -> if false then kv_queue (only if=20
> > newstore_sync_transaction=3Dfalse) ?
> > newstore_sync_wal_apply =3D true -> if false then WAL later (thread w=
al_wq) ?
> > =20
> > Is it true ?
> > =20
> > Way for cache with battery (sync DB and no sync data) ?
> > =20
> > Thanks for everything !
> > =20
> > On 10/12/2015 03:01 PM, Sage Weil wrote:
> > On Mon, 12 Oct 2015, David Casier wrote:
> > Hello everybody,
> > fragment is stored in rocksdb before being written to "/fragments" ?
> > I separed "/db" and "/fragments" but during the bench, everything is =
writing
> > to "/db"
> > I changed options "newstore_sync_*" without success.
> > =20
> > Is there any way to write all metadata in "/db" and all data in "/fra=
gments" ?
> > You can set newstore_overlay_max =3D 0 to avoid most data landing in =
db/.
> > But if you are overwriting an existing object, doing write-ahead logg=
ing
> > is usually unavoidable because we need to make the update atomic (and=
 the
> > underlying posix fs doesn't provide that).  The wip-newstore-frags br=
anch
> > mitigates this somewhat for larger writes by limiting fragment size, =
but
> > for small IOs this is pretty much always going to be the case.  For s=
mall
> > IOs, though, putting things in db/ is generally better since we can
> > combine many small ios into a single (rocksdb) journal/wal write.  An=
d
> > often leave them there (via the 'overlay' behavior).
> > =20
> > sage
> > =20
> > =20
> > =20
> > =20
> >=20
> > --=20
> > ________________________________________________________=20
> >=20
> > Cordialement,
> >=20
> > David CASIER
> >=20
> >=20
> > 4 Trait d'Union
> > 77127 LIEUSAINT
> >=20
> > Ligne directe: 01 75 98 53 85
> > Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > ________________________________________________________
> > D=E9but du message r=E9exp=E9di=E9 :
> >=20
> > De: David Casier <david.casier@aevoo.fr>
> > Date: 14 octobre 2015 22:03:38 UTC+2
> > =C0: S=E9bastien VALSEMEY <sebastien.valsemey@aevoo.fr>, benoit.lorio=
t@aevoo.fr
> > Cc: Denis Saget <geodni@gmail.com>, "luc.petetin" <luc.petetin@aevoo.=
fr>
> > Objet: R=E9p : Fwd: [newstore (again)] how disable double write WAL
> >=20
> > Bonsoir Messieurs,=20
> > Je viens de vivre le premier vrai feu Ceph.
> > Loic Dachary m'a bien appuy=E9 sur le coup.
> >=20
> > Je peux vous dire une chose : on a beau penser ma=EEtriser le produit=
, c'est lors d'un incident qu'on se rend compte du nombre de facteurs =E0=
 conna=EEtre par coeur.
> > Aussi, pas de panique, je prend vraiment l'exp=E9rience de ce soir co=
mme un succ=E8s et comme un excellent coup de boost.
> >=20
> > Explications :
> >  - LI ont un peu trop jou=E9 avec la crushmap (je ferai de la techniq=
ue pointut un autre jour)
> >  - Mise =E0 jour et red=E9marrage des OSD
> >  - Les OSD ne savaient plus o=F9 =E9taient la data
> >  - Reconstruction =E0 la mimine de la crushmap et zzooouu.
> >=20
> > Rien de bien grave en soit et un gros plus (++++) en image chez LI (j=
'aurais perdu 1h =E0 2h de plus sans Loic o=F9 ne s'est pas dispers=E9)
> >=20
> > Conclusion :=20
> > On va bosser ensemble sur des stress-tests, un peu comme des validati=
ons RedHat : une plate-forme, je casse, vous r=E9parez.
> > Vous aurez autant de temps qu'il faut pour trouver (il m'est arriv=E9=
 de passer quelques jours sur certains trucs).
> >=20
> > Objectifs :=20
> >  - Ma=EEtriser une liste de v=E9rifs =E0 faire=20
> >  - La rejouer toutes les semaines si beaucoup de fautes
> >  - Tous les mois si un peu de faute
> >  - Tous les 3 mois si bonne ma=EEtrise=20
> >  - ...
> >=20
> > Il faut qu'on soit au top et que certaines choses passent en r=E9flex=
e (v=E9rif crushmap, savoir trouver la data sans les process, ...).
> > Surtout qu'il faut que le client soit rassur=E9 en cas d'incident (ou=
 pas).
> >=20
> > Et franchement, c'est vraiment passionnant Ceph !
> >=20
> >   On 10/12/2015 09:33 PM, Sage Weil wrote:
> >> Hi David-
> >>=20
> >> On Mon, 12 Oct 2015, David Casier wrote:
> >>> Ok,
> >>> Great.
> >>>=20
> >>> With these  settings :
> >>> //
> >>> newstore_max_dir_size =3D 4096
> >>> newstore_sync_io =3D true
> >>> newstore_sync_transaction =3D true
> >>> newstore_sync_submit_transaction =3D true
> >> Is this a hard disk?  Those settings probably don't make sense since=
 it=20
> >> does every IO synchronously, blocking the submitting IO path...
> >>=20
> >>> newstore_sync_wal_apply =3D true
> >>> newstore_overlay_max =3D 0
> >>> //
> >>>=20
> >>> And direct IO in the benchmark tool (fio)
> >>>=20
> >>> I see that the HDD is 100% charged and there are notransfer of /db =
to
> >>> /fragments after stopping benchmark : Great !
> >>>=20
> >>> But when i launch a bench with random blocs of 256k, i see random b=
locs
> >>> between 32k and 256k on HDD. Any idea ?
> >> Random IOs have to be write ahead logged in rocksdb, which has its o=
wn IO=20
> >> pattern.  Since you made everything sync above I think it'll depend =
on=20
> >> how many osd threads get batched together at a time.. maybe.  Those=20
> >> settings aren't something I've really tested, and probably only make=
=20
> >> sense with very fast NVMe devices.
> >>=20
> >>> Debits to the HDD are about 8MBps when they could be higher with la=
rger blocs> (~30MBps)
> >>> And 70 MBps without fsync (hard drive cache disabled).
> >>>=20
> >>> Other questions :
> >>> newstore_sync_io -> true =3D fsync immediatly, false =3D fsync late=
r (Thread
> >>> fsync_wq) ?
> >> yes
> >>=20
> >>> newstore_sync_transaction -> true =3D sync in DB ?
> >> synchronously do the rocksdb commit too
> >>=20
> >>> newstore_sync_submit_transaction -> if false then kv_queue (only if
> >>> newstore_sync_transaction=3Dfalse) ?
> >> yeah.. there is an annoying rocksdb behavior that makes an async=20
> >> transaction submit block if a sync one is in progress, so this queue=
s them=20
> >> up and explicitly batches them.
> >>=20
> >>> newstore_sync_wal_apply =3D true -> if false then WAL later (thread=
 wal_wq) ?
> >> the txn commit completion threads can do the wal work synchronously.=
. this=20
> >> is only a good idea if it's doing aio (which it generally is).
> >>=20
> >>> Is it true ?
> >>>=20
> >>> Way for cache with battery (sync DB and no sync data) ?
> >> ?
> >> s
> >>=20
> >>> Thanks for everything !
> >>>=20
> >>> On 10/12/2015 03:01 PM, Sage Weil wrote:
> >>>> On Mon, 12 Oct 2015, David Casier wrote:
> >>>>> Hello everybody,
> >>>>> fragment is stored in rocksdb before being written to "/fragments=
" ?
> >>>>> I separed "/db" and "/fragments" but during the bench, everything=
 is
> >>>>> writing
> >>>>> to "/db"
> >>>>> I changed options "newstore_sync_*" without success.
> >>>>>=20
> >>>>> Is there any way to write all metadata in "/db" and all data in
> >>>>> "/fragments" ?
> >>>> You can set newstore_overlay_max =3D 0 to avoid most data landing =
in db/.
> >>>> But if you are overwriting an existing object, doing write-ahead l=
ogging
> >>>> is usually unavoidable because we need to make the update atomic (=
and the
> >>>> underlying posix fs doesn't provide that).  The wip-newstore-frags=
 branch
> >>>> mitigates this somewhat for larger writes by limiting fragment siz=
e, but
> >>>> for small IOs this is pretty much always going to be the case.  Fo=
r small
> >>>> IOs, though, putting things in db/ is generally better since we ca=
n
> >>>> combine many small ios into a single (rocksdb) journal/wal write. =
 And
> >>>> often leave them there (via the 'overlay' behavior).
> >>>>=20
> >>>> sage
> >>>>=20
> >>>=20
> >>> --=20
> >>> ________________________________________________________
> >>>=20
> >>> Cordialement,
> >>>=20
> >>> *David CASIER
> >>> DCConsulting SARL
> >>>=20
> >>>=20
> >>> 4 Trait d'Union
> >>> 77127 LIEUSAINT
> >>>=20
> >>> **Ligne directe: _01 75 98 53 85_
> >>> Email: _david.casier@aevoo.fr_
> >>> * ________________________________________________________
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> >>> the body of a message to majordomo@vger.kernel.org <mailto:majordom=
o@vger.kernel.org>
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html =
<http://vger.kernel.org/majordomo-info.html>
> >>>=20
> >>>=20
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> the body of a message to majordomo@vger.kernel.org <mailto:majordomo=
@vger.kernel.org>
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html <=
http://vger.kernel.org/majordomo-info.html>
> >=20
> >=20
> > --=20
> > ________________________________________________________=20
> >=20
> > Cordialement,
> >=20
> > David CASIER
> > DCConsulting SARL
> >=20
> > =20
> > 4 Trait d'Union
> > 77127 LIEUSAINT
> >=20
> > Ligne directe: 01 75 98 53 85
> > Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > ________________________________________________________
>=20
>=20
--557981400-594944368-1448397726=:25734--
