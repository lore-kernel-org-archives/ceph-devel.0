From: Florian Haas <florian@hastexo.com>
Subject: Configuring radosgw to behave like Amazon S3
Date: Mon, 9 Jul 2012 15:00:09 +0200
Message-ID: <CAPUexz8vPRhfeNZEDz3dwqRmgvQdmAL2BY4Ddd=qUshE3S4xXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62087 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab2GINAL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 09:00:11 -0400
Received: by qcro28 with SMTP id o28so6631678qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 06:00:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I find it kind of neat that you can use radosgw to convince S3 clients
that they are in fact talking to the "real" Amazon S3, with just a bit
of config and DNS trickery, but haven't seen this documented anywhere.
So I decided to add a little page to the Hints & Kinks section on our
website, in the hope that it's useful. If anyone wants to share
comments, feedback or corrections, please do so either here on the
list, or on the page directly (scroll down to "add new comment";
leaving comments requires you to log in in an effort to combat comment
spam).

http://www.hastexo.com/resources/hints-and-kinks/configuring-radosgw-behave-amazon-s3

As a side note, I'm not 100% sure if the information listed in
http://ceph.com/docs/master/radosgw/s3/ with respect to S3 API
compatibility is entirely accurate. Specifically, it seems that the
"Bucket Website" feature *is* supported by way of "rgw dns name"
(unless I'm missing something, and Bucket Website refers to something
different). Thoughts on that would also be appreciated.

Cheers,
Florian
