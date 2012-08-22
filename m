From: Gregory Farnum <greg@inktank.com>
Subject: Re: wip-crush
Date: Wed, 22 Aug 2012 10:04:22 -0700
Message-ID: <CAPYLRzjmcOuSkxG1iO8GqEZPeLchKwKP94KizB7mXWzAU2a57w@mail.gmail.com>
References: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net>
	<5034F0B4.3060107@hastexo.com>
	<C4813C81-696A-4261-A4E7-991C719C0DB2@ornl.gov>
	<alpine.DEB.2.00.1208220929390.32470@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63010 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964802Ab2HVREY convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Aug 2012 13:04:24 -0400
Received: by lagy9 with SMTP id y9so695288lag.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 10:04:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208220929390.32470@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Atchley, Scott" <atchleyes@ornl.gov>, Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 22, 2012 at 9:33 AM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 22 Aug 2012, Atchley, Scott wrote:
>> On Aug 22, 2012, at 10:46 AM, Florian Haas wrote:
>>
>> > On 08/22/2012 03:10 AM, Sage Weil wrote:
>> >> I pushed a branch that changes some of the crush terminology.  In=
stead of
>> >> having a crush type called "pool" that requires you to say things=
 like
>> >> "pool=3Ddefault" in the "ceph osd crush set ..." command, it uses=
 "root"
>> >> instead.  That hopefully reinforces that it is a tree/hierarchy.
>> >>
>> >> There is also a patch that changes "bucket" to "node" throughout,=
 since
>> >> bucket is a term also used by radosgw.
>> >>
>> >> Thoughts?  I think the main pain in making this transition is tha=
t old
>> >> clusters have maps that have a type 'pool' and new ones won't, an=
d the
>> >> docs will need to walk people through both...
>> >
>> > "pool" in a crushmap being completely unrelated to a RADOS pool is
>> > something that I've heard customers/users report as confusing, as =
well.
>> > So changing that is probably a good thing. Naming it "root" is pro=
bably
>> > a good choice as well, as it happens to match
>> > http://ceph.com/wiki/Custom_data_placement_with_CRUSH.
>> >
>> > As for changing "bucket" to node... a "node" is normally simply a
>> > physical server (at least in HA terminology, which many potential =
Ceph
>> > users will be familiar with), and CRUSH uses "host" for that. So t=
hat's
>> > another recipe for confusion. How about using something super-gene=
ric,
>> > like "element" or "item"?
>> >
>> > Cheers,
>> > Florian
>>
>> My guess is that he is trying to use data structure tree nomenclatur=
e
>> (root, node, leaf). I agree that node is an overloaded term (as is
>> pool).
>
> Yeah...
>
>> As for an alternative to bucket which indicates the item is a
>> collection, what about subtree or branch?
>
> I think fixing the overloading of 'pool' in the default crush map is =
the
> biggest pain point.  I can live with crush 'buckets' staying the same=
 (esp
> since that's what the papers and code use pervasively) if we can't co=
me up
> with a better option.

I'm definitely most interested in replacing "pool", and "root" works
for that in my mind. RGW buckets live at a sufficiently different
level that I think people are unlikely to be confused =97=A0and "bucket=
"
is actually a good name for what they are (I'm open to better ones,
but I don't think that "node" qualifies).


> On the pool part, though, the challenge is how to transition.  Existi=
ng
> clusters have maps that use 'pool', and new clusters will use 'root' =
(or
> whatever).  Some options:
>
>  - document both.  this kills much of the benefit of switching, but i=
s
>    probably inevitable since people will be running different version=
s.
>  - make the upgrade process transparently rename the type.  this lets
>    all the tools use the new names.
>  - make the tools silently translate old names to new names.  this is
>    kludgey in that it makes the code make assumptions about the names=
 of
>    the data it is working with, but would cover everyone except those=
 who
>    created their own crush maps from scratch.
>  - ?
I would go with option two, and only document the new options =97=A0I
wouldn't be surprised if the number of people who had changed those
was zero. Anybody who has done so can certainly be counted on to pay
enough attention that a line note "changed CRUSH names (see here if
you customized your map)" would be sufficient, right?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
