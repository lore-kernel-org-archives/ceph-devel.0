From: huang jun <hjwsm1989@gmail.com>
Subject: mds sync wrlock
Date: Mon, 27 Jun 2011 19:53:01 +0800
Message-ID: <BANLkTin9SkuYVnatyXoKCjHiJevCizKwVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61685 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759617Ab1F0LxD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2011 07:53:03 -0400
Received: by wwe5 with SMTP id 5so4686711wwe.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2011 04:53:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
now,we test the directory operation in ceph,and found follow phenomenons:
we mount ceph on /mnt/test/
then create dir "/mnt/test/a/b/"
1) in dir "b" , use "seq 3000|xargs -i mkdir {}" to create 3000 dirs
2) and at some time,make a directory "c" in "a"
then step 2) returns very slow,from the debug log,we got :
step 2) will block  until  step 1)  finished
because  step 2) need a sync wrlock of dir "a", but step 1) got the
wrlock in predirectory_journal_parents function
until it finished works .
so i have few questions:
  a) why step 1)  got the wrlock of dir "a" ? I think it should just
hold the wrlock of dir "b",but not dir "a".
  b) why circularly judge the  variable "stop" value  of all the
parent directory of dir "b" ?

best regards!
