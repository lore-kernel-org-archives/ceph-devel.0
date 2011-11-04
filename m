From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: radosgw-admin temp remove
Date: Fri, 4 Nov 2011 16:47:11 +0800
Message-ID: <CANExM-NKpof7kQ1sMCkcnwdAQ-F6e3QH5g5i3VKnCGyKrj4gaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64525 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab1KDIrM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 04:47:12 -0400
Received: by ggnb2 with SMTP id b2so2268875ggn.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 01:47:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I used to schedule a cron job to do "radosgw-admin --date `date
+%Y-%m-%d` temp remove".
It works fine in v0.36, but got an error in v0.37. See the error message below:

root@ceph1:~# radosgw-admin --date 2011-11-04 temp remove -d
2011-11-04 16:34:27.373509 7f277c6ab760 cls_bucket_list .intent-log
start  num 1000
2011-11-04 16:34:27.373538 7f277c6ab760 ERROR: empty marker for
cls_rgw bucket operation
failed to list objects

I wonder if it is a bug or the command changed?

-Henry


Below is the objects in the ".intent-log":

root@ceph1:~# rados -p .intent-log ls
2011-11-03-26-henry-9z91szuh1enh3vmfrszjzof-1
2011-11-03-31-henry-7s5j9qyqeip1jadgeev35rc-1
2011-11-03-17-henry-tl6flzkv89e2zbjk3fg1doy-1
2011-11-03-45-henry-k7w66ahljw4rx4v61ko7xwv-1
2011-11-03-16-henry-g2gfq861g8lvghjq2ne8u5p-1
2011-11-03-46-henry-j8va7tlbt6nbytqve3kh3ki-1
2011-11-03-48-henry-m39ci8a3r33barh03f59etk-1
2011-11-03-71-henry-pymwu6e1poqzkz8j81qhs4q-1
2011-11-03-76-henry-pqms7iyel6zwbftbujthl16-1
2011-11-03-15-henry-zyuj92audhgsqv4w88tyaoz-1
2011-11-03-77-henry-6j7sx0frpz35hjsmjfey4fw-1
2011-11-03-10-henry-amrio0dfn27afir43unpatx-1
2011-11-03-37-henry-6t3tuywfmx6j9uc66hmgl8c-1
2011-11-03-7-henry-kndbt9jd8hw66ykc9rqqg9c-1
2011-11-03-80-henry-mru4pgbax0jtq4w36bsk162-1
2011-11-03-59-henry-c1itzkk7ufp5ppv39sg5oaq-1
2011-11-03-42-henry-6onaw8zge49msj84dkzdvw6-1
2011-11-03-20-henry-g0fywpb39eu2pxn14rly48r-1
2011-11-03-82-henry-97az4zl3kfali36sydkmiz8-1
2011-11-03-43-henry-4safkzrekaul239kkmzwp3p-1
2011-11-03-6-henry-l9d5s66n71v8fd2y7hclnn5-1
2011-11-03-44-henry-1jp4rofc7o53x270d9c9slr-1
2011-11-03-32-henry-buqznoyo7j4v098pauxyz33-1
2011-11-03-29-henry-atsgjrkumqzf5k2ewqid64e-1
2011-11-03-64-henry-wofqgscr3c338ag4zu0k60d-1
2011-11-03-18-henry-nrmry6koketysgaguai05e9-1
2011-11-03-83-henry-yfb7ouy9lfqbz9dz3fcqmm0-1
2011-11-04-100-henry-5zukmr1dy8gdrei1zti8dk5-1
2011-11-03-2-henry1
2011-11-04-102-henry-5z2vmr6attsintduomzc5r8-1
2011-11-03-5-henry-34yumzmilge99pvigee15pp-1
2011-11-03-28-henry-65zccl6pecu6omoxs7s8b5a-1
2011-11-04-106-henry-von0mspwmuusjunscb9dzl7-1
2011-11-03-11-henry-20fgrrgghn49worb0db5uuy-1
2011-11-03-41-henry-hxjvl1hzomta3oz26mxl9yx-1
2011-11-03-75-henry-9nsy0uo9f6ilqdosx5mzm9i-1
2011-11-04-85-henry-t73b1a3wi4j79y6sdunc6pz-1
2011-11-04-89-henry-t9qvhao2x8a78ou2jvwx5z8-1
2011-11-03-34-henry-ecv8inzxgm5t0ayviaoeyre-1
2011-11-03-33-henry-5vqxblrga0o5r7b2rdgskdh-1
2011-11-03-38-henry-uwpykjcm5in2ylrp0s4o0vp-1
2011-11-04-94-henry-uaoz2wkhd51wy3m7bj6dj2w-1
2011-11-04-91-henry-dydhzj19qrq5bwtny36khn9-1
2011-11-03-67-henry-a4thzk60aysgaus25jbj9ez-1
2011-11-03-12-henry-lh3ocyltlh8zdnzflp3vmpo-1
2011-11-03-81-henry-5acyopvmrrx7g8q4xc7ejtt-1
2011-11-04-95-henry-9g3yod4ik4149lik81xvr7t-1
2011-11-04-98-henry-00c86v4wgjq15kvbo6bfmif-1
2011-11-03-30-henry-zksm6yvzdrjx36trlqiq8nn-1
2011-11-04-99-henry-pl3u5n0bz6627fzf2h3u5o2-1
2011-11-03-53-henry-d27tgt8gnh1fx4m7u6x9dfm-1
