From: Loic Dachary <loic@dachary.org>
Subject: Re: vstart and Python bindings
Date: Fri, 26 Feb 2016 11:41:54 +0700
Message-ID: <56CFD792.5080001@dachary.org>
References: <20160224233718.6a8c7569@lembas.zaitcev.lan>
 <56CEA76D.9040200@dachary.org> <20160225172704.134e9480@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44457 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbcBZEmD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 23:42:03 -0500
In-Reply-To: <20160225172704.134e9480@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Pete,

I know too little about cython to answer usefully I'm afraid. I'll let =
other, more knowledgeable developers answer to this problem.

Cheers

On 26/02/2016 07:27, Pete Zaitcev wrote:
> Dear Loic:
>=20
> The PR 7792 is not the problem. The issue appears to be that cythoniz=
ation
> is not performed (anymore). There's a coupld of Makefile.am files in
> src/pybind, but no relevant Makefile files are generated. I tried to =
make
> it more explicit with this:
>=20
> ./configure --with-rados --with-cython --with-radosgw
>=20
> Still no effect.
>=20
> Greetings,
> -- Pete
>=20
> On Thu, 25 Feb 2016 14:04:13 +0700
> Loic Dachary <loic@dachary.org> wrote:
>=20
>> Hi Pete,
>>
>> You need https://github.com/ceph/ceph/pull/7792 which is going to be=
 merged real soon now ;-)
>>
>> Cheers
>>
>> On 25/02/2016 13:37, Pete Zaitcev wrote:
>>> I did a git pull today and rebuilt. Ran vstart, and it produced a
>>> Python traceback, ending with:
>>>
>>> ImportError: No module named rados
>>>
>>> Oooookay... This box never had Python bindings installed, but okay,
>>> someone innovated something. Fine, I thought. Installed python-rado=
s,
>>> and ./ceph -w tracebacks:
>>>
>>> Traceback (most recent call last):
>>>   File "./ceph", line 953, in <module>
>>>     retval =3D main()
>>>   File "./ceph", line 778, in main
>>>     run_in_thread(cluster_handle.monitor_log, level, watch_cb, 0)
>>> AttributeError: 'Rados' object has no attribute 'monitor_log'
>>>
>>> Of course. The system version of pybind is obsolete, but ./ceph get=
s
>>> wrong one. Actually, it's not even getting built from .pyx anymore.
>>>
>>> Could whoever did all this please undo?
>>>
>>> -- Pete
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
