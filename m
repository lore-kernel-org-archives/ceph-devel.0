From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: librados3
Date: Thu, 19 Oct 2017 08:09:43 -0400
Message-ID: <CA+aFP1B71gWjrjxGNBsUadUiBkn3uhqEF2ba+gzUDWhS+ghXWA@mail.gmail.com>
References: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com>
 <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com> <alpine.DEB.2.11.1710191200091.26711@piezo.us.to>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:49471 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbdJSMJo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 08:09:44 -0400
Received: by mail-yw0-f173.google.com with SMTP id n189so3267560ywd.6
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 05:09:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1710191200091.26711@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <jspray@redhat.com>, kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I vote against bumping to so.3 for Luminous since it would prevent
distros from upgrading to Luminous w/o re-linking apps like QEMU (e.g.
qemu-kvm rpm in RHEL has a requirement on "
librados.so.2()(64bit)". Therefore, we would have to still ship
librados2 (with the broken ABI) so it doesn't seem like we gain
anything.

On Thu, Oct 19, 2017 at 8:00 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 19 Oct 2017, John Spray wrote:
>> On Thu, Oct 19, 2017 at 10:25 AM, kefu chai <tchaikov@gmail.com> wrote:
>> > in luminous, we introduced a change not backward compatible with
>> > pre-luminous librados. see see http://tracker.ceph.com/issues/21573.
>> > and i cannot see an obvious solution without bumping up the so version
>> > of librados to 3.
>> >
>> > if we have the luxury to do it,  we will be able to give librados an
>> > overhaul. for a todo list, see http://pad.ceph.com/p/librados3.
>> >
>> > what do you think?
>>
>> I've added a couple of items to the pad for deprecated bits to remove
>> when we go up a version.
>>
>> I guess we would do the version bump for Mimic and for Luminous we
>> will just have to apologetically tell people they need to recompile?
>>
>> Or we could have a so.3 version (ABI change only) in Luminous that
>> just bumps the version to force a recompile, and a so.4 version in
>> Mimic that actually makes the API changes?
>
> Yeah, it sounds like this is what we actually want in this case?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
