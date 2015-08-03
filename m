From: chen kael <chenji.bupt@gmail.com>
Subject: A issue in straw2 , maybe it`s not a problem
Date: Mon, 3 Aug 2015 17:33:41 +0800
Message-ID: <CAA-rZjaWe-6K7BOjT3RmqVvnoBNjheuX5xphyMY+KTGSR+PELg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34211 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbHCJdm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 05:33:42 -0400
Received: by wibud3 with SMTP id ud3so127979428wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 02:33:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,everyone

    recently,I want to migrate our on-line cluster from straw to
straw2,because if I add or remove some osds,too much objects are to be
replaced than it should be.

    I have a confusing in using straw2, because straw2 should have a
character that if an item's weight was adjusted up or down, mappings
would either
move to or from the adjusted item, but never between other unmodified
items in the bucket.

    However after I do the test below , I still find pgs move from
unmodified items,I am not sure whether this is normal.



code from :commit 1113eb6b98cb8224f8c3e407435923de7415ca3f



Step1:MON=3D1 OSD=3D6 ./vstart.sh -l -n -x

Step2:[root@localhost src]# ./ceph osd pool create newpool 200 200

Step3:[root@localhost src]# ./ceph osd getcrushmap -o crush.out

Step4:[root@localhost src]# ./crushtool -d crush.out -o crush.txt

Step5:[root@localhost src]# vi crush.txt //modify crush map

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# buckets
host localhost {
 id -2  # do not change unnecessarily
 # weight 18.000
 alg straw2
 hash 0 # rjenkins1
 item osd.0 weight 2.000
 item osd.1 weight 2.000
 item osd.2 weight 3.000
 item osd.3 weight 3.000
 item osd.4 weight 4.000
 item osd.5 weight 4.000
}
root default {
 id -1  # do not change unnecessarily
 # weight 18.000
 alg straw
 hash 0 # rjenkins1
 item localhost weight 6.000
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Step6:[root@localhost src]# ./crushtool -c crush.txt -o crush.out

Step7:[root@localhost src]# ./crushtool -i crush.out --test --min-x 1
--max-x 1000 --num-rep 3  --show-statistics --show-mappings >straw.old

Step8:[root@localhost src]# ./crushtool -i crush.out --reweight-item
osd.5 0 -o crush.out.new

Step9:[root@localhost src]# ./crushtool -i crush.out.new --test
--min-x 1 --max-x 1000 --num-rep 3  --show-statistics --show-mappings
>straw.new

Step9:[root@localhost src]# diff -y --suppress-common-lines straw.old
straw.new >straw.diff



In straw.diff we can find pg movements like=EF=BC=9A

        old                                        new

CRUSH rule 0 x 453 [5,2,1]                CRUSH rule 0 x 453 [0,2,4]
CRUSH rule 0 x 628 [3,0,5]                CRUSH rule 0 x 628 [3,0,2]
CRUSH rule 0 x 629 [3,1,0]                CRUSH rule 0 x 629 [3,5,1]
CRUSH rule 0 x 759 [5,2,1]                CRUSH rule 0 x 759 [0,4,3]



Conclusion:

If the osd.5 is the primary osd,or second osd in a pg, then other osd
behind osd.5 are still possible to be switched out,Is this what straw2
really want achieve?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
