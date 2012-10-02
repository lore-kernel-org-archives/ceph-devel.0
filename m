From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 12/12] mds: Avoid creating unnecessary snaprealm
Date: Wed, 03 Oct 2012 07:45:44 +0800
Message-ID: <506B7CA8.9030505@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com> <1349168152-13281-12-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1210021129220.19966@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30892 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756730Ab2JBXp4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 19:45:56 -0400
In-Reply-To: <alpine.DEB.2.00.1210021129220.19966@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/03/2012 02:31 AM, Sage Weil wrote:
> Hi Yan,
> 
> This whole series looks great!  Sticking it in wip-mds and running it 
> through the fs qa suite before merging it.
> 
> How are you testing these?  If you haven't seen it yet, there is an 'mds 
> thrash exports' option that will make MDSs random migrate subtrees to each 
> other that is great for shaking out bugs.  That and periodic daemon 
> restarts (one of the first things we need to do on the clustered mds front 
> is to get daemon restarting integrated into teuthology).
> 

The patches are fixes for problems I encountered during playing MDS shutdown.
I setup a 2 MDS cephfs and copied some data into it, deleted some directories
whose authority is MDS.1, then shutdown MDS.1.

Most patches in this series are obvious. The two snaprealm related patches are
workaround for a bug: replica inode's snaprealm->open is not true. The bug triggers
assertion in CInode::pop_projected_snaprealm() if snaprealm is involved in cross
authority rename.

Regards
Yan, Zheng
