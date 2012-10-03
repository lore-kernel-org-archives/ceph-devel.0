From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] mds: Use stray dir as base inode for stray reintegration
Date: Thu, 04 Oct 2012 00:01:12 +0800
Message-ID: <506C6148.8090608@intel.com>
References: <1349264412-31444-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1210030811350.21194@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34359 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529Ab2JCQBO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Oct 2012 12:01:14 -0400
In-Reply-To: <alpine.DEB.2.00.1210030811350.21194@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/03/2012 11:17 PM, Sage Weil wrote:
> On Wed, 3 Oct 2012, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> Server::handle_client_rename() only skips common ancestor check
>> if source path's base inode is stray directory, but source path's
>> base inode is mdsdir in the stray reintegration case.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> 
> Hmm, I think this is a problem because path_traverse() does not know how 
> to get started with a stray dir it doesn't already have.  It might make 
> more sense to use the full path here, and make the handle_client_rename() 
> check smarter.
> 
> I'm testing this:
> 
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index b706b5a..0c3ff96 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -5066,7 +5066,8 @@ void Server::handle_client_rename(MDRequest *mdr)
>  
>    // src+dest traces _must_ share a common ancestor for locking to prevent orphans
>    if (destpath.get_ino() != srcpath.get_ino() &&
> -      !MDS_INO_IS_STRAY(srcpath.get_ino())) {  // <-- mds 'rename' out of stray dir is ok!
> +      !(req->get_source()->is_mds() &&
> +       MDS_INO_IS_MDSDIR(srcpath.get_ino()))) {  // <-- mds 'rename' out of stray dir is ok!
>      // do traces share a dentry?
>      CDentry *common = 0;
>      for (unsigned i=0; i < srctrace.size(); i++) {
> 
>
FYI: MDCache::migrate_stray() uses stray directory as base inode, it requires an update.
