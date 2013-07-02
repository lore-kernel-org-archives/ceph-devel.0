From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: Erasure coding library API
Date: Tue, 2 Jul 2013 10:07:23 -0400
Message-ID: <68444BDD-2068-4850-998D-C65449C20353@ornl.gov>
References: <51D20A03.1030204@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta02.ornl.gov ([128.219.177.12]:27760 "EHLO mta02.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab3GBOQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jul 2013 10:16:57 -0400
In-Reply-To: <51D20A03.1030204@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Jul 1, 2013, at 7:00 PM, Loic Dachary <loic@dachary.org> wrote:

> Hi,
> 
> Today Sam pointed out that the API for LRC ( Xorbas Hadoop Project Page, Locally Repairable Codes (LRC) http://smahesh.com/HadoopUSC/ for instance ) would need to be different from the one initialy proposed:

An interesting video. Not as entertaining as Jim Plank's video. ;-)

While Plank's focused on the processor requirements for encoding/decoding, this video focuses on the network and disk I/O requirements.

>    context(k, m, reed-solomon|...) => context* c 
>    encode(context* c, void* data) => void* chunks[k+m]
>    decode(context* c, void* chunk[k+m], int* indices_of_erased_chunks) => void* data // erased chunks are
> not used
>    repair(context* c, void* chunk[k+m], int* indices_of_erased_chunks) => void* chunks[k+m] // erased
> chunks are rebuilt
> 
> The decode function must allow for partial read:
> 
>    decode(context* c, int offset, int length, void* chunk[k+m], int* indices_of_erased_chunks, int* missing_chunks) => void* data 
> 
> If there are not enough chunks to recover the desired data range [offset, offset+length) the function returns NULL and sets missing_chunks to the list of chunks that must be retrieved in order to be able to read the desired data.
> 
> If decode is called to read just 1 chunk and it is missing, reed-solomon would return on error and ask for all other chunks to repair. If the underlying library implements LRC, it would ask for a subset of the chunks. 
> 
> An implementation allowing only full reads and using jerasure ( which does not do LRC ) requires that offset is always zero, length is the size of the object and returns a copy of indices_of_erased_chunks if there are not enough chunks to rebuild the missing ones. 
> 
> Comments are welcome :-)

I have loosely followed this discussion and I have not looked closely at the proposed API nor at the jerasure interface. My apologies if this has already been addressed.

It is not clear to me from the above proposed API (ignoring the partial read) what it would do. Was the original intent to encode the entire file using k+m blocks irregardless of the file size and of the rados object size?

If so, how will you map rados objects to the logical k+m objects and vice versa?

If not, then the initial API needed an offset and length (either logical or rados object).

I would assume that you would want to operate on rados sized objects. Given a fixed k+m, then you may have more than one set of k+m objects per file. This is ignoring the LRC "local" parity blocks. For example, if the rados object size if 1 MB and k = 10 and m = 4 (as in the Xorbas video), then for a 20 MB file one would need two sets of encoding blocks. The first for objects 1-10 and the second for objects 11-20.

Perhaps, this is what the context is above. If so, it should have the logical offset and rados object size, no?

I see value in the Xorbas concept and I wonder if the jerasure library can be modified to generate the local parity blocks such that they can be used to generate the global parity blocks. That would be a question for Jim Plank.

Scott