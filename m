From: Sage Weil <sage@newdream.net>
Subject: Re: read/write on RADOS using external buffer
Date: Tue, 14 Sep 2010 11:44:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34869 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab0INSmy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Sep 2010 14:42:54 -0400
In-Reply-To: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Mon, 13 Sep 2010, Takuya ASADA wrote:
> I want to use external buffer in Rados::write() and Rados::read() in
> my application, I figure out the way on write() but I couldn't on
> read().
> 
> I have "char *buf" as buffer, and it's length "int len".
> On write(), I could do it like this:
>   rados.initialize(0, NULL);
>   rados.open_pool(bucket, &pool);
>   bl.push_front(ceph::buffer::create_static(len, buf));
>   rados.write_full(pool, oid, bl);
> 
> But on read(), I tried slimier code but fails:
>   r = rados.initialize(0, NULL);
>   r = rados.open_pool(bucket, &pool);
>   bl.push_front(ceph::buffer::create_static(len, buf));
>   rados.read(pool, oid, 0, bl, 0);
> 
> It seems new buffer allocated inside of read() operation, and the data
> wrote on new buffer instead of "buf".
> Where that new buffer allocated?
> And is there a way to use external buffer instead of new buffer?

There currently isn't a way to use a preallocated buffer for reads.  The 
incoming data is read into a buffer allocated low in the stack by the 
messaging layer.  The bufferlist& ref is really a handle for the caller to 
get at the buffers; any prior contents are discarded.

This is something that could be changed, but it will require an additional 
messenger callback so that the upper layers can provide the buffer to read 
the data into.  (That is what the kernel implementation does.)

sage
