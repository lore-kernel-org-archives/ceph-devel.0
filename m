From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: compiler warnings on centos5
Date: Thu, 5 Aug 2010 10:02:15 -0700
Message-ID: <AANLkTi=uegGEfjXw_DpfshdArsjQjk=sOv8DJ0-TF5be@mail.gmail.com>
References: <i3e1fs$mv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35762 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760197Ab0HERCU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Aug 2010 13:02:20 -0400
Received: by wyb39 with SMTP id 39so6852896wyb.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Aug 2010 10:02:18 -0700 (PDT)
In-Reply-To: <i3e1fs$mv$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Thomas:
We're certainly interested in keeping the Ceph compile warning-free.
However, these errors are pretty annoying to work around and are bogus
enough to not be present in newer versions of gcc (it's the compiler,
not the system). Can you upgrade your compiler?
-Greg

On Thu, Aug 5, 2010 at 2:49 AM, Thomas Mueller <thomas@chaschperli.ch> =
wrote:
> hi
>
> altough my tests are running ok on centos5 =A0there a lots of compile=
r
> warnings:
>
> http://chaschperli.ch/testing/viewBuildError.php?type=3D1&buildid=3D1=
49
>
> I do not seem them on debian.
>
> this is with ceph.git/unstable.
>
> - Thomas
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
