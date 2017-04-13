From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Thu, 13 Apr 2017 16:23:12 +0200
Message-ID: <d4bde447-f179-aeca-bac5-636fa40ccba5@corp.ovh.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
 <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 3.mo302.mail-out.ovh.net ([137.74.110.76]:40965 "EHLO
        3.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbdDMOXP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Apr 2017 10:23:15 -0400
In-Reply-To: <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/06/2017 03:25 PM, Sage Weil wrote:
> On Thu, 6 Apr 2017, Piotr Dałek wrote:
>> Hello,
>>
>> We recently had an interesting issue with RBD images and filestore on Jewel
>> 10.2.5:
>> We have a pool with RBD images, all of them mostly untouched (large areas of
>> those images unused), and once we added 3 new OSDs to cluster, objects
>> representing these images grew substantially on new OSDs: objects hosting
>> unused areas of these images on original OSDs remained small (~8K of space
>> actually used, 4M allocated), but on new OSDs were large (4M allocated *and*
>> actually used). After investigation we concluded that Ceph didn't propagate
>> sparse file information during cluster rebalance, resulting in correct data
>> contents on all OSDs, but no sparse file data on new OSDs, hence disk space
>> usage increase on those.
>>
>> Example on test cluster, before growing it by one OSD:
>>
>> ls:
>>
>> osd-01-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
>> /var/lib/ceph/osd-01-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>> osd-02-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
>> /var/lib/ceph/osd-02-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>> osd-03-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
>> /var/lib/ceph/osd-03-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>>
>> du:
>>
>> osd-01-cluster: 12
>> /var/lib/ceph/osd-01-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>> osd-02-cluster: 12
>> /var/lib/ceph/osd-02-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>> osd-03-cluster: 12
>> /var/lib/ceph/osd-03-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>>
>>
>> mon-01-cluster:~ # rbd diff test
>> Offset   Length  Type
>> 8388608  4194304 data
>> 16777216 4096    data
>> 33554432 4194304 data
>> 37748736 2048    data
>>
>> And after growing it:
>>
>> ls:
>>
>> clush> find /var/lib/ceph/osd-*/current/0.*head/ -type f -name '*data*' -exec
>> ls -l {} \+
>> osd-02-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
>> /var/lib/ceph/osd-02-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>> osd-03-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
>> /var/lib/ceph/osd-03-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>> osd-04-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:25
>> /var/lib/ceph/osd-04-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>>
>> du:
>>
>> clush> find /var/lib/ceph/osd-*/current/0.*head/ -type f -name '*data*' -exec
>> du -k {} \+
>> osd-02-cluster: 12
>> /var/lib/ceph/osd-02-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>> osd-03-cluster: 12
>> /var/lib/ceph/osd-03-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>> osd-04-cluster: 4100
>> /var/lib/ceph/osd-04-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
>>
>> Note that "rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0" grew
>> from 12 to 4100KB when copied from other OSDs to osd-04.
>>
>> Is this something to be expected? Is there any way to make it propagate the
>> sparse file info? Or should we think about issuing a "fallocate -d"-like patch
>> for writes on filestore?
>>
>> (We're using kernel 3.13.0-45-generic but on 4.4.0-31-generic the issue
>> remains; our XFS uses 4K bsize).
>
> I think the solution here is to use sparse_read during recovery.  The
> PushOp data representation already supports it; it's just a matter of
> skipping the zeros.  The recovery code could also have an option to check
> for fully-zero regions of the data and turn those into holes as well.  For
> ReplicatedBackend, see build_push_op().

So far it turns out that there's even easier solution, we just enabled 
"filestore seek hole" on some test cluster and that seems to fix the problem 
for us. We'll see if fiemap works too.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
