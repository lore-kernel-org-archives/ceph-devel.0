From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: C++ api for librados 0.25
Date: Thu, 24 Feb 2011 15:20:55 -0800
Message-ID: <AANLkTikWG5=hat5WgfFi0nXjswGazCPb=Cn_D3guMapO@mail.gmail.com>
References: <AANLkTin3gXaBv1y+MPEvJVxNYVhtJdkqtzf+1vp=XApw@mail.gmail.com>
	<4D669D48.6060202@dreamhost.com>
	<AANLkTi=RW=AWkDoZsM8TsKdZP+6AJNCfwdJ2SKtU3oVV@mail.gmail.com>
	<4D66A5A9.4050107@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37096 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756605Ab1BXXVx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 18:21:53 -0500
Received: by fxm17 with SMTP id 17so1114932fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Feb 2011 15:21:52 -0800 (PST)
In-Reply-To: <4D66A5A9.4050107@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Updated API at http://ceph.newdream.net/git/?p=3Dceph.git;a=3Dblob;f=3D=
src/include/rados/librados.hpp;h=3D29dec7a3143b4233fd7eb365c1e26fd3409b=
a6bb;hb=3Dlibrados_api_cpp

C.


On Thu, Feb 24, 2011 at 10:38 AM, Josh Durgin <josh.durgin@dreamhost.co=
m> wrote:
> On 02/24/2011 10:13 AM, Colin McCabe wrote:
>> On Thu, Feb 24, 2011 at 10:02 AM, Josh Durgin <josh.durgin@dreamhost=
=2Ecom> wrote:
>>> - aio_create_completion could be moved into Pool since it's only
>>> =A0used within the context of a pool. (librbd would need this unles=
s
>>> =A0Pool had a get_rados method).
>>
>> Hmm. I'm not seeing the pool dependency for aio_create_completion. I=
t
>> looks like this has nothing to do with any particular pool. It's jus=
t
>> a callback?
>
> My thinking was that the only reason for creating one is for doing ai=
o, which is done on a pool.
>
> Looking at the implementation, however, there's no dependency on the =
RadosClient at all.
> These could just be constructors of AioCompletion (in the interface a=
nd implementation).
>
> -Josh Durgin
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
