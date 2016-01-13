From: Alexey Sheplyakov <asheplyakov@mirantis.com>
Subject: Re: 7915 is not resolved
Date: Wed, 13 Jan 2016 19:49:51 +0300
Message-ID: <CAC7t81acPoRpjqUcAR=fu9L=0t=8UvgE6qBbW80m2A05Q_LNuA@mail.gmail.com>
References: <CAFUG7Cd4KQRCCYamWQNnGUphY_OCXyeuqbK6DVcWT7AKko5=VA@mail.gmail.com>
	<alpine.DEB.2.11.1601111224120.27580@cpach.fuggernut.com>
	<CAFUG7CfS4uNp=Jxxc5bgf1s_X72Ezb8w5wg2zSdr=UnWCpYCQw@mail.gmail.com>
	<20160111190619.GA22809@localhost>
	<CAFUG7Cf+7wViua5YZCWt11_Q0253F3E4nzUPkfA9PoA8SHsNJA@mail.gmail.com>
	<CAFUG7CcudK5zu0eezuTmZrsakE4s-oHyPss3cubSRL5txQmA9Q@mail.gmail.com>
	<20160112065305.GA16215@gmail.com>
	<alpine.DEB.2.11.1601120821210.27580@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33231 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbcAMQtx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jan 2016 11:49:53 -0500
Received: by mail-lb0-f171.google.com with SMTP id x4so37456712lbm.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 08:49:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601120821210.27580@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mykola Golub <mgolub@mirantis.com>, Boris Lukashev <blukashev@sempervictus.com>, ceph-devel@vger.kernel.org

Sage,

> As you can see the problem is that the OSDMap's removed snaps shrank somehow.

Should we teach master (infernalis, hammer) to handle such a situation
more gracefully too?
Or at least make the OSD fail with a more clear message?

Best regards,
     Alexey


On Tue, Jan 12, 2016 at 4:24 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 12 Jan 2016, Mykola Golub wrote:
>> On Mon, Jan 11, 2016 at 09:00:18PM -0500, Boris Lukashev wrote:
>> > In case anyone is following the mailing list later on, we spoke in IRC
>> > and Sage provided a patch - http://fpaste.org/309609/52550203/
>>
>> > diff --git a/src/osd/PG.cc b/src/osd/PG.cc
>> > index dc18aec..f9ee23c 100644
>> > --- a/src/osd/PG.cc
>> > +++ b/src/osd/PG.cc
>> > @@ -135,8 +135,16 @@ void PGPool::update(OSDMapRef map)
>> >    name = map->get_pool_name(id);
>> >    if (pi->get_snap_epoch() == map->get_epoch()) {
>> >      pi->build_removed_snaps(newly_removed_snaps);
>> > -    newly_removed_snaps.subtract(cached_removed_snaps);
>> > -    cached_removed_snaps.union_of(newly_removed_snaps);
>> > +    interval_set<snapid_t> intersection;
>> > +    intersection.intersection_of(newly_removed_snaps, cached_removed_snaps);
>> > +    if (!(intersection == cached_removed_snaps)) {
>> > +      newly_removed_snaps.subtract(cached_removed_snaps);
>>
>> Sage, won't it still violate the assert?
>> "intersection != cached_removed_snaps" means that cached_removed_snaps
>> contains snapshots missed in newly_removed_snaps, and we can't subtract?
>
> Oops, yeah, just remote the !.
>
> As you can see the problem is that the OSDMap's removed snaps shrank
> somehow.  If you crank up logging you can see what the competing sets
> are.
>
> An alternative fix/hack would be to modify the monitor to allow the
> snapids that were previously in the set to be added back into the OSDMap.
> That's arguably a better fix, although it's a bit more work.  But, even
> then, something like the above will be needed since there are still
> OSDMaps in the history where the set is smaller.
>
> sage
>
>>
>> > +      cached_removed_snaps.union_of(newly_removed_snaps);
>> > +    } else {
>> > +      lgeneric_subdout(g_ceph_context, osd, 0) << __func__ << " cached_removed_snaps shrank from " << cached_removed_snaps << dendl;
>> > +      cached_removed_snaps = newly_removed_snaps;
>> > +      newly_removed_snaps.clear();
>> > +    }
>> >      snapc = pi->get_snap_context();
>> >    } else {
>> >      newly_removed_snaps.clear();
>>
>> --
>> Mykola Golub
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
