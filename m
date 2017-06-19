From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM
 volumes
Date: Mon, 19 Jun 2017 20:57:07 +0200
Message-ID: <22e79c3c-848c-a675-74fb-8e1986d9edd5@digiware.nl>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com>
 <626e190c-fa2a-71d2-980a-49ddd2770eb9@digiware.nl>
 <CAC-Np1y=0wkOHvGDHaxyZ+0jesQ_64TX2fvrMLaRkWOoLC6OsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:18517 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdFSS5M (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Jun 2017 14:57:12 -0400
In-Reply-To: <CAC-Np1y=0wkOHvGDHaxyZ+0jesQ_64TX2fvrMLaRkWOoLC6OsQ@mail.gmail.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: John Spray <jspray@redhat.com>, Warren Wang - ISD <Warren.Wang@walmart.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>



Op 19-6-2017 om 19:57 schreef Alfredo Deza:
> On Mon, Jun 19, 2017 at 11:37 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 19-6-2017 16:13, Alfredo Deza wrote:
>>> On Mon, Jun 19, 2017 at 9:27 AM, John Spray <jspray@redhat.com> wrote:
>>>> On Fri, Jun 16, 2017 at 7:23 PM, Alfredo Deza <adeza@redhat.com> wrote:
>>>>> On Fri, Jun 16, 2017 at 2:11 PM, Warren Wang - ISD
>>>>> <Warren.Wang@walmart.com> wrote:
>>>>>
>> I would just try to glue it into ceph-disk in the most flexible way
> We can't "glue it into ceph-disk" because we are proposing a
> completely new way of doing things that
> go against how ceph-disk works.

'mmm,

Not really a valid argument if you want the 2 to become equal.

I have limited python knowledge, but I can envision an outer wrapper 
that just call
the old version of ceph-disk as an external executable. User impact is 
thus reduced
to bare minimum.

Got admit that it is not very elegant, but it would work.

But I'll see what you guys come up with.
Best proof is always the code.

--WjW

