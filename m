From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: OpenStack summit : Ceph design session
Date: Wed, 6 Mar 2013 15:12:16 -0800
Message-ID: <CAC-hyiEDiTNgdkNjc0Jd5hpY-vDELDhD0Xy7VPwhyAP4Yf37Jw@mail.gmail.com>
References: <51289AF2.9010509@dachary.org>
	<512A9F5F.7080706@inktank.com>
	<CANygib_m5h6F7u5ayzSTdZ2Y_8mO414dFXQup2w8NTWQtYWc9w@mail.gmail.com>
	<512B3725.4040602@dachary.org>
	<513319E8.7000105@dachary.org>
	<CANygib_axAT=3vmG39GNCb0X_1Goycy+P6nF2UQyBcUm9EqbUA@mail.gmail.com>
	<5137C71E.5090507@dachary.org>
	<CANygib_BkX7oXGKNF44UxJL=1b=+6Kaw3janFaA4cDHPpxV9BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:46204 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab3CFXMR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 18:12:17 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so7781904iae.25
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 15:12:16 -0800 (PST)
In-Reply-To: <CANygib_BkX7oXGKNF44UxJL=1b=+6Kaw3janFaA4cDHPpxV9BQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Levine <neil.levine@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Mar 6, 2013 at 3:05 PM, Neil Levine <neil.levine@inktank.com> wrote:
> On Wed, Mar 6, 2013 at 2:45 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Neil,
>>
>> On 03/06/2013 08:27 PM, Neil Levine wrote:
>>> I think the multi-site RGW stuff is somewhat orthogonal to OpenStack
>>
>> Even when keystone is involved ?
>
> Good question.
>
> Yehuda: how would the asynchronously replicated user metadata interact
> with Keystone?

Depends. Are there any special requirements? From what I understand,
you'd define the keystone backend every zone interact with per-zone,
and the fact that it's a replicated region/zone doesn't change much.

>
>>> Who approves the session at ODS and when is this decision made?
>>
>> I suspect Josh knows more than I do about this. During the cinder meeting earlier today J. Griffith said that if the nova track is too busy to host the "Roadmap for Ceph integration with OpenStack" session he was in favor of having it in the cinder track. Following his advice I suggested to Thierry Carrez to open a "Cross project" track ( http://lists.openstack.org/pipermail/openstack-dev/2013-March/006365.html )
>
> I don't think Cinder is such a bad place for it to be as presumably
> the interaction to copy the block device to a secondary location would
> be triggered through a Cinder API call no?
>
> Neil
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
