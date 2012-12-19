From: norbi <norbi@rocknob.de>
Subject: Re: deleting non existing pgs ?
Date: Wed, 19 Dec 2012 22:13:00 +0100
Message-ID: <50D22DDC.40709@rocknob.de>
References: <50D226E6.4020708@rocknob.de> <CA+4uBUa1wYYJWaNgTodWLexu45zArKyuzxN9KXdjOP+O2A81NA@mail.gmail.com> <CA+4uBUaETcFoV2BQtsakZa1ZhvLo0rgLyM1vwjubqAvA-g7Cjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:33157 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab2LSVOT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 16:14:19 -0500
In-Reply-To: <CA+4uBUaETcFoV2BQtsakZa1ZhvLo0rgLyM1vwjubqAvA-g7Cjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, ceph-devel@vger.kernel.org

cant bring the osds back, thought that ceph replicates data over hosts 
not only over osds. so i stopped two OSDs on one host, and deleted the 
data/osds, after that i saw the mistake...

On 19.12.2012 22:05, Samuel Just wrote:
> Note, however, that it will render the objects previously stored there
> permanently lost.  Better would be bringing the osds in question back
> up.
> -Sam
>
> On Wed, Dec 19, 2012 at 1:05 PM, Samuel Just <sam.just@inktank.com> wrote:
>> ceph pg force_create_pg <pgid> should cause it to be re-created empty.
>> -Sam
>>
>> On Wed, Dec 19, 2012 at 12:43 PM, norbi <norbi@rocknob.de> wrote:
>>> Hi List,
>>>
>>> how can i delete non existing PGs ?
>>> the OSDs where the PGs was stored are crashed and now i see this
>>>
>>> pg 2.80 is stuck stale for 38971.810705, current state stale+active+clean,
>>> last acting [2,0]
>>> pg 0.82 is stuck stale for 38971.810712, current state stale+active+clean,
>>> last acting [2,0]
>>> pg 1.81 is stuck stale for 38971.810712, current state stale+active+clean,
>>> last acting [2,0]
>>>
>>>
>>> or the osd.log shows me this
>>>
>>> 2012-12-19 21:38:36.771016 7f2e5c518700  7 osd.2 3090 hit non-existent pg
>>> 0.82
>>> 2012-12-19 21:38:36.771024 7f2e5c518700  7 osd.2 3090 we are valid target
>>> for op, waiting
>>> 2012-12-19 21:38:36.771026 7f2e5c518700 15 osd.2 3090
>>> require_same_or_newer_map 3086 (i am 3090) 0x17eec00
>>>
>>>
>>> how can i delete this pgs ?
>>>
>>> norbert
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
