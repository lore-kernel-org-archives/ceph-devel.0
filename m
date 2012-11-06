From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: python-ceph
Date: Mon, 5 Nov 2012 21:18:27 -0500
Message-ID: <CACkq2mpABf55DyXn3wQiuo1Lxc9CeHxthYGBY7KMfj3PtDZgyg@mail.gmail.com>
References: <CACkq2momtqxBZ+XCz_j_kiJsbn_8epU=vovn8-RfAob-d5d-wA@mail.gmail.com>
 <CAPYLRzjwEy2o=JwCUQuio-WDevzrPiQ0fUCnMJu7XiDTVWhF8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61726 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933522Ab2KFCSt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 21:18:49 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so6551926vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 18:18:48 -0800 (PST)
In-Reply-To: <CAPYLRzjwEy2o=JwCUQuio-WDevzrPiQ0fUCnMJu7XiDTVWhF8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Gary Lowell <gary.lowell@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Greg,

> I'm not familiar with Python packaging, can you talk about this a bit more?

I'd be happy to.  PyPI (the Python Package Index) is a repo on
python.org for distributing/sharing Python projects.  People can
publish their code onto it for others to download.  If you are a Perl
guy, it's a similar concept to CPAN.

Since Python is an interpreted language, it is fairly trivial to
distribute code in a portable way.  Obviously there are complications
and exceptions to everything, but I believe this is true more often
than not.  Python has a few different tools available for installing
modules -- easy_install and pip come to mind.  Both of these are
essentially their own package managers,  solving dependencies and
such.  One can do things like "easy_install matplotlib" or
"easy_install python-mysql" and this package will be searched for on
PyPI (and other repos) and installed into the current Python path.

This has some advantages over getting your packages strictly through
your distro package manager (say yum or apt).  This is especially true
for developers deploying webservices, or really any other situation
where you might want to have multiple versions of Python, or multiple
versions of applications that require different versions of the same
package.  I could, for example, create multiple virtual environments
(which is a way for Python to make a copy of it's core binaries, minus
the global modules) and have each environment run a different version
of a specific module.  Or commonly, to set up a testing environment in
parallel to your production environment to make sure that a newer
module version doesn't break everything.

As for packaging, an egg file is a Python format that really is just a
zip file -- containing all the Python source code, dependencies, and
other info about the module.  They get dropped in your site-packages
folder (or on Ubuntu, dist-packages since they like to be different).

So to get specific, when I use apt to install python-ceph via "apt-get
install python-ceph", it's essentially dropping rbd.py and rados.py
into dist-packages.  I can then go into Python and do "import rbd" or
"import rados".  However, dropping .py files into dist-packages can be
improved upon.  By building a proper Python package (in the form of an
.egg), you can package it all up inside of a namespace like "ceph",
and then your code is more like "from ceph import rbd" and "from ceph
import rados". Or just "import ceph.rbd".

Also, even though there is all the versioning from dpkg/apt involved,
from a Python perspective, the .py files have no version.  From within
Python, there is no notion of what version of rbd.py I am using.
Using a .egg can solve that.  That would allow one to build other
python modules that depend on package "ceph", such that you can say
required "ceph >= 0.48.2" or similar.

There are lots of examples of projects that distribute their modules
both through distro repos and PyPI.  OpenStack is a good example.  If
you do "apt-get install python-novaclient", it's going to to grab the
package from archive.ubuntu.com (and stuff it into dist-packages).
But if you do easy_install python-novaclient (or use pip), it's going
to grab the latest from PyPI and stuff it into the site-packages
folder of whatever Python path is currently active.

Not sure if that touches on what you were looking for or not.  Hope
so.  I know it'd be a big benefit to me!  I think it would be a great
way to promote the Python bindings.

 - Travis

On Sat, Nov 3, 2012 at 12:31 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Fri, Nov 2, 2012 at 8:53 PM, Travis Rhoden <trhoden@gmail.com> wrote:
>> Hi folks,
>>
>> Are there any plans to release python-ceph to pypi?  It would be nice
>> to see it packaged up in distutils/egg format and added to pypi, that
>> way other python packages can list it as a dependency.
>>
>> I know there is currently a python-ceph package in Debian, but that
>> doesn't allow me to list it as a dependency in a setup.py file and
>> have it installed in a virtualenv, for example.  Right now I have to
>> copy rbd.py into my virtualenv.
>>
>> Curious to know if this is something you would consider.  Perhaps it
>> is something I could help with.
>
> I'm not familiar with Python packaging, can you talk about this a bit more?
> -Greg
>
>>
>> Thanks,
>>
>>  - Travis
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
