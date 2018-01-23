From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: debugging mgr python modules
Date: Tue, 23 Jan 2018 10:51:43 +0100
Message-ID: <20180123095143.6ug43gtkbjde5xmz@suse.com>
References: <822b6122-c866-f6b6-42e5-6913dbef0744@suse.com>
 <60075fa9-f114-649c-b49b-217087f33e89@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbeAWJwB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Jan 2018 04:52:01 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2BB6BACE6
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jan 2018 09:52:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <60075fa9-f114-649c-b49b-217087f33e89@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 2018-01-23T07:30:43, Ricardo Dias <rdias@suse.com> wrote:

> I think this idea is also very useful but for a different use-case like
> unit/functional testing without having to start a Ceph cluster.
> This way we could add unit tests to the ceph-mgr plugins and run them along
> with the already existing tests.

As far as crazy ideas go, it'd be useful if we could get some sort of
API recorder going at the ceph-mgr / plugin interfaces?




-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

