From: Wido den Hollander <wido@42on.com>
Subject: Re: rbd image association
Date: Mon, 03 Jun 2013 09:34:47 +0200
Message-ID: <51AC4717.7010304@42on.com>
References: <51AC3D1E.2000800@gmail.com> <20130603070836.GA2422@nix.wogri.at> <51AC42FC.1040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:60736 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab3FCHet (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 03:34:49 -0400
In-Reply-To: <51AC42FC.1040703@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

On 06/03/2013 09:17 AM, Roman Alekseev wrote:
> On 03.06.2013 11:08, Wolfgang Hennerbichler wrote:
>> On Mon, Jun 03, 2013 at 10:52:14AM +0400, Roman Alekseev wrote:
>>> Hi,
>>>
>>> Is it possible to associate certain rbd device with the appropriate
>>> rbd image (for example : image1 > /dev/rbd0)?
>>> We always need to map image1 to /dev/rbd0, image2 to /dev/rbd1 etc.
>>> Because I'm using /dev/rbd* in some configuration files.
>> Hi,
>>
>> I can't remember exactly, but I think there is something like
>> /dev/rbd/<pool>/<imagename> which simply symlinks to /dev/rbdX. This
>> should solve your issue.
>>> Thanks
>> HTH
>> Wolfgang
>>
> Dear Wolfgang,
>
> I was trying to use the command ln -s /dev/rbd1 image1 but it creates
> wrong symlink. Most likely there is more specific command to symlink the
> image and device correctly.
>

Why are you symlinking? Like Wolfgang mentioned, udev takes care of this 
for you.

Just use /dev/rbd/pool/imagename which is created by udev.

> Thanks.
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
