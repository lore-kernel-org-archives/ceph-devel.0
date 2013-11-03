From: Xing <xinglin@cs.utah.edu>
Subject: Re: unable to compile
Date: Sun, 3 Nov 2013 15:13:41 -0700
Message-ID: <B9B45B52-0660-492A-AC51-597D3D01C5D5@cs.utah.edu>
References: <94B89671-08D2-49DB-837B-B0377DE8120C@cs.utah.edu>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:60262 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab3KCWNp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Nov 2013 17:13:45 -0500
In-Reply-To: <94B89671-08D2-49DB-837B-B0377DE8120C@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, noahwatkins@gmail.com
Cc: Xing <xinglin@cs.utah.edu>, Sage Weil <sage@inktank.com>

Hi all,

It looks like it is because g++ does not support designated initializer list (gcc supports it). 
http://stackoverflow.com/questions/18731707/why-does-c11-not-support-designated-initializer-list-as-c99

I am able to compile and run vstart.sh again after I reverted the following commit by Noah.
6efc2b54d5ce85fcb4b66237b051bcbb5072e6a3

Noah, do you have any feedback?

Thanks,
Xing

On Nov 3, 2013, at 1:22 PM, Xing <xinglin@cs.utah.edu> wrote:

> Hi all,
> 
> I was able to compile and run vstart.sh yesterday. When I merged the ceph master branch into my local master branch, I am not able to compile now. This issue seems to be related with boost but I have installed the libboost1.46-dev package. Any suggestions? thanks,
> 
> ===
> the compiler complains the following code section.
> 
> // file layouts
> struct ceph_file_layout g_default_file_layout = {
> .fl_stripe_unit = init_le32(1<<22),
> .fl_stripe_count = init_le32(1),
> .fl_object_size = init_le32(1<<22),
> .fl_cas_hash = init_le32(0),
> .fl_object_stripe_unit = init_le32(0),
> .fl_unused = init_le32(-1),
> .fl_pg_pool = init_le32(-1),
> };
> 
> ===make errors===
> common/config.cc:61:2: error: expected primary-expression before '.' token
> common/config.cc:61:20: warning: extended initializer lists only available with -std=c++0x or -std=gnu++0x [enabled by default]
> common/config.cc:62:2: error: expected primary-expression before '.' token
> common/config.cc:62:21: warning: extended initializer lists only available with -std=c++0x or -std=gnu++0x [enabled by default]
> common/config.cc:63:2: error: expected primary-expression before '.' token
> common/config.cc:63:20: warning: extended initializer lists only available with -std=c++0x or -std=gnu++0x [enabled by default]
> common/config.cc:64:2: error: expected primary-expression before '.' token
> common/config.cc:64:17: warning: extended initializer lists only available with -std=c++0x or -std=gnu++0x [enabled by default]
> common/config.cc:65:2: error: expected primary-expression before '.' token
> common/config.cc:65:27: warning: extended initializer lists only available with -std=c++0x or -std=gnu++0x [enabled by default]
> common/config.cc:66:2: error: expected primary-expression before '.' token
> common/config.cc:66:15: warning: extended initializer lists only available with -std=c++0x or -std=gnu++0x [enabled by default]
> common/config.cc:67:2: error: expected primary-expression before '.' token
> common/config.cc:67:16: warning: extended initializer lists only available with -std=c++0x or -std=gnu++0x [enabled by default]
> 
> I am compiling ceph in a 64-bit ubuntu12-04 machine and gcc version is 4.6.3. 
> 
> ===gcc version===
> root@client:/mnt/ceph# gcc -v
> Using built-in specs.
> COLLECT_GCC=gcc
> COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/4.6/lto-wrapper
> Target: x86_64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro 4.6.3-1ubuntu5' --with-bugurl=file:///usr/share/doc/gcc-4.6/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-4.6 --enable-shared --enable-linker-build-id --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/include/c++/4.6 --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --enable-gnu-unique-object --enable-plugin --enable-objc-gc --disable-werror --with-arch-32=i686 --with-tune=generic --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
> Thread model: posix
> gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
> 
> Thanks,
> Xing
> 
> 
> 
> 

