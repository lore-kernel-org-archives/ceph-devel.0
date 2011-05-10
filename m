From: Simon Tian <aixt2006@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Tue, 10 May 2011 21:50:10 +0800
Message-ID: <BANLkTimfL1TafAmGHNx11otRzPQynMjrOQ@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<loom.20110510T134503-22@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53090 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246Ab1EJNuL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 09:50:11 -0400
Received: by wwa36 with SMTP id 36so6894337wwa.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 06:50:10 -0700 (PDT)
In-Reply-To: <loom.20110510T134503-22@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

2011/5/10 Fyodor Ustinov <ufm@ufm.su>:
> Simon Tian <aixt2006 <at> gmail.com> writes:
>
>> [root <at> mon-00 ~]# cclass -a
>> [root <at> mon-00 ~]# ceph class list
>
> Do you forget "ceph class activate rbd 1.3" ?
>

As the log show, the rbd 1.3 is already active:

[root@mon-00 ~]# rbd create foo --size 1024
2011-05-11 05:46:59.074470 42fb0940 -- 10.250.6.98:0/1014581 >>
10.250.6.30:6801/3240 pipe(0x63ee70 sd=5 pgs=0 cs=0 l=0).fault first
fault


Thx!

Simon


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
                            ^^^^^^^
' (0)

After I done "ceph class activate rbd 1.3" , It
