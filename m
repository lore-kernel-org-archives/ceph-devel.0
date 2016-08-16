From: Loic Dachary <loic@dachary.org>
Subject: Re: jewel backports: cephfs.InvalidValue: error in setxattr
Date: Tue, 16 Aug 2016 10:44:26 +0200
Message-ID: <57B2D26A.3080904@dachary.org>
References: <57B1F22E.7050508@dachary.org>
 <CAAM7YAkFFPJrJGjeaWdNu8zQqRMAYovbe+dJaLYuscNcKKvwVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:32914 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcHPIox (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2016 04:44:53 -0400
In-Reply-To: <CAAM7YAkFFPJrJGjeaWdNu8zQqRMAYovbe+dJaLYuscNcKKvwVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Yan,

On 16/08/2016 04:16, Yan, Zheng wrote:
> On Tue, Aug 16, 2016 at 12:47 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi John,
>>
>> http://pulpito.ceph.com/loic-2016-08-15_07:35:11-fs-jewel-backports-distro-basic-smithi/364579/ has the following error:
>>
>> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:create_volume: /volumes/grpid/volid
>> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:create_volume: grpid/volid, create pool fsvolume_volid as data_isolated =True.
>> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:Traceback (most recent call last):
>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  File "<string>", line 11, in <module>
>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  File "/usr/lib/python2.7/dist-packages/ceph_volume_client.py", line 632, in create_volume
>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:    self.fs.setxattr(path, 'ceph.dir.layout.pool', pool_name, 0)
>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  File "cephfs.pyx", line 779, in cephfs.LibCephFS.setxattr (/srv/autobuild-ceph/gitbuilder.git/build/out~/ceph-10.2.2-351-g431d02a/src/build/cephfs.c:10542)
>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:cephfs.InvalidValue: error in setxattr
>>
> 
> The error is because MDS had outdated osdmap and thought the newly
> creately pool does not exist. (MDS has code that makes sure its osdmap
> is the same as or newer than fs client's osdmap)  For this case, It
> seems both mds and fs client had outdated osdmap.  Pool creation was
> through self.rados. self.rados had the newest olsdmap, but self.fs
> might have outdated osdmap.

Interesting. Do you know why this happens ? Is there a specific pull request that causes this ?

Thanks a lot for your help !

> 
> Regards
> Yan, Zheng
> 
> 
>> This is jewel with a number of CephFS related backports
>>
>> https://github.com/ceph/ceph/tree/jewel-backports but I can't see which one could cause that kind of error.
>>
>> There are a few differences between the jewel and master branch of ceph-qa-suite, but it does not seem to be the cause;
>>
>> git log --no-merges --oneline --cherry-mark --left-right ceph/jewel...ceph/master -- suites/fs
>>
>>> ed1e7f1 suites/fs: fix log whitelist for inotable repair
>>> 41e51eb suites: fix asok_dump_tree.yaml
>>> c669f1e cephfs: add test for dump tree admin socket command
>>> 60dc968 suites/fs: log whitelist for inotable repair
>> = 1558a48 fs: add snapshot tests to mds thrashing
>> = b9b18c7 fs: add snapshot tests to mds thrashing
>>> dc165e6 cephfs: test fragment size limit
>>> 4179c85 suites/fs: use simple messenger some places
>>> 367973b cephfs: test readahead is working
>>> 795d586 suites/fs/permission: run qa/workunits/fs/misc/{acl.sh,chmod.sh}
>>> 45b8e9c suites/fs: fix config for enabling libcephfs posix ACL
>> = fe74a2c suites: allow four remote clients for fs/recovery
>> = b970f97 suites: allow four remote clients for fs/recovery
>>
>> If that rings a bell, let me know. Otherwise I'll keep digging to narrow it down.
>>
>> Cheers
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
