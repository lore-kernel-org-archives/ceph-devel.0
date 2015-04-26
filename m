From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Sun, 26 Apr 2015 11:44:03 +0300
Message-ID: <CAOi1vP_s5d1jL0pppedF_PsjkX9qnU772GHDDZXR6HR6C+1ioQ@mail.gmail.com>
References: <cover.1429881439.git.dfuller@redhat.com>
	<553C85D6.3010407@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36004 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbDZIoF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Apr 2015 04:44:05 -0400
Received: by wizk4 with SMTP id k4so66551932wiz.1
        for <ceph-devel@vger.kernel.org>; Sun, 26 Apr 2015 01:44:04 -0700 (PDT)
In-Reply-To: <553C85D6.3010407@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Douglas Fuller <dfuller@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Apr 26, 2015 at 9:29 AM, Alex Elder <elder@ieee.org> wrote:
> On 04/24/2015 08:22 AM, Douglas Fuller wrote:
>>
>> Support multiple class op calls in one ceph_msg and consolidate rbd header
>> read and refresh processes to use this feature to reduce the number of
>> ceph_msgs sent for that process. Refresh features on header refresh and
>> begin returning EIO if features have changed since mapping.
>
>
> I think I understand the motivation for what you're doing here.
> You ultimately want to pack more ops into a message, which
> would be really great.  Ideally you could pack some arbitrary
> number (much larger than 3), but it seems to me there'll be
> some restructuring required to get there.
>
> I am having a hard time understanding your intended
> implementation though.  I've looked mainly at your first
> patch, and scanned the other two.  Let's see if I have
> it right.
>
> You are adding another hunk of data to a class request,
> and using it as an intermediate buffer for receiving
> data.
>
> Currently a class request has three "hunks":
> - request_info, a pagelist data item, which contains the
>   class name and method name, and perhaps someday, an
>   argument list (?).
> - request_data, which can contain any number of data
>   items of any type, and constitutes outgoing data for
>   a write request.
> - response_data, also any number of any type of data
>   items, which constitutes space into which incoming
>   data is placed.
>
> You are adding a fourth:
> - chain_data, which is a page vector big enough to hold
>   all incoming response data.
>
> When building up an OSD request, we call osd_req_encode_op()
> for every op in the request.  For a class op, that records
> the length of the class and method names in the op structure,
> and then appends those names to the outbound request_data.
> Following that, the "real" request data (if any) provided
> with the class op is appended to request_data.
>
> Next (before your patches) whatever buffer space was provided
> (as a page array, pagelist, or bio) to receive response data
> is appended to response_data.  Prior to this, the class
> op will have been set up with adequate buffers to directly
> receive the expected data.
>
> What your first patch seems to do is circumvent this last
> step, and instead of using the prearranged buffers, you
> allocate another page vector, big enough to hold the
> combined size of all response_data data items, and store
> that in the new chain_data field of an OSD request class op.
> (Note that this could be in *any* of the ops in an OSD
> request, though I suspect it's always the first.)
>
> When a response arrives, if the *first* op in the request
> array is CEPH_OSD_OP_CALL, you "split" the data, which will
> have been deposited in the "chain_data" page vector.  That
> process involves allocating another buffer sufficient to
> hold the entirety of the received data.  You copy the
> received data into that buffer and release the chain_data
> page vector.  And then you copy the data from this new
> buffer back into the original response array, and then
> free the buffer.
>
> This sounds pretty expensive.  For every class operation
> you are copying the received data two extra times.
>
> It's possible I'm not understanding what you're doing here
> and that's why I'm writing this now.  Before I provide
> any more specific commentary on your patches, I want to
> be sure I understand what you're trying to do.
>
> If my understanding *is* correct, I would say you're
> going about this the wrong way, and I may have some
> suggestions for a better approach.
>
> Will you please correct me where I'm wrong above, and
> maybe give a little better high-level explanation of
> what you're trying to do?  I see in patch 1 you mention
> a problem with short reads, and there may be a simpler
> fix than that (to begin with).  But beyond that, if
> you're trying to incorporate more ops in a message,
> there may be better ways to go about that as well.

Yeah, the only objective of this was to pack more call ops into an
osd_request in order to reduce the number of network RTs during rbd map
and refresh.  The fundamental problem the first patch is trying to work
around is the first ceph_msg_data item consuming all reply buffers
instead of just its own.  We have to preallocate response buffers and
if the preallocated response buffer for the first op is large enough
(it always is) it will consume the entire ceph_msg, along with replies
to other ops.

My understanding is that the first patch is supposed to be a specific
workarond for just that - I think it's noted somewhere that it will
break on reads combined with call ops or similar.

I too have my efficiency concerns and I raised them in one of the
standups but the argument was that this is only going to be used for
header init/refresh, not copyup, so the overhead is negligible.  I'm
still not sold on the copying everything twice though and was going to
try to see if there is a simple way to special case this even more and
make the diffstat smaller.

Thanks,

                Ilya
