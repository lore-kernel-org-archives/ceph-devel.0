From: Erik Logtenberg <erik@logtenberg.eu>
Subject: Re: Fwd: [ceph-users] Small fix for ceph.spec
Date: Tue, 30 Jul 2013 23:01:28 +0200
Message-ID: <51F829A8.104@logtenberg.eu>
References: <51F6F595.605@logtenberg.eu> <CAP8Oy=KD4au7aaOqo1t6zvWP1JFnTtQELd8YunxXqyBaE4+wpg@mail.gmail.com> <51F76B43.4020801@bisect.de> <51F76E49.2090504@logtenberg.eu> <51F771B2.1080606@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx.logtenberg.eu ([77.94.249.229]:53043 "EHLO mx.logtenberg.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757041Ab3G3VBa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jul 2013 17:01:30 -0400
In-Reply-To: <51F771B2.1080606@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

Hi,

I will report the issue there as well. Please note that Ceph seems to
support Fedora 17, even though that release is considered end-of-life by
Fedora. This issue with the leveldb package cannot be fixed for Fedora
17, only for 18 and 19.
So if Ceph wants to continue supporting Fedora 17, adding this
workaround seems to be the only way to get this (rather minor) bug fixed.

Kind regards,

Erik.


On 07/30/2013 09:56 AM, Danny Al-Gaaf wrote:
> Hi,
> 
> then the Fedora package is broken. If you check the spec file of:
> 
> http://dl.fedoraproject.org/pub/fedora/linux/updates/19/SRPMS/leveldb-1.12.0-3.fc19.src.rpm
> 
> 
> You can see the spec-file sets a:
> 
> BuildRequires:  snappy-devel
> 
> But not the corresponding "Requires: snappy-devel" for the devel package.
> 
> You should report this issue to your distribution, it needs to be fixed
> there instead of adding a workaround to the ceph spec.
> 
> Regards,
> 
> Danny
> 
> Am 30.07.2013 09:42, schrieb Erik Logtenberg:
>> Hi,
>>
>> Fedora, in this case Fedora 19, x86_64.
>>
>> Kind regards,
>>
>> Erik.
>>
>>
>> On 07/30/2013 09:29 AM, Danny Al-Gaaf wrote:
>>> Hi,
>>>
>>> I think this is a bug in packaging of the leveldb package in this case
>>> since the spec-file already sets dependencies on on leveldb-devel.
>>>
>>> leveldb depends on snappy, therefore the leveldb package should set a
>>> dependency on snappy-devel for leveldb-devel (check the SUSE spec file
>>> for leveldb:
>>> https://build.opensuse.org/package/view_file/home:dalgaaf:ceph:extra/leveldb/leveldb.spec?expand=1).
>>> This way the RPM build process will pick up the correct packages needed
>>> to build ceph.
>>>
>>> Which distro do you use?
>>>
>>> Danny
>>>
>>> Am 30.07.2013 01:33, schrieb Patrick McGarry:
>>>> ---------- Forwarded message ----------
>>>> From: Erik Logtenberg <erik@logtenberg.eu>
>>>> Date: Mon, Jul 29, 2013 at 7:07 PM
>>>> Subject: [ceph-users] Small fix for ceph.spec
>>>> To: ceph-users@lists.ceph.com
>>>>
>>>>
>>>> Hi,
>>>>
>>>> The spec file used for building rpm's misses a build time dependency on
>>>> snappy-devel. Please see attached patch to fix.
>>>>
>>>> Kind regards,
>>>>
>>>> Erik.
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>
