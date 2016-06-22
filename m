From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: udev events on a disk, at boot time
Date: Wed, 22 Jun 2016 17:07:52 +0200
Message-ID: <CAPed3OGUMDjsDTZsb-eNBmoZ9Qjffdb8uXeYG=07Y4D9kbb8mA@mail.gmail.com>
References: <57695098.50403@dachary.org> <CAPed3OFeAJvLy+7G8YdwJ1pdi=p+tRatpPPQ=DmsvGjr-5QouA@mail.gmail.com>
 <57696DC1.3090803@dachary.org> <CAPed3OFyST0oJs0SQaxKXLRSu71YYPUTu+ZpKBmaEX2QaWri8g@mail.gmail.com>
 <576A8299.2000404@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:32940 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbcFVPIM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 11:08:12 -0400
Received: by mail-oi0-f54.google.com with SMTP id u201so26373329oie.0
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 08:08:12 -0700 (PDT)
In-Reply-To: <576A8299.2000404@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 22, 2016 at 2:20 PM, Loic Dachary <loic@dachary.org> wrote:
>> One thing that might be different between our setups is that my root
>> fs is on LVM. I'll reinstall a server just to see if that matters.
>>
>> Another workaround for this that works for me is running 'udevadm
>> trigger -c add -s block' after boot, this mounts the ceph volumes
>> successfully.
>
> Thanks for the additional information. It confirms that for some reason I have ADD events in my test setup and you don't. Still digging.

I now reinstalled a few servers with the root fs on a plain partition,
to take LVM out of the equation, and the OSDs come up fine.
