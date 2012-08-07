From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Errors compiling ceph argonaut
Date: Tue, 07 Aug 2012 12:23:14 -0700
Message-ID: <50216B22.7050209@inktank.com>
References: <501A832A02000099000E6EDB@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63872 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab2HGTXS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 15:23:18 -0400
Received: by yenl2 with SMTP id l2so4084114yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 12:23:17 -0700 (PDT)
In-Reply-To: <501A832A02000099000E6EDB@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

On 08/02/2012 12:39 PM, Nick Couchman wrote:
> Running into some errors compiling ceph-0.48 (argonaut) on RHEL5.  It gets most of the way through the build process and then throws the following:
>
>    CXX    librbd_la-cls_rbd_client.lo
> /usr/include/sys/types.h:46: error: conflicting declaration 'typedef __loff_t loff_t'
> /usr/include/linux/types.h:30: error: 'loff_t' has a previous declaration as 'typedef __kernel_loff_t loff_t'
> /usr/include/sys/types.h:62: error: conflicting declaration 'typedef __dev_t dev_t'
> /usr/include/linux/types.h:13: error: 'dev_t' has a previous declaration as 'typedef __kernel_dev_t dev_t'
> /usr/include/time.h:105: error: conflicting declaration 'typedef void* timer_t'
> /usr/include/linux/types.h:22: error: 'timer_t' has a previous declaration as 'typedef __kernel_timer_t timer_t'
> /usr/include/sys/types.h:198: error: conflicting declaration 'typedef long int int64_t'
> /usr/include/linux/types.h:98: error: 'int64_t' has a previous declaration as 'typedef __s64 int64_t'
> /usr/include/sys/types.h:204: error: conflicting declaration 'typedef long unsigned int u_int64_t'
> /usr/include/linux/types.h:97: error: 'u_int64_t' has a previous declaration as 'typedef __u64 u_int64_t'
> /usr/include/sys/select.h:78: error: conflicting declaration 'typedef struct fd_set fd_set'
> /usr/include/linux/types.h:12: error: 'fd_set' has a previous declaration as 'typedef struct __kernel_fd_set fd_set'
> /usr/include/sys/types.h:248: error: conflicting declaration 'typedef __blkcnt64_t blkcnt_t'
> /usr/include/linux/types.h:114: error: 'blkcnt_t' has a previous declaration as 'typedef long unsigned int blkcnt_t'
> /usr/include/stdint.h:56: error: conflicting declaration 'typedef long unsigned int uint64_t'
> /usr/include/linux/types.h:96: error: 'uint64_t' has a previous declaration as 'typedef __u64 uint64_t'
> make[3]: *** [librbd_la-cls_rbd_client.lo] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[3]: Leaving directory `/usr/src/redhat/BUILD/ceph-0.48argonaut.test/src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/usr/src/redhat/BUILD/ceph-0.48argonaut.test/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/usr/src/redhat/BUILD/ceph-0.48argonaut.test/src'
> make: *** [all-recursive] Error 1
>
> So, looks like a source file is pulling in both sys/types.h and linux/types.h, and that's causing problems.  From what I can see, most of the files only pull in one or the other (via some ifdef/elif code blocks), but evidently one of them does not.  I have not been able to track it down, yet - is this something anyone else has encountered?  0.44 seemed to work fine, this seems to be unique to 0.48.

It looks like this might be src/include/types.h including sys/types.h 
and src/include/rbd_types.h, which is including linux/types.h.

Does adding ifdefs to src/include/types.h so it includes linux/types.h 
on linux work?

> Thanks,
> Nick

