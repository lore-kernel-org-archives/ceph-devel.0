From: Ricardo Dias <rdias@suse.com>
Subject: Re: seastar starting points
Date: Wed, 13 Dec 2017 16:42:10 +0000
Message-ID: <0ebd9a80-e838-7a4f-81ee-f206f9c575ef@suse.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:33445 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbdLMQmS (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 13 Dec 2017 11:42:18 -0500
In-Reply-To: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org



On 13-12-2017 16:34, Sage Weil wrote:
> We had a great chat yesterday with Avi Kivity @ Scylla about seastar in
> ceph, and were talking about where to start...  One candidate was to carve
> off the entire messenger and reimplement using seastar futures/promises.

I don't think it's a good idea to start with the messenger since we are 
currently making a lot of changes to implement the new V2 protocol.

> 
> Another thought that is somewhat trivial but probably necessary and
> smallish is the log/ framework.  This might be a good test case for the
> legacy <-> seastar communications infrastructure.  It's all one-way, which
> simplifies things a bit, and the implementation should be pretty
> straightforward?
> 
> I know we can't rely on the current debug stuff for
> tracing/instrumentation, but I don't think teh need for a debug log is
> going to go away.
> 
> Another question is how the logger/perfcounters will need to change in a
> seastar world.
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Ricardo Dias
Senior Software Engineer - Storage Team
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284
(AG Nürnberg)
