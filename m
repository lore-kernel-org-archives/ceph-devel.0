From: Samuel Just <sjust@redhat.com>
Subject: Re: Dev Meeting followup on compression
Date: Tue, 9 Feb 2016 07:34:57 -0800
Message-ID: <CAN=+7FXJ=CDaEV6msVCMb3v_P55+hUF9yMaEYX3BdQ2boPmjbw@mail.gmail.com>
References: <56B8C37F.9050904@mirantis.com>
	<CAOi1vP9tGqqMVV+GmF4ikmvLecKkT21HVFWB=0Bnc5WCwoNyYA@mail.gmail.com>
	<56B9E8A1.5010805@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35588 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571AbcBIPe5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Feb 2016 10:34:57 -0500
Received: by mail-yw0-f173.google.com with SMTP id g127so128989290ywf.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Feb 2016 07:34:57 -0800 (PST)
In-Reply-To: <56B9E8A1.5010805@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Core standup would be best.  I'll send you an invite.
-Sam

On Tue, Feb 9, 2016 at 5:24 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Ilya,
>
> please find my comments inline.
>
>
> On 08.02.2016 22:23, Ilya Dryomov wrote:
>>
>> On Mon, Feb 8, 2016 at 5:34 PM, Igor Fedotov <ifedotov@mirantis.com>
>> wrote:
>>>
>>> Guys,
>>>
>>> let me summarize what we decided regarding compression support in Ceph
>>> during the Dev Meeting last week.
>>>
>>> Below are possible implementation options, their pros/cons and the
>>> conclusion.
>>>
>>> 1) Add compression support to RGW.
>>> Pros/Cons:
>>> + Simple
>>> + Reduced inter-component traffic
>>> - Limited to specific clients
>>> - Will conflict with partial read/writes if any appear
>>>
>>> Alyona Kiseleva from Mirantis (akyseleva@mirantis.com) will start
>>> implementing this promptly. You can ask additional questions to her via
>>> e-mail or during daily RGW stendups she is planning to attend regularly.
>>>
>>> 2) Add basic compression support to BlueStore. Basic = "Append only"
>>> functionality to be implemented. Specific "append only" hint/flag needs
>>> to
>>> be introduced for object creation interface.
>>>
>>> Pros/Cons:
>>> + Moderate complexity
>>> + Suits for any client/PG backend
>>> + Good isolation from other Ceph components
>>> - Limited applicability
>>> - additional 50-200% CPU load for the cluster since we compress each
>>> replica/EC shard independently
>>> - no inter-component traffic saving
>>> - recovery procedure requires decompress/recompress sequence
>>
>> This is for EC pools only, right?  Can you elaborate on this bullet?
>
> That's for any pool type. When compression takes place at object store level
> and recovery is performed at OSD(PGBackend instance) you need to retrieve an
> object replica from the store ( and hence decompress it ) and subsequently
> compress it back when saving at a new store .
> Contrary having compress/decompress at PGBackend allows to bypass such
> decompress/compress overhead.
>
>>> Mirantis ( me specifically ) will start blueprint/POC creation for this
>>> promptly. I'm planning to attend daily RBD syncup regularly to inform on
>>> the
>>> progress.
>>
>> Core standup and/or the new EC-overwrite meeting Sam is planning on
>> holding is probably a better place for this.
>
> Where can I find a schedule for these meetings?
>
>> Thanks,
>>
>>                  Ilya
>
> Regards,
> Igor
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
