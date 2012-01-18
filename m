From: Andrey Stepachev <octo47@gmail.com>
Subject: How to remove lost objects.
Date: Wed, 18 Jan 2012 19:37:17 +0400
Message-ID: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:45325 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab2ARPhj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 10:37:39 -0500
Received: by wgbgn7 with SMTP id gn7so3723140wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 07:37:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I've test ceph against laggy network. (0ms-400ms delays).
At some moment i got many messages like:
2012-01-18 16:06:49.184776 7ff134119700 -- 84.201.161.73:6801/25424
send_message dropped message osd_op_reply(291 1000000101b.0000001e
[write 66734080~37
4784] ondisk = 0) v1 because of no pipe on con 0x315e640
And ceph don't respond on ls on some of subdirs (via hadoop fs -ls or
kernel client)
My cluster runs with no debug at that moment, so I can't find what is going on.

After restart ceph writes to log
2012-01-18 16:10:39.985509 7f217989d780 osd.1 155 pg[0.155( v 136'373
(94'368,136'373]+backlog n=3 ec=1 les/c 150/145 146/151/58) [] r=0
lpr=0 (info mismatch, log(94'368,0'0]+backlog) (log bound mismatch,
actual=[8'124,94'369]) lcod 0'0 mlcod 0'0 inactive] read_log  got dup
94'369 (last was 94'369, dropping that one)

After such strange hangouts i found, that rm -rf on filesystem
(mounted via kernel),
fs shows, that 210Gb still in use. Looking at /data/osd.x i found many
objects inside.
So:
a) looks like some errors lead us to orphaned objects in rados
b) i can't find utility, which can check that orpaned data (and cleanup it)

Question: how I can identify what objects are, and how I can clean up them.

-- 
Andrey.
