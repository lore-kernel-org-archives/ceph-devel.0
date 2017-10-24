From: Ricardo Dias <rdias@suse.com>
Subject: Messenger V2: multiple bind support
Date: Tue, 24 Oct 2017 15:36:57 +0100
Message-ID: <1508855817.10018.25.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:33585 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdJXOhL (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 24 Oct 2017 10:37:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi list,

I was wondering if it makes sense to support multiple binds with a
single messenger instance.

The use case I have in mind is when there are multiple public/cluster
networks specified in ceph.conf and we want to listen for connections
in one interface of each network. With the support for multiple binds,
we could use a single messenger instance to listen to all interfaces.

Do you think it is worth to implement such support or is the above use
case easily handled by having multiple messenger instances?

Thanks,
-- 
Ricardo Dias
Senior Software Engineer - Storage Team
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284
(AG Nürnberg)
