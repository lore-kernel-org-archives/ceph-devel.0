From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Ceph performance
Date: Mon, 29 Oct 2012 18:01:00 +0400
Message-ID: <508E8C1C.4020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58649 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057Ab2J2OBE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 10:01:04 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3064957lbo.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 07:01:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Kindly guide me how to improve performance on the cluster which consist=
=20
of 5 dedicated servers:

- ceph.conf: http://pastebin.com/hT3qEhUF
- file system on all drives is ext4
- mount options "user_xattr"
- each server has :
CPU:Intel=AE Xeon=AE Processor E5335(8M Cache, 2.00 GHz, 1333 MHz FSB) =
x2
MEM: 4Gb DDR2
- 1Gb network

Simple test:

mounted as ceph
root@client1:/mnt/mycephfs# time find . | wc -l
83932

real    17m55.399s
user    0m0.152s
sys    0m1.528s

on 1 HDD:

root@client1:/home# time find . | wc -l
83932

real    0m55.399s
user    0m0.152s
sys    0m1.528s

Please help me to find out the issue. Thanks.

--=20
Kind regards,

R. Alekseev

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
