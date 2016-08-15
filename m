From: Ridge Chen <ridge.chen@gmail.com>
Subject: Sequential write performance on cloning images
Date: Mon, 15 Aug 2016 10:41:55 +0800
Message-ID: <CAOb-7EzSpjYp9dZB4j2UoTgB6H0WZM5SeC2rJ=EYMc9R9a6x3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38292 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbcHOCl5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Aug 2016 22:41:57 -0400
Received: by mail-it0-f43.google.com with SMTP id i128so5093712itf.1
        for <ceph-devel@vger.kernel.org>; Sun, 14 Aug 2016 19:41:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Experts,

I was trying to test the performance on rbd images. I find the
sequential write throughput on cloning image is only harf of that on
origin one. I have enabled object-map feature on both images and the
cloning image is fully over-written before the performance test.

Here is my steps:
1. create two images called "ori-vol1", "ori-vol2"
2. run a "dd" on them to make the images full of data
3. create a snap on "ori-vol1", called "snap-vol1"
4. clone a image from "snap-vol1", called "clone-vol1"
5. run a "dd" on "clone-vol1" to make the image full "copy-up"
6. finally test performance on "ori-vol2" and "clone-vol1". --
sequential write, 64K iosize, fio

I have tested on hammer and jewel, the results are similar. Is it expected?

I know there may be performance drop on cloning image since the issued
object may be at parent image and it required a extra "copy-up"
operation. However in my case the objects are all at own image and
librbd should have knowledge about this from object-map.

Regards
Ridge
