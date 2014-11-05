From: Sage Weil <sage@newdream.net>
Subject: Re: Question about Transaction::get_data_alignment
Date: Wed, 5 Nov 2014 05:19:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411050517420.15135@cobra.newdream.net>
References: <CAMm-wc+v1_yrcHgftxjgNBo1QARP29K5V_mshuANYq=gn8yRXg@mail.gmail.com> <loom.20141105T075526-51@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58498 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbaKENTx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 08:19:53 -0500
In-Reply-To: <loom.20141105T075526-51@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jianpeng <majianpeng@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 5 Nov 2014, jianpeng wrote:
> Dong Yuan <yuandong <at> unitedstack.com> writes:
> 
> > 
> > Hi Sage,
> > 
> > I am now working with the BP osd: update Transaction encoding, but the
> > Transaction::get_data_alignment make me confused.
> > 
> > This method give the alignment which is used by FileJournal to do
> > better buffer build. It calculate the alignment by largest_data_off
> > and get_data_offset() while the first is an offset of some object and
> > the second is an offset of the transaction encode result. I am not
> > sure there is any reason to do calculation between them.
> > 
> > The code works fine, probably because any result is fine for
> > Transaction::get_data_alignment, while
> > FileJournal::prepare_single_write can use any alignment value to build
> > logical bufferlist.
> > 
> > Can you give me some explanation?  Thank you.
> > 
> 
> Hi, i send a pull request to reduce the memcopy cause by unalignment.
> https://github.com/ceph/ceph/pull/2803
> I think get_data_offset() should not care largest_data_off.

I finally got to testing this and it looks good.  Pulled the patches 
manually into master.  Sorry it took so long!

For the last two MOSDSubOp, I think those changes should be done as part 
of this ticket

	http://tracker.ceph.com/issues/9961

which will replace the common client replication op to use a fresh message 
type that is properly optimized.  Jianpeng, is this something you might be 
interested in working on?  We talked with Haomai about it during CDS but I 
think he and Yuan Dong will be occupied with the ObjectStore::Transaction 
encoding first, and I would really like to see this done in time for 
hammer (jan 1f freeze).

Thanks!
sage

