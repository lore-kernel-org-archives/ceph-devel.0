From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Dev Meeting followup on compression
Date: Tue, 9 Feb 2016 16:24:49 +0300
Message-ID: <56B9E8A1.5010805@mirantis.com>
References: <56B8C37F.9050904@mirantis.com>
 <CAOi1vP9tGqqMVV+GmF4ikmvLecKkT21HVFWB=0Bnc5WCwoNyYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35221 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbcBINYw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Feb 2016 08:24:52 -0500
Received: by mail-lf0-f41.google.com with SMTP id l143so115384611lfe.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Feb 2016 05:24:51 -0800 (PST)
In-Reply-To: <CAOi1vP9tGqqMVV+GmF4ikmvLecKkT21HVFWB=0Bnc5WCwoNyYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ilya,

please find my comments inline.

On 08.02.2016 22:23, Ilya Dryomov wrote:
> On Mon, Feb 8, 2016 at 5:34 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>> Guys,
>>
>> let me summarize what we decided regarding compression support in Ceph
>> during the Dev Meeting last week.
>>
>> Below are possible implementation options, their pros/cons and the
>> conclusion.
>>
>> 1) Add compression support to RGW.
>> Pros/Cons:
>> + Simple
>> + Reduced inter-component traffic
>> - Limited to specific clients
>> - Will conflict with partial read/writes if any appear
>>
>> Alyona Kiseleva from Mirantis (akyseleva@mirantis.com) will start
>> implementing this promptly. You can ask additional questions to her via
>> e-mail or during daily RGW stendups she is planning to attend regularly.
>>
>> 2) Add basic compression support to BlueStore. Basic = "Append only"
>> functionality to be implemented. Specific "append only" hint/flag needs to
>> be introduced for object creation interface.
>>
>> Pros/Cons:
>> + Moderate complexity
>> + Suits for any client/PG backend
>> + Good isolation from other Ceph components
>> - Limited applicability
>> - additional 50-200% CPU load for the cluster since we compress each
>> replica/EC shard independently
>> - no inter-component traffic saving
>> - recovery procedure requires decompress/recompress sequence
> This is for EC pools only, right?  Can you elaborate on this bullet?
That's for any pool type. When compression takes place at object store 
level and recovery is performed at OSD(PGBackend instance) you need to 
retrieve an object replica from the store ( and hence decompress it ) 
and subsequently compress it back when saving at a new store .
Contrary having compress/decompress at PGBackend allows to bypass such 
decompress/compress overhead.

>> Mirantis ( me specifically ) will start blueprint/POC creation for this
>> promptly. I'm planning to attend daily RBD syncup regularly to inform on the
>> progress.
> Core standup and/or the new EC-overwrite meeting Sam is planning on
> holding is probably a better place for this.
Where can I find a schedule for these meetings?

> Thanks,
>
>                  Ilya
Regards,
Igor
