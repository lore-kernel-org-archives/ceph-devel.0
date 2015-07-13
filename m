From: =?utf-8?B?546LIOWBpQ==?= <jason.jianwang@gmail.com>
Subject: rads gateway Parallel Uploads
Date: Mon, 13 Jul 2015 02:07:22 -0400
Message-ID: <0142046B-030E-4E7D-96FB-C7C519E4B0FC@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34733 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbGMGHa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 02:07:30 -0400
Received: by pdbep18 with SMTP id ep18so219494663pdb.1
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jul 2015 23:07:30 -0700 (PDT)
Received: from [10.49.129.61] (c-98-210-180-117.hsd1.ca.comcast.net. [98.210.180.117])
        by smtp.gmail.com with ESMTPSA id c6sm17517841pas.39.2015.07.12.23.07.29
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 23:07:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Cepher,
I am working on prorting Google Cloud Storage API to rados gateway and =
I notice that Google Cloud Storage support parallel uploads as below:
"Object composition enables a simple mechanism for uploading an object =
in parallel: simply divide your data into as many chunks as required to=
 fully utilize your available bandwidth, upload each chunk to a distinc=
t object, compose your final object, and delete any temporary objects. =
=E2=80=9C
So I am wondering whether radios gateway support the similar feature to=
 let user parallel upload large objects?
Thanks
Jian

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
