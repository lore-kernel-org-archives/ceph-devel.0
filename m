From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Is Ceph-FreeBSD package building information wanted in the Ceph
 tree?
Date: Mon, 28 Nov 2016 17:18:52 +0100
Message-ID: <f9f68ee5-3a6a-be37-40d1-1bdcf7814d49@digiware.nl>
References: <bd20aaaa-93a3-2f7e-482f-b544a4aaf80e@digiware.nl>
 <alpine.DEB.2.11.1611281438100.28496@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:56002 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932406AbcK1QSz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 28 Nov 2016 11:18:55 -0500
In-Reply-To: <alpine.DEB.2.11.1611281438100.28496@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 28-11-2016 15:41, Sage Weil wrote:
> On Mon, 28 Nov 2016, Willem Jan Withagen wrote:
>> Hi,
>>
>> The Ceph package build config is almost ready for submission to the
>> FreeBSD Ports system.
>> Now the question is, is a copy of this also wanted in the Ceph-tree?
>>
>> Note that the FreeBSD ports are already publicly available in SVN, and
>> completely trackable there.
>>
>> Advantage is that all FreeBSD items are in the tree.
>> Disadvantage would probably be:
>>  -  There ia absolutely no way to test this
>>  -  it is not going to be used by users from the tree, but from
>> 	/usr/ports
>>  -  The version in the Ceph tree will always lagg, if only because
>> 	changes will be submitted after acceptance by the Ceph
>> 	developers.
>>
>> In my personal opinion it does have value, because it will inform
>> porters to other systems that there is already infrastructure for BSD.
>>
>> But the reason for asking is that I'm bivalent about this.
> 
> We do this for debian and rpm distro (keep debian/ and ceph.spec in-tree), 
> which is a bit unusual.  In those cases they are the 'upstream' version 
> of the build config, and downstream distros typically patch any 
> additional changes they need on top.

Problem with this is that it is rather hard to actually simulate the
build environment (poudriere) for FreeBSD ports. So for that it will
require a rather convoluted setup to test submits.

Hence my preference to upload only after changes have shown to work in
the Ports system.

But perhaps it would be wise to actually keep a "release" version of the
ports-config in the tree. That is a version that does not change all
that often. On the other hand you would not want to delay the release of
Ceph version until the FreeBSD port is stable. So the ports entry would
be updated after the release of a new version....

I could just submit a PR for it once the port seems oke, and then we see
what works.

--WjW

