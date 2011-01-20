From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: ceph hang.this is my environment
Date: Thu, 20 Jan 2011 10:45:45 -0800
Message-ID: <AANLkTimebDN07EyEs9HN7kTsV77jXgUAD_i=F7EcL64o@mail.gmail.com>
References: <1295455606.6777.23.camel@sale659.sandia.gov>
	<AANLkTi=LNa0AyiT4UfyrJLQrUCrPDACBocsiQV=yw7GQ@mail.gmail.com>
	<1295457888.6777.33.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1101190929290.6864@cobra.newdream.net>
	<D0C67741759ABD4BBD8D3A5CB815606E07E489@mail.cloud-valley.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44656 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab1ATSqB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jan 2011 13:46:01 -0500
Received: by wwa36 with SMTP id 36so970626wwa.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jan 2011 10:46:00 -0800 (PST)
In-Reply-To: <D0C67741759ABD4BBD8D3A5CB815606E07E489@mail.cloud-valley.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Longguang Yue <longguang_yue@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Based on what you've told us it looks like maybe you're running into a
btrfs bug of some kind.

We're working on getting the most recent version of btrfs onto some
nodes here to check it out as we've been hearing about sync issues
with btrfs for a few days now, but we haven't managed it yet.

2011/1/19 Longguang Yue <longguang_yue@tcloudcomputing.com>:
> 5 nodes,{mds0,mon0,osd0,osd1,client}
> Because I update ceph-0.23 to 0.24.  client and osd? Also hang.  So I=
 mkfs.btrfs ,mkcephfs again.  Client and osd1 hang again!!!!!!!!!
>
> 1. mkcephfs -a -c /etc/ceph/ceph.conf ; at highest debug level
> 2. client#   mount mon0:/ /mnt/ceph
> 3.client#   ls /mnt/ceph  ;   cp files /mnt/ceph  ; go to other node =
,ls /data/osd? Ok.
> 4.client#   ls /mnt/ceph =A1=BEok=A1=BF.    Now I cp newfile /mnt/cep=
h ; sync ...........................hang,   ls /mnt/ceph  .............=
=2E......   hang!!!!!!!
> 5.osd1#    ls /data/osd1 .................hang
> -------------osd1 dmesg-------------------------------------
> Device : 'btrfs-4' device_add
> PM:adding info for no bus : btrfs-4
> Bad ordered accounting left 4096 size 262144
> ----------------client dmesg,ceph -s ,umount  ---- attached ---------=
---------
>
> II  how to locate this problem?  What should I do?
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
