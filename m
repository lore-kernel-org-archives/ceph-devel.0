From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: rados bench single instance vs. multiple instances
Date: Mon, 11 May 2015 17:15:47 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166440A10@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com ([157.56.110.135]:7520
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751096AbbEKRPy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 13:15:54 -0400
In-Reply-To: <alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Monday, May 11, 2015 12:04 PM
> To: Deneau, Tom
> Cc: ceph-devel
> Subject: Re: rados bench single instance vs. multiple instances
> 
> On Mon, 11 May 2015, Deneau, Tom wrote:
> > I have noticed the following while running rados bench seq read tests
> > with a 40M object size
> >
> >     single rados bench, 4 concurrent ops,                     bandwidth =
> 190 MB/s
> >     4 copies of rados bench, 1 concurrent op each,  aggregate
> > bandwidth = 310 MB/s
> >
> > and in fact the single rados bench seems limited to 190, no matter how many
> concurrent ops.
> >
> > I don't see this kind of behavior with a 4M object size.
> >
> > (The above are with caches dropped on the osd targets)
> >
> > It doesn't seem to be related to the total number of bytes being
> > processed by the single because if I don't drop the caches, both the
> > single rados bench and the 4-copy rados bench get much higher numbers
> > (600 vs. 900) but still the single rados bench appears limited, no matter
> how many concurrent ops are used.
> >
> > Is there kind of throttling going on by design here?
> 
> It might be the librados throttles:
> 
> OPTION(objecter_inflight_op_bytes, OPT_U64, 1024*1024*100) // max in-flight
> data (both directions)
> OPTION(objecter_inflight_ops, OPT_U64, 1024)               // max in-flight
> ios
> 
> IIRC these only affect librados.. which would include 'rados bench'.
> 
> sage
> 

I noticed those, and tried setting them higher but it didn't seem to have an effect.
But maybe I didn't change it correctly.

What I did:
   * stop all osds
   * add the following lines to ceph.conf
     [osd]
        objecter_inflight_op_bytes = 1048576000
   * restart all osds
   * admin-daemon osd config show shows the new value
   * made sure /etc/ceph/ceph.conf on the client also had those lines added
      (although I was not sure if that was needed?)

-- Tom


