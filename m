From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 22:13:14 -0500
Message-ID: <0b770e1d-5b3a-b9d1-175c-ccec29ee1737@redhat.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BLUPR0201MB1524775973993917A1A59078E8300@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1607121658240.497@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbcGMDNz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jul 2016 23:13:55 -0400
In-Reply-To: <alpine.DEB.2.11.1607121658240.497@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 07/12/2016 08:50 PM, Sage Weil wrote:
> On Tue, 12 Jul 2016, Allen Samuels wrote:
>> Good analysis.
>>
>> My original comments about putting the oNode on a diet included the idea
>> of a "custom" encode/decode path for certain high-usage cases. At the
>> time, Sage resisted going down that path hoping that a more optimized
>> generic case would get the job done. Your analysis shows that while
>> we've achieved significant space reduction this has come at the expense
>> of CPU time -- which dominates small object performance (I suspect that
>> eventually we'd discover that the variable length decode path would be
>> responsible for a substantial read performance degradation also -- which
>> may or may not be part of the read performance drop-off that you're
>> seeing). This isn't a surprising result, though it is unfortunate.
>>
>> I believe we need to revisit the idea of custom encode/decode paths for
>> high-usage cases, only now the gains need to be focused on CPU
>> utilization as well as space efficiency.
>
> I still think we can get most or all of the way there in a generic way by
> revising the way that we interact with bufferlist for encode and decode.
> We haven't actually tried to optimize this yet, and the current code is
> pretty horribly inefficient (asserts all over the place, and many layers
> of pointer indirection to do a simple append).  I think we need to do two
> things:
>
> 1) decode path: optimize the iterator class so that it has a const char
> *current and const char *current_end that point into the current
> buffer::ptr.  This way any decode will have a single pointer
> add+comparison to ensure there is enough data to copy before falling into
> the slow path (partial buffer, move to next buffer, etc.).
>

I don't have a good sense yet for how much this is hurting us in the 
read path.  We screwed something up in the last couple of weeks and 
small reads are quite slow.

> 2) Having that comparison is still not ideal, but we shoudl consider ways
> to get around that too.  For example, if we know that we are going to
> decode N M-byte things, we could do an iterator 'reserve' or 'check' that
> ensures we have a valid pointer for that much and then proceed without
> checks.  The interface here would be tricky, though, since in the slow
> case we'll span buffers and need to magically fall back to a different
> decode path (hard to maintain) or do a temporary copy (probably faster but
> we need to ensure the iterator owns it and frees is later).  I'd say this
> is step 2 and optional; step 1 will have the most benefit.
>
> 3) encode path: currently all encode methods take a bufferlist& and the
> bufferlist itself as an append buffer.  I think this is flawed and
> limiting.  Instead, we should make a new class called
> buffer::list::appender (or similar) and templatize the encode methods so
> they can take a safe_appender (which does bounds checking) or an
> unsafe_appender (which does not).  For the latter, the user takes
> responsibility for making sure there is enough space by doing a reserve()
> type call which returns an unsafe_appender, and it's their job to make
> sure they don't shove too much data into it.  That should make the encode
> path a memcpy + ptr increment (for savvy/optimized callers).

Seems reasonable and similar in performance to what Piotr and I were 
discussing this morning.  As a very simple test I was thinking of doing 
a quick size computation and then passing that in to increase the 
append_buffer size when the bufferlist is created in 
Bluestore::_txc_write_nodes.  His idea went a bit farther to break the 
encapsulation, compute the fully encoded message, and dump it directly 
into a buffer of a computed size without the extra assert checks or 
bounds checking.  Obviously his idea would be faster but more work.

It sounds like your solution would be similar but a bit more formalized.

>
> I suggest we use bluestore as a test case to make the interfaces work and
> be fast.  If we succeed we can take advantage of it across the reset of
> the code base as well.

Do we have other places in the code with similar byte append behavior? 
That's what's really killing us I think, especially with how small the 
new append_buffer is when you run out of space when appending bytes.

>
> That's my thinking, at least.  I haven't had time to prototype it out yet,
> but I think our goal should be to make the encode/decode paths capable of
> being a memcpy + ptr addition in the fast path, and let that guide the
> interface...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
