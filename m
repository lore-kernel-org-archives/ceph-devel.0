From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: Fwd: [ceph-users] Small fix for ceph.spec
Date: Tue, 30 Jul 2013 09:56:34 +0200
Message-ID: <51F771B2.1080606@bisect.de>
References: <51F6F595.605@logtenberg.eu> <CAP8Oy=KD4au7aaOqo1t6zvWP1JFnTtQELd8YunxXqyBaE4+wpg@mail.gmail.com> <51F76B43.4020801@bisect.de> <51F76E49.2090504@logtenberg.eu>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:45223 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753030Ab3G3H4i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jul 2013 03:56:38 -0400
In-Reply-To: <51F76E49.2090504@logtenberg.eu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Erik Logtenberg <erik@logtenberg.eu>
Cc: Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

Hi,

then the Fedora package is broken. If you check the spec file of:

http://dl.fedoraproject.org/pub/fedora/linux/updates/19/SRPMS/leveldb-1.12.0-3.fc19.src.rpm


You can see the spec-file sets a:

BuildRequires:  snappy-devel

But not the corresponding "Requires: snappy-devel" for the devel package.

You should report this issue to your distribution, it needs to be fixed
there instead of adding a workaround to the ceph spec.

Regards,

Danny

Am 30.07.2013 09:42, schrieb Erik Logtenberg:
> Hi,
> 
> Fedora, in this case Fedora 19, x86_64.
> 
> Kind regards,
> 
> Erik.
> 
> 
> On 07/30/2013 09:29 AM, Danny Al-Gaaf wrote:
>> Hi,
>>
>> I think this is a bug in packaging of the leveldb package in this case
>> since the spec-file already sets dependencies on on leveldb-devel.
>>
>> leveldb depends on snappy, therefore the leveldb package should set a
>> dependency on snappy-devel for leveldb-devel (check the SUSE spec file
>> for leveldb:
>> https://build.opensuse.org/package/view_file/home:dalgaaf:ceph:extra/leveldb/leveldb.spec?expand=1).
>> This way the RPM build process will pick up the correct packages needed
>> to build ceph.
>>
>> Which distro do you use?
>>
>> Danny
>>
>> Am 30.07.2013 01:33, schrieb Patrick McGarry:
>>> ---------- Forwarded message ----------
>>> From: Erik Logtenberg <erik@logtenberg.eu>
>>> Date: Mon, Jul 29, 2013 at 7:07 PM
>>> Subject: [ceph-users] Small fix for ceph.spec
>>> To: ceph-users@lists.ceph.com
>>>
>>>
>>> Hi,
>>>
>>> The spec file used for building rpm's misses a build time dependency on
>>> snappy-devel. Please see attached patch to fix.
>>>
>>> Kind regards,
>>>
>>> Erik.
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
> 

