From: Boris Lukashev <blukashev@sempervictus.com>
Subject: Re: 7915 is not resolved
Date: Tue, 12 Jan 2016 20:06:03 -0500
Message-ID: <CAFUG7CdPcnxsHuOKVXZWXJdXuAParQTtpeAfkBi6NaHCLrCBqw@mail.gmail.com>
References: <CAFUG7Cd4KQRCCYamWQNnGUphY_OCXyeuqbK6DVcWT7AKko5=VA@mail.gmail.com>
	<alpine.DEB.2.11.1601111224120.27580@cpach.fuggernut.com>
	<CAFUG7CfS4uNp=Jxxc5bgf1s_X72Ezb8w5wg2zSdr=UnWCpYCQw@mail.gmail.com>
	<20160111190619.GA22809@localhost>
	<CAFUG7Cf+7wViua5YZCWt11_Q0253F3E4nzUPkfA9PoA8SHsNJA@mail.gmail.com>
	<CAFUG7CcudK5zu0eezuTmZrsakE4s-oHyPss3cubSRL5txQmA9Q@mail.gmail.com>
	<20160112065305.GA16215@gmail.com>
	<alpine.DEB.2.11.1601120821210.27580@cpach.fuggernut.com>
	<CAFUG7CcVGQBhmO0cRS4u_3Zz7uXbz+fh1rbrhbai45xZAUx=qQ@mail.gmail.com>
	<alpine.DEB.2.11.1601121245040.27580@cpach.fuggernut.com>
	<CAFUG7CcWbwG9fufWFUY=n9CJQFQpG+qQ8wY+3bE+Q2w_FSnb1A@mail.gmail.com>
	<CAFUG7CcFSs8XWD4XWQ6fVvJ13322b=h5vGrgd+4pKfcRiTmjYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34210 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbcAMBGE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jan 2016 20:06:04 -0500
Received: by mail-pa0-f42.google.com with SMTP id uo6so332262685pac.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jan 2016 17:06:04 -0800 (PST)
In-Reply-To: <CAFUG7CcFSs8XWD4XWQ6fVvJ13322b=h5vGrgd+4pKfcRiTmjYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thank you sage! The patch below allowed one of the two stuck OSDs to start up.
Whats the procedure from here? Is there a way to make Ceph consistent?
OSD 4 is still refusing to start, new error message however.

Should i drop OSD 4 and rebuild? If so whats the proper way to do
this? I've not started any VMs from the volumes yet, but i can rbd ls
-p compute which is new and ceph -s shows "health HEALTH_WARN 245 pgs
degraded; 245 pgs stuck unclean; recovery 23261/258270 objects
degraded (9.006%); 1/10 in osds are down"
How can i ensure everything is consistent before upgrading the cluster
to with hammer debs from the Mirantis repo?

Thank you very much for the assistance,
-Boris

Patch diff (slightly modified to compile):

--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -135,8 +135,22 @@ void PGPool::update(OSDMapRef map)
   name = map->get_pool_name(id);
   if (pi->get_snap_epoch() == map->get_epoch()) {
     pi->build_removed_snaps(newly_removed_snaps);
-    newly_removed_snaps.subtract(cached_removed_snaps);
-    cached_removed_snaps.union_of(newly_removed_snaps);
+    lgeneric_subdout(g_ceph_context, osd, 0) << __func__ << "
removed_snaps " << newly_removed_snaps << " cached_removed " <<
cached_removed_snaps << dendl;
+    interval_set<snapid_t> intersection;
+    intersection.intersection_of(newly_removed_snaps, cached_removed_snaps);
+    lgeneric_subdout(g_ceph_context, osd, 0)
+      << __func__ << " removed_snaps " << newly_removed_snaps
+      << " cached_removed " << cached_removed_snaps
+      << " interaction " << intersection
+      << dendl;
+    if (intersection == cached_removed_snaps) {
+      newly_removed_snaps.subtract(cached_removed_snaps);
+      cached_removed_snaps.union_of(newly_removed_snaps);
+    } else {
+      lgeneric_subdout(g_ceph_context, osd, 0) << __func__ << "
cached_removed_snaps shrank from " << cached_removed_snaps << dendl;
+      cached_removed_snaps = newly_removed_snaps;
+      newly_removed_snaps.clear();
+    }
     snapc = pi->get_snap_context();
   } else {
     newly_removed_snaps.clear();
@@ -1473,7 +1487,9 @@ void PG::activate(ObjectStore::Transaction& t,
     dout(20) << "activate - purged_snaps " << info.purged_snaps
             << " cached_removed_snaps " << pool.cached_removed_snaps << dendl;
     snap_trimq = pool.cached_removed_snaps;
-    snap_trimq.subtract(info.purged_snaps);
+    interval_set<snapid_t> intersection;
+    intersection.intersection_of(info.purged_snaps, snap_trimq);
+    snap_trimq.subtract(intersection);
     dout(10) << "activate - snap_trimq " << snap_trimq << dendl;
     if (!snap_trimq.empty() && is_clean())
       queue_snap_trim();

On Tue, Jan 12, 2016 at 3:21 PM, Boris Lukashev
<blukashev@sempervictus.com> wrote:
> Having added the following diff to the patch stack and rebuilt, i'm
> still seeing the two OSD not come up.
> However, with sage's help in IRC, i now have the following patch and
> changes to the librados hello world example to clean out bad snaps
> found via osd log 20:
>
> diff --git a/src/osd/PG.cc b/src/osd/PG.cc
> index d7174af..d78ee31 100644
> --- a/src/osd/PG.cc
> +++ b/src/osd/PG.cc
> @@ -137,7 +137,7 @@ void PGPool::update(OSDMapRef map)
>      pi->build_removed_snaps(newly_removed_snaps);
>      interval_set<snapid_t> intersection;
>      intersection.intersection_of(newly_removed_snaps, cached_removed_snaps);
> -    if (!(intersection == cached_removed_snaps)) {
> +    if (intersection == cached_removed_snaps) {
>        newly_removed_snaps.subtract(cached_removed_snaps);
>        cached_removed_snaps.union_of(newly_removed_snaps);
>      } else {
>
>
> in hello world, remove everything after io_ctx is initialized until
> the out: section and just before it, add
>   /*
>    * remove snapshots
>    */
>   {
>     io_ctx.selfmanaged_snap_remove(0x19+0xb);
>     io_ctx.selfmanaged_snap_remove(0x19+0xc);
>     io_ctx.selfmanaged_snap_remove(0x19+0xd);
>     io_ctx.selfmanaged_snap_remove(0x19+0xe);
>   }
>
> with appropriate pointers to the snaps.
>
> So, with the OSDs still not starting, i'm curious as to what the next
> step is - should i keep trying to get the OSDs up, or should i try to
> remove the snaps with the librados bin and then try to bring them up.
> Since i'm manually deleting things from Ceph, i figure i only get one
> shot so suggestions are very welcome :).
>
> Thanks as always,
> -Boris
>
> On Tue, Jan 12, 2016 at 1:03 PM, Boris Lukashev
> <blukashev@sempervictus.com> wrote:
>> I've put some of the output from debug osd 20 at
>> http://pastebin.com/he5snqwF, it seems one of the last operations is
>> in fact " activate - purged_snaps [1~5,8~2,b~d,19~f]
>> cached_removed_snaps [1~5,8~2,b~d,19~b]" which seems to make sense in
>> the context of this mismatch...
>> There is an ungodly amount of output from level 20, anything specific
>> you'd like me to grep for?
>>
>> On Tue, Jan 12, 2016 at 12:47 PM, Sage Weil <sage@newdream.net> wrote:
>>> On Tue, 12 Jan 2016, Boris Lukashev wrote:
>>>> Should i try altering the patch with the ! removed and reloading the
>>>> OSDs? (would read as ' if (intersection == cached_removed_snaps) { ')
>>>> Just for my own education on the matter - if there is disagreement
>>>> between the contents of an OSD and the map, like in this case where a
>>>> pending request seems to be outstanding, is there no mediation process
>>>> between the on-disk data (OSD) and metadata (map) services? With XFS
>>>> being used underneath most of the time, that strikes me as somewhat
>>>> scary - its not the most consistent of filesystems on the best of
>>>> days.
>>>>
>>>> With the mismatch between the OSD and map, but xfs_check coming back
>>>> clean, should i be worried about a corrupt cluster in the event that i
>>>> can somehow get it running?
>>>> I figure that with FireFly dying and Hammer available from Mirantis, i
>>>> should upgrade the cluster, but i would like to know what the safest
>>>> way forward is - i'd really prefer to keep using Ceph, its been
>>>> educational and quite handy, but if i have to rebuild the cluster
>>>> it'll need to keep playing nice with the Fuel deployed OpenStack. If i
>>>> can get access to the images stored by Glance and Swift metadata, i'll
>>>> gladly export and rebuild clean presuming i can figure out how. The
>>>> RBD images are already saved (manual export by tracking the rbd
>>>> segment hashes from the metadata files bearing volume-UUID
>>>> designations matching what i saw in Cinder, and dd-ing chunks into
>>>> flat files for raw images). Worst case, if the cluster wont come back
>>>> up and give me access to the data, what's the process for getting it
>>>> to a "clean" state such that i can upgrade to hammer and reseed my
>>>> glance, swift, and volume data from backups/exports? Do i need to
>>>> remove and re-add OSDs, or is there some darker magic at play to
>>>> ensure there are no remnants of bad data/messages?
>>>
>>> I think teh safe path is to
>>>
>>> (1) reproduce with debug osd = 20, so we can see what the removed_snaps is
>>> on the pg vs hte one in the osdmap.
>>>
>>> (2) fix the ! in the patch and restart the osds
>>>
>>> (3) re-add the deleted snaps to the osdmap so that things are back in
>>> sync.  This is possible through the librados API so it should be pretty
>>> simple to fix.  But, let's look at what (1) shows first.
>>>
>>> sage
>>>
>>>
>>>>
>>>> Thank you all
>>>> -Boris
>>>>
>>>> On Tue, Jan 12, 2016 at 8:24 AM, Sage Weil <sage@newdream.net> wrote:
>>>> > On Tue, 12 Jan 2016, Mykola Golub wrote:
>>>> >> On Mon, Jan 11, 2016 at 09:00:18PM -0500, Boris Lukashev wrote:
>>>> >> > In case anyone is following the mailing list later on, we spoke in IRC
>>>> >> > and Sage provided a patch - http://fpaste.org/309609/52550203/
>>>> >>
>>>> >> > diff --git a/src/osd/PG.cc b/src/osd/PG.cc
>>>> >> > index dc18aec..f9ee23c 100644
>>>> >> > --- a/src/osd/PG.cc
>>>> >> > +++ b/src/osd/PG.cc
>>>> >> > @@ -135,8 +135,16 @@ void PGPool::update(OSDMapRef map)
>>>> >> >    name = map->get_pool_name(id);
>>>> >> >    if (pi->get_snap_epoch() == map->get_epoch()) {
>>>> >> >      pi->build_removed_snaps(newly_removed_snaps);
>>>> >> > -    newly_removed_snaps.subtract(cached_removed_snaps);
>>>> >> > -    cached_removed_snaps.union_of(newly_removed_snaps);
>>>> >> > +    interval_set<snapid_t> intersection;
>>>> >> > +    intersection.intersection_of(newly_removed_snaps, cached_removed_snaps);
>>>> >> > +    if (!(intersection == cached_removed_snaps)) {
>>>> >> > +      newly_removed_snaps.subtract(cached_removed_snaps);
>>>> >>
>>>> >> Sage, won't it still violate the assert?
>>>> >> "intersection != cached_removed_snaps" means that cached_removed_snaps
>>>> >> contains snapshots missed in newly_removed_snaps, and we can't subtract?
>>>> >
>>>> > Oops, yeah, just remote the !.
>>>> >
>>>> > As you can see the problem is that the OSDMap's removed snaps shrank
>>>> > somehow.  If you crank up logging you can see what the competing sets
>>>> > are.
>>>> >
>>>> > An alternative fix/hack would be to modify the monitor to allow the
>>>> > snapids that were previously in the set to be added back into the OSDMap.
>>>> > That's arguably a better fix, although it's a bit more work.  But, even
>>>> > then, something like the above will be needed since there are still
>>>> > OSDMaps in the history where the set is smaller.
>>>> >
>>>> > sage
>>>> >
>>>> >>
>>>> >> > +      cached_removed_snaps.union_of(newly_removed_snaps);
>>>> >> > +    } else {
>>>> >> > +      lgeneric_subdout(g_ceph_context, osd, 0) << __func__ << " cached_removed_snaps shrank from " << cached_removed_snaps << dendl;
>>>> >> > +      cached_removed_snaps = newly_removed_snaps;
>>>> >> > +      newly_removed_snaps.clear();
>>>> >> > +    }
>>>> >> >      snapc = pi->get_snap_context();
>>>> >> >    } else {
>>>> >> >      newly_removed_snaps.clear();
>>>> >>
>>>> >> --
>>>> >> Mykola Golub
>>>> >>
>>>> >>
>>>> >>
>>>>
>>>>
