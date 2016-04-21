From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Running Test Scripts without CMake Environment Variables
Date: Thu, 21 Apr 2016 11:11:01 +0200
Message-ID: <57189925.6010407@digiware.nl>
References: <545596550.14429240.1461016414390.JavaMail.zimbra@redhat.com>
 <5715E72A.2040202@digiware.nl>
 <1402915173.14974375.1461074347967.JavaMail.zimbra@redhat.com>
 <5716717C.8000900@digiware.nl>
 <386579066.15401424.1461125540382.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:23536 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbcDUJUX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Apr 2016 05:20:23 -0400
In-Reply-To: <386579066.15401424.1461125540382.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ali Maredia <amaredia@redhat.com>, ceph-devel@vger.kernel.org

On 20-4-2016 06:12, Matt Benjamin wrote:
> Hi Willem,
>
> I think most devs now believe it's worth switching to cmake, mainly
> for build performance.
>
> I recall having issues compiling with Clang++ recently too--but for
> me, the issues seemed to be related to leveldb and rocksdb linkage.
> I know that a number of us would like Clang++ builds to be generally
> supported, not something that you have to maintain yourself just for
> FreeBSD.
>
> When you do experiment with cmake again, I'm sure folks will try to
> be helpful with specific issues.

'mmmm, lets give it a shot....
Created a separate WIP for it
And hope that Cmake guys lurk here

FreeBSD does have not udev, something similar is devd but it is
certainly not used to the extend
that udev it is used under Linux, as far as I can tell.

-- Not Found libudev: UDEV_LIBRARY-NOTFOUND
CMake Error at
/usr/local/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:148
(message):
   Could NOT find udev (missing: UDEV_LIBRARIES UDEV_INCLUDE_DIR)
Call Stack (most recent call first):
   /usr/local/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:388
(_FPHSA_FAILURE_MESSAGE)
   cmake/modules/Findudev.cmake:52 (find_package_handle_standard_args)
   CMakeLists.txt:129 (find_package)

And as for UUIDs I'm using a different library from a package
misc/e2fsprogs-libuuid and link with -luuid.

These are my full setting I use before running autogen.sh and configure:
     CWARN=""
     COPTIMIZE="-g -O0 -fno-omit-frame-pointer"
     CLANGWARN="-Wno-unused-local-typedef -Wno-mismatched-tags 
-Wno-macro-redefined -Wno-unused-function -Wno-unused-label 
-Wno-undefined-bool-conversion -Wno-unused-private-field 
-Wno-unused-local-typedef -Wno-uninitialized -Wno-gnu-designator 
-Wno-inconsistent-missing-override -Wno-deprecated-declarations 
-Wno-parentheses -Wno-missing-braces"
     CFLAGS="${COPTIMIZE} -I/usr/local/include ${CWARN} ${CLANGWARN}"
     CXXFLAGS="${COPTIMIZE} -DGTEST_USE_OWN_TR1_TUPLE=1 
-I/usr/local/include ${CWARN} ${CLANGWARN}"
     LDFLAGS="-g ${LDFLAGS} -L/usr/local/lib -export-dynamic -luuid -lcxxrt"
     FREEBSD_CONFIGURE_FLAGS="
       --disable-silent-rules
       --disable-gitversion
       --with-debug
       --with-rados
       --without-rbd
       --with-radosgw
       --with-radosstriper
       --with-mon
       --with-osd
       --with-mds
       --with-radosgw
       --with-nss
       --without-tcmalloc
       --without-libaio
       --without-libxfs
       --without-fuse
       --without-lttng
       --with-libzfs=no
       --without-rocksdb
       --with-cephfs=no
         "
With what incantations do I glue the above in the Cmake build process?

Thanx,
--WjW
