From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: CMake build errors in modules
Date: Wed, 10 Aug 2016 14:40:16 -0700
Message-ID: <57AB9F40.2030200@redhat.com>
References: <CA+2bHPYVhQPi=vP99HR610CY1nwkfJpAnQZBMN491zMtBj48cQ@mail.gmail.com>
 <CA+2bHPa6=yngnR_Q-YLPOE-2sW8G95ngW7wEyV82yLOe9pXfPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbcHJVkP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Aug 2016 17:40:15 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C6EA12B34
	for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 21:40:15 +0000 (UTC)
In-Reply-To: <CA+2bHPa6=yngnR_Q-YLPOE-2sW8G95ngW7wEyV82yLOe9pXfPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 08/10/2016 01:30 PM, Patrick Donnelly wrote:
> On Wed, Aug 10, 2016 at 4:15 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>> I sometimes get build errors for modules (not always the same module)
>> about missing headers:
>>
>> $ (cd build && make)
>> [...]
>> [ 25%] rocksdb building
>>    GEN      util/build_version.cc
>> make[3]: *** No rule to make target `db/writebuffer.h', needed by
>> `db/column_family.o'.  Stop.
>> make[2]: *** [src/CMakeFiles/build_rocksdb] Error 2
>> make[1]: *** [src/CMakeFiles/build_rocksdb.dir/all] Error 2
>> make: *** [all] Error 2
>>
>> What's the right way to fix this? I already tried `git submodule
>> update` and my working copy was sterile (`git clean -xfd`) before the
>> build.
>
> Hmm, I think this is because the submodules are not being cleaned as
> well by `git clean -xfd`? So perhaps the right way to achieve a
> sterile build is:

Yeah, that's the problem.

> # COPY PASTE DANGER: this nukes all of your local modifications
> git submodule deinit --force
> git clean -xfd
> git checkout .
> git submodule init
>
> Is there something else that is preferable?

A little more general, and avoids removing the submodule trees:

git clean -fdx
git submodule foreach 'git clean -fdx'
git submodule sync --recursive
git submodule update --force --init --recursive

Josh
