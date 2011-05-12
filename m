From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: rados pool object listing suckage
Date: Thu, 12 May 2011 13:59:51 -0700
Message-ID: <BANLkTimJNG2nrPz1ec3jJtkQgVgJFHFvAg@mail.gmail.com>
References: <Pine.LNX.4.64.1105111445100.14296@cobra.newdream.net>
	<BANLkTi=q+Ksrp_E1Wecyr5BDDym6qndHSQ@mail.gmail.com>
	<Pine.LNX.4.64.1105121059420.19492@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57384 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758559Ab1ELU7y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 16:59:54 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A0BB7C066
	for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 13:59:53 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2C7E3C062
	for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 13:59:53 -0700 (PDT)
Received: by eyx24 with SMTP id 24so541534eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 13:59:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105121059420.19492@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, ceph-devel@vger.kernel.org

So it occurs to me that one thing we could do in the Objecter layer,
to make this a bit more sane, is to optionally enable caching of the
missing objects. Then the OSD could send out all the missing objects
with a flag saying that they're missing, the Objecter could cache this
list, go through the on-disk objects as normal, and then return to the
caller in subsequent calls the missing objects that weren't returned
in the normal listing. This wouldn't have bounded memory use exactly,
but it would be less and the Objecter could give up if the size of the
missing list gets too large.
(We could store this in the ListContext.)
-Greg

On Thu, May 12, 2011 at 11:18 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 12 May 2011, Colin McCabe wrote:
>> On Wed, May 11, 2011 at 2:57 PM, Sage Weil <sage@newdream.net> wrote=
:
>> > The ability to list objects in rados pools is something we origina=
lly
>> > added to round out the librados interface and to support the requi=
rements
>> > of radosgw (S3 and swift both let you list objects in buckets). =A0=
The
>> > current interface is stateless. =A0You iterate over the PGs in the=
 pool, and
>> > for each one, request up to N objects. =A0The result has up to N r=
esults and
>> > (optionally) a cookie to continue and get more objects for that pg=
=2E
>> > Currently, that cookie is a readdir offset from the directory on t=
he
>> > server.
>> >
>> > The problem is that we currently list objects based only on what w=
e have
>> > on disk. =A0If the PG is degraded and we're recovery, we miss any =
objects
>> > that aren't yet copied locally.
>> >
>> > Because the 'list all objects in a pool' operation consists of man=
y
>> > smaller requests, and there is no state to associate them, it's ha=
rd to
>> > solve this one correctly. =A0The osd _knows_ which objects are mis=
sing at
>> > all times, but it needs to include those in the results in a sane =
way.
>> >
>> > My original thought was use the low 2^63 values of the offset/cook=
ie to
>> > represent any (potentially) missing objects and use that as an ind=
ex into
>> > the missing set, and then use the high values to represent the rea=
ddir
>> > offset. =A0That's easy enough to do (and I just did), but because =
recovery
>> > is progressing while the client is doing the series of list-object=
s calls,
>> > you can get duplicates (client sees an object while it was missing=
, and
>> > also sees it later when it was on disk). =A0Conversely, if a pg st=
arts out
>> > as not degraded, we may return no missing objects, and later retur=
n an
>> > incomplete set of on-disk objects because the primary changed.
>> >
>> > This approach can be hacked if the client restarts the whole proce=
ss (for
>> > a given pg) when the primary changes (because, for any given pg ma=
pping,
>> > the missing set will also shrink or stay the same). =A0That will w=
ork, but
>> > will potentially return some objects twice.
>>
>> Can the client keep track of all the objects it has already seen? Th=
en
>> it could eliminate dups from the result it gets from the server.
>>
>> You can't track this information on the server because of the obviou=
s
>> DDOS exploit, but it seems like the client could keep around this
>> state.
>
> So radosgw does that (it has to sort the full list alphanumerically, =
even,
> blech!). =A0Objecter and librados don't though, because otherwise any=
 user
> would incur the overhead of doing the filter step (which involves bui=
lding
> a set<object_t> and is expensive for a very large pool).
>
> I guess barring anything super clever we haven't thought of, I'm incl=
ined
> to leave dedup as the Objecter/librados user's responsibility. =A0Tha=
t's
> what I committed yesterday.
>
> This is hard because we're sharding the pool contents across multiple=
 PGs
> on different nodes for scalability. =A0I assume S3 is also sharding b=
ucket
> contents across multiple nodes, but they always return the object lis=
t
> alphanumerically sorted (!), so there must be a separate index stored
> centrally somewhere. =A0That architectural difference makes meeting t=
heir
> API requirement in radosgw expensive.
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
