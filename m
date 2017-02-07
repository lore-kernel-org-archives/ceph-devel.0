From: Sage Weil <sweil@redhat.com>
Subject: Re: Question about writeback performance and content address obejct
 for deduplication
Date: Tue, 7 Feb 2017 14:50:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702071442411.3654@piezo.novalocal>
References: <CAFNt83bds6KzCnMvxyN=vPu7dg_NyX3cHdZwgmhiQqKt4B314A@mail.gmail.com> <alpine.DEB.2.11.1701311420210.3654@piezo.novalocal> <CAFNt83Z1+n+uEGo_58DmrXYxfNQe_GzG4iTYtBdDnt6PEYvdHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753888AbdBGOud (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 09:50:33 -0500
In-Reply-To: <CAFNt83Z1+n+uEGo_58DmrXYxfNQe_GzG4iTYtBdDnt6PEYvdHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: myoungwon oh <ohmyoungwon@gmail.com>
Cc: ceph-devel@vger.kernel.org, =?EUC-KR?B?v8C47b/4?= <omwmw@sk.com>

On Tue, 7 Feb 2017, myoungwon oh wrote:
> Hi sage.
> 
> I uploaded the document which describe my overall appoach.
> please see it and give me feedback.
> slide: https://www.slideshare.net/secret/JZcy3yYEDIHPyg

This approach looks pretty close to what we have been planning.  A few 
comments:

1) I think it may be better to view the tier/pool that has the object 
metadata as the "base" pool, and the CAS pool with the refcounted 
object chunks as as tier below that.

2) I think we can use an object class or a handful of new native rados 
operations to make the CAS pool read/write operations more efficient.  In 
your slides you describe a process something like

  rados(getattr)
  if exists
     rados(increment ref count)
  else
     rados(write object and set ref count to 1)

This could be collapsed into a single optimistic operation that sends the 
data and a command that says "create or increment ref count" so that the 
conditional behavior is handled at the OSD.  This will be more efficient 
for small chunks.  (For large chunks, or in cases where we have some 
confidence that the chunk probably already exists, the pessimistic 
approach might still make sense.)  Either way, we should probably support 
both.

3) We'd like to generalize the first pool behavior so that it is just a 
special case of the new tiering functionality.  The idea is that an 
object_info_t can have a 'manifest' that described where and how the 
object is really stored instead of the object data itself (much like it 
can already be a whiteout, etc.).  In the simplest case, the manifest 
would just say "this object is stored in pool X" (simple tiering).  In 
this case, the manifest would a structure like

  map<offset, tuple<length, cas object, pool>>

I think it'll be worth the effort to build a general struture here that we 
can use for basic tiering (not just dedup).

sage



> 
> thanks
> 
> 
> 2017-01-31 23:24 GMT+09:00 Sage Weil <sage@newdream.net>:
> > On Thu, 26 Jan 2017, myoungwon oh wrote:
> >> I have two questions.
> >>
> >> 1. I would like to ask about CAS location. current our implementation store
> >> content address object in storage tier.However, If we store the CAO in the
> >> cache tier, we can get a performance advantage. Do you think we can create
> >> CAO in cachetier? or create a separate storage pool for CAS?
> >
> > It depends on the design.  If the you are naming the objects at the
> > librados client side, then you can use the rados cluster itself
> > unmodified (with or without a cache tier).  This is roughly how I have
> > anticipated implementing the CAS storage portion.  If you are doing the
> > chunking hashing and within the OSD itself, then you can't do the CAS
> > at the first tier because the requests won't be directed at the right OSD.
> >
> >> 2. The results below are performance result for our current implementation.
> >> experiment setup:
> >> PROXY (inline dedup), WRITEBACK (lazy dedup, target_max_bytes: 50MB),
> >> ORIGINAL(without dedup feature and cache tier),
> >> fio, 512K block, seq. I/O, single thread
> >>
> >> One thing to note is that the writeback case is slower than the proxy.
> >> We think there are three problems as follows.
> >>
> >> A. The current implementation creates a fingerprint by reading the entire
> >> object when flushing. Therefore, there is a problem that read and write are
> >> mixed.
> >
> > I expect this is a small factor compared to the fact that in writeback
> > mode you have to *write* to the cache tier, which is 3x replicated,
> > whereas in proxy mode those writes don't happen at all.
> >
> >> B. When client request read, the promote_object function reads the object
> >> and writes it back to the cache tier, which also causes a mix of read and
> >> write.
> >
> > This can be mitigated by setting the min_read_recency_for_promote pool
> > property to something >1.  Then reads will be proxied unless the object
> > appears to be hot (because it has been touched over multiple
> > hitset intervals).
> >
> >> C. When flushing, the unchanged part is rewritten because flush operation
> >> perform per-object based.
> >
> > Yes.
> >
> > Is there a description of your overall approach somewhere?
> >
> > sage
> >
> >
> >>
> >> Do I have something wrong? or Could you give me a suggestion to improve
> >> performance?
> >>
> >>
> >> a. Write performance (KB/s)
> >>
> >> dedup_ratio  0 20 40 60 80 100
> >>
> >> PROXY  45586 47804 51120 52844 56167 55302
> >>
> >> WRITEBACK  13151 11078 9531 13010 9518 8319
> >>
> >> ORIGINAL  121209 124786 122140 121195 122540 132363
> >>
> >>
> >> b. Read performance (KB/s)
> >>
> >> dedup_ratio  0 20 40 60 80 100
> >>
> >> PROXY  112231 118994 118070 120071 117884 132748
> >>
> >> WRITEBACK  34040 29109 19104 26677 24756 21695
> >>
> >> ORIGINAL  285482 284398 278063 277989 271793 285094
> >>
> >>
> >> thanks,
> >> Myoungwon Oh
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> 
> 
