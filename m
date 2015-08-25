From: Z Zhang <zhangz.david@outlook.com>
Subject: Long tail latency due to journal aio io_submit takes long time to
 return
Date: Tue, 25 Aug 2015 18:46:34 +0800
Message-ID: <SNT146-W82DA23C3C4087E77B0317F8C610@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from snt004-omc4s9.hotmail.com ([65.55.90.212]:60976 "EHLO
	SNT004-OMC4S9.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbbHYKve convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Aug 2015 06:51:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ceph-devel,

Recently we find there are some (not much) long tail latency due to jou=
rnal aio io_submit takes long time to return. We added some logs in the=
 FileJouranl.cc and get following output as an example. AIO's io_submit=
 function takes ~400ms to return, occasionally even takes up to 900ms.

------------------------------------------------------------
2015-08-25 15:24:39.535206 7f22699c2700 20 journal write_thread_entry w=
oke up
2015-08-25 15:24:39.535212 7f22699c2700 10 journal room 10460594175 max=
_size 10484711424 pos 4786679808 header.start 4762566656 top 4096
2015-08-25 15:24:39.535215 7f22699c2700 10 journal check_for_full at 47=
86679808 : 532480 < 10460594175
2015-08-25 15:24:39.535216 7f22699c2700 15 journal prepare_single_write=
 1 will write 4786679808 : seq 13075224 len 526537 -> 532480 (head 40 p=
re_pad 4046 ebl 526537 post_pad 1817 tail 40) (ebl alignment 4086)
2015-08-25 15:24:39.535322 7f22699c2700 20 journal prepare_multi_write =
queue_pos now 4787212288
2015-08-25 15:24:39.535324 7f22699c2700 15 journal do_aio_write writing=
 4786679808~532480
2015-08-25 15:24:39.535434 7f22699c2700 10 journal align_bl total memco=
py: 532480
2015-08-25 15:24:39.535439 7f22699c2700 20 journal write_aio_bl 4786679=
808~532480 seq 13075224
2015-08-25 15:24:39.535442 7f22699c2700 20 journal write_aio_bl .. 4786=
679808~532480 in 1
2015-08-25 15:24:39.535444 7f22699c2700 =A05 journal io_submit starting=
=2E..

2015-08-25 15:24:39.990372 7f22699c2700 =A05 journal io_submit return v=
alue: 1
2015-08-25 15:24:39.990396 7f22699c2700 =A05 journal put_throttle finis=
hed 1 ops and 526537 bytes, now 12 ops and 6318444 bytes
2015-08-25 15:24:39.990401 7f22691c1700 20 journal write_finish_thread_=
entry waiting for aio(s)
2015-08-25 15:24:39.990406 7f22699c2700 20 journal write_thread_entry a=
io throttle: aio num 1 bytes 532480 ... exp 2 min_new 4 ... pending 631=
8444
2015-08-25 15:24:39.990410 7f22699c2700 10 journal room 10460061695 max=
_size 10484711424 pos 4787212288 header.start 4762566656 top 4096
2015-08-25 15:24:39.990413 7f22699c2700 10 journal check_for_full at 47=
87212288 : 532480 < 10460061695
2015-08-25 15:24:39.990415 7f22699c2700 15 journal prepare_single_write=
 1 will write 4787212288 : seq 13075225 len 526537 -> 532480 (head 40 p=
re_pad 4046 ebl 526537 post_pad 1817 tail 40) (ebl alignment 4086)
------------------------------------------------------------

And write_aio_bl will hold aio_lock until it returns, so write_finish_t=
hread_entry can't process completed aio when io_submit is blocking. We =
reduced the aio_lock's locking scope in write_aio_bl,=A0specifically no=
t locking io_submit. It doesn't seem to need lock on io_submit in journ=
al because there is only 1 write_thread_entry and 1 write_finish_thread=
_entry.=A0

This might help those completed aio to get processed asap. But for the =
one blocked in io_submit and the ones in the queue, they still need to =
take more time.

Any idea about this?=A0

Thanks,
Zhi Zhang (David) 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
