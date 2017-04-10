From: Sage Weil <sage@newdream.net>
Subject: Re: Forwarding Rocksdb to a new sha
Date: Mon, 10 Apr 2017 13:36:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704101334321.2999@piezo.novalocal>
References: <efe3e212-13b9-c4b6-9abd-f95a6803123a@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57130 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbdDJNgG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 09:36:06 -0400
In-Reply-To: <efe3e212-13b9-c4b6-9abd-f95a6803123a@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 10 Apr 2017, Willem Jan Withagen wrote:
> Hi,
> 
> I have submitted a PR to RocksDB that got accepted.
> But now I'd like to try it in my WIP tree.
> 
> So how do I locally roll the RocksDB version forward?
> 
> Is it as simple as going into RocksDB and go:
> 	'git pull' ??

It depends on what remotes you have in the rocksdb repository; you may 
have to 'git remote add upstream https://github.com/facebook/rocksdb' and 
fetch that first.

Once you get the submodule on the right commit, you'll need to make a 
commit in the containing ceph.git updating the submodule sha1.  (I usually 
use 'git gui' for this.)

sage
