From: AnnyRen <annyren6@gmail.com>
Subject: Re: one question about cephfs disk usage
Date: Wed, 3 Aug 2011 13:29:47 +0800
Message-ID: <CADF7qQUUYgHXsR538J8TG8TxTT7Q1_t3a=0SN1Sx_9JgKuoDKA@mail.gmail.com>
References: <CADF7qQV1gcaKiuTHt9fY3jpOYZRBUx6X-bn_SCp-0th2VrDeNQ@mail.gmail.com>
	<CAF3hT9AEtR1jRppaxtZCnb09o=AoNE1FHJX5P_YmvQZTFNfY1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36270 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab1HCF3s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2011 01:29:48 -0400
Received: by iyb12 with SMTP id 12so595469iyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Aug 2011 22:29:47 -0700 (PDT)
In-Reply-To: <CAF3hT9AEtR1jRppaxtZCnb09o=AoNE1FHJX5P_YmvQZTFNfY1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Thanks for the explanation!  :)

2011/8/3 Gregory Farnum <gregory.farnum@dreamhost.com>:
> On Tue, Aug 2, 2011 at 12:30 AM, AnnyRen <annyren6@gmail.com> wrote:
>> Total data size in cephfs is 15.5 GB.
>>
>> I run "ceph -s" to check the file system usage, it shows:
>>
>> root@MON1:~# ceph -s
>> 2011-08-02 15:12:03.476151 =A0 =A0pg v946: 1782 pgs: 1782 active+cle=
an;
>> 15995 MB data, 33880 MB used, 38859 GB / 40974 GB avail
>> 2011-08-02 15:12:03.480076 =A0 mds e10: 1/1/1 up {0=3Da=3Dup:active}
>> 2011-08-02 15:12:03.480113 =A0 osd e7: 9 osds: 9 up, 9 in
>> 2011-08-02 15:12:03.480183 =A0 log 2011-08-02 14:12:32.391116 mon0
>> 192.168.10.1:6789/0 13 : [INF] mds0 192.168.10.2:6800/1716 up:act
>> 2011-08-02 15:12:03.480263 =A0 mon e1: 1 mons at {a=3D192.168.10.1:6=
789/0}
>>
>>
>> but when I remove all the file in ceph FS using
>>
>> root@MON1:~# rm -rf /mnt/ceph/0802_*
>>
>>
>> I check ceph data used again with ceph -s
>>
>> root@MON1:~# ceph -s
>> 2011-08-02 15:20:05.265826 =A0 =A0pg v958: 1782 pgs: 1782 active+cle=
an;
>> 6779 MB data, 15428 MB used, 38877 GB / 40974 GB avail
>> 2011-08-02 15:20:05.269863 =A0 mds e10: 1/1/1 up {0=3Da=3Dup:active}
>> 2011-08-02 15:20:05.269900 =A0 osd e7: 9 osds: 9 up, 9 in
>> 2011-08-02 15:20:05.269965 =A0 log 2011-08-02 14:12:32.391116 mon0
>> 192.168.10.1:6789/0 13 : [INF] mds0 192.168.10.2:6800/1716 up:act
>> 2011-08-02 15:20:05.270045 =A0 mon e1: 1 mons at {a=3D192.168.10.1:6=
789/0}
>>
>> Make sure that all files are deleted....
>>
>> root@MON1:~# ls -lh /mnt/ceph/
>> total 0
>>
>>
>> Is there anyone know why it still shows {6779 MB data, 15428 MB used=
} =A0?
>> 6779 MB data means?
>>
>> Thanks for your help. :-)
>>
>> Best Regard,
>> Anny
>
> When you delete a file, it doesn't actually clear out the data right
> away for a couple reasons[1]. Instead, it's marked as deleted on the
> MDS and the MDS goes through and removes the objects storing it as
> time is available. If you clear out the whole FS, this can naturally
> take awhile since it requires a number of messages proportional to
> amount of data in the cluster. If you look at your data usage again
> you'll probably see it's lower now.
> Some of the space is also used by the MDS journals (generally 100MB
> for each MDS), and depending on how your storage is set up you might
> also be seeing OSD journals in that space used (along with any other
> files you have on the same partition as your OSD data store). This
> should explain why you've got a bit of extra used space that isn't
> just for replicating the FS data. :)
> -Greg
> [1] Two important reasons. First one is that there might be other
> references to the objects in question due to snapshots, in which case
> you don't want to erase the data -- especially since the client doing
> the erasing might not know about these snapshots.
> Second one is that to delete the data you need to send out a message
> for each object -- ie, for every file you get one object and for ever=
y
> file >4MB you get an object for each 4MB (and it's replicated, so
> multiply by two or three for everything!). On a large tree this can
> take awhile and you might not want the client to be spending its time
> and bandwidth on such a user-useless activity.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
