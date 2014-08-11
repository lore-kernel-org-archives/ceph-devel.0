From: Sage Weil <sweil@redhat.com>
Subject: Re: how to enable ENCODE_DUMP debug option for message
Date: Sun, 10 Aug 2014 18:13:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408101811320.18917@cobra.newdream.net>
References: <75674D092A819E4189E91166C74CB90D0141EA52@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37466 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbaHKBNn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Aug 2014 21:13:43 -0400
In-Reply-To: <75674D092A819E4189E91166C74CB90D0141EA52@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 11 Aug 2014, Shu, Xinxin wrote:
> 
> Hi all , 
> 
> I want to debug message and noticed that there is  ENCODE_DUMP debug options , I recompile ceph with the following command line :
> 
> ./do_autogen.sh -d 1 -e /var/message/ -n && make && make install
> 
> then excecuted 'rbd ls', but in the /var/message/ directory , the message file did not get created .
> 
> any tip about this ? thanks in advance.

Did you make clean beforehand?  Does the process have write access to that 
directory?  I usually use /tmp/foo or something.

Once you generate a bunch of encoded blobs, you can use 
src/test/encoding/import.sh to import them into the corpus, and then
ceph-object-corpus/bin/prune.sh to prune it down to a reasonable size 
before committing the samples for the current version.

I'd really like to automate this process somehow, but right now it's 
done manually (and not frequently enough).  :/

sage

