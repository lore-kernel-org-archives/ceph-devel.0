From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: jewel backports: cephfs.InvalidValue: error in setxattr
Date: Tue, 16 Aug 2016 10:16:39 +0800
Message-ID: <CAAM7YAkFFPJrJGjeaWdNu8zQqRMAYovbe+dJaLYuscNcKKvwVg@mail.gmail.com>
References: <57B1F22E.7050508@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34890 "EHLO
	mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbcHPCQk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 22:16:40 -0400
Received: by mail-ua0-f178.google.com with SMTP id n59so100550023uan.2
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2016 19:16:40 -0700 (PDT)
In-Reply-To: <57B1F22E.7050508@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 16, 2016 at 12:47 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi John,
>
> http://pulpito.ceph.com/loic-2016-08-15_07:35:11-fs-jewel-backports-distr=
o-basic-smithi/364579/ has the following error:
>
> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:cr=
eate_volume: /volumes/grpid/volid
> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:cr=
eate_volume: grpid/volid, create pool fsvolume_volid as data_isolated =3DTr=
ue.
> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:Tr=
aceback (most recent call last):
> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  =
File "<string>", line 11, in <module>
> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  =
File "/usr/lib/python2.7/dist-packages/ceph_volume_client.py", line 632, in=
 create_volume
> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  =
  self.fs.setxattr(path, 'ceph.dir.layout.pool', pool_name, 0)
> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  =
File "cephfs.pyx", line 779, in cephfs.LibCephFS.setxattr (/srv/autobuild-c=
eph/gitbuilder.git/build/out~/ceph-10.2.2-351-g431d02a/src/build/cephfs.c:1=
0542)
> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:ce=
phfs.InvalidValue: error in setxattr
>

The error is because MDS had outdated osdmap and thought the newly
creately pool does not exist. (MDS has code that makes sure its osdmap
is the same as or newer than fs client's osdmap)  For this case, It
seems both mds and fs client had outdated osdmap.  Pool creation was
through self.rados. self.rados had the newest olsdmap, but self.fs
might have outdated osdmap.

Regards
Yan, Zheng


> This is jewel with a number of CephFS related backports
>
> https://github.com/ceph/ceph/tree/jewel-backports but I can't see which o=
ne could cause that kind of error.
>
> There are a few differences between the jewel and master branch of ceph-q=
a-suite, but it does not seem to be the cause;
>
> git log --no-merges --oneline --cherry-mark --left-right ceph/jewel...cep=
h/master -- suites/fs
>
>> ed1e7f1 suites/fs: fix log whitelist for inotable repair
>> 41e51eb suites: fix asok_dump_tree.yaml
>> c669f1e cephfs: add test for dump tree admin socket command
>> 60dc968 suites/fs: log whitelist for inotable repair
> =3D 1558a48 fs: add snapshot tests to mds thrashing
> =3D b9b18c7 fs: add snapshot tests to mds thrashing
>> dc165e6 cephfs: test fragment size limit
>> 4179c85 suites/fs: use simple messenger some places
>> 367973b cephfs: test readahead is working
>> 795d586 suites/fs/permission: run qa/workunits/fs/misc/{acl.sh,chmod.sh}
>> 45b8e9c suites/fs: fix config for enabling libcephfs posix ACL
> =3D fe74a2c suites: allow four remote clients for fs/recovery
> =3D b970f97 suites: allow four remote clients for fs/recovery
>
> If that rings a bell, let me know. Otherwise I'll keep digging to narrow =
it down.
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
