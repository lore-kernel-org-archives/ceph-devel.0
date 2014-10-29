From: Zack Cerza <zack@redhat.com>
Subject: Re: Initializing paddles
Date: Wed, 29 Oct 2014 14:37:43 -0600
Message-ID: <CAMfdg1MHsjbnGqGz3kLJAEOkU-QYN2oxwyvytSNkh+Bkg5UirA@mail.gmail.com>
References: <544B36D3.8050103@dachary.org>
	<544C3238.7080305@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38874 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622AbaJ2Uho convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 16:37:44 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so3069855obc.18
        for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 13:37:44 -0700 (PDT)
In-Reply-To: <544C3238.7080305@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

You should actually be able to POST a json object with a 'name' key
(and whichever other ones you want) to /nodes/ !

On Sat, Oct 25, 2014 at 5:28 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 24/10/2014 22:36, Loic Dachary wrote:
>> Hi Zack,
>>
>> Now that I have a paddles server running, I'd like to populate it wi=
th two virtual machines I have running. Is there a script to do this or=
 should I just type  SQL statements to do that semi-intuitively ?
>>
>> $ curl 'http://localhost:8080/nodes/?machine_type=3Dvps&count=3D2'
>> []
>
> I tried something like
>
> for id in 1 2 3 ; do sqlite3 dev.db "insert into nodes (id,name,machi=
ne_type,is_container,is_vm,locked,up,locked_by) values ($id, 'container=
00$id', 'plana', 1, 0, 0, 1, 'scheduled');" ; done
>
> and it works so far (i.e. I'm making progress although I'm not to the=
 point where a machine gets a job yet ;-)
>
> Cheers
>
>>
>> Cheers
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
