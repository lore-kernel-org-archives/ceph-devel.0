From: Sage Weil <sage@inktank.com>
Subject: Re: assertion failure while stating an object
 (librados::IoCtx::stat)
Date: Fri, 4 Apr 2014 08:16:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404040812400.22715@cobra.newdream.net>
References: <loom.20140404T115508-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46926 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbaDDPQ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Apr 2014 11:16:57 -0400
In-Reply-To: <loom.20140404T115508-66@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit Tiwary <tiwaryamt@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Amit,

On Fri, 4 Apr 2014, Amit Tiwary wrote:
> Hi Ceph Team, We are using ceph version 0.67.4 and are recently hitting 
> large number of assertion failures on our ceph cluster while stating an 
> object using C++ librados API (as shown below)
> -----
>  uint64_t size;
>  time_t mtime;
>  std::string object_name;
>  librados::IoCtx mioctx;
>  ...
>  do {
>    // generate object_name
>  }
>  while ( 0 == mioctx.stat(object_name, &size, &mtime));
> -----
> We did not face similar issues in past 3 months.
> Any thoughts on what can be done to straighten this up?
> 
> Sample log is given below:
> 
> common/Mutex.cc: In function 'void Mutex::Lock(bool)' thread 7f615f275700 
> time 2014-04-04 09:03:22.128731
> common/Mutex.cc: 93: FAILED assert(r == 0)
>  ceph version 0.67.4 (ad85b8bfafea6232d64cb7ba76a8b6e8252fa0c7)
>  1: (Mutex::Lock(bool)+0x1d3) [0x7f61576ac763]
>  2: (librados::IoCtxImpl::operate_read(object_t const&, ObjectOperation*, 
> ceph::buffer::list*)+0x17b) [0x7f615765069b]

This Mutex assertion usually triggers in use-after-free cases where the 
pthread mutex id is invalid (because it has been deallocated).  My guess 
is that your IoCtx has been freed, or the shutdown() method has been 
called on the cluster handle... is that possible?  (Obviously not with the 
code fragment above, but I'm guess that isn't a straight copy+paste from 
your code?)

sage





>  3: (librados::IoCtxImpl::stat(object_t const&, unsigned long*, 
> long*)+0x185) [0x7f6157653b05]
>  4: (librados::IoCtx::stat(std::string const&, unsigned long*, long*)+0x58) 
> [0x7f6157628498]
>  5: (radosencwriter::getUniqueObjectName(unsigned int)+0x22b) 
> [0x7f6158726c6b]
>  6: (radosencwriter::write_to_rados(std::string const&, unsigned 
> long)+0x14c) [0x7f6158726f9c]
>  7: (radosencwriter::write(std::string const&, unsigned long)+0x37a) 
> [0x7f615872868a]
>  8: (()+0x36153) [0x7f6158715153]
>  9: (Perl_pp_entersub()+0x5a5) [0x7f615eda3705]
>  10: (Perl_runops_standard()+0x16) [0x7f615eda1c46]
>  11: (perl_run()+0x13c) [0x7f615ed4660c]
>  12: (main()+0x154) [0x400f24]
>  13: (__libc_start_main()+0xfd) [0x7f615e312c8d]
>  14: starman worker () [0x400d09]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to 
> interpret this.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
