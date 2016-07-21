From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: CephFS Samba VFS RHEL packages
Date: Fri, 22 Jul 2016 08:29:39 +1100
Message-ID: <CA+z5DszcKbrEcAssNFQEfaE5ugwOaxs3RbcO1s+n9fkGK18K=A@mail.gmail.com>
References: <CA+z5Dsx7phEMT1oxENzCwXxQrB0NtCLwxWGPKF+NeMZNr+KkSw@mail.gmail.com>
 <CALqRxCwg3jFN2OTC2ut=otHukOGHw9p9r7+RbByvQdTMBifM8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34358 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbcGUV37 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 17:29:59 -0400
Received: by mail-vk0-f53.google.com with SMTP id s189so131721294vkh.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 14:29:59 -0700 (PDT)
In-Reply-To: <CALqRxCwg3jFN2OTC2ut=otHukOGHw9p9r7+RbByvQdTMBifM8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, Ira Cooper <icooper@redhat.com>, John Spray <john.spray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Ken, Ira, John -

Thanks a lot for the replies. Our initial setup is simply running
samba atop a cephfs kernel mount, and initial cursory checks seem to
show the basics are working as expected (even clustered with ctdb -
what are your concerns here Ira?). Though we've yet to try any of our
planned test scenarios/datasets.

From the conversation here I'm thinking we'd be better off using
Xenial for our CephFS+Samba test nodes at the moment... though I only
see packages for Precise and Trusty on gitbuilder.ceph.com at the
moment. We were planning to compare samba on kernel mount versus ceph
vfs.

Can someone clarify what state the cephfs kernel client in RHEL 7.x
will be in when RHCS 2.0 is released, i.e., will that be back-ported
or are RHEL users expected to use FUSE? (I'm happy to go ask support
directly but I suspect this is useful information for others too).

Cheers,

On 21 July 2016 at 02:32, Ken Dreyer <kdreyer@redhat.com> wrote:
> The Samba packages in Fedora 22+ do enable the Samba VFS:
> https://bugzilla.redhat.com/1174412
>
> From what Ira said downthread, this is pretty experimental, so you
> could run your tests on a Fedora system and see how it goes :)
>
> - Ken
>
> On Tue, Jul 19, 2016 at 11:45 PM, Blair Bethwaite
> <blair.bethwaite@gmail.com> wrote:
>> Hi all,
>>
>> We've started a CephFS Samba PoC on RHEL but just noticed the Samba
>> Ceph VFS doesn't seem to be included with Samba on RHEL, or we're not
>> looking in the right place. Trying to avoid needing to build Samba
>> from source if possible. Any pointers appreciated.
>>
>> --
>> Cheers,
>> ~Blairo
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
