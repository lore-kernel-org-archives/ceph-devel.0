From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: radosgw: Files left over after deletion (even after the gc period/process)
Date: Thu, 30 May 2013 12:21:23 +0200
Message-ID: <CAF6-1L6pC8UqoFrqMzpZXKrZctwKELw_iKpHDtwvq6ZvRsx_FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:64609 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968150Ab3E3KVZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 06:21:25 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik5so40729bkc.23
        for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 03:21:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

The basic operation I did was :

 - Upload a file using multi-part upload
 - Copy that file to a new key
 - Delete that original file (which only creates a new head)
 - Delete the copy

And it seems all the multipart & shadow files are not properly deleted.

Cheers,

    Sylvain
