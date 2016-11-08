From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: ceph rpm packaging failure -- installed but unpackaged files found
Date: Tue, 8 Nov 2016 12:06:54 -0700
Message-ID: <CALqRxCy4OFSWfxhwqkO=yHGtTEeFdDhpHWHrrCbis5kYX52J_A@mail.gmail.com>
References: <1478631747.6066.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36051 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbcKHTGz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 14:06:55 -0500
Received: by mail-ua0-f180.google.com with SMTP id b35so155144087uaa.3
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 11:06:55 -0800 (PST)
In-Reply-To: <1478631747.6066.7.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Jeff,

It sounds like we need a new "python-rgw" package for RPMs/DEBs so
these files are properly packaged.

- Ken

On Tue, Nov 8, 2016 at 12:02 PM, Jeff Layton <jlayton@redhat.com> wrote:
> I needed to build some rpms from a make-srpm.sh generated srpm, and hit
> this failure during the packaging phase. Something with the rgw python
> bindings it appears?
>
> The tree here is based on a38d53e1d29eefc35dd5cfb14dc0996253cdc468,
> with a few cephfs patches on top.
>
> Here's the tail end of the rpm build log:
>
> Provides: ceph-debuginfo = 1:11.0.2-1287.gbd4abb0f7496.fc24 ceph-debuginfo(x86-64) = 1:11.0.2-1287.gbd4abb0f7496.fc24
> Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
> Checking for unpackaged file(s): /usr/lib/rpm/check-files /home/jlayton/rpmbuild/BUILDROOT/ceph-11.0.2-1287.gbd4abb0f7496.fc24.x86_64
> error: Installed (but unpackaged) file(s) found:
>    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/PKG-INFO
>    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/SOURCES.txt
>    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/dependency_links.txt
>    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/top_level.txt
>    /usr/lib64/python2.7/site-packages/rgw.so
>    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/PKG-INFO
>    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/SOURCES.txt
>    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/dependency_links.txt
>    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/top_level.txt
>    /usr/lib64/python3.5/site-packages/rgw.cpython-35m-x86_64-linux-gnu.so
>
>
> RPM build errors:
>     Installed (but unpackaged) file(s) found:
>    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/PKG-INFO
>    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/SOURCES.txt
>    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/dependency_links.txt
>    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/top_level.txt
>    /usr/lib64/python2.7/site-packages/rgw.so
>    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/PKG-INFO
>    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/SOURCES.txt
>    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/dependency_links.txt
>    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/top_level.txt
>    /usr/lib64/python3.5/site-packages/rgw.cpython-35m-x86_64-linux-gnu.so
> --
> Jeff Layton <jlayton@redhat.com>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
