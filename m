From: Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: [ANN] ceph-deploy 1.2.3 released!
Date: Fri, 30 Aug 2013 10:59:21 -0400
Message-ID: <CANtztVz3DS068i+xzHpZoaJU4L2_CxjfgdurY8Pp-B76GP+3zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1383388030=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1383388030==
Content-Type: multipart/alternative; boundary=e89a8f6436d2b13b1704e52b776e

--e89a8f6436d2b13b1704e52b776e
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

There is a new bug-fix release of ceph-deploy, the easy ceph deployment tool.

Installation instructions: https://github.com/ceph/ceph-deploy#installation

This is the list of all fixes that went into this release which can
also be found in the CHANGELOG.rst file in ceph-deploy's git repo:
* Fix non-working ``disk list``
* ``check_call`` utility fixes ``$PATH`` issues.
* Use proper exit codes from the ``main()`` CLI function
* Do not error when attempting to add the EPEL repos.
* Do not complain when using IP:HOST pairs
* Report nicely when ``HOST:DISK`` is not used when zapping.


Make sure you update!

Thanks,


Alfredo

--e89a8f6436d2b13b1704e52b776e
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr"><pre>Hi all,

There is a new bug-fix release of ceph-deploy, the easy ceph deployment tool.

Installation instructions: <a href="https://github.com/ceph/ceph-deploy#installation">https://github.com/ceph/ceph-deploy#installation</a>

This is the list of all fixes that went into this release which can
also be found in the CHANGELOG.rst file in ceph-deploy&#39;s git repo:
<br>* Fix non-working ``disk list``<br>* ``check_call`` utility fixes ``$PATH`` issues.<br>* Use proper exit codes from the ``main()`` CLI function<br>* Do not error when attempting to add the EPEL repos.<br>* Do not complain when using IP:HOST pairs<br>
* Report nicely when ``HOST:DISK`` is not used when zapping.


Make sure you update!

Thanks,


Alfredo
</pre></div>

--e89a8f6436d2b13b1704e52b776e--

--===============1383388030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1383388030==--
