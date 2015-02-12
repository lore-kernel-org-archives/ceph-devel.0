From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: Upgrade/rollback
Date: Thu, 12 Feb 2015 09:40:32 +0200
Message-ID: <54DC58F0.7040305@redhat.com>
References: <BLU175-W8D101EDE23DCDD591ADF6DF250@phx.gbl> <CAC6JEv_76meAsaRmCr9-qEiU0C0R4LGOx=ja9M5vxkW=6jSvcQ@mail.gmail.com> <alpine.DEB.2.00.1502110923250.3035@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42790 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbbBLHkj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Feb 2015 02:40:39 -0500
In-Reply-To: <alpine.DEB.2.00.1502110923250.3035@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>
Cc: GuangYang <yguang11@outlook.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/11/2015 07:26 PM, Sage Weil wrote:
> On Wed, 11 Feb 2015, Gregory Farnum wrote:
>> On Wed, Feb 11, 2015 at 4:09 AM, GuangYang <yguang11@outlook.com> wrote:
>>> Hi ceph-devel,
>>> Recently we are trying the upgrade from Firefly to Giant and it goes pretty smoothly, however, the problem is that it does not support rollback and seems like that is by design. For example, there is new feature flag / metadata [1] added in the new version and they are persisted. As a result, the old version of software does not recognize those values and will crash themselves.
>>>
>>> Ideally we never rollback, but for unknown reasons we couldn't fix in a timely manner, we might want to rollback first. Is that something we will consider to handle?
>> We are unlikely to ever do this. We've talked about rollback options,
>> but allowing rollback means either:
>> 1) never adding information to the disk format which matters,
>> 2) having a separate switchover point (besides the code upgrade) which
>> enables all the disk change bits and which doesn't allow you to roll
>> back.
>>
>> The first option is obviously infeasible. The second one dramatically
>> increases the amount of code which can be buggy, increases the testing
>> version, and doesn't really solve the problem since you still have a
>> hard point of no return.
> The only rollback plan we do have currently is to start testing and
> supporting rollback within a major release, e.g. 0.80.8 -> 0.80.7.  We
> (normally) don't add any incompatible changes within a stable release so
> this won't be a major change except that right now none of the downgrade
> scenarios are tested.
>
> sage
>

This makes sense to me.

ric

