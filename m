From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Re: Using RADOS
Date: Wed, 21 Sep 2011 21:05:22 +0530
Message-ID: <CAMiHsJJ_zG8mM6PhH2F8JGFBCHm=WbAxuwzymHt6k=K0aOwhEw@mail.gmail.com>
References: <CAMiHsJ+XqtaBJVAzf3NBPTp3Con-5R0tneyadKB9Nvb9wvWJVQ@mail.gmail.com>
 <1316508609.2671.4.camel@wido-desktop> <CAMiHsJJ6T=MbE2vBa0X+UKeDv1CKQfdVaU95PwQ5oH5wgCGRzQ@mail.gmail.com>
 <CAMiHsJKpvKXG+_ToCXUSkzNiEB4L=kXtWPKpVKNP4Yk3qnXCKg@mail.gmail.com>
 <1316615728.2660.0.camel@wido-laptop> <CAMiHsJL5r8hQbqTA7bZ3CnH25asexD-5efJ5KKg+=-iWyqmTBg@mail.gmail.com>
 <CAMiHsJK3rjNLB4EzM-FRh4dsttEOWCpVo8HETHomGrhuTfoqjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42029 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab1IUPmZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2011 11:42:25 -0400
Received: by bkbzt4 with SMTP id zt4so1593006bkb.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2011 08:42:24 -0700 (PDT)
In-Reply-To: <CAMiHsJK3rjNLB4EzM-FRh4dsttEOWCpVo8HETHomGrhuTfoqjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Wed, Sep 21, 2011 at 8:58 PM, Atish Kathpal <atish.kathpal@gmail.com=
> wrote:
> On Wed, Sep 21, 2011 at 8:39 PM, Atish Kathpal <atish.kathpal@gmail.c=
om> wrote:
>> On Wed, Sep 21, 2011 at 8:05 PM, Wido den Hollander <wido@widodh.nl>=
 wrote:
>>>
>>> Hi,
>>>
>>> On Wed, 2011-09-21 at 18:30 +0530, Atish Kathpal wrote:
>>> > I am referring to the "rados" command line tool in my question.
>>> >
>>> > Regards
>>> > Atish
>>> >
>>> > On Wed, Sep 21, 2011 at 3:14 PM, Atish Kathpal <atish.kathpal@gma=
il.com> wrote:
>>> > > On Tue, Sep 20, 2011 at 2:20 PM, Wido den Hollander <wido@widod=
h.nl> wrote:
>>> > >>
>>> > >> Hi,
>>> > >>
>>> > >> On Tue, 2011-09-20 at 13:14 +0530, Atish Kathpal wrote:
>>> > >> > Hello friends
>>> > >> >
>>> > >> > Since there is no Ceph User's mailing list, I am posting my =
doubt here.
>>> > >> >
>>> > >> > I want to use the Ceph object store capabilities. I have alr=
eady
>>> > >> > installed and setup a Ceph cluster.
>>> > >> >
>>> > >> > As a first step, I want to be able to GET/PUT or read/write =
to the
>>> > >> > object store of my cluster. I would prefer a HTTP/REST inter=
face but
>>> > >> > please let me know of other interfaces that exist for perfor=
ming
>>> > >> > read/writes to ceph object store/RADOS.
>>> > >>
>>> > >> You mean the radosgw? See: http://ceph.newdream.net/wiki/RADOS=
_Gateway
>>> > >>
>>> > >> That should give you a nice HTTP interface to your RADOS objec=
ts. Almost
>>> > >> fully S3 compatible.
>>> > >>
>>> > >> There is also a command-line tool "rados" which you could use,=
 but you
>>> > >> can also write something against librados (C/C++).
>>> > >>
>>> > >
>>> > > I tried using rados. But it does not seem to work.
>>> > >
>>> > > atish@atish-virtual-machine:/etc/ceph$ rados ls
>>> > > 2011-09-21 15:13:32.030505 b7795b50 monclient(hunting):
>>> > > MonClient::init(): Failed to create keyring
>>>
>>> Does the user atish have read access on the ceph.conf? And does it =
also
>>> have access to the keyring.bin file?
>>>
>>> I assume you have cephx enabled?
>>>
>>> Wido
>>>
>>
>> I have given write privileges now to ceph.conf and the ceph.keyriing
>> files. Getting a different error now:-
>>
>
> Hi
>
> *I meant read and write privileges. Infact given 777 privileges. Plea=
se guide.
>
> Regards
> Atish
>
>> atish@atish-virtual-machine:/etc/ceph$ sudo rados put object1 bitmap=
sppt4.bin
>> 2011-09-21 20:33:40.833509 b78d0b50 monclient(hunting): authenticate
>> timed out after 30
>> 2011-09-21 20:33:40.834096 b78d0b50 librados: client.admin
>> authentication error Connection timed out
>> couldn't connect to cluster! error -110
>>
>> In case it helps, I got the following output while setting up the
>> cluster using mkcephs (no errors here):-
>>
>> atish@atish-virtual-machine:/etc/ceph$ sudo =A0mkcephfs -a -c ceph.c=
onf
>> -k ceph.keyring
>> temp dir is /tmp/mkcephfs.zuS8L1yaTI
>> preparing monmap in /tmp/mkcephfs.zuS8L1yaTI/monmap
>> /usr/bin/monmaptool --create --clobber --add alpha 10.72.147.207:678=
9
>> --print /tmp/mkcephfs.zuS8L1yaTI/monmap
>> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.zuS8L1yaTI/monmap
>> /usr/bin/monmaptool: generated fsid 75fdccda-038b-70aa-ed47-04aaa539=
aedf
>> epoch 1
>> fsid 75fdccda-038b-70aa-ed47-04aaa539aedf
>> last_changed 2011-09-21 20:32:47.522913
>> created 2011-09-21 20:32:47.522913
>> 0: 10.72.147.207:6789/0 mon.alpha
>> /usr/bin/monmaptool: writing epoch 1 to
>> /tmp/mkcephfs.zuS8L1yaTI/monmap (1 monitors)
>> =3D=3D=3D osd.0 =3D=3D=3D
>> =A0** WARNING: Ceph is still under development. =A0Any feedback can =
be directed =A0**
>> =A0** =A0 =A0 =A0 =A0 =A0at ceph-devel@vger.kernel.org or http://cep=
h.newdream.net/. =A0 =A0 **
>> 2011-09-21 20:32:49.740368 b77d26e0 created object store
>> /ceph_data/osd.0 journal /ceph_data/osd.0.journal for osd0 fsid
>> 75fdccda-038b-70aa-ed47-04aaa539aedf
>> creating private key for osd.0 keyring /etc/ceph/ceph.keyring
>> creating /etc/ceph/ceph.keyring
>> =3D=3D=3D mds.0 =3D=3D=3D
>> creating private key for mds.0 keyring /etc/ceph/ceph.keyring
>> creating /etc/ceph/ceph.keyring
>> Building generic osdmap
>> =A0highest numbered osd in /tmp/mkcephfs.zuS8L1yaTI/conf is osd.0
>> =A0num osd =3D 1
>> /usr/bin/osdmaptool: osdmap file '/tmp/mkcephfs.zuS8L1yaTI/osdmap'
>> /usr/bin/osdmaptool: writing epoch 1 to /tmp/mkcephfs.zuS8L1yaTI/osd=
map
>> Generating admin key at /tmp/mkcephfs.zuS8L1yaTI/keyring.admin
>> creating /tmp/mkcephfs.zuS8L1yaTI/keyring.admin
>> Building initial monitor keyring
>> added entity mds.0 auth auth(auid =3D 18446744073709551615
>> key=3DAQCa/HlO0AivCRAARY3sVWxwtiOUAupoBsc6yw=3D=3D with 0 caps)
>> added entity osd.0 auth auth(auid =3D 18446744073709551615
>> key=3DAQCZ/HlOoKS4NBAAeVAKe/nSZJy2xPM4Z7BvIw=3D=3D with 0 caps)
>> =3D=3D=3D mon.alpha =3D=3D=3D
>> =A0** WARNING: Ceph is still under development. =A0Any feedback can =
be directed =A0**
>> =A0** =A0 =A0 =A0 =A0 =A0at ceph-devel@vger.kernel.org or http://cep=
h.newdream.net/. =A0 =A0 **
>> /usr/bin/cmon: created monfs at /ceph_data/mon.alpha for mon.alpha
>> placing client.admin keyring in ceph.keyring
>>
>> -Atish
>>
>>> > >
>>> > > Any fixes?
>>> > >
>>> > > Thanks
>>> > > Atish
>>> > >
>>> > >
>>> > >
>>> > >> >
>>> > >> > Final goal: Besides normal read/writes, I also want to be ab=
le to have
>>> > >> > some objects, which point to no data. That is, I want to hav=
e a
>>> > >> > special flag, which if set, would mean there is no data poin=
ted to by
>>> > >> > this Object ID. If its unset, it means its like a normal obj=
ect
>>> > >> > pointing to some data file(s). I want to have the freedom to=
 be able
>>> > >> > to set/unset this flag and hence be able to delete/re-insert=
 the
>>> > >> > corresponding data file(s) against the same object ID. Do we=
 have an
>>> > >> > API which could allow me such functionality?
>>> > >>
>>> > >> No, RADOS is a pretty straight forward API. You have pools whe=
re you
>>> > >> place objects in. Objects can have xattrs and that's about it.
>>> > >>
>>> > >> If you want these kinds of logic you'd have to write your own =
layer over
>>> > >> librados.
>>> > >>
>>> > >> You could set xattr telling a object is empty.
>>> > >>
>>> > >> RADOS is pretty low-level and straight forward. There is not m=
uch logic
>>> > >> in it, no locking or other fancy stuff. Just store objects in =
pools and
>>> > >> make sure they are safe.
>>> > >>
>>> > >> Any other logic should be done by yourself.
>>> > >>
>>> > >> Wido
>>> > >>
>>> > >> >
>>> > >> > Please point me to suitable links/starting points.
>>> > >> >
>>> > >> > Thanks
>>> > >> > Atish
>>> > >> > --
>>> > >> > To unsubscribe from this list: send the line "unsubscribe ce=
ph-devel" in
>>> > >> > the body of a message to majordomo@vger.kernel.org
>>> > >> > More majordomo info at =A0http://vger.kernel.org/majordomo-i=
nfo.html
>>> > >>
>>> > >>
>>> > >
>>>
>>>
>>
>

Hi

The output I have posted above (most recently), is with cephx
disabled, when I try again with 777 privileges on keyring file as well
as ceph.conf and cephx enabled, I get a different error:-

atish@atish-virtual-machine:/etc/ceph$ sudo rados put object1 bitmapspp=
t4.bin
2011-09-21 21:02:32.714547 b7891b50 librados: client.admin
authentication error Operation not permitted
couldn't connect to cluster! error -1

Regards
Atish
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
