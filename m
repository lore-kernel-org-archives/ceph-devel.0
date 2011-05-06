From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: Change the weight of osd
Date: Fri, 6 May 2011 14:39:32 +0800
Message-ID: <BANLkTimvC_s9PSdojK9A+kQXy7NkyjsPWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:59247 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1EFGjd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 02:39:33 -0400
Received: by pxi16 with SMTP id 16so2101333pxi.4
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2011 23:39:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph <ceph-devel@vger.kernel.org>

Dear Ceph,
I am trying changing the weight of OSDs.
My testing environment is one MON , one MDS and two OSDs(named OSD9 and=
 OSD10).
There are 4 disk foe each server host.
In each OSD host, I running one cosd process per disk.
Therefore, there are 4 cosd processes in OSD9 and OSD10 separetly.
I named the cosd processes as osd24 osd25 and osd26 in OSD9.
I also named the cosd processes as osd27 osd28 and osd29 in OSD10.

My testing steps as shown below, if there is any wrong please correct
me as far as possible. Thank you.

1) I want to compare the size of the folder whose weight is changed
before and after.
   So I record the size of the folder before the weight of osd is chang=
ed .
   I excute"du  /mnt/ext4/osd24/current/"
                            ...
                            ...
               "du  /mnt/ext4/osd29/current/"
 2) I edit the /tmp/crushmap.txt. Here is the txt.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
domain dom8 {
        id -9           # do not change unnecessarily
        alg uniform     # do not change bucket size (3) unnecessarily
        hash 0  # rjenkins1
        item device24 weight 1.000 pos 0
        item device25 weight 1.000 pos 1
        item device26 weight 1.000 pos 2
}
domain dom9 {
        id -10          # do not change unnecessarily
        alg uniform     # do not change bucket size (3) unnecessarily
        hash 0  # rjenkins1
        item device27 weight 1.000 pos 0
        item device28 weight 1.000 pos 1
        item device29 weight 3.000 pos 2
                                      ^^^^^^^^
                                         I replace 1.000 with 3.000 .
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
3) I execute "crushtool -c /tmp/crushmap.txt -o /tmp/crushmap_new=A1=A8=
and=A1=A8
ceph osd setcrushmap -i /tmp/crushmap_new=A1=A8
4) I thought the crushmap has already changed.
    If I write data, the data will more prbable placed in osd29 . right=
?
    When I excute" time dd if=3D/dev/zero
of=3D/mnt/ceph/reweight_64k_64M_1.dbf bs=3D64k count=3D1024 oflag=3Ddsy=
nc"
    I check the folder size by excuting "/mnt/ext4/osd24/current/"....
"/mnt/ext4/osd29/current/".
    I found that the folder size is not growed in accordance with the
wight I edit (osd24 osd25 osd26 osd27 osd28 weight=3D>1.000, osd29
weight=3D>3.000).
    Here is the increasing folder size.
In OSD9
=83=DC	osd24  4124 kB
=83=DC	osd25  28748 kB
=83=DC	osd26  34064 kB
In OSD10
=83=DC	osd27  4124 kB
=83=DC	osd28  28748 kB
=83=DC	osd29  34060 kB
                 ^^^^^^^^^^^^^^^^^^
                Why  the folder size is not growed in accordance with
the wight I edit ?


If I want to change the weight of osd . Are the steps I mentioned above=
 correct?
Do you have any good idea or advice to our test? I really want to know
how to change the weight of osd and how to verify it.
Thank you very much...^^

Stefanie Chen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
