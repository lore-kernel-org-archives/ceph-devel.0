From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: [rgw] Multi-tenancy support in radosgw
Date: Tue, 15 Sep 2015 13:17:19 +0200
Message-ID: <CA+H5UW11XJ5Ag8Ye-h7LipOGLoFms-OMNELgb2Lh4pG2WRvEog@mail.gmail.com>
References: <CA+H5UW0Y2Yc7jSG=iZ5bFpSEFsPpb50tgG1FUxRZFihf904yiQ@mail.gmail.com>
	<20150914231036.4cb235a0@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37790 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbIOLRU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 07:17:20 -0400
Received: by wicfx3 with SMTP id fx3so22291466wic.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 04:17:19 -0700 (PDT)
In-Reply-To: <20150914231036.4cb235a0@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

Hello Pete,

On Tue, Sep 15, 2015 at 7:10 AM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Sat, 12 Sep 2015 00:24:27 +0200
> Radoslaw Zarzynski <rzarzynski@mirantis.com> wrote:
>
>> Each already existing user would obtain empty bucket namespace
>> by default. It will be possible to create user  with his own, unique
>> namespace. [...]
>
>> 2. We will always need ID of namespace in order to access proper
>>     bucket entry points. [...]
>
>> I would like to ask for reviews of the idea and feedback.
>
> I still don't understand how this is different from tenants in wip-5073.
> Each tenant defines what amounts to a namespace for buckets. Could you
> clear this up? I heard you discussing it a little bit during the RGW
> team stand-up call, but I can't wrap my head around it.

Tenant is much more wider concept. In wip-5073 not only bucket entry
points got a prefix, but account as well. This huge, global namespace
was called tenant. In effect, listing of RADOS pool storing serialized
RGWUserInfo and buckets register for a given account was looking like
the following example:

  $ rados -p .users.uid ls
  68a23e70b5854263ab64f2ddc16c2a38:68a23e70b5854263ab64f2ddc16c2a38.buckets
  68a23e70b5854263ab64f2ddc16c2a38:68a23e70b5854263ab64f2ddc16c2a38

where '68a23e70b5854263ab64f2ddc16c2a38' in an account ID.

It's also worth to mention that accounts and users in radosgw are
a bit blurred - RGWUserInfo describes both entities. I'm visualizing
that as a composition - account always has an owner who is so tightly
bound to it that they share even a common identifier - UID.


> Secondly, have you given a thought to exact API here, or is it all
> hand-waved for now? As you may know, initially I hoped we'd get by
> without adding any special syntax for tenants. Just off-load it onto
> the authentication system, I thought. That didn't work and now we
> have the tenant$user syntax allowed all over.
>
> What I mean by that, a client has to do "swift -U tenant\$user:subuser -K pass"
> in 5073, and that looks a bit fraught. I presume you avoided that.

Yes, avoiding that was a requirement.


> Specifically though, imagine I'm doing "radosgw-admin user info",
> what do I get under your plan?

You would get everything as usual with one, small exception - boolean
indicating whether the account has its own namespace for bucket entry
points or not. We really need that due to the compatibility with already
existing clusters.

Of course, S3 also will be able to use non-empty BNS. However, I plan
to not enforce that.

> P.S. What repo/branch do you use for this? I know you quoted it before,
> but just so we're at the same place.

Initial BNS implementation has been sent as a pull request [1]. I'm also
working on separating account's owner from user involved in RGWOp
authorization process [2] (*::verify_permission methods).

Best regards,
Radek

[1] https://github.com/ceph/ceph/pull/5872
[2] https://github.com/rzarzynski/ceph/tree/wip-5073-bns-authsep
