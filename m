From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: which osds get used for ec pool reads?
Date: Thu, 14 May 2015 21:07:56 +0200
Message-ID: <5554F28C.8040706@suse.cz>
References: <BC97738F8E7C8742BABED7F06FB9DF9166448682@SATLEXDAG01.amd.com>	<1146045701.21089476.1431622348438.JavaMail.zimbra@redhat.com>	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8C782@SACMBXIP01.sdcorp.global.sandisk.com> <CAC6JEv_xsOVPh2RxRgGD=K2Q0bj_u13TmgkAhP1Jn5CEWMJLgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54672 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030258AbbENTH7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 May 2015 15:07:59 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 01213ABB3
	for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 19:07:58 +0000 (UTC)
In-Reply-To: <CAC6JEv_xsOVPh2RxRgGD=K2Q0bj_u13TmgkAhP1Jn5CEWMJLgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 05/14/2015 08:33 PM, Gregory Farnum wrote:
> If you read every block, you increase the amount of data accessed but
> can avoid the long tail latencies. There are a bunch of research
> papers about these tradeoffs and the surprising latency improvements
> you can get on the aggregate read, and Yahoo! talked about this in
> their blog post on their use of Ceph. :)

Here's the link, might save some googling:

http://yahooeng.tumblr.com/post/116391291701/yahoo-cloud-object-store-object-storage-at


