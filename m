From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ceph: cleanup ceph_flush_snaps()
Date: Wed, 3 Aug 2016 13:55:36 +0300
Message-ID: <20160803105536.GA22419@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18198 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbcHCK4Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2016 06:56:16 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com
Cc: ceph-devel@vger.kernel.org

Hello Yan, Zheng,

This is a semi-automatic email about new static checker warnings.

The patch ed9b430c9ba9: "ceph: cleanup ceph_flush_snaps()" from Jul 
5, 2016, leads to the following Smatch complaint:

fs/ceph/caps.c:1387 ceph_flush_snaps()
	 warn: variable dereferenced before check 'psession' (see line 1350)

fs/ceph/caps.c
  1349		struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
  1350		struct ceph_mds_session *session = *psession;
                                                   ^^^^^^^^^
New code assume psession can't be NULL.

  1351		int mds;
  1352		dout("ceph_flush_snaps %p\n", inode);
  1353	retry:
  1354		spin_lock(&ci->i_ceph_lock);
  1355		if (!(ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)) {
  1356			dout(" no capsnap needs flush, doing nothing\n");
  1357			goto out;
  1358		}
  1359		if (!ci->i_auth_cap) {
  1360			dout(" no auth cap (migrating?), doing nothing\n");
  1361			goto out;
  1362		}
  1363	
  1364		mds = ci->i_auth_cap->session->s_mds;
  1365		if (session && session->s_mds != mds) {
  1366			dout(" oops, wrong session %p mutex\n", session);
  1367			mutex_unlock(&session->s_mutex);
  1368			ceph_put_mds_session(session);
  1369			session = NULL;
  1370		}
  1371		if (!session) {
  1372			spin_unlock(&ci->i_ceph_lock);
  1373			mutex_lock(&mdsc->mutex);
  1374			session = __ceph_lookup_mds_session(mdsc, mds);
  1375			mutex_unlock(&mdsc->mutex);
  1376			if (session) {
  1377				dout(" inverting session/ino locks on %p\n", session);
  1378				mutex_lock(&session->s_mutex);
  1379			}
  1380			goto retry;
  1381		}
  1382	
  1383		__ceph_flush_snaps(ci, session);
  1384	out:
  1385		spin_unlock(&ci->i_ceph_lock);
  1386	
  1387		if (psession) {
                    ^^^^^^^^
Old code assumed it could be.

  1388			*psession = session;
  1389		} else {

regards,
dan carpenter
