From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Some testprograms are no longer runable from CLI???
Date: Mon, 18 Apr 2016 11:48:32 -0700
Message-ID: <CAJ4mKGYDc5sfZK9y5vNibiEw6Zy32X8g1z3T9eqv9RAx5mcTgg@mail.gmail.com>
References: <5713E97D.20609@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33542 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcDRSsd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 14:48:33 -0400
Received: by mail-vk0-f43.google.com with SMTP id n62so115426106vkb.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 11:48:33 -0700 (PDT)
In-Reply-To: <5713E97D.20609@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ali Maredia <amaredia@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Apr 17, 2016 at 12:52 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> As far as Ik can tell this is due to:
> https://github.com/ceph/ceph/commit/1c8cd003600953ee1f469fc91be1b0cc4b4f7fa7
>
> Author: Ali Maredia <amaredia@redhat.com>
> Date:   Wed Jan 13 14:40:22 2016 -0500
>
>     cmake: erasure-code tests passing
>
>     Replaced relative paths in test-erausure-eio.sh
>     test-erasure-code.sh, and replaced .libs in
>     erasure_code unittests with CEPH_VAR environment
>     variables set in cmake.
>
>     Signed-off-by: Ali Maredia <amaredia@redhat.com>
>
> =============
>
> Lots of scripts now contain the header:
> source $CEPH_ROOT/qa/workunits/ceph-helpers.sh
>
> Which was uptill this commit not required to be set.
>
> As far as I can tell other "required" Shell varaibles might be:
>
> ../cmake/modules/AddCephTest.cmake:    CEPH_ROOT=${CMAKE_SOURCE_DIR}
> ../cmake/modules/AddCephTest.cmake:
> CEPH_BIN=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
> ../cmake/modules/AddCephTest.cmake:
> CEPH_LIB=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
> ../cmake/modules/AddCephTest.cmake:    CEPH_BUILD_DIR=${CMAKE_BINARY_DIR}
>
> It would be nice that if these variables are not set, it is still possible
> to
> run the tests from the commandline due to setting defaults to values that it
> had
> before these Cmake changes were introducded.
>
> Something like
> ====
> C_ROOT=${CEPH_ROOT:-.}
> source $CEPH_ROOT/qa/workunits/ceph-helpers.sh
> ====
> would help quite a bit, and keep things backwards compatible.

Yes please, test binaries should be runnable on their own without
going through "make check" or whatever!
-Greg

>
> Thanx,
> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
