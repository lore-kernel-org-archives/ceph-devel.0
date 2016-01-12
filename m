From: Boris Lukashev <blukashev@sempervictus.com>
Subject: Re: 7915 is not resolved
Date: Tue, 12 Jan 2016 13:03:42 -0500
Message-ID: <CAFUG7CcWbwG9fufWFUY=n9CJQFQpG+qQ8wY+3bE+Q2w_FSnb1A@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34292 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763068AbcALSDn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jan 2016 13:03:43 -0500
Received: by mail-pf0-f179.google.com with SMTP id q63so68400796pfb.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jan 2016 10:03:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601121245040.27580@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've put some of the output from debug osd 20 at
http://pastebin.com/he5snqwF, it seems one of the last operations is
in fact " activate - purged_snaps [1~5,8~2,b~d,19~f]
cached_removed_snaps [1~5,8~2,b~d,19~b]" which seems to make sense in
the context of this mismatch...
There is an ungodly amount of output from level 20, anything specific
you'd like me to grep for?

On Tue, Jan 12, 2016 at 12:47 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 12 Jan 2016, Boris Lukashev wrote:
>> Should i try altering the patch with the ! removed and reloading the
>> OSDs? (would read as ' if (intersection == cached_removed_snaps) { ')
>> Just for my own education on the matter - if there is disagreement
>> between the contents of an OSD and the map, like in this case where a
>> pending request seems to be outstanding, is there no mediation process
>> between the on-disk data (OSD) and metadata (map) services? With XFS
>> being used underneath most of the time, that strikes me as somewhat
>> scary - its not the most consistent of filesystems on the best of
>> days.
>>
>> With the mismatch between the OSD and map, but xfs_check coming back
>> clean, should i be worried about a corrupt cluster in the event that i
>> can somehow get it running?
>> I figure that with FireFly dying and Hammer available from Mirantis, i
>> should upgrade the cluster, but i would like to know what the safest
>> way forward is - i'd really prefer to keep using Ceph, its been
>> educational and quite handy, but if i have to rebuild the cluster
>> it'll need to keep playing nice with the Fuel deployed OpenStack. If i
>> can get access to the images stored by Glance and Swift metadata, i'll
>> gladly export and rebuild clean presuming i can figure out how. The
>> RBD images are already saved (manual export by tracking the rbd
>> segment hashes from the metadata files bearing volume-UUID
>> designations matching what i saw in Cinder, and dd-ing chunks into
>> flat files for raw images). Worst case, if the cluster wont come back
>> up and give me access to the data, what's the process for getting it
>> to a "clean" state such that i can upgrade to hammer and reseed my
>> glance, swift, and volume data from backups/exports? Do i need to
>> remove and re-add OSDs, or is there some darker magic at play to
>> ensure there are no remnants of bad data/messages?
>
> I think teh safe path is to
>
> (1) reproduce with debug osd = 20, so we can see what the removed_snaps is
> on the pg vs hte one in the osdmap.
>
> (2) fix the ! in the patch and restart the osds
>
> (3) re-add the deleted snaps to the osdmap so that things are back in
> sync.  This is possible through the librados API so it should be pretty
> simple to fix.  But, let's look at what (1) shows first.
>
> sage
>
>
>>
>> Thank you all
>> -Boris
>>
>> On Tue, Jan 12, 2016 at 8:24 AM, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 12 Jan 2016, Mykola Golub wrote:
>> >> On Mon, Jan 11, 2016 at 09:00:18PM -0500, Boris Lukashev wrote:
>> >> > In case anyone is following the mailing list later on, we spoke in IRC
>> >> > and Sage provided a patch - http://fpaste.org/309609/52550203/
>> >>
>> >> > diff --git a/src/osd/PG.cc b/src/osd/PG.cc
>> >> > index dc18aec..f9ee23c 100644
>> >> > --- a/src/osd/PG.cc
>> >> > +++ b/src/osd/PG.cc
>> >> > @@ -135,8 +135,16 @@ void PGPool::update(OSDMapRef map)
>> >> >    name = map->get_pool_name(id);
>> >> >    if (pi->get_snap_epoch() == map->get_epoch()) {
>> >> >      pi->build_removed_snaps(newly_removed_snaps);
>> >> > -    newly_removed_snaps.subtract(cached_removed_snaps);
>> >> > -    cached_removed_snaps.union_of(newly_removed_snaps);
>> >> > +    interval_set<snapid_t> intersection;
>> >> > +    intersection.intersection_of(newly_removed_snaps, cached_removed_snaps);
>> >> > +    if (!(intersection == cached_removed_snaps)) {
>> >> > +      newly_removed_snaps.subtract(cached_removed_snaps);
>> >>
>> >> Sage, won't it still violate the assert?
>> >> "intersection != cached_removed_snaps" means that cached_removed_snaps
>> >> contains snapshots missed in newly_removed_snaps, and we can't subtract?
>> >
>> > Oops, yeah, just remote the !.
>> >
>> > As you can see the problem is that the OSDMap's removed snaps shrank
>> > somehow.  If you crank up logging you can see what the competing sets
>> > are.
>> >
>> > An alternative fix/hack would be to modify the monitor to allow the
>> > snapids that were previously in the set to be added back into the OSDMap.
>> > That's arguably a better fix, although it's a bit more work.  But, even
>> > then, something like the above will be needed since there are still
>> > OSDMaps in the history where the set is smaller.
>> >
>> > sage
>> >
>> >>
>> >> > +      cached_removed_snaps.union_of(newly_removed_snaps);
>> >> > +    } else {
>> >> > +      lgeneric_subdout(g_ceph_context, osd, 0) << __func__ << " cached_removed_snaps shrank from " << cached_removed_snaps << dendl;
>> >> > +      cached_removed_snaps = newly_removed_snaps;
>> >> > +      newly_removed_snaps.clear();
>> >> > +    }
>> >> >      snapc = pi->get_snap_context();
>> >> >    } else {
>> >> >      newly_removed_snaps.clear();
>> >>
>> >> --
>> >> Mykola Golub
>> >>
>> >>
>> >>
>>
>>
