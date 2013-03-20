From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 04/39] mds: make sure table request id unique
Date: Tue, 19 Mar 2013 23:15:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303192309380.11428@cobra.newdream.net>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-5-git-send-email-zheng.z.yan@intel.com> <C7E493EEAA91442B9BD120B881E4638F@inktank.com> <51494EF6.6040607@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37809 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3CTGPO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 02:15:14 -0400
In-Reply-To: <51494EF6.6040607@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Wed, 20 Mar 2013, Yan, Zheng wrote:
> On 03/20/2013 07:09 AM, Greg Farnum wrote:
> > Hmm, this is definitely narrowing the race (probably enough to never hit it), but it's not actually eliminating it (if the restart happens after 4 billion requests?). More importantly this kind of symptom makes me worry that we might be papering over more serious issues with colliding states in the Table on restart.
> > I don't have the MDSTable semantics in my head so I'll need to look into this later unless somebody else volunteers to do so?
> 
> Not just 4 billion requests, MDS restart has several stage, mdsmap epoch 
> increases for each stage. I don't think there are any more colliding 
> states in the table. The table client/server use two phase commit. it's 
> similar to client request that involves multiple MDS. the reqid is 
> analogy to client request id. The difference is client request ID is 
> unique because new client always get an unique session id.

Each time a tid is consumed (at least for an update) it is journaled in 
the EMetaBlob::table_tids list, right?  So we could actually take a max 
from journal replay and pick up where we left off?  That seems like the 
cleanest.

I'm not too worried about 2^32 tids, I guess, but it would be nicer to 
avoid that possibility.

sage

> 
> Thanks
> Yan, Zheng
> 
> > -Greg
> > 
> > Software Engineer #42 @ http://inktank.com | http://ceph.com
> > 
> > 
> > On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:
> > 
> >> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>  
> >> When a MDS becomes active, the table server re-sends 'agree' messages
> >> for old prepared request. If the recoverd MDS starts a new table request
> >> at the same time, The new request's ID can happen to be the same as old
> >> prepared request's ID, because current table client assigns request ID
> >> from zero after MDS restarts.
> >>  
> >> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> >> ---
> >> src/mds/MDS.cc (http://MDS.cc) | 3 +++
> >> src/mds/MDSTableClient.cc (http://MDSTableClient.cc) | 5 +++++
> >> src/mds/MDSTableClient.h | 2 ++
> >> 3 files changed, 10 insertions(+)
> >>  
> >> diff --git a/src/mds/MDS.cc (http://MDS.cc) b/src/mds/MDS.cc (http://MDS.cc)
> >> index bb1c833..859782a 100644
> >> --- a/src/mds/MDS.cc (http://MDS.cc)
> >> +++ b/src/mds/MDS.cc (http://MDS.cc)
> >> @@ -1212,6 +1212,9 @@ void MDS::boot_start(int step, int r)
> >> dout(2) << "boot_start " << step << ": opening snap table" << dendl;  
> >> snapserver->load(gather.new_sub());
> >> }
> >> +
> >> + anchorclient->init();
> >> + snapclient->init();
> >>  
> >> dout(2) << "boot_start " << step << ": opening mds log" << dendl;
> >> mdlog->open(gather.new_sub());
> >> diff --git a/src/mds/MDSTableClient.cc (http://MDSTableClient.cc) b/src/mds/MDSTableClient.cc (http://MDSTableClient.cc)
> >> index ea021f5..beba0a3 100644
> >> --- a/src/mds/MDSTableClient.cc (http://MDSTableClient.cc)
> >> +++ b/src/mds/MDSTableClient.cc (http://MDSTableClient.cc)
> >> @@ -34,6 +34,11 @@
> >> #undef dout_prefix
> >> #define dout_prefix *_dout << "mds." << mds->get_nodeid() << ".tableclient(" << get_mdstable_name(table) << ") "
> >>  
> >> +void MDSTableClient::init()
> >> +{
> >> + // make reqid unique between MDS restarts
> >> + last_reqid = (uint64_t)mds->mdsmap->get_epoch() << 32;
> >> +}
> >>  
> >> void MDSTableClient::handle_request(class MMDSTableRequest *m)
> >> {
> >> diff --git a/src/mds/MDSTableClient.h b/src/mds/MDSTableClient.h
> >> index e15837f..78035db 100644
> >> --- a/src/mds/MDSTableClient.h
> >> +++ b/src/mds/MDSTableClient.h
> >> @@ -63,6 +63,8 @@ public:
> >> MDSTableClient(MDS *m, int tab) : mds(m), table(tab), last_reqid(0) {}
> >> virtual ~MDSTableClient() {}
> >>  
> >> + void init();
> >> +
> >> void handle_request(MMDSTableRequest *m);
> >>  
> >> void _prepare(bufferlist& mutation, version_t *ptid, bufferlist *pbl, Context *onfinish);
> >> --  
> >> 1.7.11.7
> > 
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
