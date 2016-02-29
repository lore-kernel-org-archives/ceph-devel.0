From: John Spray <jspray@redhat.com>
Subject: Re: Get rados to build, and run, with the current Cython version.
Date: Mon, 29 Feb 2016 14:10:03 +0000
Message-ID: <CALe9h7ffzrD9KshCp_FbspEPooNZV9npYGwjE9Ycfu_Gb58BYA@mail.gmail.com>
References: <56D19815.8010902@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33385 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbcB2OKZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 09:10:25 -0500
Received: by mail-lb0-f176.google.com with SMTP id ed16so2430295lbb.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 06:10:24 -0800 (PST)
In-Reply-To: <56D19815.8010902@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Feb 27, 2016 at 12:35 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>
> I'm running into a rather blocking issue with testing on FreeBSD due
> to the cythonifying of rados. (would have prefered an option to not use
> cython... )
>
> One of the first tests after all unittests is:
>         ceph-disk/run-tox.sh
>
> It runs at the end:  bash -x tests/ceph-disk.sh
>
> Which tries to execute:
> DEBUG:ceph_disk.main:Cluster uuid is cddc1351-dcf1-11e5-8cd4-1c6f6582ec12
> INFO:ceph_disk.main:Running command: ../ceph-osd --cluster=ceph
> --show-config-value=fsid
> DEBUG:ceph_disk.main:Cluster name is ceph
> DEBUG:ceph_disk.main:OSD uuid is ceac49dd-dcf1-11e5-8cd4-1c6f6582ec12
> DEBUG:ceph_disk.main:Allocating OSD id...
> INFO:ceph_disk.main:Running command: ../ceph --cluster ceph --name
> client.bootstrap-osd --keyring test-ceph-disk/bootstrap-osd/ceph.
> keyring osd create --concise ceac49dd-dcf1-11e5-8cd4-1c6f6582ec12
> Traceback (most recent call last):
>   File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/.tox/py27/bin/ceph-disk",
> line 9, in <module>
>     load_entry_point('ceph-disk', 'console_scripts', 'ceph-disk')()
>   File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
> 4601, in run
>     main(sys.argv[1:])
>   File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
> 4553, in main
>     args.func(args)
>   File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
> 3061, in main_activate
>     init=args.mark_init,
>   File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
> 2882, in activate_dir
>     (osd_id, cluster) = activate(path, activate_key_template, init)
>   File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
> 2974, in activate
>     keyring=keyring,
>   File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
> 925, in allocate_osd_id
>     raise Error('ceph osd create failed', e, e.output)
> Error: Error: ceph osd create failed: Command '../ceph' returned
> non-zero exit status 1: *** DEVELOPER MODE: setting PATH, PYTHONPAT
> H and LD_LIBRARY_PATH ***
> Traceback (most recent call last):
>   File "../ceph", line 108, in <module>
>     import rados
>   File "rados.pyx", line 363, in init rados
> (/usr/srcs/Ceph/work/ceph/src/build/rados.c:48031)
> NameError: name 'errno' is not defined
>
> Now I've changed some code at File "rados.pyx", line 363 because FreeBSD
> does not have ENODATA, and in includes/compat.h it is defined to be
> ENOATTR with a define. Otherwise it would not even compile.
>
> But the cython translation/compilation does not pick up on this?
> ENOATTR is just another define in /usr/include/errno.h so it should find
> it. But it does not.
>
> What is the way forward here?

The ENODATA->ENOATTR mapping from compat.h is going to be completely
invisible to the python/cython code.  Looking at the pre-cython python
code, it appears that that was unconditionally using errno.ENODATA,
which presumably exists in the standard python library even when
compiled on freebsd.  I guess the Cython errno.pyd is silently
dropping ENODATA when it's not found in the header.

You could try using "hasattr(errno, 'ENODATA')" as a conditional check
for whether the NoData python exception should be raised from ENODATA
or ENOATTR.  I don't know if there is a nicer compile time check you
can do for freebsd from the cython code.

All that said, the NameError you're seeing there doesn't seem to be
anything to do with specific error codes, it's as if it's not finding
the errno module at all.  You mention you've modified that file, so it
would probably be useful to link to your branch.

John
