From: hemant surale <hemant.surale@gmail.com>
Subject: Re: Ceph setup on single node : prob with "
Date: Fri, 17 Aug 2012 11:13:41 +0530
Message-ID: <CAGfy=6nACVM3ZB7WEKm6ndHGii9z1yv-HL31yLG9DTTgHth+7w@mail.gmail.com>
References: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com>
	<CADvuQRFzjzKO4OC20jvKZMKUx29o5sKmjxVFAm2vqAc2eufiMw@mail.gmail.com>
	<CAGfy=6nJR+jRmM8sVaWOOjwm+DXfjTQ762K9JhLpxyRYt0eghQ@mail.gmail.com>
	<CADvuQREJp_v=ywHPPe-WVZfgmhua-pYwUz+duedo54XXt9usAQ@mail.gmail.com>
	<502D6D9E.2020802@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42529 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab2HQFnn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 01:43:43 -0400
Received: by obbuo13 with SMTP id uo13so4785147obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 22:43:42 -0700 (PDT)
In-Reply-To: <502D6D9E.2020802@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

Thank you Sir for your great help . Finally ceph is up and working.
Now I will move to run it on cluster of 3 nodes(VMs)
and I need to start instrumenting the code .


Regards,
Hemant

On Fri, Aug 17, 2012 at 3:31 AM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> On 17/08/12 04:13, Tommi Virtanen wrote:
>>
>> On Wed, Aug 15, 2012 at 9:44 PM, hemant surale <hemant.surale@gmail.com>
>> wrote:
>>>
>>> Hello Tommi, Ceph community
>>>
>>> I did mkdir the directory. Infact I have created a new partition by
>>> the same name and formatted using ext3. I also executed the following
>>> command for the partition/directory:
>>>
>>> "mount -o remount,user_xattr /"
>>
>> Remounting root with extended attributes isn't really relevant; what
>> you care about is /ceph_data/osd.0.
>>
>> Please share output of
>>
>> mount
>> ls /ceph_data/osd.0
>> --
>>
>
> Also I think there are a few things wrong with his ceph.conf (see
> attached....was sent to me in private email).
>
> I think he needs to:
> - correct bogus host entries (myserver01, alpha)
> - specify keyring for mds
>
> Making these changes (with hostnames appropriate for my setup) I can
> mkcephfs with his ceph.conf
>
> Cheers
>
> Mark
