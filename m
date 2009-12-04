From: Sage Weil <sage@newdream.net>
Subject: v0.18 released
Date: Fri, 4 Dec 2009 10:52:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0912041045520.5007@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

There's a v0.18 release to match the latest posting of the kernel client 
code on the Linux email lists.  If there are no final issues there, that 
will be what I send to Linus for 2.6.33.

Most of the changes since v0.17 are bug fixes in the MDS and kclient.  The 
main other item is an authentication framework to restrict access to the 
cluster and it's services to authorized clients.  Two protocols/schemes 
are implemented: an AUTH_NONE framework that does no real authentication 
(and is essentially equivalent to what we've had until now) and a 
AUTH_CEPHX scheme that uses  Kerberos-like tickets to mutually 
authenticate clients and services.

Changes since v0.17 include:
- osd: basic ENOSPC handling
- big endian fixes (required protocol/disk format change)
- osd: improved object -> pg hash function; selectable
- crush: selectable hash function(s)
- mds restart bug fixes
- kclient: mds reconnect bug fixes
- fixed mds log trimming bug
- fixed mds cap vs snap deadlock
- filestore: faster flushing
- uclient,kclient: snapshot fixes
- mds: fix recursive accounting bug
- uclient: fixes for 32bit clients
- auth: 'none' security framework
- mon: "safely" bail on write errors (e.g. ENOSPC)
- mds: fix replay/reconnect race (caused (fast) client reconnect to fail)
- mds: misc journal replay, session fixes

There is a known memory leak in the MDS in this release.  It should be 
fixed in the unstable git shortly.

Looking forward, the main items are:

    * stability
    * fixing a few pressing MDS performance issues
    * improving OSD interaction with btrfs (we may switch to using btrfs 
      snapshots in place of the user transaction ioctls)
    * stability

Relevant URLs:

    * Direct download at http://ceph.newdream.net/download/ceph-0.18.tar.gz
    * For Debian packages see http://ceph.newdream.net/wiki/Debian

sage

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
