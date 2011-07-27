From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: About the rados check command
Date: Wed, 27 Jul 2011 15:16:44 +0800
Message-ID: <CAAdKTP_hMHXHQgEo+aHBXoWvQME+W8iJxZHjpnhRKOoiicSTMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41838 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab1G0HQp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 03:16:45 -0400
Received: by gxk21 with SMTP id 21so833162gxk.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 00:16:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph <ceph-devel@vger.kernel.org>

Dear Ceph,

Thanks for your answer before. That let me learn more.

Recently,I want to check the pools and the contents in the rados gatewa=
y.
So I execute "rados lspools".
Here is the massages on the screen:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[root@mon1 ~]# rados lspools
data
metadata
rbd
=2Ergw
^^^^^^^^^^^^^
=2Eusers.uid
=2Eusers
=2Epool
^^^^^^^^^^^^
=2Elog
test2
test741
test741-2
test741-3
test741-4
test741-5
test1
doki1
123
foo
anny
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

I am curious about the information about .rgw  .pool and .log=A1C
                                                           ^^^^^  ^^^^^=
^
Therefore I execute "rados -p .rgw ls"
Here is the massages:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[root@mon1 ~]# rados -p .rgw ls
=2Elog
=2Epool
=2Eusers
=2Eusers.uid
test1
test2
test741
test741-2
doki1
test741-3
test741-4
test741-5
123
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Question(1): What is that massages that mean? What is the difference
between the massages will be showed when I type "rados lspools"?


When I execute "rados -p .pool ls"
Here is the massages:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[root@mon1 ~]# rados -p .pool ls
10
11
13
14
15
17
18
19
20
21
6
12
9
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Question(2): What is the number mean?

Question(3): Likewisethe same questions above-mentioned=A1AWhat is the
messages mean when I type " rados -p .log ls" ?

Thank you~

Best Regards.
Stefanie.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
