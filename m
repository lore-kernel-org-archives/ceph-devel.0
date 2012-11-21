From: Gregory Farnum <greg@inktank.com>
Subject: Re: Files lost after mds rebuild
Date: Wed, 21 Nov 2012 11:13:27 -0800
Message-ID: <CAPYLRzhpb0cM=fQGizOAS-hLX5P36GkRFjX7ytG9_isaKyC4og@mail.gmail.com>
References: <CAJiejCTWvtn6yS+_9h07t4KWqRHPqT-Oe23KtXmnvf7ZZbsAAw@mail.gmail.com>
	<CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com>
	<CAJiejCQt2xVBMzY9q6viYLkXYNrDcmHZP=rcWj+GK+qsYu=XuQ@mail.gmail.com>
	<CAPYLRzhF2hpkqVLk9RQZwffzJz4DhsmwA30PBxOxNJi+HSkf3w@mail.gmail.com>
	<CAJiejCQbbX1p=KpxA_HKT7KhrgOScOBS56Ru-2YWPcsPoZdm4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64795 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab2KUTN2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 14:13:28 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so802281iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Nov 2012 11:13:28 -0800 (PST)
In-Reply-To: <CAJiejCQbbX1p=KpxA_HKT7KhrgOScOBS56Ru-2YWPcsPoZdm4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 20, 2012 at 8:28 PM, Drunkard Zhang <gongfan193@gmail.com> =
wrote:
> 2012/11/21 Gregory Farnum <greg@inktank.com>:
>> No, absolutely not. There is no relationship between different RADOS
>> pools. If you've been using the cephfs tool to place some filesystem
>> data in different pools then your configuration is a little more
>> complicated (have you done that?), but deleting one pool is never
>> going to remove data from the others.
>> -Greg
>>
> I think that should be a bug. Here's the story I did:
> I created one directory 'audit' in running ceph filesystem, and put
> some data into the directory (about 100GB) before these commands:
> ceph osd pool create audit
> ceph mds add_data_pool 4
> cephfs /mnt/temp/audit/ set_layout -p 4
>
> log3 ~ # ceph osd dump | grep audit
> pool 4 'audit' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
> 8 pgp_num 8 last_change 1558 owner 0
>
> at this time, all data in audit still usable, after 'ceph osd pool
> delete data', the disk space recycled (forgot to test if the data
> still usable), only 200MB used, from 'ceph -s'. So, here's what I'm
> thinking, the data stored before pool created won't follow the pool,
> it still follows the default pool 'data', is this a bug, or intended
> behavior?

Oh, I see. Data is not moved when you set directory layouts; it only
impacts files created after that point. This is intended behavior =97
Ceph would need to copy the data around anyway in order to make it
follow the pool. There's no sense in hiding that from the user,
especially given the complexity involved in doing so safely =97
especially when there are many use cases where you want the files in
different pools.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
