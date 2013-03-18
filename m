From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: [radosgw] Race condition corrupting data on COPY ?
Date: Mon, 18 Mar 2013 10:50:17 +0100
Message-ID: <CAF6-1L6+un7+z0MmCH=vKzkXUOevhFDAneYqC3Krxm3nb0LP1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:62095 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3CRJuS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 05:50:18 -0400
Received: by mail-qa0-f46.google.com with SMTP id o13so1545612qaj.5
        for <ceph-devel@vger.kernel.org>; Mon, 18 Mar 2013 02:50:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


I've just noticed something rather worrying on our cluster.

Some files are apparently truncated. From the first look I had at it,
it happened on files where there was a metadata update right after the
file was stored. The exact sequence was:

 - PUT to store the file
 - GET to get the file (which at that point is still correct and has
the proper length)
 - PUT using a 'copy source' over itself to update the metadata

all of theses happening sequentially in the same second, very quickly.

Then subsequent GET return a truncated file.


I'm looking into it to narrow down the issue but I wanted to know if
anyone had seen something similar ?


Cheers,

     Sylvain
