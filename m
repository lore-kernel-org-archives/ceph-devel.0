From: Samuel Just <sam.just@inktank.com>
Subject: Re: deleting non existing pgs ?
Date: Wed, 19 Dec 2012 13:38:15 -0800
Message-ID: <CA+4uBUYz9LGx36+QpL3ON59hgOgZqP=JyWFshnDmXO2KxQ+pSg@mail.gmail.com>
References: <50D226E6.4020708@rocknob.de>
	<CA+4uBUa1wYYJWaNgTodWLexu45zArKyuzxN9KXdjOP+O2A81NA@mail.gmail.com>
	<CA+4uBUaETcFoV2BQtsakZa1ZhvLo0rgLyM1vwjubqAvA-g7Cjg@mail.gmail.com>
	<50D22DDC.40709@rocknob.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33097 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab2LSViQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 16:38:16 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so2863946vcd.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 13:38:15 -0800 (PST)
In-Reply-To: <50D22DDC.40709@rocknob.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: norbi <norbi@rocknob.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ceph can be configured that way using crush.  See
http://ceph.com/docs/master/rados/operations/crush-map/
-Sam

On Wed, Dec 19, 2012 at 1:13 PM, norbi <norbi@rocknob.de> wrote:
> cant bring the osds back, thought that ceph replicates data over hosts not
> only over osds. so i stopped two OSDs on one host, and deleted the
> data/osds, after that i saw the mistake...
>
>
> On 19.12.2012 22:05, Samuel Just wrote:
>>
>> Note, however, that it will render the objects previously stored there
>> permanently lost.  Better would be bringing the osds in question back
>> up.
>> -Sam
>>
>> On Wed, Dec 19, 2012 at 1:05 PM, Samuel Just <sam.just@inktank.com> wrote:
>>>
>>> ceph pg force_create_pg <pgid> should cause it to be re-created empty.
>>> -Sam
>>>
>>> On Wed, Dec 19, 2012 at 12:43 PM, norbi <norbi@rocknob.de> wrote:
>>>>
>>>> Hi List,
>>>>
>>>> how can i delete non existing PGs ?
>>>> the OSDs where the PGs was stored are crashed and now i see this
>>>>
>>>> pg 2.80 is stuck stale for 38971.810705, current state
>>>> stale+active+clean,
>>>> last acting [2,0]
>>>> pg 0.82 is stuck stale for 38971.810712, current state
>>>> stale+active+clean,
>>>> last acting [2,0]
>>>> pg 1.81 is stuck stale for 38971.810712, current state
>>>> stale+active+clean,
>>>> last acting [2,0]
>>>>
>>>>
>>>> or the osd.log shows me this
>>>>
>>>> 2012-12-19 21:38:36.771016 7f2e5c518700  7 osd.2 3090 hit non-existent
>>>> pg
>>>> 0.82
>>>> 2012-12-19 21:38:36.771024 7f2e5c518700  7 osd.2 3090 we are valid
>>>> target
>>>> for op, waiting
>>>> 2012-12-19 21:38:36.771026 7f2e5c518700 15 osd.2 3090
>>>> require_same_or_newer_map 3086 (i am 3090) 0x17eec00
>>>>
>>>>
>>>> how can i delete this pgs ?
>>>>
>>>> norbert
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
