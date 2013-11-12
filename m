From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Fwd: Returning the bucket name in RGW response
Date: Mon, 11 Nov 2013 20:37:11 -0800
Message-ID: <CABBk=J_kTz7HL7ynaqbJ0sJ3cnAcLTiPM1jwt0ZHib_07t5VZA@mail.gmail.com>
References: <527A9996.8050402@42on.com>
	<CABBk=J88dNmZUhAki0ZvCd1toG9qg=u9UP5UkeTm3WT_EqL7SA@mail.gmail.com>
	<528140A2.2060909@42on.com>
	<CABBk=J9HUyESppF2L5ABe9dU=yGiY3Z2wfJJsaNgRFBqhdhYNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:46981 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab3KLEhM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 23:37:12 -0500
Received: by mail-vc0-f172.google.com with SMTP id ij19so1490407vcb.31
        for <ceph-devel@vger.kernel.org>; Mon, 11 Nov 2013 20:37:11 -0800 (PST)
In-Reply-To: <CABBk=J9HUyESppF2L5ABe9dU=yGiY3Z2wfJJsaNgRFBqhdhYNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

(resending as plain text)

I'm away and on my phone, I'll make it short. Overall direction is ok.
Run git submodule update because a submodule change snuck in.
I'd move the header dumping into a new RGWOp::pre_exec() callback and
fold the dump_continue() also into it.
Note that dumping bucket is only applicable for the object store api,
so need to take it into account (e.g., do it in the appropriate
subclass of RGWOp).

Yehuda

On Nov 11, 2013 12:40 PM, "Wido den Hollander" <wido@42on.com> wrote:
>
> On 11/06/2013 10:12 PM, Yehuda Sadeh wrote:
>>
>> On Wed, Nov 6, 2013 at 11:33 AM, Wido den Hollander <wido@42on.com> wrote:
>>>
>>> Hi,
>>>
>>> I'm working on a RGW setup where I'm using Varnish[0] to cache objects, but
>>> when doing so you run into the problem that a lot of (cached) requests will
>>> not reach the RGW itself so the accounting of traffic isn't correct.
>>>
>>> To overcome this I've been sending all the logs from Varnish to Logstash[1]
>>> and into ElasticSearch and afterwards analyzing the logs in ElasticSearch to
>>> find out how much traffic each bucket did.
>>>
>>> This method works, but it isn't safe enough. Since I'm currently parsing the
>>> "Host" header to find out which bucket it was, but this isn't always safe
>>> since users can CNAME.
>>>
>>> So I've been playing with the idea to add the "Rgwx-bucket" header to each
>>> response which tells you which bucket the request was made to.
>>>
>>> In Varnish I can catch this response header and send it to Logstash so I
>>> have a safer method of which requests was done by which bucket.
>>>
>>> I'm using Varnish, but you could do the same with nginx or any HTTP caching
>>> proxy.
>>>
>>> Would it be an idea to add this to RGW? I have it running on my system and
>>> it works fine, but it's currently a bit hacky.
>>
>>
>> Yeah, I don't see why not. As long as it's configurable.
>>
>>>
>>> A config variable like "rgw expose bucket" could be false by default, but
>>> when set to true RGW would send the response header with the bucket name.
>>>
>>> How does this sound?
>>
>>
>>
>> Sounds good, just need to see the code now ...
>>
>
> I did it way to complex until I looked at the code again today and came up with a much simpler patch. It's in wip-rgw-expose-bucket now: https://github.com/ceph/ceph/commit/f321471df2703ae706910757a133ab8a13803acb
>
> The dump_bucket_from_state method was already there, but it's not used anywhere. So I modified it a bit to have it honor the configuration boolean.
>
> It writes the header "Bucket" although we might want to change it to Rgwx-Bucket or X-Bucket where I prefer the last one.
>
> The unwritten rule is that when you come up with custom header to prefix it with "X-".
>
> How does this sound?
>
> Wido
>
>>>
>>> P.S.: When this is all up and running I'm planning to make a cool
>>> presentation about this for the next Ceph day.
>>>
>>
>> Awesome!
>>
>> Yehuda
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
