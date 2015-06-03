From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD journal draft design
Date: Wed, 3 Jun 2015 12:13:33 -0400 (EDT)
Message-ID: <1679134333.10270211.1433348013379.JavaMail.zimbra@redhat.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com> <1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com> <CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:56535 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586AbbFCQNg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 12:13:36 -0400
In-Reply-To: <CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> > In contrast to the current journal code used by CephFS, the new jou=
rnal
> > code will use sequence numbers to identify journal entries, instead=
 of
> > offsets within the journal.
>=20
> Am I misremembering what actually got done with our journal v2 format=
?
> I think this is done =E2=80=94 or at least we made a move in this dir=
ection.

Assuming journal v2 is the code in osdc/Journaler.cc, there is a new "r=
esilient" format that helps in detecting corruption, but it appears to =
be still largely based upon offsets and using the Filer/Striper for I/O=
=2E  This does remind me that I probably want to include a magic preamb=
le value at the start of each journal entry to facilitate recovery.

> > A new journal object class method will be used to submit journal en=
try
> > append requests.  This will act as a gatekeeper for the concurrent =
client
> > case.
>=20
> The object class is going to be a big barrier to using EC pools;
> unless you want to block the use of EC pools on EC pools supporting
> object classes. :(

Josh mentioned (via Sam) that reads were not currently supported by obj=
ect classes on EC pools.  Are appends not supported either?

> >A successful append will indicate whether or not the journal is now =
full
> >(larger than the max object size), indicating to the client that a n=
ew
> >journal object should be used.  If the journal is too large, an erro=
r code
> >responce would alert the client that it needs to write to the curren=
t
> >active journal object.  In practice, the only time the journaler sho=
uld
> >expect to see such a response would be in the case where multiple cl=
ients
> >are using the same journal and the active object update notification=
 has
> >yet to be received.
>=20
> I'm confused. How does this work with the splay count thing you
> mentioned above? Can you define <splay count>?

Similar to the stripe width.

> What happens if users submit sequenced entries substantially out of
> order? It sounds like if you have multiple writers (or even just a
> misbehaving client) it would not be hard for one of them to grab
> sequence value N, for another to fill up one of the journal entry
> objects with sequences in the range [N+1]...[N+x] and then for the
> user of N to get an error response.

I was thinking that when a client submits their journal entry payload, =
the journaler will allocate the next available sequence number, compute=
 which active journal object that sequence should be submitted to, and =
start an AIO append op to write the journal entry.  The next journal en=
try to be appended to the same journal object would be <splay count/wid=
th> entries later.  This does bring up a good point that if you are gen=
erating journal entries fast enough, the delayed response saying the ob=
ject is full could cause multiple later journal entry ops to need to be=
 resent to the new (non-full) object.  Given that, it might be best to =
scrap the hard error when the journal object gets full and just let the=
 journaler eventually switch to a new object when it receives a respons=
e saying the object is now full.

> >
> > Since the journal is designed to be append-only, there needs to be =
support
> > for cases where journal entry needs to be updated out-of-band (e.g.=
 fixing
> > a corrupt entry similar to CephFS's current journal recovery tools)=
=2E  The
> > proposed solution is to just append a new journal entry with the sa=
me
> > sequence number as the record to be replaced to the end of the jour=
nal
> > (i.e. last entry for a given sequence number wins).  This also prot=
ects
> > against accidental replays of the original append operation.  An
> > alternative suggestion would be to use a compare-and-swap mechanism=
 to
> > update the full journal object with the updated contents.
>=20
> I'm confused by this bit. It seems to imply that fetching a single
> entry requires checking the entire object to make sure there's no
> replacement. Certainly if we were doing replay we couldn't just apply
> each entry sequentially any more because an overwritten entry might
> have its value replaced by a later (by sequence number) entry that
> occurs earlier (by offset) in the journal.

The goal would be to use prefetching on the replay.  Since the whole ob=
ject is already in-memory, scanning for duplicates would be fairly triv=
ial.  If there is a way to prevent the OSDs from potentially replaying =
a duplicate append journal entry message, the CAS update technique coul=
d be used.

> I'd also like it if we could organize a single Journal implementation
> within the Ceph project, or at least have a blessed one going forward
> that we use for new stuff and might plausibly migrate existing users
> to. The big things I see different from osdc/Journaler are:

Agreed.  While librbd will be the first user of this, I wasn't planning=
 to locate it within the librbd library.

> 1) (design) class-based
> 2) (design) uses librados instead of Objecter (hurray)
> 3) (need) should allow multiple writers
> 4) (fallout of other choices?) does not stripe entries across multipl=
e
> objects

=46or striping, I assume this is a function of how large MDS journal en=
tries are expected to be.  The largest RBD journal entries would be blo=
ck write operations, so in the low kilobytes.  It would be possible to =
add a higher layer to this design that could break-up large client jour=
nal entries into multiple, smaller entries.

> Using librados instead of the Objecter might make this tough to use i=
n
> the MDS, but we've already got journaling happening in a separate
> thread and it's one of the more isolated bits of code so we might be
> able to handle it. I'm not sure if we'd want to stripe across objects
> or not, but the possibility does appeal to me.
>=20
> >
> > Journal Header
> > ~~~~~~~~~~~~~~
> >
> > omap
> > * soft max object size
> > * journal objects splay count
> > * min object number
> > * most recent active journal objects (could be out-of-date)
> > * registered clients
> >   * client description (i.e. zone)
> >   * journal entry tag
> >   * last committed sequence number
>=20
> omap definitely doesn't go in EC pools =E2=80=94 I'm not sure how blu=
e-sky you
> were thinking when you mentioned those. :)

Did not realize that.  Good to know.

> More generally the naive client implementation would be pretty slow t=
o
> commit something (go to header for sequence number, write data out).
> Do you expect to always have a queue of sequence numbers available in
> case you need to do an immediate commit of data? What makes the singl=
e
> header sequence assignment be not a bottleneck on its own for multipl=
e
> clients? It will need to do a write each time...

There is no need to go to the header for a sequence number.  Multiple (=
out-of-process) writers to the same journal would need to use a differe=
nt tag so that they would have their own sequence number set.

> -Greg
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
