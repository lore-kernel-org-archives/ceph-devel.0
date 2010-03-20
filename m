From: Dan Carpenter <error27@gmail.com>
Subject: bug report: ceph: && vs ||
Date: Sat, 20 Mar 2010 15:39:26 +0300
Message-ID: <20100320123926.GA30085@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org



  1772          /* correct session? */
  1773          if (!req->r_session && req->r_session != session) {

	Is this supposed to || here?  We know "session" is non-NULL at
	the point because we already dereferenced it.  If "req->r_session"
	is null then the second condition is always true.

	Also we dereference "req->r_session" later on without checking.

  1774                  pr_err("mdsc_handle_reply got %llu on session mds%d"
  1775                         " not mds%d\n", tid, session->s_mds,
  1776                         req->r_session ? req->r_session->s_mds : -1);
  1777                  mutex_unlock(&mdsc->mutex);
  1778                  goto out;
  1779          }
  1780

regards,
dan carpenter
