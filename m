From: Tommi Virtanen <tv@inktank.com>
Subject: Re: s3 UnboundLocalError
Date: Tue, 16 Oct 2012 09:45:55 -0700
Message-ID: <CADvuQRGkDMr_unZfXt2NLtZj26G3OeGgaFid8EqQgqJ179xvRQ@mail.gmail.com>
References: <CABpo6hKK3Xyc0BhcUYRdP+OGtG6sc31YnGPc0cx+XTRM_WBY=w@mail.gmail.com>
 <CABpo6h+hq0EnzG_vx5f7igNZr37uk_NvJvZr7_4hCe+_G5qt9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34982 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab2JPQqQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 12:46:16 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1193810qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 09:46:15 -0700 (PDT)
In-Reply-To: <CABpo6h+hq0EnzG_vx5f7igNZr37uk_NvJvZr7_4hCe+_G5qt9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lokesh Krishnappa <lokesh.professional.it@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 15, 2012 at 10:04 PM, Lokesh Krishnappa
<lokesh.professional.it@gmail.com> wrote:
> am following, the below given link :
> https://github.com/ceph/s3-tests for my testing purpose ... and while
> am executing the command as:
>
> S3TEST_CONF=example.conf ./virtualenv/bin/nosetests
>
> getting results with 2error , which is as follows:
>
>  lokesh@lokesh:~/Downloads/ceph-teuthology-78b7b02$
> S3TEST_CONF=example.conf ./virtualenv/bin/nosetests
> ................EES................................
> ======================================================================
> ERROR: teuthology.orchestra.test.test_connection.test_connect

It seems like you are confusing s3-tests with teuthology? S3TEST_CONF
is definitely about s3-tests, but the unit tests you are running, and
the directory you are in, are about teuthology.

>   File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/orchestra/test/test_connection.py",
> line 47, in test_connect
>     _SSHClient=sshclient,
>   File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/orchestra/connection.py",
> line 30, in connect
>     ssh.load_system_host_keys()
> UnboundLocalError: local variable 'ssh' referenced before assignment

The error you are seeing seems only possible if someone were to change
the unit test in question, or if the behavior of the fudge library has
changed. I just confirmed that a virtualenv created from scratch, with
fudge 1.0.3, behaves as expected.

Did you edit the source?

> i thought it would be ssh login problem and tried to secure login, its
> working fine .

These are unit tests, they have nothing to do with the actual SSH
service on your host.
