From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RGW Blocking on 1-2 PG's - argonaut
Date: Wed, 6 Mar 2013 14:06:55 +0100
Message-ID: <CAMwB3Ticn4i3T3RZDJX5i8SMCiDa6HCRsrjeKJfVUz5wT5yBeQ@mail.gmail.com>
References: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com>
	<CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com>
	<CAMwB3ThWcpWNOp03tCv1vG1OckH0Nw0moKYnPDytNya2Hhv+XA@mail.gmail.com>
	<alpine.DEB.2.00.1303040900500.14723@cobra.newdream.net>
	<CAMwB3TjfkX8LJpBiicrcdf3UqZpYApBoEShebceee6KgY+C3kw@mail.gmail.com>
	<CAPYLRzhMBBsgDHSwn84EimJJUb7uGtRx8-ef933Kayhv1UMsvQ@mail.gmail.com>
	<CAMwB3TjQqYqhmSouFEgaiGwby=_mpk3hOGcrcx=9ho_+h1NdMg@mail.gmail.com>
	<CAMwB3TiB04etBKq==DsU-5KXm9bgLqTTAfNmh1LDhShzEDzc8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52393 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab3CFNG5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 08:06:57 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so5551745lbo.5
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 05:06:55 -0800 (PST)
In-Reply-To: <CAMwB3TiB04etBKq==DsU-5KXm9bgLqTTAfNmh1LDhShzEDzc8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, i do some test, to reproduce this problem.

As you can see, only one drive (each drive in same PG) is much more
utilize, then others, and there are some ops in queue on this slow
osd. This test is getting heads from s3 objects, alphabetically
sorted. This is strange. why this files is going in much part only
from this triple osd's.

checking what osd are in this pg.

 ceph pg map 7.35b
osdmap e117008 pg 7.35b (7.35b) -> up [18,61,133] acting [18,61,133]

On osd.61

{ "num_ops": 13,
  "ops": [
        { "description": "osd_sub_op(client.10376104.0:961532 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370134
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.448543",
          "age": "0.032431",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376110.0:972570 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370135
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.453829",
          "age": "0.027145",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376104.0:961534 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370136
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.454012",
          "age": "0.026962",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376107.0:952760 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370137
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.458980",
          "age": "0.021994",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376110.0:972572 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370138
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.459546",
          "age": "0.021428",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376110.0:972574 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370139
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.463680",
          "age": "0.017294",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376107.0:952762 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370140
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.464660",
          "age": "0.016314",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376104.0:961536 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370141
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.468076",
          "age": "0.012898",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376110.0:972576 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370142
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.468332",
          "age": "0.012642",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376107.0:952764 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370143
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.470480",
          "age": "0.010494",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376107.0:952766 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370144
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.475372",
          "age": "0.005602",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376104.0:961538 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370145
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.479391",
          "age": "0.001583",
          "flag_point": "started"},
        { "description": "osd_sub_op(client.10376107.0:952768 7.35b
2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370146
snapset=0=[]:[] snapc=0=[])",
          "received_at": "2013-03-06 13:59:18.480276",
          "age": "0.000698",
          "flag_point": "started"}]}

On osd.18

{ "num_ops": 9,
  "ops": [
        { "description": "osd_op(client.10391092.0:718883
2013-03-06-13-8700.1-ocdn [append 0~299] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.929677",
          "age": "0.025480",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10391092",
              "tid": 718883}},
        { "description": "osd_op(client.10373691.0:956595
2013-03-06-13-8700.1-ocdn [append 0~299] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.934533",
          "age": "0.020624",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10373691",
              "tid": 956595}},
        { "description": "osd_op(client.10391092.0:718885
2013-03-06-13-8700.1-ocdn [append 0~299] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.937101",
          "age": "0.018056",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10391092",
              "tid": 718885}},
        { "description": "osd_op(client.10373691.0:956597
2013-03-06-13-8700.1-ocdn [append 0~299] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.940284",
          "age": "0.014873",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10373691",
              "tid": 956597}},
        { "description": "osd_op(client.10373691.0:956598
2013-03-06-13-8700.1-ocdn [append 0~275] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.941170",
          "age": "0.013987",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10373691",
              "tid": 956598}},
        { "description": "osd_op(client.10373691.0:956601
2013-03-06-13-8700.1-ocdn [append 0~299] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.946009",
          "age": "0.009148",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10373691",
              "tid": 956601}},
        { "description": "osd_op(client.10391092.0:718887
2013-03-06-13-8700.1-ocdn [append 0~299] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.950400",
          "age": "0.004757",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10391092",
              "tid": 718887}},
        { "description": "osd_op(client.10373691.0:956603
2013-03-06-13-8700.1-ocdn [append 0~275] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.951217",
          "age": "0.003940",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10373691",
              "tid": 956603}},
        { "description": "osd_op(client.10373691.0:956604
2013-03-06-13-8700.1-ocdn [append 0~299] 7.2b11a75b)",
          "received_at": "2013-03-06 13:57:52.951491",
          "age": "0.003666",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.10373691",
              "tid": 956604}}]}

iostat of this osd drives in same time. osd.61 is master i think.

osd.133
Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sde               0.00     0.00    1.00  816.67     4.00 29925.50
73.21     0.24    0.28    6.67    0.27   0.19  15.33
osd.61
Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdk               0.00    60.33    0.67  685.33     2.67 27458.83
80.06     1.48    2.16   54.00    2.11   1.45  99.47
osd.18
Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdt               0.00     0.00    2.00  809.67     8.00 27608.00
68.05     0.19    0.23   12.00    0.20   0.14  11.33

Sort o files number of files with same date, but only a little probe of all.

     57 21 Nov 2012
     58 11 Dec 2012
     59 02 Jan 2013
     59 17 Feb 2013
     64 16 Feb 2013
     65 27 Nov 2012
     66 14 Dec 2012
     69 01 Mar 2013
     71 07 Feb 2013
     71 20 Dec 2012
     71 30 Nov 2012
     72 22 Nov 2012
     74 23 Nov 2012
     81 13 Dec 2012
     88 01 Dec 2012
     90 21 Feb 2013
    113 16 Nov 2012
    118 10 Feb 2013
    120 13 Feb 2013
    142 15 Feb 2013
    158 19 Feb 2013
    195 29 Nov 2012
    200 14 Feb 2013
    606 18 Feb 2013
    766 20 Feb 2013
   1347 05 Dec 2012
   2439 09 Dec 2012
   2603 08 Dec 2012

Other osd's have very small number of iops.


Best Regards
SS
