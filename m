From: yue longguang <yuelongguang@gmail.com>
Subject: Fwd: question about client's cluster aware
Date: Thu, 25 Sep 2014 09:02:54 +0800
Message-ID: <CAPaK2r9DQ2b-3V=RUQg4UD7zaSHdtMcWp5qQPwNuOmY12UK66w@mail.gmail.com>
References: <CAPaK2r-ToTheCfmjfi1K-Ss=yOoo1MD8pHJ+Ghs0n549+sAEiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:40762 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbaIYBCy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Sep 2014 21:02:54 -0400
Received: by mail-ig0-f177.google.com with SMTP id h3so7540919igd.10
        for <ceph-devel@vger.kernel.org>; Wed, 24 Sep 2014 18:02:54 -0700 (PDT)
In-Reply-To: <CAPaK2r-ToTheCfmjfi1K-Ss=yOoo1MD8pHJ+Ghs0n549+sAEiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sweil@redhat.com, ceph-devel@vger.kernel.org

---------- Forwarded message ----------
=46rom: yue longguang <yuelongguang@gmail.com>
Date: Tue, Sep 23, 2014 at 5:53 PM
Subject: question about client's cluster aware
To: ceph-devel@vger.kernel.org


hi,all

my question is from my test.
let's take a example.   object1(4MB)--> pg 0.1 --> osd 1,2,3,p1

when client is writing object1, during the write , osd1 is down. let
suppose 2MB is writed.
1.
   when the connection to osd1 is down, what does client do?  ask
monitor for new osdmap? or only the pg map?

2.
  now client gets a newer map , continues the write , the primary osd
should be osd2.  the rest 2MB is writed out.
 now what does ceph do to integrate the two part data? and to promise
that replicas is enough?

3.
 where is the code.  Be sure to tell me where the code is=E3=80=82

it is a very difficult question.

Thanks so much
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
