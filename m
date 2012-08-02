From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Errors compiling ceph argonaut
Date: Thu, 02 Aug 2012 13:39:54 -0600
Message-ID: <501A832A02000099000E6EDB@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:34369 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab2HBUrY convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:1:1>);
	Thu, 2 Aug 2012 16:47:24 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q72JdcVb021381
	for <ceph-devel@vger.kernel.org>; Thu, 2 Aug 2012 13:39:39 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 3F79D44B93
	for <ceph-devel@vger.kernel.org>; Thu,  2 Aug 2012 13:39:55 -0600 (MDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Running into some errors compiling ceph-0.48 (argonaut) on RHEL5.  It gets most of the way through the build process and then throws the following:

  CXX    librbd_la-cls_rbd_client.lo
/usr/include/sys/types.h:46: error: conflicting declaration 'typedef __loff_t loff_t'
/usr/include/linux/types.h:30: error: 'loff_t' has a previous declaration as 'typedef __kernel_loff_t loff_t'
/usr/include/sys/types.h:62: error: conflicting declaration 'typedef __dev_t dev_t'
/usr/include/linux/types.h:13: error: 'dev_t' has a previous declaration as 'typedef __kernel_dev_t dev_t'
/usr/include/time.h:105: error: conflicting declaration 'typedef void* timer_t'
/usr/include/linux/types.h:22: error: 'timer_t' has a previous declaration as 'typedef __kernel_timer_t timer_t'
/usr/include/sys/types.h:198: error: conflicting declaration 'typedef long int int64_t'
/usr/include/linux/types.h:98: error: 'int64_t' has a previous declaration as 'typedef __s64 int64_t'
/usr/include/sys/types.h:204: error: conflicting declaration 'typedef long unsigned int u_int64_t'
/usr/include/linux/types.h:97: error: 'u_int64_t' has a previous declaration as 'typedef __u64 u_int64_t'
/usr/include/sys/select.h:78: error: conflicting declaration 'typedef struct fd_set fd_set'
/usr/include/linux/types.h:12: error: 'fd_set' has a previous declaration as 'typedef struct __kernel_fd_set fd_set'
/usr/include/sys/types.h:248: error: conflicting declaration 'typedef __blkcnt64_t blkcnt_t'
/usr/include/linux/types.h:114: error: 'blkcnt_t' has a previous declaration as 'typedef long unsigned int blkcnt_t'
/usr/include/stdint.h:56: error: conflicting declaration 'typedef long unsigned int uint64_t'
/usr/include/linux/types.h:96: error: 'uint64_t' has a previous declaration as 'typedef __u64 uint64_t'
make[3]: *** [librbd_la-cls_rbd_client.lo] Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: Leaving directory `/usr/src/redhat/BUILD/ceph-0.48argonaut.test/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/usr/src/redhat/BUILD/ceph-0.48argonaut.test/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/ceph-0.48argonaut.test/src'
make: *** [all-recursive] Error 1

So, looks like a source file is pulling in both sys/types.h and linux/types.h, and that's causing problems.  From what I can see, most of the files only pull in one or the other (via some ifdef/elif code blocks), but evidently one of them does not.  I have not been able to track it down, yet - is this something anyone else has encountered?  0.44 seemed to work fine, this seems to be unique to 0.48.

Thanks,
Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
