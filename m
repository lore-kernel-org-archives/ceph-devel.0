From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] compile error on centos 5.9
Date: Sun, 4 Aug 2013 21:03:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308042100330.5645@cobra.newdream.net>
References: <51FF1100.2000004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40740 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3HEEDX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 00:03:23 -0400
In-Reply-To: <51FF1100.2000004@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huangjun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

[Moving to ceph-devel]

On Mon, 5 Aug 2013, huangjun wrote:
> hi,all
> i compiled ceph 0.61.3 on centos 5.9,the "sh autogen.sh" and
> "./configure " is ok, but when i "make", an error occurs, the err log:
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:
> In function ?int rados::cls::lock::lock(librados::IoCtx*, const
> std::string&, const std::string&, ClsLockType, const std::string&, const
> std::string&, const std::string&, const utime_t&, uint8_t)?:
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:83:
> error: ?class __gnu_cxx::lock? is not a function,
> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
> std::string&, ClsLockType, const std::string&, const std::string&, const
> std::string&, const utime_t&, uint8_t)?
> cls/lock/cls_lock_client.cc:62: error: in call to ?lock?
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:
> In member function ?void
> rados::cls::lock::Lock::lock_shared(librados::ObjectWriteOperation*)?:
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:83:
> error: ?class __gnu_cxx::lock? is not a function,
> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
> std::string&, ClsLockType, const std::string&, const std::string&, const
> std::string&, const utime_t&, uint8_t)?
> cls/lock/cls_lock_client.cc:181: error: in call to ?lock?
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:
> In member function ?int
> rados::cls::lock::Lock::lock_shared(librados::IoCtx*, const std::string&)?:
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:83:
> error: ?class __gnu_cxx::lock? is not a function,
> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
> std::string&, ClsLockType, const std::string&, const std::string&, const
> std::string&, const utime_t&, uint8_t)?
> cls/lock/cls_lock_client.cc:187: error: in call to ?lock?
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:
> In member function ?void
> rados::cls::lock::Lock::lock_exclusive(librados::ObjectWriteOperation*)?:
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:83:
> error: ?class __gnu_cxx::lock? is not a function,
> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
> std::string&, ClsLockType, const std::string&, const std::string&, const
> std::string&, const utime_t&, uint8_t)?
> cls/lock/cls_lock_client.cc:193: error: in call to ?lock?
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:
> In member function ?int
> rados::cls::lock::Lock::lock_exclusive(librados::IoCtx*, const
> std::string&)?:
> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/bits/concurrence.h:83:
> error: ?class __gnu_cxx::lock? is not a function,
> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
> std::string&, ClsLockType, const std::string&, const std::string&, const
> std::string&, const utime_t&, uint8_t)?
> cls/lock/cls_lock_client.cc:199: error: in call to ?lock?
> make[3]: *** [cls_lock_client.o] Error 1
> 
> the gcc version is 4.1.2, does this make a difference?

I suspect so.  Mark Nelson successfully built on RHEL5 a while back but 
needed to use a newer gcc.

> what should i do if i want to use ceph-fuse client on centos 5.9? must
> compile the ceph? or just compile the ceph-fuse code?

Right.. you only need the ceph-fuse code.  'make ceph-fuse' may do the 
trick.  Otherwise, you'll need to just strip out the osd stuff from 
Makefile.am.

Either way, let us know how it goes, as others would benefit from this as 
well!

Thanks-
sage
