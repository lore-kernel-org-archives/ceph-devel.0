From: hemant surale <hemant.surale@gmail.com>
Subject: Fwd: Delivery Status Notification (Failure)
Date: Tue, 30 Oct 2012 14:32:17 +0530
Message-ID: <CAGfy=6=CjbJCE981zT=oZOGXpMuKBadXD0hxR8yuCRbfKskz9g@mail.gmail.com>
References: <CAGfy=6=se6CXExQyyA7TrAjUVkGqRwGL=E1wqo4h4_6ORzS-MA@mail.gmail.com>
	<f46d0438909985742c04cc3f658c@google.com>
	<CAGfy=6n6WJOKvQTO1LfsnY+_SRdh714HmoPKGgTSpjhE06qZBQ@mail.gmail.com>
	<CAGfy=6mwAD6A4Z3GXzmMwJnu7W0uPan1m1FYAnRuna9a3rDG=A@mail.gmail.com>
	<508EE4E4.7060802@inktank.com>
	<CAGfy=6nj9v14JHa1KX4ffYnNCKoXB-dHNeAUqMqZRAE0+oFhnA@mail.gmail.com>
	<DBD4A33F-98A2-452B-A854-4DD6D846E0A0@inktank.com>
	<CAGfy=6kNDhdPQB4WdYN2adZHxAJtXfySfch3-_PjHSGBWknmKg@mail.gmail.com>
	<CAGfy=6mesQn=wGQiXgKDwKd3zjYWNtYdn+xY=StSKgDqiNa9NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51928 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab2J3JCS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 05:02:18 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so25710vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 02:02:17 -0700 (PDT)
In-Reply-To: <CAGfy=6mesQn=wGQiXgKDwKd3zjYWNtYdn+xY=StSKgDqiNa9NA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---------- Forwarded message ----------
From: hemant surale <hemant.surale@gmail.com>
Date: Tue, Oct 30, 2012 at 2:28 PM
Subject: Re: Delivery Status Notification (Failure)
To: Dan Mick <dan.mick@inktank.com>


Sir,
  Now "mkcephfs" is working fine but even after that when i tried to
execute "service ceph start " following error is observed


------------------------------------------------------------------------------------------------------------------------------------
root@atish-virtual-machine:/usr/local/bin# service ceph start
=== mon.alpha ===
Starting Ceph mon.alpha on atish-virtual-machine...
bash: /usr/bin/ceph-mon: Is a directory
failed: ' /usr/bin/ceph-mon -i alpha --pid-file
/var/run/ceph/mon.alpha.pid -c /etc/ceph/ceph.conf '
-------------------------------------------------------------------------------------------------------------------------------------


Thanks & Regards,
Hemant Surale.


On Tue, Oct 30, 2012 at 11:33 AM, hemant surale <hemant.surale@gmail.com> wrote:
> -------------------//ceph.conf-----------------------------------------------------------------
>
> [global]
>         auth supported = none
>
> [mon]
>        # mon data = /ceph_data/mon.$id
>
> [mds]
>
> [osd]
>         #osd data = /ceph_data/osd.$id
>         #osd journal = /ceph_data/osd.$id.journal
>         osd journal size = 1000
>         filestore xattr use omap = true
>
> [mon.alpha]
>         host = atish-virtual-machine
>         mon addr = 10.72.148.248:6789
>
> [osd.0]
>         host = atish-virtual-machine
>         host addr = 10.72.148.248:6789
>
>
> [mds.alpha]
>         host = atish-virtual-machine
>         host addr = 10.72.148.248:6789
> ----------------------------------------------------------------------------------------------------------------------------------------------------
>
>
> -
> Hemant Surale
>
> On Tue, Oct 30, 2012 at 11:31 AM, Dan Mick <dan.mick@inktank.com> wrote:
>> This is totally different from not finding ceph-common.sh.
>>
>> Please show your ceph.conf.
>>
>>
>> On Oct 29, 2012, at 9:11 PM, hemant surale <hemant.surale@gmail.com> wrote:
>>
>>> After performing all required steps for building I simply executed
>>> "mkcephfs -a -c /etc/ceph/ceph/ceph/conf -k ceph.keyring" then it
>>> showed Error:
>>>
>>> ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>>
>>> temp dir is /tmp/mkcephfs.V45sNNmgk8
>>> preparing monmap in /tmp/mkcephfs.V45sNNmgk8/monmap
>>> /usr/local/bin/monmaptool --create --clobber --add alpha
>>> 10.72.148.248:6789 --print /tmp/mkcephfs.V45sNNmgk8/monmap
>>> /usr/local/bin/monmaptool: monmap file /tmp/mkcephfs.V45sNNmgk8/monmap
>>> /usr/local/bin/monmaptool: generated fsid d30d3dbf-232f-46cf-9e64-ed31f9083a0b
>>> epoch 0
>>> fsid d30d3dbf-232f-46cf-9e64-ed31f9083a0b
>>> last_changed 2012-10-30 09:38:44.916885
>>> created 2012-10-30 09:38:44.916885
>>> 0: 10.72.148.248:6789/0 mon.alpha
>>> /usr/local/bin/monmaptool: writing epoch 0 to
>>> /tmp/mkcephfs.V45sNNmgk8/monmap (1 monitors)
>>> === osd.0 ===
>>> 2012-10-30 09:38:45.008029 b6fa5740 -1
>>> filestore(/var/lib/ceph/osd/ceph-0) limited size xattrs -- enable
>>> filestore_xattr_use_omap
>>> 2012-10-30 09:38:45.008044 b6fa5740 -1 OSD::mkfs: couldn't mount
>>> FileStore: error -95
>>> 2012-10-30 09:38:45.008069 b6fa5740 -1  ** ERROR: error creating empty
>>> object store in /var/lib/ceph/osd/ceph-0: (95) Operation not supported
>>> failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.V45sNNmgk8
>>> --init-daemon osd.0'
>>> ----------------------------------------------------------------------------------------------------------------------------------------------------------
>>> And According to my knowledge Till mkcephfs doesn't work fine
>>> "service Ceph start" wont work. Can you please guide me about steps
>>> required after successfully executing build instructions given at
>>> official site.
>>>
>>>
>>> Thanks & Regards,
>>> Hemant Surale.
>>>
>>>
>>>
>>> On Tue, Oct 30, 2012 at 1:49 AM, Dan Mick <dan.mick@inktank.com> wrote:
>>>> Last time you asked this, I responded (on 18 Oct):
>>>>
>>>> So, clearly something went wrong with the installation step, and this file
>>>> was not created.  How did you install after building?
>>>>
>>>>
>>>> On 10/29/2012 02:27 AM, hemant surale wrote:
>>>>>
>>>>> Hi Folks ,
>>>>>
>>>>> I have executed all required steps to build Ceph from source but now
>>>>> when I execute "service Ceph start" it shows
>>>>>
>>>>>
>>>>> ---------------------------------------//Error--------------------------------------------
>>>>> root@atish-virtual-machine:/ceph_data# service ceph start
>>>>> /etc/init.d/ceph: 37: .: Can't open /usr/lib/ceph/ceph_common.sh
>>>>>
>>>>> -------------------------------------------------------------------------------------------
>>>>>
>>>>>
>>>>> Please help me out .
