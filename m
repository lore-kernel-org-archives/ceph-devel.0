From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 5/9] libceph: init osd->o_node in create_osd()
Date: Mon, 17 Dec 2012 08:17:55 -0600
Message-ID: <50CF2993.8050809@inktank.com>
References: <50CA0915.1090801@inktank.com> <50CA0A0F.5070101@inktank.com> <alpine.DEB.2.00.1212141727390.14354@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63501 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab2LQORy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 09:17:54 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so9324871ieb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 06:17:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212141727390.14354@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 12/14/2012 07:43 PM, Sage Weil wrote:
> We should drop this one, I think.  See upstream commit 
> 4c199a93a2d36b277a9fd209a0f2793f8460a215.  When we added the similar call 
> on teh request tree it caused some noise in linux-next and then got 
> removed.

Well, we need to initialize it.  In particular, there is a call
to RB_EMPTY_NODE() in __unregister_request() which assumes that
if a node is not in the tree, it has been initialized as it is
in RB_CLEAR_NODE().  Even if that's not a normal path (and even
if no current code path allows that condition), if we're using
RB_EMPTY_NODE() we need to be sure any node we'll pass is properly
set up or it's broken code.

So it's fine with me if we use RB_CLEAR_NODE() instead.  Or, we
could stop using RB_EMPTY_NODE() (but that's more work to verify).

The same goes for the event passed to __remove_event(), but that
should be fixed in a separate patch.

Please let me know what you think.

					-Alex

> sage
> 
> On Thu, 13 Dec 2012, Alex Elder wrote:
> 
>> It turns out to be harmless but the red-black node o_node in the
>> ceph osd structure is not initialized in create_osd().  Add a
>> call to rb_init_node() initialize it.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>  net/ceph/osd_client.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 60c74c1..470816c 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -642,6 +642,7 @@ static struct ceph_osd *create_osd(struct
>> ceph_osd_client *osdc, int onum)
>>  	atomic_set(&osd->o_ref, 1);
>>  	osd->o_osdc = osdc;
>>  	osd->o_osd = onum;
>> +	rb_init_node(&osd->o_node);
>>  	INIT_LIST_HEAD(&osd->o_requests);
>>  	INIT_LIST_HEAD(&osd->o_linger_requests);
>>  	INIT_LIST_HEAD(&osd->o_osd_lru);
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

