From: Timofey Titovets <nefelim4ag@gmail.com>
Subject: Re: [BUG] rbd hard lookup -> kernel crush by some crush maps
Date: Mon, 11 May 2015 13:59:43 +0300
Message-ID: <CAGqmi762nEN6q3SihXaQg0kCWcDJr2+xfmcdN-zw3jeyzUct9Q@mail.gmail.com>
References: <CAGqmi74aCmT1=ai5sFg1GEQd2MTYzAP8wNnp8uDBh_X2k8D1vw@mail.gmail.com>
 <CAOi1vP-sEmjaxwouBTSyeR=AjqWQSdrNQvMvm-Obkcdu8OeY5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36598 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbEKLAZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 07:00:25 -0400
Received: by wgiu9 with SMTP id u9so124373293wgi.3
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 04:00:24 -0700 (PDT)
In-Reply-To: <CAOi1vP-sEmjaxwouBTSyeR=AjqWQSdrNQvMvm-Obkcdu8OeY5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Year, np

# begin crush map
tunable choose_local_tries 0
tunable choose_local_fallback_tries 0
tunable choose_total_tries 50
tunable chooseleaf_descend_once 1
tunable chooseleaf_vary_r 1
tunable straw_calc_version 1
tunable allowed_bucket_algs 54

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 osd.4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8
device 9 osd.9
device 10 osd.10
device 11 osd.11

# types
type 0 osd
type 1 host
type 2 chassis
type 3 rack
type 4 row
type 5 pdu
type 6 pod
type 7 room
type 8 datacenter
type 9 region
type 10 root

# buckets
host srv-lab-ceph-node-03 {
  id -6 # do not change unnecessarily
  # weight 2.720
  alg straw
  hash 0 # rjenkins1
  item osd.11 weight 0.910
  item osd.8 weight 0.450
  item osd.9 weight 0.450
  item osd.10 weight 0.910
}
host srv-lab-ceph-node-01 {
  id -4 # do not change unnecessarily
  # weight 1.940
  alg straw
  hash 0 # rjenkins1
  item osd.0 weight 0.450
  item osd.1 weight 0.450
  item osd.2 weight 0.130
  item osd.3 weight 0.910
}
host srv-lab-ceph-node-02 {
  id -5 # do not change unnecessarily
  # weight 2.720
  alg straw
  hash 0 # rjenkins1
  item osd.4 weight 0.450
  item osd.5 weight 0.450
  item osd.7 weight 0.910
  item osd.6 weight 0.910
}
rack rack3 {
  id -3 # do not change unnecessarily
  # weight 7.380
  alg straw
  hash 0 # rjenkins1
  item srv-lab-ceph-node-03 weight 2.720
  item srv-lab-ceph-node-01 weight 1.940
  item srv-lab-ceph-node-02 weight 2.720
}
room k402b {
  id -2 # do not change unnecessarily
  # weight 7.380
  alg straw
  hash 0 # rjenkins1
  item rack3 weight 7.380
}
root default {
  id -1 # do not change unnecessarily
  # weight 7.380
  alg straw
  hash 0 # rjenkins1
  item k402b weight 7.380
}

# rules
  rule replicated_ruleset {
  ruleset 0
  type replicated
  min_size 1
  max_size 10
  step take default
  step choose firstn 0 type room
  step choose firstn 0 type rack
  step choose firstn 0 type host
  step chooseleaf firstn 0 type osd
  step emit
}

# end crush map

2015-05-11 12:53 GMT+03:00 Ilya Dryomov <idryomov@gmail.com>:
> On Mon, May 11, 2015 at 12:37 PM, Timofey Titovets <nefelim4ag@gmail.com> wrote:
>> Sorry list, i just can't find how send bugs to tracking system -_-
>>
>> How reporduce:
>> 1. Use crush rule
>> rule replicated_ruleset {
>>   ruleset 0
>>   type replicated
>>   min_size 1
>>   max_size 10
>>   step take default
>>   step choose firstn 0 type room
>>   step choose firstn 0 type rack
>>   step choose firstn 0 type host
>>   step chooseleaf firstn 0 type osd
>>   step emit
>> }
>> 2. inject into cluster
>> 3. do:
>> rbd map <rbd name>
>>
>> crushtool passed test successful, but if you inject map into cluster
>> (i use 0.94.1)
>> All kernel rbd Clients who use rbd map, immadentely crush.
>> i don't know which kernel not affected, but i catch it with 4.0.1
>>
>> With long stucktrace in kernel and message like "Hard lookup detected"
>> Sorry but i realy have a problems with find logs =_=
>
> Can you paste your entire crushmap?
>
> Thanks,
>
>                 Ilya



-- 
Have a nice day,
Timofey.
