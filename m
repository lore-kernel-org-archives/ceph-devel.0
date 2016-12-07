From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: enabling shared ccache dirs in default builds
Date: Wed, 7 Dec 2016 18:07:30 +0100
Message-ID: <91f410e8-3073-7093-1ed7-2046f69d06f5@digiware.nl>
References: <CAJ4mKGZSnN+RE7d5wrzghmtWZA1w1e7NT8JeW4nArwVdijggkQ@mail.gmail.com>
 <fde7b31e-75ba-9c71-a0d2-1467e65b1d54@digiware.nl>
 <CAJ4mKGZW35ULXFmf14rjmtEvBtJZfPN2eHPM-ogSw4xx8rmS+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:11523 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbcLGRHr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Dec 2016 12:07:47 -0500
In-Reply-To: <CAJ4mKGZW35ULXFmf14rjmtEvBtJZfPN2eHPM-ogSw4xx8rmS+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 7-12-2016 17:46, Gregory Farnum wrote:
> On Wed, Dec 7, 2016 at 1:26 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 7-12-2016 01:09, Gregory Farnum wrote:
>>> The default (or at least, ./do_cmake.sh-setup) Ceph build makes use of
>>> cmake. This is nice for speeding up builds, but as the amount of disk
>>> space increases it really explodes disk usage on dev boxes. As of
>>> today, a Ceph repo with build artifacts is ~30GB, and my ccache
>>> directory is ~32GB.
>>>
>>> For me and many of the other Red Hat devs, that's a significant
>>> fraction of the 256GB available on our (shared box) home-dir SSDs, and
>>> I don't think there's *too* much advantage to be gained by giving each
>>> dev their own ccache dir. If anybody has expertise configuring ccache
>>> and wants to tweak our build scripts to make setting that up easy,
>>> it'd be cool — I started in on the ccache man page and it doesn't look
>>> too hard but I've never configured any of it. Created a ticket at
>>> http://tracker.ceph.com/issues/18160
>>
>> From the ccache site:
>> "Another reason to use ccache is that the same cache is used for builds
>> in different directories. If you have several versions or branches of a
>> software stored in different directories, many of the object files in a
>> build directory can probably be taken from the cache even if they were
>> compiled for another version or branch
>> "
>>
>> So why not have a shared/global ccache. I would expect the larger part
>> of the project to generate the same code over and over for most of the
>> users? On average only a small fraction of the compile is different
>> between developers, and even that will be absorbed by a large general
>> cache. The trick with a cache is that the benifits increase if there are
>> more users doing/reusing more of the same. So the advantage of 300G
>> cache is better that 10*30G. Note that ccache can even compress data in
>> the cache, leading to even more objects in your cache. With an even
>> better hit ratio.
>>
>> Get ride of all personal ccache.conf files and
>> in global /etc/ccache.conf
>> cache_dir = /somewhere/you/want/then/ccache
>> max_size = as large as possible
>> umask = 777
>> # or 775 if devs are all in the same group.
> 
> Yes, something like this would be involved too. But if you grep for
> ccache in ceph.git you'll notice it's doing some level of autoconfig —
> I don't know how much — which needs to play nicely as well.
> Now that I look at it with fresh eyes it looks like maybe our tooling
> is only invoking ccache and we do just need the config; I'm just a
> little fidgety about it because some of the test-dir contents are
> referencing specific directories and I'm not sure if we invoke any of
> those bits via make check or similar.

Well, these are all references to ccache in the Cmake sources:

./src/CMakeLists.txt:693:if (WITH_CCACHE AND CCACHE_FOUND)
./src/CMakeLists.txt:694:  list(APPEND ROCKSDB_CMAKE_ARGS
-DCMAKE_CXX_COMPILER=ccache)
./src/CMakeLists.txt:696:else(WITH_CCACHE AND CCACHE_FOUND)
./src/CMakeLists.txt:698:endif(WITH_CCACHE AND CCACHE_FOUND)

This^^^^^^ is code for rocksdb to use ccache, so nothing there.

./CMakeLists.txt:40:option(WITH_CCACHE "Build with ccache.")
./CMakeLists.txt:41:if(WITH_CCACHE)
./CMakeLists.txt:42:  find_program(CCACHE_FOUND ccache)
./CMakeLists.txt:43:  if(CCACHE_FOUND)
./CMakeLists.txt:44:    message(STATUS "Building with ccache:
${CCACHE_FOUND}, CCACHE_DIR=$ENV{CCACHE_DIR}")
./CMakeLists.txt:45:    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE
ccache)
./CMakeLists.txt:46:    # ccache does not accelerate link (ld), but let
it handle it. by passing it
./CMakeLists.txt:49:    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK
ccache)
./CMakeLists.txt:50:  else(CCACHE_FOUND)
./CMakeLists.txt:51:    message(FATAL_ERROR "Can't find ccache. Is it
installed?")
./CMakeLists.txt:52:  endif(CCACHE_FOUND)
./CMakeLists.txt:53:endif(WITH_CCACHE)

This^^^^ is code to educate Cmake to use ccache as compiler/linker....

So nothing scary there...

And in the *.sh files is the only real reference to ccache:
./src/test/docker-test-helper.sh:119:    local ccache
./src/test/docker-test-helper.sh:120:    mkdir -p $HOME/.ccache
./src/test/docker-test-helper.sh:121:    ccache="--volume
$HOME/.ccache:$HOME/.ccache"
./src/test/docker-test-helper.sh:123:    local cmd="docker run $opts
--rm --name $image --privileged $ccache"

And I known nothing of docker, but it's use seems to override the global
cache. And could deserve a bit of rewrite if this access is actually
intended to use the cache that is build outside of the docker.
Perhaps ask Loic.

But other than that I was not able to find references to ccache.

--WjW



