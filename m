From: Junwang Zhao <zhjwpku@gmail.com>
Subject: Re: [wip-addr-features] make sure I am doing the right thing
Date: Thu, 19 May 2016 21:54:20 +0800
Message-ID: <CAEG8a3JBbfs_15+Ypsm24jAM7Od+BcCR8HoO1o9Sq2mtnmu6mA@mail.gmail.com>
References: <CAEG8a3LQuro2zXu90im0aQ58XxdGLDQvLxnjkJ+Rd8C6k70QVw@mail.gmail.com>
	<alpine.DEB.2.11.1605160446150.30956@cpach.fuggernut.com>
	<alpine.DEB.2.11.1605161228390.30956@cpach.fuggernut.com>
	<CAEG8a3KPFfuFfM2TDyY11A0XD=fvGEmm=TP2Y_ZvZfWYTREAzw@mail.gmail.com>
	<alpine.DEB.2.11.1605181637080.30956@cpach.fuggernut.com>
	<CAEG8a3KCYaCUAmdw8i=-BZKHVN4DJ4gK3RAzSf5q9cA2xXEr=Q@mail.gmail.com>
	<alpine.DEB.2.11.1605190806040.980@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33492 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbcESNyV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 09:54:21 -0400
Received: by mail-vk0-f45.google.com with SMTP id z184so103737392vkg.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 06:54:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605190806040.980@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi, Sage,

Check [1] when you got some time, sorry to bother :)

[1]https://github.com/zhjwpku/ceph/commit/8934f038fdf28156038770e601e4a27f7a684390

On Thu, May 19, 2016 at 8:08 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 19 May 2016, Junwang Zhao wrote:
>> Hi Sage, Haomai,
>> Please check [1] and give some feedback, I am not sure about
>> 52436ded943b8f567adb584c50b789431b788a85
>>
>> [1] https://github.com/zhjwpku/ceph/commits/wip-addr-work
>
> Great! I made several suggestions, and I have a question for everyone:
> what should we do if we have a "new" addr (say, for the v2 msgr protocol)
> and we need to encode it for a client that doesn't have the ADDR2 feature?
> Right now we are still stuffing the sockaddr_storage in their with
> whatever sockaddr data we have, but it is indistinguishable from a legacy
> address.  Perhaps it sould encode as blank?  (e.g., entity_addr_t())? Or
> blank, except with a magic nonce (0xffffffff maybe) so that you can tell
> that it is non-blank but not terribly useful/usable?
>
> sage
>
>
>
>> > Thanks!
>>
>> On Thu, May 19, 2016 at 4:44 AM, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 17 May 2016, Junwang Zhao wrote:
>> >> Hi Sage,
>> >>
>> >> Check this[1], we should I do next, entity_addrvec_t ?
>> >>
>> >> [1] https://github.com/zhjwpku/ceph/commits/wip-addr-work
>> >
>> > Looks good!  I opened the PR
>> >
>> >         https://github.com/ceph/ceph/pull/9184
>> >
>> > for review and test.
>> >
>> > The next step is just to make a new entity_addr_t encoding that is more
>> > compact and uses an ADDR2 feature.  One commit that defines the new
>> > feature, then one commit that changes the entity_addr_t encode/decode,
>> > somewhat like in c728926a86e1410f959011d24700bb07bad1dc2c.  I would use
>> > the new get_sockaddr_len() method for elen, though.
>> >
>> > Also, the TYPE_ definitions should really be TYPE_LEGACY = 1, not the
>> > transport version (IP version), which is already covered by the sa_family
>> > field in the sockaddr.  I think that makes sense...
>> >
>> > A third commit would then add the entity_addrvec_t type, similar to what
>> > is in that same commit.  It should also add the type to
>> > test/encoding/types.h.
>> >
>> > Thanks!
>> > sage
>> >
>> >
>> >
>> >>
>> >> On Tue, May 17, 2016 at 12:29 AM, Sage Weil <sage@newdream.net> wrote:
>> >> > On Mon, 16 May 2016, Sage Weil wrote:
>> >> >> Hi Junwang,
>> >> >>
>> >> >> On Mon, 16 May 2016, Junwang Zhao wrote:
>> >> >> > Hi Sage, Haomai,
>> >> >> >
>> >> >> > I am working on the require-features-patch, I use 'make' to see the conflicts,
>> >> >> > and change the code to fit the required-feature-patch, [1] is a huge patch
>> >> >> > that I am still working on, it has not been finished. I really need to check
>> >> >> > with you whether I am doing it right, since it seems the errors are endless.
>> >> >> >
>> >> >> > There are some comments where I am not sure in the patch, like 'not sure'.
>> >> >>
>> >> >> I skimmed through this and it looks mostly right, but I see a few cases
>> >> >> where features aren't needed, e.g. cls_refcount_get in
>> >> >> cls_refcount_client.cc (there's no addr being encoded in
>> >> >> cls_refcount_get_op, so no need to make the encoding featureful).
>> >> >>
>> >> >> > I didn't split this huge patch into small ones, I am not sure is that a
>> >> >> > must, if yes, I will split it into small ones.
>> >> >>
>> >> >> The end result needs to be a series of small patches, but that doesn't
>> >> >> have to happen right away.  I think it might be useful to do a few small
>> >> >> sets of changes first just to show what the goal is, though.
>> >> >>
>> >> >> I will take the patch below and pull a few sample changes out so you can
>> >> >> see.  Traveling at the moment, but I'll have something pushed today (that
>> >> >> is also rebased on top of the latest wip-addr-cleanup branch).
>> >> >
>> >> > I went on a bit of a binge and have a wip-addr-work branch that is mostly
>> >> > there.  The last thing (I think) is updating msg/simple and msg/async.
>> >> > These ones should explicitly encode with features 0 since the protocol is
>> >> > defined in terms of the legacy encoding.
>> >> >
>> >> > sage
>> >>
>> >>
>>
>>
