From: David Zafman <dzafman@redhat.com>
Subject: Re: wip-addr
Date: Mon, 12 Oct 2015 10:42:58 -0700
Message-ID: <561BF122.5050809@redhat.com>
References: <20151002232413.GA8939@degu.b.linuxbox.com>
 <alpine.DEB.2.00.1510091446090.29929@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33418 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbbJLRnA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 12 Oct 2015 13:43:00 -0400
In-Reply-To: <alpine.DEB.2.00.1510091446090.29929@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Marcus Watts <mwatts@redhat.com>
Cc: ceph-devel@vger.kernel.org, haomai@xsky.com


I don't understand how encode/decode of entity_addr_t is changing 
without versioning in the encode/decode.  This means that this branch is 
changing the ceph-objectstore-tool export format if 
CEPH_FEATURE_MSG_ADDR2 is part of the features.  So we could bump 
super_header::super_ver if the export format must change.

Now that I look at it, I'm sure I can clear the watchers and 
old_watchers in object_info_t during export because that is dynamic 
information and it happens to include entity_addr_t.  I need to verify 
this, but that may be the only reason that the objectstore tool needs a 
valid features value to be passed there.

David

On 10/9/15 2:49 PM, Sage Weil wrote:
>> 2.
>> >(about line 2067 in src/tools/ceph_objectstore_tool.cc)
>> >(use via ceph cmd?) tools - "object store tool".
>> >This has a way to serialize objects which includes a watch list
>> >which includes an address.  There should be an option here to say
>> >whether to include exported addresses.
> I think it's safe to use defaults here.. what do you think, David?

