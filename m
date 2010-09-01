From: H Chang <heracles@gmail.com>
Subject: Re: support for multiple data placement policies
Date: Wed, 1 Sep 2010 17:03:37 -0400
Message-ID: <AANLkTi=yYL2PZFZvQaS7ySbhmaSEDrrEhJbwBpU7TaXW@mail.gmail.com>
References: <AANLkTin8GVQfPmV0d3xGThEMPYeRMKYuCR1b6Fk5XPre@mail.gmail.com>
	<AANLkTi=K3ASGMoN1DTkQu-hqMzXm43eVyb64LhEqgxRC@mail.gmail.com>
	<Pine.LNX.4.64.1009011320280.9613@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37659 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab0IAVDi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Sep 2010 17:03:38 -0400
Received: by gxk23 with SMTP id 23so3181063gxk.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Sep 2010 14:03:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009011320280.9613@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

Thanks Greg and Sage for your replies.

Sage's suggestion seems more doable to me.
With custom file layout policy, each file would potentially be able to
use a customized CRUSH rule.

I see that the feature is planned for v0.22.
Out of curiosity, what will be an interface for specifying such a
policy?  Use xattr?

Best regards,
HS

On Wed, Sep 1, 2010 at 4:28 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 1 Sep 2010, Gregory Farnum wrote:
>
>> On Wed, Sep 1, 2010 at 11:33 AM, H Chang <heracles@gmail.com> wrote:
>> > Hi Ceph team,
>> >
>> > I'm a newbie in Ceph, so please bear with me if my question sounds=
 stupid.
>> >
>> > I'd like to explore the possibility to support multiple placement
>> > policies in Ceph.
>
> Some of the infrastructure is there for this. =A0Each file has a layo=
ut,
> which specifies the striping strategy and which storage pool the file=
 data
> gets stored. =A0Each pool has a field specifying which CRUSH rule set=
 to use
> (they can share).
>
>> > For example, suppose each user using Ceph has its own placement po=
licy
>> > which may be different from one user to another.
>
> Creating a pool for each user may be overkill, however. =A0The intent=
ion was
> for pools and/or crush rules to be defined for things like "fast sas
> disks", "slow sata pool", that sort of thing. =A0Currently everything=
 is
> thrown in a single data pool.
>
> Currently the default file layout is compiled in and applies to all n=
ew
> files. =A0There is an open bug/issue for specifying the default file =
layouts
> on a directory basis (e.g, everthing in /home goes into this pool,
> everything in /scratch goes in that pool). =A0See
>
> =A0 =A0 =A0 =A0http://tracker.newdream.net/issues/185
>
> In any case, creating per-user pools means pushing more awareness of =
users
> into the file system, autocreating pools, and that sort of thing. =A0=
As
> things stand, the layout policy is something an administrator has to
> set up.
>
>> But it will require changing several pretty low-level structs and
>> modifying the metadata server and both versions of the client to
>> enable, so it's not a good introductory project and you shouldn't
>> expect it soon. :(
>
> ...for per-user pools, at least. =A0Something along the lines of issu=
e #185
> above is more doable (and on the roadmap).
>
> sage
>
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
