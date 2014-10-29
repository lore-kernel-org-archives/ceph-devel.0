From: Zack Cerza <zack@redhat.com>
Subject: Re: Initializing paddles
Date: Wed, 29 Oct 2014 17:35:36 -0600
Message-ID: <CAMfdg1NLbccHSdjcmxc7vTD9rJBaSFPg4dGn8H6uH+_ohcXGxw@mail.gmail.com>
References: <544B36D3.8050103@dachary.org>
	<544C3238.7080305@dachary.org>
	<CAMfdg1MHsjbnGqGz3kLJAEOkU-QYN2oxwyvytSNkh+Bkg5UirA@mail.gmail.com>
	<5451722F.8010002@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:39488 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287AbaJ2Xfh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 19:35:37 -0400
Received: by mail-yh0-f46.google.com with SMTP id a41so1090567yho.5
        for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 16:35:36 -0700 (PDT)
In-Reply-To: <5451722F.8010002@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

It's my fault for not documenting the API properly - hopefully once I
get teuthology straightened out I'll get to put more into paddles
documentation.

On Wed, Oct 29, 2014 at 5:03 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Zack,
>
> On 29/10/2014 21:37, Zack Cerza wrote:
>> You should actually be able to POST a json object with a 'name' key
>> (and whichever other ones you want) to /nodes/ !
>
> I completely missed that, thanks :-)
>
> Cheers
>
>> On Sat, Oct 25, 2014 at 5:28 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>>
>>>
>>> On 24/10/2014 22:36, Loic Dachary wrote:
>>>> Hi Zack,
>>>>
>>>> Now that I have a paddles server running, I'd like to populate it =
with two virtual machines I have running. Is there a script to do this =
or should I just type  SQL statements to do that semi-intuitively ?
>>>>
>>>> $ curl 'http://localhost:8080/nodes/?machine_type=3Dvps&count=3D2'
>>>> []
>>>
>>> I tried something like
>>>
>>> for id in 1 2 3 ; do sqlite3 dev.db "insert into nodes (id,name,mac=
hine_type,is_container,is_vm,locked,up,locked_by) values ($id, 'contain=
er00$id', 'plana', 1, 0, 0, 1, 'scheduled');" ; done
>>>
>>> and it works so far (i.e. I'm making progress although I'm not to t=
he point where a machine gets a job yet ;-)
>>>
>>> Cheers
>>>
>>>>
>>>> Cheers
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
