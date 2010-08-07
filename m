From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: compiler warnings on centos5
Date: Sat, 07 Aug 2010 12:54:44 +0200
Message-ID: <4C5D3B74.2050307@chaschperli.ch>
References: <i3e1fs$mv$1@dough.gmane.org>	<AANLkTi=uegGEfjXw_DpfshdArsjQjk=sOv8DJ0-TF5be@mail.gmail.com>	<i3gthp$56v$2@dough.gmane.org> <AANLkTinKDgH-K7myRsEeP3PUHP3E_fM8CQd=gMzha6uR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:43675 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab0HGKzP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Aug 2010 06:55:15 -0400
In-Reply-To: <AANLkTinKDgH-K7myRsEeP3PUHP3E_fM8CQd=gMzha6uR@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On 06.08.2010 18:25, Gregory Farnum wrote:
> On Fri, Aug 6, 2010 at 5:00 AM, Thomas Mueller<thomas@chaschperli.ch>  wrote:
>> I found out that Centos5 actually provides a gcc44 and gcc44-c++ package.
>> Compiling with those doesn't show the wanrings.
>>
>> symlinking g++44 and gcc44 to /usr/local/(gcc|g++) works.

I just thought it would work. did not look at the configure output.

>>
>>
>> calling configure with the custom paths for gcc and g++ doesn't:
>>
>> CC=/usr/bin/gcc44 CXX=/usr/bin/g++44 ./configure --prefix=/usr
>> ...
>> checking for atomic_ops.h... yes
>> checking for dirent.h that defines DIR... yes
>> checking for library containing opendir... none required
>> checking for ANSI C header files... (cached) yes
>> checking for sys/wait.h that is POSIX.1 compatible... yes
>> checking boost/spirit.hpp usability... no
>> checking boost/spirit.hpp presence... no
>> checking for boost/spirit.hpp... no
>> configure: error: Sorry you need to install the Boost spirit parser
>> library (libboost-dev on debian)
> Looks like a configuration issue since it can't find the Boost header
> file. I imagine that by calling them directly you're losing some
> include lines or something?


I think i finally located the problem, in config.log:


configure:20728: g++ -E  conftest.cc
In file included from /usr/include/boost/mpl/apply.hpp:23,
                  from /usr/include/boost/iterator/iterator_facade.hpp:34,
                  from /usr/include/boost/iterator/iterator_adaptor.hpp:15,
                  from /usr/include/boost/iterator_adaptors.hpp:8,
                  from 
/usr/include/boost/spirit/iterator/file_iterator.hpp:55,
                  from /usr/include/boost/spirit/iterator.hpp:21,
                  from /usr/include/boost/spirit.hpp:49,
                  from conftest.cc:30:
/usr/include/boost/mpl/apply_wrap.hpp:81:31: error: missing binary 
operator before token "("
/usr/include/boost/mpl/apply_wrap.hpp:173:31: error: missing binary 
operator before token "("

seems that the version of boost (1.33.1) in Centos5 does not compile 
with gcc 4.4.

- Thomas
