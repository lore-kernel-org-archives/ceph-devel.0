From: David Casier <david.casier@aevoo.fr>
Subject: Re: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 12 Oct 2015 20:52:26 +0200
Message-ID: <561C016A.8090701@aevoo.fr>
References: <561BABB5.2090209@aevoo.fr> <561BAC81.5030506@aevoo.fr> <alpine.DEB.2.00.1510120557380.29929@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 62-210-192-203.rev.poneytelecom.eu ([62.210.192.203]:42456 "EHLO
	aevoo.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbbJLSyL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 12 Oct 2015 14:54:11 -0400
In-Reply-To: <alpine.DEB.2.00.1510120557380.29929@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: =?windows-1252?Q?S=E9bastien_VALSEMEY?= <sebastien.valsemey@aevoo.fr>, benoit.loriot@aevoo.fr, Denis Saget <geodni@gmail.com>, "luc.petetin" <luc.petetin@aevoo.fr>

Ok,
Great.

With these  settings :
//
newstore_max_dir_size = 4096
newstore_sync_io = true
newstore_sync_transaction = true
newstore_sync_submit_transaction = true
newstore_sync_wal_apply = true
newstore_overlay_max = 0
//

And direct IO in the benchmark tool (fio)

I see that the HDD is 100% charged and there are notransfer of /db to 
/fragments after stopping benchmark : Great !

But when i launch a bench with random blocs of 256k, i see random blocs 
between 32k and 256k on HDD. Any idea ?

Debits to the HDD are about 8MBps when they could be higher with larger 
blocs (~30MBps)
And 70 MBps without fsync (hard drive cache disabled).

Other questions :
newstore_sync_io -> true = fsync immediatly, false = fsync later (Thread 
fsync_wq) ?
newstore_sync_transaction -> true = sync in DB ?
newstore_sync_submit_transaction -> if false then kv_queue (only if 
newstore_sync_transaction=false) ?
newstore_sync_wal_apply = true -> if false then WAL later (thread wal_wq) ?

Is it true ?

Way for cache with battery (sync DB and no sync data) ?

Thanks for everything !

On 10/12/2015 03:01 PM, Sage Weil wrote:
> On Mon, 12 Oct 2015, David Casier wrote:
>> Hello everybody,
>> fragment is stored in rocksdb before being written to "/fragments" ?
>> I separed "/db" and "/fragments" but during the bench, everything is writing
>> to "/db"
>> I changed options "newstore_sync_*" without success.
>>
>> Is there any way to write all metadata in "/db" and all data in "/fragments" ?
> You can set newstore_overlay_max = 0 to avoid most data landing in db/.
> But if you are overwriting an existing object, doing write-ahead logging
> is usually unavoidable because we need to make the update atomic (and the
> underlying posix fs doesn't provide that).  The wip-newstore-frags branch
> mitigates this somewhat for larger writes by limiting fragment size, but
> for small IOs this is pretty much always going to be the case.  For small
> IOs, though, putting things in db/ is generally better since we can
> combine many small ios into a single (rocksdb) journal/wal write.  And
> often leave them there (via the 'overlay' behavior).
>
> sage
>


-- 
________________________________________________________

Cordialement,

*David CASIER
DCConsulting SARL


4 Trait d'Union
77127 LIEUSAINT

**Ligne directe: _01 75 98 53 85_
Email: _david.casier@aevoo.fr_
* ________________________________________________________
