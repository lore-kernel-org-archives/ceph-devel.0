From: Ricardo Dias <rdias@suse.com>
Subject: Why does messenger sends the address of himself and of the
 connecting peer
Date: Fri, 20 Oct 2017 16:25:18 +0100
Message-ID: <1508513118.10018.8.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60193 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdJTPZo (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 20 Oct 2017 11:25:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

In the current messenger protocol, upon accepting a new connection, the
messenger sends it's address and the connecting peer address along with
the banner string. Why does the connecting peer need these addresses?
Moreover, the connecting peer uses the connecting peer address (sent
from the server) to set as it's own address.

What happens if the network is rewriting addresses  because of NAT, or
whatever other strange reasons?

I also saw that the code that encodes these addresses have a comment
saying "// legacy". Should we remove these addresses from the new V2
protocol, or do we still need them?

Thanks,
Ricardo

-- 
Ricardo Dias
Senior Software Engineer - Storage Team
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284
(AG Nürnberg)
