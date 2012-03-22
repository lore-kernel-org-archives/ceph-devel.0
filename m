From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: leveldb build issues in 0.44
Date: Thu, 22 Mar 2012 11:37:08 -0600
Message-ID: <4F6B0EE402000099000DD660@collaborate.seakr.com>
References: <4F6AE7FF02000099000DD5F9@collaborate.seakr.com>
 <CACLRD_0eLA0fj-KajQTHz3Q=1qOD_GJi67vJcB_hKN5VXGoJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:60100 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429Ab2CVRhQ convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:2:1>);
	Thu, 22 Mar 2012 13:37:16 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q2MIXHXF007589
	for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 12:33:19 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id CFCF444C5B
	for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 11:37:09 -0600 (MDT)
In-Reply-To: <CACLRD_0eLA0fj-KajQTHz3Q=1qOD_GJi67vJcB_hKN5VXGoJ9w@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

>>> On 2012/03/22 at 11:29, Samuel Just <sam.just@dreamhost.com> wrote: 
> Hmm, leveldb/include must not be in the include path.  Anyone with
> some rpm experience know how to fix that?
> -Sam
> 

I actually figured out partially what the issue is.  In the spec file, the make command sets CFLAGS and CXXFLAGS with a bunch of options.  In the src/leveldb/Makefile(.in,.am), leveldb is setting up its own CFLAGS and CXXFLAGS, and one of those flags in the include for the header files for leveldb.  So, I was able to get around it by changing the CFLAGS = and CXXFLAGS = lines to "override CFLAGS +=" and "override CXXFLAGS +=", which keeps the command-line specified variables, but adds them on to the ones in the Makefile.  I don't know if that's the proper way to do it, or if the Makefile needs some tweaking to place includes elsewhere, outside of the CFLAGS/CXXFLAGS variables.

So, I got past that issue and promptly ran into another one:

  CXX    ceph_dencoder.o
In file included from ./rgw/rgw_common.h:18:0,
                 from ./rgw/rgw_access.h:11,
                 from test/encoding/types.h:87,
                 from test/encoding/ceph_dencoder.cc:13:
./common/ceph_crypto.h:44:22: fatal error: pk11pub.h: No such file or directory
compilation terminated.
make[3]: *** [ceph_dencoder.o] Error 1

I'm suspecting something similar - a Makefile that has an issue with CFLAGS/CXXFLAGS being overriden, but now I get to track that one down :-).

-Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
