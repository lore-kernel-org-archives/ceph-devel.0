From: qi Shi <m13913886148@gmail.com>
Subject: Why does the heartbeat packet have 122 bytes of messages?
Date: Tue, 16 May 2017 12:50:42 +0800
Message-ID: <CAN=xyVVirpj9BsYPB5eMyNy4KrLN6KA+ysTC_29h4aD3rffSdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35351 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdEPEun (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 May 2017 00:50:43 -0400
Received: by mail-it0-f44.google.com with SMTP id c15so55573209ith.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 May 2017 21:50:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When the ceph cluster is HEALTH_OK, and there is no data to read and write.
----------------------------------------------------------------------------------------------------------
 cluster 80d21b45-ba60-4d47-a0df-1f084317770a
     health HEALTH_OK
     monmap e2: 1 mons at {node01=192.168.2.103:6789/0}
            election epoch 14, quorum 0 node01
        mgr no daemons active
     osdmap e290: 4 osds: 4 up, 4 in
            flags
sortbitwise,require_jewel_osds,require_kraken_osds,require_luminous_osds
      pgmap v13559: 256 pgs, 1 pools, 10000 MB data, 2504 objects
            72389 MB used, 802 GB / 873 GB avail
                 256 active+clean
-------------------------------------------------------------------------------------------------------------


I used tcpdump to grab packets between osds.
The following is the package I catched :
-----------------------------------------------------------------------------------------------------------------------
00:19:23.306656 IP node02.6806 > node01.54659: Flags [.], ack 1441,
win 235, options [nop,nop,TS val 98492923 ecr 77914108], length 0
00:19:25.566682 IP node01.54659 > node02.6806: Flags [P.], seq
1441:1563, ack 1442, win 123, options [nop,nop,TS val 77916408 ecr
98492923], length 122
00:19:25.567189 IP node02.6806 > node01.54659: Flags [.], ack 1563,
win 235, options [nop,nop,TS val 98495183 ecr 77916408], length 0
00:19:25.567595 IP node02.6806 > node01.54659: Flags [P.], seq
1442:1564, ack 1563, win 235, options [nop,nop,TS val 98495183 ecr
77916408], length 122
00:19:25.567601 IP node02.6806 > node01.54659: Flags [P.], seq
1564:1573, ack 1563, win 235, options [nop,nop,TS val 98495183 ecr
77916408], length 9
00:19:25.567623 IP node01.54659 > node02.6806: Flags [.], ack 1573,
win 123, options [nop,nop,TS val 77916409 ecr 98495183], length 0
00:19:25.567664 IP node01.54659 > node02.6806: Flags [P.], seq
1563:1572, ack 1573, win 123, options [nop,nop,TS val 77916409 ecr
98495183], length 9
00:19:25.607876 IP node02.6806 > node01.54659: Flags [.], ack 1572,
win 235, options [nop,nop,TS val 98495224 ecr 77916409], length 0
00:19:30.867932 IP node01.54659 > node02.6806: Flags [P.], seq
1572:1694, ack 1573, win 123, options [nop,nop,TS val 77921709 ecr
98495224], length 122
00:19:30.868603 IP node02.6806 > node01.54659: Flags [.], ack 1694,
win 235, options [nop,nop,TS val 98500484 ecr 77921709], length 0
00:19:30.868881 IP node02.6806 > node01.54659: Flags [P.], seq
1573:1695, ack 1694, win 235, options [nop,nop,TS val 98500484 ecr
77921709], length 122
00:19:30.868932 IP node02.6806 > node01.54659: Flags [P.], seq
1695:1704, ack 1694, win 235, options [nop,nop,TS val 98500484 ecr
77921709], length 9
00:19:30.868941 IP node01.54659 > node02.6806: Flags [.], ack 1704,
win 123, options [nop,nop,TS val 77921710 ecr 98500484], length 0
00:19:30.868952 IP node01.54659 > node02.6806: Flags [P.], seq
1694:1703, ack 1704, win 123, options [nop,nop,TS val 77921710 ecr
98500484], length 9
00:19:30.909155 IP node02.6806 > node01.54659: Flags [.], ack 1703,
win 235, options [nop,nop,TS val 98500525 ecr 77921710], length 0
00:19:34.368849 IP node01.54659 > node02.6806: Flags [P.], seq
1703:1825, ack 1704, win 123, options [nop,nop,TS val 77925210 ecr
98500525], length 122
00:19:34.369508 IP node02.6806 > node01.54659: Flags [.], ack 1825,
win 235, options [nop,nop,TS val 98503984 ecr 77925210], length 0
00:19:34.369672 IP node02.6806 > node01.54659: Flags [P.], seq
1704:1826, ack 1825, win 235, options [nop,nop,TS val 98503985 ecr
77925210], length 122
00:19:34.369681 IP node02.6806 > node01.54659: Flags [P.], seq
1826:1835, ack 1825, win 235, options [nop,nop,TS val 98503985 ecr
77925210], length 9
00:19:34.370055 IP node01.54659 > node02.6806: Flags [.], ack 1835,
win 123, options [nop,nop,TS val 77925211 ecr 98503985], length 0
00:19:34.370110 IP node01.54659 > node02.6806: Flags [P.], seq
1825:1834, ack 1835, win 123, options [nop,nop,TS val 77925211 ecr
98503985], length 9
00:19:34.409773 IP node02.6806 > node01.54659: Flags [.], ack 1834,
win 235, options [nop,nop,TS val 98504025 ecr 77925211], length 0
00:19:39.070578 IP node01.54659 > node02.6806: Flags [P.], seq
1834:1956, ack 1835, win 123, options [nop,nop,TS val 77929912 ecr
98504025], length 122
00:19:39.070948 IP node02.6806 > node01.54659: Flags [.], ack 1956,
win 235, options [nop,nop,TS val 98508685 ecr 77929912], length 0
00:19:39.071230 IP node02.6806 > node01.54659: Flags [P.], seq
1835:1957, ack 1956, win 235, options [nop,nop,TS val 98508686 ecr
77929912], length 122
00:19:39.071238 IP node02.6806 > node01.54659: Flags [P.], seq
1957:1966, ack 1956, win 235, options [nop,nop,TS val 98508686 ecr
77929912], length 9
00:19:39.071248 IP node01.54659 > node02.6806: Flags [.], ack 1966,
win 123, options [nop,nop,TS val 77929912 ecr 98508686], length 0
00:19:39.071286 IP node01.54659 > node02.6806: Flags [P.], seq
1956:1965, ack 1966, win 123, options [nop,nop,TS val 77929912 ecr
98508686], length 9
00:19:39.111197 IP node02.6806 > node01.54659: Flags [.], ack 1965,
win 235, options [nop,nop,TS val 98508726 ecr 77929912], length 0
00:19:39.571298 IP node01.54659 > node02.6806: Flags [P.], seq
1965:2087, ack 1966, win 123, options [nop,nop,TS val 77930412 ecr
98508726], length 122
00:19:39.571945 IP node02.6806 > node01.54659: Flags [.], ack 2087,
win 235, options [nop,nop,TS val 98509186 ecr 77930412], length 0
00:19:39.572185 IP node02.6806 > node01.54659: Flags [P.], seq
1966:2088, ack 2087, win 235, options [nop,nop,TS val 98509187 ecr
77930412], length 122
00:19:39.572191 IP node02.6806 > node01.54659: Flags [P.], seq
2088:2097, ack 2087, win 235, options [nop,nop,TS val 98509187 ecr
77930412], length 9
00:19:39.572205 IP node01.54659 > node02.6806: Flags [.], ack 2097,
win 123, options [nop,nop,TS val 77930413 ecr 98509187], length 0
00:19:39.572241 IP node01.54659 > node02.6806: Flags [P.], seq
2087:2096, ack 2097, win 123, options [nop,nop,TS val 77930413 ecr
98509187], length 9
00:19:39.612299 IP node02.6806 > node01.54659: Flags [.], ack 2096,
win 235, options [nop,nop,TS val 98509227 ecr 77930413], length 0
-----------------------------------------------------------------------------------------------------------------------

But when i look at the code, heartbeat packet is only 9 bytes.
Here is the code:
------------------------------------------------------------------------------------------------------------
int Pipe::write_keepalive2(char tag, const utime_t& t)
{
  ldout(msgr->cct,10) << "write_keepalive2 " << (int)tag << " " << t << dendl;
  struct ceph_timespec ts;
  t.encode_timeval(&ts);
  struct msghdr msg;
  memset(&msg, 0, sizeof(msg));
  struct iovec msgvec[2];
  msgvec[0].iov_base = &tag;
  msgvec[0].iov_len = 1;
  msgvec[1].iov_base = &ts;
  msgvec[1].iov_len = sizeof(ts);
  msg.msg_iov = msgvec;
  msg.msg_iovlen = 2;

  if (do_sendmsg(&msg, 1 + sizeof(ts)) < 0)
    return -1;
  return 0;
}
-----------------------------------------------------------------------------------------------------------------
"ts" is 8 bytes, and "1+sizeof(ts)" == 9 bytes.


My question is why the packet will appear 122 bytes of the message,
this message is heartbeat message?
