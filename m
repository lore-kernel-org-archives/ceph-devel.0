From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 12 Oct 2015 12:33:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510121225540.6589@cobra.newdream.net>
References: <561BABB5.2090209@aevoo.fr> <561BAC81.5030506@aevoo.fr> <alpine.DEB.2.00.1510120557380.29929@cobra.newdream.net> <561C016A.8090701@aevoo.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38565 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbJLTdx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 15:33:53 -0400
In-Reply-To: <561C016A.8090701@aevoo.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier <david.casier@aevoo.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, =?ISO-8859-15?Q?S=E9bastien_VALSEMEY?= <sebastien.valsemey@aevoo.fr>, benoit.loriot@aevoo.fr, Denis Saget <geodni@gmail.com>, "luc.petetin" <luc.petetin@aevoo.fr>

Hi David-

On Mon, 12 Oct 2015, David Casier wrote:
> Ok,
> Great.
> 
> With these  settings :
> //
> newstore_max_dir_size = 4096
> newstore_sync_io = true
> newstore_sync_transaction = true
> newstore_sync_submit_transaction = true

Is this a hard disk?  Those settings probably don't make sense since it 
does every IO synchronously, blocking the submitting IO path...

> newstore_sync_wal_apply = true
> newstore_overlay_max = 0
> //
> 
> And direct IO in the benchmark tool (fio)
> 
> I see that the HDD is 100% charged and there are notransfer of /db to
> /fragments after stopping benchmark : Great !
> 
> But when i launch a bench with random blocs of 256k, i see random blocs
> between 32k and 256k on HDD. Any idea ?

Random IOs have to be write ahead logged in rocksdb, which has its own IO 
pattern.  Since you made everything sync above I think it'll depend on 
how many osd threads get batched together at a time.. maybe.  Those 
settings aren't something I've really tested, and probably only make 
sense with very fast NVMe devices.

> Debits to the HDD are about 8MBps when they could be higher with larger blocs> (~30MBps)
> And 70 MBps without fsync (hard drive cache disabled).
> 
> Other questions :
> newstore_sync_io -> true = fsync immediatly, false = fsync later (Thread
> fsync_wq) ?

yes

> newstore_sync_transaction -> true = sync in DB ?

synchronously do the rocksdb commit too

> newstore_sync_submit_transaction -> if false then kv_queue (only if
> newstore_sync_transaction=false) ?

yeah.. there is an annoying rocksdb behavior that makes an async 
transaction submit block if a sync one is in progress, so this queues them 
up and explicitly batches them.

> newstore_sync_wal_apply = true -> if false then WAL later (thread wal_wq) ?

the txn commit completion threads can do the wal work synchronously.. this 
is only a good idea if it's doing aio (which it generally is).

> Is it true ?
> 
> Way for cache with battery (sync DB and no sync data) ?

?
s

> 
> Thanks for everything !
> 
> On 10/12/2015 03:01 PM, Sage Weil wrote:
> > On Mon, 12 Oct 2015, David Casier wrote:
> > > Hello everybody,
> > > fragment is stored in rocksdb before being written to "/fragments" ?
> > > I separed "/db" and "/fragments" but during the bench, everything is
> > > writing
> > > to "/db"
> > > I changed options "newstore_sync_*" without success.
> > > 
> > > Is there any way to write all metadata in "/db" and all data in
> > > "/fragments" ?
> > You can set newstore_overlay_max = 0 to avoid most data landing in db/.
> > But if you are overwriting an existing object, doing write-ahead logging
> > is usually unavoidable because we need to make the update atomic (and the
> > underlying posix fs doesn't provide that).  The wip-newstore-frags branch
> > mitigates this somewhat for larger writes by limiting fragment size, but
> > for small IOs this is pretty much always going to be the case.  For small
> > IOs, though, putting things in db/ is generally better since we can
> > combine many small ios into a single (rocksdb) journal/wal write.  And
> > often leave them there (via the 'overlay' behavior).
> > 
> > sage
> > 
> 
> 
> -- 
> ________________________________________________________
> 
> Cordialement,
> 
> *David CASIER
> DCConsulting SARL
> 
> 
> 4 Trait d'Union
> 77127 LIEUSAINT
> 
> **Ligne directe: _01 75 98 53 85_
> Email: _david.casier@aevoo.fr_
> * ________________________________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
