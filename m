From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: With ceph-detect-init changes, make install fails
Date: Wed, 13 May 2015 09:42:00 -0700
Message-ID: <CAFkUHxcH20FzAX+y3LoPnJTG-Uz=cgjPrckYJ330-_dahMxKNQ@mail.gmail.com>
References: <CAFkUHxdwK4YkoJ+B1Vkcn5006wXpj5nKDu5tR1w16Q_1mBntBA@mail.gmail.com>
	<55532CB2.8060201@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33743 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbbEMQmB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 12:42:01 -0400
Received: by pdbnk13 with SMTP id nk13so56845981pdb.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 May 2015 09:42:00 -0700 (PDT)
In-Reply-To: <55532CB2.8060201@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,

https://github.com/ceph/ceph/pull/4663 fixes the issue. Thanks!

-Neo

On Wed, May 13, 2015 at 3:51 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> http://tracker.ceph.com/issues/11598 should be fixed with https://git=
hub.com/ceph/ceph/pull/4663. Would you have time to review this fix ?
>
> Thanks !
>
> On 12/05/2015 20:26, kernel neophyte wrote:
>> Hi,
>>
>> With the recent ceph-detect-init changes, make install now fails (
>> make succeeds hence this is not detected by build bots )
>>
>> Error:
>>
>> cd ceph-detect-init ; \
>>
>> if lsb_release -si | grep --quiet 'Ubuntu\|Debian\|Devuan' ; then \
>>
>> options=3D--install-layout=3Ddeb ; \
>>
>> else \
>>
>> options=3D--prefix=3D/usr ; \
>>
>> fi ; \
>>
>> python setup.py install --root=3D $options
>>
>> running install
>>
>> Checking .pth file support in usr/lib/python2.7/dist-packages/
>>
>> /usr/bin/python -E -c pass
>>
>> TEST FAILED: usr/lib/python2.7/dist-packages/ does NOT support .pth =
files
>>
>> error: bad install directory or PYTHONPATH
>>
>>
>> You are attempting to install a package to a directory that is not
>>
>> on PYTHONPATH and which Python does not read ".pth" files from.  The
>>
>> installation directory you specified (via --install-dir, --prefix, o=
r
>>
>> the distutils default setting) was:
>>
>>
>>     usr/lib/python2.7/dist-packages/
>>
>>
>> and your PYTHONPATH environment variable currently contains:
>>
>>
>>     '../src/pybind'
>>
>>
>> Here are some of your options for correcting the problem:
>>
>>
>> * You can choose a different installation directory, i.e., one that =
is
>>
>>   on PYTHONPATH or supports .pth files
>>
>>
>> * You can add the installation directory to the PYTHONPATH environme=
nt
>>
>>   variable.  (It must then also be on PYTHONPATH whenever you run
>>
>>   Python and want to use the package(s) you are installing.)
>>
>>
>> * You can set up the installation directory to support ".pth" files =
by
>>
>>   using one of the approaches described here:
>>
>>
>>   https://pythonhosted.org/setuptools/easy_install.html#custom-insta=
llation-locations
>>
>>
>> -Neo
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
