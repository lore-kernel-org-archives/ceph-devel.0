From: Ali Maredia <amaredia@redhat.com>
Subject: Re: Some testprograms are no longer runable from CLI???
Date: Mon, 18 Apr 2016 17:58:40 -0400 (EDT)
Message-ID: <1380561062.14432666.1461016720071.JavaMail.zimbra@redhat.com>
References: <5713E97D.20609@digiware.nl> <CAJ4mKGYDc5sfZK9y5vNibiEw6Zy32X8g1z3T9eqv9RAx5mcTgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:45558 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbcDRV6p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 17:58:45 -0400
In-Reply-To: <CAJ4mKGYDc5sfZK9y5vNibiEw6Zy32X8g1z3T9eqv9RAx5mcTgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

I'm working on a fix for this, please see the email I just sent to ceph-devel for more information.

-Ali

----- Original Message -----
From: "Gregory Farnum" <gfarnum@redhat.com>
To: "Willem Jan Withagen" <wjw@digiware.nl>, "Ali Maredia" <amaredia@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Monday, April 18, 2016 2:48:32 PM
Subject: Re: Some testprograms are no longer runable from CLI???

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
