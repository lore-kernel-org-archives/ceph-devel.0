From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 23:57:31 +0800
Message-ID: <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com>
References: <516E7D5C.7080309@nazarianin.com>
	<alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:51396 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab3DQP5b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 11:57:31 -0400
Received: by mail-ve0-f175.google.com with SMTP id m1so1554826ves.6
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 08:57:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

I looked into this problem earlier. The problem is that zfs does not
return ERANGE when the size of value buffer passed to getxattr is too
small. zfs returns with truncated xattr value.

Regards,
Henry

2013/4/17 Sage Weil <sage@inktank.com>:
> Hey,
>
> Can you test with the wip-debug-xattr branch?  Set debug filestore = 30
> and it will dump the xattr values to the log on set and get, so we can see
> what is going on.
>
> Also/alternatively, strace with -f -v -x, which will (I think) include the
> full value of the get/setxattr args..
>
> Thanks!
> sage
>
>
> On Wed, 17 Apr 2013, Aleksey Leonov wrote:
>
>>      Hi all,
>>
>>      I create test VM for try run ceph osd on zfs.
>>      mkcephfs run ok. Osd down 2 minutes after start.
>>
>> ceph.conf
>> [global]
>>          max open files = 131072
>>          log file = /var/log/ceph/$name.log
>>          pid file = /var/run/ceph/$name.pid
>> [mon]
>>          mon data = /ceph/mon/$name
>> [mon.alpha]
>>          host = ct1
>>          mon addr = 10.10.10.2:6789
>> [mds]
>> [mds.alpha]
>>          host = ct1
>> [osd]
>>          debug filestore = 20
>>          filestore xattr use omap = true
>>          osd data = /ceph/osd/$name
>>          osd journal = /ceph/osd/$name/journal
>>          osd journal size = 2000 ; journal size, in megabytes
>>          journal dio = false
>>          journal aio = false
>>
>> [osd.0]
>>          host = ct1
>>
>>
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
