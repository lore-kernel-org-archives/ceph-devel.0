From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph/hadoop benchmarking
Date: Wed, 26 Oct 2011 15:36:59 -0700
Message-ID: <CAORUGqBe-xdQ1bwifcN3kQEZ=0a72tkHsFU9TqXHvvED7DpS=g@mail.gmail.com>
References: <193464577.4390.1319657347846.JavaMail.root@mail-01.cse.ucsc.edu> <Pine.LNX.4.64.1110261425320.18909@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53332 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab1JZWhU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 18:37:20 -0400
Received: by wwe6 with SMTP id 6so3151067wwe.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2011 15:37:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1110261425320.18909@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Wed, Oct 26, 2011 at 14:34, Sage Weil <sage@newdream.net> wrote:
>> 1) Everything (JNI wrappers + Java) lives in the Ceph tree and build
>> =C2=A0 =C2=A0instructions include applying a patch to Hadoop.
>>
>> =C2=A0 =C2=A0The current solution, and isn't too bad but needs docum=
entation. This
>> =C2=A0 =C2=A0approach can be simplified to avoid patching Hadoop by =
integrating
>> =C2=A0 =C2=A0Ceph-specific Java code using the CLASSPATH global vari=
able.

=46rom my experience with Hadoop, the CLASSPATH approach seems
definitely good enough, and gives us more flexibility.

I don't know very much about the current patch in the Apache tracker,
but there really should be no need to patch the Hadoop upstream. Just
provide a jar with our filesystem plugin, change
fs.default.name=3Dceph://something/,
fs.ceph.impl=3Dcom.ceph.hadoop.CephFileSystem (whatever is in the jar).

http://hadoop.apache.org/common/docs/current/cluster_setup.html#Configu=
ring+the+Hadoop+Daemons
http://hadoop.apache.org/common/docs/current/core-default.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
