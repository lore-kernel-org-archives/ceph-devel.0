From: Sage Weil <sage@newdream.net>
Subject: Re: Forwarding Rocksdb to a new sha
Date: Mon, 10 Apr 2017 13:52:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704101350380.2999@piezo.novalocal>
References: <efe3e212-13b9-c4b6-9abd-f95a6803123a@digiware.nl> <alpine.DEB.2.11.1704101334321.2999@piezo.novalocal> <21ce1351-d892-90ed-d902-fb043af3d87e@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57205 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbdDJNwg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 09:52:36 -0400
In-Reply-To: <21ce1351-d892-90ed-d902-fb043af3d87e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 10 Apr 2017, Willem Jan Withagen wrote:
> On 10-4-2017 15:36, Sage Weil wrote:
> > On Mon, 10 Apr 2017, Willem Jan Withagen wrote:
> >> Hi,
> >>
> >> I have submitted a PR to RocksDB that got accepted.
> >> But now I'd like to try it in my WIP tree.
> >>
> >> So how do I locally roll the RocksDB version forward?
> >>
> >> Is it as simple as going into RocksDB and go:
> >> 	'git pull' ??
> > 
> > It depends on what remotes you have in the rocksdb repository; you may 
> > have to 'git remote add upstream https://github.com/facebook/rocksdb' and 
> > fetch that first.
> 
> Uptil now I avoided cloning RocksDB and submitted PRs fully thru GitHub ;-)
> 
> > Once you get the submodule on the right commit, you'll need to make a 
> > commit in the containing ceph.git updating the submodule sha1.  (I usually 
> > use 'git gui' for this.)
> 
> There is not that many updates to RocksDB, And my PR-commit is the
> current HEAD: 04abb2b2ddc308ab03f55ea9a1e08b62667d6e39
> 
> So how do I forward the submodule to this SHA?

Yeah, that makes sense!

sage



> And I can actually test this release of RockDB with Ceph. Otherwise we
> stay at the old version we include, and I need to keep a patch.

> 
> --WjW
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
