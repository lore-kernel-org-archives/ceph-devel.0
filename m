From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: Braindump: multiple clusters on the same hardware
Date: Tue, 13 Nov 2012 18:01:27 -0700
Message-ID: <4D460586-2BFC-4160-AD5E-0ED21E06EA70@tchpc.tcd.ie>
References: <CADvuQREhkrqxm1dMo3XXFpwhtCzC7SM7cK_7+r5HnACGbCnJLw@mail.gmail.com> <4F329E1D-EACC-497E-B9E4-445992BA4F35@tchpc.tcd.ie> <A91A18BC-9B52-45E6-953F-7A13B6716275@tchpc.tcd.ie>  <sfid-H20121018-174727-+035.14-1@marduk.tchpc.tcd.ie> <CADvuQRF-3ThfrLtDm5fxFBMxa=C1vei3iseMnpBPpw-_sz==Yg@mail.gmail.com>  (sfid-H20121018-174727-+035.14-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:42930 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756052Ab2KNBBu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 20:01:50 -0500
In-Reply-To: <CADvuQRF-3ThfrLtDm5fxFBMxa=C1vei3iseMnpBPpw-_sz==Yg@mail.gmail.com>  (sfid-H20121018-174727-+035.14-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org, John Wilkins <john.wilkins@inktank.com>


On 18 Oct 2012, at 10:47, Tommi Virtanen wrote:
> 
> That's the "async replication for disaster recovery" feature that has
> been mentioned every now and then.
> 
> You could build it as "read from one cluster, write to another"
> yourself, the client libraries are perfectly able to talk to two
> clusters at once. Ceph itself doesn't have that feature currently, but
> might in the future. It's definitely on the roadmap, and asked for a
> lot.
> 

Not sure if it should stay in this thread or not, but I had a chat with some ink tank people here at SC12, but for async replication will this replication process work within a single cluster? that is will it replicate data within a pool, between pools?

Or will the replication happen by copying files/objects/datablobs from one cluster to another cluster? And if it's the second case will the issue of cluster to cluster authentication and authorisation be dealt with?

Since it's on the roadmap I thought I might ask the above!


Jimmy

