From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: LOOKUPPARENT
Date: Fri, 07 Mar 2014 08:15:44 +0800
Message-ID: <53190FB0.2060902@intel.com>
References: <alpine.DEB.2.00.1403061441340.3593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20573 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbaCGARe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Mar 2014 19:17:34 -0500
In-Reply-To: <alpine.DEB.2.00.1403061441340.3593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 03/07/2014 06:44 AM, Sage Weil wrote:
> Hey Zheng,
> 
> The recent patch that changed LOOKUPPARENT probably broke getcwd() in 
> Client.cc:
> 
> void Client::getcwd(string& dir)
> {
>   filepath path;
>   ldout(cct, 10) << "getcwd " << *cwd << dendl;
> 
>   Inode *in = cwd;
>   while (in != root) {
>     assert(in->dn_set.size() < 2); // dirs can't be hard-linked
>     Dentry *dn = in->get_first_parent();
>     if (!dn) {
>       // look it up
>       ldout(cct, 10) << "getcwd looking up parent for " << *in << dendl;
>       MetaRequest *req = new MetaRequest(CEPH_MDS_OP_LOOKUPPARENT);
>       filepath path(in->ino);
>       req->set_filepath(path);
>       req->set_inode(in);
>       int res = make_request(req, -1, -1);
>       if (res < 0)
> 	break;
> 
>       // start over
>       path = filepath();
>       in = cwd;
>       continue;
>     }
>     path.push_front_dentry(dn->name);
>     in = dn->dir->parent_inode;
>   }
>   dir = "/";
>   dir += path.get_path();
> }
> 
> The old version would return the diri + dentry + in, the new version just 
> returns dir.   I don't see an old user in the kernel code, but I wonder if 
> we should 
> 
> - keep the old semantics (diri + dentry + in) and make the kernel 
> essentially ignore this information, or
> 
> - change getcwd to use LOOKUPINO + WANT_DENTRY to make it work.

I prefer to change getcwd. The problem of old LOOKUPPARENT semantic is that
client can't lock the parent inode in advance, This breaks VFS locking rules
for lookup.

I added the getcwd fix to https://github.com/ceph/ceph/pull/1385

Regards
Yan, Zheng

> 
> ?
> sage
> 

