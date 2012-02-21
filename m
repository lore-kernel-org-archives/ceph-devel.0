From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: rbd benchmark details
Date: Tue, 21 Feb 2012 14:11:31 -0800
Message-ID: <30838D0D-3F50-4933-9AEB-0798FFDBE372@cs.ucsc.edu>
References: <AE277795-A081-4CCA-9816-E5BA717A6946@cs.ucsc.edu> <CAF3hT9BcBui8VH9F=4egWpvoHH+ENcPOgaDSpTCsqVN7KwuL1w@mail.gmail.com> <3DF204ED-EE24-4DCC-B8DA-4B351F8AADBE@cs.ucsc.edu> <CAF3hT9CWeCpoSK4tuHzwejpcz2JNpU2v7rBwdFUBEexrv62sxg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:57235 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab2BUWL5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 17:11:57 -0500
In-Reply-To: <CAF3hT9CWeCpoSK4tuHzwejpcz2JNpU2v7rBwdFUBEexrv62sxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Adam Manzanares <nmtadam@gmail.com>


On Feb 21, 2012, at 2:03 PM, Gregory Farnum wrote:

> On Tue, Feb 21, 2012 at 1:50 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> 
> In any case, working out the expected speeds on a cluster with
> heterogenous disks is a challenge we haven't fully automated yet. If
> you've got 3 nodes with 3x replication and one node can only handle
> 30MB/s though, that's what you're going to get in terms of asymptotic
> throughput, yes. In a 23-node cluster it's considerably more
> complicated and I'd have to draw it out.
> 
> -Greg
> (not sure if that answered your question or not...)

Yeh, I think that filled in some of my understanding. I think the easiest solution at this point is go move drives around until we get a homogenous setup :)

-Noah