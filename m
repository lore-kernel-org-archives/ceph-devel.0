From: David Zafman <dzafman@redhat.com>
Subject: Re: ceph-objectstore-tool import failures
Date: Fri, 19 Jun 2015 19:38:11 -0700
Message-ID: <5584D213.80405@redhat.com>
References: <alpine.DEB.2.00.1506191923200.31501@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59993 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbbFTCiN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Jun 2015 22:38:13 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 7CD92CC08A
	for <ceph-devel@vger.kernel.org>; Sat, 20 Jun 2015 02:38:13 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1506191923200.31501@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org


Have not seen this as an assert before.  Given the code below in 
do_import() of master branch the assert is impossible (?).

   if (!curmap.have_pg_pool(pgid.pgid.m_pool)) {
     cerr << "Pool " << pgid.pgid.m_pool << " no longer exists" << 
std::endl;
     // Special exit code for this error, used by test code
     return 10;  // Positive return means exit status
   }


David

On 6/19/15 7:25 PM, Sage Weil wrote:
> Hey David,
>
> On this run
>
> 	/a/sage-2015-06-18_15:51:18-rados-wip-temp---basic-multi/939648
>
> ceph-objectstore-tool is failing to import a pg because the pool doesn't
> exist.  It looks like the thrasher is doing an export+import and racing
> with a test that is tearing down a pool.  The crash is
>
>   ceph version 9.0.1-955-ge274efa
> (e274efa450e99a68c02bcb713c8837d7809f1ec3)
>   1: ceph-objectstore-tool() [0xa26335]
>   2: (()+0xfcb0) [0x7f10cef18cb0]
>   3: (gsignal()+0x35) [0x7f10cd5af425]
>   4: (abort()+0x17b) [0x7f10cd5b2b8b]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f10cdf0269d]
>   6: (()+0xb5846) [0x7f10cdf00846]
>   7: (()+0xb5873) [0x7f10cdf00873]
>   8: (()+0xb596e) [0x7f10cdf0096e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x259) [0xb0ce09]
>   10: (ObjectStoreTool::get_object(ObjectStore*, coll_t,
> ceph::buffer::list&, OSDMap&, bool*)+0x143f) [0x64829f]
>   11: (ObjectStoreTool::do_import(ObjectStore*, OSDSuperblock&, bool,
> std::string)+0x13dd) [0x64a62d]
>   12: (main()+0x3017) [0x632037]
>   13: (__libc_start_main()+0xed) [0x7f10cd59a76d]
>   14: ceph-objectstore-tool() [0x639119]
>
> I don't think this is related to my branch.. but maybe?  Have you seen
> this?  I rebased onto latest master yesterday.
>
> sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
