From: Sage Weil <sage@inktank.com>
Subject: LOOKUPPARENT
Date: Thu, 6 Mar 2014 14:44:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1403061441340.3593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60818 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaCFWoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 17:44:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, zheng.z.yan@intel.com

Hey Zheng,

The recent patch that changed LOOKUPPARENT probably broke getcwd() in 
Client.cc:

void Client::getcwd(string& dir)
{
  filepath path;
  ldout(cct, 10) << "getcwd " << *cwd << dendl;

  Inode *in = cwd;
  while (in != root) {
    assert(in->dn_set.size() < 2); // dirs can't be hard-linked
    Dentry *dn = in->get_first_parent();
    if (!dn) {
      // look it up
      ldout(cct, 10) << "getcwd looking up parent for " << *in << dendl;
      MetaRequest *req = new MetaRequest(CEPH_MDS_OP_LOOKUPPARENT);
      filepath path(in->ino);
      req->set_filepath(path);
      req->set_inode(in);
      int res = make_request(req, -1, -1);
      if (res < 0)
	break;

      // start over
      path = filepath();
      in = cwd;
      continue;
    }
    path.push_front_dentry(dn->name);
    in = dn->dir->parent_inode;
  }
  dir = "/";
  dir += path.get_path();
}

The old version would return the diri + dentry + in, the new version just 
returns dir.   I don't see an old user in the kernel code, but I wonder if 
we should 

- keep the old semantics (diri + dentry + in) and make the kernel 
essentially ignore this information, or

- change getcwd to use LOOKUPINO + WANT_DENTRY to make it work.

?
sage
