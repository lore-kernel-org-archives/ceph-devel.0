From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: fallocate issue on CentOS 5
Date: Sat, 07 Apr 2012 23:06:05 -0600
Message-ID: <4F80C85D02000099000DE9F5@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:38854 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab2DHFGI convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:2:1>);
	Sun, 8 Apr 2012 01:06:08 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q3866A6R016946
	for <ceph-devel@vger.kernel.org>; Sun, 8 Apr 2012 00:06:11 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 53C4844C69
	for <ceph-devel@vger.kernel.org>; Sat,  7 Apr 2012 23:06:07 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

On Sat, 2012-04-07 at 08:48 -0700, Sage Weil wrote:
> On Sat, 7 Apr 2012, Nick Couchman wrote:
> > I'm trying to compile 0.44.1 on CentOS 5, and am running into the following compile-time error:
> > 
> >  g++ -DHAVE_CONFIG_H -I. -I. -I. -I/usr/include/nss3 -I/usr/include/nspr4 -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -D_GNU_SOURCE -rdynamic -Winit-self -Wpointer-arith -fno-strict-aliasing -DCEPH_LIBDIR=\"/usr/lib64\" -Wnon-virtual-dtor -Wno-invalid-offsetof -Wstrict-null-sentinel -I../src/leveldb/include -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic -MT libos_la-FileStore.lo -MD -MP -MF .deps/libos_la-FileStore.Tpo -c os/FileStore.cc  -fPIC -DPIC -o .libs/libos_la-FileStore.o
> > os/FileStore.cc: In member function 'int FileStore::_zero(coll_t, const hobject_t&, uint64_t, size_t)':
> > os/FileStore.cc:3013: error: 'fallocate' was not declared in this scope
> > os/FileStore.cc: In member function 'void FileStore::sync_entry()':
> > os/FileStore.cc:3385: warning: passing 'float' for argument 1 to 'SyncEntryTimeout::SyncEntryTimeout(int)'
> > make[3]: *** [libos_la-FileStore.lo] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > 
> > Interestingly, if I go to that block of code, there's an "#ifdef HAVE_FALLOCATE" block there, and this is inside that block.  So, I go and look at the output of configure and I see:
> > 
> > checking for utime.h... yes
> > checking for sync_file_range... no
> > checking for fallocate... no
> > checking for a Python interpreter with version >= 2.4... python
> > checking for python... /usr/bin/python
> > 
> > Configure script believes fallocate is not available.  And, indeed, from config.log:
> > 
> > configure:18309: checking for fallocate
> > configure:18309: gcc -o conftest -g -O2 conftest.c >&5
> > /tmp/ccybZzwg.o: In function `main':
> > /root/ceph-0.44.1/conftest.c:81: undefined referenece to `fallocate'
> > 
> > Okay, so compiler cannot find it, then why is this block of code being evaluated??  I poked around a bit more, and found that HAVE_FALLOCATE is defined in /usr/include/linux/fs.h, which appears to be included in FileStore.cc.  So, even though the configure script fails to detect fallocate correctly, it's still pulling it in because it is defined in the linux/fs.h file, even though it doesn't work.  What's the best way to fix this build issue and have it correctly disable HAVE_FALLOCATE if fallocate() doesn't really work?
> 
> That's annoying.  You could modify configure.ac so that it defines 
> something other than HAVE_FALLOCATE (CEPH_HAVE_FALLOCATE, perhaps) and 
> adjust the #ifdefs accordingly...
> 
> sage

Very annoying, but thanks for the tip - that worked great!  I was able
to patch configure.ac and src/os/FileStore.cc in that manner and build
RPMs for CentOS 5!

-Nick




--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
