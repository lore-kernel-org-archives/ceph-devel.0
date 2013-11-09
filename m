From: James Harper <james.harper@bendigoit.com.au>
Subject: portability issue with gmtime method in utime_t
Date: Sat, 9 Nov 2013 08:24:22 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B665E2149@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:39894 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab3KIIYd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 03:24:33 -0500
Received: from bitcom1.int.sbss.com.au ([2002:cb10:e0fe:201:a5ca:4fd3:14f:ad5d])
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1Vf3qI-0006sK-J1
	for ceph-devel@vger.kernel.org; Sat, 09 Nov 2013 19:24:30 +1100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

utime.h defines a utime_t class with a gmtime() method, and also calls the library function gmtime_r().

mingw implements gmtime_r() as a macro in pthread.h that in turn calls gmtime(), and gcc bails because it gets confused about which is being called:
 
utime.h: In member function 'utime_t utime_t::round_to_minute()':
utime.h:113:5: error: no matching function for call to 'utime_t::gmtime(time_t*)'
utime.h:113:5: note: candidate is:
utime.h:146:12: note: std::ostream& utime_t::gmtime(std::ostream&) const
utime.h:146:12: note:   no known conversion for argument 1 from 'time_t* {aka long long int*}' to 'std::ostream& {aka std::basic_ostream<char>&}'

Same for asctime and localtime. I can work around it by creating a static method that in turn calls ::gmtime() etc, but I'm not sure that's the best way to do it.

There's a bunch of other build errors in there too so it may be a lost cause...

James
