From: Sage Weil <sage@newdream.net>
Subject: Re: OSDs crashing with latest master
Date: Thu, 1 Dec 2011 21:07:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112012107180.14320@cobra.newdream.net>
References: <4ED85A17.10303@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48394 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab1LBFH7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2011 00:07:59 -0500
In-Reply-To: <4ED85A17.10303@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 1 Dec 2011, Noah Watkins wrote:
> Running a new master install on 13 nodes. Half the OSDs crashed with the
> following stack trace.

Fixed by commit 2f5bd5f737e831a03beb93c3928c74b59a59052e.

Thanks!
sage


> 
> Thanks,
> Noah
> 
> 2011-12-01 20:31:17.974984 7f0826e07700 osd.4 11 OSD::ms_handle_reset()
> 2011-12-01 20:31:17.975030 7f0826e07700 osd.4 11 OSD::ms_handle_reset()
> s=0x27c86c0
> 2011-12-01 20:35:45.729921 7f0826e07700 osd.4 11 OSD::ms_handle_reset()
> 2011-12-01 20:35:45.729987 7f0826e07700 osd.4 11 OSD::ms_handle_reset()
> s=0x2097900
> osd/ReplicatedPG.cc: In function 'void
> ReplicatedPG::sub_op_modify(MOSDSubOp*)', in thread '7f08234ff700'
> osd/ReplicatedPG.cc: 3373: FAILED assert(0)
>  ceph version 0.38-273-g813523a
> (commit:813523a6816417c75cae0d6aac6e3222c5d6c605)
>  1: (ReplicatedPG::sub_op_modify(MOSDSubOp*)+0x1402) [0x4b4672]
>  2: (ReplicatedPG::do_sub_op(MOSDSubOp*)+0x83) [0x4d6d13]
>  3: (OSD::dequeue_op(PG*)+0x3e4) [0x541304]
>  4: (ThreadPool::worker()+0xa28) [0x5bef08]
>  5: (ThreadPool::WorkThread::entry()+0xd) [0x565f7d]
>  6: (()+0x7971) [0x7f0832a90971]
>  7: (clone()+0x6d) [0x7f083111b92d]
>  ceph version 0.38-273-g813523a
> (commit:813523a6816417c75cae0d6aac6e3222c5d6c605)
>  1: (ReplicatedPG::sub_op_modify(MOSDSubOp*)+0x1402) [0x4b4672]
>  2: (ReplicatedPG::do_sub_op(MOSDSubOp*)+0x83) [0x4d6d13]
>  3: (OSD::dequeue_op(PG*)+0x3e4) [0x541304]
>  4: (ThreadPool::worker()+0xa28) [0x5bef08]
>  5: (ThreadPool::WorkThread::entry()+0xd) [0x565f7d]
>  6: (()+0x7971) [0x7f0832a90971]
>  7: (clone()+0x6d) [0x7f083111b92d]
> *** Caught signal (Aborted) **
>  in thread 7f08234ff700
>  ceph version 0.38-273-g813523a
> (commit:813523a6816417c75cae0d6aac6e3222c5d6c605)
>  1: /usr/bin/ceph-osd() [0x6b1d14]
>  2: (()+0xfb40) [0x7f0832a98b40]
>  3: (gsignal()+0x35) [0x7f0831068ba5]
>  4: (abort()+0x180) [0x7f083106c6b0]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f083190c6bd]
>  6: (()+0xb9906) [0x7f083190a906]
>  7: (()+0xb9933) [0x7f083190a933]
>  8: (()+0xb9a3e) [0x7f083190aa3e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x39f) [0x5cce4f]
>  10: (ReplicatedPG::sub_op_modify(MOSDSubOp*)+0x1402) [0x4b4672]
>  11: (ReplicatedPG::do_sub_op(MOSDSubOp*)+0x83) [0x4d6d13]
>  12: (OSD::dequeue_op(PG*)+0x3e4) [0x541304]
>  13: (ThreadPool::worker()+0xa28) [0x5bef08]
>  14: (ThreadPool::WorkThread::entry()+0xd) [0x565f7d]
>  15: (()+0x7971) [0x7f0832a90971]
>  16: (clone()+0x6d) [0x7f083111b92d]
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
