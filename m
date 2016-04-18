From: Sage Weil <sage@newdream.net>
Subject: Re: Sessions and Persistence
Date: Sun, 17 Apr 2016 20:56:26 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604172031220.4797@cpach.fuggernut.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com> <CAJ4mKGbhPrFbMKJi_hKAP1rKzjnX8GqQGMP+m7C_io-m1VDquA@mail.gmail.com> <20160415222936.GA6461@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51550 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbcDRA40 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2016 20:56:26 -0400
In-Reply-To: <20160415222936.GA6461@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, 15 Apr 2016, Adam C. Emerson wrote:
> On 15/04/2016, Gregory Farnum wrote:
> > So the most common time we really get replay operations is when one of
> > the OSDs crash or a PG's acting set changes for some other reason.
> > Which means these "cached" operation results need to be persisted to
> > disk and then cleaned up, a la the pglog.

Yeah

> > I don't see anything in these data structures that explains how we do
> > that efficiently, which is the biggest problem and the reason we don't
> > already do reply caching. Am I missing something?
> So! I had been considering the usual case of resend to be transient connection
> drop between client and OSD. (An example of why feedback is nice :)
> 
> I /had/ thought of persisting thee things as a possible feature we would want to
> add that administrators could turn on or off depending on the level of
> reliability they wanted (and if they had some NVRAM on the machine.)

Yeah, unfortunately they'd have to be persisted all the time, probably 
attached to the pglog entry as Greg mentioned.  Which I think makes this 
pretty much orthogonal to the persistent session discussion.  We can do 
persistent sessions *now* and cache replies so that if a transient error 
forces an OSD to reconnect and the session is still there it won't have to 
resent its writes.  Then it's just an optimization to reduce the impact of 
the failure case (and may or may not be worthwhile, depending on how 
frequent we think that will be).

But to make the read/write ops idempotent, we'll need to persist the reply 
with the update itself.  (Right now the successful reply contains no real 
information, so the existence of a pglog entry or a oi.last_reqid match is 
enough.)  Even if we did do that, the user would need to be careful never 
to have the read very big or else they're turning lots of read data 
into write data.

The big advantage of doing this seems to be that you can pipeline reads 
and writes.  This read+write op is just one example of that, but in the 
end the end point is that you persist read results between writes so that 
the client doesn't have to wait.  But I'm skeptical.  It's a huge amount 
of complexity, and expensive... is it really worth it?  Or can the client 
just wait for the write before sending the read, or vice versa?  You 
wouldn't do anything remotely weird like this with a conventional 
storage stack because latencies aren't that large... and it will be harder 
for us to keep latencies down with complexity like this.

> I had not thought specifically about persisting them QUICKLY in the
> spinning disk case. One optimization would be refusing to cache read-only
> ops so we don't have to pay for a disk-write unless we're using a disk
> write.

I think that works in the simple case, but not if you pipeline, say, read 
(nocache), then write, then <disconnect>.  The write will have 
persisted while we reconnect and our read result is gone.  Of course, the 
client may not care.. but if that's the case we don't really need any of 
this.

I think my real question is what are some workloads that really need this.  
FWIW I think I've only seen *one* user of the current read/write 
transaction 'fail with data or do write' so far.  I'm pretty sure RGW has 
lots of cases of 'do some class op' followed by a read to see the result, 
though, and that slows things down.

Perhaps if the interface made the write "result" payload something 
explicit/separate.  For example, the a class op could do some transaction 
and populate the write result payload with some new state (which it 
presumably knows).  Then it isn't necessary to build a fully general "do 
arbitrary read operation that orders post-update", which is pretty 
complex, and probably not an efficient way to address the above cls 
mutation op anyway.  This way the write result payload is a known special 
thing and the users will hopefully keep it small to make attaching it to 
pg_log_entry_t (and/or object_info_t) okay...

sage
