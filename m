From: Alfredo Deza <adeza@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Tue, 31 May 2016 15:03:21 -0400
Message-ID: <CAC-Np1xcEZWi30MWAgXQ+Lk=Cr1OyAAoHgCQzi8YVOr+i7ZFew@mail.gmail.com>
References: <5703A7FF.2090002@suse.com>
	<CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
	<5704C76C.2050408@suse.com>
	<alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
	<570666AB.8090408@suse.com>
	<alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
	<57067F56.2000705@suse.com>
	<alpine.DEB.2.11.1604071143000.19675@cpach.fuggernut.com>
	<57081B3A.20601@suse.com>
	<570BAC52.4070404@suse.com>
	<alpine.DEB.2.11.1605120905220.23446@cpach.fuggernut.com>
	<573F0A9F.6000704@suse.com>
	<57457CC7.1080809@suse.com>
	<alpine.DEB.2.11.1605250843590.4873@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34415 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbcEaTDX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 15:03:23 -0400
Received: by mail-lf0-f48.google.com with SMTP id k98so97373006lfi.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 12:03:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605250843590.4873@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Owen Synge <osynge@suse.com>, cjones303@bloomberg.net, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <ldachary@redhat.com>

On Wed, May 25, 2016 at 8:45 AM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 25 May 2016, Owen Synge wrote:
>> Great news ceph-deploy master now has the PR merged in so that
>> ceph-deploy can now work without any magic involved with ceph-create-keys.
>>
>> I will now make a patch to ceph proper to remove ceph-create-keys from
>> the init scripts. Hopefully this will move things forward and we can get
>> this patch merged relatively quickly.
>>
>> Please let me know if I am doing anything wrong.
>
> Great!
>
> Alfredo, are there changes we need to ceph-ansible for this too?  Puppet?
> Chef?

We don't have anything to deal with this in ceph-ansible (yet). We
should make some noise about this change when the PR is up
so that Chef/Puppet users+maintainers are aware of the required changes.


>
> (This is post-jewel, so it can wait a bit if necessary.)
>
> sage
