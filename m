From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: v0.60 released
Date: Tue, 02 Apr 2013 14:13:50 -0300
Message-ID: <orzjxghn3l.fsf@livre.home>
References: <alpine.DEB.2.00.1304011817500.28170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:58329 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761176Ab3DBROE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 13:14:04 -0400
In-Reply-To: <alpine.DEB.2.00.1304011817500.28170@cobra.newdream.net> (Sage
	Weil's message of "Mon, 1 Apr 2013 19:16:49 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org

--=-=-=

On Apr  1, 2013, Sage Weil <sage@inktank.com> wrote:

> * mds, ceph-fuse: fix bugs with replayed requests after MDS restart (Sage 
>   Weil)

There's a brown paperbag bug in the session_info_t compat decoding code,
that caused mds to crash on start up for me.  Here's a fix.  I also
patched the spec file so that rpms would build.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=mds-session-info-compat-decode.patch

Fix compat decoding of session_info_t

From: Alexandre Oliva <oliva@gnu.org>

Compat decoding built a set<tid_t> temporary to decode
completed_requests with its old type and took info from the set and
put it in completed_requests after decoding, but it decoded into the
new type instead of the temporary.  Oops.  Fixed.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mds/mdstypes.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/mdstypes.cc b/src/mds/mdstypes.cc
index ad4a71a..6c34c63 100644
--- a/src/mds/mdstypes.cc
+++ b/src/mds/mdstypes.cc
@@ -543,7 +543,7 @@ void session_info_t::decode(bufferlist::iterator& p)
   ::decode(inst, p);
   if (struct_v == 2) {
     set<tid_t> s;
-    ::decode(completed_requests, p);
+    ::decode(s, p);
     while (!s.empty()) {
       completed_requests[*s.begin()] = inodeno_t();
       s.erase(s.begin());

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=ceph-spec-0.60.patch

Package ceph_test_snap_mapper, drop dir dupes

From: Alexandre Oliva <oliva@gnu.org>

rpmbuild failed on ceph 0.60 because ceph_test_snap_mapper was
installed but not packaged.

rpm also complained about some directories packaged twice.  Some names
used rpm macros, others mentioned /etc and /var explicitly.
I consolidated them all into the placeholder directories group, and
changed them to use the rpm macros.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 ceph.spec.in |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index cb998c4..48aed35 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -413,13 +413,7 @@ fi
 %{_mandir}/man8/ceph-debugpack.8*
 %{_mandir}/man8/ceph-clsinfo.8.gz
 %{_mandir}/man8/librados-config.8.gz
-%dir %{_localstatedir}/lib/ceph/
-%dir %{_localstatedir}/lib/ceph/tmp/
-%dir %{_localstatedir}/log/ceph/
-%ghost %dir %{_localstatedir}/run/ceph/
-%dir %{_sysconfdir}/ceph/
 /usr/sbin/rcceph
-%dir %{_libdir}/rados-classes
 %{_libdir}/rados-classes/libcls_rbd.so*
 %{_libdir}/rados-classes/libcls_rgw.so*
 %{_libdir}/rados-classes/libcls_lock.so*
@@ -432,14 +426,17 @@ fi
 
 #set up placeholder directories
 %defattr(-,root,root,755)
-%dir /etc/ceph
-%dir /var/log/ceph
-%dir /var/lib/ceph/tmp
-%dir /var/lib/ceph/mon
-%dir /var/lib/ceph/osd
-%dir /var/lib/ceph/mds
-%dir /var/lib/ceph/bootstrap-osd
-%dir /var/lib/ceph/bootstrap-mds
+%dir %{_sysconfdir}/ceph/
+%dir %{_libdir}/rados-classes
+%dir %{_localstatedir}/lib/ceph/
+%dir %{_localstatedir}/lib/ceph/tmp/
+%dir %{_localstatedir}/log/ceph/
+%dir %{_localstatedir}/lib/ceph/mon
+%dir %{_localstatedir}/lib/ceph/osd
+%dir %{_localstatedir}/lib/ceph/mds
+%dir %{_localstatedir}/lib/ceph/bootstrap-osd
+%dir %{_localstatedir}/lib/ceph/bootstrap-mds
+%ghost %dir %{_localstatedir}/run/ceph/
 
 #################################################################################
 %files fuse
@@ -610,6 +607,7 @@ fi
 %{_bindir}/ceph_test_rados_api_stat
 %{_bindir}/ceph_test_rados_api_watch_notify
 %{_bindir}/ceph_test_rewrite_latency
+%{_bindir}/ceph_test_snap_mapper
 %{_bindir}/ceph_test_stress_watch
 %{_bindir}/ceph_test_trans
 %{_bindir}/ceph_test_crypto

--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
