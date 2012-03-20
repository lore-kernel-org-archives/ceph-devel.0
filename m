From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rados.py broken with Python2.4
Date: Tue, 20 Mar 2012 14:57:18 -0700
Message-ID: <CAORUGqDuysDKt7z99ypH+C541yJ-E_4J=dedV9wPOqcTzAsHsg@mail.gmail.com>
References: <4F68A57802000099000DD35F@collaborate.seakr.com> <4F68A6A002000099000DD364@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48728 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab2CTV5j convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Mar 2012 17:57:39 -0400
Received: by pbcun15 with SMTP id un15so326101pbc.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Mar 2012 14:57:38 -0700 (PDT)
In-Reply-To: <4F68A6A002000099000DD364@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Mar 20, 2012 at 14:47, Nick Couchman <Nick.Couchman@seakr.com> =
wrote:
>> Just noticed this with ceph-0.43 - ceph-0.39 does not have this issu=
e. =C2=A0I'm
>> trying to use Ceph on multiple platforms, one of which is CentOS 5. =
=C2=A0CentOS 5
>> still uses Python 2.4, and byte-compilation of the rados.py file fai=
ls during
>> the build of ceph 0.43 with the following error:
>>
>> Byte-compiling python modules...
>> rados.py =C2=A0File "/usr/lib/python2.4/site-packages/rados.py", lin=
e 422
>> =C2=A0 =C2=A0 with self.lock:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^
>> SyntaxError: invalid syntax
>>
>> A quick Google search doesn't turn up anything obviously wrong with =
this
>> statement - just that Python 2.4 may not support this? =C2=A0Is ther=
e anything that
>> can be done to make this block of code (Ioctx, some of the aio stuff=
)
>> compatible with Python 2.4?

Python 2.4 does not support the with statement.

You should be able to replace that with

        self.lock.acquire()
        try:
            cb =3D self.safe_cbs[completion]
            del self.safe_cbs[completion]
        finally:
            self.lock.release()

I'm afraid we don't have resources to maintain Python support for
versions before 2.6; after all, 2.5 was released 5.5 years ago.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
