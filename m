From: Sage Weil <sweil@redhat.com>
Subject: Re: bluestore blobs REVISITED
Date: Wed, 24 Aug 2016 21:18:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608242113300.25681@piezo.us.to>
References: <BLUPR0201MB15245F1EA4B70EF5761981AFE8170@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608211601350.14754@piezo.us.to> <2F51EC8C-D280-4DFF-8FF6-4AC97071A7D5@sandisk.com> <BLUPR0201MB15245054714F66FC2AB92935E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608222158190.25681@piezo.us.to> <BLUPR0201MB152454CA00246E35A1AE08C0E8E80@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608222249560.25681@piezo.us.to> <BLUPR0201MB1524C52747AF115A4C178D0FE8E80@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231548080.25678@piezo.us.to> <BLUPR0201MB152475F2D6907CAD2E594FC6E8EB0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608231918460.25678@piezo.us.to> <BLUPR0201MB1524808F8F4763BB50517C12E8EA0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608241759180.25678@piezo.us.to> <35D6E177-5070-4853-8CF4-FBDA14B08CAD@sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754444AbcHXVSo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 17:18:44 -0400
In-Reply-To: <35D6E177-5070-4853-8CF4-FBDA14B08CAD@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, jdurgin@redhat.com, dillaman@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 24 Aug 2016, Allen Samuels wrote:
> > In that case, we should focus instead on sharing the ref_map *only* and 
> > always inline the forward pointers for the blob.  This is closer to what 
> > we were originally doing with the enode.  In fact, we could go back to the 
> > enode approach were it's just a big extent_ref_map and only used to defer 
> > deallocations until all refs are retired.  The blob is then more ephemeral 
> > (local to the onode, immutable copy if cloned), and we can more easily 
> > rejigger how we store it.
> > 
> > We'd still have a "ref map" type structure for the blob, but it would only 
> > be used for counting the lextents that reference it, and we can 
> > dynamically build it when we load the extent map.  If we impose the 
> > restriction that whatever the map sharding approach we take we never share 
> > a blob across a shard, we the blobs are always local and "ephemeral" 
> > in the sense we've been talking about.  The only downside here, I think, 
> > is that the write path needs to be smart enough to not create any new blob 
> > that spans whatever the current map sharding is (or, alternatively, 
> > trigger a resharding if it does so).
> 
> Not just a resharding but also a possible decompress recompress cycle. 

Yeah.

Oh, the other consequence of this is that we lose the unified blob-wise 
cache behavior we added a while back.  That means that if you write a 
bunch of data to a rbd data object, then clone it, then read of the clone, 
it'll re-read the data from disk.  Because it'll be a different blob in 
memory (since we'll be making a copy of the metadata etc).

Josh, Jason, do you have a sense of whether that really matters?  The 
common case is probably someone who creates a snapshot and then backs it 
up, but it's going to be reading gobs of cold data off disk anyway so I'm 
guessing it doesn't matter that a bit of warm data that just preceded the 
snapshot gets re-read.

sage

