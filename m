From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: RE: Erasure coding library API
Date: Wed, 3 Jul 2013 20:06:19 -0700
Message-ID: <622F4407872BA447A16110F65453358C01A4D80674CF@FMSAMAIL.fmsa.local>
References: <51D20A03.1030204@dachary.org>
 <68444BDD-2068-4850-998D-C65449C20353@ornl.gov>
 <14B8F72D-C792-4829-9F9B-1175CB27F3EA@ornl.gov>
 <CA+4uBUavSx4SKYB0BQbqz+NqPTy2_WYiFTUWSAXcSJQzJQ9TGQ@mail.gmail.com>
 <622F4407872BA447A16110F65453358C01A4D8067419@FMSAMAIL.fmsa.local>
 <487BCFAF-6093-4E0D-BE80-26D8D919EF4D@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu24.fnanic.fujitsu.com ([192.240.6.14]:56992 "EHLO
	fujitsu24.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932633Ab3GDDDM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 23:03:12 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>, "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Samuel Just <sam.just@inktank.com>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Scott, et al.

Here is an interesting paper from Usenix HotStorage Conference which provides local codes without additional capacity overhead.

Check it out. (abstract with links to paper and slides)
https://www.usenix.org/conference/hotstorage13/solution-network-challenges-data-recovery-erasure-coded-distributed-storage

Cheers,
pvs

> On Jul 3, 2013, at 11:19 AM, Paul Von-Stamwitz wrote:
> 
> Hi Scott,
> 
> Point taken.
> 
> I was thinking about Loic's decode description where k+m was requested and
> data was decoded when k blocks were received. But he was referring to full
> stripe reads where all the memory is allocated.
> 
> Degraded reads and block repair are a different matter.
> 
> pvs
> 
> > On Jul 3, 2013, at 4:53 AM Scott Atchley wrote:
> >
> > On Jul 2, 2013, at 10:12 PM, Paul Von-Stamwitz
> > <PVonStamwitz@us.fujitsu.com> wrote:
> >
> > > Scott,
> > >
> > > You make a good point comparing (5/3) RS with Xorbas, but a small nit:
> > >
> > > "The I/O to recover from a single failure for both schemes is 5 blocks
> > so it is as efficient as Xorbas."
> > >
> > > Maybe not. You would probably issue I/O to all the remaining 7 blocks
> to
> > cover for the possibility of double errors. The time to reconstruct
> would
> > be about the same, but there could be more disk and network I/O. (LRC
> will
> > need to issue I/O to the rest of the global stripe if it detected
> multiple
> > local errors.)
> >
> > Why would you request more than five? If one cannot be read, request
> > another.
> >
> > Also, I am not sure that you want to request five at once since it will
> > lead to spikes in network traffic and require memory for all five blocks.
> > You will need at least two buffers. Request the first two and start the
> > decoding. You may want a third buffer to overlap the decoding of the
> > current block with the communication for the next block. It may be that
> > the decode time is less than the communication and, in that case, you
> will
> > want to request all of the blocks at once.
> >
> > > What I like about Xorbas is that it is an extension of a (x,y) RS. You
> > can start with traditional RS. If degraded reads and repaired blocks are
> > causing a problem, you can add the LRC. If capacity is an issue, you can
> > take it out.
> >
> > I like it too and Microsoft has something similar with Pyramid codes.
> That
> > said, my example using traditional RS can provide more fault-tolerance
> on
> > average given the same amount of storage overhead.
> >
> > >
> > > Best,
> > > Paul
> > >
> > > On Tue, Jul 2, 2013 at 2:33 PM, Samuel Just wrote:
> > >> I think we should be able to cover most cases by adding an interface
> > like:
> > >>
> > >> set<int> minimum_to_read(const set<int> &want_to_read, const set<int>
> > >> &available_chunks);
> > >>
> > >> which returns the smallest set required to read/rebuild the chunks in
> > >> want_to_read given the chunks in available_chunks.  Alternately, we
> > might
> > >> include a "cost" for reading each chunk like
> > >>
> > >> set<int> minimum_to_read_with_cost(const set<int> &want_to_read,
> const
> > >> map<int, int> &available)
> > >>
> > >> which returns the minimum cost set required to read the specified
> > chunks
> > >> given a mapping of available chunks to costs.  The costs might allow
> us
> > to
> > >> consider the difference between reading local chunks vs remote chunks.
> > >> This should be sufficient to cover the read case (esp the degraded
> read
> > >> case) and the repair case.
> > >> -Sam
> > >>
> > >> On Tue, Jul 2, 2013 at 10:14 AM, Atchley, Scott <atchleyes@ornl.gov>
> > >> wrote:
> > >>> On Jul 2, 2013, at 10:07 AM, "Atchley, Scott" <atchleyes@ornl.gov>
> > >> wrote:
> > >>>
> > >>>> On Jul 1, 2013, at 7:00 PM, Loic Dachary <loic@dachary.org> wrote:
> > >>>>
> > >>>>> Hi,
> > >>>>>
> > >>>>> Today Sam pointed out that the API for LRC ( Xorbas Hadoop Project
> > >> Page, Locally Repairable Codes (LRC) http://smahesh.com/HadoopUSC/
> for
> > >> instance ) would need to be different from the one initialy proposed:
> > >>>>
> > >>>> An interesting video. Not as entertaining as Jim Plank's video. ;-)
> > >>>>
> > >>>> While Plank's focused on the processor requirements for
> > >> encoding/decoding, this video focuses on the network and disk I/O
> > >> requirements.
> > >>>>
> > >>>>>  context(k, m, reed-solomon|...) => context* c
> > >>>>>  encode(context* c, void* data) => void* chunks[k+m]
> > >>>>>  decode(context* c, void* chunk[k+m], int*
> > >>>>> indices_of_erased_chunks) => void* data // erased chunks are not
> > used
> > >>>>>  repair(context* c, void* chunk[k+m], int*
> > >>>>> indices_of_erased_chunks) => void* chunks[k+m] // erased chunks
> are
> > >>>>> rebuilt
> > >>>>>
> > >>>>> The decode function must allow for partial read:
> > >>>>>
> > >>>>>  decode(context* c, int offset, int length, void* chunk[k+m], int*
> > >>>>> indices_of_erased_chunks, int* missing_chunks) => void* data
> > >>>>>
> > >>>>> If there are not enough chunks to recover the desired data range
> > >> [offset, offset+length) the function returns NULL and sets
> > missing_chunks
> > >> to the list of chunks that must be retrieved in order to be able to
> > read
> > >> the desired data.
> > >>>>>
> > >>>>> If decode is called to read just 1 chunk and it is missing, reed-
> > >> solomon would return on error and ask for all other chunks to repair.
> > If
> > >> the underlying library implements LRC, it would ask for a subset of
> the
> > >> chunks.
> > >>>>>
> > >>>>> An implementation allowing only full reads and using jerasure
> > ( which
> > >> does not do LRC ) requires that offset is always zero, length is the
> > size
> > >> of the object and returns a copy of indices_of_erased_chunks if there
> > are
> > >> not enough chunks to rebuild the missing ones.
> > >>>>>
> > >>>>> Comments are welcome :-)
> > >>>>
> > >>>> I have loosely followed this discussion and I have not looked
> closely
> > >> at the proposed API nor at the jerasure interface. My apologies if
> this
> > >> has already been addressed.
> > >>>>
> > >>>> It is not clear to me from the above proposed API (ignoring the
> > partial
> > >> read) what it would do. Was the original intent to encode the entire
> > file
> > >> using k+m blocks irregardless of the file size and of the rados
> object
> > >> size?
> > >>>>
> > >>>> If so, how will you map rados objects to the logical k+m objects
> and
> > >> vice versa?
> > >>>>
> > >>>> If not, then the initial API needed an offset and length (either
> > >> logical or rados object).
> > >>>>
> > >>>> I would assume that you would want to operate on rados sized
> objects.
> > >> Given a fixed k+m, then you may have more than one set of k+m objects
> > per
> > >> file. This is ignoring the LRC "local" parity blocks. For example, if
> > the
> > >> rados object size if 1 MB and k = 10 and m = 4 (as in the Xorbas
> video),
> > >> then for a 20 MB file one would need two sets of encoding blocks. The
> > >> first for objects 1-10 and the second for objects 11-20.
> > >>>>
> > >>>> Perhaps, this is what the context is above. If so, it should have
> the
> > >> logical offset and rados object size, no?
> > >>>>
> > >>>> I see value in the Xorbas concept and I wonder if the jerasure
> > library
> > >> can be modified to generate the local parity blocks such that they
> can
> > be
> > >> used to generate the global parity blocks. That would be a question
> for
> > >> Jim Plank.
> > >>>
> > >>> The benefits of the Xorbas concept is reduced network and disk I/O
> for
> > >> failures while maintaining traditional RS's higher fault-tolerance
> than
> > 3x
> > >> replication while using less space.
> > >>>
> > >>> You can do almost the same thing with jerasure without modifying it
> at
> > >> all. Using the values from the Xorbas video, they have k data blocks,
> m
> > >> global parity blocks, and 2 local parity blocks (generated from k/2
> > data
> > >> blocks) for a total of k+m+2 blocks on disk that can tolerate any m
> > >> failures. In their example, k = 10 and m = 4. They store 16 blocks
> for
> > >> each 10 data blocks.
> > >>>
> > >>> If you use traditional RS encoding via jerasure and used the same
> > amount
> > >> of storage (16 blocks for each 10 data blocks), you could encode 3
> > parity
> > >> blocks for each 5 data blocks. This would consume 16 data blocks for
> > each
> > >> 10 data blocks and the fault-tolerance would be variable from 3-6
> > failures
> > >> depending on how the failures fell between the two groups of 5 blocks
> > >> which is higher than the static 4 failures for the Xorbas code. The
> I/O
> > to
> > >> recover from a single failure for both schemes is 5 blocks so it is
> as
> > >> efficient as Xorbas. On average, it provides more fault-tolerance,
> but
> > it
> > >> can be less (four failures from one group of 5 data + 3 parity
> blocks),
> > >> but that worst case is the same as 3x replication.
> > >>>
> > >>> Scott--
> > >>> To unsubscribe from this list: send the line "unsubscribe ceph-
> devel"
> > >>> in the body of a message to majordomo@vger.kernel.org More majordomo
> > >>> info at  http://vger.kernel.org/majordomo-info.html
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in
> > >> the body of a message to majordomo@vger.kernel.org More majordomo
> info
> > at
> > >> http://vger.kernel.org/majordomo-info.html

