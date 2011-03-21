From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: RPM issues
Date: Mon, 21 Mar 2011 16:52:48 -0700
Message-ID: <AANLkTi=xkHU6avpnZNj_P-zPNjsmCvb+MSCTMoWCG-zi@mail.gmail.com>
References: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
	<AANLkTikPLyPNroVBQGD5fVYZvjatN3erN2Y1xz6zWGnK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51139 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab1CUXww (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 19:52:52 -0400
Received: by fxm17 with SMTP id 17so5969758fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 16:52:50 -0700 (PDT)
In-Reply-To: <AANLkTikPLyPNroVBQGD5fVYZvjatN3erN2Y1xz6zWGnK@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ruben Kerkhof <ruben@rubenkerkhof.com>
Cc: Brian Chrisman <brchrisman@gmail.com>, Terrance Hutchinson <terrance.hutchinson@gmail.com>, Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

On Sat, Mar 19, 2011 at 6:08 AM, Ruben Kerkhof <ruben@rubenkerkhof.com> wrote:
>> 2. What is the best way to bundle the python bindings? Currently I am
>> getting this error when building the RPM:
>>> error: Installed (but unpackaged) file(s) found:
>>> /usr/lib/python2.4/site-packages/rados.py
>>> /usr/lib/python2.4/site-packages/rados.pyc
>>> /usr/lib/python2.4/site-packages/rados.pyo
>> However, I need to find an RPM variable that has a path to the python
>> site-packages directory. automake knows this, but so far I haven't
>> figured out where this information lives in RPM.
>>
>> This guy suggests a workaround:
>> http://www.linux-archive.org/centos/171366-python-sybase-centos-5-x86_64-a.html
>> But his workaround seems kind of clumsy, and in fact doesn't work for
>> me on CentOS 5.5. Surely there is a standard way to refer to the
>> sit-packages directory in RPM without hacks?
>
> There are standard macros in recent versions of Fedora and RHEL6, but
> this should work:
>
> %if ! (0%{?fedora} > 12 || 0%{?rhel} > 5)
> %{!?python_sitelib: %global python_sitelib %(%{__python} -c "from
> distutils.sysconfig import get_python_lib; print(get_python_lib())")}
> %{!?python_sitearch: %global python_sitearch %(%{__python} -c "from
> distutils.sysconfig import get_python_lib; print(get_python_lib(1))")}
> %endif

Thanks for this workaround, Ruben. I committed it as
f2e146aa86f595b9acc1829e394abcd6570ce222

>
> If you add that to the top of your spec you can use %{python_sitearch}
> in your %files section.
> There are more tips at http://fedoraproject.org/wiki/Packaging:Python
>
>> 3. How should we handle tcmalloc, if at all? Google-perftools is not
>> bundled for 64 bit on CentOS. (It seems like this decision was made
>> because some of the stuff in this package is buggy on 64 bit x86.
>> However, tcmalloc itself is not buggy on 64 bit.).
>
> Is google-perftool an EPEL package? If so can you report a bug against
> that package at bugzilla.redhat.com?
> An option would be to split out tcmalloc into it's own rpm.

Filed as https://bugzilla.redhat.com/show_bug.cgi?id=689630

Hopefully we'll get a tcmalloc package!

cheers,
Colin
