From: Huamin Chen <hchen@redhat.com>
Subject: rbd lock list command failure
Date: Wed, 9 Sep 2015 12:26:47 -0400 (EDT)
Message-ID: <1133197671.21438012.1441816007901.JavaMail.zimbra@redhat.com>
References: <638484117.21434546.1441815449448.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:43287 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbbIIQ0s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Sep 2015 12:26:48 -0400
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t89GQmCZ000841
	for <ceph-devel@vger.kernel.org>; Wed, 9 Sep 2015 12:26:48 -0400
In-Reply-To: <638484117.21434546.1441815449448.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

Running "rbd lock list" inside a Docker container yields mixed results. Sometimes I can get the right results but most times I just get errors.

A good run is like this:
[root@host server]# docker run --privileged --net=host -v /dev:/dev -v /sys:/sys ceph/base rbd lock list foo --pool kube --id kube -m host:6789 --key=AQAMgXhVwBCeDhAA9nlPaFyfUSatGD4drFWDvQ==
2015-09-09 16:11:16.812858 7f3337ff5840 -1 did not load config file, using default settings.
There is 1 exclusive lock on this image.
Locker      ID                                                     Address                
client.4333 kubelet_lock_magic_host 10.16.154.78:0/1000001 

Same commands but with error:
[root@host server]# docker run --privileged --net=host -v /dev:/dev -v /sys:/sys ceph/base rbd lock list foo --pool kube --id kube -m host:6789 --key=AQAMgXhVwBCeDhAA9nlPaFyfUSatGD4drFWDvQ==
2015-09-09 16:11:30.430345 7f4159766840 -1 did not load config file, using default settings.
2015-09-09 16:11:30.464193 7f4159766840 -1 librbd::ImageCtx: error finding header: (108) Cannot send after transport endpoint shutdown
rbd: error opening image foo: (108) Cannot send after transport endpoint shutdown

rbd version:
[root@host server]# docker run -ti ceph/base ceph -v
ceph version 0.94.2 (5fb85614ca8f354284c713a2f9c610860720bbf3)

ceph server version:
# ceph -v
ceph version 0.80.9 (b5a67f0e1d15385bc0d60a6da6e7fc810bde6047)
