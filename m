From: Sage Weil <sage@inktank.com>
Subject: Re: SSD journal suggestion
Date: Wed, 7 Nov 2012 04:17:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45535 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2KGMR3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 07:17:29 -0500
In-Reply-To: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 7 Nov 2012, Gandalf Corvotempesta wrote:
> I'm evaluating some SSD drives as journal.
> Samsung 840 Pro seems to be the fastest in sequential reads and write.
> 
> What parameter should I consider for a journal? I think that none of
> read benchmark are influent because when dumping journal to disk, the
> bottleneck will always be the SAS/SATA write speed. (in this case, the
> SSD will never reach it's read best performance)
> So, should I evaluate only the write speed when datas are wrote to the
> journal ? Sequential or random ?

Sequential write is the only thing that matters for the osd journal.  I'd 
look at both large writes and small writes.

sage

