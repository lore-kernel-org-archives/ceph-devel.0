From: Damien Churchill <damoxc@gmail.com>
Subject: Re: Set object mtime
Date: Mon, 25 Mar 2013 19:24:13 +0000
Message-ID: <CAFtEh-d6r4S+1G1LLhWnzJXhKR1maQXJYrVK8nn+3UjjchoSZw@mail.gmail.com>
References: <CAFtEh-e6GWeU-hP==zPjcXDuxfWkmeZo0wDwY-R82SJR2JZnzQ@mail.gmail.com>
	<5150A306.6030509@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:62815 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758841Ab3CYTYN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 15:24:13 -0400
Received: by mail-pd0-f170.google.com with SMTP id 4so2665762pdd.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 12:24:13 -0700 (PDT)
In-Reply-To: <5150A306.6030509@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 25 March 2013 19:18, Wido den Hollander <wido@42on.com> wrote:
> On 03/25/2013 12:27 PM, Damien Churchill wrote:
>>
>> Does anyone know if it's possible to set an objects mtime at all in RADOS?
>>
>
> You mean with a specific operation while not modifying the content of the
> object?
>
> I checked the rados API, but I couldn't find any method which allows you to
> do so.

Neither could I. I guess the question should be changed to:

How difficult would it be to allow the modification time to be set
(including setting it to a time in the past) without changing the
object?

>
> Wido
>
>> Regards,
>> Damien
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
