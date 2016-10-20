From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Building for Clang is broken for snap-types
Date: Thu, 20 Oct 2016 10:53:04 -0600
Message-ID: <CAJ4mKGbAjqUR1HNEm88e3ZO+Px64Gz+2aVqMq0jkJGCU--xrYg@mail.gmail.com>
References: <0e42917f-707d-a5a2-141a-6c5c971ff021@digiware.nl>
 <CAJE9aOP7gYJzgZaT25bJy1y8nOS8Hqmmb0wttc63KN+hg=AoTA@mail.gmail.com>
 <d2873553-7338-dc43-c98d-2ce0e6a7c956@digiware.nl> <13220e29-4827-c2c9-5c88-0f4a88c2c244@digiware.nl>
 <1dd0cd11-aa96-5d53-5623-bfe856ffd6ff@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33183 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbcJTQxH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2016 12:53:07 -0400
Received: by mail-yw0-f171.google.com with SMTP id t192so61820082ywf.0
        for <ceph-devel@vger.kernel.org>; Thu, 20 Oct 2016 09:53:06 -0700 (PDT)
In-Reply-To: <1dd0cd11-aa96-5d53-5623-bfe856ffd6ff@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 20, 2016 at 3:21 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 20-10-2016 02:49, Willem Jan Withagen wrote:
>> On 20-10-2016 02:21, Willem Jan Withagen wrote:
>>> On 19-10-2016 20:58, kefu chai wrote:
>>>> should have been fixed in master.
>>>
>>> Ehh,
>>>
>>> Not really.
>>> Just tested by running
>>> cd Ceph/master/ceph
>>> git pull
>>> ./do_freebsd.sh
>>>
>>> And I still get the same error.
>>>
>>> Guess I'll have to start bisecting to see where it went wrong.
>>
>> This is the actual commit going wrong
>>
>> commit c9c5235ef7d563b92f44dab63a8ac2b694e69d4f
>> Author: Sage Weil <sage@redhat.com>
>> Date:   Wed Sep 14 13:32:20 2016 -0400
>>
>>     include/object: conditional denc_traits for snapid_t
>>
>>     Signed-off-by: Sage Weil <sage@redhat.com>
>
> This all was in pull #11027
> Last commit that works is: dec0f05288dc4fce0f5ae2de7cf4dd8f9281fe1f
>
> That code is changing all kind of templates... And to be honest, I not
> very comfortable with that.
>
> But obviously GCC seems to able to promote type
>         'const vector<snapid_t>'
> in such a way that it can find a matching function, where as Clang is
> being more selective (as usual)

That's odd; isn't snapid_t a typedef for uint64_t?
There are a few things like that which are wrapped structs with
implicit conversions, in which case maybe it needs to be defined more
clearly for Clang in this case, or just give it an explicit template
wrapper pointing at le64 (or whichever one it's supposed to be).
-Greg

>
> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
