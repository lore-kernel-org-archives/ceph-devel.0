From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: apache/fcgi deprecation?
Date: Mon, 8 Feb 2016 17:16:05 -0800
Message-ID: <CADRKj5SJSxNsZNgKOi-Q497JMAfA=GbBZ_FT_vxV9iD1Bhcv2g@mail.gmail.com>
References: <56B42126.7090106@suse.cz>
	<CALqRxCxtJ5a0xB68kSNP7xr3qcJ-rEr=xP+ByqyusyuOWU2HgQ@mail.gmail.com>
	<56B91FA8.8080709@suse.cz>
	<alpine.DEB.2.11.1602081929450.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34786 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964804AbcBIBQG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 20:16:06 -0500
Received: by mail-ob0-f171.google.com with SMTP id wb13so175447547obb.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 17:16:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602081929450.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Right, apache can be used as a proxy. In any case, my understanding is
that it's not a dependency, but we'll still have the ability to
install it (mod-proxy-fcgi) if needed (correct me if I'm wrong here).
There aren't any current plans that I know of to remove the rgw fcgi
frontend.

Yehuda


On Mon, Feb 8, 2016 at 4:30 PM, Sage Weil <sweil@redhat.com> wrote:
> Matt, Yehuda-
>
> What do you think?  There are some valid use-cases for wanting apache (or
> whatever) in front as it gives you access to a bunch of modules.  On the
> other hand, you can do the same with a proxy.
>
> sage
>
>
> On Tue, 9 Feb 2016, Nathan Cutler wrote:
>
>> On 02/08/2016 11:57 PM, Ken Dreyer wrote:
>> > Sure, please do it!
>> >
>> > I think it's just a matter of no one having time to remove it.
>>
>> So we could remove the FastCGI dependency from the packaging, too?
>>
>> > On Thu, Feb 4, 2016 at 9:12 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> > > I was just browsing the RGW documentation and noticed that parts of it are
>> > > still apache/fcgi-oriented (with no mention of civetweb) even in master.
>> > >
>> > > My impression was that civetweb is now recommended for RGW deployments as
>> > > it
>> > > is faster. Is that true? And is there a plan to deprecate/drop apache/fcgi
>> > > support, or will it remain indefinitely?
>> > >
>> > > Would it be a good idea to expunge apache/fcgi from the docs and point
>> > > folks
>> > > to civetweb instead?
>> > >
>> > > --
>> > > Nathan Cutler
>> > > Software Engineer Distributed Storage
>> > > SUSE LINUX, s.r.o.
>> > > Tel.: +420 284 084 037
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> Nathan Cutler
>> Software Engineer Distributed Storage
>> SUSE LINUX, s.r.o.
>> Tel.: +420 284 084 037
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
