From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Fri, 19 Apr 2013 07:21:21 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
 <516FF893.1030309@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:34524 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756609Ab3DSHVa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 03:21:30 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>, Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> > > Where should I start looking for performance problems? I've tried
> running
> > > some of the benchmark stuff in the documentation but I haven't gotten
> very
> > > far...
> >
> > Hi James!  Sorry to hear about the performance trouble!  Is it just
> > sequential 4KB direct IO writes that are giving you troubles?  If you
> > are using the kernel version of RBD, we don't have any kind of cache
> > implemented there and since you are bypassing the pagecache on the
> > client, those writes are being sent to the different OSDs in 4KB chunks
> > over the network.  RBD stores data in blocks that are represented by 4MB
> > objects on one of the OSDs, so without cache a lot of sequential 4KB
> > writes will be hitting 1 OSD repeatedly and then moving on to the next
> > one.  Hopefully those writes would get aggregated at the OSD level, but
> > clearly that's not really happening here given your performance.
> 
> Using dd I tried various block sizes. With 4kb I was getting around
> 500kbytes/second rate. With 1MB I was getting a few mbytes/second. Read
> performance seems great though.
> 

I did an strace -c to gather some performance info, if that helps:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 78.13   39.589549        2750     14398       967 futex
 12.45    6.308784        4200      1502           poll
  7.99    4.048253      224903        18         9 restart_syscall
  0.65    0.331042         635       521           writev
  0.34    0.172011       57337         3           SYS_344
  0.22    0.110395         117       944           close
  0.08    0.040002         310       129           truncate64
  0.07    0.036003       12001         3           fsync
  0.02    0.010611           1     10263           gettimeofday
  0.02    0.008000        1333         6           pwrite64
  0.01    0.004941           9       521           fsetxattr
  0.01    0.004256          33       129           sync_file_range
  0.01    0.002779           1      3660       814 stat64
  0.00    0.001775           4       442           sendmsg
  0.00    0.001266           1      1507           recv
  0.00    0.001103           1       948         4 open
  0.00    0.000640           1       979           time
  0.00    0.000493           1       409           clock_gettime
  0.00    0.000375           1       522           _llseek
  0.00    0.000111          11        10           read
  0.00    0.000000           0         1           setxattr
  0.00    0.000000           0         1           getxattr
  0.00    0.000000           0        32         8 fgetxattr
  0.00    0.000000           0         5           statfs64
  0.00    0.000000           0         5         5 fallocate
------ ----------- ----------- --------- --------- ----------------
100.00   50.672389                 36958      1807 total

Does that look about what you'd expect?

James
