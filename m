From: Simon Tian <aixt2006@gmail.com>
Subject: rbd create error with 0.26
Date: Tue, 10 May 2011 10:30:48 +0800
Message-ID: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34098 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab1EJCat (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 22:30:49 -0400
Received: by wya21 with SMTP id 21so4332219wya.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2011 19:30:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

I met an error when creating a rbd image:

====================================================
[root@mon-00 ~]# ceph class list
2011-05-10 17:36:29.530759 mon <- [class,list]
2011-05-10 17:36:29.531491 mon0 -> 'no installed classes!' (0)
[root@mon-00 ~]# cclass -a
Loading class: /usr/local/lib/rados-classes/libcls_rbd.so.1.0.0: rbd 1.3 x86-64
2011-05-10 17:36:37.657254 7eff9cfc36f0 read 184650 bytes from
/usr/local/lib/rados-classes/libcls_rbd.so.1.0.0
2011-05-10 17:36:37.658820 mon <- [class,add,rbd,1.3,x86-64,changed]
2011-05-10 17:36:37.749791 mon0 -> 'updated' (0)
[root@mon-00 ~]# ceph class list
2011-05-10 17:36:45.176860 mon <- [class,list]
2011-05-10 17:36:45.177511 mon1 -> 'installed classes:
rbd (v1.3 [x86-64]) [active]
' (0)
[root@mon-00 ~]# rbd list
pool rbd doesn't contain rbd images
[root@mon-00 ~]# rbd list
pool rbd doesn't contain rbd images
[root@mon-00 ~]# rbd create foo --size 1024
2011-05-10 17:42:14.854907 7fcff83cb6f0 librbd: failed to assign a
block name for image
create error: Input/output error
[root@mon-00 ~]# ceph class activate rbd 1.3
2011-05-10 17:42:34.824676 mon <- [class,activate,rbd,1.3]
2011-05-10 17:42:34.944398 mon2 -> 'updated' (0)
[root@mon-00 ~]# rbd create foo --size 1024
2011-05-10 17:42:44.227398 7fa9411866f0 librbd: failed to assign a
block name for image
create error: Input/output error
====================================================
I just done as this tracker said:  http://tracker.newdream.net/issues/263

I found that the return value of io_ctx.exec function is bellow zero:

  r = io_ctx.exec(info_oid, "rbd", "assign_bid", bl, out);
  if (r < 0)
    return r;

Thx!
