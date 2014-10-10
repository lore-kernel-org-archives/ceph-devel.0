From: Alexandre Oliva <oliva@gnu.org>
Subject: rados.py: add tmap_to_omap method
Date: Fri, 10 Oct 2014 02:57:15 -0300
Message-ID: <ork348a2mc.fsf@free.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:50105 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbaJJGBB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 02:01:01 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s9A60pBN002643
	for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 06:00:52 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

I wanted to script a tmap_to_omap conversion of a few million dirs, but
running the rados program for each inode would have made it take too
long, so I wrote the attached python script, that I'm now running in
multiple copies in parallel with GNU parallel.

Before it would run, however, I found out python bindings of rados's
tmap_to_omap hadn't been implemented.  It might have been because it
takes a bool argument, and I couldn't find out how to pass it as such.

I ended up forcing the bool argument to False and passing it as an int
0.  This could fail on machines whose ABIs pass bools differently from
ints, but IIRC bools are just aliases to char in C, at least within GCC,
and since char is promoted to int for argument passing, passing an int
should work, especially if it's zero.  For nonzero values, endianness
could matter if the argument is passed on the stack, so I settled for
forcing it to zero.

If anyone knows better, please let me know.


--=-=-=
Content-Type: text/x-python
Content-Disposition: inline; filename=tmap-to-omap.py

#! /usr/bin/python

import sys
import rados
import time

r = rados.Rados(conffile='/etc/ceph/ceph.conf')
r.connect()
i = r.open_ioctx('metadata')
c = 0
err = 0
tbase = time.time()
if len(sys.argv) > 1:
    seq = sys.argv[1:]
    verbose = False
else:
    seq = sys.stdin.readlines()
    verbose = True
for s in seq:
    if verbose:
        sys.stderr.write('\r%i %4.2f/s ' % (c, c / (time.time() - tbase)))
        sys.stderr.flush()
    c = c + 1
    key = '%x.00000000' % int(s.split('\t')[0])
    try:
      i.tmap_to_omap(key)
      print(s)
    except:
      try:
        if i.stat(key)[0] == 0:
	  print(s)
      except:
        sys.stderr.write('\n%s failed\n' % s)
        sys.stderr.flush()
        err = -1
        break
exit(err)

--=-=-=


---

Add tmap_to_omap method to rados python bindings, without the bool
argument: it is forced to false.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/pybind/rados.py |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/pybind/rados.py b/src/pybind/rados.py
index 93e5040..a2394aa 100644
--- a/src/pybind/rados.py
+++ b/src/pybind/rados.py
@@ -1438,6 +1438,24 @@ returned %d, but should return zero on success." % (self.name, ret))
             raise make_ex(ret, "Failed to stat %r" % key)
         return psize.value, time.localtime(pmtime.value)
 
+    def tmap_to_omap(self, key):
+        """
+        Convert a dir from tmap to omap.
+
+        :param key: the name of the object to convert
+        :type key: str
+
+        :raises: :class:`TypeError`
+        :raises: :class:`Error`
+        :returns: int - 0 on success, otherwise raises an error
+        """
+        self.require_ioctx_open()
+        ret = run_in_thread(self.librados.rados_tmap_to_omap,
+                            (self.io, c_char_p(key), c_int(0)))
+        if ret < 0:
+            raise make_ex(ret, "Failed to convert %s from tmap to omap" % key)
+        return 0
+
     def get_xattr(self, key, xattr_name):
         """
         Get the value of an extended attribute on an object.


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer

--=-=-=--
