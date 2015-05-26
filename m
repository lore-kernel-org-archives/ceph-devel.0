From: Gregory Farnum <greg@gregs42.com>
Subject: Re: MDS auth caps for cephfs
Date: Tue, 26 May 2015 07:26:52 -0700
Message-ID: <CAC6JEv8EzQ9Pp=ca_LSuVqiyAYSfhyF2ie1Os4YM2v46Ru8Z4w@mail.gmail.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
	<555EF6D0.5000903@redhat.com>
	<alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net>
	<CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com>
	<alpine.DEB.2.00.1505221505441.6462@cobra.newdream.net>
	<CAC6JEv9Zd11mXiO=VWNQ6s_LKtOkkk4HmCdoa0mTLi7-H-q+tA@mail.gmail.com>
	<alpine.DEB.2.00.1505221544570.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38658 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbEZO0y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 10:26:54 -0400
Received: by igcau1 with SMTP id au1so54448582igc.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2015 07:26:53 -0700 (PDT)
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com. [209.85.213.171])
        by mx.google.com with ESMTPSA id g32sm7371205ioj.20.2015.05.26.07.26.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2015 07:26:52 -0700 (PDT)
Received: by igbyr2 with SMTP id yr2so59477030igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2015 07:26:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505221544570.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Fri, May 22, 2015 at 3:52 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 22 May 2015, Gregory Farnum wrote:
>> On Fri, May 22, 2015 at 3:18 PM, Sage Weil <sweil@redhat.com> wrote:
>> >> What would it mean for a user who doesn't have no_root_squash to have
>> >> access to uid 0? Why should we allow random users to access any UID
>> >> *except* for root? Does a client who has no_root_squash and anon uid
>> >> 123 get to access stuff as root, or else as 123? Can they access as
>> >> 124?
>> >
>> > I can't tell what you mean... :(
>> >
>> > I'm guessing you're getting at root_squash being a weak tool, since it
>> > mostly only prevents you from doing something that only root could do (a
>> > compromised client can just claim to be any uid).  A weak tool is still a
>> > tool, though, and one that people can make use of.
>>
>> I guess maybe I am. But it's not just that: it's that I don't
>> understand how it interacts with specifying UIDs. I would *expect*
>> that we grant specific cephx keys access to specific UIDs,
>
>  allow uid 1 rw
>  allow uid 2 rw
>
>> or to "any except root",
>
>  allow rw options root_squash
>
>> or to "any".
>
>  allow rw     # implied no_root_squash
>
>> But the usage of root_squash implies that any client can try to act as
>> any UID and we'll let them.
>
> Yes... any uid *except* uid 0.
>
>> So if a key says "no_root_squash, allow uid=123, allow gid=123", does
>> that key allow the client to act as root? I think it *does*, but it
>> *shouldn't*.
>
> Do you mean
>
>  allow rw options  # implied no_root_squash
>  allow uid 123 rw
>  allow gid 123 rw
>
> ?  Because the 2nd and third are no-ops since the first will already let
> 123 and any-other non-0 uid (or gid) do a write.
>
> Or, do you mean
>
>  allow uid 123 gid 123 options no_root_squash
>
> In that case, I think no_root_squash is a meaningless option because we
> have already said 'uid 123' only please.

So here you've said that no_root_squash is meaningless because of a
different set of granted permissions; that doesn't sound strictly
additive to me.
Or do you mean (as John implies below) that no_root_squash will not
squash the user and then it will fail because it doesn't have adequate
access permissions?

On Tue, May 26, 2015 at 5:56 AM, John Spray <john.spray@redhat.com> wrote:
> This feels more like a syntax issue: as you say, these NFS-esque options
> don't make sense as part of a list of additive capabilities, they're more
> like a single structure with some fields.  The naming is potentially
> confusing too; we're really talking about a condition under which we squash
> a UID (never, when requester was root, or always), and then how we do the
> squashing (to which UID/GID).
>
> A syntax that doesn't allow the nonsensical combinations of options might be
> something like:
> squash: <none|all|root>
> squash_to: <uid> <gid>
> capabilities: [existing additive list style] [] []...
>
> (or even a list of those structures, so that admin could define e.g.
> multiple path-limited capabilities, each with different squashing rules).
>
> But maybe it is a good idea to avoid introducing this to users as "it's like
> NFS" to avoid confusion.

Yes, something like this makes a lot more sense to me. Although I'd
almost expect/want it to be done client-side rather than on the
server: the server is responsible for making sure clients have
permission to do what they're asking; the clients are responsible for
forming their requests in a way that they have permission. Is that
nonsensical?
-Greg
