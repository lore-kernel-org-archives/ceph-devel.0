From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: more human readable log to track request or using mapreduce for data statistics
Date: Thu, 26 Mar 2015 16:05:40 +0800
Message-ID: <CANE=7sXgs9qd_3o7zT6RempoVmc2SfgG8qDZeVKO-77oPvkTzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33175 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbCZIFk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Mar 2015 04:05:40 -0400
Received: by obcxo2 with SMTP id xo2so39658646obc.0
        for <ceph-devel@vger.kernel.org>; Thu, 26 Mar 2015 01:05:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

hi=EF=BC=8Cceph:

Currently, the command =E2=80=9Dceph --admin-daemon
/var/run/ceph/ceph-osd.0.asok dump_historic_ops=E2=80=9C may return as =
below:

{ "description": "osd_op(client.4436.1:11617
rb.0.1153.6b8b4567.000000000192 [] 2.8eb4757c ondisk+write e92)",
          "received_at": "2015-03-25 19:41:47.146145",
          "age": "2.186521",
          "duration": "1.237882",
          "type_data": [
                "commit sent; apply or cleanup",
                { "client": "client.4436",
                  "tid": 11617},
                [
                    { "time": "2015-03-25 19:41:47.150803",
                      "event": "event1"},
                    { "time": "2015-03-25 19:41:47.150873",
                      "event": "event2"},
                    { "time": "2015-03-25 19:41:47.150895",
                      "event": "event3"},
                    { "time": "2015-03-25 19:41:48.384027",
                      "event": "event4"}]]}

I think this message is not so suitable for grep log or using
mapreduce for data statistics. Such as, I want to know
the write request avg latency for each rbd everyday. If we could
output the all latency in just one line, it would be very easy to
achieve it.

Such as, the output log maybe something like this:
2015-03-26 03:30:53.859759 osd=3Dosd.0 pg=3D2.11 op=3D(client.4436.1:11=
617
rb.0.1153.6b8b4567.000000000192 [] 2.8eb4757c ondisk+write e92)
received_at=3D1427355253 age=3D2.186521 duration=3D1.237882 tid=3D11617
client=3Dclient.4436 event1=3D20ms event2=3D300ms event3=3D400ms event4=
=3D100ms.

The above:

duration means: the time between (reply_to_client_stamp -
request_received_stamp)
event1 means: the time between (the event1_stamp - request_received_sta=
mp)
=2E..
event4 means: the time between (the event4_stamp - request_received_sta=
mp)

Now, If we output the every log as above. it would be every easy to
know the write request avg latency for each rbd everyday.
Or if I use grep it is more easy to find out which stage is the bottlen=
eck.

--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
