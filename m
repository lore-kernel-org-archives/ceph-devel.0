From: Sage Weil <sweil@redhat.com>
Subject: Re: teuthology rados runs for next
Date: Tue, 21 Jul 2015 06:43:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507210642560.8878@cobra.newdream.net>
References: <55AE0667.8020000@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbbGUNnN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jul 2015 09:43:13 -0400
In-Reply-To: <55AE0667.8020000@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Samuel Just <sjust@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 21 Jul 2015, Loic Dachary wrote:
> Hi Sam,
> 
> I noticed today that http://pulpito.ceph.com/?suite=rados&branch=next is 
> lagging three days behind. Do we want to keep all the runs or should we 
> kill the older ones ? I suppose there would be value in having the 
> results for all of them but given the current load in the sepia lab it 
> also significantly delays them. What do you think ?

I think it's better to kill old scheduled runs.
