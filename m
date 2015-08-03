From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC PATCH 0/2] target/iscsi: clustered SendTargets handling
Date: Sun, 02 Aug 2015 22:37:31 -0700
Message-ID: <1438580251.16598.85.camel@haakon3.risingtidesystems.com>
References: <1436958019-16937-1-git-send-email-ddiss@suse.de>
	 <1438415118.16598.33.camel@haakon3.risingtidesystems.com>
	 <20150803020316.4f692e56@plati.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <20150803020316.4f692e56@plati.site>
Sender: target-devel-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org, mchristi@redhat.com
List-Id: ceph-devel.vger.kernel.org

On Mon, 2015-08-03 at 02:03 +0200, David Disseldorp wrote:
> Hi Nicholas,
> 
> On Sat, 01 Aug 2015 00:45:18 -0700, Nicholas A. Bellinger wrote:
> 
> > Hi David,
> > 
> > Apologies for the delayed follow-up on your original patch.
> 
> No problem - thanks for the feedback!
> 
> > On Wed, 2015-07-15 at 13:00 +0200, David Disseldorp wrote:
> > > For active/active clustered iSCSI targets (e.g. LIO + Ceph RBD),
> > > SendTargets responses from any single node should include portal details
> > > for remote cluster nodes.
> > > 
> > > This patch-set adds a TPG discoverable_while_disabled attribute, which
> > > when set sees LIO include details for a disabled TPG in SendTargets
> > > responses.
> > > 
> > > This allows for the use of a common configuration for cluster nodes,
> > > with TPGT/enable set on a node specific basis.
> > > 
> > > A patch-set to ensure that LIO doesn't listen/accept connections via
> > > disabled TPGs will follow once I've finished cleaning it up.
> > > 
> > > Feedback appreciated.
> > 
> > No objections to adding an attribute to allow disabled TPGs to be
> > included in sendtargets discovery information, but I think this
> > particular configfs attribute can use a better name..
> 
> Heh, yeah I also wasn't a fan of discoverable_while_disabled, but
> couldn't think of anything better. 
> 
> > How about the following instead..?
> 
> Looks like an improvement to me.
> 

Applied to target-pending/for-next with your original authorship +
signed-off-by for the patch.

Thanks!
