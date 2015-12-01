From: David Casier <david.casier@aevoo.fr>
Subject: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Tue, 1 Dec 2015 21:34:24 +0100
Message-ID: <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
	<alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
	<CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33945 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbbLAUe0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Dec 2015 15:34:26 -0500
Received: by wmvv187 with SMTP id v187so225257328wmv.1
        for <ceph-devel@vger.kernel.org>; Tue, 01 Dec 2015 12:34:24 -0800 (PST)
In-Reply-To: <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

=46YI
---------- Forwarded message ----------
=46rom: David Casier <david.casier@aevoo.fr>
Date: 2015-12-01 21:32 GMT+01:00
Subject: Re: Fwd: [newstore (again)] how disable double write WAL
To: Sage Weil <sage@newdream.net>
Cc: S=C3=A9bastien VALSEMEY <sebastien.valsemey@aevoo.fr>, Vish Maram-S=
SI
<vishwanath.m@ssi.samsung.com>, Ceph Development
<ceph-devel@vger.kernel.org>, Beno=C3=AEt LORIOT <benoit.loriot@aevoo.f=
r>,
pascal.billery-schneider@laposte.net


Hi Sage,
With a standard disk (4 to 6 TB), and a small flash drive, it's easy
to create an ext4 FS with metadata on flash

Example with sdg1 on flash and sdb on hdd :

size_of() {
  blockdev --getsize $1
}

mkdmsetup() {
  _ssd=3D/dev/$1
  _hdd=3D/dev/$2
  _size_of_ssd=3D$(size_of $_ssd)
  echo """0 $_size_of_ssd linear $_ssd 0
  $_size_of_ssd $(size_of $_hdd) linear $_hdd 0" | dmsetup create dm-${=
1}-${2}
}

mkdmsetup sdg1 sdb

mkfs.ext4 -O ^has_journal,flex_bg,^uninit_bg,^sparse_super,sparse_super=
2,^extra_isize,^dir_nlink,^resize_inode
-E packed_meta_blocks=3D1,lazy_itable_init=3D0 -G 32768 -I 128 -i
$((1024*512)) /dev/mapper/dm-sdg1-sdb

With that, all meta_blocks are on the SSD

If omap are on SSD, there are almost no metadata on HDD

Consequence : performance Ceph (with hack on filestore without journal
and directIO) are almost same that performance of the HDD.

With cache-tier, it's very cool !

That is why we are working on a hybrid approach HDD / Flash on ARM or I=
ntel

With newstore, it's much more difficult to control the I/O profil.
Because rocksDB embedded its own intelligence

In the (near) futur, we will create a portal to display our hardware
solution in the CERN OHL license.

(My non-fluency in English explains the latency of my answers)

2015-11-24 21:42 GMT+01:00 Sage Weil <sage@newdream.net>:
>
> On Tue, 24 Nov 2015, S=C3=A9bastien VALSEMEY wrote:
> > Hello Vish,
> >
> > Please apologize for the delay in my answer.
> > Following the conversation you had with my colleague David, here ar=
e
> > some more details about our work :
> >
> > We are working on Filestore / Newstore optimizations by studying ho=
w we
> > could set ourselves free from using the journal.
> >
> > It is very important to work with SSD, but it is also mandatory to
> > combine it with regular magnetic platter disks. This is why we are
> > combining metadata storing on flash with data storing on disk.
>
> This is pretty common, and something we will support natively with
> newstore.
>
> > Our main goal is to have the control on performance. Which is quite
> > difficult with NewStore, and needs fundamental hacks with FileStore=
=2E
>
> Can you clarify what you mean by "quite difficult with NewStore"?
>
> FWIW, the latest bleeding edge code is currently at
> github.com/liewegas/wip-bluestore.
>
> sage
>
>
> > Is Samsung working on ARM boards with embedded flash and a SATA por=
t, in
> > order to allow us to work on a hybrid approach? What is your line o=
f
> > work with Ceph?
> >
> > How can we work together ?
> >
> > Regards,
> > S=C3=A9bastien
> >
> > > D=C3=A9but du message r=C3=A9exp=C3=A9di=C3=A9 :
> > >
> > > De: David Casier <david.casier@aevoo.fr>
> > > Date: 12 octobre 2015 20:52:26 UTC+2
> > > =C3=80: Sage Weil <sage@newdream.net>, Ceph Development <ceph-dev=
el@vger.kernel.org>
> > > Cc: S=C3=A9bastien VALSEMEY <sebastien.valsemey@aevoo.fr>, benoit=
=2Eloriot@aevoo.fr, Denis Saget <geodni@gmail.com>, "luc.petetin" <luc.=
petetin@aevoo.fr>
> > > Objet: R=C3=A9p : Fwd: [newstore (again)] how disable double writ=
e WAL
> > >
> > > Ok,
> > > Great.
> > >
> > > With these  settings :
> > > //
> > > newstore_max_dir_size =3D 4096
> > > newstore_sync_io =3D true
> > > newstore_sync_transaction =3D true
> > > newstore_sync_submit_transaction =3D true
> > > newstore_sync_wal_apply =3D true
> > > newstore_overlay_max =3D 0
> > > //
> > >
> > > And direct IO in the benchmark tool (fio)
> > >
> > > I see that the HDD is 100% charged and there are notransfer of /d=
b to /fragments after stopping benchmark : Great !
> > >
> > > But when i launch a bench with random blocs of 256k, i see random=
 blocs between 32k and 256k on HDD. Any idea ?
> > >
> > > Debits to the HDD are about 8MBps when they could be higher with =
larger blocs (~30MBps)
> > > And 70 MBps without fsync (hard drive cache disabled).
> > >
> > > Other questions :
> > > newstore_sync_io -> true =3D fsync immediatly, false =3D fsync la=
ter (Thread fsync_wq) ?
> > > newstore_sync_transaction -> true =3D sync in DB ?
> > > newstore_sync_submit_transaction -> if false then kv_queue (only =
if newstore_sync_transaction=3Dfalse) ?
> > > newstore_sync_wal_apply =3D true -> if false then WAL later (thre=
ad wal_wq) ?
> > >
> > > Is it true ?
> > >
> > > Way for cache with battery (sync DB and no sync data) ?
> > >
> > > Thanks for everything !
> > >
> > > On 10/12/2015 03:01 PM, Sage Weil wrote:
> > >> On Mon, 12 Oct 2015, David Casier wrote:
> > >>> Hello everybody,
> > >>> fragment is stored in rocksdb before being written to "/fragmen=
ts" ?
> > >>> I separed "/db" and "/fragments" but during the bench, everythi=
ng is writing
> > >>> to "/db"
> > >>> I changed options "newstore_sync_*" without success.
> > >>>
> > >>> Is there any way to write all metadata in "/db" and all data in=
 "/fragments" ?
> > >> You can set newstore_overlay_max =3D 0 to avoid most data landin=
g in db/.
> > >> But if you are overwriting an existing object, doing write-ahead=
 logging
> > >> is usually unavoidable because we need to make the update atomic=
 (and the
> > >> underlying posix fs doesn't provide that).  The wip-newstore-fra=
gs branch
> > >> mitigates this somewhat for larger writes by limiting fragment s=
ize, but
> > >> for small IOs this is pretty much always going to be the case.  =
=46or small
> > >> IOs, though, putting things in db/ is generally better since we =
can
> > >> combine many small ios into a single (rocksdb) journal/wal write=
=2E  And
> > >> often leave them there (via the 'overlay' behavior).
> > >>
> > >> sage
> > >>
> > >
> > >
> > > --
> > > ________________________________________________________
> > >
> > > Cordialement,
> > >
> > > *David CASIER
> > > DCConsulting SARL
> > >
> > >
> > > 4 Trait d'Union
> > > 77127 LIEUSAINT
> > >
> > > **Ligne directe: _01 75 98 53 85_
> > > Email: _david.casier@aevoo.fr_
> > > * ________________________________________________________
> > > D=C3=A9but du message r=C3=A9exp=C3=A9di=C3=A9 :
> > >
> > > De: David Casier <david.casier@aevoo.fr>
> > > Date: 2 novembre 2015 20:02:37 UTC+1
> > > =C3=80: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.c=
om>
> > > Cc: benoit LORIOT <benoit.loriot@aevoo.fr>, S=C3=A9bastien VALSEM=
EY <sebastien.valsemey@aevoo.fr>
> > > Objet: R=C3=A9p : Fwd: [newstore (again)] how disable double writ=
e WAL
> > >
> > > Hi Vish,
> > > In FileStore, data and metadata are stored in files, with xargs F=
S and omap.
> > > NewStore works with RocksDB.
> > > There are a lot of configuration in RocksDB but all options not i=
mplemented.
> > >
> > > The best way, for me, is not to use the logs, with secure cache (=
for example SSD 845DC).
> > > I don't think that is necessary to report I/O with a good metadat=
a optimisation.
> > >
> > > The problem with RocksDB is that not possible to control I/O bloc=
s size.
> > >
> > > We will resume work on NewStore soon.
> > >
> > > On 10/29/2015 05:30 PM, Vish (Vishwanath) Maram-SSI wrote:
> > >> Thanks David for the reply.
> > >>
> > >> Yeah We just wanted to know how different is it from Filestore a=
nd how do we contribute for this? My motive is to first understand the =
design of Newstore and get the Performance loopholes so that we can try=
 looking into it.
> > >>
> > >> It would be helpful if you can share what is your idea from your=
 side to use Newstore and configuration? What plans you are having for =
contributions to help us understand and see if we can work together.
> > >>
> > >> Thanks,
> > >> -Vish
> > >>   <>
> > >> From: David Casier [mailto:david.casier@aevoo.fr <mailto:david.c=
asier@aevoo.fr>]
> > >> Sent: Thursday, October 29, 2015 4:41 AM
> > >> To: Vish (Vishwanath) Maram-SSI
> > >> Cc: benoit LORIOT; S=C3=A9bastien VALSEMEY
> > >> Subject: Re: Fwd: [newstore (again)] how disable double write WA=
L
> > >>
> > >> Hi Vish,
> > >> It's OK.
> > >>
> > >> We have a lot of different configuration with newstore tests.
> > >>
> > >> What is your goal with ?
> > >>
> > >> On 10/28/2015 11:02 PM, Vish (Vishwanath) Maram-SSI wrote:
> > >> Hi David,
> > >>
> > >> Sorry for sending you the mail directly.
> > >>
> > >> This is Vishwanath Maram from Samsung and started to play around=
 with Newstore and observing some issues with running FIO.
> > >>
> > >> Can you please share your Ceph Configuration file which you have=
 used to run the IO's using FIO?
> > >>
> > >> Thanks,
> > >> -Vish
> > >>
> > >> -----Original Message-----
> > >> From: ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-owner@=
vger.kernel.org> [mailto:ceph-devel-owner@vger.kernel.org <mailto:ceph-=
devel-owner@vger.kernel.org>] On Behalf Of David Casier
> > >> Sent: Monday, October 12, 2015 11:52 AM
> > >> To: Sage Weil; Ceph Development
> > >> Cc: S=C3=A9bastien VALSEMEY; benoit.loriot@aevoo.fr <mailto:beno=
it.loriot@aevoo.fr>; Denis Saget; luc.petetin
> > >> Subject: Re: Fwd: [newstore (again)] how disable double write WA=
L
> > >>
> > >> Ok,
> > >> Great.
> > >>
> > >> With these  settings :
> > >> //
> > >> newstore_max_dir_size =3D 4096
> > >> newstore_sync_io =3D true
> > >> newstore_sync_transaction =3D true
> > >> newstore_sync_submit_transaction =3D true
> > >> newstore_sync_wal_apply =3D true
> > >> newstore_overlay_max =3D 0
> > >> //
> > >>
> > >> And direct IO in the benchmark tool (fio)
> > >>
> > >> I see that the HDD is 100% charged and there are notransfer of /=
db to
> > >> /fragments after stopping benchmark : Great !
> > >>
> > >> But when i launch a bench with random blocs of 256k, i see rando=
m blocs
> > >> between 32k and 256k on HDD. Any idea ?
> > >>
> > >> Debits to the HDD are about 8MBps when they could be higher with=
 larger
> > >> blocs (~30MBps)
> > >> And 70 MBps without fsync (hard drive cache disabled).
> > >>
> > >> Other questions :
> > >> newstore_sync_io -> true =3D fsync immediatly, false =3D fsync l=
ater (Thread
> > >> fsync_wq) ?
> > >> newstore_sync_transaction -> true =3D sync in DB ?
> > >> newstore_sync_submit_transaction -> if false then kv_queue (only=
 if
> > >> newstore_sync_transaction=3Dfalse) ?
> > >> newstore_sync_wal_apply =3D true -> if false then WAL later (thr=
ead wal_wq) ?
> > >>
> > >> Is it true ?
> > >>
> > >> Way for cache with battery (sync DB and no sync data) ?
> > >>
> > >> Thanks for everything !
> > >>
> > >> On 10/12/2015 03:01 PM, Sage Weil wrote:
> > >> On Mon, 12 Oct 2015, David Casier wrote:
> > >> Hello everybody,
> > >> fragment is stored in rocksdb before being written to "/fragment=
s" ?
> > >> I separed "/db" and "/fragments" but during the bench, everythin=
g is writing
> > >> to "/db"
> > >> I changed options "newstore_sync_*" without success.
> > >>
> > >> Is there any way to write all metadata in "/db" and all data in =
"/fragments" ?
> > >> You can set newstore_overlay_max =3D 0 to avoid most data landin=
g in db/.
> > >> But if you are overwriting an existing object, doing write-ahead=
 logging
> > >> is usually unavoidable because we need to make the update atomic=
 (and the
> > >> underlying posix fs doesn't provide that).  The wip-newstore-fra=
gs branch
> > >> mitigates this somewhat for larger writes by limiting fragment s=
ize, but
> > >> for small IOs this is pretty much always going to be the case.  =
=46or small
> > >> IOs, though, putting things in db/ is generally better since we =
can
> > >> combine many small ios into a single (rocksdb) journal/wal write=
=2E  And
> > >> often leave them there (via the 'overlay' behavior).
> > >>
> > >> sage
> > >>
> > >>
> > >>
> > >>
> > >>
> > >> --
> > >> ________________________________________________________
> > >>
> > >> Cordialement,
> > >>
> > >> David CASIER
> > >>
> > >>
> > >> 4 Trait d'Union
> > >> 77127 LIEUSAINT
> > >>
> > >> Ligne directe: 01 75 98 53 85
> > >> Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > >> ________________________________________________________
> > >
> > >
> > > --
> > > ________________________________________________________
> > >
> > > Cordialement,
> > >
> > > David CASIER
> > >
> > >
> > > 4 Trait d'Union
> > > 77127 LIEUSAINT
> > >
> > > Ligne directe: 01 75 98 53 85
> > > Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > > ________________________________________________________
> > > D=C3=A9but du message r=C3=A9exp=C3=A9di=C3=A9 :
> > >
> > > De: Sage Weil <sage@newdream.net>
> > > Date: 12 octobre 2015 21:33:52 UTC+2
> > > =C3=80: David Casier <david.casier@aevoo.fr>
> > > Cc: Ceph Development <ceph-devel@vger.kernel.org>, S=C3=A9bastien=
 VALSEMEY <sebastien.valsemey@aevoo.fr>, benoit.loriot@aevoo.fr, Denis =
Saget <geodni@gmail.com>, "luc.petetin" <luc.petetin@aevoo.fr>
> > > Objet: R=C3=A9p : Fwd: [newstore (again)] how disable double writ=
e WAL
> > >
> > > Hi David-
> > >
> > > On Mon, 12 Oct 2015, David Casier wrote:
> > >> Ok,
> > >> Great.
> > >>
> > >> With these  settings :
> > >> //
> > >> newstore_max_dir_size =3D 4096
> > >> newstore_sync_io =3D true
> > >> newstore_sync_transaction =3D true
> > >> newstore_sync_submit_transaction =3D true
> > >
> > > Is this a hard disk?  Those settings probably don't make sense si=
nce it
> > > does every IO synchronously, blocking the submitting IO path...
> > >
> > >> newstore_sync_wal_apply =3D true
> > >> newstore_overlay_max =3D 0
> > >> //
> > >>
> > >> And direct IO in the benchmark tool (fio)
> > >>
> > >> I see that the HDD is 100% charged and there are notransfer of /=
db to
> > >> /fragments after stopping benchmark : Great !
> > >>
> > >> But when i launch a bench with random blocs of 256k, i see rando=
m blocs
> > >> between 32k and 256k on HDD. Any idea ?
> > >
> > > Random IOs have to be write ahead logged in rocksdb, which has it=
s own IO
> > > pattern.  Since you made everything sync above I think it'll depe=
nd on
> > > how many osd threads get batched together at a time.. maybe.  Tho=
se
> > > settings aren't something I've really tested, and probably only m=
ake
> > > sense with very fast NVMe devices.
> > >
> > >> Debits to the HDD are about 8MBps when they could be higher with=
 larger blocs> (~30MBps)
> > >> And 70 MBps without fsync (hard drive cache disabled).
> > >>
> > >> Other questions :
> > >> newstore_sync_io -> true =3D fsync immediatly, false =3D fsync l=
ater (Thread
> > >> fsync_wq) ?
> > >
> > > yes
> > >
> > >> newstore_sync_transaction -> true =3D sync in DB ?
> > >
> > > synchronously do the rocksdb commit too
> > >
> > >> newstore_sync_submit_transaction -> if false then kv_queue (only=
 if
> > >> newstore_sync_transaction=3Dfalse) ?
> > >
> > > yeah.. there is an annoying rocksdb behavior that makes an async
> > > transaction submit block if a sync one is in progress, so this qu=
eues them
> > > up and explicitly batches them.
> > >
> > >> newstore_sync_wal_apply =3D true -> if false then WAL later (thr=
ead wal_wq) ?
> > >
> > > the txn commit completion threads can do the wal work synchronous=
ly.. this
> > > is only a good idea if it's doing aio (which it generally is).
> > >
> > >> Is it true ?
> > >>
> > >> Way for cache with battery (sync DB and no sync data) ?
> > >
> > > ?
> > > s
> > >
> > >>
> > >> Thanks for everything !
> > >>
> > >> On 10/12/2015 03:01 PM, Sage Weil wrote:
> > >>> On Mon, 12 Oct 2015, David Casier wrote:
> > >>>> Hello everybody,
> > >>>> fragment is stored in rocksdb before being written to "/fragme=
nts" ?
> > >>>> I separed "/db" and "/fragments" but during the bench, everyth=
ing is
> > >>>> writing
> > >>>> to "/db"
> > >>>> I changed options "newstore_sync_*" without success.
> > >>>>
> > >>>> Is there any way to write all metadata in "/db" and all data i=
n
> > >>>> "/fragments" ?
> > >>> You can set newstore_overlay_max =3D 0 to avoid most data landi=
ng in db/.
> > >>> But if you are overwriting an existing object, doing write-ahea=
d logging
> > >>> is usually unavoidable because we need to make the update atomi=
c (and the
> > >>> underlying posix fs doesn't provide that).  The wip-newstore-fr=
ags branch
> > >>> mitigates this somewhat for larger writes by limiting fragment =
size, but
> > >>> for small IOs this is pretty much always going to be the case. =
 For small
> > >>> IOs, though, putting things in db/ is generally better since we=
 can
> > >>> combine many small ios into a single (rocksdb) journal/wal writ=
e.  And
> > >>> often leave them there (via the 'overlay' behavior).
> > >>>
> > >>> sage
> > >>>
> > >>
> > >>
> > >> --
> > >> ________________________________________________________
> > >>
> > >> Cordialement,
> > >>
> > >> *David CASIER
> > >> DCConsulting SARL
> > >>
> > >>
> > >> 4 Trait d'Union
> > >> 77127 LIEUSAINT
> > >>
> > >> **Ligne directe: _01 75 98 53 85_
> > >> Email: _david.casier@aevoo.fr_
> > >> * ________________________________________________________
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
> > >> the body of a message to majordomo@vger.kernel.org
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
> > >>
> > >>
> > > D=C3=A9but du message r=C3=A9exp=C3=A9di=C3=A9 :
> > >
> > > De: David Casier <david.casier@aevoo.fr>
> > > Date: 29 octobre 2015 12:41:22 UTC+1
> > > =C3=80: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.c=
om>
> > > Cc: benoit LORIOT <benoit.loriot@aevoo.fr>, S=C3=A9bastien VALSEM=
EY <sebastien.valsemey@aevoo.fr>
> > > Objet: R=C3=A9p : Fwd: [newstore (again)] how disable double writ=
e WAL
> > >
> > > Hi Vish,
> > > It's OK.
> > >
> > > We have a lot of different configuration with newstore tests.
> > >
> > > What is your goal with ?
> > >
> > > On 10/28/2015 11:02 PM, Vish (Vishwanath) Maram-SSI wrote:
> > >> Hi David,
> > >>
> > >> Sorry for sending you the mail directly.
> > >>
> > >> This is Vishwanath Maram from Samsung and started to play around=
 with Newstore and observing some issues with running FIO.
> > >>
> > >> Can you please share your Ceph Configuration file which you have=
 used to run the IO's using FIO?
> > >>
> > >> Thanks,
> > >> -Vish
> > >>
> > >> -----Original Message-----
> > >> From: ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-owner@=
vger.kernel.org> [mailto:ceph-devel-owner@vger.kernel.org <mailto:ceph-=
devel-owner@vger.kernel.org>] On Behalf Of David Casier
> > >> Sent: Monday, October 12, 2015 11:52 AM
> > >> To: Sage Weil; Ceph Development
> > >> Cc: S=C3=A9bastien VALSEMEY; benoit.loriot@aevoo.fr <mailto:beno=
it.loriot@aevoo.fr>; Denis Saget; luc.petetin
> > >> Subject: Re: Fwd: [newstore (again)] how disable double write WA=
L
> > >>
> > >> Ok,
> > >> Great.
> > >>
> > >> With these  settings :
> > >> //
> > >> newstore_max_dir_size =3D 4096
> > >> newstore_sync_io =3D true
> > >> newstore_sync_transaction =3D true
> > >> newstore_sync_submit_transaction =3D true
> > >> newstore_sync_wal_apply =3D true
> > >> newstore_overlay_max =3D 0
> > >> //
> > >>
> > >> And direct IO in the benchmark tool (fio)
> > >>
> > >> I see that the HDD is 100% charged and there are notransfer of /=
db to
> > >> /fragments after stopping benchmark : Great !
> > >>
> > >> But when i launch a bench with random blocs of 256k, i see rando=
m blocs
> > >> between 32k and 256k on HDD. Any idea ?
> > >>
> > >> Debits to the HDD are about 8MBps when they could be higher with=
 larger
> > >> blocs (~30MBps)
> > >> And 70 MBps without fsync (hard drive cache disabled).
> > >>
> > >> Other questions :
> > >> newstore_sync_io -> true =3D fsync immediatly, false =3D fsync l=
ater (Thread
> > >> fsync_wq) ?
> > >> newstore_sync_transaction -> true =3D sync in DB ?
> > >> newstore_sync_submit_transaction -> if false then kv_queue (only=
 if
> > >> newstore_sync_transaction=3Dfalse) ?
> > >> newstore_sync_wal_apply =3D true -> if false then WAL later (thr=
ead wal_wq) ?
> > >>
> > >> Is it true ?
> > >>
> > >> Way for cache with battery (sync DB and no sync data) ?
> > >>
> > >> Thanks for everything !
> > >>
> > >> On 10/12/2015 03:01 PM, Sage Weil wrote:
> > >>> On Mon, 12 Oct 2015, David Casier wrote:
> > >>>> Hello everybody,
> > >>>> fragment is stored in rocksdb before being written to "/fragme=
nts" ?
> > >>>> I separed "/db" and "/fragments" but during the bench, everyth=
ing is writing
> > >>>> to "/db"
> > >>>> I changed options "newstore_sync_*" without success.
> > >>>>
> > >>>> Is there any way to write all metadata in "/db" and all data i=
n "/fragments" ?
> > >>> You can set newstore_overlay_max =3D 0 to avoid most data landi=
ng in db/.
> > >>> But if you are overwriting an existing object, doing write-ahea=
d logging
> > >>> is usually unavoidable because we need to make the update atomi=
c (and the
> > >>> underlying posix fs doesn't provide that).  The wip-newstore-fr=
ags branch
> > >>> mitigates this somewhat for larger writes by limiting fragment =
size, but
> > >>> for small IOs this is pretty much always going to be the case. =
 For small
> > >>> IOs, though, putting things in db/ is generally better since we=
 can
> > >>> combine many small ios into a single (rocksdb) journal/wal writ=
e.  And
> > >>> often leave them there (via the 'overlay' behavior).
> > >>>
> > >>> sage
> > >>>
> > >>
> > >
> > >
> > > --
> > > ________________________________________________________
> > >
> > > Cordialement,
> > >
> > > David CASIER
> > >
> > >
> > > 4 Trait d'Union
> > > 77127 LIEUSAINT
> > >
> > > Ligne directe: 01 75 98 53 85
> > > Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > > ________________________________________________________
> > > D=C3=A9but du message r=C3=A9exp=C3=A9di=C3=A9 :
> > >
> > > De: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.com>
> > > Date: 29 octobre 2015 17:30:56 UTC+1
> > > =C3=80: David Casier <david.casier@aevoo.fr>
> > > Cc: benoit LORIOT <benoit.loriot@aevoo.fr>, S=C3=A9bastien VALSEM=
EY <sebastien.valsemey@aevoo.fr>
> > > Objet: RE: Fwd: [newstore (again)] how disable double write WAL
> > >
> > > Thanks David for the reply.
> > >
> > > Yeah We just wanted to know how different is it from Filestore an=
d how do we contribute for this? My motive is to first understand the d=
esign of Newstore and get the Performance loopholes so that we can try =
looking into it.
> > >
> > > It would be helpful if you can share what is your idea from your =
side to use Newstore and configuration? What plans you are having for c=
ontributions to help us understand and see if we can work together.
> > >
> > > Thanks,
> > > -Vish
> > >   <>
> > > From: David Casier [mailto:david.casier@aevoo.fr]
> > > Sent: Thursday, October 29, 2015 4:41 AM
> > > To: Vish (Vishwanath) Maram-SSI
> > > Cc: benoit LORIOT; S=C3=A9bastien VALSEMEY
> > > Subject: Re: Fwd: [newstore (again)] how disable double write WAL
> > >
> > > Hi Vish,
> > > It's OK.
> > >
> > > We have a lot of different configuration with newstore tests.
> > >
> > > What is your goal with ?
> > >
> > > On 10/28/2015 11:02 PM, Vish (Vishwanath) Maram-SSI wrote:
> > > Hi David,
> > >
> > > Sorry for sending you the mail directly.
> > >
> > > This is Vishwanath Maram from Samsung and started to play around =
with Newstore and observing some issues with running FIO.
> > >
> > > Can you please share your Ceph Configuration file which you have =
used to run the IO's using FIO?
> > >
> > > Thanks,
> > > -Vish
> > >
> > > -----Original Message-----
> > > From: ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-owner@v=
ger.kernel.org> [mailto:ceph-devel-owner@vger.kernel.org <mailto:ceph-d=
evel-owner@vger.kernel.org>] On Behalf Of David Casier
> > > Sent: Monday, October 12, 2015 11:52 AM
> > > To: Sage Weil; Ceph Development
> > > Cc: S=C3=A9bastien VALSEMEY; benoit.loriot@aevoo.fr <mailto:benoi=
t.loriot@aevoo.fr>; Denis Saget; luc.petetin
> > > Subject: Re: Fwd: [newstore (again)] how disable double write WAL
> > >
> > > Ok,
> > > Great.
> > >
> > > With these  settings :
> > > //
> > > newstore_max_dir_size =3D 4096
> > > newstore_sync_io =3D true
> > > newstore_sync_transaction =3D true
> > > newstore_sync_submit_transaction =3D true
> > > newstore_sync_wal_apply =3D true
> > > newstore_overlay_max =3D 0
> > > //
> > >
> > > And direct IO in the benchmark tool (fio)
> > >
> > > I see that the HDD is 100% charged and there are notransfer of /d=
b to
> > > /fragments after stopping benchmark : Great !
> > >
> > > But when i launch a bench with random blocs of 256k, i see random=
 blocs
> > > between 32k and 256k on HDD. Any idea ?
> > >
> > > Debits to the HDD are about 8MBps when they could be higher with =
larger
> > > blocs (~30MBps)
> > > And 70 MBps without fsync (hard drive cache disabled).
> > >
> > > Other questions :
> > > newstore_sync_io -> true =3D fsync immediatly, false =3D fsync la=
ter (Thread
> > > fsync_wq) ?
> > > newstore_sync_transaction -> true =3D sync in DB ?
> > > newstore_sync_submit_transaction -> if false then kv_queue (only =
if
> > > newstore_sync_transaction=3Dfalse) ?
> > > newstore_sync_wal_apply =3D true -> if false then WAL later (thre=
ad wal_wq) ?
> > >
> > > Is it true ?
> > >
> > > Way for cache with battery (sync DB and no sync data) ?
> > >
> > > Thanks for everything !
> > >
> > > On 10/12/2015 03:01 PM, Sage Weil wrote:
> > > On Mon, 12 Oct 2015, David Casier wrote:
> > > Hello everybody,
> > > fragment is stored in rocksdb before being written to "/fragments=
" ?
> > > I separed "/db" and "/fragments" but during the bench, everything=
 is writing
> > > to "/db"
> > > I changed options "newstore_sync_*" without success.
> > >
> > > Is there any way to write all metadata in "/db" and all data in "=
/fragments" ?
> > > You can set newstore_overlay_max =3D 0 to avoid most data landing=
 in db/.
> > > But if you are overwriting an existing object, doing write-ahead =
logging
> > > is usually unavoidable because we need to make the update atomic =
(and the
> > > underlying posix fs doesn't provide that).  The wip-newstore-frag=
s branch
> > > mitigates this somewhat for larger writes by limiting fragment si=
ze, but
> > > for small IOs this is pretty much always going to be the case.  F=
or small
> > > IOs, though, putting things in db/ is generally better since we c=
an
> > > combine many small ios into a single (rocksdb) journal/wal write.=
  And
> > > often leave them there (via the 'overlay' behavior).
> > >
> > > sage
> > >
> > >
> > >
> > >
> > >
> > > --
> > > ________________________________________________________
> > >
> > > Cordialement,
> > >
> > > David CASIER
> > >
> > >
> > > 4 Trait d'Union
> > > 77127 LIEUSAINT
> > >
> > > Ligne directe: 01 75 98 53 85
> > > Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > > ________________________________________________________
> > > D=C3=A9but du message r=C3=A9exp=C3=A9di=C3=A9 :
> > >
> > > De: David Casier <david.casier@aevoo.fr>
> > > Date: 14 octobre 2015 22:03:38 UTC+2
> > > =C3=80: S=C3=A9bastien VALSEMEY <sebastien.valsemey@aevoo.fr>, be=
noit.loriot@aevoo.fr
> > > Cc: Denis Saget <geodni@gmail.com>, "luc.petetin" <luc.petetin@ae=
voo.fr>
> > > Objet: R=C3=A9p : Fwd: [newstore (again)] how disable double writ=
e WAL
> > >
> > > Bonsoir Messieurs,
> > > Je viens de vivre le premier vrai feu Ceph.
> > > Loic Dachary m'a bien appuy=C3=A9 sur le coup.
> > >
> > > Je peux vous dire une chose : on a beau penser ma=C3=AEtriser le =
produit, c'est lors d'un incident qu'on se rend compte du nombre de fac=
teurs =C3=A0 conna=C3=AEtre par coeur.
> > > Aussi, pas de panique, je prend vraiment l'exp=C3=A9rience de ce =
soir comme un succ=C3=A8s et comme un excellent coup de boost.
> > >
> > > Explications :
> > >  - LI ont un peu trop jou=C3=A9 avec la crushmap (je ferai de la =
technique pointut un autre jour)
> > >  - Mise =C3=A0 jour et red=C3=A9marrage des OSD
> > >  - Les OSD ne savaient plus o=C3=B9 =C3=A9taient la data
> > >  - Reconstruction =C3=A0 la mimine de la crushmap et zzooouu.
> > >
> > > Rien de bien grave en soit et un gros plus (++++) en image chez L=
I (j'aurais perdu 1h =C3=A0 2h de plus sans Loic o=C3=B9 ne s'est pas d=
ispers=C3=A9)
> > >
> > > Conclusion :
> > > On va bosser ensemble sur des stress-tests, un peu comme des vali=
dations RedHat : une plate-forme, je casse, vous r=C3=A9parez.
> > > Vous aurez autant de temps qu'il faut pour trouver (il m'est arri=
v=C3=A9 de passer quelques jours sur certains trucs).
> > >
> > > Objectifs :
> > >  - Ma=C3=AEtriser une liste de v=C3=A9rifs =C3=A0 faire
> > >  - La rejouer toutes les semaines si beaucoup de fautes
> > >  - Tous les mois si un peu de faute
> > >  - Tous les 3 mois si bonne ma=C3=AEtrise
> > >  - ...
> > >
> > > Il faut qu'on soit au top et que certaines choses passent en r=C3=
=A9flexe (v=C3=A9rif crushmap, savoir trouver la data sans les process,=
 ...).
> > > Surtout qu'il faut que le client soit rassur=C3=A9 en cas d'incid=
ent (ou pas).
> > >
> > > Et franchement, c'est vraiment passionnant Ceph !
> > >
> > >   On 10/12/2015 09:33 PM, Sage Weil wrote:
> > >> Hi David-
> > >>
> > >> On Mon, 12 Oct 2015, David Casier wrote:
> > >>> Ok,
> > >>> Great.
> > >>>
> > >>> With these  settings :
> > >>> //
> > >>> newstore_max_dir_size =3D 4096
> > >>> newstore_sync_io =3D true
> > >>> newstore_sync_transaction =3D true
> > >>> newstore_sync_submit_transaction =3D true
> > >> Is this a hard disk?  Those settings probably don't make sense s=
ince it
> > >> does every IO synchronously, blocking the submitting IO path...
> > >>
> > >>> newstore_sync_wal_apply =3D true
> > >>> newstore_overlay_max =3D 0
> > >>> //
> > >>>
> > >>> And direct IO in the benchmark tool (fio)
> > >>>
> > >>> I see that the HDD is 100% charged and there are notransfer of =
/db to
> > >>> /fragments after stopping benchmark : Great !
> > >>>
> > >>> But when i launch a bench with random blocs of 256k, i see rand=
om blocs
> > >>> between 32k and 256k on HDD. Any idea ?
> > >> Random IOs have to be write ahead logged in rocksdb, which has i=
ts own IO
> > >> pattern.  Since you made everything sync above I think it'll dep=
end on
> > >> how many osd threads get batched together at a time.. maybe.  Th=
ose
> > >> settings aren't something I've really tested, and probably only =
make
> > >> sense with very fast NVMe devices.
> > >>
> > >>> Debits to the HDD are about 8MBps when they could be higher wit=
h larger blocs> (~30MBps)
> > >>> And 70 MBps without fsync (hard drive cache disabled).
> > >>>
> > >>> Other questions :
> > >>> newstore_sync_io -> true =3D fsync immediatly, false =3D fsync =
later (Thread
> > >>> fsync_wq) ?
> > >> yes
> > >>
> > >>> newstore_sync_transaction -> true =3D sync in DB ?
> > >> synchronously do the rocksdb commit too
> > >>
> > >>> newstore_sync_submit_transaction -> if false then kv_queue (onl=
y if
> > >>> newstore_sync_transaction=3Dfalse) ?
> > >> yeah.. there is an annoying rocksdb behavior that makes an async
> > >> transaction submit block if a sync one is in progress, so this q=
ueues them
> > >> up and explicitly batches them.
> > >>
> > >>> newstore_sync_wal_apply =3D true -> if false then WAL later (th=
read wal_wq) ?
> > >> the txn commit completion threads can do the wal work synchronou=
sly.. this
> > >> is only a good idea if it's doing aio (which it generally is).
> > >>
> > >>> Is it true ?
> > >>>
> > >>> Way for cache with battery (sync DB and no sync data) ?
> > >> ?
> > >> s
> > >>
> > >>> Thanks for everything !
> > >>>
> > >>> On 10/12/2015 03:01 PM, Sage Weil wrote:
> > >>>> On Mon, 12 Oct 2015, David Casier wrote:
> > >>>>> Hello everybody,
> > >>>>> fragment is stored in rocksdb before being written to "/fragm=
ents" ?
> > >>>>> I separed "/db" and "/fragments" but during the bench, everyt=
hing is
> > >>>>> writing
> > >>>>> to "/db"
> > >>>>> I changed options "newstore_sync_*" without success.
> > >>>>>
> > >>>>> Is there any way to write all metadata in "/db" and all data =
in
> > >>>>> "/fragments" ?
> > >>>> You can set newstore_overlay_max =3D 0 to avoid most data land=
ing in db/.
> > >>>> But if you are overwriting an existing object, doing write-ahe=
ad logging
> > >>>> is usually unavoidable because we need to make the update atom=
ic (and the
> > >>>> underlying posix fs doesn't provide that).  The wip-newstore-f=
rags branch
> > >>>> mitigates this somewhat for larger writes by limiting fragment=
 size, but
> > >>>> for small IOs this is pretty much always going to be the case.=
  For small
> > >>>> IOs, though, putting things in db/ is generally better since w=
e can
> > >>>> combine many small ios into a single (rocksdb) journal/wal wri=
te.  And
> > >>>> often leave them there (via the 'overlay' behavior).
> > >>>>
> > >>>> sage
> > >>>>
> > >>>
> > >>> --
> > >>> ________________________________________________________
> > >>>
> > >>> Cordialement,
> > >>>
> > >>> *David CASIER
> > >>> DCConsulting SARL
> > >>>
> > >>>
> > >>> 4 Trait d'Union
> > >>> 77127 LIEUSAINT
> > >>>
> > >>> **Ligne directe: _01 75 98 53 85_
> > >>> Email: _david.casier@aevoo.fr_
> > >>> * ________________________________________________________
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
> > >>> the body of a message to majordomo@vger.kernel.org <mailto:majo=
rdomo@vger.kernel.org>
> > >>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml <http://vger.kernel.org/majordomo-info.html>
> > >>>
> > >>>
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
> > >> the body of a message to majordomo@vger.kernel.org <mailto:major=
domo@vger.kernel.org>
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml <http://vger.kernel.org/majordomo-info.html>
> > >
> > >
> > > --
> > > ________________________________________________________
> > >
> > > Cordialement,
> > >
> > > David CASIER
> > > DCConsulting SARL
> > >
> > >
> > > 4 Trait d'Union
> > > 77127 LIEUSAINT
> > >
> > > Ligne directe: 01 75 98 53 85
> > > Email: david.casier@aevoo.fr <mailto:david.casier@aevoo.fr>
> > > ________________________________________________________
> >
> >




--=20

________________________________________________________

Cordialement,

David CASIER


3B Rue Taylor, CS20004
75481 PARIS Cedex 10 Paris

Ligne directe: 01 75 98 53 85
Email: david.casier@aevoo.fr
________________________________________________________



--=20

________________________________________________________

Cordialement,

David CASIER


3B Rue Taylor, CS20004
75481 PARIS Cedex 10 Paris

Ligne directe: 01 75 98 53 85
Email: david.casier@aevoo.fr
________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
