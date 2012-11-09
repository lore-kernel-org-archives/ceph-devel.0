From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: some snapshot problems
Date: Fri, 09 Nov 2012 13:42:35 -0800
Message-ID: <509D78CB.20709@inktank.com>
References: <CABFZihudrA640nD9N60b8w0ccQvmaduGmceBf2uHrpLbShtjig@mail.gmail.com> <alpine.DEB.2.00.1211050139280.14104@cobra.newdream.net> <20121109213238.fb1049a8.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42968 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab2KIVnA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 16:43:00 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so3104087pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 13:43:00 -0800 (PST)
In-Reply-To: <20121109213238.fb1049a8.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?Q2zDoXVkaW8gTWFydGlucw==?= <ctpm@ist.utl.pt>
Cc: Sage Weil <sage@inktank.com>, liu yaqi <liuyaqiyaqi@gmail.com>, ceph-devel@vger.kernel.org

On 11/09/2012 01:32 PM, Cl=C3=A1udio Martins wrote:
>
> On Thu, 8 Nov 2012 09:30:55 -0800 (PST) Sage Weil <sage@inktank.com> =
wrote:
>> Lots of different snapshots:
>>
>>   - librados lets you do 'selfmanaged snaps' in its API, which let a=
n
>>     application control which snapshots apply to which objects.
>>   - you can create a 'pool' snapshot on an entire librados pool.  th=
is
>>     cannot be used at the same time as rbd, fs, or the above 'selfma=
naged'
>>     snaps.
>
>   Could you please clarify this? You mean that if a given pool has a
> snapshot created, a subsequent 'rbd snap create' on an image placed i=
n
> that very same pool would fail?

Yes, if you create a pool-wide snapshot, 'rbd snap create' in that pool
would fail. This explains a little about how these work at the rados
level:

https://github.com/ceph/ceph/blob/master/src/include/rados/librados.h#L=
664

>   A quick search through the RADOS and RBD documentation didn't turn
> anything up about this restriction, but I apologize if I missed it.
>
>   Thanks
>
> Cl=C3=A1udio


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
