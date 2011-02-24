From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: C++ api for librados 0.25
Date: Thu, 24 Feb 2011 10:13:34 -0800
Message-ID: <AANLkTi=RW=AWkDoZsM8TsKdZP+6AJNCfwdJ2SKtU3oVV@mail.gmail.com>
References: <AANLkTin3gXaBv1y+MPEvJVxNYVhtJdkqtzf+1vp=XApw@mail.gmail.com>
	<4D669D48.6060202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45979 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab1BXSV7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 13:21:59 -0500
Received: by fxm17 with SMTP id 17so828507fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Feb 2011 10:21:58 -0800 (PST)
In-Reply-To: <4D669D48.6060202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 24, 2011 at 10:02 AM, Josh Durgin <josh.durgin@dreamhost.co=
m> wrote:
> On 02/23/2011 11:11 PM, Colin McCabe wrote:
>> Here is the proposed C++ API for librados 0.25.
>> The main changes are that I created class Pool, class Snap, and the
>> ObjectIterator interface.
>
> I like the idea of a more OO interface. This will allow easily
> stacking librbd on top of librados, eliminating the need for a
> separate librbd pool type.
>
> I have a couple suggestions:
>
> - The pool_t parameters in the self-managed snap methods can be
> =A0removed, since they're part of the Pool class.
>
> - The aio_read/write functions can be members of Pool instead of
> =A0having a pool_t parameter.

Yeah.

> - aio_create_completion could be moved into Pool since it's only
> =A0used within the context of a pool. (librbd would need this unless
> =A0Pool had a get_rados method).

Hmm. I'm not seeing the pool dependency for aio_create_completion. It
looks like this has nothing to do with any particular pool. It's just
a callback?

>
> Also, what is the constructor Pool(Rados *rados_, pool_t *pool_)
> intended to be used for? I don't see a method to get a pool_t from
> this API.

Rados has to create Pools somehow, and that means they need a construct=
or.

It could be hidden deeper using the usual C++ bag of tricks (like
private constructors and friend functions), but it didn't seem
necessary.

Colin


>
> -Josh Durgin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
