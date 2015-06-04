From: Gregory Farnum <greg@gregs42.com>
Subject: Re: RBD journal draft design
Date: Wed, 3 Jun 2015 17:01:42 -0700
Message-ID: <CAC6JEv_M5jKk+FSDZja15Rmyf3W2x5-yeg9LRukKCHLnYq-j+w@mail.gmail.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com>
	<1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com>
	<CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com>
	<1679134333.10270211.1433348013379.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35793 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbbFDABp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 20:01:45 -0400
Received: by lbbtu8 with SMTP id tu8so1183588lbb.2
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2015 17:01:44 -0700 (PDT)
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com. [209.85.215.43])
        by mx.google.com with ESMTPSA id f2sm110217lah.39.2015.06.03.17.01.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2015 17:01:43 -0700 (PDT)
Received: by laei3 with SMTP id i3so20059378lae.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2015 17:01:42 -0700 (PDT)
In-Reply-To: <1679134333.10270211.1433348013379.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 3, 2015 at 9:13 AM, Jason Dillaman <dillaman@redhat.com> wr=
ote:
>> > In contrast to the current journal code used by CephFS, the new jo=
urnal
>> > code will use sequence numbers to identify journal entries, instea=
d of
>> > offsets within the journal.
>>
>> Am I misremembering what actually got done with our journal v2 forma=
t?
>> I think this is done =E2=80=94 or at least we made a move in this di=
rection.
>
> Assuming journal v2 is the code in osdc/Journaler.cc, there is a new =
"resilient" format that helps in detecting corruption, but it appears t=
o be still largely based upon offsets and using the Filer/Striper for I=
/O.  This does remind me that I probably want to include a magic preamb=
le value at the start of each journal entry to facilitate recovery.

Ah yeah, I was confusing the changes we did there and in our MDLog
wrapper bits. Ignore me on this bit.

>
>> > A new journal object class method will be used to submit journal e=
ntry
>> > append requests.  This will act as a gatekeeper for the concurrent=
 client
>> > case.
>>
>> The object class is going to be a big barrier to using EC pools;
>> unless you want to block the use of EC pools on EC pools supporting
>> object classes. :(
>
> Josh mentioned (via Sam) that reads were not currently supported by o=
bject classes on EC pools.  Are appends not supported either?

We discussed this briefly and certain object class functions might
work "by mistake" on EC pools, but you should assume nothing does (is
my recollection of the conclusions). For instance, even if it's
technically possible, the append thing is really hard for this sort of
write; I think I mentioned in Josh's thread about needing to have an
entire stripe at a time (and the smallest you could even think about
doing reasonably is 4KB * N, and really that's not big enough given
metadata overheads).

>
>> >A successful append will indicate whether or not the journal is now=
 full
>> >(larger than the max object size), indicating to the client that a =
new
>> >journal object should be used.  If the journal is too large, an err=
or code
>> >responce would alert the client that it needs to write to the curre=
nt
>> >active journal object.  In practice, the only time the journaler sh=
ould
>> >expect to see such a response would be in the case where multiple c=
lients
>> >are using the same journal and the active object update notificatio=
n has
>> >yet to be received.
>>
>> I'm confused. How does this work with the splay count thing you
>> mentioned above? Can you define <splay count>?
>
> Similar to the stripe width.

Okay, that sort of makes sense but I don't see how you could legally
be writing to different "sets" so why not just make it an explicit
striping thing and move all journal entries for that "set" at once?

=2E..Actually, doesn't *not* forcing a coordinated move from one object
set to another mean that you don't actually have an ordering guarantee
across tags if you replay the journal objects in order?


>
>> What happens if users submit sequenced entries substantially out of
>> order? It sounds like if you have multiple writers (or even just a
>> misbehaving client) it would not be hard for one of them to grab
>> sequence value N, for another to fill up one of the journal entry
>> objects with sequences in the range [N+1]...[N+x] and then for the
>> user of N to get an error response.
>
> I was thinking that when a client submits their journal entry payload=
, the journaler will allocate the next available sequence number, compu=
te which active journal object that sequence should be submitted to, an=
d start an AIO append op to write the journal entry.  The next journal =
entry to be appended to the same journal object would be <splay count/w=
idth> entries later.  This does bring up a good point that if you are g=
enerating journal entries fast enough, the delayed response saying the =
object is full could cause multiple later journal entry ops to need to =
be resent to the new (non-full) object.  Given that, it might be best t=
o scrap the hard error when the journal object gets full and just let t=
he journaler eventually switch to a new object when it receives a respo=
nse saying the object is now full.

I was misunderstanding where the seqs came from and that they were
associated with the tag, not the journal. So this shouldn't be such a
problem.

>
>> >
>> > Since the journal is designed to be append-only, there needs to be=
 support
>> > for cases where journal entry needs to be updated out-of-band (e.g=
=2E fixing
>> > a corrupt entry similar to CephFS's current journal recovery tools=
).  The
>> > proposed solution is to just append a new journal entry with the s=
ame
>> > sequence number as the record to be replaced to the end of the jou=
rnal
>> > (i.e. last entry for a given sequence number wins).  This also pro=
tects
>> > against accidental replays of the original append operation.  An
>> > alternative suggestion would be to use a compare-and-swap mechanis=
m to
>> > update the full journal object with the updated contents.
>>
>> I'm confused by this bit. It seems to imply that fetching a single
>> entry requires checking the entire object to make sure there's no
>> replacement. Certainly if we were doing replay we couldn't just appl=
y
>> each entry sequentially any more because an overwritten entry might
>> have its value replaced by a later (by sequence number) entry that
>> occurs earlier (by offset) in the journal.
>
> The goal would be to use prefetching on the replay.  Since the whole =
object is already in-memory, scanning for duplicates would be fairly tr=
ivial.  If there is a way to prevent the OSDs from potentially replayin=
g a duplicate append journal entry message, the CAS update technique co=
uld be used.

Actually don't you need to keep <splay count> objects prefetched in
memory, because the ops round-robin across them?

>
>> I'd also like it if we could organize a single Journal implementatio=
n
>> within the Ceph project, or at least have a blessed one going forwar=
d
>> that we use for new stuff and might plausibly migrate existing users
>> to. The big things I see different from osdc/Journaler are:
>
> Agreed.  While librbd will be the first user of this, I wasn't planni=
ng to locate it within the librbd library.
>
>> 1) (design) class-based
>> 2) (design) uses librados instead of Objecter (hurray)
>> 3) (need) should allow multiple writers
>> 4) (fallout of other choices?) does not stripe entries across multip=
le
>> objects
>
> For striping, I assume this is a function of how large MDS journal en=
tries are expected to be.  The largest RBD journal entries would be blo=
ck write operations, so in the low kilobytes.  It would be possible to =
add a higher layer to this design that could break-up large client jour=
nal entries into multiple, smaller entries.

Really we just picked up the striping for free by making use of the
=46iler to handle our data layout. ;) We don't ever enable it ourself
and I don't think it matters.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
