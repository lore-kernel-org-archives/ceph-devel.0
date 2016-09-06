From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: librados.h version numbers
Date: Tue, 6 Sep 2016 16:16:49 -0700
Message-ID: <37bd7608-3352-5057-d238-e04517640f5b@redhat.com>
References: <1843378866.3701.1473189527273@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755801AbcIFXQv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Sep 2016 19:16:51 -0400
In-Reply-To: <1843378866.3701.1473189527273@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/06/2016 12:18 PM, Wido den Hollander wrote:
> Hi,
>
> wido@wido-laptop:~$ python -c "import rados; r = rados.Rados(); print(r.version())"
> 0.69.1
> wido@wido-laptop:~$ dpkg -l|grep rados|awk '{print $2" "$3}'
> librados-dev 10.2.2-1trusty
> librados2 10.2.2-1trusty
> libradosstriper1 10.2.2-1trusty
> python-rados 10.2.2-1trusty
> wido@wido-laptop:~$
>
> Looking at librados.h in master I see:
>
> #define LIBRADOS_VER_MAJOR 0
> #define LIBRADOS_VER_MINOR 69
> #define LIBRADOS_VER_EXTRA 1
>
> Is this something which has just been forgotten to update?

Pretty much. Not much has relied on the librados/librbd version numbers
of this style. Adding tests for particular functions can be more
reliable than checking version numbers, since sometimes functions are
backported.

> Looking at the 'ceph' tool I see:
>
> CEPH_GIT_NICE_VER="10.2.2"
>
> This is updated during packaging/build it seems.
>
> Should we maybe do that for librados.h as well?

I see no reason not to.

> Is there any other way (other then executing 'ceph -v') to get the version of the local librados?

There is 'librados-config --version' if you have the -dev package
installed.

Josh
