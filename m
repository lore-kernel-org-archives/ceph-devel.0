From: Gregory Farnum <greg@gregs42.com>
Subject: Re: RBD journal draft design
Date: Tue, 2 Jun 2015 17:39:15 -0700
Message-ID: <CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com>
	<1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35618 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbFCAjR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2015 20:39:17 -0400
Received: by qkhq76 with SMTP id q76so82487893qkh.2
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jun 2015 17:39:17 -0700 (PDT)
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com. [209.85.216.179])
        by mx.google.com with ESMTPSA id o19sm8292834qkh.25.2015.06.02.17.39.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 17:39:16 -0700 (PDT)
Received: by qcmi9 with SMTP id i9so67186604qcm.0
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jun 2015 17:39:16 -0700 (PDT)
In-Reply-To: <1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jun 2, 2015 at 8:11 AM, Jason Dillaman <dillaman@redhat.com> wr=
ote:
> I am posting to get wider review/feedback on this draft design.  In s=
upport of the RBD mirroring feature [1], a new client-side journaling c=
lass will be developed for use by librbd.  The implementation is design=
ed to carry opaque journal entry payloads so it will be possible to be =
re-used in other applications as well in the future.  It will also use =
the librados API for all operations.  At a high level, a single journal=
 will be composed of a journal header to store metadata and multiple jo=
urnal objects to contain the individual journal entries.
>
> Journal objects will be named "<journal object prefix>.<journal id>.<=
object number>".  An individual journal object will hold one or more jo=
urnal entries, appended one after another.  Journal objects will have a=
 configurable soft maximum size.  After the size has been exceeded, a n=
ew journal object (numbered current object + number of journal objects)=
 will be created for future journal entries and the header active set w=
ill be updated so that other clients know that a new journal object was=
 created.
>
> In contrast to the current journal code used by CephFS, the new journ=
al code will use sequence numbers to identify journal entries, instead =
of offsets within the journal.

Am I misremembering what actually got done with our journal v2 format?
I think this is done =E2=80=94 or at least we made a move in this direc=
tion.

> Additionally, a given journal entry will not be striped across multip=
le journal objects.  Journal entries will be mapped to journal objects =
using the sequence number: <sequence number> mod <splay count> =3D=3D <=
object number> mod <splay count> for active journal objects.

Okay, that's different.

>
> The rationale for this difference is to facilitate parallelism for ap=
pends as journal entries will be splayed across a configurable number o=
f journal objects.  The journal API for appending a new journal entry w=
ill return a future which can be used to retrieve the assigned sequence=
 number for the submitted journal entry payload once committed to disk.=
 The use of a future allows for asynchronous journal entry submissions =
by default and can be used to simplify integration with the client-side=
 cache writeback handler (and as a potential future enhacement to delay=
 appends to the journal in order to satisfy EC-pool alignment requireme=
nts).
>
> Sequence numbers are treated as a monotonically increasing integer fo=
r a given value of journal entry tag.  This allows for the possibility =
for multiple clients to concurrently use the same journal (e.g. all RBD=
 disks within a given VM could use the same journal).  This will provid=
e a loose coupling of operations between different clients using the sa=
me journal.
>
> A new journal object class method will be used to submit journal entr=
y append requests.  This will act as a gatekeeper for the concurrent cl=
ient case.

The object class is going to be a big barrier to using EC pools;
unless you want to block the use of EC pools on EC pools supporting
object classes. :(

>A successful append will indicate whether or not the journal is now fu=
ll (larger than the max object size), indicating to the client that a n=
ew journal object should be used.  If the journal is too large, an erro=
r code responce would alert the client that it needs to write to the cu=
rrent active journal object.  In practice, the only time the journaler =
should expect to see such a response would be in the case where multipl=
e clients are using the same journal and the active object update notif=
ication has yet to be received.

I'm confused. How does this work with the splay count thing you
mentioned above? Can you define <splay count>?

What happens if users submit sequenced entries substantially out of
order? It sounds like if you have multiple writers (or even just a
misbehaving client) it would not be hard for one of them to grab
sequence value N, for another to fill up one of the journal entry
objects with sequences in the range [N+1]...[N+x] and then for the
user of N to get an error response.

>
> All the journal objects will be tied together by means of a journal h=
eader object, named "<journal header prefix>.<journal id>".  This objec=
t will contain the current committed journal entry positions of all reg=
istered clients.  In librbd's case, each mirrored copy of an image woul=
d be a new registered client.  OSD class methods would be used to creat=
e/manipulate the journal header to serialize modifications from multipl=
e clients.
>
> Journal recovery / playback will iterate through each journal entry f=
rom the journal, in sequence order.  Journal objects will be prefetched=
 (where possible) to a configurable amount to improve the latency.  Jou=
rnal entry playback can use an optional client-specified filter to only=
 iterate over entries with a matching journal entry tag.  The API will =
need to support the use case of an external client periodically testing=
 the journal for new data.
>
> Journal trimming will be accomplished by removing a whole journal obj=
ect.  Only after all registered users of the journal have indicated tha=
t they have committed all journal entries within the journal object (vi=
a an update to the journal header metadata) will the journal object be =
deleted and the header updated to indicate the new starting object numb=
er.
>
> Since the journal is designed to be append-only, there needs to be su=
pport for cases where journal entry needs to be updated out-of-band (e.=
g. fixing a corrupt entry similar to CephFS's current journal recovery =
tools).  The proposed solution is to just append a new journal entry wi=
th the same sequence number as the record to be replaced to the end of =
the journal (i.e. last entry for a given sequence number wins).  This a=
lso protects against accidental replays of the original append operatio=
n.  An alternative suggestion would be to use a compare-and-swap mechan=
ism to update the full journal object with the updated contents.

I'm confused by this bit. It seems to imply that fetching a single
entry requires checking the entire object to make sure there's no
replacement. Certainly if we were doing replay we couldn't just apply
each entry sequentially any more because an overwritten entry might
have its value replaced by a later (by sequence number) entry that
occurs earlier (by offset) in the journal.

I'd also like it if we could organize a single Journal implementation
within the Ceph project, or at least have a blessed one going forward
that we use for new stuff and might plausibly migrate existing users
to. The big things I see different from osdc/Journaler are:

1) (design) class-based
2) (design) uses librados instead of Objecter (hurray)
3) (need) should allow multiple writers
4) (fallout of other choices?) does not stripe entries across multiple =
objects

Using librados instead of the Objecter might make this tough to use in
the MDS, but we've already got journaling happening in a separate
thread and it's one of the more isolated bits of code so we might be
able to handle it. I'm not sure if we'd want to stripe across objects
or not, but the possibility does appeal to me.

>
> Journal Header
> ~~~~~~~~~~~~~~
>
> omap
> * soft max object size
> * journal objects splay count
> * min object number
> * most recent active journal objects (could be out-of-date)
> * registered clients
>   * client description (i.e. zone)
>   * journal entry tag
>   * last committed sequence number

omap definitely doesn't go in EC pools =E2=80=94 I'm not sure how blue-=
sky you
were thinking when you mentioned those. :)

More generally the naive client implementation would be pretty slow to
commit something (go to header for sequence number, write data out).
Do you expect to always have a queue of sequence numbers available in
case you need to do an immediate commit of data? What makes the single
header sequence assignment be not a bottleneck on its own for multiple
clients? It will need to do a write each time...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
