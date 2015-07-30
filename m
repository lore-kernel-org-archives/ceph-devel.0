From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Transitioning Ceph from Autotools to CMake
Date: Thu, 30 Jul 2015 13:34:26 -0600
Message-ID: <55BA7C42.4020404@redhat.com>
References: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbbG3Te2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jul 2015 15:34:28 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 1B90A1CA58E
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jul 2015 19:34:28 +0000 (UTC)
In-Reply-To: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ali Maredia <amaredia@redhat.com>, ceph-devel@vger.kernel.org

On 07/30/2015 01:01 PM, Ali Maredia wrote:
>  - Creating CMake targets that build packages (such as for rpm or debian)

There was some discussion on the list a while back about how we don't
really need to go through the full autoconf + ./configure + "make rpm"
routine simply to generate packages with the right version information.
My conclusion was that we should be able to generate a release tarball
(and even SRPM or RPM) with a shell script, rather than trying to do it
in autotools with a make target.

The reasoning was speed and efficiency: there's no point to running
"./configure" to generate an SRPM when the RPM itself runs "./configure"
during its build.

I don't know how well this maps to CMake, and whether CMake gives you
some sort of "skip everything and immediately do <foo>"... clearly I
need to learn more about CMake :)

>  - Replacing the integration autotools has with any automated build/test
>    systems such as the gitbuilder

We hope to eventually replace gitbuilder with something more scalable
like Jenkins, but in the meantime we're maintaining both systems :(

gitbuilder is https://github.com/ceph/autobuild-ceph
Jenkins is https://github.com/ceph/ceph-build

And then Loic also runs a make check bot in his own Jenkins instance.
