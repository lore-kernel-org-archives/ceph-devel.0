From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: RPM issues
Date: Sat, 19 Mar 2011 14:08:43 +0100
Message-ID: <AANLkTikPLyPNroVBQGD5fVYZvjatN3erN2Y1xz6zWGnK@mail.gmail.com>
References: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:65499 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab1CSNJE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Mar 2011 09:09:04 -0400
Received: by yia27 with SMTP id 27so1904266yia.19
        for <ceph-devel@vger.kernel.org>; Sat, 19 Mar 2011 06:09:03 -0700 (PDT)
In-Reply-To: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Brian Chrisman <brchrisman@gmail.com>, Terrance Hutchinson <terrance.hutchinson@gmail.com>, Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

Hi Colin,

On Sat, Mar 19, 2011 at 01:29, Colin McCabe <cmccabe@alumni.cmu.edu> wr=
ote:
> Hi all,
>
> =C2=A0We have made some progress recently on getting a Ceph RPM that =
works
> on CentOS 5.5 and other Red Hat-derived distros.
>
> Now that our version number no longer includes a tilde, and the spec
> file has been pruned a bit, I think we have a shot at building this
> cleanly.
>
> I just have a few questions that perhaps people more experienced with
> RPM packaging can answer:
>
> 1. should we have a debug SPEC file and a regular SPEC file? I think
> in the long term we want to have both a Ceph and a Ceph-devel RPM
> built.

A single spec can produce multiple binary rpms, so this shouldn't be ne=
cessary.

>
> 2. What is the best way to bundle the python bindings? Currently I am
> getting this error when building the RPM:
>> error: Installed (but unpackaged) file(s) found:
>> /usr/lib/python2.4/site-packages/rados.py
>> /usr/lib/python2.4/site-packages/rados.pyc
>> /usr/lib/python2.4/site-packages/rados.pyo
> However, I need to find an RPM variable that has a path to the python
> site-packages directory. automake knows this, but so far I haven't
> figured out where this information lives in RPM.
>
> This guy suggests a workaround:
> http://www.linux-archive.org/centos/171366-python-sybase-centos-5-x86=
_64-a.html
> But his workaround seems kind of clumsy, and in fact doesn't work for
> me on CentOS 5.5. Surely there is a standard way to refer to the
> sit-packages directory in RPM without hacks?

There are standard macros in recent versions of Fedora and RHEL6, but
this should work:

%if ! (0%{?fedora} > 12 || 0%{?rhel} > 5)
%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from
distutils.sysconfig import get_python_lib; print(get_python_lib())")}
%{!?python_sitearch: %global python_sitearch %(%{__python} -c "from
distutils.sysconfig import get_python_lib; print(get_python_lib(1))")}
%endif

If you add that to the top of your spec you can use %{python_sitearch}
in your %files section.
There are more tips at http://fedoraproject.org/wiki/Packaging:Python

> 3. How should we handle tcmalloc, if at all? Google-perftools is not
> bundled for 64 bit on CentOS. (It seems like this decision was made
> because some of the stuff in this package is buggy on 64 bit x86.
> However, tcmalloc itself is not buggy on 64 bit.).

Is google-perftool an EPEL package? If so can you report a bug against
that package at bugzilla.redhat.com?
An option would be to split out tcmalloc into it's own rpm.

> And in general, how
> do we handle things that are "good to have" but which shouldn't be
> dependencies?

Ah, that's one of the problems of RPM :) There's no such thing as
Recommends or Suggests.
Some people handle this by adding conditional macros to the spec file.
This enables you to rebuild the source rpm by specifying rpmbuild
--with python for example. The libvirt spec file is a good example of
this: http://pkgs.fedoraproject.org/gitweb/?p=3Dlibvirt.git;a=3Dblob;f=3D=
libvirt.spec

> cheers,
> Colin

Kind regards,

Ruben
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
