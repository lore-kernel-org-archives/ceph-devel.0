From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: Ceph mds stuck on replay forever
Date: Mon, 11 Jan 2016 11:33:56 +0800
Message-ID: <CAGkCoN+XLbjdCxtWjxXmgCHeb6SxdcBSwtLYfmQgkwum7p9XJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38531 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758005AbcAKDeh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Jan 2016 22:34:37 -0500
Received: by mail-wm0-f45.google.com with SMTP id b14so248332354wmb.1
        for <ceph-devel@vger.kernel.org>; Sun, 10 Jan 2016 19:34:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Zheng Yan <ukernel@gmail.com>

Hi Guys,

Last week one of our clusters became unavailable because MDSes always
stuck on replay state.

From the log, we found some clues:

MDS wants to replay log from 31885100783 to 31935430656. The last
prefetch expects 4194304 bytes from one mds log. At this point, the
requested_pos is increased to write_pos which is 31935430656, so there
will be no prefetch any more.

But this mds log (already the latest one) is only 4192831 bytes, so
finally read_pos can only reach 31935429183, which is less than
expected write_pos. MDS wants to read more for replay, but there is no
mds log can be read, hence MDS is stuck forever.

See below mds logs:
----------------------------------------------------------------------------------------
2016-01-08 13:26:34.468773 7f16a78a7700 10 mds.0.log replay start,
from 31885100783 to 31935430656

2016-01-08 13:26:35.164194 7f16a50a2700 10 mds.0.journaler(ro)
_issue_read reading 31931236352~4194304, read pointers
31889294570/31931236352/31935430656
2016-01-08 13:26:35.164219 7f16a50a2700 10 mds.0.objecter _op_submit
op 0x536ba80
2016-01-08 13:26:35.164235 7f16a50a2700 10 mds.0.objecter _calc_target
 pgid 2.ccfa8253 acting [0,6]
2016-01-08 13:26:35.164241 7f16a50a2700 20 mds.0.objecter _get_session
s=0x53b0f00 osd=0 2
2016-01-08 13:26:35.164243 7f16a50a2700 20 mds.0.objecter  note: not
requesting commit
2016-01-08 13:26:35.164256 7f16a50a2700 10 mds.0.objecter _op_submit
oid 200.00001dbd @2 @2 [read 0~4194304] tid 0 osd.0

2016-01-08 13:26:35.172434 7f16a98ab700 10 mds.0.objecter ms_dispatch
0x5370000 osd_op_reply(22 200.00001dbd [read 0~4192831] v0'0 uv42142
ondisk = 0) v6
2016-01-08 13:26:35.172493 7f16a98ab700 10 mds.0.objecter in handle_osd_op_reply

2016-01-08 13:26:35.172832 7f16a78a7700 10 mds.0.journaler(ro)
_finish_read got 31931236352~4192831
2016-01-08 13:26:35.172852 7f16a78a7700 10 mds.0.journaler(ro)
_assimilate_prefetch 31931236352~4192831
2016-01-08 13:26:35.172896 7f16a78a7700 10 mds.0.journaler(ro)
_assimilate_prefetch read_buf now 31889339375~46089808, read pointers
31889339375/31935429183/31935430656

2016-01-08 13:26:42.541242 7f16a50a2700 10 mds.0.journaler(ro)
_is_readable read_buf.length() == 0, but need 12 for next entry;
fetch_len is 41943040
2016-01-08 13:26:42.541251 7f16a50a2700 10 mds.0.journaler(ro)
_is_readable: not readable, returning false
2016-01-08 13:26:42.541261 7f16a50a2700 10 mds.0.journaler(ro) _prefetch
2016-01-08 13:26:42.541272 7f16a50a2700 10 mds.0.journaler(ro)
_prefetch fetch_len=41943040 read_pos=31935429183 adjustment=1473
target=31977373696 write_pos=31935430656
2016-01-08 13:26:42.541282 7f16a50a2700 10 mds.0.journaler(ro)
_is_readable read_buf.length() == 0, but need 12 for next entry;
fetch_len is 41943040
2016-01-08 13:26:42.541292 7f16a50a2700 10 mds.0.journaler(ro)
_is_readable: not readable, returning false
2016-01-08 13:26:42.541302 7f16a50a2700 10 mds.0.journaler(ro)
wait_for_readable at 31935429183 onreadable 0x7f16a50a1d40
----------------------------------------------------------------------------------------


From mds log object, 200.00001dbd is the latest one whose size is
4192831 bytes. The write_pos in 200.00000000 object is 31935430656.

The strange thing is the modified time of this two objects.
200.00000000 object's modified time is older than 200.00001dbd
object's. Does this mean mds update log meta info first, then write
log data? In our case, writing log data to 200.00001dbd fails somehow?

----------------------------------------------------------------------------------------
[ceph@xxx /data/lib/ceph/osd/ceph-0/current/2.94_head/DIR_4/DIR_9/DIR_4]$ ls -lh
total 4.0K
-rw-r--r-- 1 root root 90 Jan  8 02:06 200.00000000__head_844F3494__2

[ceph@xxx /data/lib/ceph/osd/ceph-0/current/2.53_head/DIR_3/DIR_5/DIR_2]$ ls -l
total 4096
-rw-r--r-- 1 root root 4192831 Jan  8 02:09 200.00001dbd__head_CCFA8253__2
----------------------------------------------------------------------------------------


Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com
