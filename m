From: Samuel Just <sjust@redhat.com>
Subject: Re: 'Racing read got wrong version' during proxy write testing
Date: Thu, 4 Jun 2015 14:20:12 -0400 (EDT)
Message-ID: <386643982.14151101.1433442012365.JavaMail.zimbra@redhat.com>
References: <06E7D85B3BA36C4DB207FEDE871C53489E8D8C@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1505250924080.19787@cobra.newdream.net> <06E7D85B3BA36C4DB207FEDE871C53489EE0F9@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1506031808170.26591@cobra.newdream.net> <06E7D85B3BA36C4DB207FEDE871C53489EE2D3@SHSMSX101.ccr.corp.intel.com> <556FADE4.3080305@redhat.com> <06E7D85B3BA36C4DB207FEDE871C53489EE309@SHSMSX101.ccr.corp.intel.com> <695825089.14140061.1433441534199.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:49250 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbFDSUN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jun 2015 14:20:13 -0400
In-Reply-To: <695825089.14140061.1433441534199.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhiqiang Wang <zhiqiang.wang@intel.com>
Cc: David Zafman <dzafman@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Yeah, I think the right answer is to remove that check and restructure all of the existing reader ops which rely on it to return ENOENT from do_osd_ops.  For copy_get, we instead return 0 and indicate in the structured payload that the object logically does not exist (along with the relevant log entries).
-Sam

----- Original Message -----
From: "Samuel Just" <sjust@redhat.com>
To: "Zhiqiang Wang" <zhiqiang.wang@intel.com>
Cc: "David Zafman" <dzafman@redhat.com>, "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
Sent: Thursday, June 4, 2015 11:12:14 AM
Subject: Re: 'Racing read got wrong version' during proxy write testing

copy_get can happen outside of the context of a cache op, so we can't (shouldn't) just flag it as a cache op.  I wonder whether it wouldn't be better to live without that check at all and let all of the ops in do_osd_ops individually return ENOENT as appropriate.
-Sam

----- Original Message -----
From: "Zhiqiang Wang" <zhiqiang.wang@intel.com>
To: "David Zafman" <dzafman@redhat.com>, "Sage Weil" <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org
Sent: Wednesday, June 3, 2015 7:08:35 PM
Subject: RE: 'Racing read got wrong version' during proxy write testing

Hi David,

Proxy write hasn't been merge into master yet. It's not likely this is causing #11511.

-----Original Message-----
From: David Zafman [mailto:dzafman@redhat.com] 
Sent: Thursday, June 4, 2015 9:46 AM
To: Wang, Zhiqiang; Sage Weil
Cc: ceph-devel@vger.kernel.org
Subject: Re: 'Racing read got wrong version' during proxy write testing


I'm wonder if this issue could be the cause of #11511.  Could a proxy write have raced with the fill_in_copy_get() so object_info_t size doesn't correspond with the size of the object in the filestore?

David


On 6/3/15 6:22 PM, Wang, Zhiqiang wrote:
> Making the 'copy get' op to be a cache op seems like a good idea.
>
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Thursday, June 4, 2015 9:14 AM
> To: Wang, Zhiqiang
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: 'Racing read got wrong version' during proxy write 
> testing
>
> On Wed, 3 Jun 2015, Wang, Zhiqiang wrote:
>> I ran into the 'op not idempotent' problem during the testing today.
>> There is one bug in the previous fix. In that fix, we copy the reqids 
>> in the final step of 'fill_in_copy_get'. If the object is deleted, 
>> since the 'copy get' op is a read op, it returns earlier with ENOENT in do_op.
>> No reqids will be copied during promotion in this case. This again 
>> leads to the 'op not idempotent' problem. We need a 'smart' way to 
>> detect the op is a 'copy get' op (looping the ops vector doesn't seem
>> smart?) and copy the reqids in this case.
> Hmm.  I think the idea here is/was that that ENOENT would somehow include the reqid list from PGLog::get_object_reqids().
>
> I think teh trick is getting it past the generic check in do_op:
>
>    if (!op->may_write() &&
>        !op->may_cache() &&
>        (!obc->obs.exists ||
>         ((m->get_snapid() != CEPH_SNAPDIR) &&
> 	obc->obs.oi.is_whiteout()))) {
>      reply_ctx(ctx, -ENOENT);
>      return;
>    }
>
> Maybe we mark these as cache operations so that may_cache is true?
>
> Sam, what do you think?
>
> sage
>
>
>> -----Original Message-----
>> From: Sage Weil [mailto:sweil@redhat.com]
>> Sent: Tuesday, May 26, 2015 12:27 AM
>> To: Wang, Zhiqiang
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: 'Racing read got wrong version' during proxy write 
>> testing
>>
>> On Mon, 25 May 2015, Wang, Zhiqiang wrote:
>>> Hi all,
>>>
>>> I ran into a problem during the teuthology test of proxy write. It is like this:
>>>
>>> - Client sends 3 writes and a read on the same object to base tier
>>> - Set up cache tiering
>>> - Client retries ops and sends the 3 writes and 1 read to the cache 
>>> tier
>>> - The 3 writes finished on the base tier, say with versions v1, v2 
>>> and
>>> v3
>>> - Cache tier proxies the 1st write, and start to promote the object 
>>> for the 2nd write, the 2nd and 3rd writes and the read are blocked
>>> - The proxied 1st write finishes on the base tier with version v4, 
>>> and returns to cache tier. But somehow the cache tier fails to send 
>>> the reply due to socket failure injecting
>>> - Client retries the writes and the read again, the writes are 
>>> identified as dup ops
>>> - The promotion finishes, it copies the pg_log entries from the base 
>>> tier and put it in the cache tier's pg_log. This includes the 3 
>>> writes on the base tier and the proxied write
>>> - The writes dispatches after the promotion, they are identified as 
>>> completed dup ops. Cache tier replies these write ops with the 
>>> version from the base tier (v1, v2 and v3)
>>> - In the last, the read dispatches, it reads the version of the 
>>> proxied write (v4) and replies to client
>>> - Client complains that 'racing read got wrong version'
>>>
>>> In a previous discussion of the 'ops not idempotent' problem, we solved it by copying the pg_log entries in the base tier to cache tier during promotion. Seems like there is still a problem with this approach in the above scenario. My first thought is that when proxying the write, the cache tier should use the original reqid from the client. But currently we don't have a way to pass the original reqid from cache to base. Any ideas?
>> I agree--I think the correct fix here is to make the proxied op be recognized as a dup.  We can either do that by passing in an optional reqid to the Objecter, or extending the op somehow so that both reqids are listed.  I think the first option will be cleaner, but I think we will also need to make sure the 'retry' count is preserved as (I think) we skip the dup check if retry==0.  And we probably want to preserve the behavior that a given (reqid, retry) only exists once in the system.
>>
>> This probably means adding more optional args to Objecter::read()...?
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


