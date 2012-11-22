From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: 'zombie snapshot' problem
Date: Thu, 22 Nov 2012 14:23:38 +0300
Message-ID: <CABYiri9BufKJH3zksVoGHoGQbJUfgnsuxi0usQqJj6rsT1TU-g@mail.gmail.com>
References: <CABYiri-cnNmP_Y0bdhvp8O8v-9kJyAWK9vcHgb_zwPP7ZAAuXQ@mail.gmail.com>
 <50AD500F.5040800@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec54a35ca04626704cf13b490
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62806 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab2KVSn6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:43:58 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8286231oag.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 10:43:57 -0800 (PST)
In-Reply-To: <50AD500F.5040800@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

--bcaec54a35ca04626704cf13b490
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 22, 2012 at 2:05 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 11/21/2012 04:50 AM, Andrey Korolyov wrote:
>>
>> Hi,
>>
>> Somehow I have managed to produce unkillable snapshot, which does not
>> allow to remove itself or parent image:
>>
>> $ rbd snap purge dev-rack0/vm2
>> Removing all snapshots: 100% complete...done.
>
>
> I see one bug with 'snap purge' ignoring the return code when removing
> snaps. I just fixed this in the next branch. It's probably getting the
> same error as 'rbd snap rm' below.
>
> Could you post the output of:
>
>     rbd snap purge dev-rack0/vm2 --debug-ms 1 --debug-rbd 20
>
>
>> $ rbd rm dev-rack0/vm2
>> 2012-11-21 16:31:24.184626 7f7e0d172780 -1 librbd: image has snapshots
>> - not removing
>> Removing image: 0% complete...failed.
>> rbd: image has snapshots - these must be deleted with 'rbd snap purge'
>> before the image can be removed.
>> $ rbd snap ls dev-rack0/vm2
>> SNAPID NAME                               SIZE
>>     188 vm2.snap-yxf 16384 MB
>> $ rbd info dev-rack0/vm2
>> rbd image 'vm2':
>>          size 16384 MB in 4096 objects
>>          order 22 (4096 KB objects)
>>          block_name_prefix: rbd_data.1fa164c960874
>>          format: 2
>>          features: layering
>> $ rbd snap rm --snap vm2.snap-yxf dev-rack0/vm2
>> rbd: failed to remove snapshot: (2) No such file or directory
>> $ rbd snap create --snap vm2.snap-yxf dev-rack0/vm2
>> rbd: failed to create snapshot: (17) File exists
>> $ rbd snap rollback --snap vm2.snap-yxf dev-rack0/vm2
>> Rolling back to snapshot: 100% complete...done.
>> $ rbd snap protect --snap vm2.snap-yxf dev-rack0/vm2
>> $ rbd snap unprotect --snap vm2.snap-yxf dev-rack0/vm2
>>
>>
>> Meanwhile, ``rbd ls -l dev-rack0''  segfaulting with an attached log.
>> Is there any reliable way to kill problematic snap?
>
>
> From this log it looks like vm2 used to be a clone, and the snapshot
> vm2.snap-yxf was taken before it was flattened. Later, the parent of
> vm2.snap-yxf was deleted. Is this correct?

I have attached log you asked, hope it will be useful.
Here is a two possible flows: snapshot created before and during flatten:

Completely linear flow:

$ rbd cp install/debian7 dev-rack0/testimg
Image copy: 100% complete...done.
$ rbd snap create --snap test1 dev-rack0/testimg
$ rbd snap clone --snap test1 dev-rack0/testimg dev-rack0/testimg2
rbd: error parsing command 'clone'
$ rbd snap protect --snap test1 dev-rack0/testimg
$ rbd clone --snap test1 dev-rack0/testimg dev-rack0/testimg2
$ rbd snap create --snap test2 dev-rack0/testimg2
$ rbd flatten dev-rack0/testimg2
Image flatten: 100% complete...done.
$ rbd snap unprotect --snap test1 dev-rack0/testimg
2012-11-22 15:11:03.446892 7ff9fb7c1780 -1 librbd: snap_unprotect:
can't unprotect; at least 1 child(ren) in pool dev-rack0
rbd: unprotecting snap failed: (16) Device or resource busy
$ rbd snap purge dev-rack0/testimg2
Removing all snapshots: 100% complete...done.
$ rbd snap ls dev-rack0/testimg2
$ rbd snap unprotect --snap test1 dev-rack0/testimg


snapshot created over image with ``flatten'' in progress:

$ rbd snap create --snap test3 dev-rack0/testimg
$ rbd snap protect --snap test3 dev-rack0/testimg
$ rbd clone --snap test3 dev-rack0/testimg dev-rack0/testimg3
rbd $ rbd flatten dev-rack0/testimg3
[here was executed rbd snap create --snap test43 dev-rack0/testimg3]
Image flatten: 100% complete...done.
$ rbd snap unprotect --snap test3 dev-rack0/testimg
$ rbd snap ls dev-rack0/testimg3
SNAPID NAME     SIZE
   323 test43 640 MB
$ rbd snap purge dev-rack0/testimg3
Removing all snapshots: 100% complete...done.
$ rbd snap ls dev-rack0/testimg3
SNAPID NAME     SIZE
   323 test43 640 MB
$ rbd snap rm --snap test43 dev-rack0/testimg3
rbd: failed to remove snapshot: (2) No such file or directory

Hooray, problem found! Now I`ll avoid this by putting flatten state as
exclusive one over the image.
ceph version 0.54 (commit:60b84b095b1009a305d4d6a5b16f88571cbd3150)

>
> It was a bug in 0.53 that protected snapshots could be deleted.
>
> Josh

--bcaec54a35ca04626704cf13b490
Content-Type: application/x-gzip; name="snap.txt.gz"
Content-Disposition: attachment; filename="snap.txt.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h9tsjqfw0

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
--bcaec54a35ca04626704cf13b490--
