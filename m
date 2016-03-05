From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Unable to build ceph: Ubuntu 15.04 Ceph master
Date: Sat, 05 Mar 2016 19:54:45 +0100
Message-ID: <1457204085.27465.34.camel@redhat.com>
References: <CAPLK-i8OBSir0ad7whXp7pwNZ_nXhu1GB_G5okhqhzsH5pWzyA@mail.gmail.com>
	 <1457117156.27465.20.camel@redhat.com>
	 <CAPLK-i_3NHvCQCjo085-s4AeEwd5G8K-M+ZyA4xnJ2Lxwj-mEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50711 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbcCESyt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Mar 2016 13:54:49 -0500
In-Reply-To: <CAPLK-i_3NHvCQCjo085-s4AeEwd5G8K-M+ZyA4xnJ2Lxwj-mEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 2016-03-05 at 13:05 -0500, Shehbaz Jaffer wrote:
> Hello,
> 
> The command --with-radosgw helped in building the code. The compile
> error and the solution to solve the problem (adding the aforementioned
> option) is very unintuitive to user. Should this option be there by
> default? Shall I report a bug?

please open a tracker issue.

> An ideal fix will add --with-radosgw as default config file, unless
> --without-radosgw is a switch given by the user.
> 

It is a bug in the makefile, probably we are missing a check to see if
the radosgw was enabled. I don't think we need to change the configure
defaults.

> Also, I had to install the following other packages on Ubuntu 15.04,
> for successful compilation. I think these should also be checked by
> configure script:
> 
> python-setuptools
> python-pip python-dev build-essential
> virtualenv
> 
> Please let me know if it would be appropriate to report bug and commit
> fix for the same.

I don't think this is an issue,

Orit
> Thanks,
> Shehbaz
> 
> 
> On Fri, Mar 4, 2016 at 1:45 PM, Orit Wasserman <owasserm@redhat.com> wrote:
> > What configure command did you use?
> > can you try adding --with-radosgw?
> >
> > Orit
> >
> > On Fri, 2016-03-04 at 09:41 -0500, Shehbaz Jaffer wrote:
> >> Hi,
> >>
> >> I have cloned ceph from git master branch. I am getting the following
> >> errors while build:
> >>
> >> ENVIRONMENT
> >> ----------------------
> >>
> >> $ uname -a
> >> Linux donjaffer 4.3.0-dev #1 SMP Sun Dec 6 13:56:49 EST 2015 x86_64
> >> x86_64 x86_64 GNU/Linux
> >>
> >> $ g++ -v
> >> Using built-in specs.
> >> COLLECT_GCC=g++
> >> COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/4.9/lto-wrapper
> >> Target: x86_64-linux-gnu
> >> Configured with: ../src/configure -v --with-pkgversion='Ubuntu
> >> 4.9.2-10ubuntu13'
> >> --with-bugurl=file:///usr/share/doc/gcc-4.9/README.Bugs
> >> --enable-languages=c,c++,java,go,d,fortran,objc,obj-c++ --prefix=/usr
> >> --program-suffix=-4.9 --enable-shared --enable-linker-build-id
> >> --libexecdir=/usr/lib --without-included-gettext
> >> --enable-threads=posix --with-gxx-include-dir=/usr/include/c++/4.9
> >> --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu
> >> --enable-libstdcxx-debug --enable-libstdcxx-time=yes
> >> --enable-gnu-unique-object --disable-vtable-verify --enable-plugin
> >> --with-system-zlib --disable-browser-plugin --enable-java-awt=gtk
> >> --enable-gtk-cairo
> >> --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-4.9-amd64/jre
> >> --enable-java-home
> >> --with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-4.9-amd64
> >> --with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-4.9-amd64
> >> --with-arch-directory=amd64
> >> --with-ecj-jar=/usr/share/java/eclipse-ecj.jar --enable-objc-gc
> >> --enable-multiarch --disable-werror --with-arch-32=i686 --with-abi=m64
> >> --with-multilib-list=m32,m64,mx32 --enable-multilib
> >> --with-tune=generic --enable-checking=release --build=x86_64-linux-gnu
> >> --host=x86_64-linux-gnu --target=x86_64-linux-gnu
> >> Thread model: posix
> >> gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13)
> >>
> >> BUILD ERROR
> >> ---------------------
> >>
> >> $make
> >> ...
> >>   CXXLD    ceph-dencoder
> >> rgw/ceph_dencoder-rgw_dencoder.o: In function
> >> `RGWZoneGroup::generate_test_instances(std::list<RGWZoneGroup*,
> >> std::allocator<RGWZoneGroup*> >&)':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1095: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> rgw/ceph_dencoder-rgw_dencoder.o: In function
> >> `RGWZoneParams::generate_test_instances(std::list<RGWZoneParams*,
> >> std::allocator<RGWZoneParams*> >&)':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:870: undefined
> >> reference to `vtable for RGWZoneParams'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function
> >> `decode_zonegroups(std::map<std::string, RGWZoneGroup,
> >> std::less<std::string>, std::allocator<std::pair<std::string const,
> >> RGWZoneGroup> > >&, JSONObj*)':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1095: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function
> >> `RGWSystemMetaObj::~RGWSystemMetaObj()':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:763: undefined
> >> reference to `vtable for RGWSystemMetaObj'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function
> >> `RGWSystemMetaObj::~RGWSystemMetaObj()':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:763: undefined
> >> reference to `vtable for RGWSystemMetaObj'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function `RGWZoneGroup::~RGWZoneGroup()':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1096: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:763: undefined
> >> reference to `vtable for RGWSystemMetaObj'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function `RGWZoneGroup::~RGWZoneGroup()':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1096: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:763: undefined
> >> reference to `vtable for RGWSystemMetaObj'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function
> >> `std::_Rb_tree<std::string, std::pair<std::string const,
> >> RGWZoneGroup>, std::_Select1st<std::pair<std::string const,
> >> RGWZoneGroup> >, std::less<std::string>,
> >> std::allocator<std::pair<std::string const, RGWZoneGroup> >
> >> >::_M_erase(std::_Rb_tree_node<std::pair<std::string const,
> >> RGWZoneGroup> >*)':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1096: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:763: undefined
> >> reference to `vtable for RGWSystemMetaObj'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function
> >> `std::_Rb_tree_iterator<std::pair<std::string const, RGWZoneGroup> >
> >> std::_Rb_tree<std::string, std::pair<std::string const, RGWZoneGroup>,
> >> std::_Select1st<std::pair<std::string const, RGWZoneGroup> >,
> >> std::less<std::string>, std::allocator<std::pair<std::string const,
> >> RGWZoneGroup> > >::_M_emplace_hint_unique<std::piecewise_construct_t
> >> const&, std::tuple<std::string const&>, std::tuple<>
> >> >(std::_Rb_tree_const_iterator<std::pair<std::string const,
> >> RGWZoneGroup> >, std::piecewise_construct_t const&,
> >> std::tuple<std::string const&>&&, std::tuple<>&&)':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1095: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:763: undefined
> >> reference to `vtable for RGWSystemMetaObj'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function `bool
> >> JSONDecoder::decode_json<RGWZoneGroup>(char const*, RGWZoneGroup&,
> >> JSONObj*, bool)':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1095: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function `void
> >> decode_json_obj<std::string, RGWZoneGroup>(std::map<std::string,
> >> RGWZoneGroup, std::less<std::string>,
> >> std::allocator<std::pair<std::string const, RGWZoneGroup> > >&,
> >> JSONObj*)':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1095: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> rgw/ceph_dencoder-rgw_json_enc.o: In function
> >> `std::_Rb_tree_iterator<std::pair<std::string const, RGWZoneGroup> >
> >> std::_Rb_tree<std::string, std::pair<std::string const, RGWZoneGroup>,
> >> std::_Select1st<std::pair<std::string const, RGWZoneGroup> >,
> >> std::less<std::string>, std::allocator<std::pair<std::string const,
> >> RGWZoneGroup> > >::_M_insert_<std::pair<std::string const,
> >> RGWZoneGroup>&>(std::_Rb_tree_node_base*, std::_Rb_tree_node_base*,
> >> std::pair<std::string const, RGWZoneGroup>&)':
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:733: undefined
> >> reference to `vtable for RGWSystemMetaObj'
> >> /home/shehbaz/gsoc/ceph/ceph/src/rgw/rgw_rados.h:1063: undefined
> >> reference to `vtable for RGWZoneGroup'
> >> collect2: error: ld returned 1 exit status
> >> Makefile:15392: recipe for target 'ceph-dencoder' failed
> >> make[3]: *** [ceph-dencoder] Error 1
> >> make[3]: Leaving directory '/home/shehbaz/gsoc/ceph/ceph/src'
> >> Makefile:29913: recipe for target 'all-recursive' failed
> >> make[2]: *** [all-recursive] Error 1
> >> make[2]: Leaving directory '/home/shehbaz/gsoc/ceph/ceph/src'
> >> Makefile:12277: recipe for target 'all' failed
> >> make[1]: *** [all] Error 2
> >> make[1]: Leaving directory '/home/shehbaz/gsoc/ceph/ceph/src'
> >> Makefile:689: recipe for target 'all-recursive' failed
> >> make: *** [all-recursive] Error 1
> >> shehbaz@donjaffer:~/gsoc/ceph/ceph$
> >>
> >>
> >> INITIAL DIAGNOSTICS
> >> -------------------------------
> >>
> >> In src/rgw/rgw_rados.h
> >>
> >> struct RGWZoneGroup : public RGWSystemMetaObj
> >>
> >> all pure virtual functions in base class should be overriden in derived class.
> >>
> >> In RGWSystemMetaObj, the following functions are defined pure virtual:
> >>
> >>  virtual const string& get_pool_name(CephContext *cct) = 0;
> >>   virtual const string get_default_oid(bool old_format = false) = 0;
> >>   virtual const string& get_names_oid_prefix() = 0;
> >>   virtual const string& get_info_oid_prefix(bool old_format = false) = 0;
> >>   virtual const string& get_predefined_name(CephContext *cct) = 0;
> >>
> >> All these functions have been declared and overridden in struct RGWZoneGroup:
> >>
> >>  const string& get_pool_name(CephContext *cct);
> >>   const string get_default_oid(bool old_region_format = false);
> >>   const string& get_info_oid_prefix(bool old_region_format = false);
> >>   const string& get_names_oid_prefix();
> >>   const string& get_predefined_name(CephContext *cct);
> >>
> >> I also found a similar report here:
> >>
> >> http://ceph.predictor.org.pl/rgw_vtable.txt
> >>
> >> But a solution to the problem is not provided.
> >>
> >> Any help is much appreciated.
> >>
> >
> >
> 
> 
> 


