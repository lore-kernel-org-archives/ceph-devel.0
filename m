From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RGW: Multi part upload - Attributes not copied from the upload object
 to the final meta object
Date: Wed, 4 Jun 2014 17:10:08 +0200
Message-ID: <CAF6-1L4rcN+P21sN2-ofrXdjqsLLbT4VYEMWzuu-1-evWBs9Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:61010 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaFDPKJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jun 2014 11:10:09 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so6126653pdj.26
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jun 2014 08:10:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,


When playing around with firefly, I noticed that the content-type I'm
setting when doing multi-part upload is not taken into account.

And looking at the rados object, I can see the xattr present on the
.meta file (upload obj), but when doing a complete, that object is
removed and the attributes are not copied over to the final object
AFAICT.


Cheers,

    Sylvain
