From: Sage Weil <sage@newdream.net>
Subject: Re: read/write on RADOS using external buffer
Date: Tue, 19 Oct 2010 21:26:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
 <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
 <20101019222727.GA1737@enoki.dokukino.com> <AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39238 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0JTEXi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 00:23:38 -0400
In-Reply-To: <AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1010192101011.21300@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 19 Oct 2010, Colin McCabe wrote:
> Hi Takuya,
> 
> Thanks for looking at this!
> 
> Unfortunately I think you have taken the wrong approach here. There
> isn't any need for thread-local data in the Objecter. It's not threads
> that the Objecter cares about, it's clients. Also, I don't think a
> change like this needs to involve SimpleMessenger and all that.

The problem Takuya is solving is that the messenger currently always 
allocates _new_ buffers for any data it reads off the network, including 
the data payload of read operations.  His goal is to avoid later doing a 
memcpy into the user provided buffer.

In principle, I think this is the right approach.  There are a few things 
I think we should change with the implementation before merging anything:

 - We should make the fetch_buffer_func a Dispatcher method, like all of 
the existing ms_* callbacks.  That avoids the single callback instance for 
the whole SimpleMessenger, and the weird constructor argument.  A helper 
method Messenger::ms_deliver_get_data_buffer() will probably be needed 
too.  This keeps the interface consistent, and allows any 
registered Dispatcher to specify buffers to read into for messages it 
expects.

 - The ms_get_data_buffer() should just take the ceph_msg_header* as an 
argument. That has a tid in it _and_ the message type--everything we might 
need to determine which message (reply) we are receiving and thus which 
buffer we should read into.

I pushed a msgr_zerocopy_read branch to ceph.git that implements this 
part (patch below).

 - SimpleMessenger::read_message() just needs to call 
ms_deliver_get_data_buffer() if data_len > 0.  If it returns true, use the 
provided bufferptr.

 - The existing Objecter::read() method returns the tid, which librados 
can then store in a private map of tid -> bufferptrs.  When it's 
ms_get_data_buffer() is called it can provide the bufferptr; no need to 
modify the Objecter at all!  Just make sure to verify that the entry 
exists in the map before using the operator[] (use find()).


The main corner case is this: if there is some osd cluster change, it's 
theoretically possible we could have two threads reading read replies to 
the same request off the wire at the same time.  Even if we carefully 
define which reply "wins", we need to make sure there isn't a stray thread 
read/accessing the buffer after the read() call returns.

I'm not sure what the solution to that one is yet.  The kclient doesn't 
have separate threads, and takes pains to yank the pages out from under 
incoming message; that approach doesn't work well with the SimpleMessenger 
threading model.  :/

sage

