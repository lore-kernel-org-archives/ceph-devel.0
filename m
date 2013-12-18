From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Wed, 18 Dec 2013 11:35:40 -0800
Message-ID: <CAPYLRzjfiXYbe=kCbz+VpucH=GLGkFu+n-t=5wLsFCohF5pcjQ@mail.gmail.com>
References: <orob8qt7kf.fsf@livre.home>
	<alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
	<ortxifi1cs.fsf@livre.home>
	<alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net>
	<or7gb3ad3w.fsf@livre.home>
	<orwqj38u3w.fsf@livre.home>
	<orsitr8slc.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:36058 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab3LRTfn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 14:35:43 -0500
Received: by mail-qc0-f178.google.com with SMTP id i17so89851qcy.37
        for <ceph-devel@vger.kernel.org>; Wed, 18 Dec 2013 11:35:41 -0800 (PST)
In-Reply-To: <orsitr8slc.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: Sage Weil <sage@inktank.com>, Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Dec 17, 2013 at 4:14 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> On Aug 27, 2013, Sage Weil <sage@inktank.com> wrote:
>
>> Hi,
>> On Sat, 24 Aug 2013, Alexandre Oliva wrote:
>>> On Aug 23, 2013, Sage Weil <sage@inktank.com> wrote:
>>>
>>> > FWIW Alexandre, this feature was never really complete.  For it t=
o work,
>>> > we also need to snapshot the monitors, and roll them back as well=
=2E
>>>
>>> That depends on what's expected from the feature, actually.
>>>
>>> One use is to roll back a single osd, and for that, the feature wor=
ks
>>> just fine.  Of course, for that one doesn't need the multi-osd snap=
shots
>>> to be mutually consistent, but it's still convenient to be able to =
take
>>> a global snapshot with a single command.
>
>> In principle, we can add this back in.  I think it needs a few chang=
es,
>> though.
>
>> First, FileStore::snapshot() needs to pause and drain the workqueue =
before
>> taking the snapshot, similar to what is done with the sync sequence.
>> Otherwise it isn't a transactionally consistent snapshot and may tea=
r some
>> update.  Because it is draining the work queue, it *might* also need=
 to
>> drop some locks, but I'm hopeful that that isn't necessary.
>
> Hmm...  I don't quite get this.  The Filestore implementation of
> snapshot already performs a sync_and_flush before calling the backend=
's
> create_checkpoint.  Shouldn't that be enough?  FWIW, the code I broug=
ht
> in from argonaut didn't do any such thing; it did drop locks, but tha=
t
> doesn't seem to be necessary any more:

=46rom a quick skim I think you're right about that. The more serious
concern in the OSDs (which motivated removing the cluster snap) is
what Sage mentioned: we used to be able to take a snapshot for which
all PGs were at the same epoch, and we can't do that now. It's
possible that's okay, but it makes the semantics even weirder than
they used to be (you've never been getting a real point-in-time
snapshot, although as long as you didn't use external communication
channels you could at least be sure it contained a causal cut).

And of course that's nothing compared to snapshotting the monitors, as
you've noticed =97 but making it actually be a cluster snapshot (instea=
d
of something you could basically do by taking a btrfs snapshot
yourself) is something I would want to see before we bring the feature
back into mainline.


On Tue, Dec 17, 2013 at 6:22 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> On Dec 17, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>
>> On Dec 17, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>>>> Finally, eventually we should make this do a checkpoint on the mon=
s too.
>>>> We can add the osd snapping back in first, but before this can/sho=
uld
>>>> really be used the mons need to be snapshotted as well.  Probably =
that's
>>>> just adding in a snapshot() method to MonitorStore.h and doing eit=
her a
>>>> leveldb snap or making a full copy of store.db... I forget what le=
veldb is
>>>> capable of here.
>
>>> I haven't looked into this yet.
>
>> None of these are particularly appealing; (1) wastes disk space and =
cpu
>> cycles; (2) relies on leveldb internal implementation details such a=
s
>> the fact that files are never modified after they're first closed, a=
nd
>> (3) requires a btrfs subvol for the store.db.  My favorite choice wo=
uld
>> be 3, but can we just fail mon snaps when this requirement is not me=
t?
>
> Another aspect that needs to be considered is whether to take a snaps=
hot
> of the leader only, or of all monitors in the quorum.  The fact that =
the
> snapshot operation may take a while to complete (particularly (1)), a=
nd
> monitors may not make progress while taking the snapshot (which might
> cause the client and other monitors to assume other monitors have
> failed), make the whole thing quite more complex than what I'd have
> hoped for.
>
> Another point that may affect the decision is the amount of informati=
on
> in store.db that may have to be retained.  E.g., if it's just a small
> amount of information, creating a separate database makes far more se=
nse
> than taking a complete copy of the entire database, and it might even
> make sense for the leader to include the full snapshot data in the
> snapshot-taking message shared with other monitors, so that they all
> take exactly the same snapshot, even if they're not in the quorum and
> receive the update at a later time.  Of course this wouldn't work if =
the
> amount of snapshotted monitor data was more than reasonable for a
> monitor message.
>
> Anyway, this is probably more than what I'd be able to undertake myse=
lf,
> at least in part because, although I can see one place to add the
> snapshot-taking code to the leader (assuming it's ok to take the
> snapshot just before or right after all monitors agree on it), I have=
 no
> idea of where to plug the snapshot-taking behavior into peon and
> recovering monitors.  Absent a two-phase protocol, it seems to me tha=
t
> all monitors ought to take snapshots tentatively when they issue or
> acknowledge the snapshot-taking proposal, so as to make sure that if =
it
> succeeds we'll have a quorum of snapshots, but if the proposal doesn'=
t
> succeed at first, I don't know how to deal with retries (overwrite
> existing snapshots?  discard the snapshot when its proposal fails?) o=
r
> cancellation (say, the client doesn't get confirmation from the leade=
r,
> the leader changes, it retries that some times, and eventually it giv=
es
> up, but some monitors have already tentatively taken the snapshot in =
the
> mean time).

The best way I can think of in a short time to solve these problems
would be to make snapshots first-class citizens in the monitor. We
could extend the monitor store to handle multiple leveldb instances,
and then a snapshot would would be an async operation which does a
leveldb snapshot inline and spins off a thread to clone that data into
a new leveldb instance. When all the up monitors complete, the user
gets a report saying the snapshot was successful and it gets marked
complete in some snapshot map. Any monitors which have to get a full
store sync would also sync any snapshots they don't already have. If
the monitors can't complete a snapshot (all failing at once for some
reason) then they could block the user from doing anything except
deleting them.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
