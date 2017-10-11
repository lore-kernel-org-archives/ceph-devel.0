From: Sage Weil <sweil@redhat.com>
Subject: Re: Messenger V2 status
Date: Wed, 11 Oct 2017 15:54:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710111551390.26702@piezo.us.to>
References: <1507736999.14714.15.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbdJKPys (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 11 Oct 2017 11:54:48 -0400
In-Reply-To: <1507736999.14714.15.camel@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Ricardo!

On Wed, 11 Oct 2017, Ricardo Dias wrote:
> Hi,
> 
> I've read the current description of the Messenger V2 protocol in http:
> //docs.ceph.com/docs/master/dev/msgr2/ and would like to ask some
> questions about the current status of this feature.
> 
> - What are the problems/limitations of the V1 protocol that V2 is
> aiming to solve?

Mainly,

1- The v1 handshake is not extensible because there isn't a negotiation of 
which features to use (no separate of supported vs required features).

2- v2 lets you multiplex multiple entities across the same 
underlying connection (e.g., a TCP stream).  We plan to host multiple OSDs 
within the same process, and those endpoints may come and go (e.g., if one 
of the OSDs is logically marked down).

> - Is the protocol and message formats described in the document final,
> or is this just a draft still subject to discussion?

Draft.  It underwent a fair bit of discussion a little over a year ago so 
it ought to be reasonable complete, but I'm sure we'll run into 
problems as it is being implemented, or what to change things.

> - Did someone already started the implementation of the V2 protocol?

I don't think so.

Thanks!
sage
