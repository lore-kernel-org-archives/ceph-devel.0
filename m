From: Christian Brunner <chb@muc.de>
Subject: [PATCH] cclass: fix .so loading file
Date: Mon, 2 Aug 2010 21:58:30 +0200
Message-ID: <20100802195830.GC4923@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61359 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab0HBT6f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 15:58:35 -0400
Received: by bwz1 with SMTP id 1so1616559bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Aug 2010 12:58:33 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 09, 2010 at 09:41:24AM -0700, Sage Weil wrote:
> On Fri, 9 Jul 2010, Christian Brunner wrote:
> > Hi,
> > 
> > in the following I'll send a few fixes and additions for the rpm spec file.
> > Please commit the patches that you like to the repository.
> 
> Thanks, committing now.
> 
> There's one other pitfall I ran into with the debs... by default symbols 
> are stripped from all binaries, but the libcls_rbd.so shared object needs 
> to _not_ be stripped, or else the class loading doesn't work.  I have no 
> idea where/when/if this is done during the rpmbuild.  The version in the 
> built package should look like so:
> 
> $ nm .libs/libcls_rbd.so
> 000000000000797d T __cls_init
> 000000000020ce50 D __cls_name
> 000000000020ce7c B __cls_name__rbd
> 000000000020ce78 B __cls_ver__1_1
> 000000000020ce48 D __cls_ver_maj
> 000000000020ce4c D __cls_ver_min
> 
> Thanks-
> sage

Hi Sage,

shared objects are not stript on our system. So I can't reproduce this.

The only thing I've found, is that the *.so files are included in the -devel
rpm. This leads to the fact that the 'find' in cclass doesn't return any
files. I'd suggest the attached change in the script.

Christian

---
 src/cclass.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cclass.in b/src/cclass.in
index 69513fa..1a2a807 100755
--- a/src/cclass.in
+++ b/src/cclass.in
@@ -85,7 +85,7 @@ load() {
 }
 
 load_all() {
-	all=`find $libdir -name 'libcls_*.so'`;
+	all=`find $libdir -name 'libcls_*.so*' -type f`;
 	if [ -n "$all" ]; then
 		for fn in $all; do
 			echo Loading class: $fn: `$BINDIR/cclsinfo $fn`
-- 
1.7.0.4


