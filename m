From: Adam Crume <adamcrume@gmail.com>
Subject: LTTng unfriendly with mixed static/dynamic linking
Date: Fri, 25 Jul 2014 11:48:24 -0700
Message-ID: <CAFu9Dv37reLPuQ_9fHkgqwDWtKiwQk8FCd4MAqY6wk75ASs07w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b5d30b6a2ea5304ff0904ca
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:41487 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbaGYSsZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 14:48:25 -0400
Received: by mail-oi0-f43.google.com with SMTP id u20so3727577oif.16
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 11:48:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--047d7b5d30b6a2ea5304ff0904ca
Content-Type: text/plain; charset=ISO-8859-1

LTTng requires tracepoints to be linked into a program only once.  If
tracepoints are linked in multiple times, the program crashes at
startup with: "LTTng-UST: Error (-17) while registering tracepoint
probe. Duplicate registration of tracepoint probes having the same
name is not allowed."

This is problematic when mixing static and dynamic linking.  If the
tracepoints are in a static library, that library can end up in an
executable multiple times by being linked in directly, as well as
being statically linked into a dynamic library.  Even if the
tracepoints are not linked directly into the executable, they can be
statically linked into multiple dynamic libraries that the executable
loads.

For us, this problem shows up with libcommon, and could show up with
others such as libosd.  (In general, I think anything added to
noinst_LTLIBRARIES is static, and anything added to lib_LTLIBRARIES is
dynamic.)

There are a few ways of solving the issue:
1. Change every library that has tracepoints, like libcommon, from
static to dynamic.  This could be a big change, as at the very least
we'd have to rename the library to something like libceph_common to
avoid conflicts, since now it would be an installed file.  This has
the advantage of keeping code and its tracepoints in the same library.
2. Keep tracepoints in a separate static library.  For example,
libcommon and libcommon_tp.  Unfortunately, every executable (but not
library!) that links in libcommon (directly or indirectly) would have
to manually link in libcommon_tp, and I don't think Automake could
automate that.
3. Keep tracepoints in a separate dynamic library.  In this case, I
think libcommon could depend on libcommon_tp, so executables would not
have to manually link in libcommon_tp.  (I'm not an Automake expert,
so let me know if I'm wrong on that.)  Again, libcommon_tp would be an
installed file, so we'd want to rename it to something like
libceph_common_tp.

I attached a minimal test case of the problem.

Thoughts or suggestions?

Thanks,
Adam Crume

--047d7b5d30b6a2ea5304ff0904ca
Content-Type: application/x-gzip; name="lttng-duplicate-tracepoints.tar.gz"
Content-Disposition: attachment;
	filename="lttng-duplicate-tracepoints.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hy1v3fov0

H4sIACKb0lMAA+2aa2/aMBSG+Yp/hdeLRCsSEkMSiXWTaGEtGqWIoU2VJqE0hBItF5aEStO0/z47
IReuaQdL1/U8HxonPj7H4PP6Emr6vn3PjWZT09BUX+d8V9X0qWPYvlcp7AmBoigSvZJqjZDUNaYg
kqpck0RJqgoFQVREpVrA0r46sI2Z56suxgV1pFqaO7P0DXZZ9S8Uc8v4m8adq7o/+MmOMdgAy3Jt
8/gTMR5/UhULAqHpohSwsJdPmMErH/8HxxhhOtDD8czWSidv0XN3CMiVbfrXHMty7J3l/wj91xL9
s+dEkIkM+s+DQP/hQMMU8Ap5hP61XWNk6Z+QeP9XE6Vg/ZdFWP9z4dCwNXM20vFBNNsfoOVnQ3/K
HqPVuQL/RJiSJE0prC6nzeiMwoymLq0flw6udNN08Nh1rLTRV/uA2v2CuSdnHrP/33UCyNK/KMuJ
/mWmf1EQJNB/HiRaj097qxNAov7kpDCX/tLWYYPQo2ag8n+Nbfq/Vr/pY8PcOeMz9E+EmpLs/2mZ
rf+1Kug/D1TTrGNLNWyEjnkNH/OTOv3jT1ExzIx73eb8KT46w5yDj06pSXidIMRa8U7YmtdQUaN1
zUG/cdHq3bS7g2Gvf3PeGjZvu43r9sWw0+5+bFy2MNfmMRd4CdtHzdF8qqEOo30nTm0/QvfjXvvi
aUEir7HTKBDzGsdiN3sMF/hOu44/nVpf7lFgi4o0Bznt4XtUq643Q9EkTXser85/2tfYV8oVCxDd
eQ4v8kI9ZRd1DhXvWUhvorr6CHNfzDLnObZq6eWl5vMwix7XOVyOW19tRjPSpjHH6x2mnyx5W/G1
ydPifZjg9ShN44FZNAq++zCJVyy5Dv2qzbkxKwWKohMOLY9MmhOmrtp1VHQtOnyhCFPlYWoqZgm5
oUaLahayd/lRbHXKRi8qOknRWyjzp4jvXd10b2m6sk7Cgv2/kn3+Z+njT3eJkbn/F+L1nxDC1n9R
qoqw/udBar1ofW51B+sO8OVgWz/oDRv9y0+lk/j2Q7vVadIH6ATmh5fKNv27M3svMTJ//63Jyf6f
nf9FRYH3//lw+KZyZ9iVO9WjO/pOk24Tz/uN/u2w1xhcveMxXwm2Jc/dS+BvsU3/4cls9xiZ6z+d
GyL9i0KVnf+JTED/eRC/6jvz/JHh8JP3a9/+rX1NiGiWBAeSbW8D0/9bwO5d3Z+5NhbgNSAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPJnfNUhYxgBQAAA=
--047d7b5d30b6a2ea5304ff0904ca--
