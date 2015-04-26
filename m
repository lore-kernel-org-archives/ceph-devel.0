From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Sun, 26 Apr 2015 01:29:42 -0500
Message-ID: <553C85D6.3010407@ieee.org>
References: <cover.1429881439.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35728 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbDZG3q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Apr 2015 02:29:46 -0400
Received: by pabtp1 with SMTP id tp1so93290417pab.2
        for <ceph-devel@vger.kernel.org>; Sat, 25 Apr 2015 23:29:45 -0700 (PDT)
In-Reply-To: <cover.1429881439.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 04/24/2015 08:22 AM, Douglas Fuller wrote:
> Support multiple class op calls in one ceph_msg and consolidate rbd header
> read and refresh processes to use this feature to reduce the number of
> ceph_msgs sent for that process. Refresh features on header refresh and
> begin returning EIO if features have changed since mapping.

I think I understand the motivation for what you're doing here.
You ultimately want to pack more ops into a message, which
would be really great.  Ideally you could pack some arbitrary
number (much larger than 3), but it seems to me there'll be
some restructuring required to get there.

I am having a hard time understanding your intended
implementation though.  I've looked mainly at your first
patch, and scanned the other two.  Let's see if I have
it right.

You are adding another hunk of data to a class request,
and using it as an intermediate buffer for receiving
data.

Currently a class request has three "hunks":
- request_info, a pagelist data item, which contains the
   class name and method name, and perhaps someday, an
   argument list (?).
- request_data, which can contain any number of data
   items of any type, and constitutes outgoing data for
   a write request.
- response_data, also any number of any type of data
   items, which constitutes space into which incoming
   data is placed.

You are adding a fourth:
- chain_data, which is a page vector big enough to hold
   all incoming response data.

When building up an OSD request, we call osd_req_encode_op()
for every op in the request.  For a class op, that records
the length of the class and method names in the op structure,
and then appends those names to the outbound request_data.
Following that, the "real" request data (if any) provided
with the class op is appended to request_data.

Next (before your patches) whatever buffer space was provided
(as a page array, pagelist, or bio) to receive response data
is appended to response_data.  Prior to this, the class
op will have been set up with adequate buffers to directly
receive the expected data.

What your first patch seems to do is circumvent this last
step, and instead of using the prearranged buffers, you
allocate another page vector, big enough to hold the
combined size of all response_data data items, and store
that in the new chain_data field of an OSD request class op.
(Note that this could be in *any* of the ops in an OSD
request, though I suspect it's always the first.)

When a response arrives, if the *first* op in the request
array is CEPH_OSD_OP_CALL, you "split" the data, which will
have been deposited in the "chain_data" page vector.  That
process involves allocating another buffer sufficient to
hold the entirety of the received data.  You copy the
received data into that buffer and release the chain_data
page vector.  And then you copy the data from this new
buffer back into the original response array, and then
free the buffer.

This sounds pretty expensive.  For every class operation
you are copying the received data two extra times.

It's possible I'm not understanding what you're doing here
and that's why I'm writing this now.  Before I provide
any more specific commentary on your patches, I want to
be sure I understand what you're trying to do.

If my understanding *is* correct, I would say you're
going about this the wrong way, and I may have some
suggestions for a better approach.

Will you please correct me where I'm wrong above, and
maybe give a little better high-level explanation of
what you're trying to do?  I see in patch 1 you mention
a problem with short reads, and there may be a simpler
fix than that (to begin with).  But beyond that, if
you're trying to incorporate more ops in a message,
there may be better ways to go about that as well.

Thanks.

					-Alex

> v2: Edit history and address comments from Mike Christie.
>
> Douglas Fuller (3):
>    ceph: support multiple class method calls in one ceph_msg
>    rbd: combine object method calls in header refresh using fewer
>      ceph_msgs
>    rbd: re-read features during header refresh and detect changes.
>
>   drivers/block/rbd.c             | 512 +++++++++++++++++++++++++++++-----------
>   include/linux/ceph/osd_client.h |   3 +-
>   net/ceph/messenger.c            |   4 +
>   net/ceph/osd_client.c           |  90 ++++++-
>   4 files changed, 462 insertions(+), 147 deletions(-)
>

