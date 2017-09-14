From: Sage Weil <sage@newdream.net>
Subject: Re: undefined references in luminous for librados-devel
Date: Thu, 14 Sep 2017 21:31:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709142130100.16664@piezo.novalocal>
References: <CAB2gnbWciSJmZzREHqJvz5Ae=uD+_5TkgkNcaYr+swxYe2iXAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34864 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdINVbE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 17:31:04 -0400
In-Reply-To: <CAB2gnbWciSJmZzREHqJvz5Ae=uD+_5TkgkNcaYr+swxYe2iXAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 14 Sep 2017, Noah Watkins wrote:
> Running into some undefined references linking against librados in
> Luminous. Installed using RPM repo instructions from Ceph docs. Note
> this issue shows up on Fedora 23,24,25, but not on CentOS 7.

It looks a bit like these are C++ ABI differences because you are using 
el7 libraries on an fc25 box, which probably has a different 
version of gcc, libraries, etc?

sage


> # Test program
> 
> [root@0ac98bfcffa2 build]# cat test.cc
> #include <rados/librados.hpp>
> 
> int main(int argc, char **argv)
> {
>   librados::IoCtx ioctx;
>   return ioctx.create("foo", true);
> }
> 
> # Linking error
> 
> [root@0ac98bfcffa2 build]# c++ --std=c++11 -Wall test.cc -lrados
> /tmp/cc4MZnFR.o: In function `main':
> test.cc:(.text+0x51): undefined reference to
> `librados::IoCtx::create(std::__cxx11::basic_string<char,
> std::char_traits<char>, std::allocator<char> > const&, bool)'
> collect2: error: ld returned 1 exit status
> 
> # Looks like everything is installed correctly.
> 
> [root@0ac98bfcffa2 build]# librados-config --version
> ceph version 12.2.0 (32ce2a3ae5239ee33d6150705cdb24d43bab910c) luminous (rc)
> 
> [root@0ac98bfcffa2 build]# rpm -qa | grep 'rados\|ceph'
> python-rados-12.2.0-0.el7.x86_64
> python-cephfs-12.2.0-0.el7.x86_64
> ceph-selinux-12.2.0-0.el7.x86_64
> ceph-osd-12.2.0-0.el7.x86_64
> librados2-12.2.0-0.el7.x86_64
> libradosstriper1-12.2.0-0.el7.x86_64
> ceph-base-12.2.0-0.el7.x86_64
> ceph-mds-12.2.0-0.el7.x86_64
> ceph-mon-12.2.0-0.el7.x86_64
> ceph-12.2.0-0.el7.x86_64
> libcephfs2-12.2.0-0.el7.x86_64
> ceph-common-12.2.0-0.el7.x86_64
> ceph-mgr-12.2.0-0.el7.x86_64
> librados-devel-12.2.0-0.el7.x86_64
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
