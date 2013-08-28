From: christophe courtaut <christophe.courtaut@gmail.com>
Subject: Radosgw-agent data full sync implementation
Date: Wed, 28 Aug 2013 18:21:40 +0200
Message-ID: <CAA8043h7rzRzmNfBex6p9g5t9VGsH4Ln=VNZzxJf3OpquPHZKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:48705 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798Ab3H1QWB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Aug 2013 12:22:01 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so8040057oah.11
        for <ceph-devel@vger.kernel.org>; Wed, 28 Aug 2013 09:22:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <joe.buck@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Joe,

I'm currently looking at the radosgw-agent, and i have seen your
recent job on full sync of data.

What will be the preferred way to list all objects to sync? Using
admin API or standard S3 API?

Moreover, we will need to do an exact copy of the object to preserve
attributes, as mentionned here
http://pad.ceph.com/p/rgw-multi-region-dr .

Will this be part of the admin API? or am i missing something?

Btw i recently posted an article here : http://blog.kri5.fr/?p=21, to
setup two cluster for testing purpose of the radosgw-agent.

Best regards.

-- 
Christophe Courtaut
