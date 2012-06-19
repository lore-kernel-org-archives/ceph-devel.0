From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Error creating journal during mkcephfs
Date: Tue, 19 Jun 2012 13:13:07 -0400
Message-ID: <CACkq2mpbU08VpDd1HZSE+xJgw3FHPp4tfWRn8_kkmULm+SXcSg@mail.gmail.com>
References: <CACkq2mqsUFoqJnQNw7VgTPChd2w2b7u7ZYqNWZ7gYsLssKVeVA@mail.gmail.com>
 <Pine.LNX.4.64.1206191008110.21853@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53074 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab2FSRN3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 13:13:29 -0400
Received: by bkcji2 with SMTP id ji2so5336658bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 10:13:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206191008110.21853@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Great!  Thanks, that was it.  I did see mention of that param in the
mailing list, and thought that might be it.  But I failed to find that
option in the docs here:
http://ceph.com/docs/master/config-ref/osd-config/

So I wasn't sure where to put it.  =3D)

Thanks again.

On Tue, Jun 19, 2012 at 1:08 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 19 Jun 2012, Travis Rhoden wrote:
>> I almost posted this to http://tracker.newdream.net/issues/2595, but
>> didn't want to piggy-back on an issue marked resolved.
>>
>> When I run mkcephfs, I get:
>>
>> 2012-06-19 09:36:29.211737 7fc7021d7780 -1 journal FileJournal::_ope=
n:
>> unable to open journal: open() failed: (22) Invalid argument
>> 2012-06-19 09:36:29.211827 7fc7021d7780 -1 OSD::mkfs: FileStore::mkf=
s
>> failed with error -22
>> 2012-06-19 09:36:29.211852 7fc7021d7780 -1 =A0** ERROR: error creati=
ng
>> empty object store in /srv/osd.0: (22) Invalid argument
>
> By default the journal code uses O_DIRECT, which tmpfs does not suppo=
rt.
> Try adding
>
> =A0 =A0 =A0 =A0journal dio =3D false
>
> to the [osd] section and see if that helps!
>
> sage
>
>
>>
>> I'm running 0.47.2 on Ubuntu 12.04. =A0Here is the osd section of my=
 ceph.conf:
>>
>> [osd]
>> =A0 =A0 =A0 =A0 osd data =3D /srv/osd.$id
>> =A0 =A0 =A0 =A0 osd journal =3D /tmpfs/osd.$id.journal
>> =A0 =A0 =A0 =A0 osd journal size =3D 1000
>> =A0 =A0 =A0 =A0 filestore fiemap =3D false
>> =A0 =A0 =A0 =A0 ; uncomment the following line if you are mounting w=
ith ext4
>> =A0 =A0 =A0 =A0 ; filestore xattr use omap =3D true
>> =A0 =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.$name
>>
>>
>> The problem arose when I was trying to move my journals onto tmpfs. =
=A0I
>> blew away my old cluster (I'm just testing different configs), and
>> then hit this when I tried to make a new one. =A0The reason I think =
this
>> is differen than issue # 2595 is that my mkcephfs does NOT succeed,
>> whereas the other user's did. =A0The journal file at
>> /tmpfs/osd.$id/journal does get created but it is 0 bytes.
>>
>> # ls -al /tmpfs
>> total 4
>> drwxrwxrwt =A02 root root =A0 60 Jun 19 09:36 .
>> drwxr-xr-x 24 root root 4096 Jun 19 09:08 ..
>> -rw-r--r-- =A01 root root =A0 =A00 Jun 19 09:36 osd.0.journal
>>
>> # df -h /tmpfs
>> Filesystem =A0 =A0 =A0 =A0 =A0 =A0 Size =A0Used Avail Use% Mounted o=
n
>> tmpfs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02.5G =A0 =A0 0 =A02.5G =A0 =
0% /tmpfs
>>
>> My tmpfs looks like this:
>>
>> # mount | grep tmpfs
>> tmpfs on /tmpfs type tmpfs (rw,size=3D2560m)
>>
>> I threw debug filestore =3D 20 into ceph.conf and capture this in th=
e log file:
>>
>> 2012-06-19 09:36:28.888220 7fc7021d7780 =A01 filestore(/srv/osd.0) m=
kfs
>> in /srv/osd.0
>> 2012-06-19 09:36:28.888379 7fc7021d7780 =A00 filestore(/srv/osd.0) m=
kfs
>> removing old directory current
>> 2012-06-19 09:36:28.890923 7fc7021d7780 =A00 filestore(/srv/osd.0) m=
kfs
>> removing old file store_version
>> 2012-06-19 09:36:28.911798 7fc7021d7780 10 filestore(/srv/osd.0) mkf=
s
>> fsid is 52ab0ff0-bb36-472d-93d5-7a02f0dfa5e5
>> 2012-06-19 09:36:28.911892 7fc7021d7780 =A02 filestore(/srv/osd.0)
>> BTRFS_IOC_SUBVOL_CREATE ioctl failed, trying mkdir /srv/osd.0/curren=
t
>> 2012-06-19 09:36:29.211668 7fc7021d7780 -1 filestore(/srv/osd.0)
>> leveldb db created
>> 2012-06-19 09:36:29.211700 7fc7021d7780 10 filestore(/srv/osd.0)
>> open_journal at /tmpfs/osd.0.journal
>> 2012-06-19 09:36:29.211737 7fc7021d7780 -1 journal FileJournal::_ope=
n:
>> unable to open journal: open() failed: (22) Invalid argument
>> 2012-06-19 09:36:29.211814 7fc7021d7780 =A00 filestore(/srv/osd.0)
>> mkjournal error creating journal on /tmpfs/osd.0.journal
>> 2012-06-19 09:36:29.211827 7fc7021d7780 -1 OSD::mkfs: FileStore::mkf=
s
>> failed with error -22
>> 2012-06-19 09:36:29.211852 7fc7021d7780 -1 ^[[0;31m ** ERROR: error
>> creating empty object store in /srv/osd.0: (22) Invalid argument^[[0=
m
>>
>>
>> The OSD that I am working with was used before in my old cluster, bu=
t
>> I blew it away first by unmounting and reformatting the partition (
>> just a simple 'mkfs.xfs /dev/md0' ). =A0The device is software RAID =
0.
>> Again, I'm just playing with configs to see what the fastest
>> performance i can get out of my hardware is. =A0It seemed like maybe=
 the
>> journal was holding me back, so I'm trying to move it to /tmpfs.
>>
>> I feel like I'm missing something obvious.
>>
>> =A0- Travis
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
