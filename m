From: Jeff Layton <jlayton@redhat.com>
Subject: Re: ceph rpm packaging failure -- installed but unpackaged files
 found
Date: Tue, 08 Nov 2016 14:17:59 -0500
Message-ID: <1478632679.6066.9.camel@redhat.com>
References: <1478631747.6066.7.camel@redhat.com>
         <CALqRxCy4OFSWfxhwqkO=yHGtTEeFdDhpHWHrrCbis5kYX52J_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35690 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbcKHTSC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 14:18:02 -0500
Received: by mail-qk0-f174.google.com with SMTP id n204so219039595qke.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 11:18:02 -0800 (PST)
In-Reply-To: <CALqRxCy4OFSWfxhwqkO=yHGtTEeFdDhpHWHrrCbis5kYX52J_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Ahh ok, I didn't realize that this was new stuff. Are the gitbuilders
also failing?

Until then, is there some way to turn off support for these so
packaging can proceed? Why aren't the gitbuilders failing?

...oh, nevermind...they are:

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-rpm-centos7-amd64-basic/log.cgi?log=a38d53e1d29eefc35dd5cfb14dc0996253cdc468


On Tue, 2016-11-08 at 12:06 -0700, Ken Dreyer wrote:
> Hi Jeff,
> 
> It sounds like we need a new "python-rgw" package for RPMs/DEBs so
> these files are properly packaged.
> 
> - Ken
> 
> On Tue, Nov 8, 2016 at 12:02 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > I needed to build some rpms from a make-srpm.sh generated srpm, and hit
> > this failure during the packaging phase. Something with the rgw python
> > bindings it appears?
> > 
> > The tree here is based on a38d53e1d29eefc35dd5cfb14dc0996253cdc468,
> > with a few cephfs patches on top.
> > 
> > Here's the tail end of the rpm build log:
> > 
> > Provides: ceph-debuginfo = 1:11.0.2-1287.gbd4abb0f7496.fc24 ceph-debuginfo(x86-64) = 1:11.0.2-1287.gbd4abb0f7496.fc24
> > Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
> > Checking for unpackaged file(s): /usr/lib/rpm/check-files /home/jlayton/rpmbuild/BUILDROOT/ceph-11.0.2-1287.gbd4abb0f7496.fc24.x86_64
> > error: Installed (but unpackaged) file(s) found:
> >    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/PKG-INFO
> >    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/SOURCES.txt
> >    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/dependency_links.txt
> >    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/top_level.txt
> >    /usr/lib64/python2.7/site-packages/rgw.so
> >    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/PKG-INFO
> >    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/SOURCES.txt
> >    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/dependency_links.txt
> >    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/top_level.txt
> >    /usr/lib64/python3.5/site-packages/rgw.cpython-35m-x86_64-linux-gnu.so
> > 
> > 
> > RPM build errors:
> >     Installed (but unpackaged) file(s) found:
> >    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/PKG-INFO
> >    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/SOURCES.txt
> >    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/dependency_links.txt
> >    /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/top_level.txt
> >    /usr/lib64/python2.7/site-packages/rgw.so
> >    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/PKG-INFO
> >    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/SOURCES.txt
> >    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/dependency_links.txt
> >    /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/top_level.txt
> >    /usr/lib64/python3.5/site-packages/rgw.cpython-35m-x86_64-linux-gnu.so
> > --
> > Jeff Layton <jlayton@redhat.com>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jeff Layton <jlayton@redhat.com>
