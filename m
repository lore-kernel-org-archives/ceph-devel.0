From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: Re: Ceph-deploy (git from today) fails to create osd on host that
 does not have a mon
Date: Thu, 5 Sep 2013 09:08:42 -0400
Message-ID: <CANtztVx8s1irFBbv383BL+WOVWzwc1vn1pTomwsYcGNC2GxFrA@mail.gmail.com>
References: <52281D10.9090507@catalyst.net.nz>
	<52282462.9030305@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:53219 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3IENIn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Sep 2013 09:08:43 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so1933371obb.1
        for <ceph-devel@vger.kernel.org>; Thu, 05 Sep 2013 06:08:43 -0700 (PDT)
In-Reply-To: <52282462.9030305@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 5, 2013 at 2:27 AM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> On 05/09/13 17:56, Mark Kirkwood wrote:
>>
>>
>>
>> [ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks
>> ceph2:/dev/vdb:/dev/vdc
>> [ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
>> [ceph_deploy.osd][DEBUG ] Deploying osd to ceph2
>> [ceph2][INFO  ] write cluster configuration to /etc/ceph/{cluster}.conf
>> [ceph2][INFO  ] keyring file does not exist, creating one at:
>> /var/lib/ceph/bootstrap-osd/ceph.keyring
>> [ceph2][INFO  ] create mon keyring file
>> [ceph2][ERROR ] Traceback (most recent call last):
>> [ceph2][ERROR ]   File
>> "/home/markir/develop/python/ceph-deploy/ceph_deploy/util/decorators.py",
>> line 10, in inner
>> [ceph2][ERROR ]   File
>> "/home/markir/develop/python/ceph-deploy/ceph_deploy/osd.py", line 14, in
>> write_keyring
>> [ceph2][ERROR ] NameError: global name 'key' is not defined
>>
>
> The attached patch seems to fix it.


Woah, good catch Mark. The osd module recently had some changes to
improve the logging in the remote host and it seems that
that variable was left out.

I opened http://tracker.ceph.com/issues/6237 and this should be fixed
(with your patch) today.
>
> Cheers
>
> Mark
