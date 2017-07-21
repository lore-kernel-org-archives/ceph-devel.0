From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: external key mgr for ceph-mon?
Date: Fri, 21 Jul 2017 15:20:20 -0400
Message-ID: <CAGbviv+MZRrUxdssjk6Pg=GTAKgLHGp7WZ7MaCsokfUQKkcFQQ@mail.gmail.com>
References: <CAGbviv+mBMnDo_R81btpw-1jM_5m0ihW5GGJ_uYB7DksT1xKjA@mail.gmail.com>
 <alpine.DEB.2.11.1707211911160.27271@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34421 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753502AbdGUTUV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jul 2017 15:20:21 -0400
Received: by mail-io0-f172.google.com with SMTP id l7so26007920iof.1
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jul 2017 12:20:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707211911160.27271@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks.

I will look into the dmcrypt key mgmt interfaces, but Im not
optimistic.  One other problem is that if a cluster already has
existing keys from the mons, and then someone wants to add external
key management, everything has to be re-keyed which complicates the
issue a bit.



On Fri, Jul 21, 2017 at 3:13 PM, Sage Weil <sage@newdream.net> wrote:
> Hi Wyllys,
>
> On Fri, 21 Jul 2017, Wyllys Ingersoll wrote:
>> Has anyone considered making the ceph-mon process fetch an external
>> "master" wrapping key from an external server (preferably using KMIP
>> protocol) to wrap/unwrap the ceph keys used for OSD encryption (or
>> possibly other keys as well)?
>>
>> In certain environments, there are strict requirements to have
>> external key management for disk-encryption keys. Now that keys for
>> OSD encryption are stored in the monitor, it should be possible to
>> wrap those keys in the monitor persistent storage with an external key
>> so that they system could not be started without fetching the master
>> wrapping key from an external source.
>>
>> I just wanted to check and see if anyone has done any work in this area.
>
> This isn't currently possible.  It could be done but would probably
> require some inelegant changes to the config-key service.  However, the
> dmcrypt key management was written to be modular so that some other key
> management service could be used instead of the mons.  This should only
> require some hacking on the ceph-disk code that creates and stores these
> keys during prepare and fetches them on activate.
>
> Note that there is also some early work on integrating with kerberos, but
> that doesn't address the dmcrypt key management at all.
>
> sage
