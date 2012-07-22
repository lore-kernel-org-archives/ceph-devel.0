From: Tim Flavin <tim.flavin@gmail.com>
Subject: Re: mkcephfs problem
Date: Sun, 22 Jul 2012 11:35:57 -0400
Message-ID: <CAEj+kbmhDRF5X=Yn=MDOPbphqDgu=rFwSQ9DBzfSwXC_d346OA@mail.gmail.com>
References: <CAEj+kbmn=UY1dUKkyDDymqhbTuvEypVM+o4Ny-phS1SKZkmshA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50205 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab2GVPf7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Jul 2012 11:35:59 -0400
Received: by vcbfk26 with SMTP id fk26so4112766vcb.19
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jul 2012 08:35:58 -0700 (PDT)
In-Reply-To: <CAEj+kbmn=UY1dUKkyDDymqhbTuvEypVM+o4Ny-phS1SKZkmshA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In addition to localhost, I found a number of other network related
problems with my setup.
When I fixed them mkcephfs was much happier.

Tim

On Thu, Jul 19, 2012 at 9:46 PM, Tim Flavin <tim.flavin@gmail.com> wrote:
> I am trying to get Ceph running on an ARM system, currently one quad
> core node, running Ubuntu 12.04.
>
> It compiles fine, currently without tcmalloc and google perf tools, but
> I am running into a problem with mkcephfs.  'mkcephfs -a -c ceph.conf'
> didn't work so I did it piece by piece until I got this:
>
> root@ubuntu:/home/tim# mkcephfs -d /tmp/foo --prepare-mon
> Building generic osdmap from /tmp/foo/conf
> /usr/local/bin/osdmaptool: osdmap file '/tmp/foo/osdmap'
> /usr/local/bin/osdmaptool: writing epoch 1 to /tmp/foo/osdmap
> Generating admin key at /tmp/foo/keyring.admin
> creating /tmp/foo/keyring.admin
> Building initial monitor keyring
> cat: /tmp/foo/key.*: No such file or directory
>
> There are no key.* files in /tmp/foo
>
> # ls /tmp/foo
> conf  keyring.admin  keyring.mon  monmap  osdmap
>
>
> If you are running everything on one node, is it OK to use localhost and
> 127.0.0.1?
>
>
> Here is my config file:
>
> [osd]
>         osd journal size = 1000
>         filestore xattr use omap = true
>
> [mon.a]
>         host = localhost
>         mon addr = 127.0.0.1:6789
>
> [osd.0]
>         host = localhost
>
>
> [mds.a]
>         host = localhost
>
>
> Here are are the other configuration commands:
>
> root@ubuntu:/home/tim# mkcephfs -c ceph.conf -d /tmp/foo --prepare-monmap
> preparing monmap in /tmp/foo/monmap
> /usr/local/bin/monmaptool --create --clobber --add a 127.0.0.1:6789
> --print /tmp/foo/monmap
> /usr/local/bin/monmaptool: monmap file /tmp/foo/monmap
> /usr/local/bin/monmaptool: generated fsid 8e4f846b-1829-46e4-9902-5d8316c3fa4f
> epoch 0
> fsid 8e4f846b-1829-46e4-9902-5d8316c3fa4f
> last_changed 2012-07-19 22:40:38.651045
> created 2012-07-19 22:40:38.651045
> 0: 127.0.0.1:6789/0 mon.a
> /usr/local/bin/monmaptool: writing epoch 0 to /tmp/foo/monmap (1 monitors)
> root@ubuntu:/home/tim# mkcephfs -d /tmp/foo --init-local-daemons mds
> root@ubuntu:/home/tim# mkcephfs -d /tmp/foo --init-local-daemons osd
> root@ubuntu:/home/tim# mkcephfs -d /tmp/foo --prepare-mon
> Building generic osdmap from /tmp/foo/conf
> /usr/local/bin/osdmaptool: osdmap file '/tmp/foo/osdmap'
> /usr/local/bin/osdmaptool: writing epoch 1 to /tmp/foo/osdmap
> Generating admin key at /tmp/foo/keyring.admin
> creating /tmp/foo/keyring.admin
> Building initial monitor keyring
> cat: /tmp/foo/key.*: No such file or directory
> root@ubuntu:/home/tim#
>
>
> Any ideas?  Which command was supposed to generate the key.* files?
>
> Tim
