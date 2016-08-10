From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: CMake build errors in modules
Date: Wed, 10 Aug 2016 16:30:33 -0400
Message-ID: <CA+2bHPa6=yngnR_Q-YLPOE-2sW8G95ngW7wEyV82yLOe9pXfPw@mail.gmail.com>
References: <CA+2bHPYVhQPi=vP99HR610CY1nwkfJpAnQZBMN491zMtBj48cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:32775 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487AbcHJUbF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 16:31:05 -0400
Received: by mail-qk0-f179.google.com with SMTP id t7so55632572qkh.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 13:31:04 -0700 (PDT)
In-Reply-To: <CA+2bHPYVhQPi=vP99HR610CY1nwkfJpAnQZBMN491zMtBj48cQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 10, 2016 at 4:15 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> I sometimes get build errors for modules (not always the same module)
> about missing headers:
>
> $ (cd build && make)
> [...]
> [ 25%] rocksdb building
>   GEN      util/build_version.cc
> make[3]: *** No rule to make target `db/writebuffer.h', needed by
> `db/column_family.o'.  Stop.
> make[2]: *** [src/CMakeFiles/build_rocksdb] Error 2
> make[1]: *** [src/CMakeFiles/build_rocksdb.dir/all] Error 2
> make: *** [all] Error 2
>
> What's the right way to fix this? I already tried `git submodule
> update` and my working copy was sterile (`git clean -xfd`) before the
> build.

Hmm, I think this is because the submodules are not being cleaned as
well by `git clean -xfd`? So perhaps the right way to achieve a
sterile build is:

# COPY PASTE DANGER: this nukes all of your local modifications
git submodule deinit --force
git clean -xfd
git checkout .
git submodule init

Is there something else that is preferable?

-- 
Patrick Donnelly
