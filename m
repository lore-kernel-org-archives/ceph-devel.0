From: Sage Weil <sage@inktank.com>
Subject: Re: Hadoop and Ceph client/mds view of modification time
Date: Tue, 27 Nov 2012 09:03:42 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211270857370.30109@cobra.newdream.net>
References: <CAPrxi5-pcHrxKsteGioaQ3haMOj0V3im1bXRL_TW28SD6R=qZw@mail.gmail.com> <50B4EE31.5020908@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33698 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab2K0RDn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 12:03:43 -0500
In-Reply-To: <50B4EE31.5020908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>

On Tue, 27 Nov 2012, Sam Lang wrote:
> Hi Noah,
> 
> I was able to reproduce your issue with a similar test using the fuse client
> and the clock_offset option for the mds.  This is what I see happening:
> 
> clientA's clock is a few seconds behind the mds clock
> 
> clientA creates the file
>     - the mds sets the mtime from its current time
>     - clientA acquires the exclusive capability (cap) for the file
> 
> clientA writes to the file
>     - the mtime is updated locally (at clientA with its current time)
> 
> clientA closes the file
>     - the exclusive cap is flushed to the mds, but the mtime is less
>       than the create mtime because of the clock skew, so the mds
>       doesn't update it to the mtime from clientA's write
> 
> clientA stats the file
>     - the mtime from the write (still cached) gets returned.  I saw a
>       race in my tests, where sometimes the mtime was from the cache
>       (if the flush hadn't completed I assume), and sometimes it was
>       from the mds.
> 
> clientB stats the file
>     - the exclusive cap is revoked at clientA, but the mtime returned
>       to clientB is from the mds
> 
> The goal of the current implementation is to provide an mtime that is
> non-decreasing, but that conflicts with using mtime as a version in this case.
> Using mtime as a version has its own set of problems, but I won't go into that
> here.  I think there are a few alternatives if we want to try to have a more
> consistent mtime value across clients.
> 
> 1. Let the client set the create mtime.  This avoids the issue that the mds
> and client clocks are out of sync, but in other cases where the client has a
> clock a few seconds ahead of other clients, we run into a similar problem.
> This might be reasonable considering clients that share state will more likely
> have synchronized clocks than the clients and mds.

I like this option the best.  It will clearly break when client clocks are 
out of sync and multiple clients write to the file, but I think that is 
the price you pay for client-driven writeback.  

Noah, is that sufficient to resolve the hadoop race?  Is there a single 
client writer?

> 2. Provide a config option to always set the mtime on cap flush/revoke, even
> if its less than the current mtime.  This breaks the non-decreasing behavior,
> and requires the user set a config option across the cluster if they want
> this.

We could also do this... but if the above is sufficient for hadoop I'd 
rather not.  :/
 
> 3. When a client acquires the cap for a file, have the mds provide its current
> time as well.  As the client updates the mtime, it uses the timestamp provided
> by the mds and the time since the cap was acquired.
> Except for the skew caused by the message latency, this approach allows the
> mtime to be based off the mds time, so it will be consistent across clients
> and the mds.  It does however, allow a client to set an mtime to the future
> (based off of its local time), which might be undesirable, but that is more
> like how  NFS behaves.  Message latency probably won't be much of an issue
> either, as the granularity of mtime is a second. Also, the client can set its
> cap acquired timestamp to the time at which the cap was requested, ensuring
> that the relative increment includes the round trip latency so that the mtime
> will always be set further ahead. Of course, this approach would be a lot more
> intrusive to implement. :-)

Yeah, I'm less excited about this one.

I think that giving consistent behavior from a single client despite clock 
skew is a good goal.  That will make things like pjd's test behave 
consistently, for example.

sage

> 
> -sam
> 
> 
> On 11/20/2012 01:44 PM, Noah Watkins wrote:
> > This is a description of the clock synchronization issue we are facing
> > in Hadoop:
> > 
> > Components of Hadoop use mtime as a versioning mechanism. Here is an
> > example where Client B tests the expected 'version' of a file created
> > by Client A:
> > 
> >    Client A: create file, write data into file.
> >    Client A: expected_mtime <-- lstat(file)
> >    Client A: broadcast expected_mtime to client B
> >    ...
> >    Client B: mtime <-- lstat(file)
> >    Client B: test expected_mtime == mtime
> > 
> > Since mtime may be set in Ceph by both client and MDS, inconsistent
> > mtime view is possible when clocks are not adequately synchronized.
> > 
> > Here is a test that reproduces the problem. In the following output,
> > issdm-18 has the MDS, and issdm-22 is a non-Ceph node with its time
> > set to an hour earlier than the MDS node.
> > 
> > nwatkins@issdm-22:~$ ssh issdm-18 date && ./test
> > Tue Nov 20 11:40:28 PST 2012           // MDS TIME
> > local time: Tue Nov 20 10:42:47 2012  // Client TIME
> > fstat time: Tue Nov 20 11:40:28 2012  // mtime seen after file
> > creation (MDS time)
> > lstat time: Tue Nov 20 10:42:47 2012  // mtime seen after file write
> > (client time)
> > 
> > Here is the code used to produce that output.
> > 
> > #include <errno.h>
> > #include <sys/fcntl.h>
> > #include <sys/time.h>
> > #include <unistd.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <dirent.h>
> > #include <sys/xattr.h>
> > #include <stdio.h>
> > #include <string.h>
> > #include <assert.h>
> > #include <cephfs/libcephfs.h>
> > #include <time.h>
> > 
> > int main(int argc, char **argv)
> > {
> >          struct stat st;
> >          struct ceph_mount_info *cmount;
> >          struct timeval tv;
> > 
> >          /* setup */
> >          ceph_create(&cmount, "admin");
> >          ceph_conf_read_file(cmount, "/users/nwatkins/Projects/ceph.conf");
> >          ceph_mount(cmount, "/");
> > 
> >          /* print local time for reference */
> >          gettimeofday(&tv, NULL);
> >          printf("local time: %s", ctime(&tv.tv_sec));
> > 
> >          /* create a file */
> >          char buf[256];
> >          sprintf(buf, "/somefile.%d", getpid());
> >          int fd = ceph_open(cmount, buf, O_WRONLY|O_CREAT, 0);
> >          assert(fd > 0);
> > 
> >          /* get mtime for this new file */
> >          memset(&st, 0, sizeof(st));
> >          int ret = ceph_fstat(cmount, fd, &st);
> >          assert(ret == 0);
> >          printf("fstat time: %s", ctime(&st.st_mtime));
> > 
> >          /* write some data into the file */
> >          ret = ceph_write(cmount, fd, buf, sizeof(buf), -1);
> >          assert(ret == sizeof(buf));
> >          ceph_close(cmount, fd);
> > 
> >          memset(&st, 0, sizeof(st));
> >          ret = ceph_lstat(cmount, buf, &st);
> >          assert(ret == 0);
> >          printf("lstat time: %s", ctime(&st.st_mtime));
> > 
> >          ceph_shutdown(cmount);
> >          return 0;
> > }
> > 
> > Note that this output is currently using the short patch from
> > http://marc.info/?l=ceph-devel&m=133178637520337&w=2 which forces
> > getattr to always go to the MDS.
> > 
> > diff --git a/src/client/Client.cc b/src/client/Client.cc
> > index 4a9ae3c..2bb24b7 100644
> > --- a/src/client/Client.cc
> > +++ b/src/client/Client.cc
> > @@ -3858,7 +3858,7 @@ int Client::readlink(const char *relpath, char
> > *buf, loff_t \
> > size)
> >   int Client::_getattr(Inode *in, int mask, int uid, int gid)
> >   {
> > -  bool yes = in->caps_issued_mask(mask);
> > +  bool yes = false; //in->caps_issued_mask(mask);
> > 
> >     ldout(cct, 10) << "_getattr mask " << ccap_string(mask) << "
> > issued=" << yes << \
> > dendl;  if (yes)
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
