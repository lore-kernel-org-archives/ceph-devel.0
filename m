From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cephfs quotas
Date: Thu, 19 Oct 2017 16:52:23 -0700
Message-ID: <CAJ4mKGbgvbVL_K4WiMKUwRbnm2kC0yv9pSMZY-khLB2=u8ex=g@mail.gmail.com>
References: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop>
 <CALe9h7dun71gFiAqn-1673spDRv95-+VHYWJWWE4CghvdXhjzg@mail.gmail.com>
 <CAJ4mKGZaQ=i6uWiebw+wB=NUmo959Q=TLhgNs98WDApJMZieJw@mail.gmail.com> <20171019112307.hn4ckrkb234ns2og@hermes.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:50590 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdJSXwY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 19:52:24 -0400
Received: by mail-it0-f44.google.com with SMTP id 72so12198452itl.5
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 16:52:24 -0700 (PDT)
In-Reply-To: <20171019112307.hn4ckrkb234ns2og@hermes.olymp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Thu, Oct 19, 2017 at 2:29 AM, Jan Fajerski <jfajerski@suse.com> wrote:
> UID based quotas would, I think, require MDS code to determine which MDS is
> responsible for a given UID (for quota accounting). With the directory/file
> based approach this code exists already. Not that this is an argument for
> either approach, I think both could work with this approach.

I'm not sure that's going to be any different, actually. Quotas can
already cross MDS subtree boundaries, and you need any MDS issuing
caps on an inode to be able to issue vouchers. This would look pretty
similar, though it might exercise the mds-side sharing/reconciliation
code more. *shrug*

On Thu, Oct 19, 2017 at 4:23 AM, Luis Henriques <lhenriques@suse.com> wrote:
> On Wed, Oct 18, 2017 at 02:44:13PM -0700, Gregory Farnum wrote:
>> On Wed, Oct 18, 2017 at 4:27 AM, John Spray <jspray@redhat.com> wrote:
>> > This is related to ideas about doing broader OSD-side enforcement of
>> > e.g. permissions: the MDS could issue tokens that said exactly what
>> > the client is allowed to do with specific inodes, rather than clients
>> > having free reign over everything in the data pool.
>>
>> Yeah, we've read a number of papers relevant to this topic. They were
>> generally focused on access permissions rather than quotas, though,
>> and generally had higher costs than are claimed here. I'm not sure if
>> any of them are extensible to quota enforcement; I tend to think not.
>> (They mostly involved the MDS signing statements with a timeout
>> granting access to the client holding them, but not feeding from the
>> OSD back to the MDS.)
>
> Just out of curiosity, is there any work being done on ceph to implement
> this OSD permissions enforcement?

No, we've never looked at it seriously. Just some occasional thoughts
bumping around in my head after reading those papers. ;)
-Greg

>> See especially "Macaroons: Cookies with Contextual Caveats for
>> Decentralized Authorization in the Cloud". "Scalable Security for
>> Petascale Parallel File Systems" was interesting but I think pretty
>> much superseded by macaroons. "Horus: Fine-Grained Encryption-Based
>> Security for Large-Scale Storage" was very different, but has the
>> "security" tag in my database program and might be more useful for
>> quotas, as it is about accessing file ranges rather than inodes.
>
> Interesting weekend literature, thanks!
>
> Cheers,
> --
> Luís
