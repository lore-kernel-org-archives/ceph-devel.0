From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: FileStore::read meta/pginfo_** error
Date: Mon, 19 Sep 2011 11:26:50 -0700
Message-ID: <4E77896A.20600@hq.newdream.net>
References: <CABAwU-ZqBtTY-Cf=f7+w3oHN2X3O5xDogzQk2dn2gkkzbavyog@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38335 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085Ab1ISS0v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2011 14:26:51 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D3141C066
	for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2011 11:31:19 -0700 (PDT)
Received: from [192.168.107.148] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id C5EE8C065
	for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2011 11:31:19 -0700 (PDT)
In-Reply-To: <CABAwU-ZqBtTY-Cf=f7+w3oHN2X3O5xDogzQk2dn2gkkzbavyog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The truncate followed by the write is acceptable since they are part of 
a transaction which *should* guarantee atomicity.  Are you using btrfs?
-Sam

On 09/19/2011 02:54 AM, huang jun wrote:
> hi,all
> we build cluster with 40 OSDs, and do nothing to it.
> after we restart the whole cluster use "/etc/init.d/ceph -a restart",
> recently we got the error like Bug #1486.
> But it provides more detail debug log.
> before we stop the cosd process of osd23:
>
> 2011-09-19 11:13:33.422941 7f98c3221700 -- 192.168.0.112:6804/6800<==
> osd38 192.168.0.120:6801/5899 474 ==== pg_info(1 pgs e52) v1
> ==== 316+0+0 (3413838934 0 0) 0x2f73e00 con 0x2c29640
> 2011-09-19 11:13:33.422947 7f98c3221700 osd23 64 _dispatch 0x2f73e00
> pg_info(1 pgs e52) v1
> 2011-09-19 11:13:33.422969 7f98c3221700 osd23 64 handle_pg_info
> pg_info(1 pgs e52) v1 from osd38
> 2011-09-19 11:13:33.422981 7f98c3221700 osd23 64
> require_same_or_newer_map 52 (i am 64) 0x2f73e00
> 2011-09-19 11:13:33.422997 7f98c3221700 osd23 64 pg[2.456( empty n=0
> ec=2 les/c 24/51 17/17/17) [38,23] r=1 active] handle_info 2.45
> 6( empty n=0 ec=2 les/c 24/52 17/17/17) from osd38
> 2011-09-19 11:13:33.423014 7f98c3221700 osd23 64 pg[2.456( empty n=0
> ec=2 les/c 24/52 17/17/17) [38,23] r=1 active] write_info info
> 309
> 2011-09-19 11:13:33.423024 7f98c3221700 osd23 64 pg[2.456( empty n=0
> ec=2 les/c 24/52 17/17/17) [38,23] r=1 active] write_info bigbl
>   8
> 2011-09-19 11:13:33.423030 7f98c3221700 filestore(/data/osd.23)
> queue_transactions existing osr 0x3060c30/0x33c3b70
> 2011-09-19 11:13:33.423035 7f98c3221700 filestore(/data/osd.23)
> queue_transactions (trailing journal) 10200 0x2f986e0
> 2011-09-19 11:13:33.423039 7f98c3221700 filestore(/data/osd.23)
> _do_transaction on 0x2f986e0
> 2011-09-19 11:13:33.423045 7f98c3221700 filestore(/data/osd.23)
> collection_setattr /data/osd.23/current/2.456_head 'info' len 309
> 2011-09-19 11:13:33.423071 7f98c3221700 filestore(/data/osd.23)
> collection_setattr /data/osd.23/current/2.456_head 'info' len 309 =
> 309
> 2011-09-19 11:13:33.423079 7f98c3221700 filestore(/data/osd.23)
> truncate meta/pginfo_2.456/0 size 0
> 2011-09-19 11:13:33.423085 7f98c3221700 filestore(/data/osd.23)
> lfn_get cid=meta oid=pginfo_2.456/0 pathname=/data/osd.23/current/me
> ta/pginfo_2.456_0 lfn=pginfo_2.456_0 is_lfn=0
> 2011-09-19 11:13:33.423106 7f98c3221700 filestore(/data/osd.23)
> truncate meta/pginfo_2.456/0 size 0 = 0
> 2011-09-19 11:13:33.423114 7f98c3221700 filestore(/data/osd.23) write
> meta/pginfo_2.456/0 0~8
> 2011-09-19 11:13:33.423120 7f98c3221700 filestore(/data/osd.23)
> lfn_get cid=meta oid=pginfo_2.456/0 pathname=/data/osd.23/current/me
> ta/pginfo_2.456_0 lfn=pginfo_2.456_0 is_lfn=0
> 2011-09-19 11:13:33.423142 7f98c3221700 filestore(/data/osd.23)
> queue_flusher ep 208 fd 21 0~8 qlen 1
> 2011-09-19 11:13:33.423150 7f98c5a26700 filestore(/data/osd.23)
> flusher_entry awoke
> 2011-09-19 11:13:33.423156 7f98c5a26700 filestore(/data/osd.23)
> flusher_entry flushing+closing 21 ep 208
> 2011-09-19 11:13:33.423172 7f98c5a26700 filestore(/data/osd.23)
> flusher_entry sleeping
> 2011-09-19 11:13:33.423179 7f98c3221700 filestore(/data/osd.23) write
> meta/pginfo_2.456/0 0~8 = 8
> 2011-09-19 11:13:33.423201 7f98c3221700 -- 192.168.0.112:6804/6800<==
> osd34 192.168.0.118:6801/5752 304 ==== pg_info(1 pgs e55) v1
> ==== 316+0+0 (362667609 0 0) 0x36d0e00 con 0x2b96780
> 2011-09-19 11:13:33.423207 7f98c3221700 osd23 64 _dispatch 0x36d0e00
> pg_info(1 pgs e55) v1
> 2011-09-19 11:13:33.423212 7f98c3221700 osd23 64 handle_pg_info
> pg_info(1 pgs e55) v1 from osd34
> 2011-09-19 11:13:33.423216 7f98c3221700 osd23 64
> require_same_or_newer_map 55 (i am 64) 0x36d0e00
> 2011-09-19 11:13:33.423231 7f98c3221700 osd23 64 pg[1.177( empty n=0
> ec=2 les/c 24/54 14/14/14) [34,23] r=1 active] handle_info 1.17
> 7( empty n=0 ec=2 les/c 24/55 14/14/14) from osd34
> 2011-09-19 11:13:33.423245 7f98c3221700 osd23 64 pg[1.177( empty n=0
> ec=2 les/c 24/55 14/14/14) [34,23] r=1 active] write_info info
> 309
> 2011-09-19 11:13:33.423255 7f98c3221700 osd23 64 pg[1.177( empty n=0
> ec=2 les/c 24/55 14/14/14) [34,23] r=1 active] write_info bigbl
>   8
> 2011-09-19 11:13:33.423261 7f98c3221700 filestore(/data/osd.23)
> queue_transactions existing osr 0x3443960/0x340db70
> 2011-09-19 11:13:33.423266 7f98c3221700 filestore(/data/osd.23)
> queue_transactions (trailing journal) 10201 0x2f98f00
> 2011-09-19 11:13:33.423270 7f98c3221700 filestore(/data/osd.23)
> _do_transaction on 0x2f98f00
> 2011-09-19 11:13:33.423276 7f98c3221700 filestore(/data/osd.23)
> collection_setattr /data/osd.23/current/1.177_head 'info' len 309
> 2011-09-19 11:13:33.423296 7f98c3221700 filestore(/data/osd.23)
> collection_setattr /data/osd.23/current/1.177_head 'info' len 309 =
> 309
> 2011-09-19 11:13:33.423303 7f98c3221700 filestore(/data/osd.23)
> truncate meta/pginfo_1.177/0 size 0
> 2011-09-19 11:13:33.423309 7f98c3221700 filestore(/data/osd.23)
> lfn_get cid=meta oid=pginfo_1.177/0 pathname=/data/osd.23/current/me
> ta/pginfo_1.177_0 lfn=pginfo_1.177_0 is_lfn=0
> 2011-09-19 11:13:33.423331 7f98c3221700 filestore(/data/osd.23)
> truncate meta/pginfo_1.177/0 size 0 = 0
> 2011-09-19 11:13:33.423339 7f98c3221700 filestore(/data/osd.23) write
> meta/pginfo_1.177/0 0~8
> 2011-09-19 11:13:33.423344 7f98c3221700 filestore(/data/osd.23)
> lfn_get cid=meta oid=pginfo_1.177/0 pathname=/data/osd.23/current/me
> ta/pginfo_1.177_0 lfn=pginfo_1.177_0 is_lfn=0
> *** Caught signal (Terminated) **
>   in thread 0x7f98cdee0720. Shutting down.
>
> then start the cosd process,can not read the pginfo_1.177,so Terminated:
>
> 2011-09-19 11:13:35.836387 7fc8470a1720 osd23 64 _open_lock_pg 1.177
> 2011-09-19 11:13:35.836391 7fc8470a1720 osd23 64 _get_pool 1 93 ->  94
> 2011-09-19 11:13:35.836406 7fc8470a1720 osd23 64 pg[1.177( DNE empty
> n=0 ec=0 les/c 0/0 0/0/0) [] r=0 mlcod 0'0 inactive] enter Initial
> 2011-09-19 11:13:35.836412 7fc8470a1720 filestore(/data/osd.23)
> collection_getattr /data/osd.23/current/1.177_head 'info'
> 2011-09-19 11:13:35.836435 7fc8470a1720 filestore(/data/osd.23)
> collection_getattr /data/osd.23/current/1.177_head 'info' = 309
> 2011-09-19 11:13:35.836443 7fc8470a1720 filestore(/data/osd.23) read
> meta/pginfo_1.177/0 0~0
> 2011-09-19 11:13:35.836449 7fc8470a1720 filestore(/data/osd.23)
> lfn_get cid=meta oid=pginfo_1.177/0
> pathname=/data/osd.23/current/meta/pginfo_1.177_0 lfn=pginfo_1.177_0
> is_lfn=0
> 2011-09-19 11:13:35.836464 7fc8470a1720 filestore(/data/osd.23)
> FileStore::read meta/pginfo_1.177/0 0~0/0
> *** Caught signal (Aborted) ***
>   in thread 0x7fc8470a1720
> ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
>   1: /bsd/bin/cosd() [0x63e102]
>   2: (()+0xef60) [0x7fc846a80f60]
>   3: (gsignal()+0x35) [0x7fc84563f165]
>   4: (abort()+0x180) [0x7fc845641f70]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fc845ed3dc5]
>   6: (()+0xcb166) [0x7fc845ed2166]
>   7: (()+0xcb193) [0x7fc845ed2193]
>   8: (()+0xcb28e) [0x7fc845ed228e]
>   9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x132) [0x491f62]
>   10: (void decode<unsigned int, PG::Interval>(std::map<unsigned int,
> PG::Interval, std::less<unsigned int>,
> std::allocator<std::pair<unsigned int const, PG::Interval>  >  >&,
> ceph::buffer::list::iterator&)+0x31) [0x5a0b11]
>   11: (PG::read_state(ObjectStore*)+0x2d3) [0x575213]
>   12: (OSD::load_pgs()+0x1f5) [0x514f05]
>   13: (OSD::init()+0x659) [0x51fd39]
>   14: (main()+0x2401) [0x490321]
>   15: (__libc_start_main()+0xfd) [0x7fc84562bc4d]
>   16: /bsd/bin/cosd() [0x48cac9]
>
> it's a problem when we restart the osd between the truncate and write,
> so the meta/pginfo size is zero.
> why we should truncate before write in PG::write_info?
> if we got the wrong data in PG::read_state,is it reationable to
> terminate the cosd process? or can we get the data from peer?
>
> thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

