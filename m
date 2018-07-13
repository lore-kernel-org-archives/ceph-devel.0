From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: IMPORTANT: broken luminous 12.2.6 release in repo,
 do not upgrade
Date: Fri, 13 Jul 2018 23:24:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1807132300580.15688@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi everyone,

tl;dr:  Please avoid the 12.2.6 packages that are currently present on 
download.ceph.com.  We will have a 12.2.7 published ASAP (probably 
Monday).

If you do not use bluestore or erasure-coded pools, none of the issues 
affect you.


Details:

We built 12.2.6 and pushed it to the repos Wednesday, but as that was 
happening realized there was a potentially dangerous regression in 
12.2.5[1] that an upgrade might exacerbate.  While we sorted that issue 
out, several people noticed the updated version in the repo and 
upgraded.  That turned up two other regressions[2][3].  We have fixes for 
those, but are working on an additional fix to make the damage from [3] 
be transparently repaired.


More details:

-- [1] http://tracker.ceph.com/issues/24597 --

This is actually a regression in 12.2.5 that affects erasure-coded pools.  
If there are (1) normal erasure code writes, and simultanously (2) erasure 
code writes that result in rados returning an error (for example, a delete 
of a non-existent object, which commonly happens when rgw is doing garbage 
collection), and (3) OSDs that are somewhat heavily loaded and then 
restart, then the bug might incorrectly roll-forward the in-progress EC 
operations.  When the PG repeers this results in an OSD crash like

src/os/filestore/FileStore.cc: 5524: FAILED assert(0 == "ERROR: source must exist")

It seems to affect filestore and busy clusters with this specific 
workload.  The OSDs recover once restarted.  However, it is also unclear 
whether it damages the objects in question.  For this reason, please avoid 
unnecessary OSD restarts if you are running 12.2.5 or 12.2.6.  When we 
release 12.2.7, we will have an upgrade procedure in the release notes 
that quiesces RADOS IO to minimize the probability that this bug will 
affect you.

If you do not have erasure-coded pools, this bug does not affect you.


-- [2] https://tracker.ceph.com/issues/24903 --

ceph-volume has had a bug for a while that leaves the 
/var/lib/ceph/osd/*/block.db or block.wal symlinks for bluestore OSDs 
owned by root:root.  This didn't matter because bluestore was ignoring 
these symlinks and using an internally stored value instead.

Both of these were fixed/changed in 12.2.6.  However, after upgrading and 
restarting, the symlink is still present in the /var/lib/ceph/osd/*/ 
tmpfs and the OSD won't restart.  Rerunning ceph-volume will fix it, as 
will manually chown -h ceph:ceph /var/lib/ceph/osd/*/block*, or a reboot.  

12.2.7 has a packaging fix to fixed this up on upgrade so there is no 
disruption.

If you do not run bluestore, this bug does not affect you.


-- [3] https://tracker.ceph.com/issues/23871 --

We modified the OSD recently to avoid storing full-object CRCs when 
bluestore is in use because those CRCs are redundant.  There was a bug in 
this code that was later fixed in master.  This code was backported to 
luminous, but the follow-on fix was missed.  The result is that a sequence 
of

- running 12.2.5
- deep-scrub (updates stored whole-object crc)
- upgrade to 12.2.6
- writefull to existing (on 12.2.6) fails to clear the whole-object crc
- read of full object -> crc mismatch

which leads to an (incorrect) EIO error.  We have fixed the original 
problem by backporting the missing fix.  However, users who mistakenly 
installed 12.2.6 may have many objects with a mismatched whole-object crc.

We are currently working on a fix to ignore the whole-object CRC if the 
same conditions are met that make us skip them entirely (i.e., running 
bluestore), and to clear/repair them on scrub.  Once this is done, we'll 
push out 12.2.7.

If you do not run bluestore, this bug does no affect you.

We don't have an easy workaround for this one at the moment, 
unfortunately.


Exciting week!  Thanks everyone,
sage
