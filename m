From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: mon config storage (config-key vs config)
Date: Wed, 10 Jan 2018 16:15:35 -0800 (PST)
Message-ID: <alpine.LSU.2.21.1801101615130.27069@smaug>
References: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal> <3f6e4a31-a0e5-d0c6-7b28-ee501081139c@corp.ovh.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1865287107-1515629739=:27069"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59957 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753169AbeAKAPD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 Jan 2018 19:15:03 -0500
In-Reply-To: <3f6e4a31-a0e5-d0c6-7b28-ee501081139c@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1865287107-1515629739=:27069
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 8 Jan 2018, Piotr Dałek wrote:

> * WARNING: "osd objectstore" is deprecated, you should change your config to 
> use "osd/objectstore" instead.

If there is a 1:1 correspondence between names, I like this idea.

-Jesse
--0-1865287107-1515629739=:27069--
