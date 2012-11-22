From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: Files lost after mds rebuild
Date: Thu, 22 Nov 2012 15:23:36 +0800
Message-ID: <CAJiejCQ6xemm0hKX5Z2uMFJwvOvptnQsTK7hDTMDc5CU3i-Jpw@mail.gmail.com>
References: <CAJiejCTWvtn6yS+_9h07t4KWqRHPqT-Oe23KtXmnvf7ZZbsAAw@mail.gmail.com>
 <CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com>
 <CAJiejCQt2xVBMzY9q6viYLkXYNrDcmHZP=rcWj+GK+qsYu=XuQ@mail.gmail.com>
 <CAPYLRzhF2hpkqVLk9RQZwffzJz4DhsmwA30PBxOxNJi+HSkf3w@mail.gmail.com>
 <CAJiejCQbbX1p=KpxA_HKT7KhrgOScOBS56Ru-2YWPcsPoZdm4A@mail.gmail.com> <CAPYLRzhpb0cM=fQGizOAS-hLX5P36GkRFjX7ytG9_isaKyC4og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:53536 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab2KVScq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:32:46 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5981281iay.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 10:32:46 -0800 (PST)
In-Reply-To: <CAPYLRzhpb0cM=fQGizOAS-hLX5P36GkRFjX7ytG9_isaKyC4og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/11/22 Gregory Farnum <greg@inktank.com>:
> On Tue, Nov 20, 2012 at 8:28 PM, Drunkard Zhang <gongfan193@gmail.com=
> wrote:
>> 2012/11/21 Gregory Farnum <greg@inktank.com>:
>>> No, absolutely not. There is no relationship between different RADO=
S
>>> pools. If you've been using the cephfs tool to place some filesyste=
m
>>> data in different pools then your configuration is a little more
>>> complicated (have you done that?), but deleting one pool is never
>>> going to remove data from the others.
>>> -Greg
>>>
>> I think that should be a bug. Here's the story I did:
>> I created one directory 'audit' in running ceph filesystem, and put
>> some data into the directory (about 100GB) before these commands:
>> ceph osd pool create audit
>> ceph mds add_data_pool 4
>> cephfs /mnt/temp/audit/ set_layout -p 4
>>
>> log3 ~ # ceph osd dump | grep audit
>> pool 4 'audit' rep size 2 crush_ruleset 0 object_hash rjenkins pg_nu=
m
>> 8 pgp_num 8 last_change 1558 owner 0
>>
>> at this time, all data in audit still usable, after 'ceph osd pool
>> delete data', the disk space recycled (forgot to test if the data
>> still usable), only 200MB used, from 'ceph -s'. So, here's what I'm
>> thinking, the data stored before pool created won't follow the pool,
>> it still follows the default pool 'data', is this a bug, or intended
>> behavior?
>
> Oh, I see. Data is not moved when you set directory layouts; it only
> impacts files created after that point. This is intended behavior =E2=
=80=94
> Ceph would need to copy the data around anyway in order to make it
> follow the pool. There's no sense in hiding that from the user,
> especially given the complexity involved in doing so safely =E2=80=94
> especially when there are many use cases where you want the files in
> different pools.
> -Greg

Got you, but how can I know which pools a file lives in? Is there any c=
ommands?

About data and pools relationship, I thought that objects is hooked to
a pool, when the pool changed, just unhook this and hook to another,
seems I was wrong.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
